Return-Path: <linux-kernel+bounces-300875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6495E9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F352810C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9662C85270;
	Mon, 26 Aug 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qa4IGBd6"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9A78C98;
	Mon, 26 Aug 2024 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655978; cv=fail; b=n1jtlLl9I9K7SOEBi7DGx02niry/5L/BNBS1RpgdhXuzAvdHzTHynaYQ7F7/qx5G+BtO1EnQZp1oh8/q8pdVp04QaW1l8rNgAIPrCkjY1OWR5/8chNDa++RbPdLmx3yp2oIJy6+25vPQPLzW7BMfOpROCdlg80PqyE42kRsPXwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655978; c=relaxed/simple;
	bh=YVBSjMz4xvwGs2PRVw+m14n4Yy0III8Kgb+kgRG7l0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ve0fLTka1Prw2M5p8N0JIhbfMRgtU2bU32PXEafH9Gva/qAnj2km62Ww2AlLVK4qZ1Pl9cA6n1lmuYmhTSBAu/tqOwmldG6JqXPd0WiH+8Z38xeEV8MGds6RKYWd3YxJGNC5WwAcRsrcFDjeHj5aZpK/z1l0qz9NVKCs7phYXG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qa4IGBd6; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufB5GAgQ6Hi87oWhYbby/j7Ff2/iTdYml4IsitwVBWE9yd7vOjIUJd27JE5Xj/4zYtnsQ79bMZD7S0DSx87CWFmx1UDGv2ASEfS6LobppV1pm3dQRXyfO52hOoSQoCzxN6GhRgUA1uvgp1VU9aGRqOph+38mxr1YTNtI7/VAW7VQRT/8FE5161sOezZq1sCB8+ai5sO92xHs49ieBQJCJnKVOk/rHl3SNWMn1h7iyBe++DAmSxZ0sMD8y5lTriu9zIiSq/sn9du5vmvEmEDUOIV+BIccsOVY8n87OaGDCopLivnWVVJGrNFMJ2qObeV0P5IGhwu7w7jJ56NZeydLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgIF22dr9N5cHfSHqoggAe1n8qmCyyRhjhPVgM+gwNc=;
 b=q2cJW4MGZaESDKmRDRB16NNdhseCccu39BV1LFIyd8TLLVTjy6rxXsUz4IBCskQyel3DApYKVRW+iWVjJz0UV34I2a8JqS7OA01mOYURmSVvVjOXWzt5emoXFolnqmtVJ1S49g/CoOHoU3BvEGu1TzwlTggM3OjQvex4GkvPQo38hMEQO/SYen0qjSlqbmAF/6gLJ9jMB1n6fqBP50vIMrrSCTolEMJbtRwwvYRFRMAYyNdfgMjEDfRDjdhdoDYvHwsG7X+kchPj/upKPrJLw+bTUHxpVVt1lF+Rtiq/ftt/pjxrd5luoXA3fJ3T3CWYFJr9QDQmP4w7xG7WAOIChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgIF22dr9N5cHfSHqoggAe1n8qmCyyRhjhPVgM+gwNc=;
 b=qa4IGBd6otPUd1BIxwcrAtSmN1cIB/h3S4q0zc8tbnBlsHHP5AwSj0/QGhCtefU3/hFPd1AvZQg4vNIm/dTQIhm7JdGfomlBGjIKb9433hgf37DAff7ttJn3TMvihREVgJb3aiymUpt1K/yGXg1Ih6Cpwzfumg7qt2uZ6KkhLXQ+DkHHObaDD9oAqXAoJ+pdI2bX6ii0PY4IRctr32ue1YaW+n/cgtJFmDrP1W0MINFIQJoVQipI3n7TQKcXfg/ByJbeHH4qoVjJDeSa+HYOQ5+ckTp9yb0oY02hdCRfHhXdU0+FxBtDYhJgAS5up4RIaj3pu8vF0eDuf7p8wRypbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:06:13 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:06:13 +0000
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
Subject: [PATCH v2 1/5] usb: aspeed_udc: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 15:05:59 +0800
Message-Id: <20240826070600.1871-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:404:e2::21) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e43008-232c-4899-f683-08dcc59d91c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?527THOvlMkbPCQwq2iaePMRTr0ovuOH0UYMnMBQJLeTo9AymfMn8FXB/YlGt?=
 =?us-ascii?Q?xPypp05SpO1H4V06ucRFpwQYO75feQWiKU6XoygQROmpgON+PFmqU60yi+7Z?=
 =?us-ascii?Q?D6oHj56Dcr35hedQEWDfyW/73WbI2dAUs3nxaaOo4bi8EpN4GzawsKKyAnnT?=
 =?us-ascii?Q?XmdjXaU2f5DK/dmF3RvAxz1lxyL86U9qO7z1z36DjX0iGzQfozwqIhbuTgxf?=
 =?us-ascii?Q?nPDpzd7VylcEO+VBd4Qy+CZ2rHNp6eCvL62PyDWkAez8b0oh6EmdHY7Gklqr?=
 =?us-ascii?Q?mkJP7bVHYHPdaNt8AENIIKrwfQvcpzHZ/Y3zvVYeWcH+VrhyH0lApwgTjP/T?=
 =?us-ascii?Q?Qr979x6+v+OhvERD5I/yO/zkQ9YJXQgoa9YS9DJpv2ITiG/pqSBJ0W1/3w3o?=
 =?us-ascii?Q?6eiLrrRXAZvUQ83RQ+5lTDA/26sIj7ZWZuKsZkZMOs2G9XCCTns+KRnbQiig?=
 =?us-ascii?Q?WxtTipWyCn0tOU5FOE8kLvmn7vpML/4Cdd7EcBAmT9lMGgAkMHMAf3SfR6vt?=
 =?us-ascii?Q?FCo2DCInCc2ArgRy78ZAKLBZ9/3ibq016TkLH6a1vDItcQeyLgP9YDSgXzxA?=
 =?us-ascii?Q?pgZsivCgI1t5qMBLBJhgsxMKFBpfzltaEtbqFCZQFeVzkdbCYuVgv1daxR6R?=
 =?us-ascii?Q?sGf04sBO4p0ZfFfjrRzx7pgDvJlBlU5j/hPPy3ceQK5bfqwIREqwiufMYCKX?=
 =?us-ascii?Q?dzXilT8dh+E41FzOAphVG+2lQ9z/BRD1D/EaJeokVCLpPc/gid+MoV664oPV?=
 =?us-ascii?Q?nFYaN85kPuacZRNJ/2umUvz8LY1DBaCH6rr0HpiuwFL8by2Ug9ZBAGfqYrIH?=
 =?us-ascii?Q?pke8ZB/XOmVMTM88GYcMlwB8/J+Ww5V1Q274LkzBSBzIkbkNYq+tybVNHGEc?=
 =?us-ascii?Q?I0Z15sZndBherOwqohhZ/zYZ36t0BwBuXI0I9ZEewbFqqGA653CltuwnYJ01?=
 =?us-ascii?Q?EQD69mP84Rsf4HveKgoZjhnoLQvSg3Rr66eJnRG8+fJOqeXi/0F4iNfb1wT1?=
 =?us-ascii?Q?w8GPZB22XvvLej1LUZYuDN4z92vVLQlXE4Uaenucx0T6DIvmCGha6u16M6Ww?=
 =?us-ascii?Q?dQkjMpyXKh9kC3SVG+7ZPX3ESAKjB48l/htKjwI1u72zdgfWo/cwqZmMg5xF?=
 =?us-ascii?Q?DupToTmXxQOfkfN8El5oIwx48cj4Cznc0fcfuZgWVtQV3TWYH9rmlqOl686u?=
 =?us-ascii?Q?LbtlGl+ffb+J083vZddQh6zXlTZlN6c3/S/CDbgnMFgCl6OI6Ac/ovDzHJiA?=
 =?us-ascii?Q?5/D7niFRUXoYLCTLa1ztXEoFYuabXzPRJ41rYtg4Lc15U+ec7DaSxHWysVhT?=
 =?us-ascii?Q?K5Q0Oz6hQbPl9F1vOAi8ZB6463Jg6+2epbyFVwS2N0goDi7Q1Arp/tus+FlY?=
 =?us-ascii?Q?UI06RnaEMAlZ7CTeO+06U5A+yKecZ2qZUKXBpmiJkDqSMm8ysA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6xiTyLT7arX/9K4bw1aOT3eUrfNkSpM/zHVRTLYLyvGj9fcf7PSSa7biRwtt?=
 =?us-ascii?Q?TkOrJ038OBupLWGQYnAjDS9uOCyyln1O/j45wCQsUi7KWAuZq/FaUOpEGAI6?=
 =?us-ascii?Q?sO11S452nqzsgyjcoVspZgHfJvPHomo2c61aFl+Ivzc/qjvvOJQYvDyG/PN1?=
 =?us-ascii?Q?n2pTwRc3wma2/Dk3XqoheEwYXoz0kLusrpEIp0RAcIWVuWlw2q7azCtfM50d?=
 =?us-ascii?Q?ijYEmcbGzoo1cuc8vTDPjfSLxSXTHT3sRAhjOh6yBADiJUg8UGmR3Phd/oEf?=
 =?us-ascii?Q?MkZfokG56DPaw6qeGPqbMVrq+0mQQRPMBKi3TIs64f9yg9w0eFID+C3GDQhe?=
 =?us-ascii?Q?ZFwBVBq5RZzD2wsqjbq0Wqjh3y8FHlEP2hnhiFlHcNxReqsuuQcNxdpWdDHT?=
 =?us-ascii?Q?1nF/JJT9sk7T0T8DlbHlL43yn20cWfsCIiMVbjp3OY3QKGRJIpIUK+YfgP2y?=
 =?us-ascii?Q?eGMOaOFceFrFkTIZA44kBmnFLDcfQP3yFaD1Cvem99VKqzIePV53rXEy3KkK?=
 =?us-ascii?Q?Qk7Gax/j+ixoMcxNhdMpC6x5C5QdFlowaJhIGjxV33WFRLH8fm/w/Ejc2wLx?=
 =?us-ascii?Q?X82NoNy93zrs9m/JVJoqbDpUynl3Ms5cqeOoNEbtY9FATb8FjcqqNUnxT+PH?=
 =?us-ascii?Q?p5a7vbtb0+9dZIzI6/dLL/VBYfE5iHuNV1Vlsb617fcn3QUfgJ84+XEqEASi?=
 =?us-ascii?Q?yeA88wn4/4SHKk65QaRMkDWqfkngGJ3xD0pKaZQ1DIMIYr3t6daSKJ6f2imd?=
 =?us-ascii?Q?n+vZHHJKfToCuZPHHrKhx7yC/nSKTTp/qgJ4LSD+wB3DXyq8KFltnY+GAQ/o?=
 =?us-ascii?Q?mEhWh4HsfY5DjKU/wrk6hTGdCkV93+DCx+paTD3wEUsJsKR9DHBXrL+DiPxK?=
 =?us-ascii?Q?xNu+Dwxk2OqDUachaV9kzIeigdDfOP9uDdasDs4aJxEIixpeNRUtYik2hYiS?=
 =?us-ascii?Q?pRJUOMwvcXoChD4eFHKzeNlZRk18shw2W7JP07SGOjiawqtDmX+kayI67zrL?=
 =?us-ascii?Q?lGmjxOveXYH1aPJ+ObrxIbXeJm3fQ6f5ikqc9tY0H6JI9Hasdn+4Gf7JB5z4?=
 =?us-ascii?Q?WAXrHFLwXpEp09OCSZx24C0ANrOjOhfoaPwmQeW1vJE9pAjFvYXObH8BtSoj?=
 =?us-ascii?Q?Qj+3NrEbvpyIsQTH+42Ccpgy8mFa5jNZMgK2/h7ijyRgEBaFOFX5F6Oi67xX?=
 =?us-ascii?Q?iJU9HGr6wVA9U8gqjRERB7kALO8HVTuVVI04DcOEdOh7kyDYHJgTuGZbx7jF?=
 =?us-ascii?Q?55eA7TqvgtwduY5jiZnpdqzUyGj4tO5LvUEbBPDRacQhQLbWcsSKhc+Rz4r1?=
 =?us-ascii?Q?qQbqSlzLeWMtc5RF/0G1PDkr4U9ttXmg1rQU4ROpNDEydOJXSW+ZWEi9bszS?=
 =?us-ascii?Q?5UQuBJnm3FNub3upCJvz8Jju0xEp4zDIrz4NC0Ml0IS3i2AjHv4ylwHhEljg?=
 =?us-ascii?Q?vrUdMB3tKhEx3SbrKtENWBE1L91BALdo5pFK4qpnH5k4QqizrSUM4+3tbejc?=
 =?us-ascii?Q?AQxJOvMBmgow/tpNlASfKrCAG+ivGKppub/ys6S/cc+2fa92e2EvDCpCNEFS?=
 =?us-ascii?Q?l4rfrjpZmZGM2hhknNZD62ihV5SdQcDGqW4OTaBA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e43008-232c-4899-f683-08dcc59d91c6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 07:06:12.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCrynoZ5JEc83RhlatGAvt2mejDB8F7e985BcqNAaWLBHl7KdFltNYzOrfx3HimybMWTJcRKdC9v6Y9ZEQhzeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6055

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


