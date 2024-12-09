Return-Path: <linux-kernel+bounces-438375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1649B9EA057
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9201667EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FA31991A5;
	Mon,  9 Dec 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GQVNJWDC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Plbe+lWC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929C14F9FB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776625; cv=fail; b=XCvT9d4AgjCvL+z5JFOkg9fYIyNgL8BuPf8jlVVHhVx1qu+8tb9rAfBspQWGpWm2effsU5evDf+1lWY5VF2UkQsAuVrTiK3s13pKdfehgA9TfVruOjr3P3npUwsQVRSob/an/Le0kl2U1yU4LRoc3NfihTy9UHDQd7hQRCM76xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776625; c=relaxed/simple;
	bh=OddiEzU7Fm3j+jIoeUwFBJhnhZCYj3khQ+cV7xt3A7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PG5XE8XGcoXmGz4gbw6QE2zPObDykKhfzxWUd57LbVgaObToIawZsJpnC+7eFXh7ovVgEms1tCRXDisMjtxaWbEjhpLdRfAzhoPBtUZdxi0LXStoGXE2Ydatucqztr+91eO8c6SFuL+TxXXTemrUiuxw+YIGjv3z2a4/TwFjijs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GQVNJWDC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Plbe+lWC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9KMrqs012941;
	Mon, 9 Dec 2024 20:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=CTMlzBK9j+jNnXNhan
	EJsLZqG04FxWmAM6D3xJZIU6E=; b=GQVNJWDCDnxdMUQlQsp++PkefazMNfj9G1
	QIfDxz9VDfv++2/u21yfCC/bSLN1UGIsnq/WoEOOXuf9GQUuU/w9PdaZYgnQceEn
	7sk1B/wG0ebrmLiWkJ6doJYptrj2tAPEv+/QiSNwEKAmYPs4o9W9TjJvUSGLr0z3
	NvSwAIpB0fml6JSz23NEnKBwG5CJbUgU/B/bwNaTNjQppFjGez4kWF36T5QsfefZ
	ccDohv3E8oZhc8rD0EZ1V7+QE7tXS4z/l8hLftj5e4PSm87DDmtf2bG88mW/6mQC
	A/EkB3Fm03RQcNksZ63k4jeLkdWgB8aSiG6hTHGuJOcWZ5LFqOXw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s1anb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 20:36:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9J6hef008678;
	Mon, 9 Dec 2024 20:36:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7gy4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 20:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCynue+yjRq2h+UOOZ9w/YfZk05RmFRDwHKDehqJyDaSeUATLghTh2vM469V+IYSC70/9eYf9N5KXE7v+QVsTJuum1k91VP9eGdQt+bGzjN8zG56q+MiHAOvIINYT2f0s3HzILtEReb4miBJ+nzMIsQt93YK1rGmNP/dz+sVVi358SffngPGdxibbn6MEh/1AVH4bZh2QiGryKEjXNTacQAdIXkcNj3S00WWr40dtyZUbEAIrEzf2y91uwcgyCMPh+QW2SOl2xExZLpAXUEpcy+Y/8gdT8yzjMe7+6kiGj+RCMIPUtPa0YhWFSsm0RaH5ACebRXSR5LAcok3v00Now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTMlzBK9j+jNnXNhanEJsLZqG04FxWmAM6D3xJZIU6E=;
 b=HNbAfsAud40F92QimxqtYT6cBsknNjrzVMbfRxkhOtHgemR9tpZAZedJZ0CjXQ8TUonfO5CpeBhKZEUjBypCCkhy9jylSWJlXywfueLzxPF9TuEOhqkQtzURC17L1xdH070Sb24K7zFg11m0dmj0L1zLe2/JNwUs1ocWVF4bVaUDazn+quqT/gFDNXF0KxUXw8s+bOCUlWMC0PDdB8q7nBR1ElKeOqhf/bg43vZumkDFafrusiMGee93GwUhMf9tS+RMZ5nO7CXj7fZzFgwCUNQHCC25sIlWtoYrjNV/YAZ6j9/NbOUfk1I9mS/x47xNkak/2PaIvb7dy7SdmA/8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTMlzBK9j+jNnXNhanEJsLZqG04FxWmAM6D3xJZIU6E=;
 b=Plbe+lWCO5aa7PnK0jbRR+E960B3AYmtiSPX4nya6e/6/BmxCwOmXP7Ljlc3YUP/oeSExomk2BDG/C+zlAJG2PFYypEvLJBrpkfQB7lpLWa1lXZJYlLxfUd0LLNQT08GqMHa0OxKbsWsP/9EJwxpOqZmUtUsMwb/inWYLlv3fuc=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by SA2PR10MB4492.namprd10.prod.outlook.com (2603:10b6:806:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 20:36:49 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 20:36:49 +0000
Date: Mon, 9 Dec 2024 15:36:46 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
Message-ID: <wx7x2qzdmadbdjy363jqz6nsfcnr3tougzlvb3oeomlqxjf6fl@dygmglqiqyx6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <6756b479.050a0220.a30f1.0196.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6756b479.050a0220.a30f1.0196.GAE@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1P288CA0033.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::46)
 To MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|SA2PR10MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: da9d970c-9d57-4ce9-4b7f-08dd189134c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OxL8Uw6k7r5GudMv0az+kPoQSUyUwcRqhsczqsKqrhnwjrD1yW7wJb6cOLCw?=
 =?us-ascii?Q?9CDSF31goTpjfc9Tvj4lyXTOxLvduRDGNGYBkU+vRcmf5Q7Ay8wW+Zj7K2Pn?=
 =?us-ascii?Q?kkq7Tcz8eoaZPE7UhYNzHhD4d1BG6VEWpRno02VlNp2w6wqI1dTHE7FQYj7J?=
 =?us-ascii?Q?ENCnAPGG/eVryuvHjTXZHtWXe685gspEgLZoJRonC1q45K2+kmPuYQAQoMVk?=
 =?us-ascii?Q?PN4CNetNhl43KWooZs7u51hLDN92jULEfrm23C55SbkoLAjsDae1gfmxdFlU?=
 =?us-ascii?Q?5JfP+xdRQ6y7b2eqigqwip58uHah1B5LNxiJQzDwvC8Rc1ZCJlcwgUIqiQNa?=
 =?us-ascii?Q?Z4dwttI9qlzntkIOxGN/M5eTtAZJVwv2hZMVv29B+HU8RlO3BXCnOJ0Y1LRs?=
 =?us-ascii?Q?/cM6y7u0RSfERVii9wiNSVZWElR6hgiJS1Hvj7leTNLAIM2xzpyjB1iukljQ?=
 =?us-ascii?Q?LYJcdKk8rNowF/98ktkiVMeFFPahBOO3c6QnYj6XzHFr11zbuDQTvd5BlGvW?=
 =?us-ascii?Q?HzC9mGr7aX+yg2+movn5baLj2Vg7AgCnKYHMlSPbiDv+fPx+MATWrfZ7FyL9?=
 =?us-ascii?Q?9805xzi5RvFtYHXWXNwTzRIXRjr2p4zkxsDTTEltKXF6escgoLKu20mF+xOk?=
 =?us-ascii?Q?QUEAZQsEC9rF/Jye3BzUXZwNpju8ovicQ4DOhfzVNLrm7EAUbKlSxstLOvS2?=
 =?us-ascii?Q?fpb314PPduEnOmetVTqVcdqmsYA5W308xpdL9Y4OGX3Hrzz/f4rHZBQ0cjke?=
 =?us-ascii?Q?Ut8ii8q1H6I9rp6GWyCzxGM0Jywqj2w7gdfcKjtTxozT9CiHD9L+e1KpS0bz?=
 =?us-ascii?Q?sNOFFCJ20jiBwXidmjaS1p8yqZ/3RhtT2/4sSImPCzJjjMhVQhQYJobYIJet?=
 =?us-ascii?Q?zHpjT//EG+m1JgNYlDGJpLBmzwWXYVdgJPMA8dWHl+oH+8bQEQCHt9qEQOgl?=
 =?us-ascii?Q?bBSgccMkASxygjGZN7yENiMyTxktanzb1ESRtHcn6lgiHwmBl/T37NQuq1vD?=
 =?us-ascii?Q?i8nZW7e/73JBHPIzISVtpW6FkNqneyId24R8Z1iGY8tuv/TeUQ8tOaNz1VE3?=
 =?us-ascii?Q?890YJIKC5KH0i1++LOcOXSDIzRI1OlhB65epY/EsMFKGiQlfkZ+mLbzsk/PG?=
 =?us-ascii?Q?XyT8V83gFNEhoXJDK3ucdbeqeRfl0Fj434xnQbRZAWNW/bdGNz9v5K+uYiXb?=
 =?us-ascii?Q?m08/3uy+1JiKCx1sJCLcoh7yffloJIVJFX5aAGntmY9jUXVJxAkBtTarSmFC?=
 =?us-ascii?Q?0llXM4aa3eUyDTdiYvkrprcXE93OtdmLbdw1ZFKU6hwdcw7x7uLV8RIJZrI8?=
 =?us-ascii?Q?Y4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64l4gvOjB/Ctj20pzOSDZfe4yp+3jJRa2j0vxXDPbZW3Rk7NhsHZfFsxEO2X?=
 =?us-ascii?Q?P9YsL/1+j8g/mbVqmueIGJPm7WrSOPbM6/BU1OJuDdtz5jidonjQBrRAt3bn?=
 =?us-ascii?Q?RmciTqntnd6XM0mCGihtUwaNgEj1heuw1xo3xaOEfAjS8hFWX8SOgw2dGTF0?=
 =?us-ascii?Q?l14lxDKkfL8W9sP4UlWa3/OqYMawuzVmS0yoDrM0XlwY0tArm8n1MGrHC8kO?=
 =?us-ascii?Q?tYVJFuTmJQBjrrl4OXy1qpE0l6P9HbgrYxMmpi42PDrDtSVqUVicfH0U7BDD?=
 =?us-ascii?Q?EdgrcYGKDrOanY4mGxhDD77UaWi40pU+hoAfkAXRo2PARDtWZNHAifLOGzPj?=
 =?us-ascii?Q?WDKMNI+/goXb7EE3fH0vcPoQkh3KuwLzSEBKABZGlbJA5AudU1AGUZZ0ALVs?=
 =?us-ascii?Q?RO9yrsljfscoS/M2bmmGyZQS5G0q/4dzc3nhVZ5t0TeBFIoNH+dc9a3xHBCS?=
 =?us-ascii?Q?17vQtn97fY2r3V1P9TlCaXzSCPea0ZdE+jIjml2NhEjjVUyftReHp+esuOUV?=
 =?us-ascii?Q?ajJN5g6xI+eWifMZKQBM+x7cs9lgHwe3gsb+kcwn5jTO49b8bQtiI7VnI/TW?=
 =?us-ascii?Q?sclDriDrpZpcG3haeD3ZB4pJRQqxY7Eue0E1XECEPITQO/hvQt32i2MP8TwI?=
 =?us-ascii?Q?eK69HEDBQ3yPIbuC2GHRk+xVAGuIR3t+GCSkfK5krFGIZ6q1/4iFDdnP6dhU?=
 =?us-ascii?Q?NtkpLbn9Ldwqim7mzB7FkRh5qoD2KIEKiOOuuN+Vz9aSjuxxzem5T9tuCfou?=
 =?us-ascii?Q?Fx2foULJzjLCh3u1YT17xZfUz+S0eVbbx/9QzVv++kCf1P2OvwHxqHWARo80?=
 =?us-ascii?Q?Iy9tKgSealgcdmtp7RKUBgCMYcl3vTn+MJChtbnQjSJfM9go7ygBiZwn5wbS?=
 =?us-ascii?Q?wMb6Zob6KSMcuahzDbi9aL21QOiTMgK0xDgR3UoqHPKd8U5DfqXfP2B2X73D?=
 =?us-ascii?Q?evGLQ8wwwLfoPFlM+3e72F6Zs/H5babbiCWRTiOtFKYlpjpbGFtFnM6jaL+r?=
 =?us-ascii?Q?njxMYEc+h4hqZuIhG8fYrYLjGtCsRDn/XWrxyy/3O8oqGyM/WGUGH9Zzs+4G?=
 =?us-ascii?Q?tTrOJGtRJ/UJ7Ubw4Nd2NLWKO0GGNuw/qoeY3dHSsRbdGVIT66Ej8fR/y/iJ?=
 =?us-ascii?Q?tWQObmTdmZGZXd2DO38YUwejIMitAnhB1HEN1U1de03wgZv524nsqOoAZSQR?=
 =?us-ascii?Q?6sjlaCyWS+Ptgzw+cwPVuavzMvD+Nfn1FU32GHFqIUPe9tHZGVnVLhAOzrI3?=
 =?us-ascii?Q?VXANuXZa5b8RDA2lLzv0H/MId9T0943UKXUwevxthhWXp5+cENzUxq1DUVSt?=
 =?us-ascii?Q?hlTnyKLKw1LdJMYoDrm6z4riuOj8IqH4eVmc1N9jgDhIhoSK7vjwqNmNROWv?=
 =?us-ascii?Q?BAi5DVLuax+CP15Visvz/Pju1QlOpPc74HeGPrsZ10ZTYQibYS/FGSd4sGjZ?=
 =?us-ascii?Q?vgTge/AlOd++/3uDMh9gssTYUfz+qstPvYEd89ATGmBc7sCOwOt5HsTGhdIl?=
 =?us-ascii?Q?WAc0UNBaGprScutm6Ob83GfPQoc9jFOvT4pjKj6Yn4aMW1Nk6QhX1L3ZRszJ?=
 =?us-ascii?Q?nsurpaPzBymZLzA3Yw6aDBa8bdkXF+al4eu+wG5m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+4HR+XcSmQc3kmcmDLMIrvfwMAdGsB8Y8DpPt88x2xykwAfpkFaxtyrOjz1J6XcUlYei8pCvVkgvvo01fKkR7xE7y0ST2gr7XvG0nOfk4vOC1h8kDirroTKMP3T7uFSWQlCeAY/tkspRiKTlscLgTlkADRyxQWz8e/o7c1KcD9n9H5AkBp7SvABqpdjEKi5Tk5sn0TNl/EJIJOFCJ+kjbC5J8B6XoL7vT+tKwrihEYQMysZhZnSAyRJJ49qN3/U/0NjrXyJtaZ8psSv8YgkAoMKqP8C4uxMuANqNWymAcLsWQwQG4p8nVOQPaRyOQIXw73oKxM7GcQvZLkmBpYNSc+7l/fRJnD64680QKvHJYLjUtFLGw5Vy2EjZWCEL+gOWlZLOtduq1EpVyCNWM9RgSy44VrnoxR+BQREuq6RIT1sOx4LlzaaL1MyOujwPlWnVH1zjvSQDzoT4NBm16m2bPJzkk6uYfP9NDFWxxXRcNyEuWIDhNYVbXrWCa/Phu3I7GLj+6OLNqq/Kka4VtlbYJ22epyY0OYqGQUlmHRhmTGULbodgDAz70D9c5D/+P6t4keIz7BmTjBt1lO6JdIpqCPDC4rYX4CXRzRzab1iXyyk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9d970c-9d57-4ce9-4b7f-08dd189134c0
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 20:36:49.2593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 725l9gLW1S9RHrq54Cu/QiPBFCetyaWavWeSJybTh/63GyLgG3YZhdJyFbbFB8D+8e888bzIKt5cVkzQor69cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_17,2024-12-09_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090159
X-Proofpoint-ORIG-GUID: lXAbbYyMXmnYJbSctRdqAYv_JsK-vB6n
X-Proofpoint-GUID: lXAbbYyMXmnYJbSctRdqAYv_JsK-vB6n

* syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com> [241209 04:12]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b08020580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> dashboard link: https://syzkaller.appspot.com/bug?extid=882589c97d51a9de68eb
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e8a8df980000

Check hot fixes in case this is related to known issues.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-unstable

> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3bb09093023b/disk-feffde68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9e37e48dc48a/vmlinux-feffde68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/36b46b3a6421/bzImage-feffde68.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	(detected by 0, t=17825 jiffies, g=10505, q=929 ncpus=2)
> rcu: All QSes seen, last rcu_preempt kthread activity 11791 (4294964533-4294952742), jiffies_till_next_fqs=1, root ->qsmask 0x0
> rcu: rcu_preempt kthread starved for 11791 jiffies! g10505 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:25784 pid:17    tgid:17    ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5369 [inline]
>  __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
>  __schedule_loop kernel/sched/core.c:6833 [inline]
>  schedule+0x14b/0x320 kernel/sched/core.c:6848
>  schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
>  rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
>  rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> rcu: Stack dump where RCU GP kthread last ran:
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 6002 Comm: syz-executor Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:__sanitizer_cov_trace_cmp8+0x0/0x90 kernel/kcov.c:293
> Code: 10 48 89 74 0a 18 4c 89 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 4c 8b 04 24 65 48 8b 0c 25 00 d6 03 00 65 8b 05 70 61
> RSP: 0018:ffffc90000a18c98 EFLAGS: 00000046
> RAX: ffffffff8bcbfbf7 RBX: ffff88805d8d6340 RCX: ffff88803141bc00
> RDX: 0000000000010000 RSI: ffff88805d8d6340 RDI: ffff88805d8d6340
> RBP: 1ffff1100bb1ac68 R08: ffffffff818d04c0 R09: 1ffffffff20328be
> R10: dffffc0000000000 R11: fffffbfff20328bf R12: ffff8880b872c9d0
> R13: ffff8880b872c9d0 R14: ffff88805d8d6340 R15: ffff88805d8d6340
> FS:  000055557e00b500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f29e4db6bd0 CR3: 00000000622f2000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  timerqueue_add+0x4b/0x290 lib/timerqueue.c:38
>  enqueue_hrtimer+0x1b2/0x3c0 kernel/time/hrtimer.c:1084
>  __run_hrtimer kernel/time/hrtimer.c:1756 [inline]
>  __hrtimer_run_queues+0x6cb/0xd30 kernel/time/hrtimer.c:1803
>  hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
>  __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>  sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> RIP: 0010:mas_wr_store_type+0x2a/0x16c0 lib/maple_tree.c:4212
> Code: 55 41 57 41 56 41 55 41 54 53 48 81 ec c8 00 00 00 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 ad 78 d8 f5 4c 89 f0 48 c1 e8 03 <48> 89 84 24 80 00 00 00 42 80 3c 20 00 74 08 4c 89 f7 e8 5f 60 43
> RSP: 0018:ffffc900031174c0 EFLAGS: 00000a02
> RAX: 1ffff92000622ec4 RBX: 0000000000000000 RCX: ffff88803141bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90003117620
> RBP: ffffc900031176f0 R08: ffffffff8bc6b87c R09: ffffffff8bc761f0
> R10: 0000000000000005 R11: ffff88803141bc00 R12: dffffc0000000000
> R13: ffffc90003117620 R14: ffffc90003117620 R15: dffffc0000000000
>  mas_preallocate+0x27d/0x8d0 lib/maple_tree.c:5540
>  vma_iter_prealloc mm/vma.h:349 [inline]
>  __mmap_new_vma mm/vma.c:2349 [inline]
>  __mmap_region+0x1b89/0x2cd0 mm/vma.c:2456
>  mmap_region+0x1d0/0x2c0 mm/mmap.c:1347
>  do_mmap+0x8f0/0x1000 mm/mmap.c:496
>  vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:580
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa71757ff53
> Code: f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 41 89 ca 41 f7 c1 ff 0f 00 00 75 14 b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 25 c3 0f 1f 40 00 48 c7 c0 a8 ff ff ff 64 c7
> RSP: 002b:00007ffedb7e9bc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: fffffffffffff000 RCX: 00007fa71757ff53
> RDX: 0000000000000000 RSI: 0000000000801000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffedb7e9c30
> R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

