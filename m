Return-Path: <linux-kernel+bounces-236519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4954491E353
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B36BB245D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51616E88B;
	Mon,  1 Jul 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a9P1K/Vr"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2067.outbound.protection.outlook.com [40.107.249.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256416DED8;
	Mon,  1 Jul 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846253; cv=fail; b=e+EeF2w7xiRXBUe47MZmoxO7eC2PafHY4mm+e5jmbr5/A+HGEj6aDumvoU7M3mZxiEfxJbP8ubP8zjo2pdBJJmwc+pllOQkprgRrpGfnw7tHkVY5Fd1rqP7fpJ/ohkHqC0koWmZFE/Xgcymug2q8r10Wi3vCxNG5A7hMtN/Tw8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846253; c=relaxed/simple;
	bh=DTO+VNKGSI4jjJCZsoh9zrmVSksUarOdNbdWRuRBe/4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cBFCg7CUU7+n4tlLwdpj/vLXJw+SmXNnHlD6rS1DLwod6MyLTYpYohfCY6EOTCblBDi+pB1h4zf4fA+cKMx6KBqGRWaQ0PW8P/cpUGBWtwRt5/6qUzpJkCYW1olP+vy6f/sQkQui9NY0XbGNOezb4XkHDDZi0dlBVWuwjcNj/7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a9P1K/Vr; arc=fail smtp.client-ip=40.107.249.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gul3/GRtlT/1uyzW65jYijTXBFUdhT74osyK5N1x4L5ctJp3C38U3N3peAWIt/nHtKrowasUDovj65BfQm8PjJYu/AAGu+wxFo73SbBFdqXqQuJOW7rBb9f2K/yvvUMHlGyR2C7U+5kPI/k1Pibn7qfdBUhgj32jkpiHU9vpLH8po7/qfI+PbrTBu/LDto4DfLp3/sEpHIHGaPjphf+oTrh39pTxDBjZmJ4KE0Gbo8h/bEKUpiOVytNJvE0Q5O5DKq5LHCWkog+N42ooH6sVqW3EB2imlLaH3I/W/5da2+m6hU05mWyJ8UTla6PLGCITjOh/InrGaHUXKNCSl+Ji+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz65/kWKfniZRT3TSxQRZahPqTyB1pM++jiCI1ZdSGw=;
 b=In8vCw2VGWZyZhd1ZK8iH5ATtGjZwj4Mz8vxvcqwEDoXmQSsE8JKK1rz6yiJ2iFit70FiOuYDIFLKzf0zLsDAEJZh4DBO16PvVWKAVhTKgB2IgM92aHbViXLZQ2HZ5QOXgBi6wSJjpJYZQqX9EUgor/vDIv+qh2LCRQ4q9z8ANhEKphm4uM59jSiACwPLHX1zO7hYp8J1AcWs3IYtNCeC/0wnMC0m3eIBo4FBe7peojx3Tj4WKiHtuk8gCAi2WLUZomreojJ3JAngVIbyqMaLioWSXtT+acGuTzLsbjNX7NekJIQBdOSgEuszpF+DYV2ddqe3f64tkOzMP05GBsdpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz65/kWKfniZRT3TSxQRZahPqTyB1pM++jiCI1ZdSGw=;
 b=a9P1K/VryRDJTfvzG9NsrZHSUTLbBTQjHSat/h2Dc+9X1o4umSZS3cJn0Tf48leEv1rgdP9n24QNZKmC0g/sfzX1zVEh9P1uT/EirLnNGBCF7dkEJAdZNL3I+QRx3e6SOea0KqdDVlq15ZAFcqKTsD5N2uXKXqETn5b7TZp931M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:04:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:04:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Jul 2024 11:03:32 -0400
Subject: [PATCH v4 6/8] arm64: dts: imx8qm-mek: add pwm and i2c in lvds
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-imx8qm-dts-usb-v4-6-03cdbc8c44b6@nxp.com>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
In-Reply-To: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=2711;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DTO+VNKGSI4jjJCZsoh9zrmVSksUarOdNbdWRuRBe/4=;
 b=lihQqOl1iQl2PMd9k0Z+D51Ced+Jft2879EttEcKRg/EnRaF+hIA1/O5N+OPvHaPEkBCdNJLy
 Rqmw66T/2z1B9jihGhJ71QpB302sg/mOup9Ui5+nMd+VyVejeRtJVOt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 496601c5-cb6a-464c-bd38-08dc99df0efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NW1oWUNBeVVBeHpacmVIMEpMYm10TGdCU2FUZGRPckxMRDN6cVVVNHFjV2cv?=
 =?utf-8?B?QUVmNXVFT2ZvMXgwcTV0S09YQXoyVnF6Ymxyb1NwZDB1Wlprb2QrZThicTll?=
 =?utf-8?B?ZlpWd3p6dWM5Rm5XNCt1emxaZ0lFdUZuOHZKZXBrd2NIV3ZUL3JWVVVZbVdh?=
 =?utf-8?B?QWFjMkJUZDM3MFJ1Q3dwa09MTzlNNk5QdXp0ZllHbUl5SkxLNkx5M0Vrc3FS?=
 =?utf-8?B?VkRhWUZYaFNnUUhMU0E5KzdrVWtDSGpvR2Y3VGVqQWRJSnMzRVJta2NrV3hm?=
 =?utf-8?B?UUVaMldQK3MzU3hzQ2xmMUtTMDVjL2lCeEhoZWFScUJHUm9JamJDNEJwekVm?=
 =?utf-8?B?VFRuQUJpeUNWZkdSWjZhUVl1aktSNlN2TEdwNDZ6Q0d3ZTVKYmErMjY3VGhE?=
 =?utf-8?B?Q0loTjNZWkhHSStiaWE1U1FjY3gxRzljQmdiV0tHMUYyaUdFMUliZjBVdHMy?=
 =?utf-8?B?N24wOUp5V3d3MVZxbnlRUEZTZm5Iby8zM0VzQzMzanpZZmR3Q0g4eTllekZR?=
 =?utf-8?B?bTBjcGtWVS9JcmNkenQrWi9mVjgyai9aQkRjL25LczdNamRwalRQaDBKTGpM?=
 =?utf-8?B?aUR2NzZsQ2ttZTNqTkpmcWphLzdxdWljaU9HUzdDVW9MYUM5VFRvQUVoWVJv?=
 =?utf-8?B?YWhsSThoQ2pRMC9DNFZTQTFSUWd3MlBnUlBQb0lNQmsyM1VBVkNnZ2ZnNjJo?=
 =?utf-8?B?YzAyS0lXS0VRU3ZaL2Q3TlR2T2c3THRkTEU5eTdheTVYdElSdVpmY2NwZDUw?=
 =?utf-8?B?N256YWZRbkZEeXdMNjRTNytqcFhkeWRKZGdHYWZpQTVnVTlJbGFzazl1aVVV?=
 =?utf-8?B?SFlTa2V3S1NKMzh4djhVUU9uUTZMYzJiL0tvemR6TkV3S251R3UxcWlBN1Rt?=
 =?utf-8?B?N0FCMHRybytvSUtqcy9helZMUStJZDV3Qk9GWDllSGtNTS9sSnhUbWR2WlRu?=
 =?utf-8?B?NzAvd1lxbkxySmRBckpmOERNNyt2Ump1N3Uza3lvSSs1bk9Lck1wZTBFdldX?=
 =?utf-8?B?ODN5emJZVXl3UUJOMDBRLzE4bEYxMVV6cCtKanhvV2w4V1BNbmlYZFlmbVo0?=
 =?utf-8?B?ejdMSW5ieHZWK09PbzJkbHNoZTBhejZ3N3hwNnRCTGVvZC9aODRhSjdWcFdG?=
 =?utf-8?B?ZHBCNkZINnMyTGExUjMzSEdZcGFCVUF4WjVNTmt4MUJYa3JEMEovRnAvRFU3?=
 =?utf-8?B?VjZhbzBEQ3ppTWZCRVByZXZ6NjlJU21vdmtaa09mbVBJTG43aHBOUnhKTnpu?=
 =?utf-8?B?RGtHbEhmSmZOSWlHSWZwQXU4Yy9IcmpQbEJUUzBCekNqaURlcjh3TXQ5Q1dM?=
 =?utf-8?B?MVhqckNneTJzdW4rVml0NG5mT3JxUHFkREcvdFJDQ0Q2VmNUVHhlV1B3ZDJI?=
 =?utf-8?B?MGZaaU5wMWVCcHFTcURDYWtLajd3ZXhBNmpwN2RJaUNWMGZyMTJyY1ZJVzdW?=
 =?utf-8?B?UWI5K1ZKOUVwcDg5U0xUNUpNVlBRVjlSZUcwcWRoQUk2QUFPdHI3eXgvMDJw?=
 =?utf-8?B?RGpjTlFuYllJbFZENTVkZ0d0RTZISUZzcHo0dUtKNk9Ncmd6VTFmMmtIMlNE?=
 =?utf-8?B?Vm1mY3RNcUU3cDlGNnZFSVNpWXM2RkRDNDlIbU9wQzJPbk1uVSttM3B4bDBU?=
 =?utf-8?B?WU9zaFI5ZTVQSDZWd08vRjZQdmFqaXZrbVV3eFExUVVONXM1d29wbVNiRElJ?=
 =?utf-8?B?RW1kS2wvUjkwNnBYeGxpbXRtVWI4c3ZidVJFS0xlRzN0aEZqYnlyd1k1RTBV?=
 =?utf-8?B?TmxBaUwzcUpOSjNkME1Hd0hOUU1ER2xKR3cyTFh6dWI1OVB5RXFodmhrRDM0?=
 =?utf-8?B?cDBSbEh5VlZEMjlnSnFRMXNuYmZrYlFjQkNXZzhHd2hRalIwR0hjVUNsMHlM?=
 =?utf-8?B?YXg5R0lnTG5KNHZLYkFXSktKY283TlplZzF2Rk9EdzRraEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1FMOGo0NWVsN2M1WVByS1RlVk9GOG1xVDNUdE10SUhiZDBOSHdPTDgwbTVY?=
 =?utf-8?B?WkgrVms3MktpbStURmZjTDMydTQyU2YzQmppUHBVT3ZDd1JoTjZvaEVHSE5Q?=
 =?utf-8?B?T3pyNmNOdGZ5RmdjMXFUZEp3V0JGVUJac1ZVcHdzdkJYMzNZWmo1RHlrckxx?=
 =?utf-8?B?dkcrK0FSQ2wzNkdYY1Z6SDd0TGhtMmRveS9qV3dLcWp3ZWZsejgybDVZQXo0?=
 =?utf-8?B?MWZKaktpa3NSanNVNDBhM09zUlRiN29PMVpWUGdaRk5yQkVhbEdwVWF6d29D?=
 =?utf-8?B?WGJ5VFpxbEY1UUQvQXhUZk92eTEwWElrZ0NZUzhvOTJNZXZXSEZ3YjMzY3k2?=
 =?utf-8?B?ZW9mN3RIbmllbStNTitGYzJGK2Q0bXlydThsVVJPNnc1NkZqVThkTXd3K0ZV?=
 =?utf-8?B?UWw3RDhRN3RVUkpscUJNQ0JPd1NYK3VwZDJ2RWg4U1ZwYTZDbGlxcDBlWHdr?=
 =?utf-8?B?UExRWlIzc24rbXI5U3hXdTRxWWtkNktMeEwwS2NWazlqRXhQSEU4cUl4R2FP?=
 =?utf-8?B?K1pkTUFsUzRDTi9jNUMxeFp0bUd6U1lKd0IvVzU3VU9Fd1RKek5JVW1qWTUy?=
 =?utf-8?B?SnFTQy9zcWw0UEQ3SjQwTDFScngvQWRzNG81WjRsMFJqUFVmcjlsaHI2dzFG?=
 =?utf-8?B?RlYvc2dDNlpYdjJoRmhVNTM4MzUwcm9SMEdlNzJLNnlzZzdzYTl0V2RERjBT?=
 =?utf-8?B?dURIMS9BYnVIZXJLckovR0ZUeG4zeXp0OTBkc0phTGdRanFoU2pMbnZpSEg2?=
 =?utf-8?B?TXBXSzNiM3B4MG4wRUc5RDJQdWJ0blZSUFFQNEg5TU55dGUzREdOanR6aWNl?=
 =?utf-8?B?L1VBcE1IcW9SaDJOSlN2ZlFmT2Fma3JtTU9KZmpLSjdCa1NjckR1K3VjRjBL?=
 =?utf-8?B?dUNWZ2FJaWcvM055R1ZUMld1M3JzajNZTmYzZk1PdkFYVTdkNWlsMkpUMWJ4?=
 =?utf-8?B?SlEwdmtUaEhSdTM4V1d4RGM4Zk1RNUZMT2MzdiswU3BrTnM4VlBzZSs0cm4z?=
 =?utf-8?B?cVdoVTY1QXhrb2NKTy9HTUZXd2NmdWcxVkxOL1NRcHM0YVFRRFlpZkdUWjda?=
 =?utf-8?B?eFFrcmJqNHZhcUo3aG5SeDdWamJWcE1Sb1diTGMwMHYwUTI2RVRWQjlmUVA1?=
 =?utf-8?B?VVcrYnY4c2VYTDl5Nk03RTlzZlhWQjZlUTJrcEJ2WkdUT3B0NGxMOVZMS3Va?=
 =?utf-8?B?RzRubW9TMnlFclhpVjMzZ2ZoMjB1RjVMYzJydStKTkUwV2U2NlNCQ0FwK0FI?=
 =?utf-8?B?R3JpME5mbGcrNUxtYTFiMkFvS3BPZVU0TGZPRlpzeGJKUG16cVJrTGd2MDRu?=
 =?utf-8?B?cnVZWVlXR2FlRkE1empiZTFvM1JZQjBrU0Y0VE5vdjVEK3h5QmcxTU8xaGdp?=
 =?utf-8?B?cVErU2RJbmtwYS9uZTIxSStpR1ZkTmpuYm1xWndsc2p4dEFmSVdZdndvKzBx?=
 =?utf-8?B?OVFXeUN2MU9pS1N0SXcveFNjOE1PUE9YNTNrRDdjd0QzSThnNkFseWo0a0Rj?=
 =?utf-8?B?WStza0c4dnZpQmNsT1loQmRoNUNMeTNMSllCd1dyMENhamJ0eWhZWGl3L2hj?=
 =?utf-8?B?bG9iU1IvTGFnN1JjaTljN1I3ckl4WUxXS3hlOVpSdXlqd1ZLUEhJTlJiNTBt?=
 =?utf-8?B?RTlwUFk2SjdQVStRNmYyQ3dLMXdDUzFITkxQY3pBSW1BbGc2ZVJ0dzFVRjNV?=
 =?utf-8?B?QlZwSXhISXg5S2pPelM1UW5zNkVtNko4K2crTmRNMTNMMy9rZzUyZ0Q1ZXVo?=
 =?utf-8?B?TExLNExSMHNDTW5LRW9qeGxxL0FHN21vTnNvWXAxb1kzUENNWXR5T2lBY1c0?=
 =?utf-8?B?cGQxbkN6OHowYkJzZGFEcEE2Q0REdE85aGJVRHdwN3FsbWFSTi93WC83SXVt?=
 =?utf-8?B?RDFSOFA4REZFNy9vTmxwaHZJc21KY3RaQlpFRFZFMDFNSndCL3BoQmpUUk9Q?=
 =?utf-8?B?NEZpaU16V3FiNHFGbDhqd1lQMnRrUUtIUDM0NnNxWmZGSE1RSXBSaU84dVJV?=
 =?utf-8?B?QitQYjRMcHdDVDg1THVJTWxURTFJdWNlelRjSTRyT3dJcmVKaENkQ3NIT21F?=
 =?utf-8?B?aC9XV0pHWHNzRzBnamhDa04rNkJ1dkQ5NERsbzRWY2FtR21LbWVQcHRHS2pM?=
 =?utf-8?Q?m80sfWk8JjCAUyiesvNbJAGxT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496601c5-cb6a-464c-bd38-08dc99df0efd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:04:08.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVJ2wbDJhr6TKkcqDV5Xg2ospEkpmL2Va8WUw2SO3ogpWTMQA79QF1+eHwsMYJ7DgzDYdipmcQulcmiV3PLUgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169

Add pwm[0,1] and i2c[0,1] in lvds subsystem.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 68 ++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index fcd904383daff..fc79ac0d57a1f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -93,6 +93,22 @@ vdevbuffer: memory@90400000 {
 		};
 	};
 
+	lvds_backlight0: backlight-lvds0 {
+		compatible = "pwm-backlight";
+		pwms = <&qm_pwm_lvds0 0 100000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <80>;
+	};
+
+	lvds_backlight1: backlight-lvds1 {
+		compatible = "pwm-backlight";
+		pwms = <&pwm_lvds1 0 100000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <80>;
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -334,6 +350,20 @@ wm8960: audio-codec@1a {
 	};
 };
 
+&i2c1_lvds0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds0_lpi2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&i2c1_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lvds1_lpi2c1>;
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
@@ -449,6 +479,18 @@ &fec2 {
 	status = "okay";
 };
 
+&qm_pwm_lvds0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_lvds0>;
+	status = "okay";
+};
+
+&pwm_lvds1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm_lvds1>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -675,6 +717,32 @@ IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
 		>;
 	};
 
+	pinctrl_lvds0_lpi2c1: lvds0lpi2c1grp {
+		fsl,pins = <
+			IMX8QM_LVDS0_I2C1_SCL_LVDS0_I2C1_SCL	0xc600004c
+			IMX8QM_LVDS0_I2C1_SDA_LVDS0_I2C1_SDA	0xc600004c
+		>;
+	};
+
+	pinctrl_lvds1_lpi2c1: lvds1lpi2c1grp {
+		fsl,pins = <
+			IMX8QM_LVDS1_I2C1_SCL_LVDS1_I2C1_SCL	0xc600004c
+			IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA	0xc600004c
+		>;
+	};
+
+	pinctrl_pwm_lvds0: pwmlvds0grp {
+		fsl,pins = <
+			IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT		0x00000020
+		>;
+	};
+
+	pinctrl_pwm_lvds1: pwmlvds1grp {
+		fsl,pins = <
+			IMX8QM_LVDS1_GPIO00_LVDS1_PWM0_OUT		0x00000020
+		>;
+	};
+
 	pinctrl_sai0: sai0grp {
 		fsl,pins = <
 			IMX8QM_SPI0_CS1_AUD_SAI0_TXC				0x0600004c

-- 
2.34.1


