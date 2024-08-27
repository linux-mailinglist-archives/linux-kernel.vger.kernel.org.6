Return-Path: <linux-kernel+bounces-302517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8FF95FFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C032834A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E0117C79;
	Tue, 27 Aug 2024 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MrXgK928"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22441BDDF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728143; cv=fail; b=Nmn/3vsmtoTHI/bwisjYxvqyFITVu/jNwpZ903Rr9c9w5LrIxPnrT/zoAGx/tEjVdxlDfd+AcWW9jWSHBY+TyrMvtToaZScZFCdJaiMOap8ffQCxuTfOMb6bNLA0VZw50EPys0UsWIDA4xph8F6nROTh0rYOvzdntzleCY19Oa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728143; c=relaxed/simple;
	bh=j07yhd8jjylNwXYbbKJMrot/sp3lZGdnc0vHZSwieoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oG4vK5u8TfsTUV8Auk/MBTgQsKII6iBHtXHUmDbdtXL+wgL9i60Xgp3ZXrYCb1M6tYaqJbgXo6o9MbAUyblbmgTgeSfmB/geAi+NyScAWYZX051khheLdG30E7Db/d9zUNN4YEfBfpFO5WkBF/BHx6aQC4HUAyIoCpUXZcNx+Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MrXgK928; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qdwl8u/0h2uy8NWPTvkYFt2FHTZv3yM1+ZkLgn/6PlRx+9pCPb4Ng+2HrsyNNdMKw9/4SCjbWadVZKV7NsRP48iTRH/G39E+DNe9Z0oAQZ9bKl4dS0KQZeGeVVEXX9lQwm92wjmN/G+G2Lm8EVEGQnPl40n4BfMRpygP6oLjPVqC0sWe3O6ipOWK7NVGcXaVbOH19GttydYGFryypmR4k4SzoofZUUwxgshZnGP69gaZpgmEbWQU2UcYR06fnT1BlJBqtMIOr85kQVSOwOy2uGyzoqOQQAf9G+ICW14PF5mgwh6BObUiociobYfjVfio2gUkOi1ct7GMLJr9bkdnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEmNn7lhlbrAfpdudAjAujvAqMEOjI7waIzAHTjPkz4=;
 b=noUvkMJiTNXtgkEJYflvvbozF7cT9iuoF91QcQBc6JhfTXvf5ociWUauqkNC7M9GHUd7+f41KMtaYk9DpvLhT/WR2m9ErEk0lKGc59BqLPwGi4E5zfAMPssoa5RVkTOC6lRo+GU3T28HuAgA/P8vMH+S3D3gAfGkzmkoqEOax2cBZtureqrp1r043VRg0SwS2FH/gdgf3VDaXtb97v6TtwCGdrNId5y9tf6TEb1AktxuqeuyAeLveCC49RHecNaqL3pFAbgqRviXvqKkTgGKe7iMzj0wF2IfbRjbOrYxSjdzt4/BQ4pqTRNFJteEzTosEM/+CUIhucjrnNsLRR2Ocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEmNn7lhlbrAfpdudAjAujvAqMEOjI7waIzAHTjPkz4=;
 b=MrXgK928tqc8Ieu+A1WTvGRcikNHzxHJehEeqNnH07H1vbb55VR4iwwiz0hDNfZpuIKaU8lOVNhleJTwY08Zm1resNpGR6w8Vf8M7Gy/6z4l92+3jKtb8Qk2UYjx56jn3xZQ+0/otF/pq60K68cv7e12SFCuWzRQDbKCGq0u6gsXnxT1Q3G5D67BvBISB4bCwq20OvwjYe0t3U33a21/ejWpkTypMMM8wx453+Izy8OYj5xRrM4N+Yqp48JDUYJqR7L6TH9g85LZXLLJYzFdVeXC0MgPawWQ/2p7hpNazPoocXX+F+Nea30tMxVBnup1WSXjCuYpaL+aqrybXY/DkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by PUZPR06MB5572.apcprd06.prod.outlook.com (2603:1096:301:e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 03:08:57 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 03:08:57 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Wu Bo <bo.wu@vivo.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] bus: imx-weim: change to use devm_clk_get_enabled() helper
Date: Mon, 26 Aug 2024 21:23:48 -0600
Message-Id: <d781c7fe4b8ffc804de1926893360d4295cd0091.1724728767.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d0d3877a33db855e232ec4c6911a6937402d501a.1724728767.git.bo.wu@vivo.com>
References: <d0d3877a33db855e232ec4c6911a6937402d501a.1724728767.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|PUZPR06MB5572:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a57f14e-ceb0-47e6-9e46-08dcc6459700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JgyFaISCFJZrf/fuOpfR6ModyBH4f69J6+PcKBAdIod6S8ESzKeFTTx3seZa?=
 =?us-ascii?Q?wUOrFE8AQ0a0+GDJvQmZmMsHG4eXW15KuGvoYWZzwMxuqOAK81D5pI9Q4JTm?=
 =?us-ascii?Q?VKmoDcFl4alUbmj9hWepRuosEBtZsyo926nfltyBp0yc8ALFCH+0TuzRMUAQ?=
 =?us-ascii?Q?WBDs3pxrd3P5bs+RWszEFUc662vcFYLkHTlQOP9xlBkyrjtZsc8/ysc38kUG?=
 =?us-ascii?Q?1emFe4lHeQrf7lQc7mtlRqx1tp9JCcDETyyI8CWL742xiKCA/LWP/n+WFaYn?=
 =?us-ascii?Q?ED5uxLErnsSp/lck/1ptSKU8KpNh1AzL/wWjiBKlf0tQw5i/z4W1dBd6PCqX?=
 =?us-ascii?Q?Imlvfek1AuDcco8QM+kKW2p/LkpmuqTkFvwIUAPbOqsEDuF6JtfsBEBPmlP4?=
 =?us-ascii?Q?ksuCVvlTSx3RbikzBJHITvxXQ8SUSqbNl61MT3/FsWv80YsE2mwhXxkbMAqb?=
 =?us-ascii?Q?z7msO1GTWrZo6HNRw489voi886o8vOePI/7+lzXogGfMEwZD22RiDfl2qFq9?=
 =?us-ascii?Q?9n9BVNJUkObK58elyM1mjzbpNVniIHSCVBnGLaX5uEA34fnmZTBxntYdKj1d?=
 =?us-ascii?Q?i+ELZr1kaRTkHBwNIGz7l6J20DysbmgSBv8YmEUKPJsNznjFQznw9f7JB9DZ?=
 =?us-ascii?Q?eBIR4d2acpaPdHHbhDU+1mGo32A07j0deKoit65Kn4DMI3xFxzCkG6KvtWQx?=
 =?us-ascii?Q?Aznz3glwoQ0w+PA1RHKCU+Wb01WjHIymNZ9txXnAX06W5hKPf6zskU4wYdqU?=
 =?us-ascii?Q?3c5UZ1fqfHG/AoFt4ayzONN0iZL2pbaHeNf0eaJV8V/ITRdGnxSvc7SrasV8?=
 =?us-ascii?Q?fE9Fm9Gia9ua7emJNRlQbcgAqRKvKma4bhdO9OSoEMSmrxE4m2fGH9wInlTn?=
 =?us-ascii?Q?NAw/2uJm3BD8SM6+VaXasU5cufuYc1Th2AHhyo8oEJe/6as731lWDHbEGL8e?=
 =?us-ascii?Q?828oh3LhUPjUp2OXTWU7oTEA5661GUtI5Dc75qSAUrH7xSj6lOwMrfAgMtAG?=
 =?us-ascii?Q?yRsR6o0Z0/6OaThV/IHfdl2JVMUWFF+Y9qlhjFmIM582XaYe6z7WMSIN32OF?=
 =?us-ascii?Q?T49IsNMBmLRreWcliI601e4lsFBKM1JB8yjVKuLtFIcDjA9A69v8WgZKlFi2?=
 =?us-ascii?Q?bSOkd1wx0S4iC1dLGSe7ReV9Wa+LIzSNzqs27p4IpEE1FMIFmaQiAhmuVtm4?=
 =?us-ascii?Q?fPS0uvq1ME9aAnr+loK1zYIkKecHxZN0iWCjAd1WvS59ZF0YbbybCrFsM/lG?=
 =?us-ascii?Q?WG5up6okNHODlpGiRuFD3500U/VOS/Mc2BiMclcy3zn6ZPA/wXmkIDni4JOA?=
 =?us-ascii?Q?dAX2Mx4rZrydFViOoi/hero+4tQE+NHiU3fvINgddi/ZaLvRy4DF/KT2jx0F?=
 =?us-ascii?Q?2gFH3DX/CLB791roR8fH0XsCcE+pMKKUq3t1A3dMUs4nq7kmcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4PPG6l+q4Fo5zt5dLAiHWaQnLKMvSzYmYw1ZqIlRl74mCzxfnbnEZEnL1Ws9?=
 =?us-ascii?Q?x5PAuDSIFe1qD6HwY+UGu/ibO4XozOFvLBEqZOkJvt6OHqA+zpW8eGVOjI40?=
 =?us-ascii?Q?C34IjpooYYSePa0Bf4OoyPBi9JtqriF2iMglaVqnb/3SKtrGV8veAw6lbbwz?=
 =?us-ascii?Q?WD3VqSqxPzg1gDgZFnzXnmMAxzcu8p0ITo7vQZCILE6qsn6GNRiDCyGLCZzp?=
 =?us-ascii?Q?5yu8AVpqvL0AYyNLshKzStDwZGrbFH9W65iy2Jd9mDXVe3S3+chiko+I8TsF?=
 =?us-ascii?Q?3KsSBk7e7yEMQy8bP2DerGS4zZHSR2A9pViocrm5JKy7FDESE0Kw3jF+QWup?=
 =?us-ascii?Q?HnmTiyeQCW89vXTaWVw+NjD1iieSCCKp4KUsOX5M8rAEk+3Idg+mUtnSDVVy?=
 =?us-ascii?Q?w6FQVyDN4yMZJbPyS3mO/8bWmQttAY5XRZqzlvevwAeCZjNNzv53pI6qCmfG?=
 =?us-ascii?Q?hViwSlD95gpFQfiQ2iDwox8KpW9LuE6nEDwW1Q039o9ogHZvx5PRROl1opKK?=
 =?us-ascii?Q?P6X3enCaDiT0FA4K01rZCHwLg1bizGlF7tFkIwaPYOY6Xt8dg5YttYuNcYZZ?=
 =?us-ascii?Q?FeviIlwhF0n2Twx/KsmHi0div2sXOG42hq/G0G19Kc4ajGXQPIVsnz2LuRVL?=
 =?us-ascii?Q?BD8bSSfQ1euO+g+ssF5Dvk2KHK+Uog24V8vOnkaBzIqfeJ8ymGwpT5gHc+G+?=
 =?us-ascii?Q?+mBy5Hzn9+b3bzb71WX227AYIAclRWnmbjEqX38Q1yrwO3yEwV2cr9R/ez9T?=
 =?us-ascii?Q?/O5l2iTFBEZpKC8IrUd2qhIgVt6cyTcvXoy5NfixHI7PmcXgCmCQW+QvvwMk?=
 =?us-ascii?Q?gX5me8roXvo4DNzCr/0n+cAdyNlCYXVMgr8cP8rJkyikr9+ScdqDe1dLFKrA?=
 =?us-ascii?Q?ywlyrWQOQuFEXkSfHBvIanPJjfN3L++Wo7JRpcPoFy4RgUhDgGzgEfEFWxJ4?=
 =?us-ascii?Q?tdnbbJRCLs7goV4Pvn/Rz09AFCWFn5YOcNalmhbKoCetzW5WvC4wec8RF6a6?=
 =?us-ascii?Q?BFCUZ6MY7TDQcBZyiEyo5MssgKqw7BZOZMr0tEu1aSDxdRBYo5B5DELzj3Qu?=
 =?us-ascii?Q?Pqqn6tUp0pd5xfzOvkyXYO3iQG8CwZ7/OBCmmjin4H/QMHwaCrh+Jt7Dipxy?=
 =?us-ascii?Q?PpXtVSvgr/6yMLSGIb3nA0AglS4HK9SUZ3J3ltsziFarldxxsojq3UW03iQK?=
 =?us-ascii?Q?utWXcgaYpi50vEAsnx/rB2xSP+w2n8kiSHFVkpxiv32m7QCmyfrf523qVRNY?=
 =?us-ascii?Q?1d80DxKORDsRrvzgcDITXOWfUOC8EkTmQ1l/xX8oknCDbNuB/A+y2NaTGdHB?=
 =?us-ascii?Q?dpfSVxeffKT23WOJXFB3PIBX8puXXzsAF78xcvB9Ns2TwKArhV6KYx1d9HkB?=
 =?us-ascii?Q?fDa9WyOSe1u646cWSqMY3GLKdRNxB9TFlq7eQ2MRlJQIS4+SbHAyX2gxdFRf?=
 =?us-ascii?Q?yCGBseVip+biFAOdz5pgU4jWmKOtAM4UfdL13RU2icV51V3I7FDjHSP3iYkT?=
 =?us-ascii?Q?Ub1fV3SLWvWwhFgT6mH1qL0MwSxB2r2+O+c5/sp2XqIjXHe/2DG+C2o3JYYa?=
 =?us-ascii?Q?Wg99911ars/40Mny5O84+k041vUg0F0qowlMTSYu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a57f14e-ceb0-47e6-9e46-08dcc6459700
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 03:08:57.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K619rik75XWuxfKZMPOFk1CBUAB+qDUbprSxeojI9WLQnCHwLfRfa5ppsUocJRLLDia9XElucNJ2NKIkVvWN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5572

Make the code cleaner and avoid call clk_disable_unprepare()

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/bus/imx-weim.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 837bf9d51c6e..83d623d97f5f 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -282,22 +282,18 @@ static int weim_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, priv);
 
 	/* get the clock */
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		return ret;
-
 	/* parse the device node */
 	ret = weim_parse_dt(pdev);
 	if (ret)
-		clk_disable_unprepare(clk);
-	else
-		dev_info(&pdev->dev, "Driver registered.\n");
+		return ret;
 
-	return ret;
+	dev_info(&pdev->dev, "Driver registered.\n");
+
+	return 0;
 }
 
 #if IS_ENABLED(CONFIG_OF_DYNAMIC)
-- 
2.25.1


