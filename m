Return-Path: <linux-kernel+bounces-301053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2795EBDD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D94D1C22C83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767FD13D61A;
	Mon, 26 Aug 2024 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="U4MONYjr"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F813DBA7;
	Mon, 26 Aug 2024 08:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660523; cv=fail; b=HPRLTQgQWN+qnGt+52nSTgSPsNGTcRVt98+voFgjosFPnjSoSbBaUw1j2GqRfBTOfbmpTJPmHmojDYFcSo7pVMlk+JvEPcLlGdRCN4ZQ6cuk2g0MhWHvka4r8Ea3VsvZvekpojh17pbHS/y0aEcMKCUUMhuiR81Ymhwny97Pye4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660523; c=relaxed/simple;
	bh=YVBSjMz4xvwGs2PRVw+m14n4Yy0III8Kgb+kgRG7l0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsW7SNpmM7kmeKE6q6An1VZCf0uwCsGZ/SvRy7s8W+KH1WJieVbtVF6NwSKU5QhjdKj8AANM/coEqnbtnpjIuTB8AaGonJAPHglu3KJFg3T34FToHHhX1Ffwp1BmDd7UwQrwoNpsiI2NV62VFJWuF3vK7Ozjyy+1ez7rePQrDiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=U4MONYjr; arc=fail smtp.client-ip=40.107.215.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=il42Wti7pc+SLjeudZNcnGM4zsjLpixqCQe9SMpvqqp3CmN6IYvPjqoJN7Anh9Sk+O0VTfY7f0+5cS6waWWDeodQUngvuXwnmYcgm72c6vo2X0qaG4LMN50cTb22yZc/58M9yNm2zbszc2mdwStyLZZX5rpWSmEgyVFLIZszPHepVmDCYCd0hdbdoqCBdwHaDQhIJ/EChZEnCdPRycDPop7Y/meAe9hCPv6Lrdu2Qt+Wd78h3KEqgoIbCwUQeGzGGqdqcBpwIxJSOUJYE8FwMlnDYpSyya0f+oujyOtuJpUmEEKI60Lh3L38ElsVHQeFPG/M0gNE+bmuL+K0G/4eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgIF22dr9N5cHfSHqoggAe1n8qmCyyRhjhPVgM+gwNc=;
 b=hLl93hDFGUoZ67t0B7KNazVwNLrOF0fuU+Qc9NI2msWrXxneqK83yWwXyTwpaAHZbQ6RFtOTzALdqDb1mof9P5ZVll/w0sc8r7/SXRcknqTDZkmhg8fFtvL7anth6ldCPzkWZnrWkB49siZwxkR8eXW2tNYR0QImzE9kRl0FLkmICCxppjXmSw4iVFPTgkwN2BQfv62RYqeZuvfpp1ELcHjiNNDAaSGSH5ao7zQRYa0rub3qmmsYjsoTEyxAcla66psu8zhjpOnaJqhlVKcubpeH0E56UnE0ASgEsIqB1yZP1bJxiPvsFdBhKhg+lnUC2SxNGKDK1jKwNFW/GIy2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgIF22dr9N5cHfSHqoggAe1n8qmCyyRhjhPVgM+gwNc=;
 b=U4MONYjrpAe+zlrt9YMAwMpJu8L505A5gg6ku9eHpK30rIGyRoXSjEdVCJrwuE/sQO3+tecxuKkXP1KKjrTvd1R2UlJPiQ81m9554gpoakrUT/M3B6YqTY49dF8KhmNgYzAGoIT+t6GISYGjabsmPeRNI1uiK2A38QUF+OplCKwAWkz2T2YrKiZxEDrcGXRuhc2n4ZrDMA/2d+L0RKCf4BmVZmdd/56mKNAmUg7LMR7SK6fe+rAkT4JIUYN43apPvv1mtAxQdjvgOwIkmC0QZwP0My3NC/023PzIbU2RfiaLg8wG1Jl07KmjyfIvZWdKxzdkOx2nJZbSDFPKtsLdPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB6054.apcprd06.prod.outlook.com (2603:1096:301:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 08:21:57 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:21:57 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v3 1/5] usb: aspeed_udc: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 16:21:39 +0800
Message-Id: <20240826082140.2311-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826081900.2284-1-liulei.rjpt@vivo.com>
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0056.jpnprd01.prod.outlook.com
 (2603:1096:405:2::20) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: ef32a74d-2fb8-4b0a-7a2a-08dcc5a826a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0OJhIANrkzCUIBM6oruxMGZ7JUJjIrl36Vw7Xd7VQpJWQE2DFlqzQGYFfSYh?=
 =?us-ascii?Q?pXTi3CL8AV8We8TmM+aQSVq138BLv/tdqFZMY/uO3BVFSWme3P11OL5DhYp5?=
 =?us-ascii?Q?4LtyNKWZwltHSseBfI7R7KDbbyL/29SMjOqek1DF4IC6AgedYZiucolbM4HL?=
 =?us-ascii?Q?phBAWSfldbVYzhuUVchg8cq/N+5WTJH2a0bAKUn73CBHQvkV47Q2T8OPVGVt?=
 =?us-ascii?Q?emi2sdV/q24GsyYFwygKCRVFnbzkfkoVCVrTRbvcUzdfFGRrol3gRgQaaDLC?=
 =?us-ascii?Q?zBO3ndPqbjCHoVUHvU3JZ62fo6C4e6LK4Jn5I0z7tlKtxuYFuKSFufZd3hPR?=
 =?us-ascii?Q?KAylP2jLJUqj2BuRmQC95X8g8XcLgBw/psr0iAhRu4brYhyYBm/nmpn8hSZo?=
 =?us-ascii?Q?AeBA+FB1spn4cgDVFxGT9rpNJ4v+wCEAk2GQjWgVTZz9n7Ccw3/rl15t62nZ?=
 =?us-ascii?Q?D0TuRvLfHGzy52YKM3s8zYHMAerQbeCqo5fjGlQ3BK6jBk3rNHJfFCNG6uaH?=
 =?us-ascii?Q?udjubDo8ynYImaPfMoXjM7kto2ImloWj6OGNFkcg0HflV1xhXE7Iekfl7mpF?=
 =?us-ascii?Q?R1kEstyosmRKrOJ8e8RWZJQZ4HGAy07C1bJ9Pj4eNFtc+4K2CEjiexMX78io?=
 =?us-ascii?Q?ZE7a46lHTOEkK2EWBpA8oZwrsX2r7POcxxTxrOpLYxQmLjHMMJ1+081WnbmG?=
 =?us-ascii?Q?fNcJNgwKYcW+01IOgDrcr+Axc6MCExSuOJFXgr9VTCNa9Vf4vUSpyl8yGJRV?=
 =?us-ascii?Q?6Wzlpo4Oo+K4gVD14y5MbMt7kUU4KeWyZZTCayMGfApB9eOVt/TiVx8NfCfA?=
 =?us-ascii?Q?KyeseLVfOFlHY++O6apQNj5WZN01EnbuVi5lGSn3pGoEwQX38usp5GMeax3c?=
 =?us-ascii?Q?4J91weXU7u6tTQunKQFX9FFCnyMdXjWTdwJZdfbb+MimshmIChrhkw0WvxDw?=
 =?us-ascii?Q?5bQUSrSWZLzdllEhMohBIgf7v/JzNtHnh1NZ31wW75uCGhVZxkd2W+8+O6Z/?=
 =?us-ascii?Q?5OwDtVE5L60yLSOCPl5AfFB3zvdMmawvDNDt04gQ203RHc4JN+w0SoCiBEWz?=
 =?us-ascii?Q?q7uC/V2OmfE0J1emfWKlqbE42aweWuhMMgpONVcF96JzV/ytmA0SI4ml9cc7?=
 =?us-ascii?Q?kwjK4u8MKvG9Sx4CX2eS1ooQqR/TS/QRuj1ewG3+rn3Z7njNNHHHox49ATg2?=
 =?us-ascii?Q?a+yy0HKWHneYu/1zMvaFPbP63G39HlY/n6/+OZbfqn9uVqZrF2OGlo2Ri2g3?=
 =?us-ascii?Q?eQLJ7q5piviPce3xBOYYawubRRo9AOy6vk8f6X9fw7iFRTYZrl6UuP2RHF4B?=
 =?us-ascii?Q?7Q+7Llf6uPOIEhE0za65U4fCTbRLGiED1nJLtZGmhkyTCSM7rci38it9t4Ko?=
 =?us-ascii?Q?I2oWAqDna+d/VzMbUnxA2qk1a6YNLBpxJVn3COU5HPw9SEJoFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?erfj9mjTpfMyMLoVEfkRiNDcr3bxAAMsFrbZRahyxhn2l+zn+FQQOz95D0Lf?=
 =?us-ascii?Q?z5O87DDtZYmn6WPywRuBfUPkl1R/CeL/vmBbbfw8X/BJSm15Ab3JwX9W9Zem?=
 =?us-ascii?Q?QYNstDwLcE2zZZ84H5ujRbMN9H+Elw8uUMrtWPnCzsk1x10Fi16XzMpMqxKs?=
 =?us-ascii?Q?+EyvGONeLH71v0aAwXfI5InLmnmwVFPDExGq3FiaJPHWKUM8/5v6hkl3IL2y?=
 =?us-ascii?Q?WWXca2Pe+rlys3XwwHZOnVPI3f3lHEj6tP7ZC42PQ2VzRcPwHyVp6dBaKTG9?=
 =?us-ascii?Q?7/1OlX1frF++/IXqfwJki9xDmFXrRRXnR9q5p9wIJvZt9fsPcYLLSftN+znH?=
 =?us-ascii?Q?5tJd6U/tG8tU1x5Q21bKvOOeLpAU2rVUos9oKR6lbqaA30EVkB6/fZowBUic?=
 =?us-ascii?Q?1vL62V32OaLK9Ln9rHY6gAOrWnr1Vq0O6sKMJgcnuR/Ek0gJX0OF9q10lvEv?=
 =?us-ascii?Q?uv6ZGKXrfhk4nPNVOvXHQsc8Us2yXRds9NcYPEQ+lFKvSmp1ezHeDegFeZH/?=
 =?us-ascii?Q?lOivwt6B6T4Nwlfac8wA30QZGldeZNgK05hbYqZkHdp73UNclaPPF2BGajHv?=
 =?us-ascii?Q?CSyOiZHMqQcv2FDkCbyA7n5Aq4ruuxsJwvycc3rBYzjM1YB3NJoOw2x4oF7r?=
 =?us-ascii?Q?SbKHJh2Uv8pZ7xmGAXjq4v4Fg+qK6r7f+q6L/9mWR+zlLL0+yJXjZ+hCL51E?=
 =?us-ascii?Q?PA1zBY7RK9J6Y4L7yop2hLdg0fyYggDn71bSU7RNput9Slk4XHiwtJ4qxG+r?=
 =?us-ascii?Q?Alj2y0lOG4N40CBY+ZGfB/tNRC+Wy5jPbmU+IcVCebYIqRrXIUZEKcqJfm1+?=
 =?us-ascii?Q?7Ua94jze3y2DzKyqRY2MJyFKeDZOkfzgQGUZqwIWjBUx8td4AJZTTfF7sqxg?=
 =?us-ascii?Q?4dqr5LWrFCStYNZ23A6ixWYx36nL7tFJ/+WVRs1we4zW18Bjk28DLuom4AE0?=
 =?us-ascii?Q?OCoPVIXJs+ltzo6CiVQBB9Fpoz9FTv3KYrZsIf9yICrzw+5fiXduRzisOpgM?=
 =?us-ascii?Q?lvqetdBOnxAz9UNa7Cb7DdB2WaJ3JsgJEuZ2WaL0NiZeeBmixGnf/xVCW4cs?=
 =?us-ascii?Q?fKbSZaqzFEs9AEDARSJ23wjEN7S108tpMDTTIIgnmowECrfCJ/+Np0QsdcYU?=
 =?us-ascii?Q?7agrUsJByAm4HXSweKfzR4KCNGpbNauXFyo6isRoUYiZEewHKp33UtxZK1a4?=
 =?us-ascii?Q?eKc9ELLeIzcFn5XMVTZiX6a+5F2L22eIY59ugTA7nxQm9wDlMgzlrNHjqWOa?=
 =?us-ascii?Q?6MVDv1q51SdWFpe1mhXS5YZq8E/twkRYdfKf2lnnjzfZI/RJhZw52o43cApf?=
 =?us-ascii?Q?oRzfcFtoIwGQEy+AztVcjMScKWkfewpMbY99xxJsmx79kJsxah8PQyUZG2gx?=
 =?us-ascii?Q?WscUGJieDfwciU0Vt7dziHjvV2zerigj+wDCCONmNj8jaihwqJLMgGrqpJRl?=
 =?us-ascii?Q?Z5amiYo+qGxGu+Ng3gbRDPql7WCHBeDiTJBQdzgIvaujg27hh8+SXuFtT+cZ?=
 =?us-ascii?Q?ovdFzwIjgQAqwVDKz8EIOcNngXLlkevCdgS92ng/1jtxcDf+Qr4PioZvx99i?=
 =?us-ascii?Q?pyLYrJD2gwgSgZA1bPyhVQbj0lP+eHchagqJDFIk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef32a74d-2fb8-4b0a-7a2a-08dcc5a826a7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:21:57.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp1d+PeSB7l4oKi/hEi3KU9E7WVLgQ9cdTiTXtFKkvJsRrRFOOxe+zAzATkHkLBmHPalGjMftN+mav+Ym+s4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6054

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index f4781e611aaa..a362e31f7550 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1459,8 +1459,6 @@ static void ast_udc_remove(struct platform_device *pdev)
 	ctrl = ast_udc_read(udc, AST_UDC_FUNC_CTRL) & ~USB_UPSTREAM_EN;
 	ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);
 
-	clk_disable_unprepare(udc->clk);
-
 	spin_unlock_irqrestore(&udc->lock, flags);
 
 	if (udc->ep0_buf)
@@ -1500,16 +1498,11 @@ static int ast_udc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, udc);
 
-	udc->clk = devm_clk_get(&pdev->dev, NULL);
+	udc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(udc->clk)) {
 		rc = PTR_ERR(udc->clk);
 		goto err;
 	}
-	rc = clk_prepare_enable(udc->clk);
-	if (rc) {
-		dev_err(&pdev->dev, "Failed to enable clock (0x%x)\n", rc);
-		goto err;
-	}
 
 	/* Check if we need to limit the HW to USB1 */
 	max_speed = usb_get_maximum_speed(&pdev->dev);
-- 
2.34.1


