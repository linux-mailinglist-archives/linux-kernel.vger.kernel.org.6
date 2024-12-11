Return-Path: <linux-kernel+bounces-440693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9CA9EC2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589A5284378
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296C217705;
	Wed, 11 Dec 2024 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMFERwCN"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF172215F7A;
	Wed, 11 Dec 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886623; cv=fail; b=FZRYPsRsCXZ+8sadkv0r91pdtnGdX6W4/RPQRwTFhTga5GHj649pLq/5+KyCZA9GJMlvONMrs0MbnscMQh0wfVvuWm9CNAklHALtcAQv/EQOeVN9SeUlcx+MgOtvwiXlN9qpv7hw6XnBpq5CPkRjfIOBrhJ7OL1O1mR4irhqXyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886623; c=relaxed/simple;
	bh=Kga5T+ah2FU3Ou2fNm/+P5B4ui4zBo7U8oJFsAlVAeU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VSjznZEjDcRIog/x/W37tmZiHnxI9Jn3fsmxVLNPjQ9kcWZ/htaoJRoQlwCE+k13iJ6IxYmnq6HLQ9T0vJFtDFLlj9VCGaQCCDuNv4Q+cYM6Iq52wr/HCeqxrfHSaoFWYagTTOuMtU/XLft1QGzyykca1cwro2lCgAQwQVbu+NA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XMFERwCN; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhxJWEODH32SaF3RDZ6AwUQvOI9X3robTp77PduCCzvzJOOuXssVQ7zzG/xqMNVb6P/2fqudgJC/Ng4kHgs+z7OF9d8SWWAz2Uk4ENEXh8FFQmbN1GVq9ddlBRYSUy6XGqZWyqhcTXbWQAFTUUmV+pBO6nt/DmQJPAWe4p7yUexpAsQdlBAfSY7o2azqpeO/TXcREuaCVr7p0QUU+74OSZ0r4ERNirGhIYivM5zEb72S3OtczPn2nPai51EVYrTkpn70KdJyV6bQMNwSNko6IFwUWYI0xEKDFHDLcEXuc/s7VA9HTCk66PQEL/HY9JAL3mtNIOPX/pxYXVypWVAC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx4r59MsUrRSAYnRBL2LULLZNbMWnLuBxzcN1FydhN0=;
 b=qzchetZgEuZitfp7oGiATbnheTPqmyQr/bfPpDKb2hzoyL2cqot+1WDZZdkJ+zf2ivqTzCwz8C8+GRbCj2GKZxr0Pg41QeJBw1MQxXA9u18cnVU+Kq9xx9qHkvqyXbCTaZT46dD4ieq/dY4UzdNFZeshfki0LUUGGBnLPJtKI2bFWjJ8rmQc8vfsCXtEB8vMMnkFdrnOB5mKNuHdB/GooAaaLCnS9+ZDVhgGva0Ea/fq1waJgHh4PZGs81AJ91kGWOnKIB8XlgAr35Ua5copJf8pO0yMJM16i1mcwCwNlz5LpSjXRfD8iUNQNdLmnn01tU0v54axtmFYQDMmAP4gXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx4r59MsUrRSAYnRBL2LULLZNbMWnLuBxzcN1FydhN0=;
 b=XMFERwCNX6H8S+46k8kTF8f4BN8/9t1h7v9DsF7xRIy1xwHfqXPf/RCb3e4xemRpXP6M2y6h1kK/n3088RtbL5Fne/ZrTAZmBkWSNcZ0KfoTU5whCkt1k0y0NCzUGoQ+UHdbVQmwd/9T2bmjKF9zuKFdcuRaiwIIc6Ft3/y/S/E4tUBZKzeRuSDHTdlayJxmZ8o5nQS+mrSAAuC7rRTCvinvSfg8ihWbG4cmrEmrP87SbR1WskuA4tDOAXb3tDb0FsMUGgubGFCElt/NSaYKamaAU9gFutW7q0LqV+ZrF7W4dGheNZcIV9wINroeo25L3JxN2u2KUVnlOH04SBr++Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Wed, 11 Dec
 2024 03:10:19 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 03:10:19 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 5/6] ASoC: fsl_asrc: register m2m platform device
Date: Wed, 11 Dec 2024 11:08:48 +0800
Message-Id: <20241211030849.1834450-6-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241211030849.1834450-1-shengjiu.wang@nxp.com>
References: <20241211030849.1834450-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 60606705-6b32-4700-7daf-08dd19915818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eARbA49xlf6MkXYc7A67vigUfrQwiu/KWk7hnMYrMmkd40v0xxF0juDXpPQm?=
 =?us-ascii?Q?c9k6JcsN3N8JmkHzpqZzXBFgHj9Q/N+/ylhaeBMWveqfaX+1SoI5zQ0UQuhL?=
 =?us-ascii?Q?SwOmpzyz614gI6AWwh4Gb0rqWFeoB6g4sFOMTaB0+KnGysdK3hOxlJzt3Uqx?=
 =?us-ascii?Q?rELIDsn+B97s/fLWCfhT5xfOS9pnndFGxULbq3r1g0+G9xr+xyF9KLHvPgYF?=
 =?us-ascii?Q?Njx/7qkRhoI4gaecVInw0Ewf/AR1CS3hnfTnkZqaIsHW4cX28L69tw+mxgHD?=
 =?us-ascii?Q?NjeF0eXq7vK6e/kzYI0DfciQcFXQV4CSTfzaBLxevA7qeM56+ApVBpcVAhIR?=
 =?us-ascii?Q?RiJZWEEK82FKmEvO+7eydhJeSOXdt8vgbXU2A64WcGryp5x0LTPke8CKKoUX?=
 =?us-ascii?Q?po4pkR+KvM6wFdQbW9eFQqyRaPt4yf8FkHFQzkGEy79b6EtJZxyKfT5LYTYr?=
 =?us-ascii?Q?QbuFbFb9gL0nD0cfM6NeSnBz5A0ecgpdTDccBUv4rlf15wd/iKJbXzjv5LHz?=
 =?us-ascii?Q?izh9UG6i4eV+O1ZtqXygZlwd+DXIxDNRCdJylO0uRzHTGClpjcolxjnH3+zd?=
 =?us-ascii?Q?siAF5VtHC5+yjxInzCIoQyjudU9xnOho509avi6Aep0F5sIHPnA7cohvrpZ9?=
 =?us-ascii?Q?7BeIs88udSghuTq9/vdtMOdTozbZPTfjompZGyh3TQCcfsA8la2bR2zJr8ts?=
 =?us-ascii?Q?XX/oHk2Xhqc/N1L+JkpDflr8NhmeDz5V4D68n884Y2TefdGmZPv1IerPhbn9?=
 =?us-ascii?Q?NHfaxYJl4j8BwJxn3xMDDRqHmMWuweJa8oaXQubMzspzN0Eqd0907u7hLQpf?=
 =?us-ascii?Q?GWsb4ouWMapI6qrHKM1t1nyN0VxwcjsKRcvkqmqwglUc5JtCkuNb6KTkpxwv?=
 =?us-ascii?Q?KabpTjT1QHn2OLa4S4lIqP13Akb2qFypm1DOGJK6cJlv4wo+toFA4jXk60Bz?=
 =?us-ascii?Q?XpWVOuNIlVU6nhK2TUC+X7JxetVJ1rFXZ4gM4yhHjTLdbtBeGnM/HtEvElMM?=
 =?us-ascii?Q?Zb4qb+vFIQnOfXGKN7g3ep+YM9Pw7k/7iMSo4hhrriLptuLPGCwnlB7+KLgz?=
 =?us-ascii?Q?fBuM0atvj3K+TC7yeu4QZy0xJU8Q97dmwEw/I8LMcDeII49w0ur8xQjNlKQO?=
 =?us-ascii?Q?4hc8IoLgzhJ0DBWVxRO3yhnLIVrwKSGSLPnI3UqYRdDyGEQfw4LML0/YTCM1?=
 =?us-ascii?Q?7CG8uez7PztcrsFCEFNlfLGSbzQLPa80FkdXO0aja3RpKIj2cEQdZkA8d1If?=
 =?us-ascii?Q?WcTXcurQFl24OHOL5heRKwzPAgshYEzshmtZMH880NSdSVc4zd23fqy1yT/b?=
 =?us-ascii?Q?eUUlFT6Uuz4pV5d8/hVoBsQCP6MIieJMx72ELK4yBHt1dai87kBT+yy0mOsG?=
 =?us-ascii?Q?7gKej9VWyP2Bp39l/SvIVsvl0TI/N62Ud266dMggweot/+mZ1x0bzhGNK91d?=
 =?us-ascii?Q?bhbmA/6NNm4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i990VOSIp+twrFdyv8bWXop7dnz2PaVMW9bjCa4Kzyb0hJSMBYwvMQw0+eRN?=
 =?us-ascii?Q?33rjsVKPSVaebZuQWvm1E/XkWy0ga7rzLRSdO1QH1//VxsZXp5y1vtU0U4qB?=
 =?us-ascii?Q?7SiRsnPRGQ5mNrumNzvuw58zWWyV2di+VwbkRi5mnO0jq01dqpfQT7okLsiX?=
 =?us-ascii?Q?jqz7BY7JcFO+9Ux1SQ7vvazvojwLJvHODd1IwQT1nwkREdAw+kWcTIut6iJ6?=
 =?us-ascii?Q?G27hk1eFbuOSxTQepoeDDCtk55WF1R6FFcC4QBObgEms2caV2XSzR77A3KIA?=
 =?us-ascii?Q?n+dA9Jv4ZEfnvbKmyeLWEXSGZBC3p2/pGkRzXJzODmNYF/Umr3CVtiBeZcZx?=
 =?us-ascii?Q?RIbF8P3jsjK/w+ekMxAi1i+wqEzNhPeRS3EWbCpHoJkqWrKuQGI15DTW/SIX?=
 =?us-ascii?Q?8hetAAOM3EuTL38QwhX3d6gWKxdbLLCw/e/Q/c6DnGbNLw0LwT415ohFVY8b?=
 =?us-ascii?Q?DYrG+raf//2zLCLZYACsnBS7dorFWaxRYaD4xUgWclBOcomqw3ZEO/PBaWt4?=
 =?us-ascii?Q?1m+rMnmICCwxcQGcynlXWiPuIuZDx8Rdq2r4Gr7QkkyGSrJPJZMzadP8QiC5?=
 =?us-ascii?Q?kQBYLQA0XW9T3UtYqf0A5pKrIhWJ2j8DpnXlZNiklIw+lf1PtQDhL1HaXC0W?=
 =?us-ascii?Q?7Qztdzp7siuiQcec58pDYBdsXV1kdERXb3y6EHDvbvkbmlyIKUTBR0Rwz4iC?=
 =?us-ascii?Q?L5piqskGfVU56iuyxplymMe4Qyfud1Nz37SaaWZZPfiZWT0g/aChmp4oiBg3?=
 =?us-ascii?Q?0OOyzP5omSbCAE1tWuzLUC22OiIUuMsVibVmwjtn4QgP852P3eSntnwJPkqk?=
 =?us-ascii?Q?J+vStCSQLfpv17gyPpmORo3UnJyRwy4qfbuRyoUAVa3drdTKJwuqwnEERMDH?=
 =?us-ascii?Q?Cp9udX9gMAPQVOTo1fKdL+Mib7+/0M3GOUjo0dxlBMWUQBtasc599fclktP4?=
 =?us-ascii?Q?b/LyiH0eds85lN1hCUSjbNgPVAdHg4wNVbpdmGNmCW5AYJofS1rHIqz1iCBm?=
 =?us-ascii?Q?11zl8C32TRIo7tmGyMHCy6op+JpuasbVLfzdAXYj3Mu3ANqqmprwdUWkFg89?=
 =?us-ascii?Q?9uT4fWvNTRBgPT4LzCPbYXu2KfvQCIN9pVQyAUwIJSO6QK6hvG2KrTWBY2wd?=
 =?us-ascii?Q?0nYsWmNGdfxudV9YDtQ9SirIsuGeescCu1LU8AAyvdWbfOUa3RfZJX+MpAw6?=
 =?us-ascii?Q?+93UhSIpO0EoCRba0Vmqv8dUGjE8D4SFwS/EDxxlByoS9kqBQGQ5MFSyr1GS?=
 =?us-ascii?Q?ermSRspa/0/gyva48VE1ZJpbjnCbICkON/H4tVF+mhNi/2orYVzdg3yTZw92?=
 =?us-ascii?Q?NO269Ic49eWfN9tTDdviVTXn8bJQJPedKI6hoHamfrlqwZIPVTPMOCY7uA0W?=
 =?us-ascii?Q?Z6y/k7/r+CWMcLP4lTYcRgFxjMyUzgA9AABlWtE+Cw1HMpXTYtI1VTX5hkhZ?=
 =?us-ascii?Q?XUllATvFAJ+WZx1YC2XoYTiUCpq2t/b7IpZfDDAD29qyoKDNZZ35/vPGzY/l?=
 =?us-ascii?Q?Yn3qV9JwQVsvkz67CoD5dKUxowHS6u4Ue7hEmeuuikJhVlVnzPWvQ4dw/4pw?=
 =?us-ascii?Q?l3Me8AADF00xtDAiuDl4vy0oJQ6qC7t4wfhtBLU6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60606705-6b32-4700-7daf-08dd19915818
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 03:10:19.7227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENGsGeLHWP2b2qvy6MnzlRKgGqLr2WD4Kd13GE2utWT5iq961q8swgjhMQ8yHP8YPOMep06wtm5Z+L4y6sTAuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

Register m2m platform device, that user can
use M2M feature.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/soc/fsl/fsl_asrc.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 471753276209..677529916dc0 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1384,6 +1384,12 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 	}
 
+	ret = fsl_asrc_m2m_init(asrc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init m2m device %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 
 err_pm_get_sync:
@@ -1396,6 +1402,10 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 static void fsl_asrc_remove(struct platform_device *pdev)
 {
+	struct fsl_asrc *asrc = dev_get_drvdata(&pdev->dev);
+
+	fsl_asrc_m2m_exit(asrc);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		fsl_asrc_runtime_suspend(&pdev->dev);
@@ -1497,10 +1507,29 @@ static int fsl_asrc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static int fsl_asrc_suspend(struct device *dev)
+{
+	struct fsl_asrc *asrc = dev_get_drvdata(dev);
+	int ret;
+
+	fsl_asrc_m2m_suspend(asrc);
+	ret = pm_runtime_force_suspend(dev);
+	return ret;
+}
+
+static int fsl_asrc_resume(struct device *dev)
+{
+	struct fsl_asrc *asrc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	fsl_asrc_m2m_resume(asrc);
+	return ret;
+}
+
 static const struct dev_pm_ops fsl_asrc_pm = {
-	SET_RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	RUNTIME_PM_OPS(fsl_asrc_runtime_suspend, fsl_asrc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(fsl_asrc_suspend, fsl_asrc_resume)
 };
 
 static const struct fsl_asrc_soc_data fsl_asrc_imx35_data = {
@@ -1538,7 +1567,7 @@ static struct platform_driver fsl_asrc_driver = {
 	.driver = {
 		.name = "fsl-asrc",
 		.of_match_table = fsl_asrc_ids,
-		.pm = &fsl_asrc_pm,
+		.pm = pm_ptr(&fsl_asrc_pm),
 	},
 };
 module_platform_driver(fsl_asrc_driver);
-- 
2.34.1


