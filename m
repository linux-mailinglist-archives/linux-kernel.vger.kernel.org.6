Return-Path: <linux-kernel+bounces-169392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D3A8BC80A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91BEFB21565
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846096D1A3;
	Mon,  6 May 2024 07:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zenithal.me header.i=@zenithal.me header.b="lnmMKbv8"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2106.outbound.protection.outlook.com [40.107.113.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2584F88E;
	Mon,  6 May 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979104; cv=fail; b=vEsBGHsJOSzPdURNZLUBQpBph6t7jnzDmgTJbHpHDZbpOdRqxI9Q3CciHlh5n5X+fI3eMiz8ZV/Jq0drOhEZ7hmuxrojUrUFAS2v4tYE+G3yaSCfDiJ0+Maau61qNg+XqdHuKYO+q77pl14AtqAKZ3nVfsAoxW8hY2Vmd3NKPO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979104; c=relaxed/simple;
	bh=I4zAkelONKTZFJbD0kqBLz7jQ03ITf4zm+6d9XtWh0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZtzJgp6Pik88qjgrJVKUiO5eW1MqFL7g7VJnmn5noc2CY2veMlxJcPrLmVrhaCa7dm4h8dIq24YPagIP215UzTmcFKud6t53UIF5W5HXY/vEckRf6uPf2cLAe+ilBQ3lW0R0M5uRUGYl1CFHATt9+YP9N5xhPeqJ6Y2OHUnMVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenithal.me; spf=pass smtp.mailfrom=zenithal.me; dkim=pass (1024-bit key) header.d=zenithal.me header.i=@zenithal.me header.b=lnmMKbv8; arc=fail smtp.client-ip=40.107.113.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenithal.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenithal.me
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH8BlZ5vZO7UCrSewncTyP2aWxftx5/RpUf+g0KLehY85St9gKGxFNJEDGpzFAmGRD1YQH6tDbVdnpyI87TgQdGnTeB2ntUp24aXG14Krg8pp1s8XAM2hXzy2j+EVEVTyV2ZF+rpExGtnf3dCq9Xi/0Y9Mx8hOYXPHYyJPL5pG+ZyfctjlhB++ZCMhfx5X2gAxVC13GW0WXB+0QxESpdzlzDYgxaFWCadsUZ39IV8KOIioDe4iyikl5Fo3ByEAa4NkGHIP3Q7OKnFcXRmXFApcJOYzaereaClOGBowfqhktuXKPB9crH5txa+NaLFzOmfGxXGi7s6xy4VC+ITWOtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rptHCJl1CsdyXQ5rkYCAsjubbNkxDv4QoKnhAg6tVA8=;
 b=HilcTQQW/bq/W5MfrKB9o70k74BvuaD1+Ju2evPs9Z/2IEWxTmCcuuwiT6GVFQ7GrckP8SMwGhyRlBl4G2tTH9rM+7lALr9MXZj53zK5bberoNQRS47d9JOm25ing9sGuvN6PonFKnF2tXI6lxK8HqtW6vVPvCHJzQ58DNgTsCGJB77j8ODOLcF5ktQgQyPSzlMkEIzpY3ZwjNMnT+iWeYl0FN+pacJ1xjgY60QvDU1aVSo2RloEG47I6jS+auO/54x++voGHqZkbV8uB5+cdWAnwWUqtpMvyGCLJvLagahv0hkh2zxGvIdemW/gW+Wth5U+Dm/XDyS7pe6KlqXu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rptHCJl1CsdyXQ5rkYCAsjubbNkxDv4QoKnhAg6tVA8=;
 b=lnmMKbv8uEl4JZ8JabdDx8dU38kB10FZ7C1hq6RW0eGxWNhpan8i4J4Teuhzc0lNvloQRBuzSos4rZ3/OmWDRy0aDZH7KEpouE6fIvhv/QlH0lp7+yeS3gPXjXd3mJvvFbch7dYiL22TVLSPDjpHeUPKzMqoGFs+QjVAROymR3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OS3P286MB2490.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Mon, 6 May 2024 07:05:00 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 07:04:59 +0000
Date: Mon, 6 May 2024 15:04:56 +0800
From: Hongren Zheng <i@zenithal.me>
To: Simon Holesch <simon@holesch.de>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] usbip: Don't submit special requests twice
Message-ID: <ZjiBGLVN6GteWvti@Sun>
References: <20231217194624.102385-1-simon@holesch.de>
 <ZjemYB6CpAx4Kx5f@Sun>
 <D11WJK47MBWS.3795S2OL21M7R@holesch.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D11WJK47MBWS.3795S2OL21M7R@holesch.de>
X-Operating-System: Linux Sun 6.6.28 
X-Mailer: Mutt 2.2.13 (2024-03-09)
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|OS3P286MB2490:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f140aa-a24b-479d-03e7-08dc6d9ad7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|41320700004|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r72vITVI9M30R73g8S6q20ffP8noZQb+kPQ1epIFmlIpejzbDdl6nyCQtZCJ?=
 =?us-ascii?Q?krzom/oz9ASeMHQhU6gaHcIDsqAaRN9sA5X4fEjqnIV5XuyYvbPeMDrRZFKf?=
 =?us-ascii?Q?tsjFfq4CKZnqfl/KBIeQXJZemA0GUI/3mpvJt0fit1g2lW/6EOrlV4jhmEhV?=
 =?us-ascii?Q?NScXtpFmarkrxZ9nCtLMsVzMqkWKPyohyGGdRqAWMehqc7qw5PYKndJg7UKQ?=
 =?us-ascii?Q?t0gVl8XbEe/hQ8aumZDvsIBrxsnld7Z1xOW05BVq2rAS42G00gf/H+qL7heJ?=
 =?us-ascii?Q?W3deMzRghn4y9LGjcJe/Pe4Nx47KBi5hb9lkr42LDyNKzUSezPFcRJHoRiTH?=
 =?us-ascii?Q?25iOswEz68bhKkJe1ou8c+0Bv6dfc7UZ/DALag+HTaDZFTul/cQ+dm4Ib67B?=
 =?us-ascii?Q?FUI/rwDh/3pZfMaKdsKIGDgI4TaGMTeEzRK1BEPNDrMHhOYrq/lJzShDLals?=
 =?us-ascii?Q?K7yA80qQxAAtw8/tyTThfE+jSkpuzW27dmR186L4lRpuQwWkY+CMVDPiWVNF?=
 =?us-ascii?Q?pSh5lnkZ7zJuJsfzDxw9PlctbNc/rZ4/MoGeBe4qyZ68fWRvmbdWPRDYd4a0?=
 =?us-ascii?Q?CwFhPCBJShriGW0nDZqYqfeB+BkhrGoB1PUWQtIEgKf9EEJX4/rPTwzwmEcV?=
 =?us-ascii?Q?xdi3mj0ebwv0xPsYk8hWqFj/pl6MwXZuT53mwb+aEIuixwwrsb3hg2cUoP7r?=
 =?us-ascii?Q?pOwSyS1EBTF2DqWzVnhD3xhi0ZtCow3xxej1dqwYxtt/SLgsa8vAuMxhqVHc?=
 =?us-ascii?Q?c0/ErIBN+isxBQyI7B+tSUbBXev+SBv9DPCliUkEQT5rNf3qr6yu/Ac9XuX4?=
 =?us-ascii?Q?X2FVhpMneuISkeCvfteCVHH0JWoK5r5CpUF7fwMKz6kAvJM6VNwuLJ5FzQCu?=
 =?us-ascii?Q?EkJiU3FwfZM7GfLeScWT1MffiztcLJGhpt1zZiasYL5cWGXAG7HZtpuHuwGa?=
 =?us-ascii?Q?xupanq1U0pbZ9tPA7pHKVAo08yVq6k+89uJXgGtix35FNij2LCl0pzlT7RTM?=
 =?us-ascii?Q?ht6bXQKwU/fDKYBhv+Uma0pqkppmv9bGTeRRdKo3xa6WdNSimLD8aalra1JU?=
 =?us-ascii?Q?VzlGJtP565mpBRcvMg3eXVgnU9Q8IairLs+mQAUhKLaB8I5Q+q7e2ldV7vSb?=
 =?us-ascii?Q?YJ0/Q9xKCPMCMcP9bm7vA3dHx/kRaCS1WWjO/oRTHqoLaflUq82ghbVg1Oyk?=
 =?us-ascii?Q?XEPGXOufyZhGWCfiB/D3bL4FWc5gOxDZ++P8s7BEvnsACwrh6OI2hl0zm/ZY?=
 =?us-ascii?Q?/DfdNQJpFQH75iHKZUHUhlaytSh52P0j2JMa3p3wXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uBx8gjcKR1B80gn54uBhxnqCyUX7azlFpBlpZ4O1J83mDTRivn7L+ig+r4su?=
 =?us-ascii?Q?cif9C/zIzH/hCoEVz40gzzIq2LI1vEn58HnVSGkcWWgQ3y8UbH8OzP5jY2aR?=
 =?us-ascii?Q?+9FuXmC06GjLmyjvJqNPFMvIx8DRuGVcj2cB8u94l2WDKb33VKxpBPp5ML6d?=
 =?us-ascii?Q?WkRMvi219Jiqd2tIc5lgNfA4OSiYQdlwKAHStOYwQwRmCP7zoIWdPahkCBp9?=
 =?us-ascii?Q?tO+LTV5v9GXcHsadvcj/G62Q5XBTKPKyxm+pbkyf6GbZBmTfst5ZSPYHV7dp?=
 =?us-ascii?Q?V6PvF9EKYeB6GBG8F01qGyhulV2D98iVVLWz79BxTkl8QnG3fuJqjxeivFbN?=
 =?us-ascii?Q?TPWT//WvgLbat6K2lEqaOt1pYyZk0zYRfFpg7gF294MzNI/wfK/+UdEf2N5n?=
 =?us-ascii?Q?h0yM1npDdbFtPTvEleLULRv9FGN+PPvUMJN34y+Qg5FtEf54lXqRdWfbkgc6?=
 =?us-ascii?Q?2GkVYwh+BvXW2vjTwICQLaDKBhHduVSiDdTy9fp13x3xPYOJTMvXZqG2Dw6g?=
 =?us-ascii?Q?9HyHMrG2jw8SLiGMN94BDmchyASblnrh1JMSKDX7wMRdn7peesZeGoUnB0re?=
 =?us-ascii?Q?4toUIgo81ku+y1iQ71gTLXTf7vP5yWqeE+d1rwN+VedKyn5FG6B4x66wR9OL?=
 =?us-ascii?Q?YPShUauTkjhYwVDzByWyJXQNamy1VV59+rct8LyAqoL19m4mSzH65dFTXFxC?=
 =?us-ascii?Q?rUoohkfQX5T9W8xf141GN9CDdDfeHfXykSFtTlG/L1njT1OUWmCTM6jjtnQW?=
 =?us-ascii?Q?QeqDpvqaGnnIDR5GT2x/xp/wxy/g3YZx17v+arXigCYPpteSEzDK28kzf5ta?=
 =?us-ascii?Q?50/svN2tvDhkwe8bKQ5EifzAXqeoVYhrjpQISaGAeHJ/lybkEbv1sTa6sYAo?=
 =?us-ascii?Q?9rAkfG7nTc0nQhRmuMsl39pGFJWGzPEqFosDxU7xKpx8pmzb3Dy474DxVJhd?=
 =?us-ascii?Q?377Hog1xRKoBMNhv3JWk5h21+cd2ZxidgghlgOVzphNf/oTqJ97P3WVXwLk3?=
 =?us-ascii?Q?9ckF3LdoXoIAPhH03nfYWmnoHotXpZ4nh7SxrDQtry5FS8Jzj2HyQS0UIG0R?=
 =?us-ascii?Q?lqDVCxE5lARRzZXbKA2phc05oMqW0DrpuWB0FcJJNzncyJcUj10BrGO19JdR?=
 =?us-ascii?Q?B7cpmMgMrMbwmsDNn6kh2PoA3A4HpqzSMlKUP9IJquVLhc8I4aC76wsEaQfM?=
 =?us-ascii?Q?QFPLlesRC3mwvsKYYv57lzGqKrIOeMn+6RI9YSjVr5rzUO2u8OLu8K5yQSuI?=
 =?us-ascii?Q?z3P07OM0jNIwVfTSs+qFbzKXRDd/IcLOq5n4+vEvOJU+jnZOVglVnrBb8ePu?=
 =?us-ascii?Q?LWSGaJvIRpqbjjkp9+byx3B2bE7ofZ4YhgKksK4vmNaJN+dFZ3W5MZC9ilDX?=
 =?us-ascii?Q?TnVVrRTKRvhaSDP9SiuwyXD9u4b6n1/kfAhiGBCqpdKZHdM0u2daGHi6TCwz?=
 =?us-ascii?Q?FxqbZCSlvuQrri4xjPVQeG+lq/4e6B5RfvdZMyG7a/5ZR7FNiNB4bQQ+iKVi?=
 =?us-ascii?Q?1hNzWxsoXede3tYTqM1bNa3rTPWRK3PHyJrVHebEaDYSTkhqK4UZ91xsQqbH?=
 =?us-ascii?Q?vNmFRt7EfNBLrOauW1QftfSHEkCoo0xnQSShQANs?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f140aa-a24b-479d-03e7-08dc6d9ad7fe
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 07:04:59.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl46fD6d791bNrPLzUHln5nmKdjTgYa/fAh1By2Jl7OO/g6AtRsYKzsTXknqZ+6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2490

On Sun, May 05, 2024 at 07:54:36PM +0200, Simon Holesch wrote:
> On Sun May 5, 2024 at 5:31 PM CEST, Hongren Zheng wrote:
> > On Sun, Dec 17, 2023 at 08:30:40PM +0100, Simon Holesch wrote:
> > > Skip submitting URBs, when identical requests were already sent in
> > > tweak_special_requests(). Instead call the completion handler directly
> > > to return the result of the URB.
> >
> > Reproduced the behavior and this patch fixed the bahavior
> 
> Thank you for testing.
> 
> > > @@ -468,6 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
> > >  	int support_sg = 1;
> > >  	int np = 0;
> > >  	int ret, i;
> > > +	int is_tweaked;
> > >  
> > >  	if (pipe == -1)
> > >  		return;
> > > @@ -580,8 +590,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
> > >  		priv->urbs[i]->pipe = pipe;
> > >  		priv->urbs[i]->complete = stub_complete;
> > >  
> > > -		/* no need to submit an intercepted request, but harmless? */
> > > -		tweak_special_requests(priv->urbs[i]);
> > > +		is_tweaked = tweak_special_requests(priv->urbs[i]);
> >
> > One question though, if there are mutiple urbs and one of them is
> > SET CONFIGURATION, then all of them would not be submitted,
> > as is_tweaked is a *global* flag instead of a per-urb flag.
> >
> > Now it is assumed that when the urb is SET CONFIGURATION then
> > num_urbs is 1. I assume it just happens to be the case and I do
> > not know if it holds for all scenario.
> 
> To be honest, I didn't fully understand the num_urbs > 1 case. I assumed
> this is for drivers not supporting SG and a long URB is just broken up
> into multiple ones.

I misunderstood that code path. It is indeed multiple URBs for
one PDU when the host controller for the physical device does not support SG.
And one global is_tweaked flag is enough. I think adding a comment here
would make it easier to understand.

Reviewed-By: Hongren Zheng <i@zenithal.me>
Tested-By: Hongren Zheng <i@zenithal.me>

