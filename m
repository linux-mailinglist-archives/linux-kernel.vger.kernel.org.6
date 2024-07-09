Return-Path: <linux-kernel+bounces-245986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DF392BC5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332DFB283B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6E194A43;
	Tue,  9 Jul 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WYp6xbcE"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CB1946AE;
	Tue,  9 Jul 2024 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533674; cv=fail; b=rvNhhFZ1wqb3uelWvfJo23BTS9Sc/pyWEcJ1GSHsvPo+KW7evCrlBdzjpfGmwx4NecBvEXd9JfYwRDZI1hP+EzvghQhnwE90ra+B+spJZo9gernF7Iga3McW/5hLkxxWCOkyyO170V2KSO3CwbEl3Rzq/IKzyhANrzMADuOOJqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533674; c=relaxed/simple;
	bh=HxotWPlTV+jWU71TsiM5UmwxPXkzxMRSUZF1j7n7kcc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b7v6WDUUZutysgpbUaaIANrLanfcoxzGp81y9Tl1qNMBCb6SfYQwRQYNckAm6EHXGXvBQmV03m4odrlCN7NOkJInA+Nc2oeIR+m9Bel62yqnshpqRsypHn0VnIzkRmNnkMUhhlFDJFoq6bXAxEbdvfFoDQonWFFyq24GK/xW41g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WYp6xbcE; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mowuotEKKfsyrh7f+yMwcks2H/DnqXVVS8o8sshE8SED5KMwJhFwyJqR8Vf0c7bj7vdn5ziIrleb0uDXTper8iyw6ShnUmZHJebqSn2HGzU0TLNwgFnkpBIEsWuGAdl03WmfnEnHDX7B9Wf16Ji91jy6HoTsktwUiZGytNgJzNvWCU4jQkn/hDfGXHc3SaDp7Eu3DUZT4oz+uIdwhJZHQSiIdHiyI2iBHqGczvyGq/jACdRZ5/0JNN4CrWT3ooY8Dg4zFXZpNSIDo+gjip8enkPPMVtgQI5c3IM3Dzh+IzRm9M68QJrrBzSEjydZZ+p2ggSg+9pmVN/aiOutBFzyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPvKVu9CNdr+J0KVWFipequxEETydACxuUvVRU1Xtpg=;
 b=Wmemqgu4LQgGQ+XnlMKOdJZ3Ge6G7Uu3lGhI/HJ797ZJNjh83uS3cCDQol8W1KgYxP6PqSrl02xkRE7VKUWmRwPwtKfbJn7EJfdp830TjrorsofNS7q+pmtbSWCSt3Ob0lrUEQYz+03bR+EgZpElxJZcpjAvr5i+lZhvIFK1CcvZfyRX8qxsC+i16y66V3KEgU3utqA9jMEdcEp3vxD4Am7euvS4XtUNYT/KAj8R5gQVN4F8g85oi1Il1tAWG2KRyatpRnIKLKzbm5OF9vjg0CVl9G9TrI0guJVvNnWNPrsJKL2jEJ4khLEcpeZA2eqtezO1RDxM3DDS3AdzMw8oCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPvKVu9CNdr+J0KVWFipequxEETydACxuUvVRU1Xtpg=;
 b=WYp6xbcEpLvQyq1kMGmpRts7jmItWPT6mNNRSrIfg+qQFa6YZHk7TU44jHnvZuDAvJxfzvToP5GD3SNiIkqE0SjzzPlHJ1y/Pnk9WzMuSJwnnDlK+l5kx2ScbQrEhxUnOud2R11DjHOY7AZcOjXzzABvozPEJOFFfaMJzqxJRys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 14:01:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:01:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 1/2] dt-bindings: firmware: arm,scmi: introduce property mbox-rx-timeout-ms
Date: Tue,  9 Jul 2024 22:09:56 +0800
Message-Id: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: cb448b10-d5ba-4f11-32ae-08dca01f9493
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ffTR/pBqucByyO6bGtQ0mRVJJywhNfwNitlt64PnwFMZR9CTB2bOJA//08RK?=
 =?us-ascii?Q?Fneaeae0N/ix64d88SQRmOgzRQwkvSDUO1e6JlyQ5zGkqRitB2EEuwWjcb+L?=
 =?us-ascii?Q?w7Ems5C7CdkaAJIaNNaurMq/jPmLgvT8O7mKHTc8FpDtgv+kYkmw2kVMMWQo?=
 =?us-ascii?Q?PvnxZpxKY/j8A20AOE+i7wJ4CVDjPagCtA4GqqGTJ8E/GIRreTRhNWBtGPpR?=
 =?us-ascii?Q?RvgBlGyYP9z0N+ezQK2Lo1WqprzbfL06bQB5mVX1AaiHzEp/mfpXisPS43/p?=
 =?us-ascii?Q?BMx3iJgDHI9urzipBCfqlL7H7JGC9sz/SDuQ597lnoNzfYjOK8q2g18hlyn4?=
 =?us-ascii?Q?S2t+y24s99Si/8uLKnfNEbDr5P8uDLkNtYbnr07RouOh+FGY6fv3+zNAxepD?=
 =?us-ascii?Q?ZXWtpSpXzOvLVQXXiEt6LGUpkFtCjfjvrPz+xqFHndtb/YEVWuef/vwQMRLt?=
 =?us-ascii?Q?+2PeuuQnfB1yFAkLQGo1i69t59fwo0YlmZ0XZv/D91FA9+Pu3u1Es6Eh7et5?=
 =?us-ascii?Q?PPSqqWWiUaMnx8uRUxWlSUjXt7ZouUEz38/X1jpevL/Qx3KBju/pcThPtx0a?=
 =?us-ascii?Q?rM77R5d0a9z7iDW0lAfkIXEoYGCQBpg9fVKpu/ejNjS6Fpx3AyOsb03WtmpU?=
 =?us-ascii?Q?YMHvQ4WP39Py7wyjknerj56JS5/qVDneC1L+XEOeOXpxN+ofJvL6PPtCFRh/?=
 =?us-ascii?Q?Q+yx2YqWkNECTxtrkY/A9TNHobXszMYnMYlPWXwS3ORACio/MNynsDIsLiQ/?=
 =?us-ascii?Q?blWFyulRb5X7LbPTHGyaYd88w15PnAxTemBLgVzAzBV8UbwRD+XNbTmI7REt?=
 =?us-ascii?Q?GxFSW31+2mSf98eNzc8CNOlllkXlUgh4kgi4yWT+kpo3On0Kq6iveu4lKp73?=
 =?us-ascii?Q?oSfocXnRIQG4e8XZALgUAFujh8vHTV9iLLwrKcVz3GzmqScTlVkNxjOcVe81?=
 =?us-ascii?Q?VyklR76An4ZHkwwn4XRJfLrGYPhNxZxLdmt5tb9/ReHiqwjazbvmOFbRG6pL?=
 =?us-ascii?Q?vT0PyhgL26FFDsRiXMfRM26mfxKM3ZaJCZwn4NEkq0QbtVbG0Mq3OEYo+f3M?=
 =?us-ascii?Q?3JVhALWmI8KvvoQ3VZbh0npK0Pjl95vRIeGgScfKQWLrixN/8QX0SD3DtPEn?=
 =?us-ascii?Q?/dExcUJRcr/9VGpMUMykE3S0jxzMFBq94IGDEg8D/hrUOgXkPC0bPzvUOQM+?=
 =?us-ascii?Q?05xYEwasr8FWJ3GOPlpqwX/eX9bK7MFhWYy05XWXKiIyFyEYT6OVj3yWiXaA?=
 =?us-ascii?Q?etXwlp9vrdWbrfcXSFm6VagGKPiFF4Ud1a+cqrtw6UI9lJc9swFJCLSVmeC3?=
 =?us-ascii?Q?o8ETy7HWELExiKd2CaEtj3VWF6JGi/xn9SwXj/VqCVCqoBmbVZ7Hd44JF+cF?=
 =?us-ascii?Q?RopKiCvTokK4eq2eSTOfqQtsei8RvvcIih7zrggZryWfdeerRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rC5BmI6C9FYcjaQPB+d1kHazjwgFZnHkT9EtF+Ytju5T64vzATxP+2M7Aot4?=
 =?us-ascii?Q?0k+gLOG+WkDluMFKukEuiJ5WnqjM3EGW0gtfwXXYR4y0PHXMbJW89s7t7ViN?=
 =?us-ascii?Q?E9dC3ODn4kdtosz6JJ9eTTlaCDPayf07+fwF+nN7qp4GgPbTFh6E8p6VLifU?=
 =?us-ascii?Q?k1MFzO+diUl3pr+itAFQdyOx8ZiqsmvdYkJM2F6YlihlGel+tcW1QuDA+99r?=
 =?us-ascii?Q?k6fw56e69uPKJn8y47LBLIbQcZ2K/SXG1dr6oATQQDpVqqd3A9QrntjZoN+p?=
 =?us-ascii?Q?sS+OibcOnhYae474RvVMjpOIRDdK7Txw/q2R2oksnfgsJYZ0c5jJsHF82kTC?=
 =?us-ascii?Q?zLEfuWlRSdY1xzkACKDmnnV2ZcYCbsfuJnhAbCwxvAokefjcgd6C2YgS59HS?=
 =?us-ascii?Q?2K7tR/gUP0+PX4K/as6f5MxiP1/QnyKTs2SDTCw5pw7KQUOhziYC/+wVaQrj?=
 =?us-ascii?Q?i+OX6ZMFsO1GpMOhit3GAIPqUrqui4sebNHoQP6iDv81/gXXMXCv2OXtVte2?=
 =?us-ascii?Q?uA6IpfegLovrkVsrsCuDq01ZEUUIU2UVDUOcdiMOWDV5cZP7OKWyWPaSUjl8?=
 =?us-ascii?Q?jhKbY8QTrNDPKB4gYPnaTbR9zlJCfrQWQnoh1gjwiTyBS/Y4MOMoKeD1/YUh?=
 =?us-ascii?Q?YmG1iOyWus7akrW/w6f4c6FIyaT9o1z7XeFVVfRQrwOgp7v8tMTJLeO8FeW4?=
 =?us-ascii?Q?84JXAXl9MEjUMBNyldum1KyzICLAnLm8+KKvBBBuKgmb4qpPSAt1MqvVmqOV?=
 =?us-ascii?Q?1M4vEy/Tip0fWDNyW/n2v07I8E4Of2SfQAb05bCylDMVkD32wUc4gsX0kM8k?=
 =?us-ascii?Q?CDZCYzvymO0tpYRatGSIoPsW8thm+1ZmnR1zdwisNj767oKQXotUC/oYeYvz?=
 =?us-ascii?Q?qZ7X6N+efQ5ot7wqnkdCG7E5YFurmJM0orZEpNkNKo8ECG1MYakurwHELh56?=
 =?us-ascii?Q?ZOQiWgNO0j1s9NFysAS+KViQ1Wu5/CJ/bPwOX5w4Y1oYK9yVbQcoJAJbwNyh?=
 =?us-ascii?Q?VH1A4ucmmXZjDfsMD074jIdIoKI4oD5WRr+PCPhxCc3ZpZJtv9HI8IsNkEmG?=
 =?us-ascii?Q?qFDYGvxLwgo8FMGQRZnThplPp6jlv1K2/LydEOQb/nS9095v4p8kyXCi6PnP?=
 =?us-ascii?Q?7FEaqwQvzbke07YQNY+Wulva0+Zt2ru1WQSJGE+5lPu5uA/qwFwMhmu0R0gZ?=
 =?us-ascii?Q?mJpuKyu3TzotieAM7Y9J7r6T1/W/0B7R94wuMMpz2PZNPlozChMTriLO5k2k?=
 =?us-ascii?Q?YEuKVlCfL3eMay8axTL4TRrG3rBq0ODsHgX5luEdgnTlUwA8KJJnyV18Ai+6?=
 =?us-ascii?Q?yMd7fxCha9oBP1bHbY55I+2j86uOf1HIUmE8CI+6yr0+vH4XT5fJqNhEjkNE?=
 =?us-ascii?Q?SZp4N5fK2g+HMIH45UjgpOhU/zTJ7n7jLgtU9xnCKa7Gy8vi3rK8iwvDKHlM?=
 =?us-ascii?Q?FaJGwcUwGJCCzIgBdKnnvC8sWH5BfQXmVNatWSwf9ejHJGj9hHeCOVSxAP17?=
 =?us-ascii?Q?96XggRRd2sOqrQoPrF17N/Q9IBi1CF8UIQAoqPefBn8FgtaxbSA2k5tbri1A?=
 =?us-ascii?Q?EVXUcVxlu6SunKY2Na9FjtU4qdrLX7A/JReqTmiA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb448b10-d5ba-4f11-32ae-08dca01f9493
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 14:01:07.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2l72GiM+IZhFYvdIzMwX97ovC7lvI9bWOy6EJyxJ7YgBBoHHCZ1YPbqV5NYHABc8UuX2at/r9hyO60Y8PqB0Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

From: Peng Fan <peng.fan@nxp.com>

System Controller Management Interface(SCMI) firmwares might have
different designs by SCMI firmware developers. So the maximum receive
channel timeout value might also varies in the various designs.

So introduce property mbox-rx-timeout-ms to let each platform could
set its own timeout value in device tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Add minimum: 1, because 0 is invalid. maximum is not set,
 because it is platform specific and unknown.
V2:
 Drop defaults, update description.

 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index ebf384e76df1..f84a978a36b2 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -121,6 +121,13 @@ properties:
       atomic mode of operation, even if requested.
     default: 0
 
+  max-rx-timeout-ms:
+    description:
+      An optional time value, expressed in milliseconds, representing the
+      mailbox maximum timeout value for receive channel. The value should
+      be a non-zero value if set.
+    minimum: 1
+
   arm,smc-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.37.1


