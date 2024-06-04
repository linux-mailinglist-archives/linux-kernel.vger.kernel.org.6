Return-Path: <linux-kernel+bounces-201070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D938FB8F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5BB1F23D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DDC149C65;
	Tue,  4 Jun 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="Tw1cOtaB"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2090.outbound.protection.outlook.com [40.107.15.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5651494C1;
	Tue,  4 Jun 2024 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518524; cv=fail; b=FjbWYFGrZcPqyDL94jOmyA5SIudH8QrnYYYRANQEeDwSHD0PIj3lh+9aMXWhw3pv1qEjoENp92CrtWjWYLA3Mv5MQfeVuzvJJIeCDI1CnlpEOjTxlBC5U4CcFaUpXYPvlBvByRCdzg1sg+3fNf/RiS7w/qbPBv0ur9Vi3/wTgxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518524; c=relaxed/simple;
	bh=sIyGbm0UwmBi6da+B27iK0z9FM13zyL6otDG0vZHnNQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JKwLWjbUKBI8bq0tNQG42ikmMXaQjwoYdcOc4i+5SdCwXaaIsRdnqO9wWFuxA2K8L1agdKsOYZg9sEpG5A4dieebbzDxbdnb50utxrwdeHqyp4+EzjdhcG9pEiFPmkufwAO1kL3dqZjh7i/+EcOgkBH2tQaT7bWq6mh6TxJw2qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=Tw1cOtaB; arc=fail smtp.client-ip=40.107.15.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhRwytJCA8OcArvcTVjmD2X0JD8lw48/EDFVjDaZfLC5EUQklPOTVwELQZzeYkJPbmdtzQxhN3vUfpIA5faqTaoeQLeaYhXd+toaIojnHDbt9f7hcJltnW0KEj8Bsf7J7cwufBSuCy2UX6HJ5gJluni2PPq8wYIOqeRX+zdAabOiKX8PE3GJEDaEPGVyZaf3A14yMwKQocuWaHRoQPkwJ8Y+BKdSStzSx532+fLQXjNqDRXG30ROXsjvR6SSuuprreWJa9Y2fQ+Wq+4l3XwR3toltmTIAabzXQ0N/QvwJ2GqD0bN9pym3pohhx+GUMLru0uLqouom7RvAIOVsHFFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/VAcOZD1swnqZLqBuUZQ2ns+6ku6ncE17Jcsgv4okU=;
 b=bgoZKbA57px6ojNhKYsJ7GolTbSiQCVXz0oWrixG50I7dapeW5UbOEWlI5n3BRE4D00tQxakscFxrGhgPqGWST7CXVvcWLRuEvRiPU3L9GfdhKnTKzd/V/l1ugLlMk53Ix6gSliJf939fXx0VIZ7UgMK7/LYoRrS7a/dvEAtqTfNav4FTOS/Rv8uC+NJNEPygjFNBDcTg6P/ciu6HeExQtEIouweDwnx66RKkIbbqJzVsJpPHmzwoAysOfFalGj+FKtb11E8nSovBjQ5FDb7mxfqewX24kIBtewVyfVo4TJ737JkR0FpkzZ70v+dyOPYHRt1J4GQhqnR3uk1oPs2Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/VAcOZD1swnqZLqBuUZQ2ns+6ku6ncE17Jcsgv4okU=;
 b=Tw1cOtaBptuax/BXUpQbVKNF/vgG2duBddQ8IYGU/ujMkEYqRz63taygjcmkhFPIqsb8Stp98Z0DsuRVvcM52TGqkgUqi/QCs2MAP9bJrynVb02rq5pOuvHeUD7IVZ0iRQgg0h73vJ92JYwpwuwrF097jfQJGPvZDxupWwA+BpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 16:28:27 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 16:28:27 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Tue, 04 Jun 2024 18:23:54 +0200
Subject: [PATCH 4/4] arm64: dts: rockchip: add mule nvram/rom to
 rk3588-jaguar
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nvmem-v1-4-b784260a36a6@cherry.de>
References: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
In-Reply-To: <20240604-nvmem-v1-0-b784260a36a6@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>, quentin.schulz@cherry.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8d1e22-885c-48ac-5ead-08dc84b35cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlBTRVJaTzUzVFc1U1dRRHB0VlZ3bDU2aHdkL2RTMHZHR0tTUGQ2MHpmRklM?=
 =?utf-8?B?QzhhalFYdkhObk44TWhUYTl3MUg1NWovMlV6bVhLWDZpKzF0dGtmYS9WWEt4?=
 =?utf-8?B?aXY5bkRiY0Vza2Y0YkFDV3pwdEJPRm0wRXdtVlB0eFlCOTJ3TXpsRE4wNVZr?=
 =?utf-8?B?dlBZYjg2N1dMTnp0dHZtZFRLMzBwSDRaU3pmWlBscWsvMkRETXdrWUVNc2FN?=
 =?utf-8?B?OUs3Y1JmMW5GWHFNYmFkV3NMOXlVR0ZwQ296cDhQQ2ZmemJzLzcrRzVralRO?=
 =?utf-8?B?MjZibkdkN3lGWXJORGdXSkhRb2tqb2RLeVJqSXpUcDlNR1NrTHg4Y3dIUlpz?=
 =?utf-8?B?YTgrQzVTN0hJQ2lhSUhHSHpvNHFUYjVycC8xVGFWcVRrZE8zWTNyY01TQk5j?=
 =?utf-8?B?U2VnaHBMTmdoU08wd2tWb1lPMkhrM245RHgvbUZROW40eHFSZ0hialRuK1Nn?=
 =?utf-8?B?Snp1bE9aZlJHcGZBVjVhMWx0VDEvRXp2czdGU0dlQTNiSExpOHdpT24wd1A0?=
 =?utf-8?B?Nm0zei9PRklxUHpKaXhrNVRjbUxqVU9kNzFaRXBWSGtjcjRlTHdNK1hDZmZK?=
 =?utf-8?B?dHBBZFYzKyszcTYrSGtGRGYrU2RUY3JTRVc3S0kvNkk0MUl2OTRnbVk0TGVU?=
 =?utf-8?B?b1ZWZ1hJbTNzbTZvbk9vS2ZUTFNhbVByUDhtWXVVZ1lscVRkTm4xZERKbHgw?=
 =?utf-8?B?ZmFGU3ppUVZmRDJSMWZ6YlJabjVUalhGam1TbGtYOW1FZGhCbXVZQnh5SThR?=
 =?utf-8?B?ZUZ4bithVUQwY3Bpek1Xb01WL2VPbERqZmNBN0Nmalh0UUdVWDJGdk8xcWw3?=
 =?utf-8?B?TTNZbGN2REIxT0lPQnFzUmdwLzRheGpzekxXbldlN0g0TEptYnN5QUZsL2xn?=
 =?utf-8?B?STVsTTB0bXJLUUNncGl4UzROclR4c0JxRVd5eGUrRUIxd1licnhxM2RCNGpy?=
 =?utf-8?B?MlAyUW9vV2ZwdjFWYlNiNmtYR2dZc3JZbWt6VmNlbnZHMmU1U05wRkoyQnB4?=
 =?utf-8?B?blZiSm0zKzVnNXJZbFdGU3FJRHNuMTVqam1oVEQwZnpRcTBMWjJQa0xLNThB?=
 =?utf-8?B?M05aOUIyeVJSMWdtYk1Pd2dCbSttMUhCVFhrZzZVRmQ1Z3NQQ2xOU3NQQkdk?=
 =?utf-8?B?SWYxb056RForL1d1L0xGY2UxbXFJWnBxOXZuTm1qN0JPbnV6dW84emoydmNO?=
 =?utf-8?B?OGorVnBQSlEydTFOUlpvb1QyaUl2NUdzbitiUHBzaG9pWElmc1lCNGZSMG12?=
 =?utf-8?B?RktFTmFlN1FqVVFiRFVKa05qTDN5cVJVLzFxeG1HOG1sbXI3dzhac1g2c1A4?=
 =?utf-8?B?R1lFZ1l2bzVYQUV5WUZScEZDamI2VlpESlNUM2RZbm1FVFFSQ1lGb0tiTkdT?=
 =?utf-8?B?QWhsS2owYzFMSklseUxnZGY2ZTJyemZXZXRTbG5qSFVld2s3N0lrblgvaWZG?=
 =?utf-8?B?T1hjSXRDeWRhWWNhaXl4S1F5RUNrekNVdWViZHB2QVQvbEZaWWVzOHJlaVNK?=
 =?utf-8?B?YThUTXp4Y3ZZb29jajFDdzFLS1BMNktsQm5UalFsQkVCUkZOTUYzNDBzWmFM?=
 =?utf-8?B?R3FnSllzYUNuYUVMN2xkTEZES3hBUnJWUlNNVWl1Sm5BNzBuNXQ1UEtqVXcv?=
 =?utf-8?B?bTRCS1Bsa2dvOHRBd0hsVWJubWl2U1c2SXNFd1JQa2g1WithbC8yeUZUaVpE?=
 =?utf-8?B?Zk9pMmZOSzlYMTZWZVpWdEs0bXlCdHNobkNOOUFHbllUSXRyVnJaZWduMU5P?=
 =?utf-8?B?dlQ2dHdsV0hlVTJQVjU4UXpCRnBkcWFqWEMvUHQ3U2ZwVytkRm50akdWM1Iz?=
 =?utf-8?Q?VUOSZ8K6SUdQPnbG3KhNtqZAs+QSmWZPNvdto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2ZuRCtrV05wWVRIMW8xemd4MzdSemFpSXZ3Mmg3eHZjcGUxdDRyaFpIcWQ5?=
 =?utf-8?B?bWpsQzVTNk1SYjdGaUZCVFhZRFJXY0M5NEJHZTZHWGg0dWRXRWN3NkJtZUVX?=
 =?utf-8?B?U0VaUHBVOEhUdis3TnVPczlybDhTK2E5bk9sQmdKN0hyMG83YWc1UlpxRi83?=
 =?utf-8?B?dmVVaWU0eHZOUW5wRHg1c0JEWUM3NTg5T0JHc3B5OUNOSmVVYWIrcE5vMXZR?=
 =?utf-8?B?aEd1a0RTL3czQWxHSnlZbTJDenl1dTB2VFBRL0tCZlV5RVFyNzNsVUh6VE5H?=
 =?utf-8?B?R3NkTE56VFVVWDBVekZNR2NESDVxU3pKQXlHN0E5L2x1aTI2WUhzU0MyLzY4?=
 =?utf-8?B?dUhQUTMzNVNVbWp4SEpvL25wUFRwMVVSZGVUcGtGWHpKL3hIQ2FUdTFmWmlr?=
 =?utf-8?B?YkRDdXZQT0NwRDZEd0FYRElwTkdRU0REamJ0cjFoZzhxQSt3d09mc0hJQXdn?=
 =?utf-8?B?cGtNaFdzMEhFdEswOHZQKzUwU0prb21qQ0x0VGFxaTZlTzhnN3dDNGphZzNy?=
 =?utf-8?B?aCszdEFRRzltdGRQbEJMZTEreXA3RTlTL01aSjJ2WmZWV2dIYlpCUWdKRXdJ?=
 =?utf-8?B?MGtwN0FiS3BxOWI4MFd5VkFwQ3BRbUtUNnptMkt1UU9FbDRIbmVyeGE0ZnBX?=
 =?utf-8?B?MXJmUW9CUjhsQ2FZSXY2c0hWVC9iUlVPOHQxOThBQ2xNZ0RFd0VBZE4zUWps?=
 =?utf-8?B?MThrZTNZMGZkano2MFpWZitvVVVZZ3ZBdnVUaWltZ2s0ck1EaXRGdHNqTlFX?=
 =?utf-8?B?NkRMZkIzcXlyZGVFd0FZTitRTi9ZeFI0b2pEYUE4Q0xBWlNyUUF0RWV4a085?=
 =?utf-8?B?ZzNxSnZVOE53Lzk1MTEreUxLcGZKRlNtWEwwZGdWZVQ5SVJsTmJ2ZnA3S2FC?=
 =?utf-8?B?ZVY1aEVhbDd0aCtJa1RWMENqYW9MZ1FudldkRHNRMGc1UTlZVE1oTndCL0xa?=
 =?utf-8?B?Q0s0SlJTOC9GMDVpTzE2SitUdXFuRjJWdjg0eFQxTlZwdmV5S25lVW9yTHpP?=
 =?utf-8?B?R3A3STFQNlNlRjJMa1FSYXpNS3JCUDNlcjJXM3hLTTMrc1IxM2RRb3o2VHhC?=
 =?utf-8?B?VmEyMmNLNEg2cXdvUk1nUjE3d3lSYk5FazdBbjJGaUVQVmZ2ZG9PV0NheGdM?=
 =?utf-8?B?WG9YQ0JhdVBwOXgxaHZrc1czdk8wKzU5SlRNdHlTOXo4R1IxMWdvaEU0QnFx?=
 =?utf-8?B?bjVkMndvUXBPUUVDVFk3T3FIYmZucCtYMHAxR3pKdnhHSXVLRThxM2syNVIy?=
 =?utf-8?B?WnAvb1FDMmVqVStGd1pSRFJqbXdBTExzYlZ6T0I2MWp1cmY4OWgyU2NCeTRH?=
 =?utf-8?B?dFlNTHhLNDluLzB5a0R4RjVwYlN1TDBkWktOeFdsYThRYXpER1FNQTY5dFdG?=
 =?utf-8?B?K0Z6STdIei9nK0FkeXpvOUZ0TnRtRnp3cEdLcXg4VHpBcnRZTS9uSXMvSGNB?=
 =?utf-8?B?WEEzeHdrTFBsdlgzUjFKVzlHUU9CSVZTSTJkMjluRnJkOHU4RGVQcWs3NE5a?=
 =?utf-8?B?SkNjVWJPNVBBNVhkTjdZRHpWWmFNY2Y1amp5YURhOFJFR0NRckd2Ly9ZWTUv?=
 =?utf-8?B?Yy8zNnlCNVFCWnpMYzVlRFphTW5XNnhBOWQxV3BzTEFuM0dpa0krRGsrTTNL?=
 =?utf-8?B?RUJRaFdjRmN4eEJkVGI0UnlqZG9VL0tmSjFpVUo4MFRmV0hicVlJQ1Z1Rjlo?=
 =?utf-8?B?K1hIRTV2MWRWQnJqcjJHSDhsODl1UkhOUjk5aGFRa01Hc3dORUhkUFlJZGc4?=
 =?utf-8?B?dUlGSXJuSmRLK1Jkc2N2MTdhUHN5ZGloMUgwTmhIayswVVQzSEVtZ3RZc1BW?=
 =?utf-8?B?TkFrNm15dkNpbTB1LzRFZ1pnQ3ZrZ2Z1RDBWZEYwUFc2ck95MStsMWx3NFAw?=
 =?utf-8?B?c0M4YmlneFNqK1pDUFFMZ3YvQUJRbWR5T0tsWFB3M2RvWDE3Smd4bzVScURM?=
 =?utf-8?B?d0pWVk1USmxZWVVzNVU5ZFRQMkIxVGltY1hZTnNjOS9QZnlOczVkb2NhOXpF?=
 =?utf-8?B?c3ZWR0IyZldkYS9NZ1NWZ3JQY0RJcVJYQVlrTW5hdktZV2RFWlhFZmVZcU8z?=
 =?utf-8?B?NnJ5YS81dWZ1OEFQc0ZTdXA2UVJCUC9iODlhU01CQ0dmdG9VV2FsNHoxZGQv?=
 =?utf-8?B?ZkRmMkx5SmtLc2hZTnpRKy84VjBtWnhtTk4xbCtOUk5XdW9tWkRJVDNHdnI0?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8d1e22-885c-48ac-5ead-08dc84b35cdb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 16:28:27.2781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdVt8zbgZxs1GZJuNLAxn40pOs9n2fnUhLlqowCcN7QI3C601bs4K6VyI1roBpP5adFp4eX/cOE/3xAQcyPAAg9c2sAApswc2GcmOk4lB78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

Add mule NVRAM and ROM on the Mule I2C mux (0x18).

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 14f1322c162f..7434771901c3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -33,6 +33,8 @@ button-bios-disable {
 	aliases {
 		ethernet0 = &gmac0;
 		i2c10 = &i2c10;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
 		mmc0 = &sdhci;
 		mmc1 = &sdmmc;
 		rtc0 = &rtc_twi;
@@ -267,6 +269,49 @@ fan: fan@18 {
 				#cooling-cells = <2>;
 			};
 		};
+
+		i2c12: i2c@2 {
+			reg = <0x2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@18 {
+				compatible = "atmel,24c02";
+				reg = <0x18>;
+				size = <8>;
+			};
+		};
+
+		i2c13: i2c@3 {
+			reg = <0x3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@18 {
+				compatible = "atmel,24c02";
+				reg = <0x18>;
+				read-only;
+				size = <32>;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					mule-variant@0 {
+						reg = <0x0 0x1>;
+					};
+
+					mule-bl-version@1 {
+						reg = <0x1 0x8>;
+					};
+
+					mule-version@9 {
+						reg = <0x9 0x8>;
+					};
+				};
+			};
+		};
 	};
 
 	vdd_npu_s0: regulator@42 {

-- 
2.34.1


