Return-Path: <linux-kernel+bounces-541807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6760A4C1DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E977AAF10
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C709421148C;
	Mon,  3 Mar 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bePXCwij";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zHNSAQpr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116B1F17E5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008390; cv=fail; b=DBXORMNMhZSHpxDF8mAKHEnT7A2NYJwY5AOw+NW7crVE3uiXOWjmetCPiS/NHVvHqMlCDWScUeOwu073CF9cu7ats3+Wq/d468ZFa4znarKP0tIabImbYC8StX3Rp8E4JST4DOF4hmoJ3YGmgnTfHmK8jsqB+B5IpEqAjv7Wlsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008390; c=relaxed/simple;
	bh=ch9uZA8zBTFUcv+c9pFoPzyilgV8GpQZo6150/Cw4NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ToF96pADf+8C8/iERMgJpMoMcTtitCXx80aZJs1OP28DyNdzZocbT8I8ScPfEzgwOqMdVycuAGbZvwNgeXYNBPobgcWR36KeD2wl2G3YClLq219Qoulx0GQBdzOf6i/CFMISr+fhc6tkQzFdoarunKVnw1Yd884xr0lrqC4aKeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bePXCwij; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zHNSAQpr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tooC022695;
	Mon, 3 Mar 2025 13:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ifdkNbRm+3f/ra2CgD
	LQDU0LJB3G0UNV/w2xO1Hyfjk=; b=bePXCwijHSptVLzidr8XaWAvga6yd4JXfL
	AmrsPWmlo3rV4L6pox48kH8575oCL5uIvsMZPzPYoKjQFqKAVUZX1CC+yZPBhF2v
	SzztDZnW/9FQdifnoOU15Q0nmdvCSpfTRyOGVTKBzeMut+M2UsAjeems+C+juZUh
	CiMLX+U3cL01wzlt4ILlirK+JYbHeMMhN/5RLJDin92bz+QuBxwzTnLmE6W/ObaX
	58cr/L1JIAapY2Wg7La/8Wocm0OL1RwXCuiE649eDwGN4DDeZ2/JJRbT0jqLCJ5I
	r8qsf0FvoRzY1sCASwZYE/NSEwjvsBhyand1o9jSwqM8y4xIMzDw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hann0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 13:26:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523CZpZw040293;
	Mon, 3 Mar 2025 13:26:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdr13r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 13:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZO+khdYi3dxoSBtA0W9JmBCvkQ1oDk0ZXMQmfub0QeeW/oOcyt0oCojQPoB/6hd92az0uXfr8taFrZf5DLlVTVLZgtJdT0gihNLLn854Bz84cDUH78dZ0k1n024em+jrJHdspVAi2a33T8v4c5PxYzy6pIfjNR6O2zqgWeLRsZLhgdBYfukP5E6AIV+F4yaCZrla7nUH+bu57wCjT6NYsfqx/KsB87589L6NUlXiLLLHtJWVQ26zuwh/gCf+JvCxbhYUexeDGimgcWfJ5iYB2y5hI+RYxrbq30LqRDtSdFNPdwZGXRYsZSZqiGHiPdewZ0usEnogQwMEB5lqBOc9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifdkNbRm+3f/ra2CgDLQDU0LJB3G0UNV/w2xO1Hyfjk=;
 b=skcNu7WXVxG512bEaBrGOGacYsF8NvfEi1uw59AXzv7U5KG4IkvugX/4SEAqnNzEERyNBXKLiHaQDMQf2Y0t/yVtz1Kbts7vMJxqgyHByLH5fF4bJi+3zfsvyH6HWqIb/SnFrc8VSmCo2GcEvvsKyZpv95FIW0Xf45DAw8XF+/Krgxp8J/K+OfcA58ERQkb+w84KRRNaSDxmX3m1S69c6sCL0wSiqv4p26K+U+ny/Fxt890KlgtXNW0G0/FdlA98SohynYrmE+CxZL3lfaAA4KbmyhUCzh+GN05LEHUXdsOOnYi3lwlsmI6oNe2zSl70eL7ibG6G1yKiRoTCscmmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifdkNbRm+3f/ra2CgDLQDU0LJB3G0UNV/w2xO1Hyfjk=;
 b=zHNSAQprnfMFQYLxnIB6qrEBJSj+hfoLG+R3389AQeDlCmRdnr/8HLWwDoAoUqlRwQwW/Ip6q8xaNvv8bXjPmKpXCTi6Yzyi0sOvus7lhV7ieiTD+i2id33LAlBI+Ecd2EiOa5lLsu3I8U6MtWQ/EBwKqePf+MD1qgo6Mxy8Dg0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY5PR10MB6023.namprd10.prod.outlook.com (2603:10b6:930:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 13:26:16 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 13:26:16 +0000
Date: Mon, 3 Mar 2025 22:26:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/mremap: correctly handle partial mremap() of VMA
 starting at 0
Message-ID: <Z8Wt8HrxZeMkKtF5@harry>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <195c3956c70a142b12465e09b4aa5e33a898b789.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195c3956c70a142b12465e09b4aa5e33a898b789.1740911247.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SE2P216CA0066.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY5PR10MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: a53a47ec-8432-4e9d-a402-08dd5a56f97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ac8KMqeOMNXTAZHcTfm0Y35k9Re5gqOhgsuFFZ+oAQKc+NsaqAoJw3KtS1lB?=
 =?us-ascii?Q?CWxKHMi2xmQzgGrFmhSaKnMl83/t0I2z9W+Segc3g9NNsbceDnejDyGoxrV6?=
 =?us-ascii?Q?Ygh964VxeQNedioylPDk0YHjZ1t8GFXBNEEFyLu3c9YSValJDiMgcypyB6Hj?=
 =?us-ascii?Q?5PbSI5BvP+tEiMUTuU/ANDyobLZMVjrnzqOG2y5AGSDT0PssreE3IMZa/qhy?=
 =?us-ascii?Q?UFyz69mqZAwq4DKS+kqh1f/0jIwXFOr/C5Mv4p3SvVBvwAufUezbQaKhkBNv?=
 =?us-ascii?Q?Q3EiUPGG2hW5tw5xZ61twCfZWVVY8BhFNuno3H83tNzg/GlbZZF45KtyCpzh?=
 =?us-ascii?Q?5XkNgIFeTJnNy48gnLe9Zhb+tN5wYTcHsEJ+stl+8wgQavl11R0Jas+3r5xd?=
 =?us-ascii?Q?a9kTbohj/ipBLgeCVxx8iAIFBMlxA40AhFcCCCX/ql7yCQW1Q8MEmCUOGb/x?=
 =?us-ascii?Q?VT3AegsllzT8zC2lh9/6MwvfF3+S+aNlLuO8Hj+nIBV7CSqi9O4/tLSLrGPn?=
 =?us-ascii?Q?fU2XKj5xWv2xrVaiIZy3UBjpTEXGlcMPCNk3/aZGUTXbvv53YfvqN+bDXyY9?=
 =?us-ascii?Q?b4+wDm3dH+KzR4lRmNYEB2iC8szCiIw1HKpb1x247Z/dQkVK9taZPm601EGA?=
 =?us-ascii?Q?JrvnhzNqFU6WDOnJ1TQMgKlPPEhXAfWnX901/PZikFV3BUayS6Eg6Rzb9DK0?=
 =?us-ascii?Q?zaKmNTs1FHKW0d+0CXxfg7MfOP9Ai9M8dnzzuzIuyOAC8Y+IDJFLZe7i28MI?=
 =?us-ascii?Q?8pSaLn43Uz6ssJpCD2SpKndFCiZJW3rkvNqD+Nnp8Fb6d6YzwlsYtwsRT47S?=
 =?us-ascii?Q?iuMUtuGVZ3ge61S4wNcSTbYJLYSJNAYaX5PBqYIbhCC1f77jJ0Pu76GW4bMx?=
 =?us-ascii?Q?8bwVHm5DR3Yv3RSqEVlsnw4d3eI7J8bLNWOfTG1Zc6Xt6qe/pj5MDftScKEg?=
 =?us-ascii?Q?37QNlOnsMNWkRG8/URF6Mfw/5dCaDERHK8xd/Elpi2tV3Ps+Ft2Lqdnk76R0?=
 =?us-ascii?Q?5cbI6Parb/lkCHWMaOWG5idsDeB83KpONq0wtEHMzN6KiVHQje1Dsfyvw3SZ?=
 =?us-ascii?Q?KJKQr2ILLzOhDz84MA48Bnw0OSW34U0q8kUOJyIFmxeh1xIEWwjBM51WFdSp?=
 =?us-ascii?Q?32S6Om2kXrwQmB4aJ9zF/t3C7kq8mn+3OnTUn3MreOsyxg/0wnrAfD6rvTO7?=
 =?us-ascii?Q?MlrvwtiAAhM+bKRTJ+1mgwkzhyCRm3HM2KjVhUPrtCYPGjUPopNMX1qRGp3e?=
 =?us-ascii?Q?zyt1dclJhi5IZXQvWzIyQ4lSuqoxm3KFxNq/AMw7nbNHj27mIngnNaz5YWB0?=
 =?us-ascii?Q?jOPY8jY5ATtsHekT+ZitdrPJT49qWycQYoV8cef9Mji7bh6I+f254eiMROgF?=
 =?us-ascii?Q?q7IbV7OvPbw01Eh+6yvPuIR3UW3k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cd4Ukvi+SMI9CNFhrxhp+8pWBXfoucgs4WZ7Xfvqxvk6lYJ+I+lRJoT5gDOL?=
 =?us-ascii?Q?OicDS5eOaUXKtLLWKVx/R6lqUMeUZ9US8EQzf8c1YYzQIO6QqjahG01SfT8H?=
 =?us-ascii?Q?/D/Cfvmk1bFw0ieGEG/QN3HQJTlpWFmlToljCQ2rNnz0dHOWMXPJgqN6RGej?=
 =?us-ascii?Q?3yQXX7txv9asH4BjykIKgZvXEMrvjNaGHpPhDTW2TpdSOEp8eOlh8B8SD0nI?=
 =?us-ascii?Q?FVD3IbJGTrYVczAwtP7UBxMEbp/qVRF3b8owy1kbJ7quKUyXWV0UMMgsQDvm?=
 =?us-ascii?Q?YaRXPYwNyRlAgyBUmEiksWcyI9afXSrbG84cg5UtXKONkW3th/5gIBvQD8qo?=
 =?us-ascii?Q?vuay3sH4A20XUAMVhtP89cRJpXb1N7OvqvmflnVSNdtttzgjEL3yE+fuNHHP?=
 =?us-ascii?Q?XChxnSTZrx6sgMpGYgva2s0aPGkN/UYwj0mZc1G1ptxUVDfPgA97OYFw+7Qp?=
 =?us-ascii?Q?OhLvx1y5HQc5OdQ6yrqFP4GFUqPOgxpmrQ6oJz7KyDCuEx1ECHAOdxxRGqJC?=
 =?us-ascii?Q?P9QnCniDU/cYTfIUacoMLCJPOlv4gzU0xDZ5OwHkhyBlvdfno59nzbpUaTW5?=
 =?us-ascii?Q?iE+oBDrqANuUjIlLSRgbsydw/TrDIGpA+VGCfL8ccq/426ShigHXfv1PEmFz?=
 =?us-ascii?Q?NC6wGintXshWenRsmbAZlh9fJSp4t5VNgFqbBAQfU5ApUJ0AVeyXEL2t2FG0?=
 =?us-ascii?Q?fSKePbHf2TOGAiC/KfEZlShALwNXQJUe9BgJrFCNuD0o7eJ8GFNEfUeDrQtk?=
 =?us-ascii?Q?CjFaes3SL+BGtRcRXIgVUn7dCxSoAmlXrCm0nhIEwOaxihmC6zX1Gir1P1tF?=
 =?us-ascii?Q?ruRJ6sqlr1I/XO/FNUyjrCtJ7lENgypyuEGNBIdix46xyf6FCXgXOQTe0kyB?=
 =?us-ascii?Q?Z3NrIrCB93IReRlK/REiw/+PX4e22wyhtq826Ip4Q6k/sPh5ix7jtb/YSH+V?=
 =?us-ascii?Q?+dfZBVNmFs4v/8SoSIcew2Xir6zx/2KitAbUes+fknwVv+U1dG+S97hipeqW?=
 =?us-ascii?Q?6GodCDIl1Rvo/1WGyWdvM/Vp6R9znp9EJG/aVY+b76FlCKmhiSxV2DBgijf7?=
 =?us-ascii?Q?/QsMyc3gZft7jpv48y6ARWeQ0YkhDA6nVjHIV+uQlW03ScF/fmybXTwnoWoh?=
 =?us-ascii?Q?t+QBf1v1jlvnLjTB3UaHhsGpOG3BkVKy/J6T7Eoy1wIrAoYHe76rliCl3gPu?=
 =?us-ascii?Q?kihzcLpmmkiRY5lLvadSpeHW4+lohaIUzMTtd0ANN0So1WX9O8h9TE7soLPr?=
 =?us-ascii?Q?olXqVh/g+AYL6oHeRY6eBGYvFqfDe0Apr+mqfXI9GLM9m+9xi1bDlTnY4q6T?=
 =?us-ascii?Q?7lDM/Vn8TiY6G36PGwTXrXeugzbpIk+JbSqlrwoMFaCXqNk+NaGzXfBq7jAf?=
 =?us-ascii?Q?WVij8R2/HwFajkgXa7eoecUSSJn3vBwGyXjxhLnJsyqEhWoeAWCqLjoQ86Ef?=
 =?us-ascii?Q?DlKGjZVxWs6gBk929WqDMGNYR4m54Gt2ecUCkI6nubYzcpghL2Z/hRFUU54k?=
 =?us-ascii?Q?uVbZG/4YDgZrZeoEZqHtks8fnV3atJ/Yv8ByDI2VgbY5SiFdAbX4siR/B1Ob?=
 =?us-ascii?Q?Gs5PxiKP9fjQ0DahKkB5+H9fMdWK3z8Y8jNv/y3H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uUOUOLY/6sGTjLT+IMYlyOL7SvW+jApLSKYP5XXwEYA1zQp8nBFcvIfO1z5jBZS8EvB2SrwvBXHoRsR5BiNCr67RXa6GH+j6n5ctCNwNsJaNKmCkaZZhRmBQTKxeP4GhC1XcqIzJk7+u5+tQbRGErS8D/MjFXrPy4XYXeioKKMVh08eDEe0cd+y0NmwPYAKoTJ5+R5DC4jDjdWap8tuFlW1F45t1+NJcTYGENqAs8yl9GBku6NlAlzarwjm7K8kcgiMwx9fjMFNzS0rJ/gwQxOd/UWbNqw7ZYuHNaJloHlx5zBPtuGDV/sOt5WDIF6WuW7atkEJjyeLlgrhhkM0jytkwiCXOshZK8tltiwZ099E9x2oouOiJJBD3Ojxgy/vSHI6k5cH55hNb1jJm7pqn+qBDs0RuyIPQ2baJ/JJhqgU7N0jLm5gNc8FYs+0PARJ4K+RGrxgeTNMsEw7grEgJeMtaBDexXv9rrMGKgPIyy/HCDFt98eR6/lldJEbY2Sph1U5PMhIUKv7BMZpd2tdbH6/d6+dZrvzwW7G8upOEmoqhsOAxCIVs6H/gXwxmySsCIjxlTQt+yShdRdkHyEhR4z7f2N6hfrMRpqao8rS98Xo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53a47ec-8432-4e9d-a402-08dd5a56f97f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:26:16.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0CqB82ZvedIOQr7Vk7d2+es72pS5NUt9rrqdGIkEsC2D5U1L+OiNgppy95+kJqnZew0cdPsIxtVDJSCyqgxqbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030103
X-Proofpoint-GUID: yCpwTkM_oQEOa6Qbi6T6Zplksg5XPqnt
X-Proofpoint-ORIG-GUID: yCpwTkM_oQEOa6Qbi6T6Zplksg5XPqnt

On Mon, Mar 03, 2025 at 11:08:31AM +0000, Lorenzo Stoakes wrote:
> Consider the case of a a partial mremap() (that results in a VMA split) of
> an accountable VMA (i.e. which has the VM_ACCOUNT flag set) whose start
> address is zero, with the MREMAP_MAYMOVE flag specified and a scenario
> where a move does in fact occur:
> 
>        addr  end
>         |     |
>         v     v
>     |-------------|
>     |     vma     |
>     |-------------|
>     0
> 
> This move is affected by unmapping the range [addr, end). In order to
> prevent an incorrect decrement of accounted memory which has already been
> determined, the mremap() code in move_vma() clears VM_ACCOUNT from the VMA
> prior to doing so, before reestablishing it in each of the VMAs post-split:
> 
>     addr  end
>      |     |
>      v     v
>  |---|     |---|
>  | A |     | B |
>  |---|     |---|
> 
> Commit 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
> changed this logic such as to determine whether there is a need to do so by
> establishing account_start and account_end and, in the instance where such
> an operation is required, assigning them to vma->vm_start and vma->vm_end.
> 
> Later the code checks if the operation is required for 'A' referenced above
> thusly:
> 
> 	if (account_start) {
> 		...
> 	}
> 
> However, if the VMA described above has vma->vm_start == 0, which is now
> assigned to account_start, this branch will not be executed.
> 
> As a result, the VMA 'A' above will remain stripped of its VM_ACCOUNT flag,
> incorrectly.
> 
> The fix is to simply convert these variables to booleans and set them as
> required.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Fixes: 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
> Cc: stable@vger.kernel.org
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry

>  mm/mremap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index cff7f552f909..c3e4c86d0b8d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -705,8 +705,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	unsigned long vm_flags = vma->vm_flags;
>  	unsigned long new_pgoff;
>  	unsigned long moved_len;
> -	unsigned long account_start = 0;
> -	unsigned long account_end = 0;
> +	bool account_start = false;
> +	bool account_end = false;
>  	unsigned long hiwater_vm;
>  	int err = 0;
>  	bool need_rmap_locks;
> @@ -790,9 +790,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
>  		vm_flags_clear(vma, VM_ACCOUNT);
>  		if (vma->vm_start < old_addr)
> -			account_start = vma->vm_start;
> +			account_start = true;
>  		if (vma->vm_end > old_addr + old_len)
> -			account_end = vma->vm_end;
> +			account_end = true;
>  	}
>  
>  	/*
> @@ -832,7 +832,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		/* OOM: unable to split vma, just get accounts right */
>  		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
>  			vm_acct_memory(old_len >> PAGE_SHIFT);
> -		account_start = account_end = 0;
> +		account_start = account_end = false;
>  	}
>  
>  	if (vm_flags & VM_LOCKED) {
> -- 
> 2.48.1
> 
> 

