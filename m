Return-Path: <linux-kernel+bounces-347741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1046298DDED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327E51C23DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656B11D1738;
	Wed,  2 Oct 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dX2GyIFr"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02CC1D07BA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880668; cv=fail; b=DhD0L+iO3QtINhhPWl+Ge4sGsYn9n4bRStm5uk6KaUE5cTsGGe0RXyr/wVDXMsBAjWWArk9w7c49DcEM7QSrVt/o8p0MAY0VEJtuiuNOMuK8aYylOj5zT0/AEFVSc+OSfpio33BjDi6arlB1jxCtDnP4wf8KljCfRRSFRi1llB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880668; c=relaxed/simple;
	bh=km8jyYKynVS8oCIdOvA4qQ3oLe8hXP9gLirgD+wv2WM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kLVxf3i0qF6x1btMSi6h2Zn6vwxfrSOuxtPg/26N8wUCRkchPygW1ugLan6Qbag0gQl6ga3pQX3Gmc46pcCucBKU3J+efTKqP3RCAQGEfEOi72kcr6dzd13cCQWfDhvm7xAG+ZxPmdGynVsu8zN2P28PDNu9WE/3TB30uhWPHog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dX2GyIFr; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR06q5A3kMQGujjCFnBRQuNNXDVXH+ifM1ZnidTMmNMHVWOxLjPNFkUnsLrJqeDqMOZ3ewoMKjT0j3W0m5B0zHP7vCCHJz5Zb7AsAiUbVCtyXc/SHYcrouTpgWvKdxnes8g8Nr3Am4sY/53+I2JfU//R61odn6T/NPESErKQOHALScwhEYSN3VwvhFfFp39SB7x/wz2WXUKUkpc2wwRQnfWMS5YNMEeJOGpSZGiXTU6VbWHoXTHN4Vskw4HVrbd/udHiSctq05/2V/3ww+JP/gG6r/8tRV6uC1rntC0CRs0yFUG12TFKU04CC51J7nIx4jI4HQCEsUfyBxTevw1RvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR98+9LS9quTYVdmJkr0U97KPEN31FgGaNrzukbSyTU=;
 b=ngAQCtXhEKIN2pKvVBPhD6z4BozYzjiKxtZsAk8tpGpBvCSSQF9dkILp1EH+mWfMWnOiEhB//ZRYCd3In7vtEF5OBFt//HbL2JuseggNWLRRg/FmEZAkT2qAPHrPb1o5Htios2ei7acaUVtr9F9r4RAPrhRdhQU7K9u2dZXjo9yylKCcwn7P7CsJRESPTIAsfF5/B1ifJPS4g5wxWscVZquWHVdi7YNuNujyeRlYTcqWOGwo9tdK5TBTqf1rhBPAQ6CF8aGFdvJASHlANxZwmSlgMaigTkde6vIA/WqAFxcVGUb3CkCATZ/zD/2rmsSQHLo8GHx+MvRBEnSw1zywQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR98+9LS9quTYVdmJkr0U97KPEN31FgGaNrzukbSyTU=;
 b=dX2GyIFrJmkKFj9e+KCMf+dDujzSDQc/g3RH8Z4qIS5FR63PiGoVODS+wMYCqcV3R6MvF6Avyxcpus9W0Gv47EDC7YaYg0qjjQRlssjvQl0BLMV5Ut/KQ6Xn/fw/2IgHgnLaL6J/rO2dIifT2odGO/ve6WJgKo0HbBdDfromPJO4ALBRhezDQ5q9iUp8mDO4pNNUk9KU/ABPFTzdvwB4MCYxmLjYGhiMfV29xez+HPP/f8D70NZBsj0fDK7RBapjiX7oEDuLcMqLnTiQy7IqcrefwRNEXMcXynKFgpJ3ewm+Z9rz5WbnftBrEJnZNdbYbKeyAp0pBt2QpJRTmfTCkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 14:50:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:50:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 02 Oct 2024 10:50:35 -0400
Subject: [PATCH v6 3/6] i3c: master: svc: need check IBIWON for dynamic
 address assignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-svc-i3c-hj-v6-3-7e6e1d3569ae@nxp.com>
References: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
In-Reply-To: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727880649; l=1618;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=km8jyYKynVS8oCIdOvA4qQ3oLe8hXP9gLirgD+wv2WM=;
 b=0/6zj+o5ZrjhO8E6paIbmVG6vIWC79f/0qAGiqEpTKUA6UaeH+V+GT8AZLzdrcqDZpy6QO+jK
 iBpO642BkxUAHGV4zp4/aIdKEWubL/LXeKK8BdWmtfzQStd89qp0tlv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6e1e14-3da9-4524-f278-08dce2f1a065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2gzMlc0VlhaeExlOWswaFVXaEIrSDNYS2hEeDljNmM4ZlgvVi9wZDRqVStT?=
 =?utf-8?B?QWRaZFpDQlczYThEWWJsblJjcUJBSWM4NDZoNXdZSG9GZE1kNmRyS0x2a3pp?=
 =?utf-8?B?RFFhdk1PQktOU1A2NHVaMFVBLzA2TUdxYXNYVVhnQVVJOWxHSGUvdy9OZXZp?=
 =?utf-8?B?ZnYxdEhhaTVCdC9seEJ4RUIremxUKzFwWC9lSkZ0b2xkZjF0cXdic0VHWC80?=
 =?utf-8?B?Y3lDbUsxNStLN2sxc0ZEQlBRR1NzZGFKSmZqZU40YWlHblFEQkRtUDNvN2pp?=
 =?utf-8?B?MFVaWUM4aVZTTTMyUUxTYjdaWENndFhLZllGR2F3aDJRbWVPWmR2WWhGWXlZ?=
 =?utf-8?B?ay9Dd0ZWQm9wVHAzN2RYcWw1c1FFRlhhY3ZpUEFjK2J5NTNwZ1lYRU5tUzZj?=
 =?utf-8?B?dXNLdVdxVElQZnNENVZkU1VxYzR1RHkvL3QzekxKb090aVB5OGZacGtrUUdB?=
 =?utf-8?B?VFkyajcxbkduRVFqQTJzV2xvOUkvdUlLdmlyWUhoOWZDYzdYVU92bkI5UUc3?=
 =?utf-8?B?eXo4S29IM0dHTWluUDhNcG00UXBaVm1ieXlSNUlqTzdzT09vWi91TEtnWTZG?=
 =?utf-8?B?Kzk4OEJTb01Za0QyeUdiT0JFNDZ0SEVYYkg3MzFZNm5SQW1rWEUwY1pJa0Nx?=
 =?utf-8?B?THJ5RTJmTE9XeVJNNUlyRVJic1RyRkVIU0xjbDZ0Rkw0T1pCYjdCMEU5T2s1?=
 =?utf-8?B?QS9jZ2hNeEMxK2RMZmMrZEEwUzBBaXdvQU5uNld6MFZ3NE40bmZkdTV3Rk9D?=
 =?utf-8?B?OFJWc1VhenhUTy9mQWVrOTFGOTllcUtPOTY1RUVnS2Qyanl3V2JFV29EYkt2?=
 =?utf-8?B?UXd6NjlIdWNqOFFvZEwxZ3RUSHpSWXRSSlV2V0cxaHJicmovWkZGYktTaXJJ?=
 =?utf-8?B?MUdkWlFMUm5WYVlBTHJzb0xpT0o4TDlXTFdHUE1EdmJsbURBVDU5MllmSDVS?=
 =?utf-8?B?UmZJMmU5dzMzWWlmeE9WajJiVFJmUlI5N2tQYTZoaml4d21kREhPekNYREpq?=
 =?utf-8?B?dC9vbW9BVXNpbmJPVFhPcisvVXNFNWpkKzNVZnQ3cTE4KythNmVIaFE4ZG8w?=
 =?utf-8?B?MTgvQXRXS3RCTjNFeHdDQ0VOQmlLWFB4aGVyN1N4ckVJM2E3T2hIVWhtdVR0?=
 =?utf-8?B?Q3RhR1lXNDYvenhZc2ozVVN5VjlCZHJ2UnI3RXBsWnA3MlF4dmt5bU11bXBM?=
 =?utf-8?B?V3BpaXozSnV3ZjhxY0JORlE3OGIxNEE5aGpBNnQ5U3lOTkhQVHJycE9FQ0Ri?=
 =?utf-8?B?dXlVaVI1Lzl0K3NRUXBCL0JIMnNTTGJYZ25UcEpvQ3pyL1BuK29pRndYRXJB?=
 =?utf-8?B?VUEyYi81ZmIxL0x1Wkk4OHhZZTE3WHRKVmN5K2EyclFEV1pGVmc4TUs5eDhp?=
 =?utf-8?B?Z1dTSTFBWXlSMEpGdVpWRlJ4RmdjcmhpSFNNUUhBdzgwbmNZU2hiRVBGa0Q2?=
 =?utf-8?B?SmQ0bFRCWkV3RG9vaDkrQzVXSHlIb2NLNHltQ3kybW56V0ZrcVpzTGhLczRR?=
 =?utf-8?B?RENwSWtYQnFEQjZTMUNWNitKdVp4TDRLbW8wSG81clRYMVk3UFFqY2E2alAy?=
 =?utf-8?B?OUVwNmR5VWVUVkRUcFJlSEdGcHBMTjhVNmhhNG81UGRNbzRaMzE5ZWZJYWhO?=
 =?utf-8?B?VkM4SDA5SzVCcnI1dndOcXFvanBlSTR4V2x5b1JnRUxDNEhYRDJuVitxSDFh?=
 =?utf-8?B?amxHYTQwMG91K2cwc2p3a21HblA2UEpmeGprdGl5S2FSSkY5SnFPbC9jTFZp?=
 =?utf-8?B?MjNlSEtiQXlTL3VFV3p2ZlczQlhTSjkyUFJPazN3Ty9jcUQ0eWkyY1J1Z0J0?=
 =?utf-8?B?R1k0NzlJbHZpWk80MzQzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHRGZ2FjMHFmWkp6UFJ1K3o5cm1QRS9wUDluY3FOZWVQRFJ4UGZZWTJjd3A3?=
 =?utf-8?B?RHFONzZrQUFSRUE2cTRkR01NSVdYNDZvenU5dmMvRkJubXhJNG1ZWE01cm9v?=
 =?utf-8?B?MmUralU2UjNmSFJ3WkllOEExK0pFWFgrVllEcmFaZ09odmRZZ2podzBKdDRR?=
 =?utf-8?B?Z0RzdDlEc09KYlgzR3d1ZFR1di9rWlBvcm1Fa3Ntc3U4QitPSmpndUZLSytH?=
 =?utf-8?B?T1pwZUJuOTdqZ3Z3SmVhWGpWMlV3ZnpLc0MvTlZQNXJtZGtyT1JpOGRxcXBo?=
 =?utf-8?B?bzhUaGFyVFRhVi9LWHllN3B4eGpld3ptWG9iVzI0OUtCaFAyQ1YydjROWEtB?=
 =?utf-8?B?dUxkRTdPclh2T1kxVUwxeTdYakhJbm5kYldSVVg0ZC9aWXpYcUN1RVovREJW?=
 =?utf-8?B?L1JLVHRBcE04bWgySElPcXZ4TXh5SXlUVVA3T3dpQ2ZRb29EeXh1UjA3RFJj?=
 =?utf-8?B?UXU4TkZIRDkxaEt1VXRDTCtIanpicTdkZjlLV1BZSGZyMUVkY2JXWFNmd0o2?=
 =?utf-8?B?NWlIOFJ1N3NtcytYUHBHWmsrY0lCSURhL0Y0cjlxdndHUjY2ci9xZ0U5dk1C?=
 =?utf-8?B?NFE0SEhaQk9vWVVVb1RrRXhtSHJTeFA5QWxZT09LU1RPYVFvVGcyRy93Y0E3?=
 =?utf-8?B?a0lIQ1JEVnE2czhLSkFnY2luUEFPUHowRzVNRE1uZFVmNVFpbms0T2FRL3VF?=
 =?utf-8?B?bjVxQlg5UDE1eUxKWjdVSXJRZS80QlkyL3BtWGx2SWt1TXBXNkxOS0l3S3Aw?=
 =?utf-8?B?cUVEYWE4ck1HR05oaGZSakxjdWlYZlJzTllPRmlZT2c1c20wRFhwRmRlYzBy?=
 =?utf-8?B?UzFOVmQ5cVY3bFFOWENiQ1VDY2YzbDhzN0xGVzBLSnpHSXhRZjB1ZjY4VGZv?=
 =?utf-8?B?VHVPb0hoZnZIVmdnWkR3YkRvdWV0NnZTbkNyem0rWGY5Y2ZFcEJRQ1NES2Vr?=
 =?utf-8?B?RFgxWlo4MkFqOVFqNjhKOEkxR1BqMG5EelpvKzBCcGhOZE5YM0UrT0ZweDRS?=
 =?utf-8?B?RDQvbEk0RzBrNC8zZHJYcnBRR2FOOVBWcUtQcjk0VDBJYkNXVDZnanUvZzlj?=
 =?utf-8?B?SzZVaUZDeUt5M3NKVEFHSmt2NStxZjZOdThIVUFmWkNDWENBV2VwNFVhaEJx?=
 =?utf-8?B?YnRma2oxZ3c0WjlBTVJDQzA5eXJJM2M1TEZRTFpzMjUwVG5TU2U4aUFScU1w?=
 =?utf-8?B?TnZQTkk1RllmRjlaZGxmR2JjWjA4MVhWMGtlWDZZcFpaaVRHVUlXb25UcWpw?=
 =?utf-8?B?alhVOFdPUFRpYkdZT0NlMW4wQkdMUy9SQ3lEOG02dUk5aTVORlZLSW5tR0xs?=
 =?utf-8?B?N0VUUkgwaDhHVUdIc21BOXRkTDJQaG43aDZUTTE1WFlENHJVMitlajY5eDc3?=
 =?utf-8?B?KzR1VjdsUHltL3RVaGppR2dCemRvbGk5cWQ0d3BibnVHVWw0bUc2NHhqVWo4?=
 =?utf-8?B?aEU3UktjdFBZTVIwazFOeTgzU2Z3NDcrUWVlSXkydnBReHk4RzNGUjA2Q3Rw?=
 =?utf-8?B?NFQ1Mmc3b2N3ZEFIbHIrbTVXaE9BMmVFdWdXN1NOb3JQWTQ1SzhBVWdVb01x?=
 =?utf-8?B?ZWM2SW5nS1RrdUFZb09WSnNsSngvRnZMVVV6UUYrU0hZb2gwTHFpSWhESXdm?=
 =?utf-8?B?TEJka1V3S2p6OSt2VXAxSWlQU1Bpa3g0clJ4dkM5Uis5ZW41cUxZdWhNY1Rj?=
 =?utf-8?B?eVBEcmZBVjRwR210dXZ3eElmWjBOU1RrSEJJRzlJMTdXWkxTVEtrRElGcHV1?=
 =?utf-8?B?Z08wakoyMGlvaStqQUI5S2oyYkRCR0lyRFFPdGJZODJPTmV1TjlPRlVPMW5h?=
 =?utf-8?B?SlBQYzBuUEg5ZC9LOFBCZ1VIbWtKWjJEMGU2b3BHbHFvdzRPNUZYRVFVUWV3?=
 =?utf-8?B?R1djbzM4RFpjMG9HZ3VNR002R05XdTNzY09wNEd6Q3BSaXQ4QXdhd1o1K1Rn?=
 =?utf-8?B?dWZtem9rWWJLdk9BbTJ5SkE3SlJKc09aZEdGcjdGYlFpc3pYWGlRNEFRRFY5?=
 =?utf-8?B?WDYvRlRYaUhsUjlpZFhkSWg0c3NpOFdiVDBtSXNpa3Z6N1NONzlXeGpvd1dN?=
 =?utf-8?B?cWluZm96emw2OWtZWjQ0d0hFbUNUWjBHbUdtUUhKc2ZpbXVEY3NUcXZSak5E?=
 =?utf-8?Q?mUyTDMmWMSNxbWLqs7mfakwN8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6e1e14-3da9-4524-f278-08dce2f1a065
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:50:58.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n24dRHriu/wBjuesMWjXukQn0onb3SG7pSsQaUUeLHRT7JEcjLTA+ecB6fGhTn9p2VCqHuit22u+O5OMuXRTiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699

When sending REQUEST_PROC_DAA, emit START and address 7E. Address
arbitration may occur at this time if other devices trigger HJ, IBI, or
CR events.

When IBIWON happen during a REQUEST_PROC_DAA, NACK the IBI request then
send a repeated start to continue current dynamic address assignment.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- use 'dynamic address assignment'
- add Miquel review tag

change from v3 to v4
- rework commit message
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index c35a228f0c2f4..5df0ec02d73ce 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -872,6 +872,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	int ret, i;
 
 	while (true) {
+		/* clean SVC_I3C_MINT_IBIWON w1c bits */
+		writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 		/* SVC_I3C_MCTRL_REQUEST_PROC_DAA have two mode, ENTER DAA or PROCESS DAA.
 		 *
 		 * ENTER DAA:
@@ -923,6 +926,9 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			ret = svc_i3c_master_readb(master, data, 2);
 			if (ret)
 				break;
+		} else if (SVC_I3C_MSTATUS_IBIWON(reg)) {
+			svc_i3c_master_handle_ibi_won(master, reg);
+			continue;
 		} else if (SVC_I3C_MSTATUS_MCTRLDONE(reg)) {
 			if (SVC_I3C_MSTATUS_STATE_IDLE(reg) &&
 			    SVC_I3C_MSTATUS_COMPLETE(reg)) {

-- 
2.34.1


