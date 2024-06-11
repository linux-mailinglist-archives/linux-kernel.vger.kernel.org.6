Return-Path: <linux-kernel+bounces-209217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A6902F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904F6283AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F0916F90D;
	Tue, 11 Jun 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CVwujwus"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD507BA42;
	Tue, 11 Jun 2024 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718076463; cv=fail; b=al+PiKSxIdS9RbiKN6Sl0/wlLCajGYKmVozM9BtSLXjPUP0pJJZp8xP9lp+NIvQnYw9plDmmL7HPfjyr5ORaJffvZ6oqMxISWR6bQKFVjjNRx7G1aSR2Cb0mmrA0Rq+CcumfWqkriCvf/+XTBgH0oVY1pKO2JTcUv8CSfeZR1T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718076463; c=relaxed/simple;
	bh=nQSo8Xrz60xP1oFqM0cXcGgQlGofJtrP6SNg4JhycrI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YbCJQL4YaB8iHsKGa6Z9KTR+YXnCmxsi/XioiaNm5uXr5xDFWsASCAz/tWUiNQJgMyErOtCz/tJdtjnWCGPCiPEB2o/6LNXKesZtluPEqFgJKKTV3TanMYKdm6X9p6/wYDl7+bawe5r5obaNxv7D0k/1K130Wc2WxdfVtycYURc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CVwujwus; arc=fail smtp.client-ip=40.107.6.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgNmJLXUBbHJBIhC8zoAggH1OzQftdY+EpuYURiOb7r3B2fSySBgYJG+IZ4Sd6u+PMkHt7YE+3RA8n8gXtSI2JSYXwwFG8IFlTaj4MWqulLKjCHaOKueIVbB/q+3DbPrz3O2FWplMs8XbWFRDXna73pxMqaEv++RfHAo4x7WTOTqwOGxQ+FCTnecejr/Cv0XJpOYqvCJIR//IZPHfo5A41JvLlUL6g/TdXmusyEB93JDqUCq+DasWpElNXPnU24yBZehhPX+MKVfc1pTaQXh5SuGZQxIAkCCqeJxLRRFBFRz+ntcelpaLi3fBcLwDoMAgjsUvAwszkjB8Vofpf33Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3q+ipasr/6kJ38HINg7Q9T9DzOIAZHp6k7Yvb4thVI=;
 b=TOwXNVrMuPF43zGokjb3LQBxWOpJsQXEE+tVXdbloqJp7jegZmGPcQaRM2gQY8shAWS8tTDdznpumfvAZH1R4AjFNdo3Pt98YfifrqefgRLhNLjb4GHVP6ek0y1jHElliYgwGSPkHrE4ybRi3GBBnEIvu/ulxJVxjsohdQHEedVpjOhTUeHQzj8i7pUqcP3ygDlFaQPMMfZ+0S2W33bVfT8LH3Drkb3GJuMKqKDtWiLYvBcrUXA5GY3SEKKgYZlBDhUaq579nrMVJIiXB7SeuhAJdzL9MbKUHhfDBSF93J2XsyFrn5tLnFNg75hoHoSeINi5w5MHEdP3nqk7QeTZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3q+ipasr/6kJ38HINg7Q9T9DzOIAZHp6k7Yvb4thVI=;
 b=CVwujwusjJI5ucKJywYR79CWwO/P+0gKbzN+UH0a19mThBzweEc3dcQcYpHLKs80SyLjn/kjRakivsxmVq5RPFxsdwWyC2Im87jXVCAIxwaUMSNAelikFhtfE8SOKM7xpYL4Y0UnmtmQz5/jKQQTqjnlVn9yM5/3DevkiZ6PKgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8959.eurprd04.prod.outlook.com (2603:10a6:102:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:27:38 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:27:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V2 1/2] dt-bindings: arm: fsl: add i.MX93 9x9 QSB board
Date: Tue, 11 Jun 2024 11:36:36 +0800
Message-Id: <20240611033637.3521514-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAXPR04MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: 265a319a-ee46-439c-43f1-08dc89c67131
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VAUKjBzHE7atNoe1pIYQB8aMYGkStJQ3nkyE5YTKq55ImcNmmwj6NlXXiSc7?=
 =?us-ascii?Q?fT2Y9R/3cLy0CnHhImnoWBikRI3Bw6B98/JJxbhCXQNNpWqyUiYxZJ8wv5ta?=
 =?us-ascii?Q?XzdDz0WLlWNXr53BR4YCv5nkcThVXSLyrT2QT18OxRef73vZ/tnZ4B/tDr6z?=
 =?us-ascii?Q?CO6VwKJ2jAx+dpxtinylxiJbmn80Kr4/dWP2Fon4ooBK2VAElq7pLyGBUYo6?=
 =?us-ascii?Q?nPOj/MFHmn7cjgY1yUIe3o9YgfremSi8IUz0Neb4CLbMsIwqryI2PYKXEFM0?=
 =?us-ascii?Q?ojYWjM9lvRvhT6DluXGM74eh4T33TGJBYCkLs/6oem3FjcqWeuKaMw+ovuYl?=
 =?us-ascii?Q?Uac61olhR3T9WpOLs+8LgdVH6FvIqiA8oTPlqWuo9GhXE+hMQlatDcsD0lp0?=
 =?us-ascii?Q?VogktfE/kuWGgT5YskkxdYlyJ9haoCKE9KjMKhQ48ga/TM431I76A+TIdUHC?=
 =?us-ascii?Q?0l37S9dFr4SbT/iIZhS7HapHKCL5ioQ3nU4jt97jTs8Djs1+Z592/UJD2NLK?=
 =?us-ascii?Q?hlXchi8UypmLEvrgGfepg6EsEYUrEddWbBAgHGooQtQFi98HidjuLXxmPRjV?=
 =?us-ascii?Q?Pk0vofURjeg5xuovFvDgu2odnc91cx1ACN1cWe1KAdPej4N3spYKm8NS1J1v?=
 =?us-ascii?Q?UPZtM6MO4zhji4enIWkIzhc77zb3JKhp0tqgpXz7B57IyhGc+ts1+Y1/pA3j?=
 =?us-ascii?Q?pBxhk6y+UP4xDxmEvca3Ry0zB2/7QKbU0AfQOqf96ZWErv9AbdeZ+ME45Q2F?=
 =?us-ascii?Q?sRP2bUTH+umuQcMLQbUvdfvtdZBnmvQFNWaUrGeTSANTC6rM+EmOYKG3TAK0?=
 =?us-ascii?Q?exc4SYp4BKNBkj3W6XcPtIKETo5ejCTgrqotpns1hMropACKUC9yfkqUMxjQ?=
 =?us-ascii?Q?qJBNBdcbVjOECXWg+fd8fPb5bKTO5lpeazq4d5/P92tUGILaUmit2imoyzTk?=
 =?us-ascii?Q?SCC7xqMJM6+sCi2apC9dnZpQjT3vLvlYnZmonb0IcXl2NB6SGLFs5PwfyKy4?=
 =?us-ascii?Q?2BefsN0RPOE0/Txr2vvqp6dSmz6V6ESA8MdJNIpQzdaDXdbtBgcDnaGPaJ9i?=
 =?us-ascii?Q?sIArKojqn9OUcd8ko4icBtDkEUnqVcjuGERyQoenm+WMIZJW/7LaaNlStbyj?=
 =?us-ascii?Q?Fu3Qg8RDDY4XikejcQxC3fHXQvAVSOX+LZS4TTJyIj7RFZ7s7qT2Cj2HcBEE?=
 =?us-ascii?Q?6GLoKHFhfE1pFGR+lLXFqhu9AZaX6hMwZP02DhvhlbgcsiH8YQiap5yYJ9XD?=
 =?us-ascii?Q?riQeO4dmgfTu9SyC6d3t1B5wu6voBWoN8g46770RoiMu14MGTiM1SD12ehv7?=
 =?us-ascii?Q?GFIAT+ugG24Md0lBaviAxo4+IMYGX4A7ifELjHFsvnkr0lP+xzKGu5Am8Nml?=
 =?us-ascii?Q?BJDG8UE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fci4EDE1PCBhP1M6SmayyDRuD7fLBel1oDeAH+SAFNkQ/9R5PbQCcqRpi6wJ?=
 =?us-ascii?Q?PikHNT8cyUBpONV6uub1sVwgla7dFbm/LsziNSUf9hurO5zgM53FtEXw3Z7k?=
 =?us-ascii?Q?xeCxLFR2TL0iRXStQBc2UDHVlaiA+h7dbeFGs6b34HtJhSn+8NTQoHrdm8nH?=
 =?us-ascii?Q?1SV0PPt2EqvNv3C9IqyOgwsKCcVFoJjSj+WH02nhUUEMifQ01IWnGjWgrSWp?=
 =?us-ascii?Q?w7bL+i1MTfdYH7nxSivCrYwWdaAInmUz/e+8mJHvva4uDVVbXsnevstBidkf?=
 =?us-ascii?Q?4PbEFVy+mJ31xsrnoJ9zFU+FprERMrkKfQtdRfw37A2zR+KV9WBdKe9s7FwV?=
 =?us-ascii?Q?7GmkObtWwmRKwX9ejRQlsCvSzM5MH+/M9nnepo/Jmo4LWAh6nlpSc8Qx6++8?=
 =?us-ascii?Q?eGmTBSVv8W3SSdNeN3HPZsTOFF7zbTdBIJmWXEfP93uJow9MbsE/eezkHRMt?=
 =?us-ascii?Q?wI7nkG4Kg8j5AZL6jZqVITNQdXHvGsHKDI0g3Ewa5LIuQbq+5MGD1w1iNfXA?=
 =?us-ascii?Q?dG5qJUL1PqjceHS1QdGE6woGoUZeA2GzHzUQeuzcBgke0cH3e9B3neFF7PFj?=
 =?us-ascii?Q?06+FeW8yzNdcAp6hwvncjpU1dn3MNAlCalrZQrqbNIJtpfaiekCP2uKkCjco?=
 =?us-ascii?Q?SFvhZUSIEbtlm4qYsDOQ/X0aL827s13gi4xUMVf6Xv6nW9MS/XgNXs/nOVhr?=
 =?us-ascii?Q?wZUIClz+UXhcNcZsC6R5RqnUFcBFdq0MT67Z4YSLpkLMTtNSwUG1Giyu1/7S?=
 =?us-ascii?Q?10rBy0O9lAqpRouIHZ9WIwz35SykXluPABoYqfriozC/D9QrK47hAeqD6iQR?=
 =?us-ascii?Q?weft/vBLauCPdED6oT+nrSIMV/1QcEEgXPuyR57xxYBbzapHMxRouJLZoFVA?=
 =?us-ascii?Q?gA2Lwmc6uJvviXT1nLwxThyFD7ORtJ0alpoMpXCRk9xrG/u4tK0fvQC4JfOQ?=
 =?us-ascii?Q?62xYp1KrAM3IQDm9iKpbeTukMhHnyiJ0Z8H2/JHvXcwThzqEvKTxhT6YxdP6?=
 =?us-ascii?Q?y/G4XnZ1s/FliEVXLqv7F6OHk1wlwT90+5nQCNkT8d95yaCQKoFGAnfJO0w8?=
 =?us-ascii?Q?6UcNu0twPRUhFH7ow42pw2KBVkQQMUBMFs07+mK89mGc9BIKtkXwUa3kqSLn?=
 =?us-ascii?Q?UD+4fJ9obYv3VkJVy3hSKWN5En/SrzZRY9f5rBMY8IuMmLJysLN1Tr/Hy2j+?=
 =?us-ascii?Q?w6EYug6XmJ7mAa13UWRuldOJPu4WaCJRqcDCvKXS7BCT6sIFX642lcsQNaIk?=
 =?us-ascii?Q?JI7+7RCCE+ov1yC7G4JE/cgxQOXlUWlYub7FdNyH6VjSwZlITN16mYWhN+iu?=
 =?us-ascii?Q?LehYR+Kbm6R/mNdcGmB3WvgBYlu2WjLXQVbcepIXBvddomb/rayq8DsxuWYO?=
 =?us-ascii?Q?aQuqxJLJ99a/sOzQpIvFQYpom1UWKPT8kA/rd9wWW83bdQG7qjXAVFpCJiSg?=
 =?us-ascii?Q?88EWn/nL0ib3nBKll33p2daUYGsmoFojjhhZlDYWyFwDu6hfhbaM2827r5mX?=
 =?us-ascii?Q?Xj/P+Wk4JcoLpZ4R/0lwlYEw9G7x7Qq27UsHIYv4NH2aaXAn9//9hYRbO3Iy?=
 =?us-ascii?Q?1Rhtsha7MVyRUD4UZzdO9pv3Is1AFJigMZniY8U/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265a319a-ee46-439c-43f1-08dc89c67131
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 03:27:37.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIxmqqgY4H46K1jk7ocFQPa4Qrj0hL8ZAJyZatwGRmYCZQwqg+xsaLVIew/cr2dA/vBmgSoSPRHro7FoBHwEQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8959

From: Peng Fan <peng.fan@nxp.com>

Add compatible string for i.MX93 9x9 Quick Start Board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2: Add A-b

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..aeecf4e70dcf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1272,6 +1272,7 @@ properties:
       - description: i.MX93 based Boards
         items:
           - enum:
+              - fsl,imx93-9x9-qsb         # i.MX93 9x9 QSB Board
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
-- 
2.37.1


