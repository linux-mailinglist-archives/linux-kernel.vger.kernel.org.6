Return-Path: <linux-kernel+bounces-215114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91478908E49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4342823D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A16A19EED3;
	Fri, 14 Jun 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AOywZidH"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6006719E7D3;
	Fri, 14 Jun 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377626; cv=fail; b=s/7NuM3G4PCDNJKlHjdVHf/WMIakeLpZPrbou/0y4oazgkYCivTU0d3c3YEcEXKq0VnxMo6eMXGRfvgf/dxCGnsQXEoeMEHRinJHWFhQeFpPQBCFMU/4cG1YD3z5vdchnJRicGG7LkBiFjjNdicAr2RC+eSuAKUX9nmSPTHIVFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377626; c=relaxed/simple;
	bh=GyyQFBwQxEU9iU2kiD5JCDDv7dPwtt10eTEDTb0pmFw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Nkm3r/h/IatTs+BZwoXCwKt1zJIC6AG+lbyBeuEWe2oDTFUTkHr8pwk8ZZc5XUTOULcvx8dujsWX2hG50Ta2U2Ds/aLgXKfaSQJxoSOMFvghGmQKedKMGgoBLHxj6W1U3N3mI5UK3aAWAiGdO5xQPoC0ggGDYGRVIWyTJKj/Yfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AOywZidH; arc=fail smtp.client-ip=40.107.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbwfFLUpjLMtXgBDaPbql/2tXnIAuwHLdcLel/cXcMPieiAU8HtJ2ZSRwYs+cz3DLQjV+GtxqSGB4CXTLVhCWUGGMTzqfEhm4LFLhYKm5Fd/YlXDyE1ammI01rtizvyAXFM1WFyNFQ8xxhfNojl+vpOCT0q3PxsRunHlCC1LJbCRoMfGU5rRLcQp6SBzt5viaUwn32Oz23moiT1n72uL/rRV5qGXYBKQbOKxCIP6LkyzkaLX8WaikL073jU8bN8JrJ2H/TkOGOcnVzc0OQC0K3YCrkWHQ+U2Q0xW4nnOSU5JGIvJdYfwL4nWwGCaOmZwG02Lg/xG7urKPi50g9mpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8QyXFldvojdWrKZneAZxjwtFdGbAS4u4yutJCttA14=;
 b=Jl4/DKf8FX1mBYrqU/a5SHwRA0wz+jbehdbuz0ADupaicKCpRlydfSJHtWcPIQpOyIefYfn6p5KeuIhlKmq615eVoGdK12DGPEII3TYEWhQ140Ai1CLq1lVsLTz3YH1745puwiZKT3Ev+ueY5/xnYMmc/scSpQC4vYL3OeBIjbhvZOy4zzCfWiGdOk2zwBl/gcVsbawQL7afWGn/4f8IdfRAvs8qYzV09BlFge6peF702qQkc8CzbahKIUR5C9me6tLZocJZXvpZQORdtU3EL0e1nGG3Eduu+cCHYU5FxXXzAEm3H5UbN0bKjgqSScQ/HoHVW6LaQeMbCITa9TJvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8QyXFldvojdWrKZneAZxjwtFdGbAS4u4yutJCttA14=;
 b=AOywZidHvJkZ7fOg833CSP4bzcJUWrBIRrGMG7uSXe15Y0FzsFE+HWAuNfqShyBmbgj7LTL5mCh7EisrJpJ/7+0j3AakYdK6A5lT7PD5fh0tufZhQK1mSdVIUDwqULhSxE5yUMKO2XzdolpHF3EZ7msAdHzFg1cAesCLZHOHnwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8215.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 15:07:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 15:07:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 14 Jun 2024 11:06:28 -0400
Subject: [PATCH v3 4/9] arm64: dts: imx8qm: add mipi subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-imx8qm-dts-usb-v3-4-8ecc30678e1c@nxp.com>
References: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
In-Reply-To: <20240614-imx8qm-dts-usb-v3-0-8ecc30678e1c@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718377604; l=2369;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GyyQFBwQxEU9iU2kiD5JCDDv7dPwtt10eTEDTb0pmFw=;
 b=DtvR8GUHILjCrK3sMvfs+102qf0ASw2z0IYnvIme4i/9VdlzrdhOb/DhXTo/36aABFXzKB0Uh
 ow+LwLtcBZiAhpcDYlOfh4HHt7thDPqINYUdWiSgicblFD91L08604R
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ac3b22-acba-41e0-8be0-08dc8c83a4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|7416011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGRXVjJUeTZRajhPeUJYWEFQVk1OVWpybXZ6SnBtYXNFSGN2UDdtSHIvSGZq?=
 =?utf-8?B?cVpZWHFVRkZUNVd1azE0UGFpL0xoY0RMM0hXbHdXaVpkOElFVTNTV01GVjhr?=
 =?utf-8?B?eG9vMitacS9nQjVPWWNOcnJSSTg2Mm9wNmt2SlFtU1o0VWV1RndubjNmcGkw?=
 =?utf-8?B?dFI2cnhRMmpQdlU0MzJINndmZ0xsV3llbW1FOGI4TWY3UnNDaFdXWGVwM1Fk?=
 =?utf-8?B?dEtjbEtZSkN2QytQRHppTVBFaDJrclYremFpcEdzd2dRZ2xPaUFvZGpnd3lL?=
 =?utf-8?B?emdoL2VZNzBYSjFYZkRVWnZ3N3N5QUNFQmpnSmMzMzRLVUE0ZnBDVGg3SDY2?=
 =?utf-8?B?cFJrbGErbUhLZ2QwUmI1UzFXTHoxR3NTbVRVcVNVRjFTYkM1ZGdpZldkU1Mw?=
 =?utf-8?B?QzY0Ny9BN3o3TWxnYzRKZ3JlYTZGYkpoWDlWOUNmNFQxaTd6V0psTDJLUHlY?=
 =?utf-8?B?OEV0dDh3OEpyb2FISGUweXFtZlVYb1dnWUpBbnloWTdzcUliM0pka0lJOWRN?=
 =?utf-8?B?b2FjaDNnZlhtcTYvUjV3WEVnS3ZaaVB0VEhlSjdTVitmeloxLzErd1UxbWhQ?=
 =?utf-8?B?MUlOVmFVRmxtZlM3MjdFZkovdkFmQTVONGlnZzMzYzFLbVZqWnplZHZKVFlS?=
 =?utf-8?B?UEZoYUJEcnJxVFJUdkE3L0daSDVCbmozbVdweFR2TkZ1bGd4b1M0b3EraG9N?=
 =?utf-8?B?Ump5SUpkSHp1N0xOd1o4eG5jdDZ0UURPc29oQzZhNGp1S1hsK0o0eUI5U1lO?=
 =?utf-8?B?Ti9UZ2R4bDRHQklMaklYcFoyT3BFZWgraTNKKzZzREZzQUxKZGtQS3ZKNFl5?=
 =?utf-8?B?bjBrMC80NlkzeGNaRXhZNGlvYmZUSzd4RUNwWkhTemZoenFGNE1jY29TRzAv?=
 =?utf-8?B?Z3pHLzgyd1hvZWZsM1dKbll3MjFDdnNFSUY0Y2pNcmtvdHJLNWVjT1Zwemcv?=
 =?utf-8?B?czk0MWZjK3dIYWViWEJSNXRicXVxdktKbzFRRzNiRWFMQlE5Sk9ERVJ3Mm95?=
 =?utf-8?B?dGJLbCtaaGFFdnp4VWN3cDA5Kzh6WXJxMHpYanBMSVRLM1ZBQ0lQWUJKWFdS?=
 =?utf-8?B?bDQ4RW55TiswTmFyaGNMVktCQ3R4TkJ5ektkZFFZQ1BwbmY0aUl4elozZlk4?=
 =?utf-8?B?TjlYazZwRWpkNSt3WjNBZVF1U1czbWtldnFUMzR0UmgxczQzYndpSVZEQ25y?=
 =?utf-8?B?OWovRDlIemEyWFJhNGwxTEVmQVR3QWpqTVUxNGtlUmlsU2RSRDg2UU5sVmVt?=
 =?utf-8?B?OTdtRk4vK0VPWFNlam9vRloyclVsSHRxZHpLOWN0amtvWDJ4R0dxd3ovTHVy?=
 =?utf-8?B?QnN0UTFHcDlKT2dxdnROaFZqYnA2aWpMczhGamh3NTVqdWRWWkZjaDRXcW9S?=
 =?utf-8?B?ZGZmdkdWbm81NDEyZEwwTHlSY2lBbXBpbUpvRjhtZFM3a1RIR2NnV0NkSUhn?=
 =?utf-8?B?MGtHQUNta3FobmljdXFFcUpvVFFqVGtjRFdNbGgwZ1p3eUxIaWc3ZlpibytI?=
 =?utf-8?B?UHo4bnhwRnJrYU9yR3NOUGZKcWRJb0djbWV2cHY3ZEtPWDJ0S2w3NlNWM3p5?=
 =?utf-8?B?ZW1wY0w3RkRRd09sbVA0Q2ZaenFVUW1aK3IrY0hDVjBVS1EvdFRCNDg4a2hm?=
 =?utf-8?B?QlljekU2N1FGSXRvTHVSc3Z1Um9aSTZpV3J2eWF1T1E3Z3N5QlhocUZlZ01N?=
 =?utf-8?B?d2dFQzh6SENiNC82LzBuN3RvOUdpQnRDL0VWZXhYL1g0blZGV1FHTm1IZmFD?=
 =?utf-8?B?cFdSdUswS2VnRVNTVzlCcmJ0VG80VUwrajhMZTVwSGVVOVZUYWFiYnlYcUtq?=
 =?utf-8?Q?Zvy7BAzhvmU/JYvcAFAC6/80Vaq8AxYhKntLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWV3Z29vdHpxK1dtaGJkcEhsNjUwOUlnbnVjMFd5RkkvTkxRU0tqK2FTM1hK?=
 =?utf-8?B?Ri9CWHRydmE3K3llMmhiNld2TTlJVlArU1d0dW5QbWkzY2t0S3IySGJlOHBH?=
 =?utf-8?B?djFoendEWHBZSnBOQkZ0RlJRZHd3MXMrWWo5ekJGQ1hTRWwxUzBPVUp5S0JH?=
 =?utf-8?B?WnovanpyWFJSZ2lwdDRQMlJGMEQrclNCVWx6dit0aWkzb0xwd2JOcGJUS245?=
 =?utf-8?B?RTBteXlES2pHWlJjRzMzVW8wV2t6YUVVNnNRbFJEbmtQaTltbnZQR1R4dDBx?=
 =?utf-8?B?cFBNU2xZc3AzTmVZenduWkNVUXFYL0JoODB0eTZwSmYrTXVRWS9qUWtaVUta?=
 =?utf-8?B?eXRPZ2NOdDQ5SXFIMTlKY0Z3ZHQyc01ydVhCdGk3TmdCeWRiYndBV1NWV2p4?=
 =?utf-8?B?cmQ3R2JhUnlQU2ZUbHdyTmg4a2Y3ck9MZGNxNnNmYmU3VWltVWxJRnRhQnFF?=
 =?utf-8?B?SzR2UnhVaGVnZjZSTm9oZkJaOWpQSTY5bXFEaXVaUTFySU1sM3ZNTmhmdVk5?=
 =?utf-8?B?REhmTXdqYkdqQ3Z4UzNhbEYxQnlJWXFYVStrNHFGL1dBblpiTUtQNUZ2YzFU?=
 =?utf-8?B?VmFRNnNZUjFjMzRCaXIwMnAwWHpNMGJvWndWUDZuaXhCUGJUR2RCR0FlK1Fw?=
 =?utf-8?B?N2Y0VGx1cGtsVEVRTFk4d3IvVEI1R21qM0F4cHhjVEwveEJnS2hRNmQvRU9B?=
 =?utf-8?B?V2RqUTdSaHphZmk3TDl4NjJaeTVoMldkUEI0MHlsdzhkZU1qd2VaMDFPejBT?=
 =?utf-8?B?Tnc0N0RxL0todFIveUNCMk9tcmxIZ0RxNWJHM280ZEs0aUcxcFdMSG5WMGlH?=
 =?utf-8?B?bmJYQjdOVlVmTHV4SllBbm0vVmFHVytVU2RiTmJMZDNqd29FWjlUd1dzQW8x?=
 =?utf-8?B?K1lyMzE1TWt0YVVTeDZJREM4THhaUmJSaVFmUkRaSjBjWnNrelFPaDNTc2ky?=
 =?utf-8?B?MStoR0JBaG9NTXRHd2E5UVR2VjZEejUweHNyb1dLRFlOcXkyZkMyTFVIVHpw?=
 =?utf-8?B?Tm94YXAxSzBlYS94RU9Lb0I3aTY0NmZSZXdsalhKc0pZQWtFTUdSVDAvMERy?=
 =?utf-8?B?cmtwcUFPQ2lPNFFUbVBSR2Ftc3NRNjErSmNrTElDeXgrR2NJVCtRQUR3T0pX?=
 =?utf-8?B?a1hDVk1rd0lub3JXTVA2QWJzVjg5RXpZRFlpVHdsVGg1UnYxVS83bTdQL294?=
 =?utf-8?B?aEY1SWxWMkY3R3M0S2QvUVh0YlBmdE4yazVWbzVsS3kzbHlvcFFneDVGa1k3?=
 =?utf-8?B?K1lIRk9WMEJUOGtybkVZc2Q4QnVRWUU2ZERyNGpFU25zT0NCczgzTWdMWmhl?=
 =?utf-8?B?RThFR3E1dFNhbEpQSkZndDU0d1YrYzJCS29HREtCT1RQekhyRUdjeDkxYnFB?=
 =?utf-8?B?b3Vqd0JlbHFrRlFSTmZxT2VrbHhEYi95bDhoT0JER0paemVLUFdhNEtGdjhW?=
 =?utf-8?B?dmVOQ3JDNWcwS1QzOGNBcU1LOXU2Z1Z6eDJLdm5VQ2J5eTZ2c09weWppTi9w?=
 =?utf-8?B?dTNwaVMwUjlaTjErRTFBaTRFRUhkdWUvaHRhNElheCtseVlBVUpSdFpSSHcw?=
 =?utf-8?B?aSsrU2wzelo4dmpwRFJYSlc2aGV3MUtrZVZkNTAyMWVrNHJ1SkhQemVvN05K?=
 =?utf-8?B?bDVWeVg4TGU5alFvYk9SbnNoUEJNbEZxOVVFSXdyU00veEdBUDE4QjBQRnhD?=
 =?utf-8?B?OC9uVlZzcTRYMjBXUGt4bCtiU1d1dG8xZmwvUlFqMldFbVlINkdFOXBqenV2?=
 =?utf-8?B?SnhxM29MR01ZUThhS3kxSFg4Z2ZIWWxtTU12YzBMbEhBanlLaUZkTXkvYmg5?=
 =?utf-8?B?SkdBWDFWQVVYNnZvcGdIYzF2bmNvLzQwSmRyc1hjc0tqZWZyeGEvYjdrMUtO?=
 =?utf-8?B?SzNKU21sWTZVeVI1bUxPT0RVSWZWdS9NYWZzd21oYWpwQUJucUlFbjJwTzZx?=
 =?utf-8?B?K2VSOGZpcmdrdmhzTkcyL3pXbnB1S2ltUjRBY3I5L2hrWVYvRENSZmJwdzJv?=
 =?utf-8?B?OXZEblVydjhIYlFaMkxXUURsTzBiZjBoNmd1OHBtQVQyb1pwRml6TEErckdY?=
 =?utf-8?B?c3Z1QUY4aTJIczB5RjhRRVh2QzdBemRUSVJhS1RBQnEyQWg0Tjlvakp4bWl3?=
 =?utf-8?Q?EhjwzJJ5YC+EpDyPfLi8WqYw1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ac3b22-acba-41e0-8be0-08dc8c83a4cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 15:07:01.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6J/dtfb/HM2ZRbgrV0Dr79TPyXe9wX0U6iZ3fShzyj3Afzo98JElykh/WDTAp4VqUw40f8Hus3HlBmazxOWAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8215

Include common imx8-ss-mipi0.dtsi and imx8-ss-mipi1.dtsi.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi | 19 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi
new file mode 100644
index 0000000000000..f4c393fe72044
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2024 NXP
+ */
+
+&mipi0_lis_lpcg {
+	clocks = <&dsi_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>;
+	clock-output-names = "mipi0_lis_lpcg_ipg_clk";
+};
+
+&mipi0_pwm_lpcg {
+	clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>,
+		 <&dsi_ipg_clk>;
+	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+	clock-output-names = "mipi0_pwm_lpcg_clk",
+			     "mipi0_pwm_lpcg_ipg_clk";
+};
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 1e8511e8d8577..3ee6e2869e3cf 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -567,12 +567,28 @@ lvds_ipg_clk: clock-controller-lvds-ipg {
 		clock-output-names = "lvds0_ipg_clk";
 	};
 
+	dsi_ipg_clk: clock-controller-dsi-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "dsi_ipg_clk";
+	};
+
+	mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <432000000>;
+		clock-output-names = "mipi_pll_div2_clk";
+	};
+
 	/* sorted in register address */
 	#include "imx8-ss-cm41.dtsi"
 	#include "imx8-ss-audio.dtsi"
 	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-gpu0.dtsi"
+	#include "imx8-ss-mipi0.dtsi"
 	#include "imx8-ss-lvds0.dtsi"
+	#include "imx8-ss-mipi1.dtsi"
 	#include "imx8-ss-lvds1.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
@@ -586,3 +602,4 @@ lvds_ipg_clk: clock-controller-lvds-ipg {
 #include "imx8qm-ss-lsio.dtsi"
 #include "imx8qm-ss-audio.dtsi"
 #include "imx8qm-ss-lvds.dtsi"
+#include "imx8qm-ss-mipi.dtsi"

-- 
2.34.1


