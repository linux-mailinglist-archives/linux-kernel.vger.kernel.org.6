Return-Path: <linux-kernel+bounces-279541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE694BEB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3EDB23E48
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFCA18E034;
	Thu,  8 Aug 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eLU3kkQp"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E318E023
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124710; cv=fail; b=CW9WNKvAi7v5dIgf4ksRwSLpyEKHzG7neGTj0z2IkIo+4HSL2X6iZbx9TAN6iNj+2e3YsIFGLQYHC0UlexMmol7j6CiUumZIl7ChD6EJH4DUdhAicPd4Nc09tEOCWTdsiznkGzuNzEdVJ9oXFzBwSRHh81r221fpcSv7CL13ZcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124710; c=relaxed/simple;
	bh=rIsU0NmRiGnblWc3Z7B+tGiG/GwJEPCGx+9H7Gs6YOs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qUfdMhP4BMg1FyPw6l+xi2K83Ihvkofu1uj/Dpd3aFT5fN10YCI/22XAlFJEGiVPTB9L9WHnfDLQDo0pnobErtpKQyotchU6x85aIh1TOS+9CeM+/3sd4fBfiwh+OY7RWrGE5lFMzlygV2Vq8dmG8CEY2156jCON2PfLLMDU884=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eLU3kkQp; arc=fail smtp.client-ip=40.107.241.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+xG5RtY6utLqH7+xETx5HogQBuh+3lUnKbQU2BDIWrlpFq2H8NfZD3HY4p7Y75wtcmcpt936y1lmO0OUada99G3BYgrBBElZGJhTISCoxWmnPY8o9XKWg0Ya1Rok0EhbgzxaniY8VtSERsxOSqhE2Ltkr8fIU0qKIRExySNNdKfQM3NJqxQzxNcUE3uqJoqJlqA8T2uOlucQ6llsNdhIEbzIGNJLPZD96Fyi/3vzFIwIeXP5lafarbBS8Ieqxnwxaxc+QhVvPI4K42sFJZElzDkwyuYWUq8J1AdiN7GcUasGJGUu+YhI7+aKq+zAUlY3SvDlHhBOsNVZeppje2Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lrAfu0bXNzDTl7jkB63iRk116p6qmpBnqe3cP5jpp0=;
 b=yeXQG3Gpx4iAL1134Qpo1Jg+VCRqms+eMk5ti5x5R96zknQTP2M+ea3oryw1BqnLDwWOOn9irdNQg+BkP+X0DlfhwsCywjZH1Pa6k92+RWhXd/UXVOPzdemgtUxAyZIJaPazvcSyiKoDhO3YukD4yRhGSfgDu6XTRbvu7awDE6+rtTP/Qs/ryu8ft7YbxsFeodqPHSdBrBjaYWU4+iFSfEF7nMM5USMra1d0REwc6shFjet63wvc0MDOs3ET7EZcyJU7UU1WzQN4QhrpfW7x4r7rMtKCdspsoehdklGD/nrwl/kwTylTu5OIUU9wU/t+P25rPpNO0oX0JGxM1il8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lrAfu0bXNzDTl7jkB63iRk116p6qmpBnqe3cP5jpp0=;
 b=eLU3kkQpAc2aL1KhGzoW9n9HGgxtQZ1Sf6O0QBjHqdTF3FTI6KJXSIixPXV5MmC44jxSdJlRepqIxxG3A5hW4aqKwHHgGC2g/I3KTGGRo3gL9e0iRucnirc33hqBKx4y+mXCF/atK4fBghj1cm/JXi6gCGJ6WDUe//THLS083p1ITpRfBfrKeGZAZ1m1KfMVxgBu1EP81JeIRdWxTTQipQdgVFAezQPrMI6yuPd2rRmdbheghxHWI5FvsVJQH/btbOTIPhrADZM4th0zP0AEOay4RTd7EMJd3WsKWAoo/Mm0egSs2cDm3CkNusE1dNMXdZXyh+5Vooon+Z1bBvZzeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8403.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 13:45:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 13:45:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: srinivas.kandagatla@linaro.org,
	shawnguo@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	Peng Fan <peng.fan@nxp.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nvmem: imx-ocotp-ele: correct ELE fuse check
Date: Thu,  8 Aug 2024 21:53:52 +0800
Message-Id: <20240808135352.575378-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: fa381978-2ea7-4917-6deb-08dcb7b04ea1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8W2x+kCqA2gYUd3QGl8x/+snG0bhCmajEC1Z6QaHqjrSO6Fij6b3nvOz8isf?=
 =?us-ascii?Q?yw48gAD/U6g0KorixwxMewimG04v0lTPH+jjHSz+0EY5ubMfyIRFscc6be2m?=
 =?us-ascii?Q?xKEgdBbQwCDiXkCbMZkpi+gMBVnTpQxD9qNS/9STA0ieU3y3fcQwFjFlbKFi?=
 =?us-ascii?Q?7/A4Y+IFMOCMUKwLjtC79nFklbotBdrfCCcHvTbfqBEV4eYI2CtM7ynpGj+e?=
 =?us-ascii?Q?n91K1F9BkGHRSHqf5KfxpP8jMS18LBTMJdy8MchdLy+LlQ7kSv0MqTYu0jVB?=
 =?us-ascii?Q?tftrG3FNk9WC6jQXY2KxxU0V8aJCPQAmwzbCQrAHjN8nQxwTXKHSMzF9bKzt?=
 =?us-ascii?Q?YF98dfU58xCeS89qt7/DAu0EuUAWKpcmOnYmIIBpZjAoAoRjZ9u22xh4u7TZ?=
 =?us-ascii?Q?jZGBKHhfnFEJNLLpnGXyW49XNC6Uc45T86mWl+CarlK7BD5SNHfl+L82Ovft?=
 =?us-ascii?Q?he3Mpms9R7nbfmu17/2gnjNQPNXzDREdA0QcbemIQj0Xdb/s/tqxMOALPSpT?=
 =?us-ascii?Q?A15qewmhHjk8pCItjRNGB6MaBb6SmeBjTpCZDjGJh2cjPaFce+WlcEIt2a/B?=
 =?us-ascii?Q?5Ak62Me4dwt21CbkTQykqwj2ycB93/SBw35rLwxMJSjcHvGYTRBZSa2zq+ag?=
 =?us-ascii?Q?9cBekLpkBriJS7ERjvWE6UKkP36AJ/Mnumzx8TrkZRJ/pQ7+kbBHeGh6Ecoq?=
 =?us-ascii?Q?Z1Oo7HfnQuFPutFRYy8rnCOayGwRhHtCXg25amSc/8E2p3Vep2vumwOs+NjC?=
 =?us-ascii?Q?ZnTPS9P7gPt5Uu2zQHbECocy6oidHBqQhLkp5kKH3ID1uJnLAdcFQCpHe7U2?=
 =?us-ascii?Q?z6qsuKTW43Ik9rIeYExwqVa9vbG4Bj0n/XhRXNrnbuXLc6M1yTjHC9LlW3yY?=
 =?us-ascii?Q?Sre/A1N4w9Z6evNnMIatLdM3SkPMdfSB/0iWoYLmxe97ZvONU0hJiE0F3B2D?=
 =?us-ascii?Q?8SBTyspxItsDhfWlHzw8WGDQipnPUExIt1fX7yqOesIAgrD/j/ybvkwhaReK?=
 =?us-ascii?Q?l8NuV9CRNz0YWrOB/MKdYrW0Mw4BMbqGYJ1jdMT2Lz7E6FDCAo6+TcVcRVfr?=
 =?us-ascii?Q?AtFYCxRmavtH0L7YiYx8Oorg12aQTGks0ijAltwYFlLus3O7hYHhso8GGfuC?=
 =?us-ascii?Q?JPchNiKSA2JWVgzJAhpFOryXBzRw3/iI4hmEF1gEqeLbc6p0bu1xXmiZpK1g?=
 =?us-ascii?Q?/0IfSG8ZR/3hfXJns/aZpXUNL5I0LesR3dAHBGCSngVonoIv/+3pZSg8KRkl?=
 =?us-ascii?Q?Kwv6wilQPDQ5clJXQqZT65AZX/pOaqYEXVSP4gHsOw8EDdycHs1sWaizuGvc?=
 =?us-ascii?Q?a3jaL+d5rrTCQPwuZ+Q4duege+UFfE8IZ1zdXemX6urn61+4uoBwR7SNMaF4?=
 =?us-ascii?Q?lnW3dCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIlWaBP8+mjnU4XG983Fly7erk8dWTyKCzUUaPYonFpJ8/1C6Qk06YNe0N5J?=
 =?us-ascii?Q?4Z3YWq/GN8AEr6J/idMQIUvWqys7i0Hi4aVn/A6DD1cYx0ANXQCHykZ5Rx9h?=
 =?us-ascii?Q?QO6kdFI7CJaLg7RKNpkA+34NEJSVyy8c5UsU7Wxlb+MUjLnjPoacqeNah077?=
 =?us-ascii?Q?pDhZa6rByKt24M9Y8gbIj348tzAVtb+PObU6alqgLIx9SnYNWlw9NcwXq7jW?=
 =?us-ascii?Q?NPfSFhuN2prhk1BPhd0xiGQ41kB8evWihvLjGEuUe3kHj3YsrD2/74Susslg?=
 =?us-ascii?Q?LsKZLcZQ6X3HzF/OKhi3rmwq7kK9j71qpDrZ1S3V8JEV6W7sedcDYzo7/P8b?=
 =?us-ascii?Q?j7ybPjAVeIEXX8AQUqRqM0/nb5prspnwpuRwa3SLjCx0Fdlis87e0dyAX6Xd?=
 =?us-ascii?Q?Or1fAKI2P9+NrjZ3/E4HpaiDCUlRNaBCtFnAHqRNfLjWhe9YNCwW17IZoNxQ?=
 =?us-ascii?Q?+FoSjO+ljh5ePMz76Mzv7g++3CIB8J1Oy1l3VZ4bN3AedP0mGE+6AN0BIwPx?=
 =?us-ascii?Q?nlbMX+WZj7QDv3qGZSKxDM7/WE69WMel89SnJIjwHwEswXAP5JkZJPJPSVhl?=
 =?us-ascii?Q?z/QkZOHzUZ54et9QeAj2TIMEiKtBXztGkUTyFX3Wkk78HfTTgSQoplQRZBEZ?=
 =?us-ascii?Q?Mkb88pf3zCN8jwPPTn0VgxFoIj+kALGkAQlLnW36tInzWMwTJXUgvp4Bfak7?=
 =?us-ascii?Q?+M8ysTCiawn1/4pYJfrgAQVcGphPW0Hpqh6I8kpHOu/cY1uo+sKlNX06xR3+?=
 =?us-ascii?Q?wKv7CdoHGEhUHlBkBg6oTcFRY2QQdXek4ogee02zUBv7hUh1rK286zv30GL6?=
 =?us-ascii?Q?NXkk0fw8ac8VA5eX7dpP+qL7sbZiQ+f8VWtufWnIkoJIYy8FivpzQ32iJKN/?=
 =?us-ascii?Q?Q0pOnpqqH/5v0yBPRes7tC9SVa7z4dlDJY4DIYgw08OTwfcLhS9YQCHyPwll?=
 =?us-ascii?Q?gEMg5J0Gb9gzkZS/y6WaS+MU8FUgRkqIOU/89QNgi/5vGhOkLdPcHaGXiaxM?=
 =?us-ascii?Q?QydtmN85hPCXXoRZFGcbnd7X7+L2bV8jxSVS8YQW7aFdia6IjNsjL5zRbHUK?=
 =?us-ascii?Q?6rQyl9QdHUTUmnZ/5ucrnhSD9FOBuTKeIFSIcdUy/+s9FDOocMDi+/qDf4C7?=
 =?us-ascii?Q?Ln67dhoM6PVasBqm4nP17lOZ0t44fJbIJuT0YskWLgdz0XZrkl4XHrS/sgtO?=
 =?us-ascii?Q?gCITcQPTTG5RXHiC4PY6vgKXI78LVZbLWeLL5ebKDm6XrEJuDskS2rzzGzSC?=
 =?us-ascii?Q?m38Zxfbscy89A4c4lUzpWbga7Q/v0itKuZjbL48ATJTze0oyfp2RM7On5CdS?=
 =?us-ascii?Q?I8RhfxwWRQXgwaV1fpa+/rWycMaWh464p48pTwdQFU/R7rbMkz2RpMqOxPMy?=
 =?us-ascii?Q?On06ZJyTyawvqX7YvsvRxVs1fh2MM/vk+90F+sZUbmo0i6+c3sFKqVgQXjc5?=
 =?us-ascii?Q?25dl2+blGYm6WLFhnObaOxu9i2Zw0/yBPkUy7Oyr/kHWdGEjtEsddz3LsP1B?=
 =?us-ascii?Q?9J/JSjNTFajknFo/Qn7SVdD3mcQlJ6CRTcxw8GzajIqaKPHSkknDjYydP/sf?=
 =?us-ascii?Q?/pM0unequv2pYYlacCx2sUpoWu7Ydr186PpPnm5u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa381978-2ea7-4917-6deb-08dcb7b04ea1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 13:45:04.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91Ezc4RzoIEG2bR2dshP+SgE2HUrEqjLvfyh7Tiujz8F6UhCOuWb/ODIYMRX7HHFGa6Y/FXniHFiWxY86wP0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8403

From: Peng Fan <peng.fan@nxp.com>

"type | FUSE_ECC" will be always true. To check whether the fuse is ECC
fuse, need use "type & FUSE_ECC"

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408080514.wuSJ2V3A-lkp@intel.com/
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Fixes tag not added, because it is still in next tree.
 My yocto toolchain not report build warning. But this is a silly bug that
 I just see there is value out and suppose it is correct. The value was indeed
 correct, but only the lower half.

 drivers/nvmem/imx-ocotp-ele.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index 4f22310920a2..1ba494497698 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -94,7 +94,7 @@ static int imx_ocotp_reg_read(void *context, unsigned int offset, void *val, siz
 			continue;
 		}
 
-		if (type | FUSE_ECC)
+		if (type & FUSE_ECC)
 			*buf++ = readl_relaxed(reg + (i << 2)) & GENMASK(15, 0);
 		else
 			*buf++ = readl_relaxed(reg + (i << 2));
-- 
2.37.1


