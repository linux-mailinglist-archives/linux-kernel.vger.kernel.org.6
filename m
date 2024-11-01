Return-Path: <linux-kernel+bounces-392675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4679B96ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB7F1F2245C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C95A1CEAAD;
	Fri,  1 Nov 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Bxfcj5jq"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C51C729E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483696; cv=none; b=o66RJBS4nCfZykx4KV0K3Gjl6TxX09Fx0X2Vak0f++sQaN5N10QF2KHaJb1ZqFOo5dk/QaPA71EM22faKatMBMZYb0aYb+Cz17m1I+x5fyzQtyjB08p7ZGrRzDj8MTyYY4m8+hfRWnVpf6gghxSH++CQ+Afai7ka3s3i/C7Q18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483696; c=relaxed/simple;
	bh=XuRVQd+uI/fEZIMs+isDw/LGu3FojnLyngs9SvWfAbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koVXulAguOeiIH6XiNOWjApWYB3/IL8RBd04W3cIEcsgzq83/75lg0ZT4+fislcZ/FXO9Hppc+JDtHLfIOHdLbzC1VYEX77ZUMpBQ8HLTl0GaXVp5cY6yiOBDY+DSIx2sk+BmlT5iLX3/yh/Pvl2vqpwP2v2bWfLjqaKoEg90T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Bxfcj5jq; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-855f2cf1ad4so105093241.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730483694; x=1731088494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuRVQd+uI/fEZIMs+isDw/LGu3FojnLyngs9SvWfAbQ=;
        b=Bxfcj5jqjhoXFeGMFLaVHza5iJgkjyIuJaeZS4e6KR8kIIJC5+IYXTH4u8gRR/xsPr
         bPIs7J3sDjrN2CqtoE0p8/nK6rLg84aZh1ADRhyY+RjMy07HNuflxG1aYvZIG+drH7Ui
         iNKwDWcxUQvc+jQatdYyP71a0pTtkKIh/6j+YCT3j8tWj2xxLvCLVVlCK1FWqTAkux9/
         Nmf+ch0FHo6+/2YxyztE2FRE0tII2Hr1Qge3KspYaLT363R/QbjmlunQbAHnMQsdLsQp
         DB9lE6KAMrT0OY/8Z4OUkJnMb1ETupOVag2lZxORLPGu6NG3xOIX+uGIqrUhK3WWSBy3
         Ju2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483694; x=1731088494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuRVQd+uI/fEZIMs+isDw/LGu3FojnLyngs9SvWfAbQ=;
        b=M0+etwlFjCBZ11Krd5M/gTrvUHAOhNwQO0AH3Ywwql273xRzGtgq0AW+S+ZNzfT2D6
         4cPzxl2PoTvc9j7uxzpAKlnMpGL3340Ry75ZVK9v+1yE6clKd3OFdUhRyqHVp8T1Q7zn
         BVBE/wdvl6VtcDunK96J6VrbuEKGtkBFIFNfT8N2QSIJKzJ+RZ3S90s8kZkndvKQDDsX
         9Aw/5U3mHq+t5EdSTMfo52NLt/4frKTtMQusZt1iIbP4cfFqtoXvXhuynH8V9cZ+kvva
         FNzeTtYeCaQU1E8CAQUp9uOrcs0dTWDK4YXt8CfXRPLxaBtu7yzG9JsSupDqbeOPQK9O
         F8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVyKbO32GHE45Lc7Zy1L/P8IxIL3upILu5Q1XUXkrrlUKK9qVmeJwUmHXl9PCNI5vHM8uKV76de85+k0zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7Ze56jZ4P3QBnihswzQjmu2V9GvYzVvc1yvRIQnrMmoh6Cl1
	ErQ7clLXndt4xTLD8rMZIHDrcR3lsIt1wuWo6/10EMW2+lbA95rMEPxaAhHWB110LVk/WIb8vnl
	4rd3IAHVC3ajm5lROzHyCtdAvD+XEwjiaxG77
X-Google-Smtp-Source: AGHT+IGsE4qjrOhlqC4OJb9cUFtYG/Io0uUOjSSRLwaJ/zVTvuHnCYeP5oQx993rVYYkkRD54yed9fa034djjSzDRQ4=
X-Received: by 2002:a05:6102:41a1:b0:4a3:ac2b:bfff with SMTP id
 ada2fe7eead31-4a962ef5a46mr4954235137.22.1730483693833; Fri, 01 Nov 2024
 10:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-3-casey@schaufler-ca.com>
 <68a956fa44249434dedf7d13cd949b35@paul-moore.com> <ZyQPfFvPD72rx4ME@calendula>
 <ZyQRgL_jWdvKgRl-@calendula> <dd727620-9823-4701-aaf1-080b03fb6ccd@schaufler-ca.com>
 <ZySCeoe3kVqKTyUh@calendula> <6a405591-40c5-4db6-bed5-8133a80b55f7@schaufler-ca.com>
 <CAHC9VhRZg5ODurJrXWbZ+DaAdEGVJYn9MhNi+bV0f4Di12P5xA@mail.gmail.com>
 <CAHC9VhQ+ig=GY1CeVGj1OrsyZtMAMBwst03b-oZ+eC2mLnqjNg@mail.gmail.com> <6fd788a9-b051-4c5e-8618-362a8632cb97@schaufler-ca.com>
In-Reply-To: <6fd788a9-b051-4c5e-8618-362a8632cb97@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 13:54:42 -0400
Message-ID: <CAHC9VhQA0L-H-9BPhXCFKMpgs4_Xk+fOip7L7s98wRK-UhS43A@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] LSM: Replace context+len with lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, mic@digikod.net, netdev@vger.kernel.org, 
	audit@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:59=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 11/1/2024 9:42 AM, Paul Moore wrote:
> > On Fri, Nov 1, 2024 at 12:35=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Fri, Nov 1, 2024 at 12:14=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >>> On 11/1/2024 12:25 AM, Pablo Neira Ayuso wrote:
> >>>> On Thu, Oct 31, 2024 at 04:58:13PM -0700, Casey Schaufler wrote:
> >>>>> On 10/31/2024 4:23 PM, Pablo Neira Ayuso wrote:
> >>>>>> On Fri, Nov 01, 2024 at 12:15:16AM +0100, Pablo Neira Ayuso wrote:
> >>>>>>> Hi Paul,
> >>>>>>>
> >>>>>>> This patch breaks nf_conntrack_netlink, Casey mentioned that he w=
ill
> >>>>>>> post another series.
> >>>>> I have a fix, it is pretty simple. How about I send a 6/5 patch for=
 it?
> >>>> No idea. I don't know what is the status of this series. I would
> >>>> suggest to repost a new series.
> >>> I will post v4 shortly. Thanks for the feedback.
> >> Please just post a fix against v2 using lsm/dev as a base.
> > That should have been "against *v3* using lsm/dev as a base".
> >
> > Also, since I didn't explicitly mention it, if I don't see a fix by
> > dinner time tonight (US East Coast), I'll revert this patchset, but
> > I'd like to avoid that if possible.
>
> I will have this as quickly as I can. The patch is easy, but the overhead
> may slow it down a bit. I should have it in time to avoid the revert.

It turns out there is no rush on this as it looks like the Rust
bindings are going to be the one that ends up pushing this out past
the next merge window as there is a conflict with changes to the Rust
LSM helpers in the VFS tree.

We still obviously need to the fix, so please keep going with the fix
based against v3; I'm going to move the v3 patchset from lsm/dev to
lsm/dev-staging, this will still allow for the usual LSM testing but
will shield it from linux-next.

--=20
paul-moore.com

