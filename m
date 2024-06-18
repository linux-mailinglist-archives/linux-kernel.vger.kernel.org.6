Return-Path: <linux-kernel+bounces-220172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAD90DDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0F61C2335E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64218757B;
	Tue, 18 Jun 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CJJa/eHQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MEvmtRHW"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E53178370
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743728; cv=fail; b=XcVSP96DRAP7+FbI8wzea3/rfUcmSJy5HwP2tdpB1t5byuOpnOOfVDteJyHZiEhHJhPgpCojDlFmBtcCrfvyilN49vcDzeks1Z5Hv/UAaJjGcGQvgkGuC7CDSGscWUFA+k5xiV4P4CI+AzNDwHD8WAu/L5Kfyx9SC0P9wB+r9bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743728; c=relaxed/simple;
	bh=mucbatbOhbvJAlEfkNTS8qLbm6X7/mqBxMiQfvxqb3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrfjdrAAkgfNcC6p458gOHvnzo3R0SLyMQsQFJ98t5bOl/doHD9r0zM0uNKmDw9SpWJpPJ2QCBZPVWRbuaToexam5yybUVrnRD5G2hW/jjIfoxDO5c3+cWqSFbGpnUM4ldzWgTrZCHO0U4yrn28bSrr5SAfA+gD4F0R0rDGC7vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CJJa/eHQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MEvmtRHW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUuo5029804;
	Tue, 18 Jun 2024 20:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=TnRBn16rZSvz7QjvRsI5wvDleitKq8HR28QzelIjebo=; b=
	CJJa/eHQwwQwku0JK0aSCHrggI36NAFmTw+tXINRpbGWai4ZnKgjMr1+dAgfzwGB
	mcbnkMoI2OuZtO7YKPH4IXL+n0pHk85JefLwx+zFTDkJoH69R4Y/B0D7oO7y3BDQ
	hdInQmkP4r+aII8qNVztXmyVsZB0ob3oQby52bxDnVTSAm9v2kviu3TdApijyxlq
	smbbPMgMxTPPjfUo6LrSx/V25s1CwB1hPwk/SFjiY2qvEH+NUspGU0JjsPkr0QMe
	z4Qnjydq735tdwzsf+zwO69zysCkmhplfS/ewnIUsUAc99Y1gMgF8aJEl+Si0OxW
	j66/RGyaKeaEKjEsDVRF0Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js5tnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIN034656;
	Tue, 18 Jun 2024 20:48:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiU2J5YwcEmv0CUVsZ/fIrquNMYhpCQ8bDuaRmbdltZ6klnUlu3X+Jl+h/ftPwUpGkgpHaGciH0YTHVgYkPadG0qmA7Qg4fCZeFKkCqp4+wvYlGixfZr23ibrWZnI9mSIuDR4//lbZyMkmLpLnwKRjSkLLQiyD7tYr5Yc+xVTW8Qf+kpVvep+3axEqH0N5bUDt2DKdzoW5gtUgbIuIJrTHXjysawPvMGfsnuazOu4rhq5ef+HcvZqcnC6yImfALLH2ssctYSltF5h1N9rWxnErPCd+ykzBFVrjAV7rp4PhFdrCj/WZl9Q8SLmRE5Iu2eVJPB3PC/vhaMTbtQBAFWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnRBn16rZSvz7QjvRsI5wvDleitKq8HR28QzelIjebo=;
 b=c85o++LlvWz/an8C9RFZZqIYPTPFQwJY1YYrUWRnyFOp7bJtk7lZuOYGpegztZ3/ViZSm/w39cxFF9kDKjgQW+0H5YTEa2xizdI5d4v5nlmhAH3fbOiNp9Syet6doMwEZTLu8BbcdV9LbxT1ROXAXccWSU4RTO14YKtadanWaPglwIYHtLArBiOMvijyvbA3bpMPkEube3cZ/DZkLnN6IxXSEKXvz1HYE27jmB+/Kfp4Vd2Mh1YXL8gxw+Pb0tbTryN1/toPupJGWDp0tDsrrc2/YZi6sBNhTqYe3x55mjmZ8lv6CUUWco1XtTyIeYBf+O4RaPw4gIq4kocrL4+WlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnRBn16rZSvz7QjvRsI5wvDleitKq8HR28QzelIjebo=;
 b=MEvmtRHWxY9njVZdwVHK7sddU6jIGwm3IVMi1+eTG9JzFB65qWg/oWeW6EaRadxLVYIepxKm1Q8fWq+BERgkiHL2AbiTRwdcEHzOy9VSTQ5F9LT9m+TFs8rkwrEEHQ+NNshGAos61AUR0bMqR1EJw2dKU2+Bs5uKlRq9Rgqgi50=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:09 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:09 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 05/16] maple_tree: remove mas_destroy() from mas_nomem()
Date: Tue, 18 Jun 2024 13:47:39 -0700
Message-ID: <20240618204750.79512-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0370.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bf3124-c4fb-4078-3b8f-08dc8fd7f662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6BEowefu4qlpmm0tipmjL9ySGeduyPI5VkOvDkCso3z+pqxatnA3r6Mfms5v?=
 =?us-ascii?Q?DSCftAdsaYXBJSj2kB7M6ltV2CV+nt0rbViQf9B1N74FYgKT1sd5YfaX+IXZ?=
 =?us-ascii?Q?c2W/OL5Yy+rpvC0kpk5pKbRdLVurEs40ONpwVRQpEpnJJK9Xf9XQRTcSBw18?=
 =?us-ascii?Q?IVwIndd/PjJGm0Zvo2TzLEJEaVNPCwzYaNBgVY5lWGv9vPCaDr9hMq1NMcxE?=
 =?us-ascii?Q?VBX88pkTlg32gMk/pIUi0Z702MSS1ibexz8OqjhjJ45nL872lW4ZmwD4AZHi?=
 =?us-ascii?Q?0GRImSSDnpUncT4y22tCdV8kGSGBIvVyXRqAuEm3JXy2PIps9NYZ6bQxGvSn?=
 =?us-ascii?Q?tY+CGjf18l74STN2NevXiDynZHLA18hVuGi3oC2beeIYQmcrclV1VmPi4uaw?=
 =?us-ascii?Q?GaJEcAHKIijK047UQJWcoNyRT712zTUAY9CLLh1zkJjNQ1OF63LIG4Y0jKGa?=
 =?us-ascii?Q?ZwmcjGIDhDTO2PObDbCKFt1nPo0DheOQGi57LUA0zvqX/JTIPoea/HKQlIOX?=
 =?us-ascii?Q?fWiEBZKa0xt9/YtaHTfeUYbR7qp3+dM2jonC2fCHPGCH+NAZtBiUcun8cJEE?=
 =?us-ascii?Q?DvOh14utVtotbIay9NYS5E+izVDCVYtBcTr5LFrIaJvkxC2g0MA5qgUW+RXH?=
 =?us-ascii?Q?kfSK+M3qac1jEdLyRRKitP2uqHVHB9K3LjOszlcUCRlNar7ttY6slKbYYTmV?=
 =?us-ascii?Q?o0kaLtfo/UjkQoMG2rAZmy1uY207CxRUAGV0KQFRS9XwhFF8t6yjHqYS0kkM?=
 =?us-ascii?Q?P/cR+ugfeJVRD7kI0aWnAlF0v7UoRLx+VqmbUnF0Pe75qSxD9ElJCmiH0Qoj?=
 =?us-ascii?Q?iLgP8I1sWG9VW/pCvE1PkoTGUsfdjR/5ij9+pQnS6nE8SOU3hyeneiIX7qq+?=
 =?us-ascii?Q?CsRGoeV2SlFjtIL3xI/w5FmN6jHQRp7pOPm5QdPNbYPFEiKtxStnIdIyVE+Y?=
 =?us-ascii?Q?maaBFU53WJQRNs87TdSYy+nlEWewvc0L8tTpjqqQsaWpURZiNdGTEjiaTLJb?=
 =?us-ascii?Q?Aky17Ov3tazR4BM+C9xSXybdJcXLZIkmEp4PF6/t+NGq0QUwi+bq4n0xKzx6?=
 =?us-ascii?Q?isIRfdyt8QQHZkCyztipnWKOg4ucK9VLSwQF0MTRkjD47O1nBSrbag9S/auo?=
 =?us-ascii?Q?scXjhbdEQe7fa+WKrCxa7klmuV3/RW6UBy9OVhzRGARzuoLnjydjuCNO1CGi?=
 =?us-ascii?Q?Zq1ulMiOFI0xBCT5eJXCF6DB9Qny4iU6SkFeRgLU4AdEJeus7wXZUDYUG5u7?=
 =?us-ascii?Q?rwtulsitGTbOf+ZRuL4FsxTSzUuMSX/3t4JyMttJBbGbBj/px3DMKHjfoWxY?=
 =?us-ascii?Q?AI3zpJ6AIdrthbLx92iVQiLT?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ONhv/mTECoxuIkkcKJGEc9k9Bl/7Tow07KeSNUrBM2gJiMnafbE5gShmey+3?=
 =?us-ascii?Q?AF6nwhznKnvCawftgxLjbF6VQ+DKlgWtbA8tTmzdMMYI67ucsiqjgMLRogD/?=
 =?us-ascii?Q?yWM2LHamq8KMo1utQVy7N1Sjj1EaMrWSfR7koEiT3I7Ry9kdQxdvEQlxSXAR?=
 =?us-ascii?Q?yrVO76+Dd8bXDrg7U4y7rCIGKJ588DHb75xTQTfG2Ekf6qQCci8R6nsRkiSy?=
 =?us-ascii?Q?VaLwd64C+MgdDMMvSccbaBJmz9WAWKcPkmzAF7mKCwxYGWGtJHvMYH6KGbAW?=
 =?us-ascii?Q?laMSh9Z7Ny+ozr6QMVNwcYxBsRz1cEvtYOtZo8fozTE7ZNgSCnKJOlqlWXe/?=
 =?us-ascii?Q?qciIiq8mr0RVC5U8aoi291+viZGHGOVNBsD+ZKwhwq1T0I9OuyjrqWFM23i4?=
 =?us-ascii?Q?Ev6a1DO0cji1Q8Ii58lizxjhnPwWQ/U7ClJNsBbaODnbZxYFFefwNaLtFNub?=
 =?us-ascii?Q?v0jmlDNxS7Hgvf7oNmV9sPvuXRxmmZB7twDdW+ONsn1Yr+IjgcZus0DUbNLO?=
 =?us-ascii?Q?uWiyFll8ufUGnLXvARFcMFO+tHZj3qAezbzJn48cCKxN4UX/c2kyI4m4URqg?=
 =?us-ascii?Q?5LlnRp9GZTKwioV8MWd1iEdKROvpUYW1Ht5LSx03L4D8Q+Ho/eKVeWtvtFS5?=
 =?us-ascii?Q?gtPZKXXc32pXJO6kzLlrFRF9W97wgSRXDLUmS12DSc5GBOdX6/4yvMZiT0hd?=
 =?us-ascii?Q?uCDAZCljPmXRJ8dw+uGBPtQMemm90JyyGVulIQgOskNUOM/mA3Wwxwmq9xfe?=
 =?us-ascii?Q?Zrq7we/dmNARD1/fhs9DtICoz2y7MOsp0jtK7cGouwU9u+8AIXGowffBB9AW?=
 =?us-ascii?Q?EaXR/PfziQv4yjeQFPuSrJOIIB7xePUdeunzEgbmVGZFGzGNBh+uMMY1C1Ux?=
 =?us-ascii?Q?PdoJ43cyKtucrIz4BqmFTxx2aMRmmxuN1hKoKGazIdRFQysp8FuRlTNBRTqZ?=
 =?us-ascii?Q?N7yDCvL3N+GWXSfZykHR8sJ5dGAdqatib/BojJIOCLMkSaI1AmSba2Is0D1t?=
 =?us-ascii?Q?undqDn0I+f5F6H+CeSyy3XrJSrsFav7dHr2j0Kt9q4dP6IDC6m/gNWpD8hoJ?=
 =?us-ascii?Q?BSZNk9ufbgZi4cE/UQR2Xu78nLvDFzOVdWf1MTDPwSUK6Ub0ufj8W61Bgbmm?=
 =?us-ascii?Q?I4rOlm618eGxicdWd45UlyhNqs4z2tU9VZZIODbrYs/ZyFiitTLfwsYSwPmb?=
 =?us-ascii?Q?xBTNAJlUvhzemGdd7tSiDXiwz8bqDvT/Lrjom4SXEZtuVOmH6RvcL2olL8n6?=
 =?us-ascii?Q?ibEa9QH8UI94aC5jynjg16Xmbk2kEkvxbFqUHF+J/sR7binw1z2IV55cbe9x?=
 =?us-ascii?Q?YuiaxZTQ0lxwoaCPCeFRG6rzkvKXegtj1XgCh1ES52RnNjDijf7o4CEHsCjg?=
 =?us-ascii?Q?4J5DYXRChqZrkeLO30z+K0wITK408qLj5aFWT9F43HfOPJSkUT1AxgaPjZeb?=
 =?us-ascii?Q?PJ/68cFpvbtgCFjOx37N8KcchnOzAY0xl0+xScLM/KHI/Pph9Y9UZi+vMEiS?=
 =?us-ascii?Q?v4xbLdw7+zznm9AWtuCAyp5OJtQTThzMbm/WTIcmHN5RsB89N7UJvc6UZW40?=
 =?us-ascii?Q?sZySQ8A4mGN46WPDD8gvi7Y5IeA9wGPxOZaVyt1STDprlC+XzoXEF+HVoqId?=
 =?us-ascii?Q?ZWErWvOZbTAKqamvZ2YZOcQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	e7WorfCG7GqaWfOFtM1LsA0vfJpConm6cx0upBTraJuLWRRz0d/YLVPpbA9AfpAf/s89TPvqlbovdquZs60SFc5hV6RZJd0jq8UVg9l9K4BHfTqgHbkAfyL2zqM5yI89BcMz7ZfUSQoZUUpwq36h0d/1cLMcIB7jkiPuDniCUyrbEqezFVywM08DTmCPiTRJ6ccQjP4EcKuk3yM+vxkTezyttc6wkFYfjbDR3l5e3w18psDr/9vYrWd10cRmTubecrwyi38vXsJU+UpUYvXr+pZ2XfHOd0Oe4hctpJvIkmDjAEJNEY11VavPHuLfoPVOBbAQR+e9c/MRnJxzIMKkW7tBjxNORN4yZMMwcXQ0lHwrMd0eXjO9C5LQGxb02QbBxnN9PwIqyK87cnkKmbEYX8peov0hrZx7so+HE8llTCAXTn02A+86zzeWqUKQC0SrXhhLgKA/taXMj//HskH59UV4YdzDgfXB5ggVdGuZZ12r/t/zCwo7IlMSS8yr9sKqwMXt7ujvbWSCRuwjJsHlhoo3aW9MPKWCuqxRRQpT5f4eEpqKaGUkVqCo5YhE3Ncibddmo5ewK5AZufC2WLPWyDatLTt3P/2uUoBm9mHYTXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bf3124-c4fb-4078-3b8f-08dc8fd7f662
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:09.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk4QwZbOKv86JBfudNHhWo/sYN7bFT6A9OTZvPhvC3AIm7LIdpJD8WqRWdHf99g/xYgZGXrM8o4fuTCgCEOoGALAsrL5WsYXN+qwtrvEwgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: mQFZjeVucwtriD1_srfgYEISTO2A0VzB
X-Proofpoint-GUID: mQFZjeVucwtriD1_srfgYEISTO2A0VzB

Separate call to mas_destroy() from mas_nomem() so we can check for no
memory errors without destroying the current maple state in
mas_store_gfp(). We then add calls to mas_destroy() to callers of
mas_nomem().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 39 +++++++++++++++++++++-----------
 tools/testing/radix-tree/maple.c | 10 ++++----
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5187f0b19742..648cd003b99a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4524,6 +4524,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 	if (*next == 0)
 		mas->tree->ma_flags |= MT_FLAGS_ALLOC_WRAPPED;
 
+	mas_destroy(mas);
 	return ret;
 }
 EXPORT_SYMBOL(mas_alloc_cyclic);
@@ -5604,18 +5605,24 @@ EXPORT_SYMBOL_GPL(mas_store);
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
+	int ret = 0;
 
-	mas_wr_store_setup(&wr_mas);
-	trace_ma_write(__func__, mas, 0, entry);
 retry:
-	mas_wr_store_entry(&wr_mas);
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	WARN_ON_ONCE(mas->store_type == wr_invalid);
+
 	if (unlikely(mas_nomem(mas, gfp)))
 		goto retry;
 
-	if (unlikely(mas_is_err(mas)))
-		return xa_err(mas->node);
+	if (mas_is_err(mas)) {
+		ret = xa_err(mas->node);
+		goto out;
+	}
 
-	return 0;
+	mas_wr_store_entry(&wr_mas);
+out:
+	mas_destroy(mas);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mas_store_gfp);
 
@@ -6363,6 +6370,7 @@ void *mas_erase(struct ma_state *mas)
 	if (mas_nomem(mas, GFP_KERNEL))
 		goto write_retry;
 
+	mas_destroy(mas);
 	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_erase);
@@ -6377,10 +6385,8 @@ EXPORT_SYMBOL_GPL(mas_erase);
 bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 	__must_hold(mas->tree->ma_lock)
 {
-	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
-		mas_destroy(mas);
+	if (likely(mas->node != MA_ERROR(-ENOMEM)))
 		return false;
-	}
 
 	if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
 		mtree_unlock(mas->tree);
@@ -6458,6 +6464,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 {
 	MA_STATE(mas, mt, index, last);
 	MA_WR_STATE(wr_mas, &mas, entry);
+	int ret = 0;
 
 	trace_ma_write(__func__, &mas, 0, entry);
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
@@ -6473,10 +6480,12 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		goto retry;
 
 	mtree_unlock(mt);
+
 	if (mas_is_err(&mas))
-		return xa_err(mas.node);
+		ret = xa_err(mas.node);
 
-	return 0;
+	mas_destroy(&mas);
+	return ret;
 }
 EXPORT_SYMBOL(mtree_store_range);
 
@@ -6512,6 +6521,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 		unsigned long last, void *entry, gfp_t gfp)
 {
 	MA_STATE(ms, mt, first, last);
+	int ret = 0;
 
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
@@ -6527,9 +6537,10 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 
 	mtree_unlock(mt);
 	if (mas_is_err(&ms))
-		return xa_err(ms.node);
+		ret = xa_err(ms.node);
 
-	return 0;
+	mas_destroy(&ms);
+	return ret;
 }
 EXPORT_SYMBOL(mtree_insert_range);
 
@@ -6584,6 +6595,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 
 unlock:
 	mtree_unlock(mt);
+	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_range);
@@ -6665,6 +6677,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 
 unlock:
 	mtree_unlock(mt);
+	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_rrange);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 2c4e69591235..175bb3346181 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -119,7 +119,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
 	mas_push_node(&mas, mn);
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL); /* free */
+	mas_destroy(&mas);
 	mtree_unlock(mt);
 
 
@@ -143,7 +143,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	mas.status = ma_start;
-	mas_nomem(&mas, GFP_KERNEL);
+	mas_destroy(&mas);
 	/* Allocate 3 nodes, will fail. */
 	mas_node_count(&mas, 3);
 	/* Drop the lock and allocate 3 nodes. */
@@ -160,7 +160,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
 	/* Free. */
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL);
+	mas_destroy(&mas);
 
 	/* Set allocation request to 1. */
 	mas_set_alloc_req(&mas, 1);
@@ -276,6 +276,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 		}
 		mas_reset(&mas);
 		MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
+		mas_destroy(&mas);
 
 	}
 
@@ -298,7 +299,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	}
 	MT_BUG_ON(mt, mas_allocated(&mas) != total);
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL); /* Free. */
+	mas_destroy(&mas); /* Free. */
 
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	for (i = 1; i < 128; i++) {
@@ -35846,6 +35847,7 @@ static noinline void __init check_nomem(struct maple_tree *mt)
 	mas_store(&ms, &ms); /* insert 1 -> &ms */
 	mas_nomem(&ms, GFP_KERNEL); /* Node allocated in here. */
 	mtree_unlock(mt);
+	mas_destroy(&ms);
 	mtree_destroy(mt);
 }
 
-- 
2.45.2


