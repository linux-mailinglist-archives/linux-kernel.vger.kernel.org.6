Return-Path: <linux-kernel+bounces-185747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C23B8CBA13
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7511F2348F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D49F745E2;
	Wed, 22 May 2024 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ojJvlW4w"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2048.outbound.protection.outlook.com [40.107.117.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B991103
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716350132; cv=fail; b=VqfZdQu1mu5ZtqVBjCXQZfxJPQJw/O3TGQZBSyRNhJK/9OD+3Ao6n0mPirHlDesylnRqWIVemVpj4R+lLN8jrmH9lgNHmuo+Rqet9N0pB+yfPxJazNO/6nMeIyM4sir9+slI1xVRVb/s9XAyvAYh0jaslRv83Xx29FllB4FWxQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716350132; c=relaxed/simple;
	bh=fRA46f/7A2K5B7NABYVl7cHTRLCuY8hgW9rF+3ZMlXE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UtANCQsxlU4iTZu+xrmGPbxhtQpIxy5G0fK8E40ba9w/3XXcB20ocXkXJ6sZOKAYCJof/CV5FEY82o525eHFSrKTfewIgY8gHerALXq3YWo3Rmqca/ezRJoDor5KuL9EaAcJEYzg8hZS1WTvhFzyu3ClTRhqJP06m21JGMNdfHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ojJvlW4w; arc=fail smtp.client-ip=40.107.117.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAwkjp2zIoKZ/hk/WBIv2ElhdC+ijNb9OYgjj2E0sz8GnWfAsbBMuICmP/UgEcvpDo0XTm6bGK/kYhRjyUkxSQnvgk/T/J2m+JjGzNgXXRx3rqe6cvX0YY9cxV4gSbiI9XHmqhOYjGM5zCGo4VdUK13owgPXD86opGinvsCT2mhopZF7yDdd/ie4hsN7GKzeS1Vql8lcvy5t1f2AL/MAhKXosbqSpuvDbjHYXABHaGHWcTYabIBpiqMiINSwlh2C1vchX98Hx5IX60hgho3+zRJm/PWPO8PIJXdhe77zIJUunEoabpzsCE3ml41t5NqcG9ePN++sipTE2CUi6bJozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udSsxj409hDkAze8HUl6ubZ2pf+UOVoDS5BNQhlc2WU=;
 b=RzBgeW3oudVeDeccper660N343ZtzvyaMYZ30h5GvcOhmDrnKKd8f7fLYcEIqQ5+/Aq/SYhqMk88m5fmr1WhgP6ViOq6do9VUzEA9VqFRzlsAxzuv2I6YC2uYCoKUXLApvhsodTivFRAPTOV32jMxXuX9ruRiPHi8wWJtwR2dC/4iB2q9aD9ZJZGmSeBUg2duvom2yVAY8LYiWZttjOfnpj0SljweGPZRj7udh56Dl0T1rnC00WWAS19NiOwArwxNcJsv6LmchVI9fgOW1OZTcRLqL9K2SFfPziOKKy+FwD3D7i9WeosUupWiBRhdVRh7mzdCNXlYFIve/L+UjaRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udSsxj409hDkAze8HUl6ubZ2pf+UOVoDS5BNQhlc2WU=;
 b=ojJvlW4wqxo0PJpGeH3PEJVMpS/LAouehP7TJQwU/10eJ6fwhuFSBWdZZDFN2RfoVSG0eDW7izWhwe4Zml16fC4fVzN7KyC8TlrHqKW/xdOLNwL+601HMwwERkVq7FzMz7n3vDwUUmhhaCGc1dslPiPTQ/DPgz1MPszQaeIqgTyGH66D7ih7MXTdpY2jBQAAtOIrBa6AqBsyi8WdvwCcul3lOg23pMovI6ckwfoUIJzAf61Ok4dkcXGboLv5VxB3WTWkQ9T3/4MsiENWZCRN8yVz9lJqylmBkPUaspWcZyXljKJVcBlTxkG9R8CcmGsAFllJQhVYZLm8/ZjCOEZ5Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEZPR06MB6569.apcprd06.prod.outlook.com (2603:1096:101:189::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 03:55:25 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 03:55:24 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Wu Bo <bo.wu@vivo.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wu Bo <wubo.oduw@gmail.com>
Subject: [PATCH] scripts/gdb: fix symbol link when run make cmd out of tree
Date: Tue, 21 May 2024 22:07:54 -0600
Message-Id: <20240522040754.2972825-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEZPR06MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: de5b637e-8d80-4b7a-d520-08dc7a130269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3+tG8ivnZUV5Gkr2u9Lo4jCG6uVA6GlUeUFj0NohZQv0ztUV9ikIsgOlh/T0?=
 =?us-ascii?Q?k+R7q5NeJ+ERZC5eYZQ6HdpHNFhEv2kmt1ULaonoWIzNF7XJBkChBhEqXxob?=
 =?us-ascii?Q?Uyb9UIkWAHyEX4ooPr9TCEu9QaryLq3eBwTlZYZ1tqo/TykkGHBFlULYxp1M?=
 =?us-ascii?Q?8l73bHB/mM1KmgTJwci2rxN9ppBmD3SB+Kl1xBaraZ20SL4GtfUtvGsFfYrp?=
 =?us-ascii?Q?0p0T529Zc0ekpZxoiXEPZD005lEQ/YXIbooXmQoDl6VaSn3hGL0FwYBARWMT?=
 =?us-ascii?Q?d2LkVtuTutTof+hcftFWT/buvPYkdRAUz5igy2r3GTeuuFcPdq3jYqxzOMiU?=
 =?us-ascii?Q?k/BWkDQb9lMM3dMCZ9RU9kKr7rLt5VzR4HCKy9zG4iFGkN0EyaYWbdr0Zl17?=
 =?us-ascii?Q?9DH+vL02IlDZB5/qK3FONT04NZ0Q6OrxEgGeyNJlHgTGy3MOnMd4mpbz/Ttm?=
 =?us-ascii?Q?AiY4p97657lH/nW4+LuIBqH2U33p7FvTYa+EAcYWkbp4Wn7y7UHXOvhaoxiy?=
 =?us-ascii?Q?Q93g2mo2Q6XzDJXpXMgj75SzoLyOugr8HT/z9FpGvy4ta6Orvj4nQUsuz6Rp?=
 =?us-ascii?Q?Vq5BVZ8h3GFuzcP2/iYFWLbEsHeVFkSKtBRv83NEOWEre2QkyLLogPXKgF/I?=
 =?us-ascii?Q?U4MjKDODFdwqu6muoW8tcEOMBCRTcvHd2ntxnYNgRKpdGZFWEQfHWXXW2Z9o?=
 =?us-ascii?Q?GGxsel6I/BnQR4N17RzCf87xf38CMYYTMcVGA3rtaUqR7NwmToU2Uw+0Tr+B?=
 =?us-ascii?Q?DaMuQVDZDY67jGAv8oeRpx1GMVe5cF/0qzD9fKcbMU3+i1lV0jYu9n0pJUwF?=
 =?us-ascii?Q?HxKU7avjvzaDl2X60uTS0qCguYn9X7+HiwxTd823yv/OILiaNImFlZhysF46?=
 =?us-ascii?Q?ltSsb2vqkMk4z+ZeeeZ6sOLuuAlyxxclu5vgQUCaqxQ7lUnBeB5OdMjrV1uq?=
 =?us-ascii?Q?LFyNEgt33wayhyQATFyCIrkuGYshJjc0lYPyRifbBUTCrRGwP5puXTN+3b4J?=
 =?us-ascii?Q?6CiJ5dGAZEu/ylvwt1xpQnmUg4sxlLsEfxWq2t/WqXS46kY4paGqH2yKxDQJ?=
 =?us-ascii?Q?pKnI9qe7iZGFsISSXX2hhi12wnSvBhGJOCGkR9ww+GtNIfDYHrYLIMe3Tlao?=
 =?us-ascii?Q?j2HwlisUQqh3SlxDyXXB2pTJbj3lk/5vMNFNrBGgRkFzwWDusJ0HLDXo430y?=
 =?us-ascii?Q?puAhSQoTx8iDnACcZApV7c2EUWlGK+M7wsXeZ5td1YOaFfRRww8Mv6ehEjAU?=
 =?us-ascii?Q?FoVoK8OAK9JCzVvgVaftc643SOcDSn9aM1TVd1TGb8+pE/HHH8ZRhUmRAQrD?=
 =?us-ascii?Q?ZK6rlO824dqhZLbbWaRwaRWRQU9rF/bDXkMfdD5/9JrLzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9tEt5HwMqVxsENdqPlUEV9roeLILxJZ2fRj0ogtuLSLocQStNF2HMkhTwCNR?=
 =?us-ascii?Q?IThsvB0LKZbP8YYtrv1qWG2f0tqESWl8FY+aa7JIHJxoCjteWwIFp17X/41z?=
 =?us-ascii?Q?OtknnwitKhwWjhUFAcL/Bdspq7osaODVDbnAsbyLodB1BcdtGzjdRlN3TPVx?=
 =?us-ascii?Q?DpVErTUmBo5baW90AqjnwjmuIdK9Lgj+6AC6qKmXZ0raPrfbCc4dTsbbScVi?=
 =?us-ascii?Q?ZGu7Xpm929X4gUIOmIbv5NqaVDPescThxzSBp8nUcn+tpodb7L4HRZVH0mGd?=
 =?us-ascii?Q?Z8TvoDOsNno15XpjMr8rDj6Li9qSYUKxqsBdg0fTdTIWlZzZ3tNWaLc03TC7?=
 =?us-ascii?Q?HIMskH9vw2zskiYgKJopfC72VlYsteK5raKNfzgSz0pSyr7js1vZPh6G5NIo?=
 =?us-ascii?Q?HZHpn2TJ26DFUdvZq9ERfpcgNaisB+RNDNL4tndWf+pC/1RRaKfQEfEn4nio?=
 =?us-ascii?Q?NlUxGILksnXB0yfKWD7U33cSGgGbEDObKxOe/v4ufitZrNS4CAU49rkBefEu?=
 =?us-ascii?Q?o9vYqa/jnE/HwzxLJpg6zpLDE6m+NHUAru9oWOsbt0eEMCPZL98SoX4U1BQl?=
 =?us-ascii?Q?THNSiQvFjXleZHNbFyiFb+nRluDq2+EPTm7Z+qHaBW0wrZwvOXmQ4tH0QR8r?=
 =?us-ascii?Q?icYd68Xdgst2RacGdgsMZGZEpYWL/WUHsHUQtHrdL8LK3jDxH7cM4QSXfo5I?=
 =?us-ascii?Q?7kmRd3NerFdDBytqXUi2IjYwncw2dROPjAGZFJFFI23oYvlt/SroUS+HK+l3?=
 =?us-ascii?Q?gkVdSQPylg35+XKwJJgQeeBk8cWqt5+8dfKMPVAJovxJZvKPzttyGMX1nbJ5?=
 =?us-ascii?Q?OH/w2xQ5xJ9SzGB1pTXpJyItK4hrwUe8irtEGYRWHaOjRfblJwEfO0w3KB2h?=
 =?us-ascii?Q?loooGdkENp3ye7dIyB2Ln6wCGXHH1zD6SBBgKEwfveR2LbFy6aZURA29LzSm?=
 =?us-ascii?Q?2Ue7U1CmTxsYFDVCAgTutKAdC+WovQTIif6VLRIUE2tz2QV2D1caqjlNpbgI?=
 =?us-ascii?Q?/Cy8dHC4f0JK8m//KpQx3ZNYoJnuJk0t8bIIXTBMh9EBjFj74jjqSYtF9kSm?=
 =?us-ascii?Q?z0gE0e3sm5gtAiGwr3er6Z1SsTA15gPZ9JVG+Bji4oOTIHD83y+LYbx0Nwaq?=
 =?us-ascii?Q?iyUPZpnh/6giaYtiBJKwHjnJ3vk+VSsEnmnW5ULRpZHQ6PRdt5AujKeuD39s?=
 =?us-ascii?Q?ocgG8gaYuotwQdxTNS6/aY4PNkrmrIGlJafurvbweesV6fHO/kjV6Fl3lzbH?=
 =?us-ascii?Q?ndci3qQZpGaGQFKnLodhksw8jjP3wy5dj3u0RwqUS3qQNzZCs9/bdqzrL9Bb?=
 =?us-ascii?Q?sFAVefHCvNUsmYv5SXVkC9+8PIQ2gQ79i0BOxhCAEdTC6v+wfpPBmc/GSC/n?=
 =?us-ascii?Q?YpByroCDXLg4Za0+azC1ea3eLK9k7fTEpZ1O45oU53UEuc2PFh3W6gJ4IMrD?=
 =?us-ascii?Q?Xqac7y9T+LqaQ/PsjqnVD8WyHrTu1KSXDvGvlI6afCRvl6vbwmEsKjU+4pyW?=
 =?us-ascii?Q?5oGKT7wgqbl7o743JxpSUJtYsNDm8M9t6Ps3khf6ms4AFwKCYYcrxBc6D9CY?=
 =?us-ascii?Q?1k79Hu4g4TL9MhN/Qg8t0N/85CUpLFdr5eucSJRF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5b637e-8d80-4b7a-d520-08dc7a130269
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 03:55:24.5959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXCBSMUfQGToX7z0Q7NMlX/ZRAzTzeAkYEH6niAYvLLXURZxDkXAc8H/sEVlL+f4KQETdvyi79+2+0oJH1qkbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6569

When running 'make scripts_gdb' command out of kernel source tree, the
symbol links gennerated under build-dir/scripts/gdb/linux is invalid.

$(srctree)/$(src) need to be replaced with $(src) since
commit b1992c3772e6 ("kbuild: use $(src) instead of $(srctree)/$(src)
for source directory")

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 scripts/gdb/linux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
index d77ad9079d0f..fcd32fcf3ae0 100644
--- a/scripts/gdb/linux/Makefile
+++ b/scripts/gdb/linux/Makefile
@@ -5,7 +5,7 @@ ifdef building_out_of_srctree
 symlinks := $(patsubst $(src)/%,%,$(wildcard $(src)/*.py))
 
 quiet_cmd_symlink = SYMLINK $@
-      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/$(src)/%,$@) $@
+      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(src))/%,$@) $@
 
 always-y += $(symlinks)
 $(addprefix $(obj)/, $(symlinks)): FORCE
-- 
2.25.1


