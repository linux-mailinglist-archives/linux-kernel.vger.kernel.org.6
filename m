Return-Path: <linux-kernel+bounces-523624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE8A3D967
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E37F178143
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D81F460E;
	Thu, 20 Feb 2025 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="CGaQLQ5P"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C61F429C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052834; cv=fail; b=pAJoj84M4VOw4yTXxAmrP5kq9L4S0CmqE52/YFzPKgBWesziM0lc56TTgNx0XQv0ESHGKFh4HmV9Cq4l7mATfIzdezzD4gUE2gFwFu5EdpKAy+1Vv1r56EQtwmJK8yPPc/AdExzNoxtCyNqTltelMeSc9reapFT5uibmcgwk/nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052834; c=relaxed/simple;
	bh=JPGqZ/QgkYLRaJrLHqi6flSu1VSWVDgleeGj2VXAY4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P7yMBkymlLPIEwFTgNoF1Uzg35RmuXx9gGHAlOl1pNblD00RZCxnLXI4PuAte0FFTCoOjMGmM1Fms266W1Q+Xr5aJ6QbH+q8AsnOmGyWi0Ejm8vfOYHRmtB5HYK1ZEPAH/dXuoj8Zy4axlJrxfU8AbBFClGQRdWObM/+QY4l5x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=CGaQLQ5P; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj4fCnBMTXk+BwEbrerVwEY1vAojWxw2byfitEeTInE8Csdqjllzshet5UoCuDAimefTq/Uzepvv0mNSdva/Q8+Ib6qkdKnVch2rEBzNiP9azf8nmwTd002dl/kGPStGGK9vhZP4W0ESSr3ctgm5RZMHST+i4V55PkldWPOgE0NcJJwx9rYeKpDKYoRtuKCVexcvfi6JvOpuRMUgD+uF3epWpXt07HTUgzoABYIEPYxJzcBTgWngSeag10WGeeGX2aCRH+cWKq6Drf1+ZzYCYziwOiWAkDqXB3hzBUBCOPE9OXr4+a54R69bel8cmW7s/8LrWvfbmWxMZKzcmCBAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXFsuL+3squtWK+pAv8dPpcL3Vg/DEtCIId/oH2I28M=;
 b=cGj5NRANvSiSxgJudLYqkk60JMCuHlKASHm1I2XZpEUIrLgmqJjEcAYXOZhbPryp2orNyc3iU4mxTCGjJKUbCwq2M5zfG7NvjLQFiQOGUZkRic6A6pOZ4u0fPYsZuZTLsVYsSL/t5dtyspwV9aEqusZtnN0UhHfZn/TE0CiZ1S6AixvAxaeJ4HGNPA0j4VCzVfggbjdtxTFXOyp6FivVL+MEexbNu26xLDaZjoKlDSz3OKAbmTWJUfLOHxAj4abJUQBRANUpIbbQ8dM4++ztSf1lRtobPUBbupf2tBNyht4H/uAV628ToybBuwjkjMSI27QVSGy24jul9BotWa2viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXFsuL+3squtWK+pAv8dPpcL3Vg/DEtCIId/oH2I28M=;
 b=CGaQLQ5P1tnuGYv/FZceE2/7yOUAYxqGP3tCcpR6NPCFgI4Y1x+L2aoTHRszOYEKRnc0MGWvLqpGBQOx7C/Xy1Mdwge5cBX40pJP9S//LjRgBfj+yN3Etn08qyeXwIeMGF0sWtvibCKOIlnmkFqkhOwZi58jBSve7n5ztbNi94g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6845.eurprd04.prod.outlook.com (2603:10a6:803:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 12:00:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 12:00:26 +0000
Message-ID: <5a4915a1-e791-48e8-bca5-643245c94d0b@cherry.de>
Date: Thu, 20 Feb 2025 13:00:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: add usb typec host support to
 rk3588-jaguar
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250218211044.2256762-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250218211044.2256762-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0407.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 2082958b-ea0d-4c2b-0445-08dd51a62972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZW5LdVUxbHVTQUdRUXk3d1h0QTRIUUZIcEhRaWkwR1pXUjFHOVk1b2dxOEQz?=
 =?utf-8?B?UjBNQkYvL1c5d2NwNWNpZUJiSi9ONitVMDI0b0Y5Y0lPMDBFVXBKNnliUHlW?=
 =?utf-8?B?MFRVdEc4bzNYUktRM1ZMclpwRmNOTFVrQklqTFJ0dTVRZkZLWFJZVjlidnFp?=
 =?utf-8?B?VTkvUWE4K09HWGJ2ZmNIZm8rREtaQlFMdUc1ZnVWY3d1aE1SdStlL01RaHJk?=
 =?utf-8?B?QTh6NU1Qa2tWZzdQdlJFQU5OdlVCRHJTTkVZQVJObXdJdWhKSDJlYXZBdmU3?=
 =?utf-8?B?eEZ2dGd3THBXRW4vcEhBbTk1TnZ2ZityaU5Nc3NZN290dXB1Vm5BYkRYUmg4?=
 =?utf-8?B?M1lsOG12U2hiM1M1ZktQWWJER2N4d2RiS3J4cHlEZEFXU1ppMm5RUzk2cndr?=
 =?utf-8?B?dkprMW40cXR2UEhzR2g3ZTdXd3NoUmJGb3hzYTliKzRLMTlxNFNveWFnd2Nk?=
 =?utf-8?B?Q2xPd3ltSXB2dDhTNTlRTmN4c1VwRzVraE9Tc2RWbTZUVFRCMzZvTkRUTjhZ?=
 =?utf-8?B?bDZxQUVoQ3ptZ2FqNGNjdXBURHpDZ0N1U096WHljN3lzTEtuaVU2YSs0d2V0?=
 =?utf-8?B?MnlYS2YrKy8xcFFFK0RTRlZPajIxOVN1eXFFREZhWkpEN0xBZFRmWXpRV2Jk?=
 =?utf-8?B?KzBjNHZsbXZoOFlqa014T25uemd4TW1FcEpsWVh0L2xWVTRZd0VuRGRmWjRC?=
 =?utf-8?B?VzArRHZPbGpzZWgyZUVvQjQySmV0eUE1cVZTRG9VZFN3TlNuR3hpQ3dEUWhh?=
 =?utf-8?B?dmpkdmF2ZURENVlFaUh3Ykg3eE9xN3llUzdTeUkwNi9hZmxlS05FU2pFSng2?=
 =?utf-8?B?YmE4b01jSVlwNFI3a3psZ2twZStRUFI3YkdheXNpYVUwZ1k5QmkyRnJqd3pV?=
 =?utf-8?B?QXMybWZ3eFRYbTMzREphcEVDN0Y3WlcxUU5PZjlYR0hkYjcyTnpzSW53MkZk?=
 =?utf-8?B?ekRnWko3MEZ1Mi9TTUNwMGRtZGtNRGZHY0xsYjJIT3N4TTNGeXhtNFNGdWtQ?=
 =?utf-8?B?bVFmeURzVXVsak92N1BoNkUzTzFQVjJSNHU0YUFYeWZTcWpBSUNBaWl3Mzkx?=
 =?utf-8?B?bGg2dUYrcnl4ZDNnYkNEZE91c1ZYeE5yZDI0eWlob2krSlowTnp4cUJPWTQ0?=
 =?utf-8?B?eGNrVGwwdkdVcFFFZzNTanlZY1VQd21UcGpzMWlVUEkvVFlxQURYU0RudS8r?=
 =?utf-8?B?akJrVGxJT3JLdkpVVnBkdnZpRlRpYnBKeGVDYlozMFFqRjVsWlhOd1ZPZkFS?=
 =?utf-8?B?OExFWVpDZnlqUGp6ckhpeDEvZG15M3dNbHZ6WVlydThOeDkxVHQyZEJNbHl0?=
 =?utf-8?B?WVoyZ3VjYll2bkQzTG1MNjBrVng3eDQydG9UbTZxNmN1RlJxOU8yV3ZiTE5N?=
 =?utf-8?B?alVoUGhrUVdMcjFhWFpwN3pBRWhqYnhqc1RUTnBoS1Z5N1Z1YlBBcHUyYnF6?=
 =?utf-8?B?ZnVpMHczaWw5elJQZ2JxR0d2S0hseWZ1U1lUSUhIcUlxTXhiNDV2VmpWZDVy?=
 =?utf-8?B?N0JtazduaWkvRlEzeVBBY2ZhbGFaWEtWSFROVDNaSVBGZE9mejdndnU4V2pL?=
 =?utf-8?B?Tm4vSmN1dmVwSll3S1RlNVZnN3FyOWZaWExlQjhubHVOZWpRaU92TExsL2pW?=
 =?utf-8?B?SUJORlYvTVB1OUE3RTlTUFdJYk42NW5SK0NmbW11cmo2WVJ5bmtnaGgzSy91?=
 =?utf-8?B?TFlubFFKTE4wRXluY2xFMlJNdU1GRnlzS3RWdUIwQmVjbDFBaVdKeVhjVkVy?=
 =?utf-8?B?dy8yU241b0VyYWNRTFIrR2pYWkI1Vk1VRElpQitzekRmS3o4LyttelZwMGhG?=
 =?utf-8?B?ei9HWGV1dW56WFBZTWdZcE11eWRrL0dTOVZ1WUxoVDM1S25jenEwL1ZZRWdM?=
 =?utf-8?Q?oZOESR0Fx/hYg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTE1M1NFRkhIYUdxc1piekVJcmMxdnN5SFphbmdTaFhwc1VQKzJReVJTWnI4?=
 =?utf-8?B?OG00dU9ZcWJHbCtMcCtzanFNUWM0UkRCRVdseTg1WHQ4aTVnWU9hNUltQjdp?=
 =?utf-8?B?OUMwVktaRVU2MHhLbkg1MVA3b1dmemd0cWxHT0lQby9LNis1ME5ReUtXd0x2?=
 =?utf-8?B?NXV5N1U4RC8wQnIvdWtXanlLeEg2Y2txZEFuM0s0VmlwKzZRRXY3Y1IxU0x3?=
 =?utf-8?B?TisrYUR5dHUrRkRqWExoZlB6dUdacmhha1RXbmxxRWRTelcvcklVQ3VnT1ND?=
 =?utf-8?B?NVpOdGRTeDZFaHFPNFdVTG1YaVZKT3ZwTTBLczFJcWFyU09yQi9ud2Q2cXh0?=
 =?utf-8?B?dkpsa05WZXpBMFlDYVlZdlREamt2SFZxWlcrNFdPQXZCb0k5K3dxeW5pU2Mx?=
 =?utf-8?B?ZUZJbmlvZWUyWDhUcy93dmRWeTNtYmNpTTdEVmRaU0d6ZHkvOGVRU0FaTXNU?=
 =?utf-8?B?YmFqQnZpNTJTZStOZkF0N3AwcnV5ZEQ3M1h5bEdvdC83eVFzT0g2Y1FXT0lM?=
 =?utf-8?B?S3NFemQyVE51YWJmazRvbDA4WmdzcHBxUG5sbmtqZ0JlU21Pc3V0R2p4ayt5?=
 =?utf-8?B?UzIvc1FEaW9MVDViUEZqYnZndGtCQUthTEwzUVJ6ZkpBUXJIbWdFYnpvUURr?=
 =?utf-8?B?Z1phS1ZGM0Q0aTZmSlVDc0NrY3RsV2t5ZHdmbkRmcEk1WTdTTFRjUis3N28r?=
 =?utf-8?B?c2VhcGVURHYzK0c0OUJkVUZaVEQ5YjlwdExic2NTTTloazhEQXZtOWIrQndt?=
 =?utf-8?B?N3BYeWtmR1gzTFVqcWI3QXI4dklrc3NDeE1makhENDlLWGtNK3BkQzdGeGRm?=
 =?utf-8?B?M3dJaG5vNDJ4dDk2ZUc2dlJMZ0IwdXk4S0psemhya1pqd2FkUmd5TWlnc1hI?=
 =?utf-8?B?TVhUTVdNcFdjMm5iaGUwbE1nZWZHSmE5dE9JQzYra21BZkRZZVY5bkJRZ3Vn?=
 =?utf-8?B?V0hUVjlQN2g3S2RxencvR3Y0YURBSlBtWTJJRmV6Q2FRN1RQSll6NXI0K2JJ?=
 =?utf-8?B?T1BvZnVQQlZ0M3JGWnRIWXZ6TVpYTnd3dUw1bXhkS2paQ0hOeVpwcTFnUmxl?=
 =?utf-8?B?Mmx5am5INFBvU0hWRTBZajByS1lFWUFWeVYyUWRYM1hoOGk1QVdIbGNnZVdB?=
 =?utf-8?B?aTVpcVBsQVluSTNLOHYxUEhibVRvWjZnTGpOaUdhalMxVG1kenRvQ1piSkFh?=
 =?utf-8?B?TnpqVTQxU3RjQ1NaZkdHYlZNalp1Yk1mMy9hQmhEaU5IMDEydDFrQkNCRDMy?=
 =?utf-8?B?Uys3bk85dURRZnJpQ1RnajZxQkVLc05aYjQ3NFVaVHVYR3VibmZsZEx0NHAr?=
 =?utf-8?B?Nm9JSDE5N3NKSFdrVWJxcVRLdGgwQ3FnOU9GU0tjUE1ndVIzU1lFazZBZ0Zv?=
 =?utf-8?B?eDhjbEVreDNMeGM3S2MvMm84VGxJKzJQV0FKTTAzVVpWaDI2RlYrVEwzMjdk?=
 =?utf-8?B?UmR6bVZibzVmcTk4MXQ3MGFZb1Q0NE1VT2ZnQWtIN3p5K2pFcHRXVHZzTGpG?=
 =?utf-8?B?N2k1MVdPSEdYYlVMaUlURE42SmNNSGlpOUprMnRrbG5xSEMzL3h0VDB2aVQ4?=
 =?utf-8?B?aG8ySE0zbzUxcktoSHE1WlpDT1A2WTlTNmJ5SmRsSmdvd2FCT28yRlArbTVu?=
 =?utf-8?B?Vkc2Q251ams1NGl6UUNEWnkxOEwzeFlLWXljcUt5K08zNm11WUEwZUE2cmtT?=
 =?utf-8?B?dDl1YWRCRGZqWWZiMUxhSVVuNTFmRnVSaFlzUVF0bGw2OXRvNkxEWm1TV3ND?=
 =?utf-8?B?Mkkzc0t3OVpPNndObGtSZS8yN0VyTnVETi9CamQ2VHhWNWFQZVE3R282YktX?=
 =?utf-8?B?a0xEVnRXdExaVEFwTUdlWXhkaDlCWGJmZW9wb1JJL1RHb2dVZm44RnZEd0RD?=
 =?utf-8?B?N3JVVnJHVFQ3L2NOMXdxbXNzb2tIZ3FiT3ltOFVCUlB0dWx4WDZyVEN1K1BM?=
 =?utf-8?B?V1dxemEvdGxCNUthYlEwcmFCN3B3NzJnU0VJVjhiNG9sTjM4SVlrREZqZjVq?=
 =?utf-8?B?NnFON3FnYURBUzlHMW51VVA1dzdWaFF4b1FTTlBLN2ZBSFJmMmltSWsrR245?=
 =?utf-8?B?SmtXNTZNWUswTWJRMjBNOXNxMEhBUkJ0N1N1S1hJR1U1dkl1cjBmYzBnTWdY?=
 =?utf-8?B?RHpJR05URzVxSHgvMW9obVJyWGtWYTBFTlJZTmU1bXFhSFFkc0ZNU1lOcFVx?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2082958b-ea0d-4c2b-0445-08dd51a62972
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 12:00:26.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dv2PUQv3cBSM4L/GH7tn0MIJ4FSaokb4EXOmaaXLSWPMgFDSsZPEf4CasRYzNWwI7mmFELxfmW9i8MLY63nFjKr7VdK6YMb/QL9+Erzy7kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6845

Hi Heiko,

On 2/18/25 10:10 PM, Heiko Stuebner wrote:
[...]
> @@ -483,6 +583,16 @@ pcie30x4_waken_m0: pcie30x4-waken-m0 {
>   			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
>   		};
>   	};
> +
> +	usb3 {
> +		cc_int1: cc-int1 {
> +			rockchip,pins = <4 RK_PA3 0 &pcfg_pull_up>;

We actually already have an external HW pull-up for that, see R221 (and 
R227 for CC_INT2). They are pulled up to the same power rail than VDD of 
the FUSB IC so there shouldn't be any issue with an interrupt spuriously 
triggering because the power rail isn't enabled early enough.

Shouldn't we use RK_GPIO instead of 0?

> +		};
> +
> +		cc_int2: cc-int2 {
> +			rockchip,pins = <4 RK_PA4 0 &pcfg_pull_up>;

Ditto.

[...]

> +&usbdp_phy0 {
> +	orientation-switch;
> +	sbu1-dc-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>; /* Q7_USB_C0_SBU1_DC */
> +	sbu2-dc-gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>; /* Q7_USB_C0_SBU2_DC */
> +	status = "okay";
> +
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		usbdp_phy0_typec_ss: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&usbc0_ss>;
> +		};
> +
> +		usbdp_phy0_typec_sbu: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usbc0_sbu>;
> +		};
> +	};
> +};
> +
> +&usbdp_phy1 {
> +	orientation-switch;
> +	sbu1-dc-gpios = <&gpio0 RK_PD4 GPIO_ACTIVE_HIGH>; /* Q7_USB_C1_SBU1_DC */
> +	sbu2-dc-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>; /* Q7_USB_C1_SBU2_DC */

Maybe pinctrl for those too :) ? Ditto for usbdp_phy0 above.

Can we have a comment above usbdp_phy0 to say it's for P11? Ditto for P12?

Looks ok to me otherwise, will start some build to test this on my 
Jaguar to give my T-b tag while you work on the v3 :)

Cheers,
Quentin

