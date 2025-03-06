Return-Path: <linux-kernel+bounces-548245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B33A54231
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC621697C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EAA19E98D;
	Thu,  6 Mar 2025 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oDnj9ofm"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6E619CCEC;
	Thu,  6 Mar 2025 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239252; cv=fail; b=svGl2LfeHsa31gSvbWHzn43exe1dhua5tUKuwHpG+oKDFTAeFp+qsLFMWoIAaKJePpobP/MjZuBW3PKISjeH/Kn03QVWIxIjTZRGXBmba1sbKGaaatZINQnuGU0a8ZRglZ4zPyJOSTa6SsvAbjSyDNS708YG+4oKadBHdlPTcnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239252; c=relaxed/simple;
	bh=Wh+vtRe3ga2mr0EP/2kelt2uayYXoJnaL601+KYFmKE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a23ezxi46CEABu1ScFvgxTIXCNk73zZaHl3odv/81Ff6pFY/AF3e5gNz3EW7nUckLTJan5qKBmU2+sovKDTpA8M7w4spYQ5pW/1dEMeedDFmGLMoEN/JWThTAL8dAIZj16GI8Ju6PRrtWB1koGtQ8E3qePPvAeAqRnFEzLbh/HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oDnj9ofm; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSxXRGmKA70STaCy7d/64XF2mW7GuApRUC11zIXJRg4y78V1ShFt/4B0hrucvhk1S732xzYp6W50dRTnBFywD9WjTfRuhcapQAJL+jpCbV1KZaCT8UgnmjmpCrUXwKjr79vET6TrsqcvcJaGo1xm97wWNwfco8dgj9SMnNSbGvpiouMqHr3uvD0VoEko2KNsjAKVxm7ZSwFSwIXIEyqD2Rmi4o+FaCkaLLH5pgxKKnztyXaSuDP45S9Hsx+K2WFxJZkfAWBkBdaPAgY0zebL5WxbAObUIQZ1AYsvhKpKfOmBATiJmIbArWvrZP1kf8GtXXW3m7qGTVir/tqPUCpSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPydRSf+SWJT8RZYbO1jojGsE6y4hgh63cQghY7Ozyw=;
 b=vXsDJKHtVXkzTHwATMGdaZyTTQYPuLNZaq/pk2qB3vwbxn65vnw7KBBgMYZ1umzGsyAu3Se7hToCmXf2yEhWd+5IYimC3LaXEQc3FgZ4CCiPL0AlflMUJPPsRNwUJytIIv7tgz0qXvY3t9cU7kOzsPdhXVRrKj/8xebt26FKN/u/N+OfMId9X9exYWyw//5wmnYJ6jtiM+vqPfpBtZNTFR92jTg5ADsYKW/4riGiNUAvJq9LG2o6Yi2zhTqC4yRE59ySBnjynaFqxQ+ndAPGxS+EF0kleLjIattcudxXrG5m3fglaZH5zJr3A/gggFqj2L5tfPwZngMBxmjCcMtf+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPydRSf+SWJT8RZYbO1jojGsE6y4hgh63cQghY7Ozyw=;
 b=oDnj9ofmNjmnaD0mmpberZqbgA6kMyR/Ny76dNDbLqae0ZzAgtkGthM0RFf8ebt7kOErJwMR7VWSiVPCc8GVkm6u2T2DWwk7p2mlk79+7tmCX8vZFCSHO7p+jYnpoWQF+q6qD7ow2WKshdH9tJfU5N4Uui1BnTHHUv+y1N4rm3mz3wDnVbfAiJcK/Wf+DfdXmcekqvAL/RmGOS5yYFp3ECZzYiXBhQNlkMbU9VjyYgBiAeSvoCbtzxkKpolF4YvN0U2lZjGuBDgEPbeIva7jqDrIikUKb3dgZOYNB1mjLjQQs6Txu4RI8k3OIPjTny97Kl8mCDcBGrfNuPnunh3e3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DU4PR04MB10362.eurprd04.prod.outlook.com (2603:10a6:10:563::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Thu, 6 Mar
 2025 05:34:08 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 05:34:08 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH] ASoC: dt-bindings: fsl,imx-asrc: Document audio graph port
Date: Thu,  6 Mar 2025 13:31:38 +0800
Message-Id: <20250306053138.1914956-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DU4PR04MB10362:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd974ef-e611-4651-a05e-08dd5c70840d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?juk2hwp861CKGivjKwa3OfBK8uK0qpI6YFk3LSY6XIE7x5RAf0wxTsff5kw7?=
 =?us-ascii?Q?Js3XmjVgZOeJuyQ26Gl6i+tpCjylb6eTnBkxHi5+GfswSRJR1uDIhMotW6Qh?=
 =?us-ascii?Q?3Ypv0W4Y5M0zy/89yf8OQv/oUA/nOA9X9P5csDvmabmzSKGRtPeZ67phX4bI?=
 =?us-ascii?Q?FpuGOEnOcqjwVRurFZdgOZxkWORQtxlgFInAMuwLd9MyzKNXipYdAYO83ZZX?=
 =?us-ascii?Q?47FS0qBI/YzHMrmQWyt0Zombn++qNvFgZjnrnFlDwkFhR7nbCxN+RIzbawGw?=
 =?us-ascii?Q?iemmYdGSczzSvp0vNSVaLXFMjHy8wq00HceeTAMVdv/wmuHvG5C9Efjq7CfJ?=
 =?us-ascii?Q?rXzrofCZY9ujJn3eH38RO4iB0P0cA94QmBjME0EGI5b7IAWR1TNADhJBJAfj?=
 =?us-ascii?Q?plym/ZD/t0Y9bX38ISTB8ewxdyLzqXvcrpwVI7xBKre1+xPf1cSncZkUo+UW?=
 =?us-ascii?Q?BaOh2viGRFaWgQwi1oAIHB/qjrY1T3VcgcAuq/ZII4gRN2bd8bqm2w3vs4jy?=
 =?us-ascii?Q?sWzjaHIUeYugWJpnCXdDnzTS3N93ulLbkfNh69YP1j1ulh8S+Oii42S2X5Ey?=
 =?us-ascii?Q?DWlY2ZKItV+1+jeq2HOu67DX4u2G5CUI5yq0upfu8OaC4F1zl03e6bGJore/?=
 =?us-ascii?Q?2LFJP/e2W3VkWwQcuhP7x837bEdw0fPn6DIGdQdw02HIhlTFE3xR0Qi6NwJ6?=
 =?us-ascii?Q?bhaOzAmLDe1izdA1q+xmvIrzU6BiKRfMm9ORn3/ifunrt4WZAxQauW4tTw/8?=
 =?us-ascii?Q?RZkrcmmieEpimrcvIQchhL5kCOLi5bq7y9D7H2fKDXyS2NwHwj1WPNh+EOE7?=
 =?us-ascii?Q?QB/y11yNNDr82aslHzTuc7heH+RzVd2V/taTk/5twuAXY2CZWBui0sy0uG2N?=
 =?us-ascii?Q?fpJ2eFZwAzDLm5hClfbcTM4VuZTr8tD4uIHz+N5QQGu7AsPC1QqZ8HDucnTs?=
 =?us-ascii?Q?VdQtZz0Ce77csSNL01sZbqIhO2kBEYB1jXpY1Yhfr/RlNiJuMOIXAN8TRZkA?=
 =?us-ascii?Q?pA9SVl3N50s9pHmjy0ybkRsgA/BwMtO0vhXmK/VaopWFbbSSYDA96rt3CnvX?=
 =?us-ascii?Q?GibWbgws7ter18hR4Z8/8STuOhWx/mxz1stJqn6LlGu6t2rljSFD2RVclsSX?=
 =?us-ascii?Q?Q7RC9HNjKNZxy+c/G5Xcy6OfB6oHXidehOWhmBEqkohW2Dvt7/4RGhvh2v5Q?=
 =?us-ascii?Q?IVJBfebPU5yV0CfhuqDzj/ld9s+k4wYMHmf+77B+pacUNv5xw2BIpCkeypw9?=
 =?us-ascii?Q?AWFvus7PCAv5DmOJzNlZFZD8KTGVKz6bkmUSDg9S7ASrYIjhWbuPBn24iXQ0?=
 =?us-ascii?Q?Fcm5dCC4cNQYnOPJVqby4IB7/LwO47Oz1ggf9M09JF8i2LKPAprRMDD/E884?=
 =?us-ascii?Q?DJhUym9t5bd2ZL+Qe5RpQuKKy4NUat2Us/AKPjhmkOiXF8OnpNrU6wkhh//1?=
 =?us-ascii?Q?7o4GUvDBFz+cyz7Fjn9ftG8C6muYqqxcvkbH1PLVsqEzmFCscMWvsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vM1Va/J/Hh1OX+Tcy/g6O66bRTmBMFjEC9d0HrCXWxo7OFoiV1IFHgw0RlOX?=
 =?us-ascii?Q?VMPeCvVq/mlWzjcjB8XOonGgY3DGB9hH9AmckKGIxkAAKAn+qd8Oexp4aBQh?=
 =?us-ascii?Q?0LwuqaCsagzIbPZ8jSF1h6r9VNbcPRaLHP8c7NyO6YADFxPIo4AppuOj3qp1?=
 =?us-ascii?Q?0LVOIGN3RY/kysUyEVN7UkawjNbastVfOn1omROSybMugDRVLmn23pvpztw5?=
 =?us-ascii?Q?v3MNmOL4zOie7RMUuGpY5MH3XRZdVdU2aRRCp14lbwrdgolnfMYBSPvzKEvg?=
 =?us-ascii?Q?2F+EknFG2fRsQ+rnClsmHi3gKsPzcaKMI4U6ICQGqk3tiBXk03D3bwOF5z6h?=
 =?us-ascii?Q?8ct0lq4Q/a/Qd0XDHqh7MXfbZp2GzLo4FTV/hUmag348ZgG07IzSrdY3vZDA?=
 =?us-ascii?Q?FFoLl2lEQd6Ia15mr9oBksI836IfIqWLMmhM9kQRlZ814/ewRWaadWiyXMgV?=
 =?us-ascii?Q?yBR5NgxqoNEN/a1dobB8XJQPXKrnMK0wnp7SvNdnLglBlv8MOcW3foNrTYbM?=
 =?us-ascii?Q?xytQaHzbj39QgNnoKeCXSTjtmjQR8lqZ/5k/gCpIkrzidJA+vfJqaT5chysm?=
 =?us-ascii?Q?JrGj1h/MX/VjsUVTOX0uqY3kVffoGqfZ6e5G7pLXrCK6uJtU4CgdAnXZmztm?=
 =?us-ascii?Q?Y/+hIRMqH0iF/HxuCOXUudCPYd84QTo3W1En6KdDd+58wMIqWSc3mEyAZVWA?=
 =?us-ascii?Q?GWgUTH4pjnvOnVBMJJ8FonwuViH+R8HMh7Ap5iVNAXsYD5q4XZK6XLmwXOW/?=
 =?us-ascii?Q?A2Ll+5UMCCA3HEjN7FsFIKVCvByC95/FTILQEIwb2Iu2eYJLc/PA2QNTVYj0?=
 =?us-ascii?Q?5Jz14mymJnZMlHzRsjgytS5wdkjRegOv/cjrbshBbQ9MfaTLLLJvnNVJq+8t?=
 =?us-ascii?Q?mYCUqrbVppfiaBUKUmnl6fMOOIsYeq71FxHWHoULYlYQB9OJenag73W/m7jL?=
 =?us-ascii?Q?t+hDnXErCh376SGXy3G10Lxa6HCWraC0rUDMes0xni7MpAi92491qEdYaIcc?=
 =?us-ascii?Q?x4XPZRpc5/MgerOA4HLV9Z9LaxmGSpiJ/PYJhjY/9l/o7dGdsQ9NX150yLIK?=
 =?us-ascii?Q?CHyaaeF9Jp8eUtF6XctC4CAPiOF6LLAgUBIvrEta/kGkt4pR0wt/d9HcaAk+?=
 =?us-ascii?Q?5aAeuMXxtVIjQcdMnGhpmwmMsKzWffh1WXJ5YdZhAphHKFJzxQHFTHvgY9mb?=
 =?us-ascii?Q?AWdgXUfttt5QCQtHmYjBgSJQoAeXC4l5S4QWTcBnV6z+9W+uLWo9WfFMbFti?=
 =?us-ascii?Q?ji46sNdPwvBX0M52jif1Be6x0sqSxXhCFsIJx7132C+w6J1ZExX4H4ghUfKY?=
 =?us-ascii?Q?Jp8uhlO6OOTAOE4HLQhj4UXEJuj77imQp/xgYwjKSZ6Nrll1QIccw4HFf4ge?=
 =?us-ascii?Q?gxaKL+muEvN/6kao3Ga8Wzjn7rAeNcSaZ7zPZ5CJ8Oo87o0MlzLSQ8UCeNrL?=
 =?us-ascii?Q?OENKd7nYaRjyCv3O+pwqr/0rb5d5BgbR9ix7dUj3aR0ch6zheefcBp0Hx9nt?=
 =?us-ascii?Q?0EIKiRXYKDUr+N00Vm1jNu2gc6arRA1MsPVj5rX1UPITuZbagNXgx4/iNd3S?=
 =?us-ascii?Q?uoAjQbiUwl2BQ+ADrjRTtDX75nPeyGLf2LwsyZ9I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd974ef-e611-4651-a05e-08dd5c70840d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 05:34:08.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hyz2W+jiLsCDWMzUdTkJaPXZv/ORzlYalnyndmFznsgMoSjgrn8k2UGFFUstjO6jJ0nfWZYJUVLwmKM7NMuPVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10362

This device can be used in conjunction with audio-graph-card to provide
an endpoint for binding with the other side of the audio link.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../devicetree/bindings/sound/fsl,imx-asrc.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index abac5084d63b..85799f83e65f 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -77,6 +77,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The mutual sample rate used by DPCM Back Ends
@@ -174,4 +178,12 @@ examples:
                     "txa", "txb", "txc";
         fsl,asrc-rate  = <48000>;
         fsl,asrc-width = <16>;
+
+        port {
+            playback-only;
+
+            asrc_endpoint: endpoint {
+                remote-endpoint = <&fe00_ep>;
+            };
+       };
     };
-- 
2.34.1


