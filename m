Return-Path: <linux-kernel+bounces-282915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E56D94EA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9393A1F22943
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588BE16EBF7;
	Mon, 12 Aug 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="uacnTsuV"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8416EB5E;
	Mon, 12 Aug 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457237; cv=fail; b=tW6baUc/FAccNS/UNBIER4nLMbMyGPmrvZqyclQLdRoojz5xBnyig5WRe4r9bnAf9Vapt4ejZm80Uv1SqhmdrVzwz6KpB4ZBlqSHhe98nGSn+qpKXx6yQJmgkh3f8KPc6VE1XoonfMkgB2eF/9bG61MBcdHrwgfxovTq/KYMbBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457237; c=relaxed/simple;
	bh=fKvp/2NSEQGDEEDF8PutXNYVdrLC7csffTty9DHrCcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cO8cP6eau6wt+ymECHtjCre8rAnNlalLi4jdgALHmNgGfWBygsymzYQohUynM5dOw7mVJKbJJlyUNKswOMBkdcC/B7Lyf+UTgZK958QU8my2sOChNAB7FvDRXRKBl6YpWlSB7NA1DbQoNICGoKJWbCKGWh+SeoIIxtioveAmkho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=uacnTsuV; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBVagdbQIVTrstW4ppYTCSJddmq3L+UGI0rPkd3y+/qMU229fcxYLB1IufG9Rk7p06plaYNYJuiZsgWEQA7h/Bma+S7cFsVT5KiQP5jme2CuliaS7v8qFfp4Z/fQrvbBuqr0/YFVPH0xRTqjk/v8BnJigRwAOAecm56Xry3cdO/pbckemmcdDd0NfWsMErVd6m4aDjxIP2MBOV+DBXdcNSCPPllIDq5P2EchcdFsmENNh1iY+5xEfggFFOF3FUVsLysQU5NU2Zk4u52s2uPB2OwB8UZBgi3itSLEEqzU+c5Su8wfdGsDc+eg+mqhUKpn7mKnkzv7N5J+BE7DgtptrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r09cKbCaDN5o0v7BW8boHMJ/ya7CDj4NHHKG3UPfBw=;
 b=rtIScPxyBttvP3qQvULH6uc31VLrTNpxakEnuqRqeEocXOE/kDeGGZ0ylC5PcanqVDOixKGpo2opZk2mDRgMGwyhRXdES94O7FVQeQ21XP8KFJy4g/r6aoLJdFAraBz3sWfQWIfrLjbG4jPp6XBF1ycQiPzVRXe7HduRPPempkntRlFmwopDaSyBi9wd5G6YlDtEEjw0TtHDFl31YM2GUjhIp29EQAVo4ldsFyyA/ZnrdUieAROcEKL66J4U4srwLl0xjn1eecwVBYgLaVhwzQ+AwAdDHouiDOYdU6f7YGHwiSrN2aJsDc7VLuLX5rebakYgMqsCIHM0Ol9fp+L6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r09cKbCaDN5o0v7BW8boHMJ/ya7CDj4NHHKG3UPfBw=;
 b=uacnTsuVPf1MNdb9v3xtodrkM7mIvQvXjiyKmBJkePagI1bxw5YPSBBUqLbDjRPfh4fzG1Si0FfuTN7EVkjAMA6UTg4SvcM0H5bqkDOGQr1/rP/ZHQsUrMX7yt09LhnzPuE4wZH+o55MGc4HttUsZ8NBVUgZTndo/2A0Nn1qaZFMzPjKk4//l34I+2IjQy5nQDUDRFaG61iVhKPpZyQVv8JDJla8eaqyh2yu35qvzyl/Q32D35B7iWlQlGMaM/RIWVa9BL8ZMZ5x5MWQ/LjPSUIXrXsIkGky94IHpk5Zi7PcOvdyYClzF3fZDfo8Voiw1Se1iCy26QRPTvfXtzyhGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB9337.eurprd07.prod.outlook.com (2603:10a6:10:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 10:07:10 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 10:07:09 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v4 2/2] of/irq: Look up address cells via API call
Date: Mon, 12 Aug 2024 12:06:52 +0200
Message-ID: <20240812100652.3800963-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240812100652.3800963-1-stefan.wiehler@nokia.com>
References: <20240812100652.3800963-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc321d8-1ad4-4190-e7fd-08dcbab686ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aTy+VIrpdiuFyuHoSMB8I6eYy7p675ja11cOjfHbAXlLVhHiJnY9/lcYC9TK?=
 =?us-ascii?Q?46pUwwpMjcoBthqthv56nLftDKd9djkgutnf+N2nCGhCPMZvlSA915O9ta93?=
 =?us-ascii?Q?P8/1ViyIw9/3z+oXHlmfnvvUuh42EldK52/JDo80Ns9w8pl36Ex0k2digJL1?=
 =?us-ascii?Q?EiyrXeeGhnxkJ7ws7bgSj0jvDfA6TlKtBMa9GGt33a9rpATdWaFOHJtjDmLU?=
 =?us-ascii?Q?WR+xLBtexnPss3yCXNzCpcK5OAjuXRCUHRWCFPCZ17g40fXD89AdpPnYgQRU?=
 =?us-ascii?Q?4b9vydZpEEH3R+ijkjhaDxY813Bf++2lWLZSGlfmnnS1rRNZKIZCaso14afB?=
 =?us-ascii?Q?Sp9Pcw0sDyGiHyCJTfh9vLcwa2O3ZB8wPFEOIdTcDYZYxvTqprJVqxm/NcdE?=
 =?us-ascii?Q?8cydS1BvOPOblgg+5NvvXMHS/nU5ImlbhL+Vz4vq+B7+JBHbKAFGaF0NbzZ6?=
 =?us-ascii?Q?gz3aTOD0rYCk22brxxlM8zAYQuCc2P7WSHdlITCkKNrVszNIg8TRtjClkn9w?=
 =?us-ascii?Q?QXHL8fO3M1kPSecVD0s5QUjUH5PyjmeNJ/Oxq/uOlaDZjYdJHCVBekgsn/X2?=
 =?us-ascii?Q?w85SNE9nn8Ip776K74ISONoidN1Ehze69qYKx0Q6oE/SF2E2H5JPaNoQaRQT?=
 =?us-ascii?Q?TPLmjoi5SiLmXFA8eiqDTYa32KgGXousxQnGl/+pbdbrgK7zpJIlw6mUT3Xt?=
 =?us-ascii?Q?J/Wsp9JWE5UgUCJoCN4MdnoM8eSYbsoaZUF3BmVqOv9DwWuuUNz1uvP2uro2?=
 =?us-ascii?Q?bCmPtJXVtIeB72uGkGU8+smhNofKlXeIfVam7StMp9KpadZ9WrSW3UQIR15h?=
 =?us-ascii?Q?hrmY7G+mYFBxyHN7MblxzKLQ2dCHi1kmhf6zmwJP4n6QO7z5ZcdmpS0ew0K6?=
 =?us-ascii?Q?actr+wj+GBCNuSThzvP73lngPPQARnnodBFfPzbqJVsxsdxSn4rIr5+mwSna?=
 =?us-ascii?Q?ET9YlpThPXQ0idYI0Dcmje3cuU/9ryREOyR1OEuKuBaOonB8h2PAUOPpH+pZ?=
 =?us-ascii?Q?RwTRDC9hphjZgBuQxOYAs+oqnOPifcBbuzl65jH1kKLDvHg5Rtv8bEi5jlTz?=
 =?us-ascii?Q?E2TIBnT53H5sWJJHm25jL8B22Pt4LKNN6Noj0o8qRKxTdo71U0FiSUXEjNCS?=
 =?us-ascii?Q?vkDAERTz8222p/jDYauIyF45SofHaY0F4RQKBiXzSY4X1igFesjERdBnEtZx?=
 =?us-ascii?Q?t/O1nPEXp4vnvjHQKsk/LTEK4cWlRVj4m1OrhivXUWl8/ZIZ6ROgIdGbrx1M?=
 =?us-ascii?Q?llW3NipZdKJaqKkzTmfIMkL3N6TbA2vHTMomnXUlacqJD90MImP9s9d842ML?=
 =?us-ascii?Q?U+lZTQ05YVRLsbbLMdzgEF84d7MwCN6AxB8csUIk1i0EtkkJ14mp3M5x39RT?=
 =?us-ascii?Q?BHVcZro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7RUN18imt/WI7Ln9OnPsQlSU3unIh82XWoFr76bceYdpEfCeyrU/NGpDwxnW?=
 =?us-ascii?Q?noDIHynpO7Fh/LEyn0lcUt/BeCIQDc0wWer8IR11lYec7jX3XFXdCmmCZqBE?=
 =?us-ascii?Q?I6YdfGcXt7xHuKxzzBojTEqEDCk3sjkYR599dBGALorUIHVgwZfTPOqqlweK?=
 =?us-ascii?Q?vMq01QB/lHmfamVsjgw/y4aRWK0fjb+vspa4XRY5Br6NmtSovy16hXujQRab?=
 =?us-ascii?Q?OT+ZE4I/yPaeRt5z7DwQ1rlIiYuJRuMk/jEA7Fo/LHtIJYPiOwQvmy3W0REH?=
 =?us-ascii?Q?YHmAi9cc3QF5iEOz5lTWitVO0RPT3riDeXkW1SWec26Lo4C+5xdZZ0SoaEyt?=
 =?us-ascii?Q?yjkrCdqJPlW21AFHN3h5ZgplZnwtHkmc7o5iDionzRRnqyNBkXTMDssFNGp/?=
 =?us-ascii?Q?r8A+y7FpcQhsIYQqaM8cWw5T/mukpHhloFrYotMSnQdYW6iZWfW4uy/SbdQt?=
 =?us-ascii?Q?Q+HOm0Fh9peadm0SJP5DhgO2aboOW83vA93FcZ77/JgoNpF+IFIaPl7Oos9C?=
 =?us-ascii?Q?sj6/Tz8pi05wzgOn994UnUovF5PQDPWN/PxJWcADDAu+zQgRirS8LAEwTJ4b?=
 =?us-ascii?Q?QUzc5bX+9BkKkUJniFaJsqRxqu9yKikl9ZuoE0VifTyiZHbhLQdJtGkgfhMl?=
 =?us-ascii?Q?0ySwvFOO9MkIHB36Ez9PWRR+p1IL98li9vBV/KzynBcLsaiLWI0rgEJRiy9V?=
 =?us-ascii?Q?Vj0WozgXQmT3k9ZJb+WX3EzxJvDledjbPxljqGhc9x4tydRxSbcM074RtmnD?=
 =?us-ascii?Q?N2Ocp6mDplAjMW41cmtFpW/5NHRVQW7R8571MngQinWvpu+kSBk/MLC0av3Q?=
 =?us-ascii?Q?YTfyyt97Lv/K2A1KF+qlqH9manvDL4RiR9SBTtA2x7N3D1XUgW7XZ8HT8kJq?=
 =?us-ascii?Q?tFJPvzmigqecjSwFrCE0SKA3wuR2HMWrO6kZJ0kCyu9A+0k9R1ju+jjnMn/l?=
 =?us-ascii?Q?pmRrBB/amcWmw29o+GdmIzSngj61py7LIWSoZGo+ut2YPj9CkFfUJfyV/qOc?=
 =?us-ascii?Q?v+SBLHdC46U/vRJHccryaa0btDc6rg8H2rVjnaKDhTHCJzqyVD5rQ6cxnh5v?=
 =?us-ascii?Q?ABG//0Je+C3aiOgxx/14eIXzNOLxxiQAkKXBuPd9LGe5AFsZYNAlUZ5gLxLs?=
 =?us-ascii?Q?wt0tZQEN4zPJzayojsoMGcL2mTXOkrgGfEKbv6K9dlfrwRFxOJ5mMOjGEXu2?=
 =?us-ascii?Q?gSsbLbRvgSQCM0N2fTPNdL77so8jjdpEbWaFBuBJ3fpTiAhqaLj1VNQ18oBM?=
 =?us-ascii?Q?niQssFltDJKUky3VK9U2q8vVgMOcERldSc+uyHMf0Et8PhiVUUxA1rolesMJ?=
 =?us-ascii?Q?mr71brNMp6sL2OjrpOTYVZlMH8TY8ELMJXIHxhES3MV908YkG1oDs8aurvfe?=
 =?us-ascii?Q?oQJNCY+yB8xrmXs6KXlrrbVtEbwsU4Jd/X2AG9cK/RkwzJ7IB9ujmbzLYMin?=
 =?us-ascii?Q?zRaiMMGC50+6JlM2z16hEYoveRXn4RzeY9YjNXkPhEKptoU4ArouNLM00G8q?=
 =?us-ascii?Q?hBhxRFky9E+EziHPNTpLH6quV2dknk8ofons9TUqQWVqmE7VO7kCaLT2Q8+F?=
 =?us-ascii?Q?oI1qZ+o91VHhGwDNL/5oyygiVjQrYPYBe24Vx+QLuShxCxlGS3Ddut9SuW0Y?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc321d8-1ad4-4190-e7fd-08dcbab686ff
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 10:07:09.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwyN6z41oCsgdSha/dsC44t1RmRVyfkSnfpB4WTXDO/IMq3TUmfUQO0T7+3cdFFq+4I1bzw/nMbLMSj3ccNDYqEWV38lA/Xy9rUFFocLXqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9337

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 drivers/of/irq.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 8fd63100ba8f0..8cc98f8212b51 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -167,10 +167,10 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
-	struct device_node *ipar, *tnode, *old = NULL;
+	struct device_node *ipar, *tnode;
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
-	const __be32 *tmp, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	const __be32 dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
 	u32 intsize = 1, addrsize;
 	int i, rc = -EINVAL;
 
@@ -201,20 +201,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	if (out_irq->args_count != intsize)
 		goto fail;
 
-	/* Look for this #address-cells. We have to implement the old linux
-	 * trick of looking for the parent here as some device-trees rely on it
-	 */
-	old = of_node_get(ipar);
-	do {
-		tmp = of_get_property(old, "#address-cells", NULL);
-		tnode = of_get_parent(old);
-		of_node_put(old);
-		old = tnode;
-	} while (old && tmp == NULL);
-	of_node_put(old);
-	old = NULL;
-	addrsize = (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
-
+	addrsize = of_bus_n_addr_cells(ipar);
 	pr_debug(" -> addrsize=%d\n", addrsize);
 
 	/* Range check so that the temporary buffer doesn't overflow */
-- 
2.42.0


