Return-Path: <linux-kernel+bounces-274636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803BF947AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B67E1F21A01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0864157E8B;
	Mon,  5 Aug 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X70FSOps";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KKpOThSs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86715748D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860109; cv=fail; b=nF42NvErODQ8zeMFyZzHwIUJJJQecH0hQhXwsmlUufTHg9S28MfqkEWa8vjhMNuv+MNK8EIHa6CToQEu5w1qYqolulFLz1+hdNxOOkfzryz+kvUIPTN68BRTTiY08rqgy/vlNftna4sHDR9LcCPHAHt3+dgFCtdlXp4WkoWB8eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860109; c=relaxed/simple;
	bh=jcrhgX6FxWVVAdsrzPD3IAsFQ2zDSazJ6cYoidTUlzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAs+ygDKrRWKnCu6xA4ie56H8BLRssLFBHJf9SCf2BrpglapVObchQVpQaK8VSRry2aYDm1VTWe6RlaSVipUOT6NqULGInBgUP/n/4k9dgrcXcKf7vA6JbYfB+0mmzXT6uEkp1KOTJy1aiw0Sf/agMZ40ZWiwZQ4AwgklvZO0eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X70FSOps; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KKpOThSs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fbAB027532;
	Mon, 5 Aug 2024 12:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=kkI6NNI0jXsxFrPLz75VTLqEXdGgi02HQ4yO6eKoi5M=; b=
	X70FSOpsna+kzk15V5WOOIAGsGM0A5Vj2XRKn32xYVr9ARFyVJftPAG4amZauQv6
	coSKeFOX2hVB55XzG1viy7/oyVzZPWo3tqOq/Yzbs/wBsd91WyKLD3FQ3/OOSi7F
	d5fEYEgXcuYcJkH4/tO61NZbCB8DQjHkn7ZKeuz//MHtTKvyOoGrYaMCLB3SNZq9
	iZPi418O3ClwXHZEtO2xx4W1nWusCa5ptd8IEIHS36TpMRjaIlw6EQRE1XYhcTdL
	gY7PiucOYSXEBuXmuT/n9lzlkjL4xT3egrOKTIsuf2VABF5w3NSxy8EhDshS3yoY
	VkE3MSuH3z/jzfSrIYkgKg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfajgkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475B4jDr004673;
	Mon, 5 Aug 2024 12:14:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0d6qsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKxYY564DvbI+nq6bJuKUwZMlYv4WSWIfwcSu8yC36jorLcMa/0iO5wM5OAR5G7GWkXlvA8Pz1i+l5woQJ+0Ckb/1I2xZGDtpZ9j3qRrFTCekg7lKFf3mZ0Lh2UaOtlBAt22JhNIMjmhMQ9SL2pKU5NYNoMY54hL9Bz70LdNy5IrOSLt9H+lgOmFcCh/sYLdCAhlneRlL+SvvP7rhWUo7NnMaCOa3hlMn++Vp2U1qkAUvs5aJEa5N2N/mmNGLtk2Lt8af7Sm7ONxlQL8Nsy1ziJcwcy6Z9HFCW3rBaHAGGJYX0mU4UFP92+MfjfZNcUkK5Mp7TDdBWf32wRCKBiwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkI6NNI0jXsxFrPLz75VTLqEXdGgi02HQ4yO6eKoi5M=;
 b=bOMR4UgxJrzpwjf45D2Vl9dhjMS1BFKcy7ck/+1VLfQkw1ivGKq1f0oH3dnReU3bqeWfAcXhL2dyxIEnknDbbnFutGOwRqS367D159qm1tpIU53+40W9GB4dnkcDyg3WkxvEX6hBFKPZ7QDqcfH83/acPZJ2tFUU3V8sEDE68XmqRBDci9ApGLb++FeSjVm5A4fqX8Thksa6UOxO9ERWgPWNNe7GvS26RE7zB1QUxhzZ1IsVl7p00iq6Agmzlodq7NX/uEGx1sjcWToDs518zzo2+5TqTk3H1xEnZ+Zs7Vf+ilL80JejjzEFa/yJ4z/wuYOOJPM3SKr3R+7msv5giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkI6NNI0jXsxFrPLz75VTLqEXdGgi02HQ4yO6eKoi5M=;
 b=KKpOThSs4MKe2l/NGjJlANsc1BAyUHFaKyLCu2GW9ybgjF6D/Ddkb5pS/MILIBSdCxB5dd4qChhO82dY8XO1QWKI6J2JGSG9FQLGoP2r7CqCydl+YjxKSWArr5NdlA/IhDcRvLpXtkcp9TzBLASBAm2HnlURAhT/V0/ag3SsXxU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:49 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 10/10] mm: rework vm_ops->close() handling on VMA merge
Date: Mon,  5 Aug 2024 13:13:57 +0100
Message-ID: <0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 040b5a69-ebf7-434c-0f83-08dcb54833fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uKTxr0Xld4oWzfjFaeIqK0Vj9+O4GFYsM0GFUZdLMPSqJ2dtwJRHD4Th10gO?=
 =?us-ascii?Q?Prl976vh4iWzNeyN82hlWBv4XsEExKd03phTD1FsF2XNN83+/iqVa8+7zo3B?=
 =?us-ascii?Q?l/+mT7nh2elzhRQ6Som4sWR+lnDBMnpYqiqWk0C7KTttHVcEMNyO9Lst5ap+?=
 =?us-ascii?Q?2MbE/JqFADvpXHS/FTkIse1jrRW+EZTBXOKGHedJ6iJhSPBG32CeDwd/J+FM?=
 =?us-ascii?Q?edM55hV2kQcSDzbjX13ZpVp3PBMi+S6prpP05XmDTu+JcOYZu0rFuXeZtVUg?=
 =?us-ascii?Q?QViZY2T/yjQBxXnTtOudVEIReVKkj1dvbwxyLhT5AsOHkci4gRCByhznCYE1?=
 =?us-ascii?Q?3UvsgXE9kZr7+1gzoY5cwVBkKVKaWRGb90Hh6lx1FqlP0XnZ+xIDX8ByZGqM?=
 =?us-ascii?Q?V23dXKJ1biY61np3tbjsBdZIQ/TWkbZR2NnGXV9W86kH+FMvumJmzEPd3B0R?=
 =?us-ascii?Q?zE004Ri2lOWq5QyzyvcVMJAnoQpIcMrGD59gs417tBTAUH8rpVpA9/JiWN38?=
 =?us-ascii?Q?G4V6NSBoA0F+P5s3OJNbE4eqUTXQMHpTTjP7CrHlFjsjRCGTZHjCdrTcMTgM?=
 =?us-ascii?Q?3kvjJHWQID5lq5Sx4BAgb8ZUVP749eI3P4vyJ5in5xzZNDC81tZd+KvXAAdR?=
 =?us-ascii?Q?YGlBeX61xf2JtJOifmN37fRJv2WHL/n3rZkBOVBHSbde7rJpUFpehD8kGyod?=
 =?us-ascii?Q?emYUOdGIs20EeODnQfEZJSrbum+MggT1yExZfdNmp68j6lwHu4hz8h4c0i+P?=
 =?us-ascii?Q?j/SQi/BbMbspueEsU7qoiShUSYTs6SdzXbhJzBV00Gn1DkZMF2SQN7w+Pg12?=
 =?us-ascii?Q?K/2NH/EWSbmQxG2XErMQBWtyv9Da4bVttg6pzshqZfEmarSgiuSVT5C6IvBK?=
 =?us-ascii?Q?7vU8UXxF+F6aAgyAoV8HUhS+RU6/Cwxtg00T+gRHp2Nh6PiBlH/7qdsICwtd?=
 =?us-ascii?Q?w8F/g7O5urJYAnzuVx/rslPyEi8FH60wYpyyHjIqznF3AR/FrZKtWA3AFV3l?=
 =?us-ascii?Q?9cdXUwQFetwmnx1NzcxtfHlHPquyjcgTPvWbImYDsIsVzjI0qmkQwDBl+I/r?=
 =?us-ascii?Q?5J2k9GO9wcuPM+Irj3xwJbJYhjs9A7J7NXea7Thr58tiX3TGMDISUmH92oQ3?=
 =?us-ascii?Q?nHEq98X++z+UVRC2BSk9D906SPZn+tMEbhDknMzTz0cDp8T+f69hgYwP4qZ6?=
 =?us-ascii?Q?8aUZtAd2PwfFocXNKrctxw5aA5P4EGKHZh06y1xqZDOqDmS80tB0Hy9Di9hd?=
 =?us-ascii?Q?B9+47qcdwuuXG/D8myZJmDLy0Dsl6f4C9r0gARADRz9b4wMK9ynf5B6Z0LFW?=
 =?us-ascii?Q?nBLo4KnFnvU8NO8Ir/GG4jdpqUqwh+kBZsRKh5PDwq+UPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yre3cDxn5PdVrv2LxusvIyo/bdQNFQeKUw6ETx1hQFQlS4cHtin7o3nkek8J?=
 =?us-ascii?Q?wv1ndlZI5Rn8AAuqzfDGPmNabdi0wSUO7abhZOTCNC+1eiYYMqz9GyU1P6mB?=
 =?us-ascii?Q?nOej9Q4/S5AfAsrDUygM+X2Pw0GWtpRKAOfFidW/BjrYiCS33o4G+qgP0erW?=
 =?us-ascii?Q?2vJddKtJmbimf58sCbMFE0Y6pYmQ6Q3VMk82SMdPjvwTqIs9oUN/r9os0eLa?=
 =?us-ascii?Q?jPg6CDg/m/AuD3CicZCYLtWto+65/Uk5VtxwGpRqLJmA0x2xZtM+wSwv7yt7?=
 =?us-ascii?Q?kfSRENghk9IwjPbFXslh3Gue7ZHPWYuBadNSZ6SYiwNXkyowcdEjcSx/X5rR?=
 =?us-ascii?Q?EXl60Ed87aPlstBVmiKwAIagVboh19D1lCEwp9CAQDhuPC4/PsrRYgq7ofx7?=
 =?us-ascii?Q?4PAny8L1snhH+K/J/G2bINIHnfibyXHnuqF8foS3h02oV6bYuKEPtAzseMuV?=
 =?us-ascii?Q?4uvJHtQ3wxJzoXAK+iEjlnDZKnxHbw97hy6K1I9oT4TaoEWl6yw7t+CXoUX9?=
 =?us-ascii?Q?f1m+HapJ/HExpFu5t8yzWK40uUSOEZAw3Tiexa6lEhrdxLrC7WhyhcJa2T12?=
 =?us-ascii?Q?VPW3uj4aSmGBRbT4vCFAL4j4nd29gKmPsYKMtViejfwgOYd9qeVrqctCspuT?=
 =?us-ascii?Q?KLEMCJ4QiaWSr5x+O0MOo3iMD85qZzrXZOtN7f1cI1DWCEwUv5jANhO97yy1?=
 =?us-ascii?Q?SG2vRzB/wCeONdW06i2k1t2ojUtE7rbp4ya4WFpU/8iRYOynFPaZTxBbNA5o?=
 =?us-ascii?Q?d3c2KE1MIHRKBzl+Tc7xeS9m+yi2IyRqp5kirXDwbuDUQgEvRWcx4dFpKP/L?=
 =?us-ascii?Q?tXrUwLGZLhs6bE5m9Fs/eVEDzVExz0AM+i1bDncYxW6br6+OiStMEjGizgzq?=
 =?us-ascii?Q?bcqVCPLZXVK/zo/BIN3V8g/NOdCnTs33kxbttyB+FUx7TOvBKKRSooONtP74?=
 =?us-ascii?Q?MBWQp9ENP6LxizqS9LwD5WvSNYFhjSzrmabATnmv7EmgI+POj1VY0+AxuKEP?=
 =?us-ascii?Q?A7dlX+/uMHm/exQbiTPhauNDgETlIeW7G8TqrcCNpuzcPZeRQdtnMAw+izEO?=
 =?us-ascii?Q?k97e/Q+MeCFtfeSI+jqjMMSW/ZhrmCK9LXcxXXHmWpDkzND3wHrulcMf5T0k?=
 =?us-ascii?Q?1grhN0v5jYQOPTFjhAgivgVSsbIW2aud6WJHRq3Ma5BnaJMdJ2arFa8Ld3eY?=
 =?us-ascii?Q?QDpX7CQdczzdpT/HD6WyQNy3NXN0Fw3VhNWiiJRsJSlxRmkdsvb0ljpZ0DfK?=
 =?us-ascii?Q?HvQUwf7RB+Z2vf2b9N8YY799DOrMFU0FdI4pvMFJb3WPGGsgwuKDghcuyMXH?=
 =?us-ascii?Q?NDHhrn2gpME20L/hLcF2JIOublBOQNnzpUzjHuq3+omwhPDqJxUolHp5aIlI?=
 =?us-ascii?Q?xk1Z/BzK4wMiaBi3YNzRWHxhZlHScvKgFS95eE3zV8GI9ECF9YxbjfPsBW2E?=
 =?us-ascii?Q?wA/OMWg1i96Jo/PLh31tkH3afUF4mtwIZPDfGC+x6qzxddzsuLyONSj+xXXV?=
 =?us-ascii?Q?OosaKrY8fgZ+h2ypHnwyKqPoj88upW0b3wOqIKhZwa3TWgTvoGaE1hfkyZA0?=
 =?us-ascii?Q?Vm1BfOKfAKuETJwnbjGSMkgDhn6cugjIg8kJ5SR7+ydewgy6sIYte074HUQX?=
 =?us-ascii?Q?ZSmZm+c7bnGTJiyPipsdZsyrqANbRKJzxnD3GF3jz/z3ZR5BmeAiP4tlv8Ti?=
 =?us-ascii?Q?Xw5j1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/nTLI+8FTonmP3mwke8/MugwagNEedS1ef7Pkw00ZO5X7Drql4GzzlbAp5MPp0dAhcI9mLMfk/R2PnkioXBJNBLtJShBsO8kxWOGyeUlvS0JzvKRj4VAfQWmcsZJlB4xmKDXbuWKbaFCnDZvr4wlWD/mAR6c1fV4DtiejLMPaYHUPCYz0ISNgSWtuk7z89iTM7FL+exG+pQJv1xh5x2tpUG2Gs7RiJ00jubht7QdYviQ07UsA/9Ho02O3eQYuspWJ+7ChbR40Kyjvbvjy3JPiPtgIsU4hKWbPzP+Btg+QAwHULH3bcVl45dezG9JO9hIPGNvQV7OL2KFlUKxrVuAKSkRdcqmXRijoKFNwtkyVB4CfbbDf8GmEaPbj8/dDmbBuCT8A4rpjraCL/WCk6rEuC+YXZ7pQ6DBtC+ylW+i40ArqBVdwav0OIwHfLoQ5KlthkpGiPcl6mlZLKoDTgpN58+mLCa4t/fOk9ZBlEVWKKM3ydTdompji4TFm9YkbHv2G0DPyOZCv41mlZQBTz7AJiQKYvS6AcbENtRjwzL0rWhMUTfjS7OKKKhSxmGEfDLKgadC4uGJp+swikxAKAOKBBL1PZLzQAu25XTTSwC6cGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 040b5a69-ebf7-434c-0f83-08dcb54833fe
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:49.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ+hiqfGmy9qcwqxDRWBhRAXH7h9XSal/vVM8VbwBV0RXE5T63DatWwX09jUykdptdfm2NXWcr00p/pEcX+31aKj+S0QEwdFV/mBIPlVHIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-GUID: rKOA1v5dUVHNKpVm3j_pxlc64ZMx3pVq
X-Proofpoint-ORIG-GUID: rKOA1v5dUVHNKpVm3j_pxlc64ZMx3pVq

In commit 714965ca8252 ("mm/mmap: start distinguishing if vma can be
removed in mergeability test") we relaxed the VMA merge rules for VMAs
possessing a vm_ops->close() hook, permitting this operation in instances
where we wouldn't delete the VMA as part of the merge operation.

This was later corrected in commit fc0c8f9089c2 ("mm, mmap: fix vma_merge()
case 7 with vma_ops->close") to account for a subtle case that the previous
commit had not taken into account.

In both instances, we first rely on is_mergeable_vma() to determine whether
we might be dealing with a VMA that might be removed, taking advantage of
the fact that a 'previous' VMA will never be deleted, only VMAs that follow
it.

The second patch corrects the instance where a merge of the previous VMA
into a subsequent one did not correctly check whether the subsequent VMA
had a vm_ops->close() handler.

Both changes prevent merge cases that are actually permissible (for
instance a merge of a VMA into a following VMA with a vm_ops->close(), but
with no previous VMA, which would result in the next VMA being extended,
not deleted).

In addition, both changes fail to consider the case where a VMA that would
otherwise be merged with the previous and next VMA might have
vm_ops->close(), on the assumption that for this to be the case, all three
would have to have the same vma->vm_file to be mergeable and thus the same
vm_ops.

And in addition both changes operate at 50,000 feet, trying to guess
whether a VMA will be deleted.

As we have majorly refactored the VMA merge operation and de-duplicated
code to the point where we know precisely where deletions will occur, this
patch removes the aforementioned checks altogether and instead explicitly
checks whether a VMA will be deleted.

In cases where a reduced merge is still possible (where we merge both
previous and next VMA but the next VMA has a vm_ops->close hook, meaning we
could just merge the previous and current VMA), we do so, otherwise the
merge is not permitted.

We take advantage of our userland testing to assert that this functions
correctly - replacing the previous limited vm_ops->close() tests with tests
for every single case where we delete a VMA.

We also update all testing for both new and modified VMAs to set
vma->vm_ops->close() in every single instance where this would not prevent
the merge, to assert that we never do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c                |  69 ++++++++-----
 tools/testing/vma/vma.c | 213 ++++++++++++++++++++++++----------------
 2 files changed, 173 insertions(+), 109 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index c55ae035f5d6..9c779fc65ba8 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -10,14 +10,6 @@
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
-	/*
-	 * If the vma has a ->close operation then the driver probably needs to
-	 * release per-vma resources, so we don't attempt to merge those if the
-	 * caller indicates the current vma may be removed as part of the merge,
-	 * which is the case if we are attempting to merge the next VMA into
-	 * this one.
-	 */
-	bool may_remove_vma = merge_next;

 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
@@ -33,8 +25,6 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
-	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
-		return false;
 	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
 		return false;
 	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
@@ -606,6 +596,12 @@ static int commit_merge(struct vma_merge_struct *vmg,
 	return 0;
 }

+/* We can only remove VMAs when merging if they do not have a close hook. */
+static bool can_merge_remove_vma(struct vm_area_struct *vma)
+{
+	return !vma->vm_ops || !vma->vm_ops->close;
+}
+
 /*
  * vma_merge_modified - Attempt to merge VMAs based on a VMA having its
  * attributes modified.
@@ -710,9 +706,30 @@ static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)

 	/* If we span the entire VMA, a merge implies it will be deleted. */
 	merge_will_delete_vma = left_side && right_side;
-	/* If we merge both VMAs, then next is also deleted. */
+
+	/*
+	 * If we need to remove vma in its entirety but are unable to do so,
+	 * we have no sensible recourse but to abort the merge.
+	 */
+	if (merge_will_delete_vma && !can_merge_remove_vma(vma))
+		return NULL;
+
+	/*
+	 * If we merge both VMAs, then next is also deleted. This implies
+	 * merge_will_delete_vma also.
+	 */
 	merge_will_delete_next = merge_both;

+	/*
+	 * If we cannot delete next, then we can reduce the operation to merging
+	 * prev and vma (thereby deleting vma).
+	 */
+	if (merge_will_delete_next && !can_merge_remove_vma(next)) {
+		merge_will_delete_next = false;
+		merge_right = false;
+		merge_both = false;
+	}
+
 	/* No matter what happens, we will be adjusting vma. */
 	vma_start_write(vma);

@@ -756,21 +773,12 @@ static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
 		vmg->start = prev->vm_start;
 		vmg->pgoff = prev->vm_pgoff;

-		if (merge_will_delete_vma) {
-			/*
-			 * can_vma_merge_after() assumed we would not be
-			 * removing vma, so it skipped the check for
-			 * vm_ops->close, but we are removing vma.
-			 */
-			if (vma->vm_ops && vma->vm_ops->close)
-				err = -EINVAL;
-		} else {
+		if (!merge_will_delete_vma) {
 			adjust = vma;
 			adj_start = end - vma->vm_start;
 		}

-		if (!err)
-			err = dup_anon_vma(prev, vma, &anon_dup);
+		err = dup_anon_vma(prev, vma, &anon_dup);
 	} else { /* merge_right */
 		/*
 		 *     |<----->| OR
@@ -886,6 +894,8 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
 	unsigned long end = vmg->end;
 	pgoff_t pgoff = vmg->pgoff;
 	pgoff_t pglen = PHYS_PFN(end - start);
+	bool merge_next = false;
+	struct anon_vma *anon_vma = vmg->anon_vma;

 	VM_WARN_ON(vmg->vma);

@@ -916,8 +926,9 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
 		vmg->end = next->vm_end;
 		vmg->vma = next;
 		vmg->pgoff = next->vm_pgoff - pglen;
-
 		vmg->anon_vma = next->anon_vma;
+
+		merge_next = true;
 	}

 	/* If we can merge with the previous VMA, adjust vmg accordingly. */
@@ -925,6 +936,16 @@ struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
 		vmg->start = prev->vm_start;
 		vmg->vma = prev;
 		vmg->pgoff = prev->vm_pgoff;
+
+		/*
+		 * If this merge would result in removal of the next VMA but we
+		 * are not permitted to do so, reduce the operation to merging
+		 * prev and vma.
+		 */
+		if (merge_next && !can_merge_remove_vma(next)) {
+			vmg->end = end;
+			vmg->anon_vma = anon_vma;
+		}
 	} else if (prev) {
 		vma_iter_next_range(vmg->vmi);
 	}
@@ -978,6 +999,8 @@ int vma_expand(struct vma_merge_struct *vmg)
 		int ret;

 		remove_next = true;
+		/* This should already have been checked by this point. */
+		VM_WARN_ON(!can_merge_remove_vma(next));
 		vma_start_write(next);
 		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index e465dc22e2d0..0c0a6ffcfc98 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -327,6 +327,9 @@ static bool test_vma_merge_new_vma(void)
 	struct anon_vma_chain dummy_anon_vma_chain_d = {
 		.anon_vma = &dummy_anon_vma,
 	};
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
 	int count;
 	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
 	bool merged;
@@ -370,6 +373,7 @@ static bool test_vma_merge_new_vma(void)
 	 * 0123456789abc
 	 * AA*B   DD  CC
 	 */
+	vma_a->vm_ops = &vm_ops; /* This should have no impact. */
 	vma_b->anon_vma = &dummy_anon_vma;
 	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
 	ASSERT_EQ(vma, vma_a);
@@ -406,6 +410,7 @@ static bool test_vma_merge_new_vma(void)
 	 * AAAAA *DD  CC
 	 */
 	vma_d->anon_vma = &dummy_anon_vma;
+	vma_d->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
 	ASSERT_EQ(vma, vma_d);
 	/* Prepend. */
@@ -423,6 +428,7 @@ static bool test_vma_merge_new_vma(void)
 	 * 0123456789abc
 	 * AAAAA*DDD  CC
 	 */
+	vma_d->vm_ops = NULL; /* This would otherwise degrade the merge. */
 	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
 	ASSERT_EQ(vma, vma_a);
 	/* Merge with A, delete D. */
@@ -573,120 +579,145 @@ static bool test_vma_merge_with_close(void)
 	struct vma_merge_struct vmg = {
 		.vmi = &vmi,
 	};
-	struct vm_operations_struct vm_ops = {};
-	struct vm_area_struct *vma_next =
-		alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, flags);
-	struct vm_area_struct *vma;
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
+	struct vm_area_struct *vma_prev, *vma_next, *vma;

 	/*
-	 * When we merge VMAs we sometimes have to delete others as part of the
-	 * operation.
-	 *
-	 * Considering the two possible adjacent VMAs to which a VMA can be
-	 * merged:
-	 *
-	 * [ prev ][ vma ][ next ]
-	 *
-	 * In no case will we need to delete prev. If the operation is
-	 * mergeable, then prev will be extended with one or both of vma and
-	 * next deleted.
-	 *
-	 * As a result, during initial mergeability checks, only
-	 * can_vma_merge_before() (which implies the VMA being merged with is
-	 * 'next' as shown above) bothers to check to see whether the next VMA
-	 * has a vm_ops->close() callback that will need to be called when
-	 * removed.
-	 *
-	 * If it does, then we cannot merge as the resources that the close()
-	 * operation potentially clears down are tied only to the existing VMA
-	 * range and we have no way of extending those to the nearly merged one.
-	 *
-	 * We must consider two scenarios:
-	 *
-	 * A.
+	 * When merging VMAs we are not permitted to remove any VMA that has a
+	 * vm_ops->close() hook.
 	 *
-	 * vm_ops->close:     -       -    !NULL
-	 *                 [ prev ][ vma ][ next ]
-	 *
-	 * Where prev may or may not be present/mergeable.
-	 *
-	 * This is picked up by a specific check in can_vma_merge_before().
-	 *
-	 * B.
-	 *
-	 * vm_ops->close:     -     !NULL
-	 *                 [ prev ][ vma ]
-	 *
-	 * Where prev and vma are present and mergeable.
-	 *
-	 * This is picked up by a specific check in vma_merge_modified().
-	 *
-	 * IMPORTANT NOTE: We make the assumption that the following case:
+	 * This is because executing this hook may clear state that is pertinent
+	 * to the VMA range as a whole.
+	 */
+
+	/*
+	 * The only case of a new VMA merge that results in a VMA being deleted
+	 * is one where both the previous and next VMAs are merged - in this
+	 * instance the next VMA is deleted, and the previous VMA is extended.
 	 *
-	 *    -     !NULL   NULL
-	 * [ prev ][ vma ][ next ]
+	 * If we are unable to do so, we reduce the operation to simply
+	 * extending the prev VMA and not merging next.
 	 *
-	 * Cannot occur, because vma->vm_ops being the same implies the same
-	 * vma->vm_file, and therefore this would mean that next->vm_ops->close
-	 * would be set too, and thus scenario A would pick this up.
+	 * 0123456789
+	 * PPP**NNNN
+	 *             ->
+	 * 0123456789
+	 * PPPPPPNNN
 	 */

-	ASSERT_NE(vma_next, NULL);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma_next->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	ASSERT_EQ(vma_merge_new_vma(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x5000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);

 	/*
-	 * SCENARIO A
+	 * When modifying an existing VMA there are further cases where we
+	 * delete VMAs.
+	 *
+	 *    <>
+	 * 0123456789
+	 * PPPVV
 	 *
-	 * 0123
-	 *  *N
+	 * In this instance, if vma has a close hook, the merge simply cannot
+	 * proceed.
 	 */

-	/* Make the next VMA have a close() callback. */
-	vm_ops.close = dummy_close;
-	vma_next->vm_ops = (const struct vm_operations_struct *)&vm_ops;
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma->vm_ops = &vm_ops;

-	/* Our proposed VMA has characteristics that would otherwise be merged. */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;

-	/* The next VMA having a close() operator should cause the merge to fail.*/
-	ASSERT_EQ(vma_merge_new_vma(&vmg), NULL);
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);

-	/* Now create the VMA so we can merge via modified flags */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
-	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, flags);
-	vmg.vma = vma;
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);

 	/*
-	 * The VMA being modified in a way that would otherwise merge should
-	 * also fail.
+	 * This case is mirrored if merging with next.
+	 *
+	 *    <>
+	 * 0123456789
+	 *    VVNNNN
+	 *
+	 * In this instance, if vma has a close hook, the merge simply cannot
+	 * proceed.
 	 */
+
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.vma = vma;
+
 	ASSERT_EQ(vma_merge_modified(&vmg), NULL);

-	/* SCENARIO B
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Finally, we consider two variants of the case where we modify a VMA
+	 * to merge with both the previous and next VMAs.
 	 *
-	 * 0123
-	 * P*
+	 * The first variant is where vma has a close hook. In this instance, no
+	 * merge can proceed.
 	 *
-	 * In order for this scenario to trigger, the VMA currently being
-	 * modified must also have a .close().
+	 *    <>
+	 * 0123456789
+	 * PPPVVNNNN
 	 */

-	/* Reset VMG state. */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
+
 	/*
-	 * Make next unmergeable, and don't let the scenario A check pick this
-	 * up, we want to reproduce scenario B only.
+	 * The second variant is where next has a close hook. In this instance,
+	 * we reduce the operation to a merge between prev and vma.
+	 *
+	 *    <>
+	 * 0123456789
+	 * PPPVVNNNN
+	 *            ->
+	 * 0123456789
+	 * PPPPPNNNN
 	 */
-	vma_next->vm_ops = NULL;
-	vma_next->__vm_flags &= ~VM_MAYWRITE;
-	/* Allocate prev. */
-	vmg.prev = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
-	/* Assign a vm_ops->close() function to VMA explicitly. */
-	vma->vm_ops = (const struct vm_operations_struct *)&vm_ops;
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma_next->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
 	vmg.vma = vma;
-	/* Make sure merge does not occur. */
-	ASSERT_EQ(vma_merge_modified(&vmg), NULL);

-	cleanup_mm(&mm, &vmi);
+	ASSERT_EQ(vma_merge_modified(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x5000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
 	return true;
 }

@@ -699,6 +730,9 @@ static bool test_vma_merge_modified(void)
 	struct vma_merge_struct vmg = {
 		.vmi = &vmi,
 	};
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};

 	/*
 	 * Merge right case - partial span.
@@ -711,7 +745,9 @@ static bool test_vma_merge_modified(void)
 	 *   VNNNNNN
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
+	vma->vm_ops = &vm_ops; /* This should have no impact. */
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
 	vmg.vma = vma;
 	vmg.prev = vma;
@@ -743,6 +779,7 @@ static bool test_vma_merge_modified(void)
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
@@ -768,7 +805,9 @@ static bool test_vma_merge_modified(void)
 	 * PPPPPPV
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vma->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.vma = vma;
@@ -800,6 +839,7 @@ static bool test_vma_merge_modified(void)
 	 * PPPPPPP
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
 	vmg.prev = vma_prev;
@@ -827,6 +867,7 @@ static bool test_vma_merge_modified(void)
 	 * PPPPPPPPPP
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
--
2.45.2

