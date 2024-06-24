Return-Path: <linux-kernel+bounces-226996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDC89146F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DB82835AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E1E136643;
	Mon, 24 Jun 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="iI+eJMu7"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2128.outbound.protection.outlook.com [40.107.8.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA2D134410;
	Mon, 24 Jun 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223495; cv=fail; b=bfM7kjBKKgLe3kxuBjdzcJixirdgMIHhLZR2KpSC90aMtoQgt01ua1j+YcUjKhVfHkshvD7+CjrS3QqA/r1tb8eIM9ZmJtKxpZUKqzNMo3vGmi6h4kUyLG2Z4/rifaThjFJl+qBcU4rKhECTOIiQEfthknosECUEBxPdPo+Wb4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223495; c=relaxed/simple;
	bh=CBw1yDr2VawP8LeYd57fOrQ5lsqXpoGQn040OAjzrlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sddV8e1D6Y/GKK9MBjOFtgnxMvAdRtwPBae/MUnfZGh655qi2FrVKtsgUMS02HggTTKEO1XnDJToclQCtMyN9miKAhZPpjaVweB/QoBOlCfQMXCu5D6wZyGuL7zzCjmKaaH3WI/CtBHbYB+YSJ6HL1EaX+JZVZc5K+pEIuXsYd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=iI+eJMu7; arc=fail smtp.client-ip=40.107.8.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AefVipk9oa1o5dLw/wrWVyCOz1+MG2R/BXsf4uIR/y5UeMgHZfzCLJHQ9dOKgECMyqGNTbseaiSRbJf64kZIzSFBZzJrsRLnNRwmy57q85PsOHqohA+tl7R2+WevhlqC8EkOLm0Ujn73Ji4TquCnN7P1AIZkQyEsxQgSUjMCW5GsZJCdtQDubqxG1qfLhKUmLksQ2I7o8iIhwrHajnFbxFFq5rgV6LyqvjnbtWciu8hZyRpL1SCBrV0esKY6qsu3L4iiDBnoePxPgQmKKVUB3o0t4I+oaHyL8D9wAvDYhtxPOgUzHyOKWRHBrGXSY4Dy8szfLTMPjY0Ap32PD463tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mru8r+vGChuSwWXvEqrNAmMLhzoWbFJ8wb6UsAUk/P8=;
 b=alBHRTwS3Bvt4tBZmtjUXur3QA66wbjGNErKbIID8o3L0VIvXnFvemGyEdZHPvfUBSVt+I+NsT6As8Zovp1YZ/0LLC3Lko4sp4sMIvpV2xQ/TmfmJ1AYuzparWfmKBrMA42HGrEFKb/GZQHnzvK2MSL26riJ0I5tO465+G2QViCC1tPoylsR6CBwnxnJ8MOA+6/N8qxgNVqbMIWyZVk8UaSspwHDyG3bXdAK0T9J6s78SwkhXDGv8aQhbw4Z3NiwatNuVKkmX8Yv4RLtJdXB7qoOj8kEQJ4XebppAzwIPjZok6+nx6xLDtYwDffoX4RXQ1RuHLaEPzKrFMwRSH7NXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mru8r+vGChuSwWXvEqrNAmMLhzoWbFJ8wb6UsAUk/P8=;
 b=iI+eJMu7RIwVTk417QHJm+3spgw7npVar1vs5w0L28eB76/qsOtjThqZRfBc+Pg7NU9y3RR4QXPtqLfcYi5L/Si9NL+6Bi+hk+VRrQQMwt/v33wus+T5OmxAptzKbcsocYOrNqIpxCXcyKzpcB/q3TEvPJlFINpFjqr1B3ErfRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM8PR04MB7908.eurprd04.prod.outlook.com (2603:10a6:20b:24c::18)
 by VI2PR04MB10114.eurprd04.prod.outlook.com (2603:10a6:800:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 10:04:45 +0000
Received: from AM8PR04MB7908.eurprd04.prod.outlook.com
 ([fe80::eb8c:cdd5:a0a:757f]) by AM8PR04MB7908.eurprd04.prod.outlook.com
 ([fe80::eb8c:cdd5:a0a:757f%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 10:04:45 +0000
Date: Mon, 24 Jun 2024 11:04:42 +0100
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: Luke Jones <luke@ljones.dev>
Cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
Message-ID: <ZnlEuiP4Dgqpf51C@laptop>
References: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
 <20240609144849.2532-2-mohamed.ghanmi@supcom.tn>
 <9daef2c6-6df4-4f61-966c-239450de7b4e@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9daef2c6-6df4-4f61-966c-239450de7b4e@app.fastmail.com>
X-ClientProxiedBy: ZR2P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::19) To AM8PR04MB7908.eurprd04.prod.outlook.com
 (2603:10a6:20b:24c::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7908:EE_|VI2PR04MB10114:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c7d6a8-ab39-48e2-51c3-08dc9435129e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|41320700010|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gcGfBi+x61MJ0dcR/Hv00bVwEQBcWRaNMLMnvFgGxFGW0Z7AS+2BL9plfv54?=
 =?us-ascii?Q?pnc57XA6SS4qGQGrU6g+9fAJRt/IFJXr4mQPOZYJ7WjvR/PfAWXtnkMRV6To?=
 =?us-ascii?Q?9DleekDqTOJvFcdZzccl31eua4F4FyMRr+6erUxT97LVkR1G8XPIkuKC7fs0?=
 =?us-ascii?Q?AaXkDbz3SJj3CGvvd61E7zvmLf6le4Q8leejgTNuxvlhMQ+RODvLxwZPqbH3?=
 =?us-ascii?Q?acGCCK0s/tW2WBjNpDp8uzH639LRfvLG4/h2TvxKvXlDrfoc1wQyBoWPS2Ke?=
 =?us-ascii?Q?YfZzZxDyBJVT5HMOEJF4XqrYj0uy+/p4TA1U3XVRq+SNEJcEIOldYjR4b5Q9?=
 =?us-ascii?Q?jJhwevjerl8icR8dKw2+jHoVejr+pLOftxunvkkWivEQAVHhwOAL8/Pv9DnC?=
 =?us-ascii?Q?dczArUGhCAQotP/CjZ7ukNXLsT0QGa1e15CPx2ot8waxPE3n7lREDD6ieuHG?=
 =?us-ascii?Q?i5TmGumiQDoEftVN4YF7L1QG85qMMuT11Tc/2SOQFGmLx53ARS4SM6sMDbBG?=
 =?us-ascii?Q?E7Yuu7ao4puMuMks4ZlMnxW53Xe6WCJB2nYfnpr8kzNWLJrSf2SB7pxkWwA0?=
 =?us-ascii?Q?vsyIFisqI/yGhbug4j079jGgJ0ayWxEhU28TITOC6ufYa2QMMltsN/Nm0HhL?=
 =?us-ascii?Q?iCSSTqXUI+KSmLx2ZX7puR9oupAwYwu5JZOUpZsQJZbvHRtTTgEEgerDBjuO?=
 =?us-ascii?Q?J1GuOOEI1SFh/I2TRcEYUxH2icOk07RddRzZTr8MN1On98vUr3VD+mgTAvmp?=
 =?us-ascii?Q?kF23aazHVne5TEC/HVgamvqtITAZFviWvQxeEscuYxmsNAPjY3Abu55DscwO?=
 =?us-ascii?Q?hOK0vTwCKziz+izeMsPSzcB/4IB93HJCTel5wp0hIoW5xHYtkE2r5ULutUKc?=
 =?us-ascii?Q?SqaIdV7GOhSVvdY0W/tBYYQQS/BUsPq+0ccc7GZSkWBRUG38Nx0CzzNzeIwA?=
 =?us-ascii?Q?S2p1AzQeD3gJsV0LpIAiK0ZCpTYACYnyiKBWtWc2eHXmzlB/uF54pr7cK1UQ?=
 =?us-ascii?Q?aayrXkVBNZTWbInVAoSflmQ4Bf6b197UItRR5odhescsooxvcIPIe+zJZQv1?=
 =?us-ascii?Q?K+KiJ+jo4w+LYcjW5EqUrPCx9fD1E7Sjtx44Va6dVYoal64iy1aP42Jvuntc?=
 =?us-ascii?Q?6izF8Y3PqITvVF7ueG6WAQfAqM244su67Xt4dFoh5c6lS1Rk3ANuEHh0Mns+?=
 =?us-ascii?Q?WjwJIfNUSkPywCSnAsgF+WS2VhjVRTyheXc3Vi0H0VvijvIhBSkbCXGh8vXZ?=
 =?us-ascii?Q?NGGy6rQhxkakkuNyWCH22udKCXDf6849qVNp60LDlCCjViFR3cWtR3cTGvSH?=
 =?us-ascii?Q?R27t9H3QK8wP6KOhdUb0rkxzxYagE3VSKPoqMg8iAbwF1TGLEUVRNJFiE4+K?=
 =?us-ascii?Q?197MgTc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7908.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(41320700010)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Yp2DZRCdu6mekiQs58kbbyYLfoGxtpuRdC9hZpLGLKNUfIP1dn4imw5WPhZ?=
 =?us-ascii?Q?DUaOUW2GtB05Toti5rHM7Yz/1OYm/SBRyQmgcaRPOwYw06QzNJz01kCIna2m?=
 =?us-ascii?Q?jnFZH3nLrGmxkhfwqF+BqJBguJPzeqDKI8hCYTlHb9ZXrb//B0jXgTpoeHiz?=
 =?us-ascii?Q?dCCl1lDFGla31EWWV5eKXkg84SNMMmr7xO5hy8azV3BYzDRJKSPgxHmXVXPy?=
 =?us-ascii?Q?Snyv+KFR2PPdBGFax27RnLgGfc/GkqRDhhFYKs3yQiIsdQqOu+dJ8I92qnIQ?=
 =?us-ascii?Q?JdkJmoG6m7bY3wHS6Ib81+TGQi1fqr564twMhPBSW6sIMZwdgKUGyeK6/AjP?=
 =?us-ascii?Q?FjvQ5q7X/jcPTO8uvoqqLDT6V1d+KIHLKyvBHgQejZsbsfDkwAZE5fd4f2Wn?=
 =?us-ascii?Q?d635LxiDuw+fLdSET0ecy/EsN82BnqTtuVD5R6LSU1W2rVkqEqLXkfkpr6Fl?=
 =?us-ascii?Q?YzTeuMKXE+lAFHiM0OBlrwmb8bNaAr80jZT7QT3B0LGp/xAg76v8i8Q6PaUx?=
 =?us-ascii?Q?D13szbvcfrYdAxvxBhLE/mYEKYyn5fnTNjxV7rSQldkCdiAgdCGeV6bZFZHD?=
 =?us-ascii?Q?eIb4E8G+QpAYsKV7BpkqMajUDjUhocXB1IR1+ws3Ff8i8bMsTpzVo7iqGyvf?=
 =?us-ascii?Q?fMK0KiwHKmdvLzBqTP3LfvklkHSoEUECbee/cuqdWF/tWhoKWqwkWr3kPqJi?=
 =?us-ascii?Q?gkpS4nlMnn4yp8mFuzXqE/XF+SosMg/zV1ghswOXWX4h6jWhoGFMX/MJb5nL?=
 =?us-ascii?Q?EzMJyYSDfWUv30iHYIwRt7/2Nf6mQqBnZcvCxp8lp1CN6+EKZG2P5jvhseAL?=
 =?us-ascii?Q?a7anJPwq+ot2zzh56T1JchPyfCC9QHG0Cg86Ac+FrMrKQVujQgovk9Tt/O+m?=
 =?us-ascii?Q?GL9CEeSoqjMRS5hCaJ7aFEqBGrQptfpSLbC+ujxmGBktDIuE7aFVUIstZAbn?=
 =?us-ascii?Q?U/ehB5TKQ0oBfyZYn76HGZBWGeOk1PLNWPedD1yqy4Em9OqnXmkmr7g25Fsn?=
 =?us-ascii?Q?Q2SPsV0G/JOEZ5I0h+G0By3ivFv5ovHDLM1LetP3xZpfOjNYrI+ZTgkFbMHF?=
 =?us-ascii?Q?M2dD1McfSJbe1yhmkQAmquK7oJ+g2TfLu4au01fZkavUmP4ka2UAPeJN7261?=
 =?us-ascii?Q?mKY0CqZJdWfD6l5GGghD0aukIcWoZ1spVu7z4e9aSuPqotb+PWTCZiD0fVEQ?=
 =?us-ascii?Q?pjS26cXPw0e1aooMHmFvdNzytdlCPt7iLooErxXamTeHq/WlaUWq+HBzPZ9R?=
 =?us-ascii?Q?L8IHKx6Bq5i4ETvBv6GiPvY6AYCgtHapXB8VrRIB0Gk6PVkV74BmvzI9Q6c7?=
 =?us-ascii?Q?OKvN5jTehrl6JOPyfn6sGvcFVvyHqQyQDBYobyz7l6YvGG5SK5bFKDh/r+QD?=
 =?us-ascii?Q?6LsxCd1X3Gm73syRoj5oLqQ4pDt18v892AD3SkwS309s4GeVTN96FVFXK/iA?=
 =?us-ascii?Q?8ltF2WGSpNaBH2HEpec634CuWxmGKl3aR/IxcZoLgwQ5FO5LQbTDTtte1gvR?=
 =?us-ascii?Q?K/jyNwtNGypVKvbxIrGuYdF0hmqHCcqp5Vsst7MzdGypxBaKIOtH4c/Ick70?=
 =?us-ascii?Q?A9MDDi8YPa0JmFbHGZdvXydT5q6L3briWtXheuqFSVTIR9SH62TN9bGsXhGI?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c7d6a8-ab39-48e2-51c3-08dc9435129e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7908.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 10:04:45.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+ZKdn2A2wGj3xMF740+OHkw2J5kA9GSzuwlAwLodx7vmCR9gJUybV22nR5gY5fej8rVmz4A5kTNrFRGd/495g/mztxrSY4VQDENDA18fLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10114

On Tue, Jun 11, 2024 at 05:31:46PM +1200, Luke Jones wrote:
> 
> 
> On Mon, 10 Jun 2024, at 2:48 AM, Mohamed Ghanmi wrote:
> > Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> > to adjust power limits.
> > 
> > These fan profiles have a different device id than the ROG series
> > and different order. This reorders the existing modes.
> > 
> > As part of keeping the patch clean the throttle_thermal_policy_available
> > boolean stored in the driver struct is removed and
> > throttle_thermal_policy_dev is used in place (as on init it is zeroed).
> > 
> > Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> > drivers/platform/x86/asus-wmi.c            | 125 ++++++++++++---------
> > include/linux/platform_data/x86/asus-wmi.h |   1 +
> > 2 files changed, 76 insertions(+), 50 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index 3c61d75a3..2e3d8d8fb 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -97,6 +97,12 @@ module_param(fnlock_default, bool, 0444);
> > #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST 1
> > #define ASUS_THROTTLE_THERMAL_POLICY_SILENT 2
> >  
> > +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO 0
> > +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO 1
> > +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO 2
> > +
> > +#define PLATFORM_PROFILE_MAX 2
> > +
> > #define USB_INTEL_XUSB2PR 0xD0
> > #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI 0x9c31
> >  
> > @@ -293,8 +299,8 @@ struct asus_wmi {
> > u32 kbd_rgb_dev;
> > bool kbd_rgb_state_available;
> >  
> > - bool throttle_thermal_policy_available;
> > u8 throttle_thermal_policy_mode;
> > + u32 throttle_thermal_policy_dev;
> >  
> > bool cpu_fan_curve_available;
> > bool gpu_fan_curve_available;
> > @@ -3152,7 +3158,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
> > int err, fan_idx;
> > u8 mode = 0;
> >  
> > - if (asus->throttle_thermal_policy_available)
> > + if (asus->throttle_thermal_policy_dev)
> > mode = asus->throttle_thermal_policy_mode;
> > /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
> > if (mode == 2)
> > @@ -3359,7 +3365,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
> > * For machines with throttle this is the only way to reset fans
> > * to default mode of operation (does not erase curve data).
> > */
> > - if (asus->throttle_thermal_policy_available) {
> > + if (asus->throttle_thermal_policy_dev) {
> > err = throttle_thermal_policy_write(asus);
> > if (err)
> > return err;
> > @@ -3576,8 +3582,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
> > __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
> >  
> > /*
> > - * Must be initialised after throttle_thermal_policy_check_present() as
> > - * we check the status of throttle_thermal_policy_available during init.
> > + * Must be initialised after throttle_thermal_policy_dev is set as
> > + * we check the status of throttle_thermal_policy_dev during init.
> >   */
> > static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> > {
> > @@ -3618,38 +3624,13 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> > }
> >  
> > /* Throttle thermal policy ****************************************************/
> > -
> > -static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> > -{
> > - u32 result;
> > - int err;
> > -
> > - asus->throttle_thermal_policy_available = false;
> > -
> > - err = asus_wmi_get_devstate(asus,
> > -     ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > -     &result);
> > - if (err) {
> > - if (err == -ENODEV)
> > - return 0;
> > - return err;
> > - }
> > -
> > - if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> > - asus->throttle_thermal_policy_available = true;
> > -
> > - return 0;
> > -}
> > -
> > static int throttle_thermal_policy_write(struct asus_wmi *asus)
> > {
> > - int err;
> > - u8 value;
> > + u8 value = asus->throttle_thermal_policy_mode;
> > u32 retval;
> > + int err;
> >  
> > - value = asus->throttle_thermal_policy_mode;
> > -
> > - err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > + err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
> >     value, &retval);
> >  
> > sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> > @@ -3679,7 +3660,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
> >  
> > static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
> > {
> > - if (!asus->throttle_thermal_policy_available)
> > + if (!asus->throttle_thermal_policy_dev)
> > return 0;
> >  
> > asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > @@ -3691,7 +3672,7 @@ static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
> > u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> > int err;
> >  
> > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > + if (new_mode > PLATFORM_PROFILE_MAX)
> > new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> >  
> > asus->throttle_thermal_policy_mode = new_mode;
> > @@ -3730,7 +3711,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> > if (result < 0)
> > return result;
> >  
> > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > + if (new_mode > PLATFORM_PROFILE_MAX)
> > return -EINVAL;
> >  
> > asus->throttle_thermal_policy_mode = new_mode;
> > @@ -3747,10 +3728,56 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> > return count;
> > }
> >  
> > -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > +/*
> > + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > + */
> > static DEVICE_ATTR_RW(throttle_thermal_policy);
> >  
> > /* Platform profile ***********************************************************/
> > +static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus,
> > +   int mode)
> 
> Given the internals of this function I'm still not sure if this naming makes sense. Perhaps "maybe_platform_profile_to_vivo()"
>
you're right. this function doesn't only remap to vivo but if the laptop
is a not a vivo (in our case a ROG) it doesn't change the mapping.

The way I see it is that there is a logical mapping (the ROG mode
mapping) which is stored in the asus_wmi struct and a physical mapping
that is used when writing to the acpi device (the vivo in this case). 
so maybe naming them asus_wmi_platform_profile_from_logical_mapping() 
and asus_wmi_platform_profile_to_logical_mapping() is a better naming.
in the future there will be other device ids for different laptops.

sorry for the late reply
> > +{
> > + bool vivo;
> > +
> > + vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > +
> > + if (vivo) {
> > + switch (mode) {
> > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> > + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> > + }
> > + }
> > +
> > + return mode;
> > +
> > +}
> > +
> > +static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus,
> > +   int mode)
> 
> Same as the last function.
> 
same as the above
> > +{
> > + bool vivo;
> > +
> > + vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > +
> > + if (vivo) {
> > + switch (mode) {
> > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
> > + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
> > + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
> > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > + }
> > + }
> > +
> > + return mode;
> > +
> > +}
> > +
> > static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > enum platform_profile_option *profile)
> > {
> > @@ -3758,10 +3785,9 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > int tp;
> >  
> > asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> > -
> > tp = asus->throttle_thermal_policy_mode;
> >  
> > - switch (tp) {
> > + switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> > case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > *profile = PLATFORM_PROFILE_BALANCED;
> > break;
> > @@ -3775,6 +3801,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > return -EINVAL;
> > }
> >  
> > +
> > return 0;
> > }
> >  
> > @@ -3800,7 +3827,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> > return -EOPNOTSUPP;
> > }
> >  
> > - asus->throttle_thermal_policy_mode = tp;
> > + asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
> > return throttle_thermal_policy_write(asus);
> > }
> >  
> > @@ -3813,7 +3840,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
> > * Not an error if a component platform_profile relies on is unavailable
> > * so early return, skipping the setup of platform_profile.
> > */
> > - if (!asus->throttle_thermal_policy_available)
> > + if (!asus->throttle_thermal_policy_dev)
> > return 0;
> >  
> > dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
> > @@ -4228,7 +4255,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
> > if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
> > if (asus->fan_boost_mode_available)
> > fan_boost_mode_switch_next(asus);
> > - if (asus->throttle_thermal_policy_available)
> > + if (asus->throttle_thermal_policy_dev)
> > throttle_thermal_policy_switch_next(asus);
> > return;
> >  
> > @@ -4436,7 +4463,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
> > else if (attr == &dev_attr_fan_boost_mode.attr)
> > ok = asus->fan_boost_mode_available;
> > else if (attr == &dev_attr_throttle_thermal_policy.attr)
> > - ok = asus->throttle_thermal_policy_available;
> > + ok = asus->throttle_thermal_policy_dev != 0;
> > else if (attr == &dev_attr_ppt_pl2_sppt.attr)
> > devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
> > else if (attr == &dev_attr_ppt_pl1_spl.attr)
> > @@ -4745,16 +4772,15 @@ static int asus_wmi_add(struct platform_device *pdev)
> > else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
> > asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
> >  
> > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> > + asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
> > + else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
> > + asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > +
> > err = fan_boost_mode_check_present(asus);
> > if (err)
> > goto fail_fan_boost_mode;
> >  
> > - err = throttle_thermal_policy_check_present(asus);
> > - if (err)
> > - goto fail_throttle_thermal_policy;
> > - else
> > - throttle_thermal_policy_set_default(asus);
> > -
> > err = platform_profile_setup(asus);
> > if (err)
> > goto fail_platform_profile_setup;
> > @@ -4849,7 +4875,6 @@ static int asus_wmi_add(struct platform_device *pdev)
> > fail_input:
> > asus_wmi_sysfs_exit(asus->platform_device);
> > fail_sysfs:
> > -fail_throttle_thermal_policy:
> > fail_custom_fan_curve:
> > fail_platform_profile_setup:
> > if (asus->platform_profile_support)
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > index 3eb5cd677..982a63774 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -64,6 +64,7 @@
> > #define ASUS_WMI_DEVID_SCREENPAD_LIGHT 0x00050032
> > #define ASUS_WMI_DEVID_FAN_BOOST_MODE 0x00110018
> > #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> > +#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
> >  
> > /* Misc */
> > #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
> > -- 
> > 2.44.0
> > 
>  
> If Hans and Ilpo don't have any requirements then:
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> 

