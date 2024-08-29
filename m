Return-Path: <linux-kernel+bounces-307699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504296519E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5E62866DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC61B6545;
	Thu, 29 Aug 2024 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZrEPAsl3"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8011BB6BC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966115; cv=fail; b=mfIeqAdWIi0skOwYMnslqufVCNmoN1Id7AlYmZYzmOXnznvetnV8x5YtGW1ZLkaeVRbRDdV3T7cnS3UoAUIQBn3mgo+qW4E9vBS/OFyjMzldXmSzr9CDq5rrj2tzG6uhPbnCZYL0+5IGoXBqgfu093iOEtbphep3RTEm3S4m2N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966115; c=relaxed/simple;
	bh=Abu8R9fjCyCOO6LsZNj8SF9ckbtApgfch6j5wEiJ3L0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s+i6e1Fe4RSpF+D6zJLs3g2b+BHBQlxp7IwsdfwPG77X1NN3ZfZ0lYTnAH6tORwW9Px9s9gKyYA+wc5tyzpFpIO2B6wStfy9mzUDC1ifT/7YHY3e31G7W9dulF+xhjVGy4g6P8Rx0Jrmh7L3eJI0Ib3HPvYKYOrY2l/nx6ICveg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZrEPAsl3; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YobVni+mq3poyw4AzlilK79ka+vFch4UMsAFfqnlU8WjXTE6tIDY0a1OUdnP9ORa26ZIyLMBFtRYKsM8YqFcrcIPLdP79ARB0Sfo76S09ngKKo3KdsVQlSSRq9XLyCG8Xk3UcJXUxrVH2kY0YcFUvPM8cziNU1FPwc8WE6qCvdPvwExEtfj8Qm9yuGAV7buqU17dFV4zdKg9j4xrSo789HmjEFZ9WS7bKBgWvkuwOjFLdVJWpvVJBwpoGFhVSy3QIMEbckdmzpZfwq0iXOY46xGvioxDlVdtOil+jtwZemczQ0l683ZbZHffnieSwgD3ihPS4oe5JkyaEVJ+ecjYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGcdrxq3VsDXfDuenVX/J6JpFFtyfXUUfnacJFSh40Q=;
 b=qfmWNCUgCsEQrn03ksrdnguOeUVHHLbfMhEQynSyWKrVNcLqAhmCQOmoRGWLfqZxBOiUhCLneWgBhy5e06i1SiwPs8WZZtn9spF8cH4Ag/EbwSmf/4tDsmj7e8y9ragWmrNhiBagODuY1gjMhvbXr1XutcTDkArRrcVwipj23+hsn7COgWKMdFM5L20VoTcXWAXWBC4QNBUf2R8TldMcFsYA3U/Z+4Up+PzGWYB9YXW7/f3AzPXv86dz54NKooiVkjJVE+m+BoDJ4ynsgdyqoWQuOmOwupEpIQx4cy4Z2v9qz0WmUgHRmSs78Gn2RnqM44ybTfANqPnaEvmLkmCBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGcdrxq3VsDXfDuenVX/J6JpFFtyfXUUfnacJFSh40Q=;
 b=ZrEPAsl3Wnb5VVCcyiimPy3atnJTMqZrHsLx3P6uiFa+YnSm/5TYGgA1ZYYrCZFzq0p8dB1RuEHjKFJvod1Vhl3RR1kpiqB7QRsPcbYZYKp0alyxg4vvr/J+yfmENGO/da42moc39t4s5A3wMFqfLx3mA5oWetBjGNgaMIC0Z+dJseb/xWG4mUXJAQROZBcZFKGfdxTbz6Cr5Rk+Z1srftYOl+9T+96aoBZaudDZSlufJ6K+drf0FTMD5px+yXqvyajlXpgB13j7w6cVZW8En5EMi9WGacBCSuZYCr1eqkln156oRnnePw2sZv7EZPT5m5YCTnkFVxHM6a7vAwDRkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8971.eurprd04.prod.outlook.com (2603:10a6:20b:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 21:15:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 21:15:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Aug 2024 17:14:04 -0400
Subject: [PATCH v4 07/11] i3c: master: svc: manually emit NACK/ACK for
 hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-i3c_fix-v4-7-ebcbd5efceba@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724966083; l=1870;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Abu8R9fjCyCOO6LsZNj8SF9ckbtApgfch6j5wEiJ3L0=;
 b=lNyY3IKUOLnuOh7Pz9pmkiRTkyrrKIcQYW38dRa4KN/3ICEhLIlwIyg4n6Rn+rraDgKgXEEKt
 yX5Auqk4+peAOMeBomHTz9hQvcEX1Qlh93x/U3mt3L1Nhr8loVKww9F
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c58072-0607-436e-1a65-08dcc86fa963
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VWR2MmJ5ZW55YnJYYmp6d3oxZGVzSEI2eVhpNjBYS040YloydmF4VUUzVTlh?=
 =?utf-8?B?Rkd4VUtwdHZaYjV4RnEwbHE2aTdiZGpRQ0I4N1ROMittUzFmMDB3RHZjVENq?=
 =?utf-8?B?dFN2aHdTV0VCT3VBL20vL1JCQk5McHRTcDVESVBGbXZxenJ0ancwTyttOXlw?=
 =?utf-8?B?Mmw2ZmVDdXVlZ05aclUwOStCM3lDMWgvY0pWdzhFelh4Y0hEcnRUQ1JmTmpZ?=
 =?utf-8?B?TEFxYVEwVnlOeGprZXNGbFc0VUFNd1V6bGxFMlVwNUNuSjdLU2VYUnJVdHQx?=
 =?utf-8?B?MmdnUm5ySkpvd1VoZFV2bk8yRkVtVXB1NFBnTTJWazNlMHRvUDBqQWU5SlpD?=
 =?utf-8?B?NXR5NW5UM0lsS3pVTDRsTDRmWUtLSVppVGQ1UUxsUXdDcm5jaHJ4K21lb0t3?=
 =?utf-8?B?K3dzT09wMHMzb0xNMURSdjFOZTA5OHFReHQyMEp2R2c5a1ZWQXY4U0VUa0U2?=
 =?utf-8?B?UnZKbzRrck9SVHBuVnM5ZGFSZGdQbUVySVpjZHFoMzRUSGZnSUdCeWlDUnc5?=
 =?utf-8?B?VnhqUndZNVN6OE1hUy8wQW9nU1dudEZKT2RMeUtxVmJqdmxwTlUzTDBrUm1m?=
 =?utf-8?B?VnRjUnM2OUo4K3lzRVQxbUNqK3BmN2VqN2V5c2lDMXZScG5DRjJtZTZWdXQv?=
 =?utf-8?B?TTRudnQ0TGhOZkV0RWRXTVQzTnRLS25SVHYvWEo4V0dSMXhQOWRNWXdzRzJH?=
 =?utf-8?B?L0M0dHEvNEUrS1BSekh1T2JkaThSY2hlU3R0WmdYMUVudHVGYlM0eWROWWNs?=
 =?utf-8?B?ZkZ3a0R0dlF6elZqOHBCT2tJOWtjSm0xWXFUZDNmVGtLMGZwWG1GNlBFNm9v?=
 =?utf-8?B?dHIzN1JnL2xFZFpuWDRtVEpIWTJ5dzI1dk03a0pUZllDdmRLMUJOek9Vbks1?=
 =?utf-8?B?WlVTZGJtMUFwR0IyVlFESWpaMTkxcUZTQ1pNY3N4SG9rSytwOWNUZkpmY1Y5?=
 =?utf-8?B?T1QwWXErQ1hydzJNeWJrUlNCemc3U0xDNlpacVkrVW5Zb3dBeURoQksxS3Fy?=
 =?utf-8?B?bm52L01QQjlXeVUyaEZNUDF3bE9CeVQ4bTFEM1lZNXJsVWlSOHZ6OWJpQ0p3?=
 =?utf-8?B?eHptUWNSSG1iZnBvaUp0emp4THVndmxNVGhsVGI0NDJ0UGVGSmYrMFFMbmVz?=
 =?utf-8?B?aTZhTTd3RTRxQzRoRWNRYS9sdzRYWG1RQktjcnNSN09JbElDaGo3ZUh4WS9B?=
 =?utf-8?B?RVdTNkNxa1FHM0xjK0xCV0UxTzI2cUpUQlZ3cVVRNXZHM3hqaUo0TTZQVVhl?=
 =?utf-8?B?ZXdJajF2d05IZGM5aVBLZEgxSHJmakxpcVpPYTZUNytKc1BiVzA3a2N3QlJl?=
 =?utf-8?B?cTZFdmUxWTc5bDJjb2tWaHZwT0J2WkpVR2dBL0h5T2lCV0FLVUZiNE11SkZQ?=
 =?utf-8?B?WkdaVTFWbDM4c0h4aktXb1FxYjFDMmh6aGhaUDhuZlFpZU9iekxpekJJZlFa?=
 =?utf-8?B?MmJac3VsZUhJRytxcUdKZVNUWkFsTVBHemF2ZStrSVhYTTZiSkYxbmxvdkdY?=
 =?utf-8?B?aDR6OW5scVhTNldtaTI5VmtZUUQrSGM4Q3dtVU1JbFZPVGx1SlByRVRFZlNk?=
 =?utf-8?B?cndJZjNwQWhaeXE1UVNhbXN5ZmlxSXFPYnA4QlNPL1FCN2dKWjVKcnR2ZTBt?=
 =?utf-8?B?SmVicnZMWGRKNldNQ0t1bG1qRVZTR3pySU9EK0dTaVdSeVhzTzRwOFFOM3NY?=
 =?utf-8?B?WXNHejZnb0hjSUFTUm1XaEpPazhvT1RhQzFHMkNrY2JscjVOd012dFJ4TlhC?=
 =?utf-8?B?MEVobUpDTVNYeFVvL2ZQVXlYVnJIT0hWa0s1N2c3dVFiSWxXcnRacDFtOExV?=
 =?utf-8?B?a3JYaGg3UG1iMFVMWkxVNk9EYzEyWlBJTTlGTElDeDBIRTJNdzJxYkVZWFVi?=
 =?utf-8?B?ZXcwTkhhaW1GQWRFWXVuT0RTTXZ6M004S0d6bE1rYnBnakE9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dE9TNEl2TTRYQ1JDanpEbjc5TGU5eXBHM0hsazhkZjc3T2FCQTlsZWRXODgr?=
 =?utf-8?B?bzUwNE9FVVJDZWl1NU9QbTE2OGhUdEtSb2NrNlc1bU8wQTNtNzRxOEluNk03?=
 =?utf-8?B?MENoV2owR1dqVk5OUC9kYStialk2YmpvUk9ERGJJSnVTNFhKZm5JdDZQd04r?=
 =?utf-8?B?MVBjK2VRK0FhRFZRZFV1bjRvQzFPRVJoTkM2dFFGeSt4NTlwUkdDbGdERUdV?=
 =?utf-8?B?REZmM0pidjNTK2Y0emRGbjlQL1lNTjY1d1RXOXJTM0U0SXh4UEM3MEhmdmxp?=
 =?utf-8?B?ZFhUUDVEODROZG1VQURZejlGdDQ4Q1lUV2krNkNSMjFMcXF0K25CdzZtbDRl?=
 =?utf-8?B?UUQ3QTRkb2dTYStuY0I5aHJEVlVRNTFwdk9wejFQd1NhTjQzZ0lxOVlGbkly?=
 =?utf-8?B?NzVRZ1pWK0Y0NEtvVzd0UC9pNFF1SGYxa1FxYnZoSFhjbCtRVGtJc1k3eWR3?=
 =?utf-8?B?SU5SL3RjT2pNM2NDTk8wd3BYeXp4MmVyMDdISjR4UzBVMGpZdVZmeXlIalNN?=
 =?utf-8?B?Mmd4RFBqQWpVZmVFZnR0eTZJYTBtVUxWR01oaW5ab0JtZGpSME9KWlhhUFZj?=
 =?utf-8?B?KzJNVzJEOGkzdGI0Zi9NNjRPdzdJZm55a3VUWDZhMmVhMHJhUzBCejRNWGY3?=
 =?utf-8?B?bUNOMTNwYkY0NGZxVFNjNXJKeFBSbXJFdVYrb1N1bUJhY2M0eXNwa3U1b1lV?=
 =?utf-8?B?SkZpbXgwRUJZaUxZa3JVNkVzNGtUbGMrRHZtY3BxaVZocmF2ejZMeFBBVDhV?=
 =?utf-8?B?R3FaMFpiWFVQbDZjeng5UXNSZFlqZXQ5enQ0Y0lzRElVTENWL0E1dGozQWV2?=
 =?utf-8?B?S1RScU9KSFJxSUlPU1VVUEFpdUNnT3E1RCtJTXhPaVY0U2piUjhIS2NLVXRt?=
 =?utf-8?B?UnMxOWtwUGZQZDNkRlhEdDlxTWxHVkNMYmJQT0JqN2g3b3IwekFEZmpCYUZE?=
 =?utf-8?B?N1NhUUFnenVPZzVMMkxsK2pkMnJNL1l0clZEQWV0ZVRmUldnaTNlQk96MDlV?=
 =?utf-8?B?c3VkTmdna3V3ZzdBUnlMbWxPZ1VkTW00RWhpbDRqemxXREh6dVNmWGpuMVNu?=
 =?utf-8?B?dHM3eTJHOCtvQ1EyaENPZGtNOEl3blE1WkxUQkRJbFlKRXpPUm9McnNiL29y?=
 =?utf-8?B?alJGZ0hjNGVzOGh5ZXJtOHhlU3I1LzVVVXhSNkQvQXFZenZFTmppWmpIRlgx?=
 =?utf-8?B?ZGFwTzEyRVZ4OGwxRmJqODlvdEdkbysyV202dzJFa084YmpqaWRjSTR4eU9q?=
 =?utf-8?B?WmdsdmNVclJFQkZDS2crSm9xT05GMkVMVjkxelVIZ1NRREd0S21DUG55TFAv?=
 =?utf-8?B?TGIrZWJ1ZENnSThFZjdhazdDejg0SmplV3p1VEZhdWVRKzF0d0dwWmJscXA3?=
 =?utf-8?B?STJjcXBOVzlTVG0zb2R6MGZYcG1aVnp2Nlh6UlQzSHhERmQyUjV2VFl0K0N6?=
 =?utf-8?B?SXdEcmEvVll3ZldNbTVPVExSVXBHcFpkUFkxSkZYc2M4OTNyNC9iWTY5amNx?=
 =?utf-8?B?SVdMRXV3aUhCb051RkRvdzFYVHBPZmZCQ2w2YWkxMGxtNWZYMXpEMGUvbVZD?=
 =?utf-8?B?UzJsbnZRSzR5S2dnU0tmNnNPT1N1a0pEOHBJSWlFWk9zNW1tSEU5emlwUGdl?=
 =?utf-8?B?dnZndFhRdmlMSnBLQ2JEV1BMOWNpa1pyOHlqUjlIZ1dXbm9WYlRESllWenVy?=
 =?utf-8?B?ZGxWcGcrRHZyY3lCTnBNQUlsZkF5cUNsUFdTM2NMak5Qemc5cXNRSFlxa0lD?=
 =?utf-8?B?aXlvZmdDazV0NUZTQ1BUdVlQSlo0L0hYeGFnVnN5TStiVThvMVBGcU1WZytX?=
 =?utf-8?B?OXhPY2RIamdYSW1ob2tSYjlYWXlPSDdkZlU5YTJUQVp3QnNQWjU3ZXdjV05S?=
 =?utf-8?B?V29MOXdibURoci9iTE9tZ1ZVc0pveDhwcGpnVUxPTXNpallXRHd2WmxCN1pU?=
 =?utf-8?B?UG5UTlp2bGtBRFJnNk9LYmU3M1R1eTJIRFhZajZVWmZhOUdmWFd6SWhMRkN4?=
 =?utf-8?B?S2tUZlZKMFczcWdDYlk2dldqRUlxYUY1NnBkQjlObXNWQ2RFOWNBbk8yUkRN?=
 =?utf-8?B?Nm1lblhjcFBRblN3Q2ZWeUh2Njd6anFBb3doL1I1T2E5RVZEQ3FvL0pnVFNC?=
 =?utf-8?Q?TbY1s5SA36SU6jn559o0hTw7x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c58072-0607-436e-1a65-08dcc86fa963
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 21:15:08.9330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: achJiPKrjX64lc3o/If3jodcW3eXBdJzi6lqSiNx8uSZ+tN4vcKUdrhroUx4e/70cX2Yt5oPjJFUZACiYrD0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8971

When the address is arbitrated at send address, the hardware can auto-send
NACK if it is an IBI. However, manual emission of NACK/ACK is needed for
hot join or controller request events.

Add help function svc_i3c_master_handle_ibi_won() to check event type and
send out NACK if the event is not an IBI.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- add Miquel review tag
---
 drivers/i3c/master/svc-i3c-master.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index ad999a1346686..122778b51c720 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -405,6 +405,24 @@ static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 	       master->regs + SVC_I3C_MCTRL);
 }
 
+static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
+{
+	u32 ibitype;
+
+	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
+
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
+	/* Hardware can't auto emit NACK for hot join and master request */
+	switch (ibitype) {
+	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
+	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_nack_ibi(master);
+	}
+
+	return 0;
+}
+
 static void svc_i3c_master_ibi_work(struct work_struct *work)
 {
 	struct svc_i3c_master *master = container_of(work, struct svc_i3c_master, ibi_work);
@@ -1113,7 +1131,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+			svc_i3c_master_handle_ibi_won(master, reg);
 			continue;
 		}
 

-- 
2.34.1


