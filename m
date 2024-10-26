Return-Path: <linux-kernel+bounces-383082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA99B172B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405DD1F23479
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B581D1F70;
	Sat, 26 Oct 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="bHPJoovg"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2139.outbound.protection.outlook.com [40.107.241.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A918800D;
	Sat, 26 Oct 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729939520; cv=fail; b=YS4ZfJziWg8P5nVbsmsaOpfF6Gq+qvPst5J9PN9jhwgP3y2R0NlmEfF7rDlQdxpi8sTccnwD3lkv6tmHmVygAXCP9iEdkIxeXgZET95Ui/6x88+sX1YRBzgjMnoNChfrCsoNMosCYcziH/8JN+pGy1xzmZ0XorjHzJtz222aukA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729939520; c=relaxed/simple;
	bh=p/txUdHC8BbDYroEJPA2iFVsTeCw9jLVEA0NKBldo0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YAOEqMPuRb/RT8XxrI/jXbLxtsMFIQTP9k2mLdRcDDA2mRx8hGhi0MAPWU79sxgNPiqZt8aa2ARqwvW91qGlYFFHvabjAdX1AV446K1Ntf3xwUoRPub6ieC7jUStJEei55Bibltja5vW7w3nOhm2rimRt9lENomFDDFJi+tlTGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=bHPJoovg; arc=fail smtp.client-ip=40.107.241.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1QigqTjyaQ7bWcaP35ZUaRsvM1YYSjlQKZr4sC2jK7YIp8WAOqLu2wUm4IvQruj3JgGeAzOQrtVmL4hMdJuNaKpFbSzZeJmpgb6EUOR1EhKzeXu5wGE3oDSankzrplTKiiM33TZpW5ma06LsWBpLpJZLuoqma6IygYStMU51y3zCNQIhhHwLCnmXw1x8s3csWQGMvSgBYdjV3Vr+9+VIcDsiipqqQLLdERcv2YNpJZCrFn5Fs27Oz+biSH1S81L2iK6WbW58/qpQxDZmdk/K6vd1FetNahgDGMVRiTC8MHAY/20DUQ19Wf9PFtnbv2GdaLRDJP6+nmiS/7K6Bv4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G6M7bJJfaKaFy5ZoAe3+uB9N9WDxDq1nxzaTyqyGFI=;
 b=zMRWV/fBCC5aaqIDWufnee4YEmcjQqMc4SxDM7hL/S2zoQuDU52/b/MQ9QSXKgO9TNJKDA7vOIfu/4Md6+6fOvNSQi9fNewejgGPg7vVl+uCUwLqyUUUAqqlg/dvsU1Asd/XESG7V2pvgxX4Vth99+aFdikEbSEDouXfX8I6MjXcIDoYjw9rE/hFBhO0tbNVfbn22nB/yswpnmlgjclXKIAASuxKAoRhrjxJ2/iai438A08Q3GNLRT0B6IipEOtCshk6yp3pqKx7VgSZ7sWMqlKEKIxDd6lJiVSmtpd6Y7LJQBXRrZSlAg4PcdjHoQhHzsIEjq68/F3IrKuOfTNc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G6M7bJJfaKaFy5ZoAe3+uB9N9WDxDq1nxzaTyqyGFI=;
 b=bHPJoovglHTjc+qovBjqELWErrlJYpL7weZ8TxwPWI0PJf3siPpwZomli9sjM0L/PZ3Gty4OB6BMyXMl3c+ilAiJc/bY4pqc9r2U/D0nybxLmPYBwDda1E3oHtujYWPRMDL+mFP2Dtq4R7887FSLxOVWCqDn1qbGGnmC7DB488E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AS8PR04MB7910.eurprd04.prod.outlook.com (2603:10a6:20b:288::15)
 by AM0PR04MB7107.eurprd04.prod.outlook.com (2603:10a6:208:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Sat, 26 Oct
 2024 10:45:10 +0000
Received: from AS8PR04MB7910.eurprd04.prod.outlook.com
 ([fe80::7acd:fca0:f5c0:4e99]) by AS8PR04MB7910.eurprd04.prod.outlook.com
 ([fe80::7acd:fca0:f5c0:4e99%7]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 10:45:10 +0000
Date: Sat, 26 Oct 2024 11:45:06 +0100
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: Armin Wolf <W_Armin@gmx.de>
Cc: corentin.chary@gmail.com, luke@ljones.dev,
	srinivas.pandruvada@linux.intel.com, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, Michael@phoronix.com,
	casey.g.bowman@intel.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: Fix inconsistent use of
 thermal policies
Message-ID: <ZxzIMsffFj2lvScb@laptop>
References: <20241025191514.15032-1-W_Armin@gmx.de>
 <20241025191514.15032-3-W_Armin@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025191514.15032-3-W_Armin@gmx.de>
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To AS8PR04MB7910.eurprd04.prod.outlook.com
 (2603:10a6:20b:288::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7910:EE_|AM0PR04MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f98555-e9ce-4656-fcf9-08dcf5ab439f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|41320700013|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tr3b8kxAZEJ6YMcOdyB6pjKJw1yHvcGN/DpGHqtY4UQKUtemyVbOH/9k1XxO?=
 =?us-ascii?Q?hlAiFWvFDejrwUCoEtdEGFXT+17f5ypzJ6b/cEmAz2M/o9E+AYC3iuK3Y+OR?=
 =?us-ascii?Q?asnpNPpQ781I2ei9saknTQTM5EPc0Vko9CA4e2KGH78pT2TXojdXOVlaCD5t?=
 =?us-ascii?Q?32MiDBiw/f2KIcpbWJiARbAgd1ZgQ26cBOCxkdHQj3ca7cZbVzUgLqBcCQpg?=
 =?us-ascii?Q?Fa22w/V4BZp57oU8B4O+RuPlwlJcgmU9SK6GXp+vpSzOwqTJQvXSuk2Puk5f?=
 =?us-ascii?Q?VHgrutmkqkJyu0hpBE0EooKr+OUtZmm0LqYhpeq6F5KnA34Sfkug4T/7PxRE?=
 =?us-ascii?Q?KMuuA++yW6H29ec1kFqDciFihq9RABlSaoP5M5RLyx+G9ORSf5ovGlvtlI5y?=
 =?us-ascii?Q?IdgZHTyn9otm3C0Kbpb1JUjY772oFlEYCDlS7LBcTrpp7K1O6oyhxfjGreEP?=
 =?us-ascii?Q?JTVaejIOv7vMLLFjHQUjClhx5JFJUK77bwa/oE/kYuVA19RdL93uSK1f1ZJg?=
 =?us-ascii?Q?v6ss0cRyuOB/62Eh1sxKEwSbrpnVFnwFRY7o0opTvb+Bzo6rZG956IeCCnlx?=
 =?us-ascii?Q?MfhydmcPt/oOY7ORQLmW4p327vdzu21tg1E5aB+/rNf3xyX0I/W37/Vq8tsy?=
 =?us-ascii?Q?o5vwAA8yMhLtZBKARTQZ1Vz8WCDSvW0rzUWLIxncCUv5E5nJUrSZSwdcdBJG?=
 =?us-ascii?Q?kcAt3nUYLJtzUiip0epdcs1wbhGNfIuy0iND5v8HZuqbDBuCddVokuaD/eOt?=
 =?us-ascii?Q?79+xwZH9qPLzoaqvt9VBZDDorfVmO4oinQ6U7St4q2mlbsJ8TYf7cRunJLZW?=
 =?us-ascii?Q?IebLrxBOfmyzRm6eTgKV7PflwufU39NYGKD01yPtLRdNZbynNzjmc7t5l7dG?=
 =?us-ascii?Q?2aQG09UmLw+7XiJOqNXoHqJDxSt6HDVAjd8CnHyR2QAfLrVxtobpjXHhGHXS?=
 =?us-ascii?Q?rLJs7I7VLtJmnKeGjEFTm8q6ZH01XEpqA9UutPb0vgysCV3xFA6/eMGqnvp2?=
 =?us-ascii?Q?WMGXHVefavpHIKq6ZQVnb6tLDfNW/cwKJIfEFQalLB5jrNDTIflfNznxqTyy?=
 =?us-ascii?Q?C0Dwu97mbIcWp5B2Ts0TviPSd5I/wx/vxuPhmvIGxqZgYOfSCmKouZYGVQFV?=
 =?us-ascii?Q?TiS0ltBKK41a9MXjpu4846g21Kfam9XJ48jA5iQ2ViSnFTXEHk2oQquN+K3s?=
 =?us-ascii?Q?MHi0o6nSPRz7vbkgowFOvOsZ5jowgeI6SiEeBJv5hJSflw8WetlEMN6O56CW?=
 =?us-ascii?Q?9Na0emdF0K7lyCQiazXmDYWaTwQHQ9yrUJy8WBQq8PdjKaxmjMYG/gal2F7a?=
 =?us-ascii?Q?SN4/IwGVx6wJJETP7FZc+5FBvRcBdkp9cOFD/1ENwHrNajRwNmux4qnTjno0?=
 =?us-ascii?Q?64qwXiEgIwjEoAdFv8ciYa5yM0Gh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7910.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(41320700013)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sVl3hJJAW5/pG8UQ85fP1qqeL6t87x9yxeN67xU2LdgnZDOsiDPJ5Qqs6mzV?=
 =?us-ascii?Q?jh2LtWTQF7ZhlpvNI9aaPm1J+PqpLqPSHkWpZGFwG69nrnFm6Y5qxIn0Lhqe?=
 =?us-ascii?Q?p4msh7qxVVOToUB3scD+KJ+rrezVHmHkVPezJPbkNXg4r4HQiD8ZmkWAsK/f?=
 =?us-ascii?Q?c0GIpOZy3B30ioqNAGx4JNTP2P7Xy5TZZ6lWG5LPlxW7CfJhAOf2UDsuBe30?=
 =?us-ascii?Q?jfN4OIQNRbfZt82FKYerIkGl5DLeu5CQhAslUk8bE/Wevm/Hnp1yJthDFRTS?=
 =?us-ascii?Q?EW5XkgOJOHbOXUkruYgYgUWzDYJ0K+Y08hhNCs9zu3AZ+fpAkMT3X4YjxORP?=
 =?us-ascii?Q?GkacvqSoCpVBc30e5KCNVQn6CVoxzE6K0Vn2GUJoI5f1b2nxeRAC7ihbLrWv?=
 =?us-ascii?Q?Nc6T+ZrFt/sSzapC9XhZ6VlSefgfyj8Gh5DXbpNXUl0Z1OVerQ6KnXcczwzN?=
 =?us-ascii?Q?ICXTwLP6DFAU3V8hn32slL54S061ha3EFAPFywSznvZU80fPrt8eH2H1QbUI?=
 =?us-ascii?Q?EuTlxwi5MCQ2ZWTsTajfJ6PE6JiXeS9eDUhPhNm89+ByksyA7cCiXAc10+OL?=
 =?us-ascii?Q?owgv2AlPatj6H9n3cqQViHkAEmeRO69GC70CuA9fVaouyiP1A0Hi9NnSff22?=
 =?us-ascii?Q?YCK6gnrEgfSfYKK8hxkm/h7xDa5Z8hTC8em2lK/HAuNWO7oj3KwnsgZZTnhd?=
 =?us-ascii?Q?Xky0WCsKhzk0tHyFDOdOlAExBUPAej6fDNU2amVLzaLkr52l+/yPoP5WsJIB?=
 =?us-ascii?Q?+ZoqxIHCcuRy2A4a4k7naBCrQqqe53cQHpBzA+WJL/nKNZ/kFHi22lSpCugU?=
 =?us-ascii?Q?cH40qBebQeClon8xKnIW1+JTyEtKrXseRVMld2ThXvpf7hRSUxgehEXgetXj?=
 =?us-ascii?Q?qu7pGsTvAvBshtTcupcMoxc/JvOaUGeSLOrwMZDFij6a71YH0YlecocymYDw?=
 =?us-ascii?Q?3pAjrOsvJp1fMVXz0Ooy3+P48gRK6zD0y/eCue3SyuEnK/KW4R21gD+ntUoU?=
 =?us-ascii?Q?WRrP7wnTnC3CDsyR/X7OW1ScBQh6gPeF8/xvWtfK7N6zS7wYyXGPFKhnTdoe?=
 =?us-ascii?Q?+Dn4luMcle+MJJ8f1rQpYOOiXxFAz9DsP24yxBcp4QhgMSR9cnZgFhNc7EPo?=
 =?us-ascii?Q?GyqidxJVafqJa7z03lTSgaflWYZYQLuR7uGA5OOwUgVX4MiwevOJIh6ANHxX?=
 =?us-ascii?Q?VCDli4ImkarxxJNUMbz8c6sRghZOiJgkN16CFl81tEojMQ4OWmaBh0VN/+CW?=
 =?us-ascii?Q?s1Y+C4y8otMjEdhj12LOJe6KenVfohB6iAEYL/onZDpoBDrsBvlW6FthiNAI?=
 =?us-ascii?Q?svEmGM6GDpDmJ3HXEWc9z0iWyO9x1mhZZHfEqilS4UEyyQSCjnm9MGtsixtC?=
 =?us-ascii?Q?b0t6x4IJjMr4SUUCrhTPf0ekIIoEgvoDz3CjaClBKIG8TLkEl4d+oGlViuQA?=
 =?us-ascii?Q?dqBgKJyakikZOpb3PsXWBb7/XeFjiSyd7lpyJ4mStpAr1debhPfs9qI620kB?=
 =?us-ascii?Q?/LcQo6+dMRz+MOk0wucYKVy0DfGN8rilqXJPqkfMqWa0AoDZlXlO6BIYwZRN?=
 =?us-ascii?Q?/GWz1ZUItlU7vMTJEMCcNFDQkIdJV5lcz2QFrVRBuOvHU3yIM/KoPV0rmDBE?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f98555-e9ce-4656-fcf9-08dcf5ab439f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7910.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 10:45:10.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrTCyi48B/dm5HWIS4GfCbhVI8/K3gjmzSFc1EAfBS524YgbPslUQRT0iCzWDIQpVJnkZXTc5HcFZHIMPQeV4H3MPucqq2Nu6dj1fZqJYkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7107

On Fri, Oct 25, 2024 at 09:15:14PM +0200, Armin Wolf wrote:
> When changing the thermal policy using the platform profile API,
> a Vivobook thermal policy is stored in throttle_thermal_policy_mode.
> 
> However everywhere else a normal thermal policy is stored inside this
> variable, potentially confusing the platform profile.
> 
> Fix this by always storing normal thermal policy values inside
> throttle_thermal_policy_mode and only do the conversion when writing
> the thermal policy to hardware.
> 
> Fixes: bcbfcebda2cb ("platform/x86: asus-wmi: add support for vivobook fan profiles")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/asus-wmi.c | 64 +++++++++++----------------------
>  1 file changed, 21 insertions(+), 43 deletions(-)

the original patch that i submitted did actually have the remapping
of the different fan profiles in the throttle_thermal_policy_write() methods 
because it was the cleaner solution [1]. however after having a discussion with luke, 
he shared that he might be planning to remove the throttle_thermal_policy sysfs interface 
in favour of platform_profiles [2] because of a refactoring he had been working on.

currently to control fan profiles through this driver you could use
either /sys/devices/platform/asus-nb-wmi/throttle_thermal_policy
(redundant and might get removed in the future) or through platform profiles which is the
better way of doing things.

for the reasons mentionned above, I decided to keep
throttle_therma_policy_write() unchanged and to move the remapping logic
to the asus_wmi_platform_profile_set(). this adopts the approach of
having a logical mapping stored in asus_wmi struct that has to be
converted to a physical mapping whenever needed [3].

so, if luke thinks that this won't cause any merge conflicts with his
work [4] then i see no problem with this approach even though it might cause an
order change when calling throttle_thermal_policy_switch_next()

Best Regards,
Mohamed G.

Link: https://lore.kernel.org/platform-driver-x86/20240421194320.48258-2-mohamed.ghanmi@supcom.tn/ # [1]
Link: https://lore.kernel.org/platform-driver-x86/4de768c5-aae5-4fda-a139-a8b73c8495a1@app.fastmail.com/ # [2]
Link: https://lore.kernel.org/platform-driver-x86/ZnlEuiP4Dgqpf51C@laptop/ # [3]
Link: https://lore.kernel.org/platform-driver-x86/20240930000046.51388-1-luke@ljones.dev/ # [4] 

