Return-Path: <linux-kernel+bounces-316425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A936096CF66
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF07B22C24
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B1118D655;
	Thu,  5 Sep 2024 06:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Ex7d5Ayl"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022085.outbound.protection.outlook.com [40.93.195.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD318950D;
	Thu,  5 Sep 2024 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518173; cv=fail; b=fpQ7Ehb/IDYWASQhztqwldKXmX1xyhEJNge2Cfb7Lh90hDfjwDZFjot4HnZBswFZ3YVnChkj6Z2blmttVZ0cPBBWS1781ulkL/sZcmj5T3QMqtdjimeAEamQQxq9isEUa7TdzqY6gfbvirA3lGdQ38lTvCpaA/Tfug0JxB9N6c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518173; c=relaxed/simple;
	bh=oCWu+0a+qra7jfr4QSvthgV5aNiB4OWbbZNS7qy8iY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+WHw8kKxS6SBt8uIkbmSOOHIO5Y+zw4sbLjdBnotojJxW+gW1oxAcObE/ANvfNWQiFWQQ03u1NfhhBRRn419hYG0O173A+V7jGDxE66CvG2FcX6sm0yMviUxBZJF1GBenRtqcSJ+d19sFOtNeo6soAWIlchcoOGUtuU+RhG4e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Ex7d5Ayl; arc=fail smtp.client-ip=40.93.195.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJhO7mQU7X8b2vYABqOYE22Z77ajNpMAgK6f2GMWLWrxUDZOGcZl3VuptAmiuB+1IkfAXc2wTqIh/HXvpqsdqYhFwpV1QQVgvxJWy4XmDtabKyD6T4AGYGkC4BQAezUjf3aov0bDXrCsLgOFXLYrXGq9Opv6QXuP6yRCkp8uFAeArvgvi0FgnZ4nFaZPB4BZb/cxJkoLcVot/1ZNtdETeeJphvAtMYNdXoa60fypYI3O2qnU5X5KpdzhOtDcZzNjhSDTCJ6djJI/ywOzY/qUJNNo5ETHhYikVnLkGFsyESuFGb0N3dE4JT8d6XWpDID8MA+EAHb63Tz/lB+tX5A5Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRWsJcXoKK/C1/jxWTZE6W5kxtOhOKPldGXNza1kkb8=;
 b=kXA+Gx1yck+vS7aTWse2N0o2CURIL7htxLpR+ZexXp2RRG9apDURxEfMzrGr2BJ3uM90q1ywmmQXK3eLDWk6ENZl+muNorrtyVPVcvugA+t14BK9x4VxjN010zkgNFgC6oB18N4yEzmVSXMftrB68NFbJn7YSaumXVoa4AksniLpRxT7MtdVu15lS+vd+D/7eUAKQn1Z5pmPXDe1elTSr2QdfXRZVEve//vyfA1Kpxs+TTBVq2bWs+FS3bykaRgCY3/ZoKCCSTqFlgPlNZQEM16A70nERkWBWLJS4QCqI4N9ri6CA6k9odG/i+otyyZ5MmDLw5NvIZi3psEMB9gfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRWsJcXoKK/C1/jxWTZE6W5kxtOhOKPldGXNza1kkb8=;
 b=Ex7d5Aylh19WuBKYzp4Bbl/nmHNbEE2cL3ESHWAVBp3Szk/kCbWQJqjfk6y/HfxUTb9L7Rvb9jCQJo8zKbSp9WcVRfT5WXF4+shBReBKG6PCQJCIOQE9YsdMbRLouOY5CGLYon7RrefD7iahWaw+uvbU7x8/UZjcwQGxgnbKl1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL3PR01MB7057.prod.exchangelabs.com (2603:10b6:208:35c::16) by
 SJ2PR01MB8079.prod.exchangelabs.com (2603:10b6:a03:4f5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Thu, 5 Sep 2024 06:36:10 +0000
Received: from BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09]) by BL3PR01MB7057.prod.exchangelabs.com
 ([fe80::b69e:5684:ed7c:4d09%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 06:36:10 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Khanh Pham <khpham@amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: mtmitchell: Add gpio line names for io expanders
Date: Thu,  5 Sep 2024 06:35:21 +0000
Message-ID: <20240905063521.319416-3-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905063521.319416-1-chanh@os.amperecomputing.com>
References: <20240905063521.319416-1-chanh@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0129.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::33) To BL3PR01MB7057.prod.exchangelabs.com
 (2603:10b6:208:35c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR01MB7057:EE_|SJ2PR01MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 413874ed-7eaf-43db-678e-08dccd750739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DkWiYZVRB/NOpq8XarvMYKsbxfWiqWfpAQQgvsxQySX/JiUWhG0wFN2I3yzn?=
 =?us-ascii?Q?az60PtLBUQp8iUa5CfA/eiLTNqxbPlX/ZcfBp64GHJxkb0BM73ncxIpOHC79?=
 =?us-ascii?Q?/GffWVwymsgQjfFUXIeGCSd8sqOp99pV+0NeRfwZlrK/R4nzp4UyMn9DvlUt?=
 =?us-ascii?Q?Wx4cQaMuW8oe54YMuk+gqRh4GN3eIfxvlWEtlFXK1HiBGxcyiRH+No6+siat?=
 =?us-ascii?Q?jhJQvWS0kjXITMdOcz8TC3qfkRL5Kw6NGakZafQDptmJ/Mg4qwK5PLDeip/F?=
 =?us-ascii?Q?JzR90kbYhOHHDJyjMyUH3OyF+EK+gllDHtnGcFcMoFPeA8yPbZgjukpfpiBI?=
 =?us-ascii?Q?kHYXe53ITutJd9O0NEVeHTiIG7R+U6X6iB+KSJRXtUBcMyUaK27kSYg3d0cT?=
 =?us-ascii?Q?rJ2SKBUx2ExWq7NcF75FAR4us6WgjdTyrqGyngw5oap6liNXJLUcaCYx4c5Q?=
 =?us-ascii?Q?0quw6FJO0Af8l57ENMvG0TH/6WAK41H6bn0899ysJJxsqcU8QksadCHcFWkQ?=
 =?us-ascii?Q?PxJmvBFEZgi6uu5ZsepoyJfFwofkPvOmslN4KpXHbzbDCKe2w1M0aBN8sR0X?=
 =?us-ascii?Q?CRbac4Uec+Fbwlpv6vTeZ7UsVMhZjkp0Jd5p/o8Wu9O145z7KbMG8MAavj9A?=
 =?us-ascii?Q?Wvz4WYcxxFh0afK30NAPbq8xO45fMeh0c34LUJiKTRCfP2noEZf+rf6amdlP?=
 =?us-ascii?Q?VXaBz8hcppXWTzEWBEFEZwlLffu6vutti8b5NaAauF8adLOx1NPy+9pCD5fP?=
 =?us-ascii?Q?qUPcAA0uUC3HDclM9IlhT15nB4UkbSksDxwkUv2nH/5iXRjduH5AcTq/+KXa?=
 =?us-ascii?Q?xcLsfFWgS7qWWtBG6fWFghd2dzkeRz31JCwMtingBVKCW6qv9cAShcbzYD8b?=
 =?us-ascii?Q?wkjSRi0GxdV4BvNt77WJnWV5DzI8xpbhxT9a1TdGrYj418WoN8vkAwaOpxjk?=
 =?us-ascii?Q?PI3edlvaqmw9JkBI8p047lpvfU/yNOSECp8CxBE5GSWd83gSVuBi2p0I9UzD?=
 =?us-ascii?Q?Iw6EzbL/0g3yHOIKWxd0FG2th+S7siQsK6Be+e66DrzZvTqqHZ+cOsjFG40A?=
 =?us-ascii?Q?bpJMevtOak6wx8KLGsd9qJUds6w/JX0IhKkY+pB9ObICzH0Mmow7cPQy9en6?=
 =?us-ascii?Q?iZe15N90mJZ4QKoLvHT2HuUPSIqdDhmxGeWXJ6CPKxGnvEp962aTtfdzXH10?=
 =?us-ascii?Q?b+7Z507eIsRdA8ShGxpoPnfqSZXoZqzdLeohDmvOCh8jHV7f6LhzHTcvCey9?=
 =?us-ascii?Q?o6vABOBpgp50Ro3XrUqbFdb67ydPUQaBwzcgIwnp+IsRvwy5D5r/lcRAqBR7?=
 =?us-ascii?Q?8jiP8LHx/5ZSsAIrnfoCWNp48ivtWFigV7xDNLc04lABkcHQagcDNKnGK4Zb?=
 =?us-ascii?Q?USsEOhjMYrSQfgSjiwAKw9bolMdlEDmQS1XGOozCEpPd71roIPXhOL5Gjtxl?=
 =?us-ascii?Q?qosz/4CKGe8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR01MB7057.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EhsxPEankaWn4xpUQ/ZZpCISssxdNQSDi5LtwgDoJgN10bJ23OoLGLaE0lWc?=
 =?us-ascii?Q?ZPOcMOxM/finq6ZM3vzNmEJ0Fy4D96jOZ4ULslZcIOibeyM5O1MBBFg0ZZEY?=
 =?us-ascii?Q?EZ6Ns8ZQFAALWLNm5FY4kRQOSJmYsCr2WBOmu0/Gqa+1LsTd0oGxMcixi0tQ?=
 =?us-ascii?Q?x5rdw4Uo63IYtquBLtrkXOSxg3mhn1stEN1CaLHFYA+nBc1/lj+pM91/JSR7?=
 =?us-ascii?Q?uwztlOGKrIA/bYiLQC7xDPYRcYM+DPKH20wANpF1CY5CoNhvi/p4NBnSvCu6?=
 =?us-ascii?Q?LazsOrY2yf+nfaMhSdbdjKx+civQXxPST9tEyumJTAPpIarCT7Kywfgi2TIx?=
 =?us-ascii?Q?lXMoPiilKHoVvNZUR3rCzUvRn96Y4g3Fve515nc5pNriRM4qQtDLOVBf79pw?=
 =?us-ascii?Q?WGKbKgN/rib/GHuPE/dSjxQq/13Wjn2B8gA92xXnwliDjqHzPlKf2HWS3UWK?=
 =?us-ascii?Q?aXWEjKbgy2CcYuJhCcgoMxmKae09WcsqnkbM6jXfVfKggKigwcIDUgiI12Kq?=
 =?us-ascii?Q?tJWwOuA8z3mlcQVd+ioj86q54hegAKKBwKE9Kk8cNLgfiyf57OjC+b5vCxP/?=
 =?us-ascii?Q?uaK/Cjv1VHXkX9i0t83whKXGFsu8xdkZg3cwTocFta2Nq4s73JyQRCuFn738?=
 =?us-ascii?Q?ECnYg8eCFKTiX7W1yMCw0QIWpeMG2Ew248XDcEij3o2V7QwT85eVFKt4w6aW?=
 =?us-ascii?Q?JsHLiDMgBh9UvuDbTV+rbyw/IWMm2bDwWCnIrhiOIc91tgP/9m93Uz1nryqV?=
 =?us-ascii?Q?nK9bjj2MvpJhT4Jt7SljQuZmVwYySMjbmX5JP3kf2AkgO6lcAGo7/URymdtU?=
 =?us-ascii?Q?NlxgEWq7ov94hbtiFuxM//483Czxl2BLumttObxrE3inQuUkhncO5lXQikMt?=
 =?us-ascii?Q?ZT7M5xzylhuGE3Lc41NLHH5BzLfVhuiztFM01He6qCC15YHYeAvl3MVkal6h?=
 =?us-ascii?Q?jh0bIU4dUNfZPELExmSZXb2ZLFqQ+/SBATBJM3lhENotQ6QOMs9QUQv/tEkv?=
 =?us-ascii?Q?Q+SPQ7vSCdcU33vc0KIEIcVBrYvp4kjRsQAB6jBuTi+Cd7jY54MruO1Wmkix?=
 =?us-ascii?Q?YQ8GOBrBGYgXybksN3Cax8F4By6kJLQ3MtgEMqIfCuN/5MHvRKLzsiCrG6Tf?=
 =?us-ascii?Q?HZmXSpII4S7S0fYRKzg0eHWttnEzNQsdqORe4WAXH64fC9PhfjXxCrXFU+mO?=
 =?us-ascii?Q?LnJsaCHQcIvfctg0u+Y5trhMR0s9P+KwGZiZlYQ6BBxxGiM0lNhRRLodULgX?=
 =?us-ascii?Q?jWVrJmn98oN6jrtNHJiZwl0peXdcLLIIeTRN0hQguICostVWUFDj5Ykd3HIn?=
 =?us-ascii?Q?a/LDaOCREOZYvqGiNd7uxj+fgH3WpGUR8Mr28L7OMzZRqoziIYFPn7nqDbaZ?=
 =?us-ascii?Q?CaiE2LrT6oolXLpVArPNYRe4l2ZIRIHYCsGe2qd5RaPgeLG8kyrbDqqU2PUF?=
 =?us-ascii?Q?MGmA2EjNUt6s1SPM1CDq66m9H2DW7ZKqJtvO+pNly/5+besJ7NoGm1ga9Yi4?=
 =?us-ascii?Q?vDEGmxXfThdfnvvcihZ/anLCqVmp9dqv/H1fW8YM+ZgPC6lKlS5ItL1G3pZb?=
 =?us-ascii?Q?6/b5ZLsn7fRUSVyQAC4gc6sbqaO6K+kPz0WS9kBgx8zrNEmoUB6XxyKqhEcZ?=
 =?us-ascii?Q?BX9YTmcOYFAV32/hQHQ3MiE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413874ed-7eaf-43db-678e-08dccd750739
X-MS-Exchange-CrossTenant-AuthSource: BL3PR01MB7057.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:36:10.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYzV7avWyWVWi0SE7Ifok9tK/jCbj2qyqyJazxB1aexuQwPys52cZlVdYomAuP70sZi3zbpQHEtj2BpTT2mu58+LMH43ixSqOVJ0P/CNdsYk3YF7iT41D+yaTnXcFfHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8079

Add below gpio line names to io expanders for more platform features.

- ext-vref-sel
- presence-hdd-bp5-n
- presence-hdd-bp6-n
- bmc-ocp0-en-n
- bmc-ocp1-en-n
- bmc-riser-en-n
- gpi0, gpi1

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index da181f9ae820..2b336aa0146d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -677,6 +677,12 @@ gpio@77 {
 		#size-cells = <0>;
 		#gpio-cells = <2>;
 
+		gpio-line-names =
+		"ext-vref-sel","","presence-hdd-bp5-n","presence-hdd-bp6-n",
+		"","bmc-riser-en-n","bmc-ocp1-en-n","bmc-ocp0-en-n",
+		"","","","",
+		"","","","";
+
 		bmc-ocp0-en-hog {
 			gpio-hog;
 			gpios = <7 GPIO_ACTIVE_LOW>;
@@ -968,7 +974,7 @@ gpio_expander1: gpio-expander@22 {
 			"fan-fault","psu-fault",
 			"","",
 			"","",
-			"","",
+			"gpi0","gpi1",
 			"","",
 			"","",
 			"","",
-- 
2.43.0


