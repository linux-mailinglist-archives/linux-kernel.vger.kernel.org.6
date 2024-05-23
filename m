Return-Path: <linux-kernel+bounces-187362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB58CD0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3841F21707
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB7D13D296;
	Thu, 23 May 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ddbu7hya"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C413D29D;
	Thu, 23 May 2024 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461552; cv=fail; b=Xqo6RF0r1ztaO/R/HsTdxC9HYFIlmYJsHPOoXUyl6UNuG08r2zP5jXwuV0hPJsqjS2dJKWikSw44EAixoXQFG63KWPV9t21noxpyjDFAyI8Z6MjHiNOf5+f6EWTaAHMUTR4IPhEW0Jxj9N1I8UUb+np06/3j6Oxi55YGZde63fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461552; c=relaxed/simple;
	bh=xw1GJ+zPsLPLlnmA5m7Y1uTX6ZZIrwqdd2eGDsmDHNc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=OO8MUtTrMWPLCyddBIkYhcqaOm4PjqdwqHsBPgRbAa2zcBhIkJZ0Co3aiM2/JAxj5hPKe0V5jygv8OOBznYsZ0c9as21pFxrwTdlUaeOVlTSKMqtTf+p+m+LGXk3u0Wl8SL0XWfCPvH4m5YhJp/+VUGHwLBRvC+SO55nrOCl1P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ddbu7hya; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCvW34cZs/pSHXotpFQ7VtLYxNLvoAGsZSH4Ze9z9SF+VHhTbDbyghjfY03l8yepFQyJmzkvHynhUuppLz0WErtAlLJSQGILO+e+O0SKLBczHS6ZINiw0bqEEKAKonHINg1JLE2EgrXpnIVeWjFkfFX0xIQgz0ba3eenRQU7of2BCTnPlsteBY/vcbdYkj0Q597vrTgrF2U3MkCxK/Ubi5/1eLQ0rkJdb7Pq2yhG3fVgCqKuyzOQWu5zgqo55OabSqGdkJlr6O+KiNpEb7z44wxP3UKF+SZy6XJY62+fJ0ZkhoHnx4TixXmpid/n6dIOZoSxVaU7gnpkW4qqkol6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ROoJpttZcBa2AUWMcN8hChwhWa1Dz0FkLQswUfo/ZM=;
 b=azk5TZlG1xiUASgrsBQxjOvskQO1T8CFCTe7+t4lxxoOy48ZC9UHX6F1tJevNlRPZ36NJuHTbpIc0tOEXhM1ZK5Dd9KpK0RkEBRLCDNy4aH+8DKWCZzQ5rmlbyH2FDC6i6DA04k2WqKNfovZM7O5eXcy6K7kMxNJzJkPdG238tp8UUFVBcfWb4Bo97x7Voo/fQNGNjMlK3NBnMzMfy6R+xwANAolCs9i4CUOaRHC3DbQMV+aZ8yGIXpu8psHMOKnGWmaUMhwlWoj/QVD6SfTQit87ErLob5L0CUXd00+ZUIZEmYN0RsojLJ3adfxANZKeNiV+BYME4MWqYnWkQRN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ROoJpttZcBa2AUWMcN8hChwhWa1Dz0FkLQswUfo/ZM=;
 b=Ddbu7hyabDKrDO/ccrxF7SUtrGu7j5gJ/In0qKgwrzii7nkUxtayt++eHtzrD+Y92q4V1bNCa3D+B/gyGLASi+DKPZsIpGzDfIHFC+xnTBFskU6f4tC8p06+sejn7XTCttFa3FsX673ybpVabbFUuDtYKGQJWPsYpfLjW3VqZyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Thu, 23 May
 2024 10:52:25 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 10:52:25 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v2 0/5] Communication Interface to NXP secure-enclave HW IP
 like Edgelock Enclave
Date: Thu, 23 May 2024 16:19:31 +0530
Message-Id: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADsfT2YC/03MQQrDIBCF4auEWdcyWjWkq96jZCFqmlkkBg1iC
 d69NnTR5f94fAckH8knuHcHRJ8pUVhbiEsHdjbryzNyrUGgkKiwZ7QUlto6MSMRlcLh5qyG9t+
 in6ic1nNsPVPaQ3yfdObf9adw/FMyZ8hEb5XRvRy4do+1bFcbFhhrrR8i732PoAAAAA==
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Pankaj Gupta <pankaj.gupta@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716461396; l=6763;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=xw1GJ+zPsLPLlnmA5m7Y1uTX6ZZIrwqdd2eGDsmDHNc=;
 b=lBDvDCL2nAD4H8VQbCKqz8eA11Lfgv5yHjhZKFFCj2ElRi7cLtG1bYM28V0O74DllqLmEm14T
 efiAkVDyZSnBHUeljNfwwgDlTRcrHmkvMJVcPWeGKL/Z7ZoIh5cGYLA
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|PAXPR04MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: 77380095-8989-4b8a-d218-08dc7b166e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|7416005|1800799015|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXZHc21hZkRrUGNRQjlpTHFxcXZyQkRGai94MnJwZm5NZGJFSlJrMXhzTDRQ?=
 =?utf-8?B?eGxXWDhnTzZHSnc1Y3EyaDhPc0tNZXNKYkFtVEVNRFgzYzdCV1BoSVVFSFVy?=
 =?utf-8?B?OUtOR1pOcy9HeWczM1NSdnNjQzZYMlBqc0RGN0JGcnBnNGFZcHltcld6c1hX?=
 =?utf-8?B?cEpFL1pERWJBL01SdDR1U2l1YlIxUUpqNytxOERJLzJxbzlEclp2ME9uL2dO?=
 =?utf-8?B?UlVJU2cvdzA2aGRlLzZoVGhNMitZTHNUbHlpZlhwN2h0cnpNYjhzWVhvVlRq?=
 =?utf-8?B?aFNUK3V0YWdKMWVXZURkenVxRnk1YTZ3b01qall2TS83OXJ4RXU0bFBJdTZ5?=
 =?utf-8?B?YkdKbHVhZ2FWMHE0VXBRZFhYdHh6bTRWeUw4WlduWk9kMFBURDJCWWRqNWkz?=
 =?utf-8?B?dmhKK1EvellaOUVWL2dpWDJqMDN4QTVpcjJXNXptQkxNTlFVclgwOHcwWnVK?=
 =?utf-8?B?Vm4wZk9kY1hTNlJPSGt6QU96U3poaVlGZ25MQ0NrcGU2cWRHeFkvTWpKQVYv?=
 =?utf-8?B?L2dHeEVJWWJ4UTNucm5leWZMR04veUFIVFRwRDE3UHFWd1AwZFpXRXNaTC9w?=
 =?utf-8?B?bVhWcUZQb2FVNTRWaGpiT0NMYkYydjNIeEJKT3ZtWVZVbXZkY1lJR3Q3bjJS?=
 =?utf-8?B?ZjBuNTlCZy8yRno3K3JsRitoUXA0MjhIUXpzbHo4MVFFSTJ6bkhMeFpXUkpI?=
 =?utf-8?B?dlVmN1c1bmQzaG1vSWw1RDd1eWtST0crVnNBUDNpSXZjeTE5WHNTVmJPaW5a?=
 =?utf-8?B?QWY2U1JtYitDY0piQTBQNGhoYUNqQjY2Qjh4S3Zoa0F5Z3c2UkhtUnBNWWhy?=
 =?utf-8?B?TlRKcFhHSXEyS0dqdU1sUjJoSndSYUFpTzl4Sk9IeGNqaUNPZlpxNWY5NEw3?=
 =?utf-8?B?T2VQTGN0dDY4b2VZTG5UUmtld0xtOUZldkpnVDFjYmkwdE5NUVFkaVVvb2JQ?=
 =?utf-8?B?N1UvWUszUDlOUGUrQlYwcEhVQXZPaEFOdFlVeDZLZzZYZXFLYzFQdnhJQjBK?=
 =?utf-8?B?aVpEVHZrblE1dWx2ZENEMVFYSklCSWJZUnhiRVBTK1BSMjhsTGozZVRVVDF6?=
 =?utf-8?B?Y1ZYSE9JSGpDQklpcnVFK09NZnplNEhDcHFUVXdld2xKbXlKa1crQW04Wmhk?=
 =?utf-8?B?QTZmK3k0OXJlTTVoQlYwWkloVktsbjhhblFhRVNDODhQb2RLOFZURU5QZk1U?=
 =?utf-8?B?dnFjUVRiSXlNRVV3UmEzSlNVTW92ZGVpelVmQ0lIU0QxOHJCRE4zb3VwRGp6?=
 =?utf-8?B?aWZqMGlaWHpaOXIrSm1iQlBsTmhleENVaC9GQlBGNUwzczFYSTFUQlJONXJG?=
 =?utf-8?B?N2VUZGp3SjVKVG1RWnFWVFo5WExQNHMvL3dZcEROTG5pUklYdmR4ZSs3QXo3?=
 =?utf-8?B?dzBaQTY3ZTN0RitkTHNJT01ETENUbUgvUTVEdUhoLzk3Q2xBanJhazZETExG?=
 =?utf-8?B?UlRsemVPWEtTK1lQRjhjamMzN254bDVod3RZYkJJdUg1eWRzbU9teWY2YzFM?=
 =?utf-8?B?WEp2UzlLMnA1KzNsRHNCTlptMnZ6dnJWYitvVFRHdTU1OTdVdDVKeVg0dEht?=
 =?utf-8?B?L0lBenU5QVNua3A2aWtTWjYrYUZhOHZLRUtldXU4Zm4vekl5ZUVPbkNEenNU?=
 =?utf-8?B?RkVEcWx6ZXdNbFZieU9yc0w2SDNGelRoNXpId2wvYmY1VDljTTJzRElMaTU0?=
 =?utf-8?B?N1N6cU9nM3o1ZzExRThCTlRVTUo5NVdYcFd2aXY2WEVKM3BncHRGdGtmcXkv?=
 =?utf-8?Q?pieHmoa8cBzQjY3QRw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHE2MmpZaElxUGJMU3FqTk1DVnBieGtIeUNJckJzeHpyclo0NWlVZ0VxT2lP?=
 =?utf-8?B?SUZxTG9LVCtST1kwVWVXb1RTUjV4YktMLzlGakI5cW81L1lHa0MxLzJkampF?=
 =?utf-8?B?ZGl5RHdrUTRjWHhjZEdoSzY2TE82aFRLaHpFU3FkZkhuWllrZjZFNlFjL3U1?=
 =?utf-8?B?OUJhaWJwM3RhQTY0RU5QS3IxNmtCZXRsbUpOU0Y0OFR5ZllXRlQxejl6amFt?=
 =?utf-8?B?TWUyMkdvWW9haVRBdm5PK3h2M0UzdjJMNWVTSWVXc1NRRWVKeTlLOVdUTndV?=
 =?utf-8?B?VnNhbHpDU3dGbjNVK1ZXU0RwNEJ3RURaUEk3VEJVOHVncVFmb0R6eFZRNWF5?=
 =?utf-8?B?QitaQXVpWUhSQXNNNXQwRnRUOVB1TkcxK0hlTmRYekpFQVU4UVFPR051SFlp?=
 =?utf-8?B?Z0o5NW1YQlp0VE9mRVZ5aXpiWHNWdFBsaDFNcStjNlVVV0xhUzJRUVZNQWRv?=
 =?utf-8?B?elhJeHJraE1jaUtrZjRRYThQc3hqWUdFTCtFUTdGSGZIZjdYL2U1UjZoVXQz?=
 =?utf-8?B?NTYydWh1UnpqcklIRlFDbGpRbTNDV0JiUUd2alNJMERUU2lZZDc4OXRNbUVj?=
 =?utf-8?B?TVowQlJQUzJSNlhpR1hES1gvTHNvd2FIUlRLa2JKYzhwNWgzM0FMZlh6UElx?=
 =?utf-8?B?QTcvNm9XRjI3NmFSNlR5NHFwYndIOUk0cUNvV3g1Zm1DLy9tYzRpZGZyYXA3?=
 =?utf-8?B?cHN3djFvL3dsNDUyN2NlbXdtTDJwVW00WS96SktpUXI4cERSY1hPcmxJbFE0?=
 =?utf-8?B?ZUNGbHMvRW51SE5ScHBPbEx3OXYyNEExclpEdHFqK3ZmcFF0Y2hUaUt4MnZV?=
 =?utf-8?B?eW8yRVFtUmx2UzhzMW1tNDNmNGdub3hFSEUxV0NoVWMzOXBMaHpiUk1ieW8w?=
 =?utf-8?B?SlpyZU5XTkRBRW9CMlFHLy84V2VvTUh4cGRGOTR2bldQUUtoWHk1VCtVQkhU?=
 =?utf-8?B?YzlVNjZLR25JR2wyTTljZVVycE5nbjBITjNFeG1kclJuWnZuNHloKzBqSXJO?=
 =?utf-8?B?MFJxd1REbzRnNG1YdDAwZEIyMTFET0E2d0E1Wnl5bXQ4Unc1ZlF3YjEzeXM1?=
 =?utf-8?B?T29ZVU50M2l0WXY1Qjlsbkp2WnBsblJzWm1xNmNOc0ZQVCt6N2hjY0tPTmpp?=
 =?utf-8?B?ajhqRGZzdUJIUnNoS3lZYkluTkg1ZW0vTlZmUGovMWoxS2VnalVyZGJnU29Z?=
 =?utf-8?B?RWErQVRYU1I3d081bThRR0V4T3hIQ2xHUEQxTk5xaGxLbnl0ME9pVW0vQzJn?=
 =?utf-8?B?cFdJK3ZocGV3cXpTK0JZTHpncFcyMHQzekNGTzI4Ymd3UTY4cVdaY1FKNDMw?=
 =?utf-8?B?Wm1IMktCaWtaT25HbndQMUk1WUoreWhVOGlteGlZUk1YZnovT21vRVA4OTZ5?=
 =?utf-8?B?RXdqbjhSZ21USHNqSHF2TWxBTW5PNk1jVkR6Y1hCQXZDYWQ3eHIrUE9oL1Ru?=
 =?utf-8?B?dFBiVDdWSUZRNW5RTHBBRTBMMlVTWk1WTEYzNnc5R3BxNXVEcHZIeHF5U0dp?=
 =?utf-8?B?SDBMUVlmMVE0K3ZNZGRBSWRFZ3ozMERTVE1nVHJQS3FqMHFtV1hQa3hoSmFP?=
 =?utf-8?B?Z0RwdGNOdzRHekxnSlhqWkRVNisrQ2t3Tm5pZHNhQW5MTlZXSWRtNlBKWXhX?=
 =?utf-8?B?a0Ura0NmQ1A5NGdMQmtVM2VwQkF5bGxHNHFiS09FL0JQaWFrQjljY0tWM2dB?=
 =?utf-8?B?WWY3WmtOV0FMNzkyVk1iWjdnRG1zRHBpdkNYU3dRYVQ2cHVxYWVYSDJNT0VU?=
 =?utf-8?B?NnNpYlUzdEV4a04rbWF4MENtRUsvd0hSdkdMZEUrOEdVT3ZNbDZ3cGRjV0JY?=
 =?utf-8?B?aGQwQUlXUlFpMFZoUjVGeEVqbEczT09HV2dkOEsvVkVESm9makhjcGlnaDlK?=
 =?utf-8?B?ejBKYjFWeGpuWk1Wa1k2TXJhTVR4ellFOUtYa0YyNDhKYk45K0hycmZaaCti?=
 =?utf-8?B?L04wTm1hS2xxRzQ2YWtaNmh2UThkZUpTOUZGOHZoM1VMdTVhQnNaQWZ2ZXND?=
 =?utf-8?B?bytJTmdCck9OQ2phY0JPWUVtbm1rV1N3dUdXa2p2Nk5EckJjYXZqQUVJUmpj?=
 =?utf-8?B?QTdveVBYQVl5SGlHc0FyQ20yaWRhMVZVVjc3em9qOWh0UFFvdm9WYS9Ebndk?=
 =?utf-8?Q?OuH2RctqDfWdKSDRZ+y4M7Mr3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77380095-8989-4b8a-d218-08dc7b166e4c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:52:25.2063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOaKRTl52q+dU7kbCG0xTpMFRwkup3b1g/lMDul35hbtHmPb/ifBLm3W3CMgAMXDTSHetGiTXZAcsX7JUfZw8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9571

Hardware interface of the NXP Secure Enclave  HW IP(s) like EdgeLock Enclave,
V2X, SHE etc, is based on the Messaging Unit module that enables processing
elements like ARMv8 core, RISC V core, within the SoC to communicate and
coordinate by passing messages (e.g., data, status and control) through 
these interfaces.

The NXP i.MX secure enclaves hardware interface kernel driver, is specifically
targeted for use between application core and NXP secure-enclave(s) HW. It allows
to send/receive messages to/from the secure-enclave.

Patch-set adds the kernel driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave,
both from:
- User-Space Applications via character driver.
- Kernel-space, used by kernel management layers like DM-Crypt.

To: Jonathan Corbet <corbet@lwn.net>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Changes in v2:

4/4
- Split this patch into two: 1. base driver & 2. Miscdev
- Initialize the return variable "err" as 0, before calling 'return err', in the file ele_common.c
- Fix the usage of un-iniitialized pointer variable, by initializing them with NULL, in ele_base_msg.c.
- Fix initializing the ret variable, to return the correct error code in case of issue.
- replaced dmam_alloc_coherent with dma_alloc_coherent.
- Replace the use of ELE_GET_INFO_READ_SZ, with sizeof(soc_info).
- Replaced -1 with -EPERM
- Removed the safety check on func-input param, in ele_get_info().
- fix the assigning data[1] with lower 32 address, rather than zero, for ele_fw_authenticate API.
- Correctly initializing the function's return error code, for file  ele_base_msg.c.
- replaced 'return' with 'goto'.
- Use length in bytes.
- Corrected the structure se_msg_hdr.
- Moved setting of rx_msg  to priv, into the function imx_ele_msg_send_rcv
- Will add lockdep_assert_held, to receive path, in v2.
- corrected the spacing at "ret  = validate_rsp_hdr"
- FIELD_GET() used for RES_STATUS
- Re-write the structure soc_info, matching the information provided in response to this api.
- The "|" goes to the end of the previous line. 
- Moved the locking and unlocking of the command lock to the caller of the function.
- removed the safety check for device private data.
- Structure memory reference, used to read message header.
- In the interrupt call back function, remove assigning waiting_rsp_dev to NULL, in case of response message rcv from FW.
- do while removed.
- replaced BIT(1) for RESERVED_DMA_POOL, to BIT(0)
- The backslash is removed while assigning the file name with absolute path to structure variable.fw_name_in_rfs =.
- Update the 'if' condition by removing "idx < 0".
- mbox_request_channel_byname() uses a "char" for the name not a u8. Corrected.
- devm managed resources, are not cleaned now, in function se_probe_if_cleanup
- Used dev_err_probe().
- Used %pe to print error string.
- remove "__maybe_unused" for "struct platform_device *enum_plat_dev __maybe_unused;"
- used FIELD_GET(), for  RES_STATUS. Removed the use of MSG_TAG, MSG_COMMAND, MSG_SIZE, MSG_VER.
- Depricated the used of member of struct se_if_priv, bool no_dev_ctx_used;
- Moved the text explaing the synchronization logic via mutexes, from patch 1/4 to se_ctrl.h.
- removed the type casting of info_list = (struct imx_se_node_info_list *) device_get_match_data(dev->parent);
- Used static variable priv->soc_rev in the se_ctrl.c, replaced the following condition: if (info_list->soc_rev) to if (priv->soc_rev) for checking if this flow is already executed or not.
- imx_fetch_soc_info will return failure if the get_info function fails.
- Removed devm_free from imx_fetch_soc_info too.

3/3
- Made changes to move all the properties to parent node, without any child node.

2/4
- Use Hex pattern string.
- Move the properties to parent node, with no child node.
- Add i.MX95-ele to compatible nodes to fix the warning "/example-2/v2x: failed to match any schema with compatible: ['fsl,imx95-v2x']"

1/1
- Corrected the spelling from creats to creates.
- drop the braces around the plural 's' for interfaces
- written se in upper case SE.
- Replace "multiple message(s)" with messages.
- Removed too much details about locks.

Testing
- make CHECK_DTBS=y freescale/imx8ulp-evk.dtb;
- make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-se.yaml
- make C=1 CHECK=scripts/coccicheck drivers/firmware/imx/*.* W=1 > r.txt
- ./scripts/checkpatch.pl --git <>..HEAD
- Tested the Image and .dtb, on the i.MX8ULP.

Reference
- Link to v1: https://lore.kernel.org/r/20240510-imx-se-if-v1-0-27c5a674916d@nxp.com

---
Pankaj Gupta (5):
      Documentation/firmware: add imx/se to other_interfaces
      dt-bindings: arm: fsl: add imx-se-fw binding doc
      arm64: dts: imx8ulp-evk: add nxp secure enclave firmware
      firmware: imx: add driver for NXP EdgeLock Enclave
      firmware: imx: adds miscdev

 Documentation/ABI/testing/se-cdev                  |   42 +
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   |  154 +++
 .../driver-api/firmware/other_interfaces.rst       |  119 ++
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts      |   17 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |   14 +-
 drivers/firmware/imx/Kconfig                       |   12 +
 drivers/firmware/imx/Makefile                      |    2 +
 drivers/firmware/imx/ele_base_msg.c                |  286 +++++
 drivers/firmware/imx/ele_base_msg.h                |   92 ++
 drivers/firmware/imx/ele_common.c                  |  343 ++++++
 drivers/firmware/imx/ele_common.h                  |   46 +
 drivers/firmware/imx/se_ctrl.c                     | 1220 ++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h                     |  145 +++
 include/linux/firmware/imx/se_api.h                |   14 +
 include/uapi/linux/se_ioctl.h                      |   88 ++
 15 files changed, 2591 insertions(+), 3 deletions(-)
---
base-commit: b63ff26648537a5600cf79bd62f916792c53e015
change-id: 20240507-imx-se-if-a40055093dc6

Best regards,
-- 
Pankaj Gupta <pankaj.gupta@nxp.com>


