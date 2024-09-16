Return-Path: <linux-kernel+bounces-330271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A5979BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9837C282CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDB24F5FB;
	Mon, 16 Sep 2024 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="VxfAFbTM"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2102.outbound.protection.outlook.com [40.107.21.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F078F70
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470957; cv=fail; b=n0C1sDPtQrQLiOMaEbdSSaL5la9K4YtNl4N1dk1I2I/3yjnM1aMW7B5gU99HTyrcYbuJzHQrWLw34eG/0n6cSEEtojU1YA48bZ0V46GAWHR9XAPljHAi4w9C7Z0YOmfTwfY+9ewz2yVJSxsTdjZ1/hyHGsTw1PUUV7MjJ3Hy3bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470957; c=relaxed/simple;
	bh=EJBTqJFRWkRzGdfLq9WnTMnl5ROIQx07Nf/gLMwcHpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Afz68m1gti+NfxDjISaczWVjvQC8bzOnIswBC8wIG1XMJyHcSgiB94tir19PlvPf819MOxdgQqkurgSB9bARcf3K/+6a5POZsJeozwlWkPqSisDRitGdeH7GqQW7NGnRsvPqFTrvHnmONFOoFpupu6o96mxN88kju59GnpmTP0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=VxfAFbTM; arc=fail smtp.client-ip=40.107.21.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoXz5xhpRC6s5SAh/whYR5PGYhWQPRWr3c6rT+Ia7ZOaP1/PsXxE599H54nC3MlGjirhO72yhqDRMgs+lFQLu3xStVifr2ZKjLE4KP9KIuKlmZErDr+1qlBh2U4osP61mEktSUdwiBGYtx7tg/Pk1XWdwkhyoiWi0H364ucMwdMsT41a6sUSd8r/GqYAUQvZEsvWNeGAn/43mdGLiLnGWjG1Z570igN5rJLCLuujk1BCMmhd0FzPZoRq4YWwiZ8XUej3JKXHPN59nBGzG8VpUy5r/EVSUSE9yeWAZWo5OpRr0H3iwlCYKzHGIharGO8vP0iW7bFrDlFaNXQS3vmW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmpY3R9pFgqEN6fAl5lldAzXw4U1vPpIFWSpHGvLnSo=;
 b=Jn7E34f0DhVIib9WgAYWT+LgQt6nxBjNskCsmslJC9XHABfQhThctJ7yS4MVe7qYx0QvzfB0dypd2UKpXdas9nVt+jCNb75ustkCxN755JuXKPiOvPBmS3/OMGW6168yEgFscSG/oGIthDNQ1tlEe+Hryo/+Zl5tFfEBEoqKITEiYXX70MXyM/oj5xg2gaSLWvU+ccbfO1UJqcBJ9OxJ4uZieCvRF5fWvlSSD3xSjTFAP+SN6TfroVopECQ2h/7g2vUTVihCaiqLfJZ95o4LnuoUA9KaGmi1Gmua/fjNNwWWPw1MWHBO7DnR8LtOPue+EeDq17QxgyWSOuQwWC+pTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmpY3R9pFgqEN6fAl5lldAzXw4U1vPpIFWSpHGvLnSo=;
 b=VxfAFbTMMp+ydk5DjeYF1xYgJO2QwGc25VzX9989Q5t6NldUU7kbJWkPUrK4ktE0g/SVXG46paR2JlGkJHcGD1BY/xCnflyVGEWO+OpiHTjNXPb30U2VPVnjoruMBnqli67AB7ncXkAw7FitS//PGhxDxSvxd+q234CRMzZHM4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA2PR10MB9114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 07:15:50 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 07:15:50 +0000
Message-ID: <cddbe1ad-047a-4c28-9594-db574cfa77f9@kontron.de>
Date: Mon, 16 Sep 2024 09:15:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 neil.armstrong@linaro.org, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240914112816.520224-1-aford173@gmail.com>
 <20240914112816.520224-4-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240914112816.520224-4-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA2PR10MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd0b5a8-0fc1-4ad9-b923-08dcd61f64b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0tFZE5KK1h5c3FQRDJZWmRHaC9GS0twQ3o2UFpOOGZ5MXM3blBoYUpxNFZK?=
 =?utf-8?B?OTQ3T1JQeUZHL0RibHAvSDF4dSsvMXFDYjBIcktrbHIyMFZkUUE5U08rajl5?=
 =?utf-8?B?SkxIVXAvVFdCc0JmM0pMYjdVdjJ4MzJIY1dyUVFoTm1vcEhQN0x6UitQSVMw?=
 =?utf-8?B?MEFpYlFOd25heWJnMlUvcVVCaDJ5Syt0NUdRSVMwK2Q5eUp3NndrNWgreEFk?=
 =?utf-8?B?VUJmTXlYUlMxaUtaN1ZGOS9XYStTeCswU1pwbUEzdmRHV0JXdkRjYlkvbFBL?=
 =?utf-8?B?bXN2SjY3UkVXYVM4Yk9qeHA2SVdKQnd0ZnMrUWRkSDlMRy81TC9NOVR6d0tn?=
 =?utf-8?B?ZlRkRC9ZZjN4NkpsaGtFWU5laFV6em1lSVdQV0lsa3pvQmZmK2p3VFNhSlBl?=
 =?utf-8?B?aklhWW1YbDlGbkR1a0ZUdnNGMW9meHdLOTE2MnpGMGhIOE9ReGN0VzB6QVpD?=
 =?utf-8?B?b0pCZm9nR0VJVlBHZzNNRCtRT1FOWUx5MVY1LzZSV1Jsb2IySXlmRVlOR014?=
 =?utf-8?B?cFJtVndEbzlKa0dpWG1aN2RNUkVCNGFOZkx6akhQQ3FqbzBhcGZpRkdUaDJE?=
 =?utf-8?B?MHVLblVjbXFZNkJ6ZjFCL2VCekxtS1hZcHFwMEJ3WVlOQmNkNkJMSkk1QkpS?=
 =?utf-8?B?WWRRR1ZLRWE5ZnRuUyszckdVaHdyVGZFZ2REUVhQbE5KdlVBK3hnbzA0RkZM?=
 =?utf-8?B?OGJsNHFWa1dhbHk5ejEwTzFvUTU5K1ROUCtWR1g4V2ZwZGQzTElsZkhBV2ty?=
 =?utf-8?B?eDQvK1U3NzVqQ3dyc1VnR2FBbUhhSUlCQXFMVWFmR2RDU0c4Wm9DQ2VyZzJC?=
 =?utf-8?B?SDlJK2szeFJQOFpGcnRNVUV2ZG9iY1NmVk9Qa2ZzSkJUK1ZzcVVZbzZZYnR5?=
 =?utf-8?B?b0ZJWXBpc0JTM1ZaTmVKbU9XMEI2N05VMGFhRkRJTTR1MlNDUUJtYWQ0dkIx?=
 =?utf-8?B?cU9IVXZRTnFoLzFhWFBCZnNzcGtjMzJFb0tHOWxGVGlpVC96ZWlTcUgwTEpJ?=
 =?utf-8?B?bmdldEVsTGtKM054blBpRGpzeDJvbkpkYjZJV0IxZ2ljd1l2MHpqZ3pHcXFK?=
 =?utf-8?B?YU9QdWdjbWE3U1dtbUdkY3JjdDZWTjZsT2V6QWxjTWVaRWVwR2RKcUp3OGxz?=
 =?utf-8?B?QktvNDVYaXhQNUFEdU1WU0tEUEdOWUhJOUY2K05PU29ITTRlVVR2azJXb2RM?=
 =?utf-8?B?OTBEM3Y0aUtkQXR3ZXpEbC81ZEtXTjZaV1B3V3VyRnExbUpvK1Rhc21LNzN4?=
 =?utf-8?B?UFdocVZNTGxqUlFLdnI0eFY4aFhnVnhwK2E2ZTE5cFFJNmRPUlBGZlNxdVly?=
 =?utf-8?B?VnNkNkM5N2ZEL2hMdHFJUnM2K3JLWmpmYUUrTjhXeExNR3JtVm5MZmQ0bEtv?=
 =?utf-8?B?ZmpVSnNaRUZ3b2dZQTRhb2VLY2pJeER1a0ZqOFNvay85WGFTT0RtcWhRRHNp?=
 =?utf-8?B?bmNIMytqcnZQN3FJMmpUOHNIK2RrOGdIMElFSzA1VFlEcEMzamhNQzNsZlEy?=
 =?utf-8?B?R2pNcGx0R2FrY29qczRxUlZiN3h5NGJKYnlmOStrbXVRbVlKaHI4T01JYmUz?=
 =?utf-8?B?RGxndjNpdXo3U3NsZ2hVcjRPcWhRR0xjL3JUMFJXQUtBV1lnU0JFaEpCYXZV?=
 =?utf-8?B?UkE3eFBidDdJRkl6MnlkeVRQdk4vNVI3SkRtM0Z4b0orWEJla25ERlNaQm9y?=
 =?utf-8?B?NFhJWGhMZWtaQXdZZXNrSW5Sb3lYQmo1SlBLQnZCd0FBQlExdXZpZVNCRE1T?=
 =?utf-8?B?WE1qY2YwT1FvNkJDUy9jZjZwc1FvaXpTZDNwTW1yM09kNkdIRTR1NnlrN3k2?=
 =?utf-8?B?ZmcwaWVqRFZiUzBtYS80dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzNtTWpMYTZxcy9pSVdtOHZROVRuR2xEMG1wcG0vR01NOCsyVFFRdys2bVEz?=
 =?utf-8?B?NnlYTEVGNCtwODkrQWxoRVMzSDFSZzBwSllLVjdmM3Q2eEc0WG1oMlE3bE1K?=
 =?utf-8?B?TVRaOExrMTdOVE8wK0tTK1NLa2Z5alN3Tnk5eWd1bEJGSmRicmlWaGtveDM2?=
 =?utf-8?B?RHpEa04yaXh6cElkRU1yMVFGUHFtcHNhVm4zaVZ0Z1c5MjRVTUxXZ0VvSkJN?=
 =?utf-8?B?bFhXdTQrUlArcEhBa0haV1p1bXVwR3VKSHFVNkQyV3hJczVkQnU1aUU4NFZT?=
 =?utf-8?B?a1FoVFBtN3RkME50NXJ3WFZVNUVzRVJhK0JpV1JJaWZNTy93RkF6MHhwMWZC?=
 =?utf-8?B?UTJyb0cwbjkxbEpLQ1RzcnFOaGw3K2xUYVpGemdFWmNRcHpMdUZLN2R0S0hX?=
 =?utf-8?B?VTZpbGxzN0p5QU1PT3VqMHVscmRUY3NIQ29WK2VVaktEY3BnOG9DL011UHBB?=
 =?utf-8?B?ME9hOFB4cW10U0VUeGxkbHNXUE15dG5vWGVuZ0R1bzRJL1hBRExENHVyajdz?=
 =?utf-8?B?aDZtYWZrKzB0ZEFLZFVLMlBRT2N4dzF1ek9HZGhDMURscXM1azNVVGYzelZh?=
 =?utf-8?B?bmlRQzVSSHRlMVpYYkw0dEd1ME9nT3pmejg0M0lUMTNBdWxKYitHTVZNaDBW?=
 =?utf-8?B?eEdvMUVzUHk2eFMxekZESVN0aHhMc01TcTFDc0ZhaUdvOWJzRUx2ajNiQlFI?=
 =?utf-8?B?eFVrT0RRcWxLdlBqN3hWZS81ZVZlQXUyWWVzL0dNdmNJbUd5SEhpSWdpanh0?=
 =?utf-8?B?Tlhkdm9KSk80M3J6UmdYTFdIRnoxNjNza0hkeUNDRXE3ZHVCNXF0OGZBWklo?=
 =?utf-8?B?eDc2RW1GUTFoZGNOcVU3ZEQrREFSQlJWWnZlSUlPSVVTTWs2Nm4xRHhWalR3?=
 =?utf-8?B?ay90VTJrQ2Uwa3UzUnEwM0dObkZXOW95cUFERStYekNLRmRlc3crcU9HdDUx?=
 =?utf-8?B?YzhLU0I1Tm0xU2tzUmE3OXltQitLS1l5U3M3NS9rSkljcUN2THRsNTJxZ2k4?=
 =?utf-8?B?NjFGWllLSDN6Q2NiRjcrNks5bk5qbEw4NWhnN09YbGxpaVNRZS9zMmFORmZn?=
 =?utf-8?B?QkZERE5QRmNUbkZFbDJTNEVpL1NZajdaSVdqNm93MkhPZ0ttSytKR3dTMDFz?=
 =?utf-8?B?bU5SNnZDOGJzVVpYUmZXdElVbnh2SnNWNjFPUTI0cERTSUJvSnNKNU1WWURk?=
 =?utf-8?B?NUt0Zy84dGgycHJqTjZ5T0l3RFdaNFVWcUFZMk9la3MvbWRWcDZkRkxIYUFr?=
 =?utf-8?B?ODNQQUYrM3hVQjFlV3hJYXFaeTRkYjRUMkVlV0dZWXJGRjNlQTdWTGFHLzZq?=
 =?utf-8?B?MjdnYmVyUGJXN21LaFVLcFJqTEV2aHFGYVB5bGhtL0ZRckNCQU5sdHhBWkx1?=
 =?utf-8?B?cWM3ZDVNSnE4QU0rZm1jdXlRVkZkcjlRL1gvbitxN1lxZE84eUhSL29OQ0J4?=
 =?utf-8?B?K1NqSlhzeUFaZ2Z2d3Q1bmEzWDFOU3V2R1VFZ2NuN0VjZFJvTDdhQTFxUXVa?=
 =?utf-8?B?c0RIa0N4NzFidkk1MS9jYkpLMkUvT282YXFVWjl3NXltV3gzYzdYbnZRTFFC?=
 =?utf-8?B?UGRTVnpqWk1vb28zcmJ4VDlJWVpwejZXZk8vWVRPem4wdWZDSXlDZTVEQkcx?=
 =?utf-8?B?eU5Sa1ppTDJ6ZXZCNlk3K3BzN21ZWGZIODhXckFKYXUvV3VWU0pHZks3UWNq?=
 =?utf-8?B?QkJOdlAzK243UVBYWTM4NnVQMFJ4UmdOeEd1WWVxdkpFYTJmQW5rVGNWTG5I?=
 =?utf-8?B?S2EvV2FGTVhVajhvUytqblQyaUVaSE0za0RBWlo0VGQ2bThlRSt3NzdJZHJO?=
 =?utf-8?B?dWYwdE1tUFpMdStUdTVka2UzNUpxay9ZQ1J2SUMwZDI1NnQzdEJtKzhDeW56?=
 =?utf-8?B?SUFnQUN0VVRHTk94SWJYd0FVNm8vRFgrMDNWVExVYy90NlA0V1FqV09IUU9K?=
 =?utf-8?B?UDRuUzJERlhJUDlpTkV0NUNFRDYzMkI5YW5XQjBITVVacStwaktGT3A3YmJk?=
 =?utf-8?B?WXJMNXU5eG5NbmJNRUtVdnVqMlV5cVhYZ2RIdSt1NGRiVlRxUk9jZERaVEhO?=
 =?utf-8?B?YnFRZmM1QS94Y0dxSElDL0JLYnRLMUZmSk1VaU1KSTdpb0l3UjNHNW8wNU1X?=
 =?utf-8?B?bVlTZXNaek5taVltc3dqU0hzWGJXLzZFeWxLRkVnRE1KWEt0V1VmcFdoNGRV?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd0b5a8-0fc1-4ad9-b923-08dcd61f64b7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 07:15:50.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHW9RN3bulmR6HJEoQBGFud8wNuaBCOSzs1fE9BPKLXZh+EApREq9g8b//w4ot+6SuxmatjBsM34W/H1ReRkdmv5LWhRzf7sjzF0JfcBUr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9114

On 14.09.24 1:27 PM, Adam Ford wrote:
> There is currently a look-up table for a variety of resolutions.
> Since the phy has the ability to dynamically calculate the values
> necessary to use the intger divider which should allow more
> resolutions without having to update the look-up-table.
> 
> If the lookup table cannot find an exact match, fall back to the
> dynamic calculator of the integer divider.
> 
> Previously, the value of P was hard-coded to 1, this required an
> update to the phy_pll_cfg table to add in the extra value into the
> table, so if the value of P is calculated to be something else
> by the PMS calculator, the calculated_phy_pll_cfg structure
> can be used instead without having to keep track of which method
> was used.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
> Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

