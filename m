Return-Path: <linux-kernel+bounces-255626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C7E9342FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25EA1C20D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935218FDD9;
	Wed, 17 Jul 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AE29rS9d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mefy1aLO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126818508E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246880; cv=fail; b=VYj5kKe1IqVnSg6wfbtRWzVCKnaO8kdh9xoA9DAVKJUHaUt1pNbAJr9iXiygisLGLjBN69ddH59FtoyDCA7V7CzVKfnGPpjT0iVpYFfKnHslGv3PMqq4MTGYENw2g+1OdWdtdM4cEuxMX5cJ37uOE5QJror8FF9wpr4/aU3wkT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246880; c=relaxed/simple;
	bh=45nDv9T7y87NEtN0/HcR4bAqsQL+M2hf9dWj6Q9nGJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rYIgwDXvfRF9I2f8Tzi2Qew2gV2/EZ+F1VCLkgzwA7zoVLDqjEM619NjEyANGIbqohAlbjyoxXZpmCZfqhiaGWc/uK1YzOiBKrWIdlJRpgzFeFtGm7zArlOdyXTMKoIDyvyfec5rtjfNJ7GeU0Qnqhv3kRuzhc1ZH5C1+O+sT8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AE29rS9d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mefy1aLO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJu8A4000345;
	Wed, 17 Jul 2024 20:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/B8O90wsTqrG8aGCnP35NaLGvZW5iIPaZPRpBTO3Ycw=; b=
	AE29rS9dWRNMzwIHxueRmLCZ+Yo9Z5rzITMthaioavtn2a3hWIZANYKgKwZSBHcu
	iOxsg5yZGcC4n+ai68b+zpOdaACTp6wZrpSZEEv4jFn0rw5/j7Eqk2OAvNPwaoRd
	LXbPBbUiEdJxwYs9fdf/d4SdLpb2hGdBajGHF7y6eoGd5diCP5IR7AokMeO5/5Ry
	CAjODzFpI5O34u3UkDFitNeebEUxgr4L2EN37V3cgoEtgfb/rTECNQaHmoGwLl7g
	/5rykrZfowawV+HVHJO/9f33BaB1UD+QSRQ6WlivrNHebt3d507JdEo+mCh+3PfV
	W80pFUYIOfhCkjMWYDtshw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emhpr0qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIoUnx003734;
	Wed, 17 Jul 2024 20:07:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweyhkk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8MfxNUMD12fP+cXcq29wIdNu+VxasFyhg35DGf4/vGcrbCTlNOCMvyAPkQl3fi8mCUS/zJ9tAp/zFy+WXWPWwZQCJeJBHcc3Pm+qMWb9j1E78PUuZL3hRMgyGbZUoh/q3cJGWejdwhUqFkLKiD5QidHAN1wS0GVcSOI2H6gPtv8NnPj9pFdsiQzXyMYTGoOYQGZu3xp4+lsl2CgcSKBgIn6/7k/64UKpFPSaZMcKQNkc1sws20yXWOFB0eJNt/5Q+EN66IG/HUtONlctMmHedSaXnASXVeoqXEZEpAB6WNIJLk+PuX8KbYKZeunwXw/VNq3F8TxGn83b51UN2xeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/B8O90wsTqrG8aGCnP35NaLGvZW5iIPaZPRpBTO3Ycw=;
 b=KRKMiNmeRvS2x8brdxuw5gNHDXyMtgflY1plQrjFtfbtbBN1/386rQLK9gyTutW6OXD12mEHCLfg05DpECLS7TKVwH/GLMlznnjqO5kJrObyTYlRr9JUBe4EYetqhaRhBl179ZatSA33TxW/ULVg/gnx0Rt/6hcIfsdCvW4JxtH1QI2luJxIwjkyzSxfRiGOYG0+QHiDjnYoV9lSZuXE4ijzlFVFjXJ8ILZvSwU4zNB4zsekzkynxIHXNNn/4Gr0UgpXePnmoVm7CLfrbQKRxrKVVoovv5W5w99pV3XD4Cy0m40pd4iUv4b55Gmt16BZmdbDSX+QinIzi7dogl6LQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B8O90wsTqrG8aGCnP35NaLGvZW5iIPaZPRpBTO3Ycw=;
 b=mefy1aLOQDbw6FEsfMVG2YZ8VI36CITvKjgSJM9wKdPM0WFrHZQPdZ9UuSLbrvzBQry5U+J+F4y8MkvPWGTsyR7X5pJwYLeTKgIi9TgSBBLVKw46qCTNWDopK0/Gr3lWSxHIgXXP7la4sLIrrD8CYHQEHX5+pW3Wl2iuuAKDmbk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:07:41 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:41 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 13/21] mm/mmap: Clean up unmap_region() argument list
Date: Wed, 17 Jul 2024 16:07:01 -0400
Message-ID: <20240717200709.1552558-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a597975-915e-4510-be67-08dca69c1d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?J5ev+TkQCRJWM6Wm2bxTsIJJ0guU7rq4uKLiU8zIz3lo+rYLk+S0Vqp1Lcdi?=
 =?us-ascii?Q?tGmvxmM3QTTYoPFKF7CDizys+Iq4/Fdvw8sfyZYQ3I0W9KUlHrkWMoGFvNNj?=
 =?us-ascii?Q?StzbJUlt92VqjKHlROJ67pN0wNdry2z5wD36apBpyChQFYjXebTGyoG1fV+a?=
 =?us-ascii?Q?6U+OdvvfQQRvFHfkwLkfNMQzeZ3dphDZrw9zhZSROsunC9NRz5BL6uhq2HpW?=
 =?us-ascii?Q?bvKwTk6zs1G8Lcj8oc0kGGQiC94qEYSRUkA02jjsE/r1E26Djv4kJSR7rkBK?=
 =?us-ascii?Q?AAl4YE7f7Spm31EAUoJmWpaNyvTXGHIuQ7uaCKAnzclnam7ee9eyqK4/cckk?=
 =?us-ascii?Q?rm+rjapyc+/k6ZQXQQXhSFH5oQTr+qwpCXSkbMVBMmWw6MiypPEUAFoQeIrH?=
 =?us-ascii?Q?RRCJEgN4uLqPPNOa4AVjxHc5vrhncPtvOXC/VbUsGZhwrQ5OICNGnzCynEs5?=
 =?us-ascii?Q?+SStZ11yHnkt7WRvNQ9c4xvtH2doGikwp80FbJmk6Sgy106ZZMkba7Deypzu?=
 =?us-ascii?Q?VxTA1vOJKFZzQ7qMloVostt2l7x1c08rg2eVH5VPZwsRQUq04adl7QK2ika4?=
 =?us-ascii?Q?3wp0zJ4mbv8R3CIv0v5ZaUErdINMmO5yrxg2ctgPrKPfCNAnMqJpoNy49Xn+?=
 =?us-ascii?Q?E/Cf/JR9me0WT1vkmZIFYFo94sOLnEjiiSluMQtTWc5HFYs/Nr69blnFwoGd?=
 =?us-ascii?Q?tJXJVigrBjE1cx6Ys4SUHdLdBAe35SsKb2r26hTwUsjp3JqN68rEiae1Ummn?=
 =?us-ascii?Q?go4QSSBMiiyP8xDHze6UqiKkRs7ZhT+8AwGjXauqSVimPZNjXWgXs6Em/NqN?=
 =?us-ascii?Q?pBUwqefkk0sC1cVVIvGw1iPC+2b6y+jQXx8a2S2XoU/sAh4TH1ZiG2SOnSjs?=
 =?us-ascii?Q?qDFfTPn+tDe+CowSv0xNs01EPz8y2RWgK3uYDGQeUfSNqet4sRfTKRgMHSau?=
 =?us-ascii?Q?JjJqjTI/y/KStpyPIWku2WpfRAfwnQHMrk1YMXyi8tZsAbkz4ISSrjtsnX6h?=
 =?us-ascii?Q?JYmO8S4XwrBXPIr6rpycEt0Bt7z9IhggKXi8a6qIFUm2MyBim5LUKtCZ1IUy?=
 =?us-ascii?Q?Syn88s/337qpZeUC1DwM1Cn2bUT2qNvSevHRQIAW3jYvQaPV6GMy8tp3h6TR?=
 =?us-ascii?Q?rr8F1PtXlcfxmR05/lbcyydf8bJkfHt/CNEpWruMM2G47mMLYoAHK+IhTh8A?=
 =?us-ascii?Q?nzfACPJrC8GRmKrl5TEviizVlJojKWsAn0sqdZMbb5J79qK6yHrg8INVdpbY?=
 =?us-ascii?Q?vgWUXRgFsX2ezzYb4vBMnMjaZ83rl2yIdvGazazMQpwAbHfQrm3pv1dobMK3?=
 =?us-ascii?Q?cyh5aUTKMHGT2QSPQK2OLy48rXrXR5xJCDLSwsA3G+EchQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5A/uqbb/VQ7nuVWmspHKeWB6AbBAPqldn9dNHrGRwH/V7q2Km8vRtBHYUEi4?=
 =?us-ascii?Q?HDlbVRWrtXfwqinGaIL1z4tWa6UXIbX3MQaqW17kY/UxNx/Y6vneyueJ2ciI?=
 =?us-ascii?Q?XZYUBCnQT20qtii04IUhESiShWWJiNcT5xoprUSZZjJN+9A4riSfo8xPcsI2?=
 =?us-ascii?Q?LROLgdc+nMl10QXWX8qNBr+qci/XjSbbJ0vcxZh6O05fNTxuacuRbjgG47wi?=
 =?us-ascii?Q?HgmKy4CLaPqFk4TyIGnyvVC/6M8g7QJg0JeaU89o1k+NvtePwYMzTyejX3s3?=
 =?us-ascii?Q?RYmNfLUrq+8hou+mdoxUAxfJCcxByt0OJdtBBN8KdrbrHUDTFyZRJ+r0l/ds?=
 =?us-ascii?Q?r/nI9eOX54DeqDRzDfUOdKdDc+Zxu/rLhRtTj1EJCWGvf+bzCVKSses6qoWZ?=
 =?us-ascii?Q?NO9Uh6YXE0y4/AO6Ssmdaxi32ZNIjE4NsMXhR/E7SnBW7LbZna3SvQuzT6FI?=
 =?us-ascii?Q?5YxlZQxDqxvhaLuGy7oJn5YTdoI6MYOR+dgm5c9gjhwpWIVvsDqRhFuRm3QR?=
 =?us-ascii?Q?IKxJCCMQLa37fUIUMh/zQXAyaXNNB/IoBVlAxlEi3pH9t4GRUUM5HtboU2Jm?=
 =?us-ascii?Q?zs70hPrYHBcV2v02ZKuF5qwAkqFgesV9DBRzuMsB/fFlt6jzPcN5ZW9BVoAN?=
 =?us-ascii?Q?ioXEPVzq0ftIV1XBKccFMIuFzjoOn3uZk+PPDfkd/02eYpHxHrZ/312pPltE?=
 =?us-ascii?Q?35Y5MsFjwR8kIPEuoAhurnCB5j/d9kqnRspY2xXaVRyIl9Mydvqf0irUTM8S?=
 =?us-ascii?Q?EYc+H+6eeV9PXHBfM9qS9Geso1gMqylBcuCjvXXRf1X0ooEBraXROcxffbCA?=
 =?us-ascii?Q?2ltvcMwm7yXLWMe9TwkXPuwIHzs0uHzfyAImXDb8IeGhrXxLBp6YNIFt8pZf?=
 =?us-ascii?Q?xbb91HGO2BFSp/cyriZALdXAgZZYq9go6UIiIn5XJX7PNBsrPrHAm7ZduhTe?=
 =?us-ascii?Q?YshLxO01WBfrLUyoJs47RyvA2GrFOl8omMUDeoW9ce6wjqgWGw3UMTIk3BPC?=
 =?us-ascii?Q?8JqJQrO0Yn5IGhoL/fQnTAFMfvOBDVP7D+UP/pcjTS1I/++OHaJcm87i1JG/?=
 =?us-ascii?Q?gjsJs/5bkDRNmeeca5Bi0zj6oM64nD00l3l91ulJc6G0OJ/4Vc4xq7JXRCty?=
 =?us-ascii?Q?oiAEnYRacQOQGe3lH9fEOQpH17+14RAE+E5dJ3x7VSnV55ZKVqyani6zUk59?=
 =?us-ascii?Q?LVMugrdDk49BaQIvvpj4a95AxED3kxnME766fOyalOQphQTZr26fzxWz6jNn?=
 =?us-ascii?Q?AO0UXA8dp26q3NoJX+TFNk0HvCq5KFEGsH75a3Fr9SipYHNujTqmfzZEj2Iw?=
 =?us-ascii?Q?dhjer/+mz26Q7JzPSWh7rulhbeES4/yuGjK5PZv/9es7idqZrJCBQCYAyZXr?=
 =?us-ascii?Q?L7/rq1n7xp2cGIaPrtAmA49bDBDYCLZilfsLOCjyrmh2fCFMdNjlV1/VrMGd?=
 =?us-ascii?Q?X/IUoS8Vl8ky0GlVYYX9DDmgEEHnV4Hc6traLIyTBrcGhmWCF04vkjqHoiba?=
 =?us-ascii?Q?DssNU3cKZn5JZQy2bkoULxwV0jmqHbUGxIH6NW7iIX/k9duE0HOGHR+H7O8K?=
 =?us-ascii?Q?g30Vo8FE+oq8m5DIAAieLPq+Bor5aeLrxI7JBMcVvOJ3Mq34B4pVCCraHcDC?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gl7nqdsT3gwt8IUBYKr+M9ovsiXilqQwSK2fp/fdIPO1amN3/cEfC/5jZcUKXOpIE48rpUeIpkjgnQVn/uhLV14Obh/jqdaR8myIynxP2Ro6s+QCGVZSx7ewS6ziGL7pXg0K3a0AQIlbtkStbtKL50nX4ukL9sR7TYy1xxX+SkgynrFe4ENLnIEkZ219vtX4PVx8gC+Qrk9wwAYh1e6plJEITaVeaiucAuc/scx7lbsFx5sBOatV2F94SIYrCZ1T6LpP6jhWfJnO4JH1pSrDIQZTcXSfVO7NtArve6ItYWyqP/y8eNdtHaXAIgQMY9WdDLLTiL6P7Q4L5uFdtfYy/+JCOxUWG5upPhOKhSOX0VK5moE5eLZFWU/TgK7Kd1qIWhYxqkuEeuXJJ4+s18hMadw+wdISbUTGZ8Enh9ZmWRSCljssvXUSdb/kK/ExSBq52VQqNiNi0LymlQudgKdaG6pDkqkEyZSiCaGL+dRPxWDiEP2OuZ1ct9u/qePIATvkuAoj6NZ0DeNOd4AskN77txeqLedBertknJlEu2wmRrqd1rKxeqYd3gZpGIePIL3k0banOgrwIZ1bsPE0CurNdU8LF4ssr27GlyV7kjBSBRc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a597975-915e-4510-be67-08dca69c1d1a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:41.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNP4b9aR35T+oNFYzieizH3+uPQqRlrlcgjFhtkzhbBKfK//4XtYk6V7AEiCIK9xt8vcbX2QC5tI+qL0Ye0w/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: hpCF9MCQ_rf2aE0WeE9MRVdzOzeNlq8O
X-Proofpoint-ORIG-GUID: hpCF9MCQ_rf2aE0WeE9MRVdzOzeNlq8O

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

With the only caller to unmap_region() being the error path of
mmap_region(), the argument list can be significantly reduced.

There is also no need to forward declare the static function any
longer.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7cc1f47122f6..20da0d039c95 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -76,11 +76,6 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
-
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
 	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
@@ -2403,22 +2398,21 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
+static void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather tlb;
-	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
-	mas_set(mas, mt_start);
+	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
+		   /* mm_wr_locked = */ true);
+	mas_set(mas, vma->vm_end);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+		      next ? next->vm_start : USER_PGTABLES_CEILING,
+		      /* mm_wr_locked = */ true);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -3198,8 +3192,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
+		unmap_region(&vmi.mas, vma, prev, next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
-- 
2.43.0


