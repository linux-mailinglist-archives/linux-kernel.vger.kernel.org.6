Return-Path: <linux-kernel+bounces-307697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FD696519C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E59DB2080E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B95156F5E;
	Thu, 29 Aug 2024 21:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZfQEBH3M"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944018A957
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966109; cv=fail; b=erecQyhAUJoG7bhudEUOjHJviIr7gAi0cbfQndJxlr2iOESXDX59mJf2ylvn9CemeE+iOBarroX2ZIcq417l04wIGxQVJcKuZ21+h6CqBklYhHJrXUKSzELYK0dTqkTjfXYd06s9jt/P1nXZJpNbgAtiSVh5AW8C6lUKN5R2BD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966109; c=relaxed/simple;
	bh=ri9MIXRiXjqbTg39R5FGovPrvPxflLRVfGXm3ZFPAs0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VP+GjDfdf7vwuy992g6gHxR+/tllKrBl/Y3jyP1X9ekCzVBEgqXYCA6l7MVB6+Bp4+ZMK+8bdpEAPr0VNEr8fKpy4f1gJuxPpaSBxXXgsVMWWzINpqfzuBdlIHFa5KInHW58EfRklBNl5UQ+WwxW+vI68cNcwthBZ22QHN+Fjdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZfQEBH3M; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDuLDBK/UtzTXF5MWuC0yqfD+jZD405Tgwt9dCnwskhK3gcDZiIw0CcYFHyRTxBtDwcjwj8SZM4WznhcaUda3KxpCHbXgjanb7blaKZlQVo7RzwFI2X2Kkp0r1m+6UjHpTxnyO9Nh0KyJUhozjVQBdl9eXBNlDs+D0493+H7/+XaCD+6IdY6Oalzftpvm5R3WToZXthQk3gJa3vX3mQt86HFoqUXvxFIEpG5jxRm9PZ65Std/jHT47zaJ41fHo9eCOLm+60O/a7eUpYk/ApY68y89I+d2DPFWX2/dqkESvJbL8EvWV30qPs/QMf0MIjr7ChgbrgjUS0/R/Zj8B3tOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cww+xyydNFuIwjFox6cDRmzfODgCjih+5wH/d19iPXE=;
 b=Sxrf4BxuH+aW/Pb4Ixx7k+jg6DJKtDWvfp8MRVZ0zvdcx106a6bjWpPvt6QejoszlY5IiIK8em4i0n+sbWudTlseF+UPsLFBZGJwz+I+FKCl2389OmXCgTohrYGBEI6d5oDEU2fT0DEvWAxggJdRAkllvfBnSFRxaFRVHpDH7BXUDwqc54ZiRiBRRE/+GRFv2vQHpl4RPXTzUhQ0ugAiIyS0voytO7XDKpt92uHMKM4OwTr1nzzGhflvR+xfN1ibVg+kSwDpzAk79dxO5IZyFAA8sZfLNKJIYIb5gEwr0/v6CbNDSMZu19pIBXOd+QQTHsfSGOl7/DvXYnZO7KQJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cww+xyydNFuIwjFox6cDRmzfODgCjih+5wH/d19iPXE=;
 b=ZfQEBH3MVlHW46+fBA/D6gatcGMuJ9IIbEJt0LzCNW03Nj19CYPHh+uRzF9P1KLP1xzodzCb/jx7nyY9ZzBY1PwHMkANJcOW39xr6nVK7XbSV3Ndt7BLsCXP9jyBT4jSgWmNIkVD4Ihtr16R0JwDfPSQ+6uQbk9jMSnHB88pEDX+lusWBgwMQqiquC8zLe2josFmk13bFqFIy3t5y1U7gHDmtiRbtbEfaNOX7cEDW+Wuo712YPI4MQWYZoInMGqNGhneubSkcUKQny7ZKOIYfrNPT/DCk2j6X8h7QdIoX+4XDJlq5QVztcSvMJT3E9zO5gtpmStHopsuwLvXi5/obg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7560.eurprd04.prod.outlook.com (2603:10a6:20b:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 21:15:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:15:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:02 -0400
Subject: [PATCH v4 05/11] i3c: master: Fix miss free init_dyn_addr at
 i3c_master_put_i3c_addrs()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-5-ebcbd5efceba@nxp.com>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
In-Reply-To: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966083; l=1199;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ri9MIXRiXjqbTg39R5FGovPrvPxflLRVfGXm3ZFPAs0=;
 b=bMB3QWwqqCes9ly5xS1nICwxaxtWpDAE97V0FjkwcTPA6PrPPoAcKO0qlBcqGKXgJKiF44FnC
 J74G2fbImxACxUkY7APZ4cT0Ir63tCQoyWBBD+OG7Jzs1B96140vM46
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 80eecb20-d659-453b-e440-08dcc86fa59f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YTBWNXl0d0RMWDFxNy93UEN5T0NiMlNXU2dXQU9WbHpaQ2ZaSS9oZU9SR1Fz?=
 =?utf-8?B?U2pRZ1dIUGFxYXk5ZnFRNFRBQlByeGM5NjJPbStvOUkvMmRxWTRXZkdGdHd6?=
 =?utf-8?B?MDhvSHRZRnRGMnVwY21pMU02OW9WcVNMRHM0Zm91QlVHanZWRVRrNFRkS3Fi?=
 =?utf-8?B?Ky9lOXdQZHl1UjNLODdtSmRWTXZSemRmb0NiZGlxRU4rREk4aUN1cnZub3d3?=
 =?utf-8?B?emJHVit2YlZVcmhMVERSbkNZNUpMK0ZweWNSUmpvaDZRbW1tRS90VFk3NHor?=
 =?utf-8?B?RXgvQ3k3WTVPTzArOEFsZjJDQkRxM0N3VXJJeDNUckpUTDlldlRGaWJoWG56?=
 =?utf-8?B?SW41K1plZjNONUgyMzBtUTlpV2JmY2F0Ukc0WVhsQVRVVlFJSVBYNFlxWXFa?=
 =?utf-8?B?V3NqSW9yUi9mRTlrY2Zaa2NYTG9IUmRTNXM5aUFOMUtTdmZ5eDJ0UkY5Tk14?=
 =?utf-8?B?OWZVTXEyU0RaaUkvdVk3UitaMDNSaVBIVHhUSGhTcXZ5a0xxTVJBaE5wbDkz?=
 =?utf-8?B?TElaZkZIbHJzUVlJTnhmRjV2dEtXM2dUcGd2SXE5K2JmMXZvNTg0TmJCai9W?=
 =?utf-8?B?MTNqWExiRkZidXJyVFRFRjJBb0lRSmhMSEM2V1hBR0o4a3RiZmVkdWJUSksz?=
 =?utf-8?B?TVVoMWR0Qk5DOUFMSlgxTmt6MUMwK3R1ZlVCektjOWU1Qzc5ei9RQkZQK1dx?=
 =?utf-8?B?ckd2VVIybnU4L0pQRjBBUU1mTU9OQjlMUlRZZHpLV01lU0R4MXlPMTVQOC93?=
 =?utf-8?B?MHZnSUNOcTJZSnkwLzhlK2ZoUm9FcENqbGFSU2FPTDNSVFRlSzlaWENxWFMx?=
 =?utf-8?B?ajFEQkZzSk5YVnVtdnI2NjJKb1BaUWJOWDRzOHNYZnY5a0VOWi9jQktMR2Jo?=
 =?utf-8?B?MEN1bm0wZnJaTmJUU2J0cDZTMDVzYS9KTlI1dSt6QXVTVHl2cHBlQk13cHpL?=
 =?utf-8?B?RmV3NUk4TWplUHJXT0NDNDhPaWcyUVp6NjFvTWJEQmxFSi9CZi9ZN2NYbCtn?=
 =?utf-8?B?R0dEUVE4TzgyWlhxTFNnK0FwWTZBdVRzdEl3d3R6RnkwaFVEVERwVEZydlFm?=
 =?utf-8?B?a0J2ekZTenU5V3BOc001b2NCWEl0Qm52ZVJ1KzEyNjIrckh5QmhTaHRtVjhy?=
 =?utf-8?B?bzJXK0wrcUo4aU5sZDdzUEtwVFY5ZWRDM2tuQUhwRzRIbGdiZ3hvSjBydDdQ?=
 =?utf-8?B?cmlEcVpVZFJmR2RMMWh1ZjlJdzFWOEpCWksyUldORFU4eWU0VWhEYkYvYjhs?=
 =?utf-8?B?VllGa1VzcmZIQndHemlJNndndWJKMG1mbkJmZ2EzbVF0SVZTeFR0OSt4MDN4?=
 =?utf-8?B?bjB5RHdNakdXeEg3YkMxRTdlMENHQU1NaGtXYXZseUF3ODBUSVF0VTdCZFl5?=
 =?utf-8?B?TUJESk9iTzlkdi9uMEVSNkxhZDluU3JZOWRVYzRRUVNMdm8veXhqdnkzaHZ6?=
 =?utf-8?B?UEtiaGJSZGdVRXFqdjNQaTBOeFZTTytDRC9aaCtEQmxRc3o2dDRMQ3lyYUlF?=
 =?utf-8?B?WXk2cVJBa3oxT2xPUFc0dVBsT2dtZjdIM3NzbVV4RW1KaDU0NmhvWms5MEZH?=
 =?utf-8?B?T2JUSHYxUzZOUGZJd2ZoaVZoeVpIeEphTytPdUpDSll5SUg4N3lxem5leUZ2?=
 =?utf-8?B?UzRXaFJ6bzc3REFTbkltMHVxdjVXU2lkV1RqS2xwZlMvVEw1cnZIbXJIZ1lK?=
 =?utf-8?B?V1F1a1NiTWRpWUNLQStHa0ZBY0hWUGtsNGFHMWFuSFNzMklHR3F0eExKLzBU?=
 =?utf-8?B?OXF3c2xYbDJldVJRY0JNSE9DOFdNSEhXZW9CTmt6Q3l5UFR5SVhlQ1lKRkZE?=
 =?utf-8?B?WFBKSURHakRNNzlSLzZQczFEcWhPZDBEbW9naWxLc1NCWWN4c25rWUliRWFo?=
 =?utf-8?B?Yk12ZzllNWw0V1RnQ21hYUpMTmZzUSsydVlhT1YxT1BBdHc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dnk3eXZjTllHKzZBY3NPWjRCSFpPWExRZFJlTjJyN1BMYWJiaEV1djRBTWVY?=
 =?utf-8?B?aGx1R09aUUkrR3k0V1RrWjBBRlk2VDJDL1dwYTluYlhTNCtCWTdQcis4K1Rk?=
 =?utf-8?B?RStha2tEKzF0dnBnZ2RZQU9TS2VXaDBvVkZ1YWpVQUk3MzFVMlZaV3laalY5?=
 =?utf-8?B?REdvOVhzQ0V6bWtVNUNiQ0ZzNVJ2TW15Ujc4cWw1NVlHODltVlQ2THQ1eG1S?=
 =?utf-8?B?WTZmRi9DN2t6akYxRm5aelRnLzBVdjNuWC9IdnJhK3VRbUFrZHl5am92WXVD?=
 =?utf-8?B?UTVDeG1QQ2lwUFNGaDRQV05LQW84citDQ1E2QlFweTdXTnpKTXFkOFQxa01U?=
 =?utf-8?B?STdNK0tGT1UvcGNNM0VISXh6YStOSk9sakRSL3FJZGJTWjkvL0J4ckdNZWFI?=
 =?utf-8?B?VEFuZ3kyVlh6WGFkU1ErcTBRVnFQc256VHZ2SXBNZFVvUnJaMnZqWGNTN0JJ?=
 =?utf-8?B?NEVqWno3RzFyMXRNYXVPUm1YT0dvdmhyVXJ4NXRieWdPUzkxSGFFc1hRVE90?=
 =?utf-8?B?QnVTK2p0K29EOXpYTHlXcnNFK3JCSmZkaWdlRVhHZlEzejNteWtWQzcrdU5j?=
 =?utf-8?B?K21wdllZU2tMLzBDRFdGVFZlb2ZyeEt3MTJQczNrRFNFMnN2enRldTdKSk0w?=
 =?utf-8?B?eVFnUFZZRklNa2JLeFZTd1dhMXF2SVMxdEtkNk5aaXhmNy80U3Y2bDVtNS9q?=
 =?utf-8?B?SW0rWjdIZ1dyVUhxeHNRZjRrM1NmcTN0YzV1ZzB2cC9RNlk5dUt2cVNlWE1r?=
 =?utf-8?B?enVxMnNZRDdoL0RlUGNEeEtCVjVvMzRUbEhmWUNNQ2VhWi8wa09zc29jZWwz?=
 =?utf-8?B?dUlTUmdVWC9qbndhcjJ6ZEswN0hvWTZxZnZxb2ZOeG5iV1VTTkhuS20wL05C?=
 =?utf-8?B?b1E1SmwzNnlvazVLeExxTC9vR29KSDJPRkExNnUzTk53RW1uYzRDUzhieHZU?=
 =?utf-8?B?RWlub05YaHRYSk56T0N6SERjemdmRm9PN09MdjBTcllvNzlZRXBNWTVDQThu?=
 =?utf-8?B?NHF2YjdsQWdhY1hUbzFNTGFWbysyVVI2VUVxeG04a1lCTmI5Rjh4UEFtb2pu?=
 =?utf-8?B?VGs0QjkyZS91NHJCNEZFOU9Da1Z5a0x4SnZDRlNhczhvUDBSQUpTRm1MMzM2?=
 =?utf-8?B?N0h1cEp6ZkFOYTNreDR5REdZRitoRUp4RzZyVnhJK1BER29mYVhBV2lVVnBL?=
 =?utf-8?B?enNxWWZPbGI3NHl1QnRKWEF0dHY1dWpSVkR1bDNFS0U2Y29jYklZVm1DcERo?=
 =?utf-8?B?WXllMmh2a3NSK1BleXZoTlpDUXlKQkZvWnU4blhpaWxGY0ZHWnhjNWpmZUxz?=
 =?utf-8?B?RDVPbUdNTis2akVwbERIY0hHeEQ2OEtDbXEyaDh3US8zWDk4UHFGMnA3c2ZC?=
 =?utf-8?B?Y1gzS1I5QkJDQzdheVpDNi9XK2FiM1J3NDYrYXBlYjZBM0FkUG9FOENOaC83?=
 =?utf-8?B?dkt5SU8zbEVQaS95aSs3dmhoV05MVXpUd1JpZVRsRzc2c1lIZ1luK1VpMzN0?=
 =?utf-8?B?S0pJZmtDV1lvZE1PM3dwOHFlaSszcXBVYitiWTA2TCtDM0JFWmlheFl4WmMz?=
 =?utf-8?B?ZWRsT2xsSFF4aFNCZDFCMHhxcUNMbWtsRXgyNjVDVUZHQ2cwMTZja2FaWk1X?=
 =?utf-8?B?eWZYT0dOcHVEbDd5TU5tVVJGSkIzdkl3ZWFqdWtQMDdaeHZWNkJSTWwzWENM?=
 =?utf-8?B?anE0ell2T1FRUG9oWDhWTDF4aGVQUGhBVG5adW1wYUt5YWNYVTJTNEdNQUJp?=
 =?utf-8?B?TVhUOXN6YVYrVEhoQjdWTDdodlVuS3N5b1B1Y29nTnQ1Z3ZITm9zZCsxN204?=
 =?utf-8?B?N3BRbjBhaS9ic2tib1NlY0xMREtWamVhRC9Eemg4dDc3MnhXNmFOb2sxQ0Z6?=
 =?utf-8?B?MnNjRENiSkRsNHBpaW03QzZDMzd1OTFUU1ViUnRrTnc5V1orVThuelNGRUFH?=
 =?utf-8?B?ckdBaEY4Y2pteDZmVHg5WUZSZUwzbWsyZ0h4S01Ndm0vVUVsODdxZFFNTzNM?=
 =?utf-8?B?bVhkeU00eDBJbzZDa3c2Uko2blo3ajlCcS9rNFRuanhjT3pOY2lzUU1BTVEw?=
 =?utf-8?B?MlZJenJXYytMRnZqdmpmSlFqelBwNUIxTzFseE9ORTNxRFZvYU02TzBhdlVa?=
 =?utf-8?Q?ch5oSBAFVpNeEs2nY3hLD1rzg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eecb20-d659-453b-e440-08dcc86fa59f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:15:02.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD8RoeLWP55uPBlTG/xBVidqGl3HzXBtezCYHt4WCcyYPWXsWQPWwubX2yw59+EO68KxLZRtmrvQSH6+WaJcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7560

if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
                                      ^^^ here check "init_dyn_addr"
	i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr, ...)
						             ^^^^
							free "dyn_addr"
Fix copy/paste error "dyn_addr" by replacing it with "init_dyn_addr".

Cc: stable@kernel.org
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- mention copy/paste error
- Add Miquel's review tag
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7c8fc4378b979..e7cbfaf13b599 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1467,7 +1467,7 @@ static void i3c_master_put_i3c_addrs(struct i3c_dev_desc *dev)
 					     I3C_ADDR_SLOT_FREE);
 
 	if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
-		i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr,
+		i3c_bus_set_addr_slot_status(&master->bus, dev->boardinfo->init_dyn_addr,
 					     I3C_ADDR_SLOT_FREE);
 }
 

-- 
2.34.1


