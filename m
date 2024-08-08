Return-Path: <linux-kernel+bounces-279936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0DC94C396
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50451B25944
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709E1917C8;
	Thu,  8 Aug 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HYixNplC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rpaI34+h"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA619005E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137781; cv=fail; b=CC/QjMDA9LomYFLVHXqMeevBsL0e6FaCqtvOsvnFfo5dTE47D9D5zXZ+C6kG8ASAWeP0up8hvELx6jlKuQdlTXq10UF7Fa7P2Fg22aagNJH9QmABxHr1KSb5XPXw7XnHy9r/6DchciBomhA6FJnKdIevEgWdjbU6cJRIDanIHhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137781; c=relaxed/simple;
	bh=os9nlwgmDmJiYB5P3NWvx0tKtx4SIX5a0Dyf8L8gm5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EqA+JzmTHgG5b7h+bWHVSFajCCNGF4CLCoOBwce9xGExHVxFh6UPCkhAxfiWQwi8nP7bL2t8adLC1JnPiZxopURdUJVO1U0u4sh3WFazlu3MrX47gZlJAGUE1iCUVDRJeMKnwCWIs6wU+paoi7AR3q7Gw8QSEiAfmIvo6SoVIR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HYixNplC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rpaI34+h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMWS4029853;
	Thu, 8 Aug 2024 17:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=fePcHupdGsS43Bx
	Zmbob1ujn5I794NiP5FJbciv04cI=; b=HYixNplCbpAfy/Rls06wbmlWStTozlb
	pEMGDw86u2mRKwHRTweCtCw11cO/qcEVvfZCmfTyDH3/ITUBzGR7be9hYi91+a/L
	ty66EXKRf2dp4MLCCNS4k4XJakj+9rquKnQbZguAH8sXGsB0nJWqe4O59UbpW3ZD
	WfCehiX58ODCXslSO3SP0vVMSrnLlDrodY7CDLhSFlJOMqF4+ohEEQ90+8YZTmDM
	xiYXrOHIwAGOYSbMCCQ0H6N+x+4oHRO8R64J9GaBUQ7kabs85pGT5zWUyYwHzNOe
	diJDmXrf5lGyjohFIDwogjGRV19igSSjxlyUbOsclbFuTDtWKJsX6pg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcjc4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 17:22:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478GDqvf023808;
	Thu, 8 Aug 2024 17:22:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0hpf22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 17:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuNPwsTubErvQ9roj8EO4Ae1zavqRAzxY0P80sfb9yyiOnSDgcxBPY9A5kxwQC7dbfV2Vcv6uY9TnmnKeIwQpMbGNG26o0U3thb0EH/JmeAl+16vhar6sbgFrWh+04RqOddwxpck5MHzP5TLQx1spWOziHhD7jDDLRHwswibdJ4Qo/3ed64TaHYpHkD4zbzHzmwZeXMoDHj71GkR0RXM1YrXEgvw09rM6+6TnM7fUqxDNaWT8+6a+cu7VwR/c4vTv3iwlVwrJs5pBOQxOsLRSuNf/s+MtAKkbi4V+QtoFeHMf1Kca/OXseIXc8pMHhFs/IlMO1/CZVA8MNQ2l6h/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fePcHupdGsS43BxZmbob1ujn5I794NiP5FJbciv04cI=;
 b=xnhiFQ23mYJfQD+WpxIdtIYWT4VD4KPRZtUlztnCGMKCDdjtCh0ViFWDpuZVBWxkR1JozHZL75P6bwUHSMXOmimaLIryOrsoCHaW2vCYtwixI0zQeHxZpKzvTFRcHeAUnS2Mlm3A+e2PQuRVMsEzK6HTaT6f/ByY1tu8exdtV+HMAQI5SjA5MN/NWPDs1jvIwLxKdpK/YEDG8ab67zc0uPT5o6JmHIhuz2QDujO5ylq675kL5n9KDOHilRvP/UCr9BzlXfXZp7rfRnFuE3yMS4RotQrzI51OCKkWiARKDkuMHuOPjtS7N8NCwoY+4+ilbVUuUnKbJr2H0PJBNkbo/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fePcHupdGsS43BxZmbob1ujn5I794NiP5FJbciv04cI=;
 b=rpaI34+hJJ9/nJAPALHqd3NclQIx7vAlWLUxkPMs+k5b4hm7BHkq1ipmQunI7lyZoVIA6+RU9JQT8wV+VezjYxGTUPr1r+vUepVXaPc13xPNz2HnrCaALRtMuzfvF5J7MnLvEshwwMeZDqyryBd+LghH5erGBMo1x+ESGoREfP0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Thu, 8 Aug
 2024 17:22:42 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 17:22:41 +0000
Date: Thu, 8 Aug 2024 13:22:38 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH 1/2] maple_tree: add test to replicate low memory race
 conditions
Message-ID: <u4opiimp7gxvap4twg35z7btttu6o46ymm6lncgs7of24fzchi@7j4uqkspcexz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240808163000.25053-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808163000.25053-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: c36cad73-b4d1-4d67-457b-08dcb7ceb53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WgTPB1VWg6RNNH++xmLzA7zFq0VT50MVuq/ypp2nPS1H9WY7O1XjjTKggr85?=
 =?us-ascii?Q?RqUfAsImS5zPtyQgVjZUQuPfkuTpP7IMsClSXPKaEoo07QqXEFXbRe7c1uZF?=
 =?us-ascii?Q?iLU/7o77M0StCRm859t7fOzBPERX4uF7Rgaqdf6OIbOrwSlypMwFL2IdiNvt?=
 =?us-ascii?Q?QOOMpXA68k9GCA2Y025yn7M0omJhjuNJfaS/Xzia/LHXcek9FUXEvVr0gxUG?=
 =?us-ascii?Q?xwqnrq3FEi73g5YzkUPhYPvbagiKtnV5ig3500LCMgl4eSubY7/teRM5Wqxc?=
 =?us-ascii?Q?QGsxh4pJ44z2xtVSxrZyIW87oMHGmM0dMs//E2hUnFkIsz+vP5uMDtIrbarX?=
 =?us-ascii?Q?e0Uk1asKgbSkaxOkqZSq+2/3abzIJpzBidBiBoul45Dpg6nTtb4JS0ALAP+D?=
 =?us-ascii?Q?Fau1loBYEiSqw2wZhHYx9+EOQtzEVjpEeGZMZ2S1Ka7PTVV3MgMVHNSIu5FL?=
 =?us-ascii?Q?KeaC8ec1rKH1491I6HFvycIwVYKBVWnJUphjHRBnqv0YS1x/KZO4foNSzlwd?=
 =?us-ascii?Q?6rVFPd6YXfjTxV77/hK3D7JNH+UOzwkoBdG+yLL3ALPOFkBOnohZF2YAdFwN?=
 =?us-ascii?Q?/4nOURqLp1MwxbiApI5oS+k8Hs0p7niCzCR5e3iMPleOx985y1hXx9yDFChj?=
 =?us-ascii?Q?xzrSaGuUWvk4/cl3RspuewdDKWwGRewwcYk74J3/luPjB4Y0xadnT8472321?=
 =?us-ascii?Q?B7Y8X1B4CQZ4kxb2IA48LpCykKVnUhLNEc6T5doGAkhWOoYcb/vruZrWKkI3?=
 =?us-ascii?Q?zK79f0plxRqBgcPj4Vu6uJJKUhlnQDUy4KZ5VdynuobSHBuHb27I47gUoX3b?=
 =?us-ascii?Q?TBHXL19CdEoxNnPdvTR5MEZSREi+B1X4SjeflovtbpMBqBWJ6mkkDTFSIIUj?=
 =?us-ascii?Q?3+wLpIg/WBLBz2PFb1V+mUk2c86gMY3MGLx8cvwO1ZofGEWmC5hDeRwpAg7O?=
 =?us-ascii?Q?JIRyDLQbq5ZOSci7Nfl2dCG1LmEGzBUVwAvxVR+gZFjCrJfvdqBHHkNk2Ef0?=
 =?us-ascii?Q?/zvY8Jh2CmJNVOgC8wFwWuuZwLvwQckbbamXnmNiw5bmixvspMXF3lXAShIZ?=
 =?us-ascii?Q?fnSohQs2N6vzrVXACsSSKU4Vj6gMz7hPxj54dP6OLfx7hTXvXmO3QN8yZ3rJ?=
 =?us-ascii?Q?sx+VLJZ0kOqns9tpvWqtiQ2vh4ydT/3fgXjdmILLLLPbo8EYGv4wLGD6X4Mp?=
 =?us-ascii?Q?Md4F1gskOv/zUA+h+g6lYViuSvK2Wce4Oej14pWtbTMU7Wmj+ITEC1ECkMJu?=
 =?us-ascii?Q?SXyCkf779Q9tRjrFf9wDpyvwegCh7euUN1xR7bT6x6E8rpls5w4sM3BlX7jW?=
 =?us-ascii?Q?KRDlHMyZZUtgYHJwL3f8R1UXWivqBo/U0JV94id5ys5fwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPWPnndAXOAFE2q8GEYMZVwt93V3467RVen6UfZOIHP4/6CLJqvECrRnFS3T?=
 =?us-ascii?Q?4X1YwCq4kIVy/xILM2JySwe+0xyZVgpCNkKE/3/CdvH/8AKC2XQKFK+JIOrd?=
 =?us-ascii?Q?aWpqGKd8uLKjeKGBY2fLFJCwBrXRu3vMxlrevCfu7CGmAQsnk7q6vUkJtFJl?=
 =?us-ascii?Q?V9849oK3EneluR6nvU/V31gWmYs8SUC5T495QI3vCjazxo2A2orUGh7tmtQv?=
 =?us-ascii?Q?N/8Askm3G/MaDthLnPZwMtv2lE4lW5SDcBr5VFMzqaFv5lOSPPRJlYqMjCps?=
 =?us-ascii?Q?4zkWWXVcXmYFgVfznBMsZJI1OwGHqnDM75dPar3oWVXguTbL+6bxj2CRkYl7?=
 =?us-ascii?Q?N2yemdYZYoeZads2XNXitLwURpFcm2vDKh7wPqMTvTre8V5g29nVfmrtQXT9?=
 =?us-ascii?Q?i8EIoOG+ooOjM0h5dX8HsCw3eWAqv+Kft70P45sRfTxzOnVOKIJiULluQ/hJ?=
 =?us-ascii?Q?DkefK7XTG5ak2NvZURgz2ezIHuQQ7kvBK9HaPXNF08TfVQ926ltrXuMyx3PI?=
 =?us-ascii?Q?vT1cFIjeetxXv+QCWVBe2+eD0Kqz1CG835GXH5J9+0yTGxQXG0W8/PcANUR5?=
 =?us-ascii?Q?5YPhSIYEn1Xuc1azjNYlUSCZIonqDYpQkhefuKcIbZW8fg9vMDLPPcPde73Q?=
 =?us-ascii?Q?TnoMfm5OK2O/VygFuyhLu4+uHzvn7/NTAUPHq1ProjVVBxzQYPDhl5bwxGtL?=
 =?us-ascii?Q?/RcDgnRl2shvmFn7vhdKKwwyNK3j1dlnkcLSAO2U2BEDIPLBoNmSpd/LKP0s?=
 =?us-ascii?Q?5ka5OR/hEiGYSxibVkxi6g7uRPZeurY1wdSdEjKeO3z7J9fkTU+SNY6P8Wq4?=
 =?us-ascii?Q?HJ4uwVKJrqDZEuaLdIymfNBFheIPqtvpUj2ryCRXUabk2gLFk5Psiqh1JGsq?=
 =?us-ascii?Q?n0aNDMOgAh1Hod97OsEAamm84GCwhhEoHfWZ/8zbc3xPwWPB+Ln9esPAa7eH?=
 =?us-ascii?Q?vsz4VQRCQZx/1ZYsimkxYlBuxpbFB5QTRAhoOf7MIQ0zElXSg2nAWolvlj9g?=
 =?us-ascii?Q?zWFmZk/yMZC5ybY7kHb6EYUlNQRc2aRnjh1g7uC+iOwGdZU/MwI8VaV2ltmg?=
 =?us-ascii?Q?dJF7u+BkVu/G3ATJLAutE0QlRELcEtuMR+zBIG7Fn9lcEhQAcgebHR8UuJcV?=
 =?us-ascii?Q?EdL4OFyxuGz/PwCwEaoSi/U6Kd2oJuctz3ZZ2VccBQ/kHAg/8nutqAPdVpAW?=
 =?us-ascii?Q?z8PtpryetI5CK0/RwJ5y1Bx3bJjoQc9ylNKWnrTI/B6X+2WGoRHFCw126SPq?=
 =?us-ascii?Q?8DfWR2abSOzgfaj5H8mhUT+FC4QCXhNASb62INENpn4MimslOfKgfGnhAZ3V?=
 =?us-ascii?Q?8e2fUE2Kzi/200xradD1jUdvX2zPppJA5OGvyun3DbXbjrWr8hGVWetbq+hR?=
 =?us-ascii?Q?OtVNWM2uyy3qeUS+719/5QBPosGQ/HD9CGALPu4muGjwq3XJFSBo2ZlKRwtG?=
 =?us-ascii?Q?U5CeyP9VLC+giS9HEiVrsZMQLfB+i2AMSs6h5YTxl7AtAq2NCr1ih1eyJqzG?=
 =?us-ascii?Q?rGAGuVnBngySPI08+mGEmY9J4xDAvBTe+uANM6Dpw/eRbE+l5ezamcnj95pJ?=
 =?us-ascii?Q?8W0su5bDwSIGSsqXrse9QzU89ogvwiU3TWv15Etd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cit9HIhzEN95fqQEnUMkrcWRoHcc87Mqr9BtamdcUHvxokGaUo7XIDKjCq3NMWgvCK7zKNzeOUwT/dCNtrhFuLAoSGIEv/8tjbOdZo39lvevyJETJvk5X9P3vp824uL6G34d0RQP7zS4YoNrwrHU6GM+0ecd1LKRcggA6iGdSfeQPiBuQpT5EVxVzJ9z48TxsQ0jSYUh1MyPQYqcnV8Ul0NBlgmNhidLRma1NDFjuaz8VWCzkeIaZehH1Defw/0G4tpiCGgpIG+csB5uJhvzV73Eu4HF0VpDtQYDFErqCfP4ey/16IORSJQ4wN8QbGaPXOSf5RsbJPRbPeJGKaul1zpE2c6KZ9EWKxgJpIvywFWF7tcCEl5agLcxkm8G9F2xBqzkb0C0UceSSc1vBUHWgtLkLnteNtThmqewVq37OVXIQxdBiiFFGuowIq637onFC3aT4Gh8e2Xz0VQVH0iPnlibNUDzOZzP5iQSOhi7InfqN61HSjHs3OfzMY88/m++NJXWRx8mNRm1XpBGENdgc3kVLOT1j7v/W27td6uRilCnlxzqEu2Q7BSI9AH9vuDTFfC1y1f/cmEcGEANTlGuzMTRCRJXDwYrel7ETjXYJUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36cad73-b4d1-4d67-457b-08dcb7ceb53b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 17:22:41.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzVSi0SGj77YDto8nlwQUJFSYaH6JGb1upcFGV8A6gHnQJGX85fEQHkWWelCfx5ZHaiZEZeDn1RqCUp6TdU3UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_17,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080123
X-Proofpoint-GUID: u8-J7FDe009vAp65mQouaMyC5nWgOnoB
X-Proofpoint-ORIG-GUID: u8-J7FDe009vAp65mQouaMyC5nWgOnoB

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240808 12:30]:
> Add new callback fields to the userspace implementation of struct
> kmem_cache. This allows for executing callback functions in order to
> further test low memory scenarios where node allocation is retried.
> 
> This callback can help test race conditions by calling a function when a
> low memory event is tested". This exposes a race condition that is
                            ^- please remove that quote

> addressed in a subsequent patch.

Please reverse the patch order so that the test cases pass for all
commit ids.  It's good to have the test prove that the problem exists
and then fix it, but if bots verify the test cases, then they will see
it as failing on this commit.

> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c                 | 12 +++++++
>  tools/testing/radix-tree/maple.c | 60 ++++++++++++++++++++++++++++++++
>  tools/testing/shared/linux.c     | 26 +++++++++++++-
>  3 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index aa3a5df15b8e..65fba37ef999 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6997,6 +6997,18 @@ void mt_set_non_kernel(unsigned int val)
>  	kmem_cache_set_non_kernel(maple_node_cache, val);
>  }
>  
> +extern void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *));
> +void mt_set_callback(void (*callback)(void *))
> +{
> +	kmem_cache_set_callback(maple_node_cache, callback);
> +}
> +
> +extern void kmem_cache_set_private(struct kmem_cache *cachep, void *private);
> +void mt_set_private(void *private)
> +{
> +	kmem_cache_set_private(maple_node_cache, private);
> +}
> +
>  extern unsigned long kmem_cache_get_alloc(struct kmem_cache *);
>  unsigned long mt_get_alloc_size(void)
>  {
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index cd1cf05503b4..0e699feb71b8 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36224,6 +36224,61 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
>  
>  extern void test_kmem_cache_bulk(void);
>  
> +static void writer2(void *maple_tree)
> +{
> +	struct maple_tree *mt = (struct maple_tree *)maple_tree;
> +	MA_STATE(mas, mt, 0, 0);
> +
> +	mtree_lock(mas.tree);
> +	__mas_set_range(&mas, 6, 10);
> +	mas_store(&mas, xa_mk_value(0xC));
> +	mas_destroy(&mas);
> +	mtree_unlock(mas.tree);

This can be simplified by setting the MA_STATE to 6, 10 to begin with,
and I don't think the destroy is necessary?

> +}
> +
> +static void check_data_race(struct maple_tree *mt)

Which data race?  check_nomem_writer_race() maybe?  It might be worth a
block comment about what's going on here?

> +{
> +	MA_STATE(mas, mt, 0, 0);
> +
> +	mt_set_non_kernel(0);
> +	/* setup root with 2 values with NULL in between */
> +	mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
> +	mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
> +	mtree_store_range(mt, 11, 15, xa_mk_value(0xB), GFP_KERNEL);
> +
> +	/* setup writer 2 that will trigger the race condition */
> +	mt_set_private(mt);
> +	mt_set_callback(writer2);
> +
> +	mtree_lock(mt);
> +	/* erase 0-5 */
> +	mas_reset(&mas);

reset isn't needed as this is the first use

> +	mas.index = 0;
> +	mas.last = 5;

These values can be passed to the init MA_STATE() too.

> +	mas_erase(&mas);
> +
> +	/* index 6-10 should retain the value from writer 2*/
> +	check_load(mt, 6, xa_mk_value(0xC));
> +	mtree_unlock(mt);
> +
> +	/* test for the same race but with mas_store_gfp */
> +	mtree_store_range(mt, 0, 5, xa_mk_value(0xA), GFP_KERNEL);
> +	mtree_store_range(mt, 6, 10, NULL, GFP_KERNEL);
> +
> +	mtree_lock(mt);
> +	mas_reset(&mas);
> +	mas.index = 0;
> +	mas.last = 5;

mas_set_range() will do these three things, maybe do it outside the
lock?

> +	mas_store_gfp(&mas, NULL, GFP_KERNEL);
> +
> +	check_load(mt, 6, xa_mk_value(0xC));
> +
> +	mt_set_private(NULL);
> +	mt_set_callback(NULL);
> +	mas_destroy(&mas);

is this destroy needed?

> +	mtree_unlock(mt);
> +}
> +
>  void farmer_tests(void)
>  {
>  	struct maple_node *node;
> @@ -36243,6 +36298,11 @@ void farmer_tests(void)
>  	node->mr64.pivot[2] = 0;
>  	tree.ma_root = mt_mk_node(node, maple_leaf_64);
>  	mt_dump(&tree, mt_dump_dec);
> +	mtree_destroy(&tree);
> +
> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
> +	check_data_race(&tree);
> +	mtree_destroy(&tree);


The lack of mtree_destroy() before this test makes me think that you
should move your test lower in the sequence - maybe the previous code
was still using that tree?

>  
>  	node->parent = ma_parent_ptr(node);
>  	ma_free_rcu(node);
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 4eb442206d01..17263696b5d8 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -26,8 +26,21 @@ struct kmem_cache {
>  	unsigned int non_kernel;
>  	unsigned long nr_allocated;
>  	unsigned long nr_tallocated;
> +	bool exec_callback;
> +	void (*callback)(void *);
> +	void *private;
>  };
>  
> +void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)(void *))
> +{
> +	cachep->callback = callback;
> +}
> +
> +void kmem_cache_set_private(struct kmem_cache *cachep, void *private)
> +{
> +	cachep->private = private;
> +}
> +
>  void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val)
>  {
>  	cachep->non_kernel = val;
> @@ -58,9 +71,17 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>  {
>  	void *p;
>  
> +	if (cachep->exec_callback) {
> +		if (cachep->callback)
> +			cachep->callback(cachep->private);
> +		cachep->exec_callback = false;
> +	}
> +
>  	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
> -		if (!cachep->non_kernel)
> +		if (!cachep->non_kernel) {
> +			cachep->exec_callback = true;
>  			return NULL;
> +		}
>  
>  		cachep->non_kernel--;
>  	}
> @@ -223,6 +244,9 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
>  	ret->objs = NULL;
>  	ret->ctor = ctor;
>  	ret->non_kernel = 0;
> +	ret->exec_callback = false;
> +	ret->callback = NULL;
> +	ret->private = NULL;
>  	return ret;
>  }
>  
> -- 
> 2.46.0

