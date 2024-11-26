Return-Path: <linux-kernel+bounces-422305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6046E9D9762
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210B8285461
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903491CBE8C;
	Tue, 26 Nov 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="RVqjWVAm"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023073.outbound.protection.outlook.com [40.107.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBE27442
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625020; cv=fail; b=kJCWIWTArbX6JDy2+lrRouxJ62WPCjymGBccndcyZdtslec85padPvuzchdPAmgHywvwEvXuvuy8UCsCnvVubJA8eDW6puODKypvGTiGq8yajasJ2OXwRThGOht92O07DRNmBF96zZ1zsHLNA40Rp/IGXKfCMUgG3qaAAlbEqbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625020; c=relaxed/simple;
	bh=CILyl1mom+gRkqCyHPhhy2SdOm62WWbRDWxpHK7ZnuI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WERMPhVxu+4pIf+p/XcT44d2FRiPJg7GsSJoya5F+R/G2VTn25Vgp8UbJG0KVOV3Hz9LlP2swyKT6gB2TgSUyXvlzjHTb+nmmUqgXmbb08hw1/TPiDn1n0jc1mY+HZMYutikLWeDIz1LW10q0ulyJIDVw8Rjul7Svw/547sPemA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=RVqjWVAm; arc=fail smtp.client-ip=40.107.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQopd5gFMlHf9uJ42ZcusJflXffU5Qp7EMkFcze5qyfQmKsav+EA0xEuRkxfz+iWPO1I0xvYt52rD3UXi7EHxucCrS620SzF140QsLOqw5x/P6iNGCWsfHc4QqAj5CtGRQuVhssr1KujWcY925jRjL9qx9/C9BQ0EJ/sE5W4eefLBU7/mKOXzpZJLEGwK0yVi7y3t7SG3fabHHNDkHOUydfeYmAhKA+bXIRqWXTatKKPVz1FAzd9IWLQjfsEGFKm54vShKnDyFJu6vMcSCODU/Gw3vAlcYvtqnySDBmKK0V1WIY8T9YTndRwX/5a4tRaCvYSALE1AVBsXGZ9lpx+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5McNBd1wFMANz25SIUuolHezFbfPcTJi1kMN3ebJ+rM=;
 b=K/fYYy9fhXALEYmG9Zm8MUSszddeGOZTDezZHckAXb7LAWYhIFmvkQD0jjV0GLtYCKJKc1TvwGemRR6chctxVNGYyCorssE1AUMElKGy7U/ffy7MEIxDBKVHROB4D1zXuQpxujqLM91dCOh/zvLBbY8fjMx09B43WuHiOTZrtqEQNtj5PQzFAtjKlrR6EmNwY+qGI1vloDmXyVuilyTFKPjWZe9iyYkxl3RU+vI82o4KqlgyMkYeA9i0M2V8GAUi8juxkC3K07zmYWUvjqUxblNm17qgSzU83kVhDD+2Bp+m2LTbicXMIZ9v7xegrw2kJY9qlmnLrEE/+YxcT/uhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5McNBd1wFMANz25SIUuolHezFbfPcTJi1kMN3ebJ+rM=;
 b=RVqjWVAm/Tozj3QfoH1XicFgJJol7O0VWHpGvGHKwwaOkT2/5iL0aV3POjULTlzyaG0PIZpz5jSMdmPvSHbqaOdxFBZGoOu+vxVuH/E16KEWhIcqyiTVWexngkpHjI/DQHaNcXAeEtUjnGxCS/9fu0m88hmWqIU1HSw42G4NubYJLHBrvFNTJvHS3VsjouiUF3OVamJ+phhG8/hAuZwXDy84wATGNAcBDkF+l3kVLR0W6Xuhl96sNTJYVUqrylYlwZ9x8lcDblmyhqkw/Ab4TKgBd0hPwloHIWm2Wk9j30bejODXNauLDbiJjSYjoROy6xKVJkO5AxjzJUKeVvcpsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com (2603:1096:400:1ac::13)
 by SEZPR06MB5740.apcprd06.prod.outlook.com (2603:1096:101:ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 12:43:29 +0000
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4]) by TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4%6]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 12:43:29 +0000
From: Angus Chen <angus.chen@jaguarmicro.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] uio: Fix return value of poll
Date: Tue, 26 Nov 2024 20:42:58 +0800
Message-Id: <20241126124259.1367-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:404:56::29) To TY0PR06MB4984.apcprd06.prod.outlook.com
 (2603:1096:400:1ac::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR06MB4984:EE_|SEZPR06MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8f18d0-7097-4314-af97-08dd0e17ed9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pk4w4YBKUcJCJTXrKtwjSuaQP81qgcVTRfdTlhQ16dmocNDpYXiAx0TIIPt1?=
 =?us-ascii?Q?RyDSbsCNtKXiRWSALqw9NgYYTSt/1tNggUfGyICPczUKhogRv1DOVggBV900?=
 =?us-ascii?Q?A1oVecb5Vm/Ar3rCqqGC7EWwctdSrtulJNjopGFccr5N7N0SNAaM34N+Zt+Y?=
 =?us-ascii?Q?cfkBiBYb1wkwd4uATQfYf8FTybPcXPgKtUh0L6OFLU3jbHXT91qAU8EAdVOq?=
 =?us-ascii?Q?Rt7uGZeUD2Qvm1zP0Cp+hhNj9Wn3os/fP1zYDV8oQmOkigs0eC6QLXW4VkoN?=
 =?us-ascii?Q?g0YMd9ROB+BLSnalVdnWZffZBopjfMk8TKc531vBZP1nf3QspyrCrCznyDvt?=
 =?us-ascii?Q?jvpmZ4YlRPw83W/IqFf+4k/lEYVtg1sMwd//foHYgacYvoU6hw2HlpLRR09J?=
 =?us-ascii?Q?uC21Ml+2ElcAwLaWxnd3HZH+Hc4MRtnmvOr0qqTQxDJW4rQvsgpqUQM2/Ss3?=
 =?us-ascii?Q?IuP3RvVv5dWzHW6n/zO7vIsD2/lQNhDNgtZ6wq7NYf1tYHuhfrvMOLy4fdh/?=
 =?us-ascii?Q?4CQ3vGHn10Oi79KEVLIw0a6qqCaQL9Pm0ADVYBv65Lcu4W03hui9hUNWRkyO?=
 =?us-ascii?Q?rQF26yso0O9U0hyShcKyw67FEXO1bHdiEsRIDCSmprLQQpIGuRJHujeUyqHa?=
 =?us-ascii?Q?txg5GKK20cEpY0nMlS0lMGUqeTpSGs0qOd1v/ZPq/C2impYHTqzZOjHKou5E?=
 =?us-ascii?Q?6WQIIdv+ZSKHfy5+CLVfAZzBXt/UF0JHBNlMgMRG4keeqne2bDhg/GHm2fmf?=
 =?us-ascii?Q?Ma0O4kuyKTK7ibidZS4LuBQvVqtmUX3TR8I1m+2qE4J/GKXKLzGqQ7YhxFnQ?=
 =?us-ascii?Q?VL70npFDh/XAyrJK4P9eQew4e3T4BQKI4pj//36RlvNVavPM3rUD38AnJipc?=
 =?us-ascii?Q?tBWycR+El3p/5X7gn4vxKSeU9VFY2aunC5EhA3tg6MaFll2Zph+iDMUjPpjh?=
 =?us-ascii?Q?V+cNOXkWg9QEgD26jqXKpBryLRqIKGBytXW0fBai9Hk2tO/DxhukLhWOGNYr?=
 =?us-ascii?Q?joqsQdPFqQ88Yuji5mADAt5WEgt213/mMn4nsZRhNhbSYp6AnhnLZNzgzmJ/?=
 =?us-ascii?Q?ExlfY5J71uo50BphobC7yt9TU/tJSPgdLy/87Gtvg9WzS5OazUBZ8IiqckI1?=
 =?us-ascii?Q?g/awQuvffb28cRDQeaNTBOTCoCUmmYCJAEdEFF8K3F7TNnx/vGCKPxfY28bI?=
 =?us-ascii?Q?as6enZO0szElnEbQxj5a5LD8CRItYzsZBhVdr0Pn/gHFLdNv6djPe4uCxIld?=
 =?us-ascii?Q?AwxbRia4Ha9g2V/0b6Lqky+OkJ/nF7SS4oiyLUUjJ/APZnHSyibHNSqXVR1E?=
 =?us-ascii?Q?wKi1TvmJ03dTaCKdLi2iCZeL/GfCf7RPsnjLLBXv5zaZ9oS3he/4N2OmeEQb?=
 =?us-ascii?Q?41yS8fm5gcxJB0OkINQvhqkIuZSfJbtW7jbeklFeIZqjG8UXyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB4984.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1KhuzYzgaO5GSkgqPAnmmWT0n7m0IwcEt+9VfMHhN84O+OwgYH21Y7yiD2Iy?=
 =?us-ascii?Q?eN816uHxr4z9clcVfxodryVQKDNwzWATgCAA5U2UK4n9ZEF2ZpRfqJU12o9T?=
 =?us-ascii?Q?7ImIt0mJ57Rz8kbYO6a/CSlGkw6Pi9xb931Ao4gn79OSzPtdte3ZJ9En/wsT?=
 =?us-ascii?Q?G6VkzZp5A6K61QcvTg73xEv3LycTwBUysgrFm6dXV75Z4jxyDc93uJjbdwfj?=
 =?us-ascii?Q?/IL34j9q+ukuJjj3ycutigHgBTdG9DzjIFR9iV16CDbmXqmx/V+09C09gzjt?=
 =?us-ascii?Q?zweBm59It5lYLGx9c4UjAadCjsJIeVWB0w0H7Svl9MnLkAP6dqYKmew5DT6U?=
 =?us-ascii?Q?Bs7kVawhMj0r1UjGC1eLKjMzPdgkYTXJVzXKxSDC5QvFObsqVxdfEsFU/mu6?=
 =?us-ascii?Q?zInB+xdYDaqdaiz53Otf205DnrUlEOmRXZ7Qjj7A3HDFkhxxzekTNogrrItY?=
 =?us-ascii?Q?KKFECZoZ0xsGTh5l2Luyb9rASQdKBboKmRPCR2P7FOS8V7X+Yr4WK363j0GS?=
 =?us-ascii?Q?QsZAKtZqDFPrbhRpZ26vINTsKOTMXbdH84PKR/YOHsueHy38+FlG82A6+1Ra?=
 =?us-ascii?Q?NmERMNGyyHSND7TKXlIwuTpmvO3t0yaL/87lc3PeNQNZHtqldXv0YNUTG1zQ?=
 =?us-ascii?Q?NaAUt9JmrZRPxxBaWkMdtRaSRONVWsBERa4BT3jDhfDnVj/hnlhzmito9J/v?=
 =?us-ascii?Q?yM/ZXNLffTLjQEnYBerhvaaH+3Iq81KvjwpMOlC6/YNyX9ktEJZF/48umUFM?=
 =?us-ascii?Q?XycjgEau/jY3qE7edWWeR4ZmHCnspXplKh5iHH+TLYU5k2P0si0yGjZEVoUN?=
 =?us-ascii?Q?lJspiYpBkewlT10XMxZ4CLL7E0EDmJ1vLkgFXXvT5gxRwg+Q83/qHFBr3YBS?=
 =?us-ascii?Q?YvxpWYVSr82GQsxLAZOjIqv8xZk6nJL/j3Cgi38L0WZj1vag3QHCas8buuqu?=
 =?us-ascii?Q?45PPv+TXX5YTp7H5i85Es/mf2K22iIcS/b/G4d5yvYzhCVUOYJFjEwi8R3yL?=
 =?us-ascii?Q?nhU6vf4twXaq4L3e9xjYwpou1XZi6PViO3YMoef1bxeBg9cwRCbDiJ2wwPNJ?=
 =?us-ascii?Q?eUJmzKMYzod8MMftuypEr1Nmfu1AIi48/DEJXceuxtfTYsU3aKZ0PFBxcYjr?=
 =?us-ascii?Q?X5Hvp+VF1We0VG7UDYB8EGHiazfds+zUEDWdw+IXAEZdyNq8pxGUJy9Ki7Hn?=
 =?us-ascii?Q?6rZBvjzDYYRBVFOg9j0fPSqrBPJV1grAro/BBcXCb42p88Ksp97OUCuVEylO?=
 =?us-ascii?Q?0VWQ8NQqFjwwq733vqOQLmpJ9QpPqbymyVx/mC17IJkXtHUQJAXWwknAbB10?=
 =?us-ascii?Q?jyvG6FkGVz+RRVRQ9V1FfnLj1MSjoYv1nE8uFE+DegDr28YaaAji6uEOD5sS?=
 =?us-ascii?Q?oOqs6/kY8i+iR3jgNtk69QHh2DRTd7iOiCHHLAO5qgND4s5wHJBxEeFlQ9c3?=
 =?us-ascii?Q?0t9KFG4hJkM5tYoXHq01yZm2D1sNpKvjqfljqiTvAKHRiP0EGSderkmYElkh?=
 =?us-ascii?Q?f4M9NxZbOPRgQNRuuW+60+rtAnx59neomG4cqWWMNoYeO9iun50SD3bsmb9u?=
 =?us-ascii?Q?UU1pqGLGtMlfteV+8/ccTLLx4QnsPbQ0D6caz8Pk+1bLUu2/VDV8ugkngPOG?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8f18d0-7097-4314-af97-08dd0e17ed9f
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB4984.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 12:43:29.3053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xPXE4umt6g5+Cz9UCyqtNWfk2anKJVagyXgTto7P4hwTTCld1aLSdQvqE8HdKnAhJU2qQk4nFue3S93aSft5bLIG0/KGwKW8+apTsbm9Zg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5740

The return type of __poll_t can't be negative,
-EIO will be translate to __poll_t,and will return to caller.

Fixes: beafc54c4e2f ("UIO: Add the User IO core code")
Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 drivers/uio/uio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 004a549c6c7d..d93ed4e86a17 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -565,7 +565,7 @@ static __poll_t uio_poll(struct file *filep, poll_table *wait)
 
 	mutex_lock(&idev->info_lock);
 	if (!idev->info || !idev->info->irq)
-		ret = -EIO;
+		ret = EPOLLERR;
 	mutex_unlock(&idev->info_lock);
 
 	if (ret)
-- 
2.34.1


