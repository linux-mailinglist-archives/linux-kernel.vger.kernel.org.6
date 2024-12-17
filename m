Return-Path: <linux-kernel+bounces-448885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885299F46CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F211697F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B841DDA37;
	Tue, 17 Dec 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="opfmN4cl"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0852537F8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426263; cv=fail; b=CFqfXQ6/6HvLemH2Y/ca5DGYlRIfRKBYhie8JA/tx0gIel/38QPQTCwLs7KvZQbYlMm2uiC9h6xhY1qwG8vyjP7cDJ9nMIiHP8SmAsafTvxl11IRM6GQi4X6hqNKp9n2B9QVJCeHo8gmNB2dohPjyahvd2FsCqAaK9gdoUjqN9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426263; c=relaxed/simple;
	bh=6XKPiyE5cQM+dvIUfNKchVc5wWFYVrjfGZzVCiqIYQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NIJOYjgYIwt7yazdNSjyNIbX4JkJCsq+7rRiO1WkyZi6UBGjYJq/W5A7HwelKwafyWFFU88UnqjnSOFnSm0HqNrqwoiMvIymiubkyXfbSyBbPuWxyMobBz78gj4GISHF3/p5g0s/QBGfMltUGaxvKmp2O99vTe7GNuY2zxR/N7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=opfmN4cl; arc=fail smtp.client-ip=40.107.21.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rX2qo3sLWbAMSCMhDrEWlzrzRjC11+xwl1ZyCGQ6a78cnHTnmyq3zcEog01kYxc8g8G8Eh3DIlau1Wq1ZHXquRj8KzlNjwzdOg5+ZnsWnl1QgobLbJoHYJlNRlpztYq5DeFjH4NNkFZ2iCUnbBYtqgN1Lc7YYA7bMSjtcydctdmzi8OQLhVmz17R4qZmC8Q+wsco0kVirKilxYP2e+SxQEoMDXOnWaF/XabvcJKCTcQ8Xu7lh9JMaAFNOwSUQwE/EkYyTZTtOEnk2u5v/Z08grA5iOOPEW1RZYg5XKW+bkqS2H4qD4tp1fhoFAz6ecjpxCIkPX+XFJNiO/e7WcOLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZczPb1EmRr9O3UE2WfPuQL7i//bcopw3QMR2wW+O3E=;
 b=CDN4rPi6YAfLfilCYe1/z580ho6YU4WMOvl3PftCjaw99NAVC05DJXWLxoT7Hqf2bf64u7rYwEydtiHCiuRHShymqoYMHf34Yqjg0uIIge81sEs8pqwDF4zhCT0kONk/Bn5lnP4rfp+Xhto+hg6aR9V3O3HS+24velN3NqSw858fFWT4OiGggA0OaUuBME7DxWyWhpqBnwY0QbUhDnJhcLlfO7mPlIt4FQ8xsk9lGDHRMJjbQwrz6fykXzKoBcP7/60b+PDk2ygwIJGcOI9gScjrvYiVs/KyiwX5AgDvLoDX9WWebVS3y+RPwtUPZJFeVzgbtVS/HO/z++Z1/CshzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZczPb1EmRr9O3UE2WfPuQL7i//bcopw3QMR2wW+O3E=;
 b=opfmN4cl4tEJgWP+Nw43fXgn53Kl860VSUf6B/LZ++qAwgkVtMcZEmaGae8gs3bZEi7gi9PeJmKRwIcl8ONwNvAARN4bUuldibzH83GLBgnxbJEnl6rq8ypz/ASW/JoBpe+/FnPe8skHpCiFk5ifLfShGXhWl/fN3K9Ppnx55ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM8PR10MB4130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 09:04:16 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 09:04:16 +0000
Message-ID: <7b91ef22-2996-4e2e-b791-0cfcd4ce1fdd@kontron.de>
Date: Tue, 17 Dec 2024 10:04:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: pca9450: use dev_err_probe on errors
 requesting resources
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Robin Gong <yibin.gong@nxp.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20241217-pca9450-dev_err_probe-v1-1-04046092a92d@pengutronix.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20241217-pca9450-dev_err_probe-v1-1-04046092a92d@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM8PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd748c4-0a65-42a5-4cb2-08dd1e79c8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGpGMVMwU1V2aTZ5VElTZ2ZXUDZWenp0eUJJSm85azNMTk5VNHZpTi9PVFhp?=
 =?utf-8?B?WHlQSnMzMExFUzJPQitCVzdDU0NESFRrU3Vjd1JPcDNTSnFJZlNsY0t5UWNB?=
 =?utf-8?B?UFh2K2JQLzUyaGk1SzIvYWprL25vOTVOVHV6dmxLZkhxVEtYekhaOFhGemhj?=
 =?utf-8?B?c2hQeTVncHZMcUdRMmpoWVVES2pXemZNSjhESjZuL0JDbEdKSjM5cUtEVHdN?=
 =?utf-8?B?OW53TFJHWHRFTzVTRlFocDFTVGl4KzNFNTg3UEVBZnRNOGttV09uVTMwSXkw?=
 =?utf-8?B?eFRDNUt5V0VOeE1LMCtsd0wvOTR6eURrTWFCSE5IM0FNQmJFTTNyVGRLQmIv?=
 =?utf-8?B?NWh1dUE5TGREb2RoRWU5YUF2OHJOUHVsWDNkTGZGalBSek41THhGR2tybEE5?=
 =?utf-8?B?ZmJianRWK2x2aG41VmFZaVJCcWtHSDlDbkE5bHU4K0dKVXM3eHk2eEI3VG8y?=
 =?utf-8?B?STRaSXdCRDJWbmMyblRXUVV6OEloVFNPeThmNGdTVzNsMHBUUHE0SE9GM1ds?=
 =?utf-8?B?a3JJMWJmZVB3S1kyQjlkWGxGSlVnRXhSWHVYZTB6eCtnMHNLbXNxR0lPZGto?=
 =?utf-8?B?YU4rMUxwbHRyVkNLQjZBWi8wYjhPREJ5ZDUxTU9SSk4vem9JeUVHbEFPU29K?=
 =?utf-8?B?bkpLZTRheUY5eG5La3N2a3JsRkV5ZTJySlN3c0M2eXNtT3BvS3ozWmJodUFP?=
 =?utf-8?B?WFIrR080NWFibnNNbnVFalRyYTd6RnQ3cFRyZjRUNDVDQnh0RlZ1b0dSK2lk?=
 =?utf-8?B?UjcxTzFxZGYyempQZWNHYTFJanV5dUZDb0l5OUNmcGxnRkt1YWtwTWZkRU4y?=
 =?utf-8?B?U05pYTRUWDJQZ2FIYjdwUkd4WjQwbGFHSzgwd3huUkRkdlc5LzJMUVQrOVRv?=
 =?utf-8?B?Tmk4RUUzbXRXUFJ0R0s3MEJTTzJ2bkpncmo2YWlJT2RObnF5clZnbHFMMjVK?=
 =?utf-8?B?Tk9JRW8vWWpPWXVucXpSYnF1aEEvbkEzMUcrOUVQRTduc2xOcW0rL0lWN1ZY?=
 =?utf-8?B?YnRJdHF6L05mampqQ2RteWdsMlFOVXFxZkxyWGd4cHhQWWNvOWY4dUpldlU5?=
 =?utf-8?B?dno2dllnb1NTbEJOWGdzR1ZaeUg5My9JMmdPSk9yTVlxbEVvVEhBeWdrQzR4?=
 =?utf-8?B?QlFaRzJncWx4RnB6UERGWVhqQ0dHaHFkc3NMV3VFR3pOMDFlZ2xRTWU5ZjY5?=
 =?utf-8?B?VldCWmMwY2QwTEZWZkNGbVBLOUpBa3JhZ3lGT1k5dnJRN0dEVE12MG5IZEJ0?=
 =?utf-8?B?Q3J0NktxVGl4UnZGMUIzdDhlWUt5RHZsU2ZMTm5UNDN2YVBnUEFjS3Q4aTVm?=
 =?utf-8?B?TEFtSTlHSUFwdmtmQ0dUOEF0OWMraXZlRFRUYVQvaVZuSXJTdWZtdjcweC9v?=
 =?utf-8?B?cTJpV3BZT0tEazBTZWtlaFJHMDYya1BHREVBOHo4ejhpb04yYWFqalBQZEx0?=
 =?utf-8?B?UGQxQkdNZGhoRGFQcW0ray9EaWRzVGNPQ1ZjYk5wOUpSRS9YZnNkMGdodzJr?=
 =?utf-8?B?RVp1aUNqa0FYeGpDOUx5bERlbXRzT0JmbE5KR3kxdm5EM2xxZlpaaklxcEt0?=
 =?utf-8?B?UVhwSWpFTC9ERWxlbFowMkpvYXl1Z0lCRGpKOWFNSGcybllnZFFlZGJMWjg4?=
 =?utf-8?B?Q1hoUXFMWkhTeG9VNmhiQTZvemNaS3drTHNpZEhPTWFiVStyQ1ZPeGFiT0dx?=
 =?utf-8?B?Vzk4Q3FYR0lIc1JGdEZRV3cxdENGRldUb3ZvT3JrcUl4eEJMMXBaOGs0VUVt?=
 =?utf-8?B?VzdnRitXem9wWUdlZWorNVB5S1pYQWZuOU9WSlNpczlEVzdVa0RQdkVhYktN?=
 =?utf-8?B?UXR0VTNCYmg5ZHV2T3E1Zjk0RXR4UlZGd1BwS25Hc2ZBWjJyUUxmQzhsemZI?=
 =?utf-8?Q?V9+Lq6JWKZPRd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTArREtaU0pCbEZJSmJQb051ZlZVZm44VkErdkhBdEI4TFByTHNhM05oYjZk?=
 =?utf-8?B?Z3lPZTdxL1h1UlhmUmlwbzBFNkhYd3ZQN1g5KzhsLy9Uc1RnVVdYWk5RNjE0?=
 =?utf-8?B?M1pDR0gzVVhlL2gxMDlCMUQxU2dJVER5NkIzNFNmY25JSEIrb1lieThUeWEr?=
 =?utf-8?B?Zmp3aTNGVkRmZGF4NVBiVkxyVHlWQmZIVG90OTN1NFc1b3V4dW4xQVhIUE5F?=
 =?utf-8?B?L0YycUg0T1ZsemFudjl1czBaQXNwNlFaWVRjYWZkZ2NDOWlKd29oME5oNElY?=
 =?utf-8?B?VmEwTmVFbEd0S1BXQ2p3NmJwL1Z5aFlCRlFDYWNZdDRCKzhNQjRGeURCVGh1?=
 =?utf-8?B?RkJuZ3hJTGtVNzlQZWViRzNFUEtpcXZLd0Q2YkJwcER6YnBKZHZPTC9lb2JL?=
 =?utf-8?B?QnlmOTdhOUsvRE5UaGY5RUxKTkZCbjdRVVVPK1pNWFJYUmpDRHZJT3NrRm11?=
 =?utf-8?B?ZGhENDdKNUhXZWRhRU91N0xtSUJZSFlxWUJ6MWxiYWxkSXNmVGtENG1MUldW?=
 =?utf-8?B?N1RaK0RKbFlyUmV5UmRvNkFqeDJjcVZnTWNFNEZieGFTdkhNbmJGd3ZWblE0?=
 =?utf-8?B?dHpOd2h2NVhwMGNjTkdxT3hoQU5MdzZ4S2lnVUkyTkQ3eVhxVzdZTldSUDM5?=
 =?utf-8?B?ZDU5N1k3ZzdMNmFKNi9UdW50RnVvcmdpWlVvQ2VCTFc4bWhCZGFRbEY1bGd5?=
 =?utf-8?B?WWN1YnAvWHZhanlqNzJpTVlqVHl4ZlRIVHZDQllZYTRheDFqRzlzNmhCcmFu?=
 =?utf-8?B?RU1zeWNVWlEyNHFQMjVXVVJVN3M1dDk5Tm1pakxCN3ZubFQ1VzVRSDQ5dG5J?=
 =?utf-8?B?SGhmRzVINC9TRmE5UkhUR0ZpZGlkNTlKSE52ODZrWjk2R1RwaTBDSmREOG9V?=
 =?utf-8?B?dzBEQzg5ZXpzamhaOVZxSjhkVzNDZmhVYWFaWGFwY1g2azhCRS9LRVgxNDhG?=
 =?utf-8?B?NFA3T0orVVZBVE84OGpLcTJLTmdnS2tTZURMMkNDRUVGL1dIYnExWVZGenMv?=
 =?utf-8?B?dDVuZkxqdTRkUnBLU0Z4a1ZOT3dWd0dvTWZYRnQwVTVqemRyU2pzZXhieWNG?=
 =?utf-8?B?TzRmUWxOZXpRRmFlc0VJaDFVUVFJUnFNUTY3eVVCR3dDRERnYzhoMXV4Z3FB?=
 =?utf-8?B?NEo1aWhVbWJFRnEwN295Zm5OeGtlcG4wWURSU3BDTDFQL2tqZlB1RnUrUEMy?=
 =?utf-8?B?ZkhlNXVRdFFrMUVhS1UxL1JYVW5XVlhMNnpXRHptMmpWVVhvVGZKOW9GWmFq?=
 =?utf-8?B?NmZQNk56MHJMakd1VHJ6VHRkZ1JoUUs5SWRVUVh2c2FWdkRIUXQ3SWpFSW10?=
 =?utf-8?B?VGFyWlp0eTlKdUN4enJKTWo3UkE4WkQwdWlTbHBkZDVRYTFZaU5IR2NqVHFQ?=
 =?utf-8?B?dnVCODhnYm1sSXRxQ0twdWMyNkRKVGJ5cUVybzJpbFhpbUwvU21qNi96V0No?=
 =?utf-8?B?a09RODhhOTRWWWVEZEJ2K1JOKzBIZUUyWG0yTkppSlQ4MW0wM3piTmlVVWxs?=
 =?utf-8?B?SWtKM0pGbjVUbjZDT2tMeW9acTJMdWNPYXg4WjV4QUJlN09Pa3dpN01uaW5t?=
 =?utf-8?B?YTc2Uit5VC9TS2FFcktkeG12OHJxdGlLOTIybStZNUtPMXhkNVMzaGtuRVZR?=
 =?utf-8?B?YVAwS0dzUCtENUxjdVhtd3ZGdmh6V3RWSGJFSnRqTWUvWVZjekpVaHA2V3RH?=
 =?utf-8?B?VTVxK3ZVYUJRODcveGJTbThhWTEvaXJNRnVNUkM1WlpDcGg5WW5nVDlBYjd5?=
 =?utf-8?B?UkRVYXlMRnNBQXg1VjhYSUE5cnlpbFRyb2tOTnhjTUZXdWpkZUsvTFFDOTVP?=
 =?utf-8?B?Zlk1bXRwcjQ0eVJNUG8rZWZpUjQzR1BBcTVMb2RJSDl2aVgvS0Y3UU1JcjlK?=
 =?utf-8?B?cHEyQy9JVlIzOCtmWjBQYmJ3ZWt2SHI3cjRqK1JEWXVjeFRLcUp3SlRuTjB1?=
 =?utf-8?B?WndJNFpJT3puRXFIS2ZZT0JIT3BsOFpLSXVNbTZZTno5NU96VXlabnU5NklU?=
 =?utf-8?B?c3M2cEpuNU5QT2lqVWgreWZwSEZwT3FSL1UyUlN5RVYyZE1weGhsYUNUMFQ3?=
 =?utf-8?B?akFJQlNodno3WFF5YzFSQ2pOWUxQU3gvUG5nSVlXekhsUXp0REhVK1pLWWps?=
 =?utf-8?B?MlFZQ0VsSzFFT0kyQ1VHWW80b0UrWDIvUVF1aEdWVGFWQWM2WldLNURadFh5?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd748c4-0a65-42a5-4cb2-08dd1e79c8c1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:04:16.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZdutc7AykqZF6SThbJpNVQxKSxQmRqvqy6Js3F8+kUnAtTAEJRmhWO1zLCfAgnRycJhqe+QqeUQZl11koW1fyHsn85gMiVc2TDSfa06ndo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4130

On 17.12.24 9:59 AM, Ahmad Fatoum wrote:
> Probe functions requesting resources may return -EPROBE_DEFER to
> the driver core to instruct it to retry probe at a later time.
> This is not unusual and printing an error message unconditionally
> is just confusing to users:
> 
>   nxp-pca9450 0-0025: Failed to register regulator(buck1): -517
> 
> Using dev_err_probe remedies this:
> 
> The error message will only be shown if the error code is not
> -EPROBE_DEFER and if it is, the deferral reason is saved for display
> at a later time.
> 
> Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

There is a similar change already queued in next:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/regulator/pca9450-regulator.c?id=0f5c601098bd3c9cdfea3e01aacdd9d0c4010ea7

> ---
>  drivers/regulator/pca9450-regulator.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
> index 9714afe347dcc0205b40243252638dff5f9298ad..8f5ba59f7fe52bee1e467a3e6adf81a6a5476221 100644
> --- a/drivers/regulator/pca9450-regulator.c
> +++ b/drivers/regulator/pca9450-regulator.c
> @@ -953,13 +953,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  		config.dev = pca9450->dev;
>  
>  		rdev = devm_regulator_register(pca9450->dev, desc, &config);
> -		if (IS_ERR(rdev)) {
> -			ret = PTR_ERR(rdev);
> -			dev_err(pca9450->dev,
> -				"Failed to register regulator(%s): %d\n",
> -				desc->name, ret);
> -			return ret;
> -		}
> +		if (IS_ERR(rdev))
> +			return dev_err_probe(pca9450->dev, PTR_ERR(rdev),
> +				"Failed to register regulator(%s)\n",
> +				desc->name);
>  	}
>  
>  	if (pca9450->irq) {
> @@ -968,9 +965,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  						(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
>  						"pca9450-irq", pca9450);
>  		if (ret != 0) {
> -			dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
> -				pca9450->irq);
> -			return ret;
> +			return dev_err_probe(pca9450->dev, ret,
> +					     "Failed to request IRQ: %d\n",
> +					     pca9450->irq);
>  		}
>  		/* Unmask all interrupt except PWRON/WDOG/RSVD */
>  		ret = regmap_update_bits(pca9450->regmap, PCA9450_REG_INT1_MSK,
> @@ -1022,10 +1019,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
>  	 */
>  	pca9450->sd_vsel_gpio = gpiod_get_optional(pca9450->dev, "sd-vsel", GPIOD_OUT_HIGH);
>  
> -	if (IS_ERR(pca9450->sd_vsel_gpio)) {
> -		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
> -		return PTR_ERR(pca9450->sd_vsel_gpio);
> -	}
> +	if (IS_ERR(pca9450->sd_vsel_gpio))
> +		return dev_err_probe(&i2c->dev,
> +				     PTR_ERR(pca9450->sd_vsel_gpio),
> +				     "Failed to get SD_VSEL GPIO\n");
>  
>  	dev_info(&i2c->dev, "%s probed.\n",
>  		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
> 
> ---
> base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> change-id: 20241217-pca9450-dev_err_probe-778149cae5ee
> 
> Best regards,


