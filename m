Return-Path: <linux-kernel+bounces-320715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15748970F73
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C090B282B40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B0B1AE048;
	Mon,  9 Sep 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="saQdr5Bn"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157C4C81
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866260; cv=fail; b=NJ8aYQCt8FI2NcAf1W46ShKAwWHlpZqC6TCgJlUzu7SoA2gCMu90oyESyRbuU6T42gCGJ/SjgXb7xoRaJoS3pB8HWiF7y+ECs7FIE8oS1pSOVww29Pse3YL9R/K/aJXuMUH5pqVUKZXgR2tQhC4JaqMOYpPYmYAAHCY5KBhhJTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866260; c=relaxed/simple;
	bh=uHE1ubDba5vsLHwu6SQqA8lTAZisezJuxmtCYuFpoFc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t6V0tRniG6vOz/ONGi+GjA+L9rGsQQj/w0Rq5ms9XWkd8BqqDPI6WF8EweeV70m6VoiNsGuA+onRJY5tbJVeHPQ0BRKjniHXWUIqbq0svl/QgJiJUIbJDFj1/wllpr8Zo5IPYkHNYnXzzr6iecIk88WYHcaaoG1s2hYEb7FCQUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=saQdr5Bn; arc=fail smtp.client-ip=40.107.117.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIIVrh1Brmf1pqhYhCgMrlEu09qw940H5LT5O9ok6wRZPcskGIOSK1DKPfyO7W7f4Um9wjSeljxFvpXjAvfOIvOYLxookrMg6zD8q+zjh+0xtGbhtQfbIRrZ67LUaLsmKyXMz0OZpAtKS6NlWSJt6NigEhFQxRuz9X+hKI4yjdwEOenwXh98vTYXVfnnNTAjgDUrqrdL/hst7Dq39E++7XoT3IeqKgx8W8JoYBv4wbXpAJ3MvCcwEPOSKCfTMbyNgLo53bIBIDLe71z0fXN0FU0SkdsycAQBcBxdAImZFy7mXNCwvsO3YVOGwmEufE4SLUZiqyLqXMtINsklRExeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IiIkO4exIf7gfb7qPDHIkeGF8ZyMcKAhyN6asYKjBk=;
 b=Oo/RZ3rKOa3R6fV91KOw+sgIj/qmoyPV2aHNvEEZrVNeAiDJLnM/yoEROLkxLr5URC9/FBrD1d/bD7V02rfyRDLP4h+gztc/AhgG63N6F/iqKWp1IFrrqNsgL0wceEJQk7G5sMzj18+pux+gSBXObCNyQlBFFLfx8nKeiRSzIGLx6iutiFVmKWzOqbTYFCvfru8PXr6E52trNsA8euCX7Pkk+uVBuep4qHuOFnkE4de62Yg/8ZBF22barG/KcRfLrxaszGZjljFLt0pXUJwnucG9u1Sa9z1TkY91d/LuXDyIqWTNUSJLXxZAqaRccy7xQsZiI6iRKlkxolScyV4Jag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IiIkO4exIf7gfb7qPDHIkeGF8ZyMcKAhyN6asYKjBk=;
 b=saQdr5Bn/w4kgAN3pAQNWQNQu4INNHECL7nOq68gdbtLF/zcDC5/cVE/FSBjspHZzY/lN/mePhhrFPtuHV/O/EtO5iBc7S8UBvZsUoEkzLFg1a4KeqJrN231vFNnCDrrgNi1hJTH1ifpPRwcyghQHz18+MSimU0R7eMFq7+wBafbziwuyfenMoHstxMH1WwHVqFezAPH9NZAWB8nU9EGOk87q8HM8f8RV9Nz5jWPRBYNHl/YgoBo3iaDrNq+XjxPJ8oyxlkBVCGvWHLNgySU+YysSmjxzxGvLiz72e6FtdLER2VhFO1ALXdkM9UdasKWff+vFGRiejTDgE5OHOwRMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by KL1PR0601MB5536.apcprd06.prod.outlook.com (2603:1096:820:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 07:17:28 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%7]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 07:17:26 +0000
From: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To: jacob.e.keller@intel.com,
	linux-kernel@vger.kernel.org
Cc: Shawn Shao <shawn.shao@jaguarmicro.com>
Subject: [PATCH v2] lib: Export the parsing functions and related data structures of the PLDM library
Date: Mon,  9 Sep 2024 15:17:21 +0800
Message-Id: <20240909071721.1768-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To TYZPR06MB3933.apcprd06.prod.outlook.com
 (2603:1096:400:29::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|KL1PR0601MB5536:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a8738d-317e-423e-fc30-08dcd09f7536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F3rA9+9EykDP/f3LIldgWnCEO5DzklZoZzMQG5j2AToWOtsLxsaOk7whIec1?=
 =?us-ascii?Q?grx1BtDlBoWMPSWztzMsf3/pvwEQ3DRfVQmR573chl+KYFp5KFC8sywtCv06?=
 =?us-ascii?Q?bvwxoa1+6R0opERwAbowgdiWaYwe5IX2Ty6EfNB3JU+SMYLhTciGbOGlMZ1Y?=
 =?us-ascii?Q?vrpsyPu/qC2m0H1edGwP691Q683VkZ2h/G9vwlCQZCFnAB1oumgvvhdue+d/?=
 =?us-ascii?Q?yGxPuPYnIHIVq0cc494OggLUXPwwSDJFsD1Or9Oh8fy5NcUq+RmUCHgrkLz5?=
 =?us-ascii?Q?d13LgZgtLTen+JO7oWcjsCj8Q86Isx9NGaYiDq5Sv9oO4a2XxC1eA99eiVHi?=
 =?us-ascii?Q?bqVCuB+ScxcSzMhnTIyRiCqAvT2VLnzqr6xE8341W3myS3d6xvOFm0NGUkxb?=
 =?us-ascii?Q?UeHBBvkUTY95gBRpLI7YyY9HEoD6AcvfM2xoTiBV1Sg81Bsh1N3Oa2jSJ8gO?=
 =?us-ascii?Q?0L8kPt0vUekE54lROj6k5ISEakZd+GPa7I5YwC5sgqtxEj0gVbQBfegXq5j6?=
 =?us-ascii?Q?nAu9BowSQG2Qs50G8n03I1YAlZnXxVahYSfylG11d47kNlg6BxXDizZMvu+Q?=
 =?us-ascii?Q?QToZn8JnACogzhJmSKRRxszKYGmwptFh5r5L28AB7E3MbwCJLAFMYrYgueaT?=
 =?us-ascii?Q?ihsE2XaseaocE1sg1slI60B0Pz7YVdR2Mlnhx978rXKLQPrLlBMOLNvS71EH?=
 =?us-ascii?Q?uyQpUmbAmxMcxmesEj0VqyYqfX+nB8yfESe0ddLDV2/3Po5En6EKCAoGj/Rx?=
 =?us-ascii?Q?aKXaSZlGcrrmaVawP+Klv1LhuHO1dr4+FYnKQLJTjcSTd0iBGj4d/cnBPQ8u?=
 =?us-ascii?Q?sVTFICftkC9FpNWCJSP2ndkYEOhhqB8v6tYxSr4uYJiGz9Z72u8vjR0k6EVW?=
 =?us-ascii?Q?QFc0xjlutGza2OQD8tOW3ouycShcr7GdP9fACj2S68V4DJuExZedX+MicEfy?=
 =?us-ascii?Q?h3JE2Nw9PdVkkoNDyWx96EMfPgVLr4Opn2mA/ZpXGEpc62HvvavsIVSlfJr8?=
 =?us-ascii?Q?3MkmvHXd74SajRXgrdN0Ir7GaX6UyBVwUvEeQ7ivqMUD7M+RwFEFM0AGqFoe?=
 =?us-ascii?Q?57dg7t9j3XvSkGMbNOvFq4Y5aGUuuECXy6vvpOm52ytUf2k6txF+Iobb7RT/?=
 =?us-ascii?Q?1HVN2Rw+fEZjlhYUG6Sy1z9eQYjCcliZgoEtCymuRocuQ1j5la/aP9E6X0bo?=
 =?us-ascii?Q?MzcqjRtaEwmaJ09WNBym3yvSY0W1LiRx0jhhEb0SaoDDW5o42HevmQefK+0p?=
 =?us-ascii?Q?k9BfhUQC6/o/btfMW4CV1H9Vzb3sKshGy7ggTcPHyXTeUJS0ZtGHxszd3Zs0?=
 =?us-ascii?Q?nlF/4WRoAeEnJ89ZmCGPpYb5Y4RcAFfoo3udMGhaG0dPt5Dnaja4pCQ67ZEb?=
 =?us-ascii?Q?V+BWf7O0w0AJJ2KDNtJMZDjlGL9hRZbBifw9Oq21zX9W2b6P1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PhnNK8Qp3FLt0OaQ4Zpky4cbRiYEW1Y7vZzfFgVbMN582VeaYRu8H+74EZiL?=
 =?us-ascii?Q?1dpWfTvKZA3hOPjBffhRAW6FsePRGBJT7p30EwQvk5LYySYNvaY8hc0xvfbR?=
 =?us-ascii?Q?T/IqrdoB8PsBZF9ErFAPpiAw3D3YjvVLecaAELWhYgaiE+XQ7xNI1MXfrzFE?=
 =?us-ascii?Q?Oyr5Ju7REjzKb9+Yqoy0+vKZqWW8FO9pfeV/x65ddwF44XS5k7D1Gua6e8/M?=
 =?us-ascii?Q?1htObBOD/2t4+NSsMAgsekZulAMfLJZHIDwz8irvkfTn2X41JCvjREEr5s1R?=
 =?us-ascii?Q?sbva1DKomcjvZdJeMm/simy6UQCPeKhPQmhw1z8Yzm0KqPzgqW8zqshiLDXf?=
 =?us-ascii?Q?/pbV8iaCPibCd/KhmFcYlw5gZovfDv4+RYMFRLafRaxsTsUqF2JblrrLPz8g?=
 =?us-ascii?Q?K+OjTxvCOzsffRN4IK44oaYHtP3XjGd8/sCWb7Gm4CrWvQQckPjY/IUaUA+W?=
 =?us-ascii?Q?E6VaY6mtkwWrblsrw59IvxrLiX4L8yz1iMUEm0QWZHz2EVIocqzG9YwEsWL5?=
 =?us-ascii?Q?pHzz5gfLTdzjiTjbU2QhnsvC4Ok5lKVllb5ro4UVBIyTMIZx9ialHNAJ2emX?=
 =?us-ascii?Q?0ZarpGkHcQfRaJ4PgxOf+LrlLVZHn1trO603O1JSXEkZnzRW1VpPL1hMw9kw?=
 =?us-ascii?Q?iFvQSulq3VmR9uKFeHZKAvaBrV33No/pI4T4f3+XV3z1fdWZBVQW3tzQEkyx?=
 =?us-ascii?Q?eGpz+/RTvw0PeXI76tpHTi/5EPsGN6lL0zwcMEb+waBhZtjLpJMbuHteTWAV?=
 =?us-ascii?Q?bEXFQt2eb+kEd8yQdMpS6GJN2MRW3iSJ4FaBIsJ/FBuGdbaCh0PdGCREQGqc?=
 =?us-ascii?Q?M5ZP2EC9Ub5IxO4feRjcFzXDFIPy333SsL56Z3mRgkWQSAGIgYghDTW8qnwK?=
 =?us-ascii?Q?thC4QB65rvRm0nsIf6YukI7jafHS7gRVVP4e1j4sIV7b5BlAqgsdQcsSde9K?=
 =?us-ascii?Q?SHHYMaQo+iXZlElsAgsY8dUs2DjhQ9TJqx0emow+ibrkD0ZKWpB83J31nyPt?=
 =?us-ascii?Q?AFGLicz5fOEp0Gy29EzhF8XDWwAc0LKuehnqhZTBwr0+TPk4mXUY1a392HYc?=
 =?us-ascii?Q?GzvG2QN8URMWlCJaG/Dcejxuro4PuVvew6CMQHccyxtZIJcMmyBYRBACpOJF?=
 =?us-ascii?Q?RszQ5qjllPllYKG2JifY9y9cw1VfmobRoi4yCMhvBEDFe2LKdir3TZJsSU7j?=
 =?us-ascii?Q?ZM3/YksWMKl0uV6hGMsPxytiRUEaan7GlfxPQumOZhNGxBIEkFbtyOVFcZcr?=
 =?us-ascii?Q?/S6CkRxd6+70c9OGIwk3Wyn8tjKFkeMxDhNdl0cEaTk4TuWtUwSracoeS/Al?=
 =?us-ascii?Q?Y9RPWGA4RnjPaLoEmLX+husNdIE82i+P4Wm7sSTWTBtgs7lb9LH4yqVAm65c?=
 =?us-ascii?Q?+liFJBZ/kH+jugYLy5fsugqxY6hgx+kvRvoFmOm5NlVa+efyFAhkAMkSVoa5?=
 =?us-ascii?Q?INSOqq0+alu/k6auRwD7O4dBR/oRyMHD8Wlldv3dyuJMFlKtnaqdvolxELCc?=
 =?us-ascii?Q?0pzwaI8X8a/dvRlAy0n4hZT9SMBW9jFls8vks3g/9E8d0MG/Sn+KIIRFOxxp?=
 =?us-ascii?Q?qzCWzSbkkzK13PpZdIRfzL5VidMbwYzgzIWPuVwVLZKDMKvVSx91FYqqep39?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a8738d-317e-423e-fc30-08dcd09f7536
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 07:17:26.6571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLMYG/dI45DInlRyF53Sw/mPw0QU2OL8R7Weqa2rpu+TURksdc3F+tbbqLcgtgvdzyN1ONQR90N8+Y8IJ62t0kZsuFXhTWQg7R1nXdFA33g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5536

From: Shawn Shao <shawn.shao@jaguarmicro.com>

v1 -> v2: Updated the commit message, added a description
	of the changes related to `DeviceUpdateOptionFlags`, etc.

The PLDM library is used to implement firmware upgrades,
but the current library functions only support the
`pldmfw_flash_image` function to complete a fixed
process of parsing, sending data to the backend,
and flashing (allowing users to implement custom
logic using `pldmfw_ops`). However, this poses
significant challenges for device vendors using
PLDM for firmware upgrades.
The following scenarios are not supported:
1. Only using the PLDM parsing functions, as the
   current library does not support this operation.
2. The firmware upgrade process differs from this
   fixed flow (the firmware upgrade process may
   vary across different vendors).
	|-> pldmfw_flash_image
		|-> pldm_parse_image
			|-> pldm_parse_header
			|-> pldm_parse_records
			|-> pldm_parse_components
			-> pldm_verify_header_crc
		|-> pldm_find_matching_record (xxx_match_record)
		|-> pldm_send_package_data (xxx_send_package_data)
		|-> pldm_send_component_tables (xxx_send_package_data)
		|-> pldm_flash_components (xxx_flash_component)
		|-> pldm_finalize_update (xxx_finalize_update)
3. The current PLDM library does not support parsing the
   DeviceUpdateOptionFlags parameter, which is defined in the PLDM
   specification to facilitate the transfer of control information
   between the UA (Update Agent) and the firmware.Please refer to:
   https://www.dmtf.org/sites/default/files/standards/documents
   /DSP0267_1.3.0.pdf P37.

Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
---
 include/linux/pldmfw.h | 38 +++++++++++++++++++++++++++++++++++++
 lib/pldmfw/pldmfw.c    | 43 +++++-------------------------------------
 2 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
index 0fc831338226..5058a07a5ea4 100644
--- a/include/linux/pldmfw.h
+++ b/include/linux/pldmfw.h
@@ -130,6 +130,42 @@ struct pldmfw {
 	struct device *dev;
 };
 
+/* pldmfw_priv structure used to store details about the PLDM image file as it is
+ * being validated and processed.
+ */
+struct pldmfw_priv {
+	struct pldmfw *context;
+	const struct firmware *fw;
+
+	/* current offset of firmware image */
+	size_t offset;
+
+	struct list_head records;
+	struct list_head components;
+
+	/* PLDM Firmware Package Header */
+	const struct __pldm_header *header;
+	u16 total_header_size;
+
+	/* length of the component bitmap */
+	u16 component_bitmap_len;
+	u16 bitmap_size;
+
+	/* Start of the component image information */
+	u16 component_count;
+	const u8 *component_start;
+
+	/* Start pf the firmware device id records */
+	const u8 *record_start;
+	u8 record_count;
+
+	/* The CRC at the end of the package header */
+	u32 header_crc;
+
+	struct pldmfw_record *matching_record;
+};
+
+
 bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
 
 /* Operations invoked by the generic PLDM firmware update engine. Used to
@@ -160,6 +196,8 @@ struct pldmfw_ops {
 	int (*finalize_update)(struct pldmfw *context);
 };
 
+int pldm_parse_image(struct pldmfw_priv *data);
+void pldmfw_free_priv(struct pldmfw_priv *data);
 int pldmfw_flash_image(struct pldmfw *context, const struct firmware *fw);
 
 #endif
diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 54e1809a38fd..cd1698e9c340 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -14,41 +14,6 @@
 
 #include "pldmfw_private.h"
 
-/* Internal structure used to store details about the PLDM image file as it is
- * being validated and processed.
- */
-struct pldmfw_priv {
-	struct pldmfw *context;
-	const struct firmware *fw;
-
-	/* current offset of firmware image */
-	size_t offset;
-
-	struct list_head records;
-	struct list_head components;
-
-	/* PLDM Firmware Package Header */
-	const struct __pldm_header *header;
-	u16 total_header_size;
-
-	/* length of the component bitmap */
-	u16 component_bitmap_len;
-	u16 bitmap_size;
-
-	/* Start of the component image information */
-	u16 component_count;
-	const u8 *component_start;
-
-	/* Start pf the firmware device id records */
-	const u8 *record_start;
-	u8 record_count;
-
-	/* The CRC at the end of the package header */
-	u32 header_crc;
-
-	struct pldmfw_record *matching_record;
-};
-
 /**
  * pldm_check_fw_space - Verify that the firmware image has space left
  * @data: pointer to private data
@@ -341,6 +306,7 @@ pldm_parse_one_record(struct pldmfw_priv *data,
 		return err;
 
 	record_len = get_unaligned_le16(&__record->record_len);
+	record->device_update_flags = get_unaligned_le32(&__record->device_update_flags);
 	record->package_data_len = get_unaligned_le16(&__record->package_data_len);
 	record->version_len = __record->version_len;
 	record->version_type = __record->version_type;
@@ -540,7 +506,7 @@ static int pldm_verify_header_crc(struct pldmfw_priv *data)
  * Loops through and clears all allocated memory associated with each
  * allocated descriptor, record, and component.
  */
-static void pldmfw_free_priv(struct pldmfw_priv *data)
+void pldmfw_free_priv(struct pldmfw_priv *data)
 {
 	struct pldmfw_component *component, *c_safe;
 	struct pldmfw_record *record, *r_safe;
@@ -566,7 +532,7 @@ static void pldmfw_free_priv(struct pldmfw_priv *data)
 		kfree(record);
 	}
 }
-
+EXPORT_SYMBOL(pldmfw_free_priv);
 /**
  * pldm_parse_image - parse and extract details from PLDM image
  * @data: pointer to private data
@@ -581,7 +547,7 @@ static void pldmfw_free_priv(struct pldmfw_priv *data)
  *
  * Returns: zero on success, or a negative error code on failure.
  */
-static int pldm_parse_image(struct pldmfw_priv *data)
+int pldm_parse_image(struct pldmfw_priv *data)
 {
 	int err;
 
@@ -602,6 +568,7 @@ static int pldm_parse_image(struct pldmfw_priv *data)
 
 	return pldm_verify_header_crc(data);
 }
+EXPORT_SYMBOL(pldm_parse_image);
 
 /* these are u32 so that we can store PCI_ANY_ID */
 struct pldm_pci_record_id {
-- 
2.34.1


