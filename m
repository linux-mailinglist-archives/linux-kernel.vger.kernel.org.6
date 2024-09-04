Return-Path: <linux-kernel+bounces-315454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D003F96C2E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91AC1C25105
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CCC1E1308;
	Wed,  4 Sep 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YG8v9D4D"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48761DA608;
	Wed,  4 Sep 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464973; cv=fail; b=vBIkU5iEfHonvb6YbCcGwyMZlYv8kmMAkUyKymwj2NA+DAOCI9Nfbhc2GqOZcAgC+A21NQhnVm+0WithTmlbu+Oqci9GaFGSOsPe2OLQVm5xXKDaKmcjQT6cIWZxSr+qzoCDC0x0H+1jSdEjoaA1UFa33YLhHhtPn9JPJhJbXbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464973; c=relaxed/simple;
	bh=OPMEgo/PPVAH3sDsMsvf6tFyCZJh0Wh9SpXjFlyjVQQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BKBR8apWEMpN91acl9+IXn0/xBqJ397xTLxO1D6UXs8uqZIIQu1cuhQo/W4aSfETv4I+PtxRPSlzw0t1ppdPLdKwljbUymnXevH+5RqazFzEPcIWLgVGL5BkgpgWmpTpU5m8JEcJtBKZO0n6fRGW9iEivKcKxarYmbyEvqXApuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YG8v9D4D; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dy1RoP8N1Jjz5oTPYfLoS/KyuBt8zI+851CVNzeiIDKJNdBykj1eHmvgCa04gf3PSYwNxQ4sU+JUuvccOMkh69dQ9GBi61Lal2ZeJduIBB+wIKSL8Pa5zME7zp791F9sBgNZaF5wLJZSio41HeR6n91n4MKrCEQr1q+xSSEma7YIu5JxB1KDoh7GtyrM1OK+IXcW/xLKjpakGeMe1SYkUtWxSXr8Dx7/jR5eo33DDfvrUeH/AAfAeqRYVJEDpuhazSkuPqTW6EbSemTET6jw9U1wltghuOZCsmCg0+BRjHbQVuGoXkZLu4Az16I3xdoOc5mevT0NQ6lHAdQ1j1p7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FGgaU9IlyBHq49XF9k5+aS5ZI1cv/6PvMPvqC36+xQ=;
 b=iv4JTg7FOu/RdGihKeFakwyLWiWLsttiQ47nmgynIiH0rOdg258eNFFPrDIgV21+4rWxaCsJmAwmqnTFtEWETzBGT0kC1AsQm2gth3snXPTOBB0ZHw6rMPyEwndfRhYToDTTJFIS49+RDuZnpT9nk3TgpPox07VJx4f8WwqljBwoqBn5/PvFHsdOq9YGovNlILM17NHyOM21doFUdL4xOyc5EsQH6eNtVqZx4aTmdQ6bPitYAyrcIj0ydwV0txIILJY09/oSrWd87r7TwDzJq1sGeDxNmxDvyDgLzTebARMZzzKWcif+OHsaO4j4MexiQT8ykFOBgAbP2RsubQv8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FGgaU9IlyBHq49XF9k5+aS5ZI1cv/6PvMPvqC36+xQ=;
 b=YG8v9D4Dldd7wErik2VtBC/vv0xfI7iEWBVn72DS9jkxmr8NUaQkKaaZrmxxCExQ+EZkW7LjqY7StwZu15XaKfDSd60FUU9bjwfVxDQDjKsqlME1IBEbE+WzEeGiRaXa0xNSrLaMT3h7XRlS9/TUIqhHSDs+KlYy3DqFTTaSP2hSmUT4gw1YOf2tbSqNwOKsh4vnm+oIkKLiyahvbgHpFibsWcCftSh+FKXCoRrpbOIq8wGOXX+TVWAJD4m+blATugCZLyRIMKZJEbDpOiJgyHgTcrzmnQG8aDzX3DS4hUw5AJlAxgfGYTUvF3udtWLCprEQ4MJ3A2LmYozik/WQFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:49:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:49:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Sep 2024 11:49:02 -0400
Subject: [PATCH v3 1/3] usb: host: xhci-plat: Parse xhci-missing_cas_quirk
 and apply quirk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-dwc-mp-v3-1-319947736ec0@nxp.com>
References: <20240904-dwc-mp-v3-0-319947736ec0@nxp.com>
In-Reply-To: <20240904-dwc-mp-v3-0-319947736ec0@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725464962; l=1035;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OPMEgo/PPVAH3sDsMsvf6tFyCZJh0Wh9SpXjFlyjVQQ=;
 b=qw9gic8gN6R4qA5UgOfoKE83zy6veieKUzUqWclSB6QDNiN7WmzFitlDVNmX6wCCLYB/YRnxs
 pdwrLJMgwHYBJXqMU9UuQ8wIVTSCYE96oi9oEobiQANj4xGWkfyGBEO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc1af90-193c-428c-f120-08dcccf92913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M05qTGZReS8zNC9TcUozVno0UUsyTmUxbzM4Q2U2eGdPOXJIQW4xbWRBK21B?=
 =?utf-8?B?d0tpeTdlOWFCYk5VLzM1dzdxOHJBeWhoeFpOQkNKV3AxcGVnWS9QMG1WU1o5?=
 =?utf-8?B?Mm9NbmxlRXZFekpab2VabzJkbDZoWURnOG1sZFJYMndtQlpvZVQ5U2o0ZUxx?=
 =?utf-8?B?d1J0bnBYRlQ0TkR5dHRQUjN4Vi83am1Yb0VPRUlTcnZodWYyOHp2Q2xZeTV0?=
 =?utf-8?B?eXNwZXhiV25TWTIza0V2K1lPZWVGY1A3L1diR240VWY1ejRGN0kwOUdjV0tm?=
 =?utf-8?B?bkF6aDdObVFNSjh0c054QmZrdWNtVFNGS0ZsODN2TmZMaEJHVXNmbHhKekRN?=
 =?utf-8?B?RkFjUDFtQkgxeU5rOWU4Y2dLeDBCT0pPNmY2cXFsN2I2SFRtUk9wa2lxQ2E5?=
 =?utf-8?B?djhzTmsxUS9GQ1BENDNGMFRFK2p2NnN2VUx6MFpJTkNXbHE1NEtFdFRzRkh1?=
 =?utf-8?B?cjZkRjI5V0Q3SjdxUk80R0N5MFhoOWhvSVVFY1hKNUk0aWgvTDF4M01sbElI?=
 =?utf-8?B?K0NVeHA0Wmw0bmxjRGdTakpmMnBiS1RRcUMzOFAvd2xjTlZjM2ppTXhKc09i?=
 =?utf-8?B?OVVlakV0K1JoWnlQMG1BMVFMUis1T2NmOXpCeC8rSHhIZVFTcFV4Q1JHamdq?=
 =?utf-8?B?TElRZ0VHeTVWTzZMNDlDN0VCMTlwWHA3bEdyRXN1cGpIUFcxRHlEdWJ6VUJi?=
 =?utf-8?B?ZXRFb0hla1o1Q3gvemdCOThkajBYcjVBTzZFK0dzWE4vSXdhMnJ1YlEvVWRx?=
 =?utf-8?B?ZFFRSFBkT2tSemVSTmJiYWY4cW9uQkdrM3VHZVJOdTY4dFpxN29sRnNlNXhM?=
 =?utf-8?B?RCtETVVpVXdIcnZZRjIrdUZlQUorY1R6dlEvbVBxL0RTVWx1MEgvdEE1NjBW?=
 =?utf-8?B?Q1J6eFNJbW5KQStsMnJHcFIxZWZ5UU1TY1ZmNW9oRUo4Wm5kTm5FOHdCbk9E?=
 =?utf-8?B?L0x5Zit0c3VmYTY3eHFEVWRITHQ4NlRmU2hHZzlCdkl0bVRJM0ZkemZ3Nnd6?=
 =?utf-8?B?eXlZVmE2aWllNDRxSEhheEpWdlh5aFdDTHlHcGdtVXYvdjNZSVZCUzI4T3Ay?=
 =?utf-8?B?MWg0NVJkVDVXcDJSRC90N1phUkEwUks5dFA2YzRHZ3RmMTZjNm5tRXpWQTB3?=
 =?utf-8?B?MXZMT1VlR2xuZHF2K2ExaVNUM1VLdEFISjQ2ZnY0dkxXa1N0ZG4zUFZyb1lJ?=
 =?utf-8?B?OU1vMkxmTUhEeWwyeTNManRQbW5jaWlxM3ljMXBmdDhiRkdvQTFWdGpKZXh5?=
 =?utf-8?B?MzkwQWxvTWhrRmxDU0cxekUvWlVuK05YVExNUGgzN05uNGpHdFNpckNoRGZT?=
 =?utf-8?B?UW53TUJ6Sjc2SGxCTTRuWEwrWU5PZjRFbHNEMnlhb21OQTlVMVBDaFc0L2FE?=
 =?utf-8?B?bm83RGZFNWx0bGROMkdjUFV2bkpTVVJPMi9YU2ZHNVVVZjRxbDVIeGRhMzFu?=
 =?utf-8?B?OS9QZU15Ums4MWlrYWNFaGo2ZHdHcWxCeFNJcjlFN2s0NDE4dFpnNS9iendX?=
 =?utf-8?B?U2tyYXpvUkJjTkRnTitneUd6QUZaMGQ3NytrMlBjbnd1K2pMQ1dCSXorcjVE?=
 =?utf-8?B?cXdSVzFxb3Y5RXVnR1NQVlhOcTdSWGhTbzk4OVdYbXB6U2dvWmlPdkxMVXdq?=
 =?utf-8?B?ejFxajFsay9rWHpZNUc3bjBLK1dEUnRkZFJ2eXBIL01YdU5qZXU1TG5wVUhL?=
 =?utf-8?B?dUlRSGQxRmkvbVdsMmxhRjB2d1FFRi9kNHFicjhkS3lNa0oxTVJHYTlIelB0?=
 =?utf-8?B?bUF2MmZiOFVyeVllWGFQYXpOakVhdnB6UEx4bVdscVcwNTNJS3FCOFhiRVc1?=
 =?utf-8?B?dnZZa2E3ZGpSekN6LzY3VjJlTWJPZ2ZJWHplOGt4aU1hVGFxOWNBd0doM0pv?=
 =?utf-8?B?SG93MXVCakJTUVpFV1pkUXVtQ2ZScHFMOWZtSUpsUFVMUUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alVLUVVjdGk3anNZQXQzNktwbnhvVS9xSmRQOVQvajY1MEQvclZINUtjV2kr?=
 =?utf-8?B?VUhjY25rWStWK3RJbW5qbzZqV3lOMHN0azlqV0Rlc1gzVWpDNGpDNjVYWUtG?=
 =?utf-8?B?b1E5TkI0RCt2dWlSWVoxL3laeFlKVFZPQkUxTHV1ZklEdUtiZzNEWkVXeFIw?=
 =?utf-8?B?UGRaa2RUQjVTRFlKZUk3SmJiTk5Da0MyNTFNVHU0L1pyRkFEaTJaa3R4ZEFP?=
 =?utf-8?B?UCthY3djZ3RUWktOVmxaWkdyTTNpVjdzS1pYZ3pnZE01cEcxWEVPZ1lCQ3Ru?=
 =?utf-8?B?SHhsYjAzbjY1MStrSnR0Y1RYMGxYOFFQR295ZytQUkdrRXdXbC8rbTl6c0pG?=
 =?utf-8?B?dWdqN29MNmdsTm9kWVp6NjdsN2x2dzFhUjFyeHVUN0tGRzdDMWU3ZWdBTzVG?=
 =?utf-8?B?ZFlKZ1k5TXV1RVVkVXhEK1dDd0NTUFZiaXY4V2E4SUJPdzhxdWNsSEg1MjBR?=
 =?utf-8?B?aUx4Y01qT0hISkdQaXlNdG4vSjlreUMvY0JrRkpSVGphaHZ0a2MrWm9BR0dW?=
 =?utf-8?B?b2pBNUZqSFB1MnMwMkxiNUFLUkJCSXdYNHE5WWZYMFllcUtEU2NtbHRhZUlm?=
 =?utf-8?B?TThVWDVZazdXSnd5OU8ybzNFQjU0VTZBbGhKeHlWOXFWY2dUeStqZkVXQUE0?=
 =?utf-8?B?dTg5N3VJd1NTSEJEOXVVZ2NDZ1VxZExudHNRRVBYaTBSSnFHMHVnMWhVQXhF?=
 =?utf-8?B?K0ZVMHFidXNkUUY0K0dtVktDRGoxQ1hGb0R5a3hIK01rdGl3OUdzZ200NFZw?=
 =?utf-8?B?ZXdndnR2MStwWHdJWEJWOTE0RXZpT2dSek1CZk9hUElwN3MrU2g4N1o0SVJH?=
 =?utf-8?B?VlRTcXpXSDZRVjFQQWRjVjFya3ZRbUNmV3FibHdCYnkzTGdMN1Fnd1YzcUdV?=
 =?utf-8?B?QlZCTlFrRW9KZjdUem5MMG5lTUJ0VytaTTVLNEU4ckdFZFdsTi9kVGg4U1Bm?=
 =?utf-8?B?dnAzUk9vVVd5dWpFdWdYZENVcWVCSjRTMy8xYUZ5T25uQzZsM2JPY1U2bTZG?=
 =?utf-8?B?LzRpckY4NExteWxhaVoxUTVRYmhUaTJJSW5DWklpb0lDOS9zenQ0RlBodFBG?=
 =?utf-8?B?NFk1YjBReTJ0Y2tkUkpuUHhRVVhxTU5FRVB2M05DZ25zWWdGS3RXcFE3TnVi?=
 =?utf-8?B?ZEM5d0hoRmc4MjRZY0p5WGJIc0sxUms0U2N3bklQeXNqaW5sNGxKZWRvZlhl?=
 =?utf-8?B?L1l2N2xhc2tJbUszUU5uN2NRb2ljMk1GQ1lqUEtnQk9XdHJSenlYTTZuMi9M?=
 =?utf-8?B?elVOQUgvT3JxQjQxRXZ5RWFiRm9Uei9QalFLTlR2djBUNVJGMTkyNlpCamc4?=
 =?utf-8?B?b1dxZjluUkRGM1RmR1hqcmJ5ZUlaMk10MEZwRk9BcHFGcWI3OHJzT1hEUEhk?=
 =?utf-8?B?eDEzTkxPald6dWF2b0pYRTcwVTZpUmlkR1hYNkUrQ1NLWmpTc3hkODVCNW5s?=
 =?utf-8?B?Tkdoa1orQkxoQ0NKcE82SzJsb0owS2xScVExanNLWk0yeStEcnQ4eHVtQWo4?=
 =?utf-8?B?RG5FS2tMQkwvNnVOa3hLUm0wL3VwSVJ1WmtqTTZpN09tZEpkZ1YzYW9SMmxL?=
 =?utf-8?B?ZTVSajRiMjNJRGNKWDJTVUg5MW4vaGRFNlN0bW5Da3JYWXl3czdjUmhzQzg4?=
 =?utf-8?B?dWcvSzhxVUpxL1JVYjZRdGFNZmtYNlQvUGFkaUNKR1ZFTE5jWXZJdFZjYVFT?=
 =?utf-8?B?VWRlb3RMdHo0OVpUQkM5Tjc1dkp3aklTS0doRDNJOHdyZ0Z3ME5NTC8rUW12?=
 =?utf-8?B?d3BqWXZ3KzlaUGRGN29iZ1h0QzVXcWUyOGpCeEZKOENrRVVaNVZWaFBJL0py?=
 =?utf-8?B?b3FPQU5hZVZ1ZUFqR2JLUEttYzkvTHBaUHl3a3p2aHBXakd4MEFJWkthYi9I?=
 =?utf-8?B?OXhpVTJ6aFMzK0RhTWRUa0Faa2ZweXpOeE42R2dnNzFWSEJ0eGt2ZUR1OWp6?=
 =?utf-8?B?NXUvbXZub2c4NDFPQS9FNmhHdGx5dXN4dFZiNkdGR0xOczNSbGNWR1RERm1u?=
 =?utf-8?B?VnQzWWQ4RzFqSUFIVGpOTDA3UGhnYUduc2JVNW0rMDV5cHI4VHdoL0dPUDNj?=
 =?utf-8?B?Yk1ueUNodks2WElVc3dqNHRneFNSSnBrSjlOQks1MXc2Z0Vlc3lRL0dBNGF2?=
 =?utf-8?Q?KzHci6WjyuxuYf6tKlnu2ThiE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc1af90-193c-428c-f120-08dcccf92913
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:49:28.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylQP6n4ruqtx0NQTDBBMMxY2wmAXc7EneCeQMYEEwyIMRRuEl8YKrTg6g8dSgjM3VqLG/VEMUrWi3bzHpLb9zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859

Parse software managed property 'xhci-skip-phy-init-quirk' and
'xhci-skip-phy-init-quirk' to apply related quirk. It allows usb glue layer
driver apply these quirk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/host/xhci-plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 31bdfa52eeb25..ecaa75718e592 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -259,6 +259,12 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "write-64-hi-lo-quirk"))
 			xhci->quirks |= XHCI_WRITE_64_HI_LO;
 
+		if (device_property_read_bool(tmpdev, "xhci-missing-cas-quirk"))
+			xhci->quirks |= XHCI_MISSING_CAS;
+
+		if (device_property_read_bool(tmpdev, "xhci-skip-phy-init-quirk"))
+			xhci->quirks |= XHCI_SKIP_PHY_INIT;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}

-- 
2.34.1


