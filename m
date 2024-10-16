Return-Path: <linux-kernel+bounces-368526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D199A10E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87CF1C22751
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136820ADE7;
	Wed, 16 Oct 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GqmuGOC7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB118784A;
	Wed, 16 Oct 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100830; cv=fail; b=Yeos0/+7U7rVC8zaUXwyiE1a4nFjduNiLzvUZIH2M7qEfUchFcpgB1gz6qZoLPqQT9ftUUwiGFIaZs0nFvdpmbyQTbQhuTXkhfYGFqYtC9synPs70pYFvaOrViPEcKS1VfkAoz2OXU02UG7yIFPUKnwiaKGoZl8eC+O0/qVsW+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100830; c=relaxed/simple;
	bh=C1OhCf//nGE8suJMPaGKXzuxF/sJ2FYYrrI5LB+1LoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OF7KLUMHn4/AHuEnGhjxF7bov5Xd8Ken0jEM/M46NoSaahE//nQ+ZpMy3vfZdn9GTYaOqUPOpF86FXcpdetIIxz1vvt1T6XA1RKZq2LDESU0lQTJ3Iu0qaRuOPtmlxQSigl2R2w8uKzRRx2XBfrdsqPsyy6Qqvwg968qO2tvVYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GqmuGOC7; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD+x9hRY0eUxwfIX2P12Zz+chIf6JmMiiO+N6Qp3wk63tQbWjCp+U+rD6ZBNEoxqEFcUAIDLLec29uEQ5Eef/jcP30sum8A2nNnnMtR03ns1Dqr6cWxuzIs4QpJGtd82meUmqR2hBB9SPFBS6s67DBtodD1nIruA98jHx6JSoLYJPVKCCySMbIPu/hTv84YcSQBZ4rtXiSwKltKXi4ThgpR8zAZjl48EUZ6M265Fb9wZYmCm90+4wCEpdmMJkhL8+OVcYmpUbuz2bwmpXfowAhz/HFY7yUMcqhv/RP/UZnYnQudC2qCiWbKgliQcRu9ky9hL5ssfVRcQ+dSuMMegYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QThl1MHsS7cxfv0IhbTiQEm5a0rJvS3BQ7qJbLx53SE=;
 b=lxmF4BYrR2oymyOG5rWmFL6uz0fTj2d/+7xiGIg5oWbXEGTnyMzVxoXSbcAg/nIrPyPiT31y7SU3aYauYH2sXz4ForRjlHhXNdsxKNi18Rh56E2ekXuVJGdekZUX8FIF4tFo6w4C0CJOYgWDE7R0lYqDuw11nVrMi1NjyjRwgb4sXcXqqC2G2g+c6EQAIpNXsC+0DKMe3Cp+gySrXlrRMfBWfVA446orV99rYhGHZp7qzGYP67ETILexys06lzYdCndcLsiWGGTPnuRcysllQ+YUzzG4l1eQJz2Kh3J9flkaPdDpTOTAg+Qo4HrAMwPEBAdmsOkxhri22H8gcUCHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QThl1MHsS7cxfv0IhbTiQEm5a0rJvS3BQ7qJbLx53SE=;
 b=GqmuGOC7THTnPGEeeTVHGgmeq0AoR3s3BnC6K46+1VskPjnPnoHNLcxGGdz0m2Wu/DiAJJVciarjjXlFwkS/Pyz8iWq92nqKcTAC7DKGoymfT5D2uNit53iC88txd7ZLlcpn5qJwmB+mCKjAZa5f3m2PsByhTDJBQTHvkenhpXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Wed, 16 Oct
 2024 17:47:04 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::65b2:12d5:96ba:dd44%7]) with mapi id 15.20.8048.029; Wed, 16 Oct 2024
 17:47:04 +0000
Message-ID: <5b1c8688-8154-436e-ba8f-f5a9087d2c85@amd.com>
Date: Wed, 16 Oct 2024 13:46:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] drm: Minimum backlight overrides and
 implementation for amdgpu
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>,
 Hans de Goede <hdegoede@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dustin Howett <dustin@howett.net>, linux-doc@vger.kernel.org
References: <20240824-amdgpu-min-backlight-quirk-v6-0-1ed776a17fb3@weissschuh.net>
 <cfec358a-ff42-49c3-a174-149bee7a461c@t-8ch.de>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <cfec358a-ff42-49c3-a174-149bee7a461c@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0174.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::23) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: df13ea2c-6a34-415a-8b78-08dcee0a8b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUN4OEhkT3doaG1aRUNEalZIVjNOVkRwQW9neWplZVM5RWdQMVBkSWRUbXJs?=
 =?utf-8?B?R1BOeGZTSnVydTlFUWN5eXo0cHJqNjQzL3BKcUxrb1AyQnZBT0o1eTZkZHhh?=
 =?utf-8?B?MkIzVlFkMWFXRWFGcEZ3UU0zdEdjNllBQ1NLVGQ1djdGM3Yzc0tCYm9VYWll?=
 =?utf-8?B?cVNMRnFGVlJyNExIendueGVGYXpQUGFMcWtHcWlTeXIxYmlYVXM3ZXZUbFc0?=
 =?utf-8?B?N2pJaHlOcnRMLzdHTWoxblJ4eEJBUC82NXM2ek5QRHVzb1VsbFFQaDBncUkw?=
 =?utf-8?B?WlRaMnNBTlBEdk9kSUgwUTdRUnMxRmFuN21OZm11MnNBWW04NDVMc3RvTTVo?=
 =?utf-8?B?WWNzejZBaXlCVDF4L1oxSHdIYzRTTE80OHU4VjJRZmFoaHA3bHVpNklpRWFK?=
 =?utf-8?B?T2hoa2xrVXRzczdERy9nSktWTzUwZTQ0REpsZ1F0aVpSSzZuSnFFVStyVk9D?=
 =?utf-8?B?ekNsODRCZ3Vaa0N2RWV5SmtSakF1QWJ0RHhpc0FqNHh6R2YyTWErcWVFVmpl?=
 =?utf-8?B?YjhBOUxSd3JGQytBZkN0TGh3M1NMdG9Kd3YrQ3Zsa1BaZVBLV3I3bDlJSkor?=
 =?utf-8?B?aStkYnJUVTB3TlpURHRJR0MzdG9aYW1hR0xUSlBUZzNaZEZKajNsZ0Z5ZzlE?=
 =?utf-8?B?Qk9WRFdkQnkzSXo5RWhkZ2lMdDhZUzhZakJLZldXb1ZwcUV3a1ZxMUxtWmxl?=
 =?utf-8?B?dXZhZTJNM0ViWDZLVDFDZjhTUkt6NzNWSzA0c0VEQm5sU3lyK0tqeThvRnk5?=
 =?utf-8?B?U0o1RnRpWUpBb2IxSXRzWmpPYWRRc1VqQ3lscTc2UTZmb0hIemNyaG9vVE0w?=
 =?utf-8?B?Q0dhWFRxRFNNaEc2c0NPRXRvcktXc2VoMDFOS3dnUTkxMWNqSzFpcnIwMHFa?=
 =?utf-8?B?Y0wvMGpzejE1ZjRienQ1V3RhSmMrY1ExVHRLb2Z5MFZmT3N1bEtFaXF4eXAr?=
 =?utf-8?B?TWFXUllndUtiNkE5M3JSdjN2YVFUczdRejI0WmNiOTNxUlRocVoyVHVnTEtj?=
 =?utf-8?B?TW5xRHZuOFhKaFZVUmM1RDF3YnFHL2VrREdvWTA0cVJ5Z2RUU0Jnd0ZyYndI?=
 =?utf-8?B?Z0tIYWkyVXRCdGxwYUU2RzFYMXZuZk1VdXFrQ3NvQlJOSTlpYVNZcEZQM3Vq?=
 =?utf-8?B?M0N5cFUxQTdKc0JDbC9JckhCN0Q0TUtUL0FzOEZ0azd5VEJEaXZSY0VEOWpF?=
 =?utf-8?B?bGpLVWlCL0xUcmppejluYnVtNzI3eVlaNnhVYUJxNEpaVzBEWWRRb2ZCdzVa?=
 =?utf-8?B?ZHk5aVl4bHBJSnFwMzVYMmNiNWpHNk5WNDBiam4vSHZEazV2NzdkQmsvSWtQ?=
 =?utf-8?B?RXZoYTBtUml0SmkrdnFGcUd1WStaTzRwM09ldHN6K2dXbmwyNnEreTBUVzZF?=
 =?utf-8?B?akF0dkxVZ3FFUnF4Z2ROclZtR2hXdTEvMlUrbVFGSnBjZnY4Q2NiUHJBekMr?=
 =?utf-8?B?NEgxeVhMeEJTaHJlTkZoNFBrK2o3cnk5K0YybklpSXFBdDJlYys0Z3NPdmRN?=
 =?utf-8?B?YkUxTThXZWhvdWN0Tm1xWi9NcHBpUGZZeWttV1gxSUtWaG1EbnlKay9iRU1Y?=
 =?utf-8?B?eTdLQjFGS0pVeU5hajZYUGlWaFlwdXJGZXpUWjBYOC8xRlB6TlBtSjhRRzd0?=
 =?utf-8?B?c1ZTYXZJWERWQ3Zka2J1VUxBeUpZQmN4QjFRZm9DZ2s4eUk4ZkJ0eFJSd0sx?=
 =?utf-8?B?Q2Uxa0MwUm9CM2dRRndObDJwTm5xYXF0OFBnTEVtbGZsMzhNT0ZIcEZhVWVk?=
 =?utf-8?Q?p1z1Mcdjskki9BTwsk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5438.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXhZWmcxSFpNUStVMG9yMGxYQ2xObnJOSTlGQXRTWkh2aEVHZ1duaEJEUHFx?=
 =?utf-8?B?MytteUwvMk5IV3JuOWFkc29wcmFlZlZCa05IRVYrZ3FsekZSVXNSNm1aT1Bq?=
 =?utf-8?B?RTV4bnpSdkY1WnJ0NTVadDdwb1FJMHZuTHFzcFQ3OEdma2tVUWVTcEs5VFRZ?=
 =?utf-8?B?MnFYdlQvdjE3czQzRXhIYUZQMjY3R2dUQTlCRjFza2JxM3JYZjBzbm84QjJ1?=
 =?utf-8?B?U3hHVm03dlBoSmZYaFpZdlZGR3ZFdEF4blE1MS80MG1rUklBU0pSTTdNN2tx?=
 =?utf-8?B?d2FLT2pOOGhWNzBqUzRXZ2JKREdJK0ZYVVFFUGJnZ2RhRi9SR0lxbWcvQldP?=
 =?utf-8?B?VStKR1pnbWtGbUg5amRwZUlUQzBKN2VURnk1QkNsY0hmRHVKQit4TlZ1Y0V5?=
 =?utf-8?B?K2haMkNKT0NDa3gxTkJNUXFseFJVTm5aMnBqNDZGSVQrVW9SQTVxeFNJdlF4?=
 =?utf-8?B?OE5nUkdzeldZRTBJczVvNk1ySVYra3hBWVFHZVdTeFBkU1h0OWxNOThLczNr?=
 =?utf-8?B?ZWFWQlB5R1RWMGlBaGVWT2U4T2JRbVhqNEpPMlF6aUZDSUs1OXpEczFmZFhC?=
 =?utf-8?B?NnBUWFkzcVBGWFBHYzlNOCt0YlkvN0FZcFpEQ2hyQUl3cExGSndWU2hWalpK?=
 =?utf-8?B?dVpHWXFMNFpZMzdiaXF5cVNhZ1Btc2JzdnEyZFAzS01mWkYzaDgyMjBJZjlG?=
 =?utf-8?B?ZDFXT3krRnN2RnJJdDlCNVBZSUdUZnZPd0NLRlhYM2ppMFZSTEZhOFZ6S1Ez?=
 =?utf-8?B?dC92NWRRNS8yMld2bWhDcVE1eDUzdHBtZXk4WHVEUzBkOXpKQzBWVmhnZ2ln?=
 =?utf-8?B?MXgwZVpENGRwZWQ3RGRpbncwaHdYM2QzMjBoUFBxSDF6c2VqZ1ZsMWlhL1Ra?=
 =?utf-8?B?dUpSUHZWdTFTQnRHWTQ2c2x6eUlXRUJwSE9wbWU4eXA5VWxuNisrY2ZuVHAz?=
 =?utf-8?B?aWtka1JUVklDclFXNDU0TkdSSWZUQ3BrUk5kOGNKNzgvN0htcWhwSk1sMG1h?=
 =?utf-8?B?RDlCTVFmTUZyU3lDd0tzeWhkaVhFWlFaMm91QytrRUlMUXQzR1h6WngwMnFB?=
 =?utf-8?B?VlBBRit0bFQ1NGZjS3VVV1gvQmx6VzhXaDhwclhremlzMTF6L2VBMkZGUU5S?=
 =?utf-8?B?b3hHbjVUendGd29XVmc5WlNocWRmVFpVNWs2b0NoN3N0cFNpZGNTQTljQjZX?=
 =?utf-8?B?cWcwSjhoeUxIRjNLcnVhKzF6WXZyQmdMdmN5MHZXeks0SHQxQ2VFNWhnZVZ3?=
 =?utf-8?B?TFNxV2RQWnRrU1lKTVhaWkdCYTRISHdkL3Zqc1M3QkdMaW1oZEJyTGU1ckNW?=
 =?utf-8?B?OEdDRVJIZ1czRW5qMkVhZVVQaXg3bVh1aFJCeVFoK09DYVp4T1RWODBUMi9S?=
 =?utf-8?B?UjgreWFkSGpMUDkzZHBXdFRRSXNDblRXSG5ZWFlVT3BGR1dCTXdKMDNtdERQ?=
 =?utf-8?B?Y2tHS2xpRnpnVVRLZ2dwMG1iaDUyVlp5cFJrd3p0R0RFVjVRNnZJM0M2aExZ?=
 =?utf-8?B?Qmd2WDRQazVZTmtqVFJXMGU3YlY3RGk4TGJ6NFJ1cWlHVmQwVFpTOG1rdUJ3?=
 =?utf-8?B?RTZGTjJ1T3JSaW83Ymw3ZGZHK2dqd1JuVy9aV0JucTN1SThoLy8yUDdaUnRB?=
 =?utf-8?B?d1JIOHcyNXpqb2Jrbm9uNmhORGtCOS9rM2ZvMHc3Z2ZWc3lzajM4U3VKQjhH?=
 =?utf-8?B?R0o1aVFBcEFTYk1ISlNhUDVIenpJOVFLaC9KeFczTXhoMHlKcnFYbk1vK2Zm?=
 =?utf-8?B?N0t3RnNkS0IzT3pZSWZUMFRpQVEyOWxURThvMnFsdFROMDJCTG5LdGdQUytK?=
 =?utf-8?B?b256YXFUREtWZEozS1RmZFNJU0p3S0FVaXI4RTRGS1IvTU9BR3ZreGhwVldx?=
 =?utf-8?B?Q0dFa0VEb3F4dFRuQ3VjYWN4N1ZnK3B5U1BEY1h1dFZVdDk4a012OVlxRVpL?=
 =?utf-8?B?Y05kREsrWUZYR2NGVlBBTFREUkxmeVNTajI3djQzL1VOY1pxZ0hMTWFXOFFD?=
 =?utf-8?B?QVk4cFlhQWk1VUFtS1RCQ0JkVUFrTHhPOGxjVEYwZCt4ZlRZRStUU2l5WGRl?=
 =?utf-8?B?aTBOYVBpa0xsbUpoQmtWYXN5UzRVRXBZZTZZR0xUZzVWMUlJS012WE01OWkr?=
 =?utf-8?Q?+FZbn03TzaYCrF3DtZjrU5JCa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df13ea2c-6a34-415a-8b78-08dcee0a8b68
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:47:04.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wXqHvadtE8o9IcxbAw17pQdm3respTBGgkKB8dR3FTyVsOIedYKwhm0qsXAnTUs+lSqqbota//p34iAXpsG5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207



On 2024-09-16 14:23, Thomas Weißschuh wrote:
> Hi Harry, Leo and other amdgpu maintainers,
> 
> On 2024-08-24 20:33:53+0000, Thomas Weißschuh wrote:
>> The value of "min_input_signal" returned from ATIF on a Framework AMD 13
>> is "12". This leads to a fairly bright minimum display backlight.
>>
>> Introduce a quirk to override "min_input_signal" to "0" which leads to a
>> much lower minimum brightness, which is still readable even in daylight.
> 
> could you take another look at the series?
> The issues around panel power are not specific to the low pwm values,
> so shouldn't have an impact on this series.
> (And are nearly imperceptible anyways)
> 

I think these patches are good.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>> One solution would be a fixed firmware version, which was announced but
>> has no timeline.
>>
>> ---
>> Changes in v6:
>> - Clean up cover letter and commit messages
>> - Add my S-o-b to patch from Dustin
>> - Mention testing in combination with "panel_power_savings"
>> - Link to v5: https://lore.kernel.org/r/20240818-amdgpu-min-backlight-quirk-v5-0-b6c0ead0c73d@weissschuh.net
>>
>> Changes in v5:
>> - Forward-declare struct drm_edid
>> - Reorder patches, quirk entries are last
>> - Add patch from Dustin for additional quirk entries
>> - Link to v4: https://lore.kernel.org/r/20240812-amdgpu-min-backlight-quirk-v4-0-56a63ff897b7@weissschuh.net
>>
>> Changes in v4:
>> - Switch back to v2 implementation
>> - Add MODULE_DESCRIPTION()
>> - Simplify quirk infrastructure to only handle min backlight quirks.
>>   It can be extended if necessary.
>> - Expand documentation.
>> - Link to v3: https://lore.kernel.org/r/20240731-amdgpu-min-backlight-quirk-v3-0-46d40bb21a62@weissschuh.net
>>
>> Changes in v3:
>> - Switch to cmdline override parameter
>> - Link to v2: https://lore.kernel.org/r/20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net
>>
>> Changes in v2:
>> - Introduce proper drm backlight quirk infrastructure
>> - Quirk by EDID and DMI instead of only DMI
>> - Limit quirk to only single Framework 13 matte panel
>> - Link to v1: https://lore.kernel.org/r/20240610-amdgpu-min-backlight-quirk-v1-1-8459895a5b2a@weissschuh.net
>>
>> ---
>> Dustin L. Howett (1):
>>       drm: panel-backlight-quirks: Add Framework 13 glossy and 2.8k panels
>>
>> Thomas Weißschuh (3):
>>       drm: Add panel backlight quirks
>>       drm/amd/display: Add support for minimum backlight quirk
>>       drm: panel-backlight-quirks: Add Framework 13 matte panel
>>
>>  Documentation/gpu/drm-kms-helpers.rst             |  3 +
>>  drivers/gpu/drm/Kconfig                           |  4 +
>>  drivers/gpu/drm/Makefile                          |  1 +
>>  drivers/gpu/drm/amd/amdgpu/Kconfig                |  1 +
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++
>>  drivers/gpu/drm/drm_panel_backlight_quirks.c      | 94 +++++++++++++++++++++++
>>  include/drm/drm_utils.h                           |  4 +
>>  7 files changed, 117 insertions(+)
>> ---
>> base-commit: d2bafcf224f3911b183113b2fcb536c9e90684a3
>> change-id: 20240610-amdgpu-min-backlight-quirk-8402fd8e736a
>>
>> Best regards,
>> -- 
>> Thomas Weißschuh <linux@weissschuh.net>
>>


