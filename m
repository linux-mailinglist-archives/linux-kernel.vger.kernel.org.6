Return-Path: <linux-kernel+bounces-433180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B549E54D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791E42813E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199E9217703;
	Thu,  5 Dec 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUh2uQay"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF8214A6A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400076; cv=none; b=ovlQkbXXj525DSe7xv0D+EFGiw+rDm0rHucSJqLSUU+X53G4/OOL6Q26T8Y9FmCUcsJ8su+04uPjus21kQxDvggN7yTIYtqaBBQ69uBamkN8INOZZhJFffannFaGLpJtjUi7JiCVhX/4NK2d7Nz8K52UHfF59mHPPzqxxlHvcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400076; c=relaxed/simple;
	bh=igHuV65PfChlvayLhiUqy9lj35SM6XPHNIT3m7rfZik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHEqFq4X1guQQeapM5KQywm17+9Js1q+ucRARWbTWqAPHLlibqefTBsf5ISPffboseb68ipDZBE/j5NLJU5rhx0Gb+DS1deJLLs4gMJBsqlnmLEITMnc0kpdJEAjD4ojkEgJA4SP6hJA+jpTR7cQuXveyCh31j5oFOe29fDOOvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aUh2uQay; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffb3cbcbe4so7945901fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733400073; x=1734004873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9iuiYMyHL0ZujcME1Pq8WGSxJnCLdbW4+uP4na3Cm0=;
        b=aUh2uQays9R1KX3swFiIp+efFyuLMk3U3THp742IsxbnESuQdWPE4N+fj0rdwIaWCX
         FvSIddYGq4aT3mBCDh6OYdPmBxfeIp1KLdDsB15yhfxYBBdBXbqGg7cOSDUcYkXuILKT
         i/utp7FHKoINwVUuiKMy0cQ2R1OawTYy5jaK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733400073; x=1734004873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9iuiYMyHL0ZujcME1Pq8WGSxJnCLdbW4+uP4na3Cm0=;
        b=pYctmqPDqpVjx/fgMU0ZXYG3KqQVnKIJ4vOV7bsKxGfBfN/hfe6zcvc16kGZq5UVWv
         dg3zg5GOAEOBxytSQ8om7SyuSludnhxrXjtPRECaRYAW8rUdLLnMLe8UcIWPr1oJi2SB
         wQNAEAoYle5vfWYMt28UPHmI7C1ppNByyru9L4dK6zT26cTlzfRhFyzh/XZJFYDs5IWd
         Lguict/6thPE+xxgvKj35Hj328tFbeIO0uF8I7CstU3kUuw0EYUlw9sWVioaC9/4BCGd
         H+FX8dNe4aPiSGKrSnMnhvePJg1Curw7ld6bXCjUVOmPS/m1X27OHZRbFyYNkkbQOmTK
         YJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUV4wmX6MTpVrGfp5diJsSHhyh1wDWBd0GvPJxzg8AlOeabJvm54ADXX/xVT2sN12kFLKQ29G8Qal2j6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ilJ+fAKX+E60zVICPsatkwspyrF409o55KfwYGAlR1fnSBcU
	pSdYbeBjlAXwW32lcsfbFyUm6pBBruWhhTGJ3CP1h56ZjLwnr6chJkUfmla3J2AiBS+Zk22zNOG
	nwTuSfNhwpCAHM2mpkEtWGrxO5taqL4RMVWvU
X-Gm-Gg: ASbGncuwXzffydOrpK2+oQEkgw4JF9eXe4S4FZEjjVOlcOW+E3eVptFfq4gc4GHpIlM
	FEg7cTkeea5/vxoqIY8VyhopxFnpfYdw=
X-Google-Smtp-Source: AGHT+IFqxE8e3rYM9AzwaPlgzzOUZ14+ItrMjjXrcdlxT+YFbFu9+Xx3xTisN69RKnuerQioeLH7SVvHjRsOGYMz5kA=
X-Received: by 2002:a2e:7a10:0:b0:300:1373:f16c with SMTP id
 38308e7fff4ca-3001374012amr41186281fa.7.1733400072710; Thu, 05 Dec 2024
 04:01:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113193239.2113577-1-dualli@chromium.org> <20241113193239.2113577-3-dualli@chromium.org>
 <20241204183550.6e9d703f@kernel.org>
In-Reply-To: <20241204183550.6e9d703f@kernel.org>
From: Li Li <dualli@chromium.org>
Date: Thu, 5 Dec 2024 04:01:01 -0800
Message-ID: <CANBPYPgzGKfu-P8dH9tdgdNPAGz1TMcmQVbJF2XFhaX0W6ig-g@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/2] binder: report txn errors via generic netlink
To: Jakub Kicinski <kuba@kernel.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com, 
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com, 
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org, 
	cmllamas@google.com, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 6:35=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 13 Nov 2024 11:32:39 -0800 Li Li wrote:
> > +     struct binder_proc *proc;
> > +
> > +     if (flags !=3D (flags & (BINDER_GENL_FLAG_OVERRIDE
> > +                     | BINDER_GENL_FLAG_FAILED
> > +                     | BINDER_GENL_FLAG_DELAYED
> > +                     | BINDER_GENL_FLAG_SPAM))) {
> > +             pr_err("Invalid binder report flags: %u\n", flags);
> > +             return -EINVAL;
>
> no need, netlink already checks that only bits from the flags are used:

Ah, yes, let me remove this redundant check.

>
>                                     vvvvvvvvvvvvvvvvvvvvvvvvvvvvv
> +       [BINDER_GENL_A_CMD_FLAGS] =3D NLA_POLICY_MASK(NLA_U32, 0xf),
>

> > +     payload =3D nla_total_size(strlen(context->name) + 1) +
> > +               nla_total_size(sizeof(u32)) * (BINDER_GENL_A_REPORT_MAX=
 - 1);
> > +     skb =3D genlmsg_new(payload + GENL_HDRLEN, GFP_KERNEL);
>
>  genlmsg_new() adds the GENL_HDRLEN already
>

Yes, genlmsg_new calls genlmsg_msg_size to include GENL_HDRLEN already.
I'll just use NLMSG_DEFAULT_SIZE as suggested below.

> > +     payload =3D nla_total_size(sizeof(pid)) + nla_total_size(sizeof(f=
lags));
> > +     skb =3D genlmsg_new(payload + GENL_HDRLEN, GFP_KERNEL);
> > +     if (!skb) {
> > +             pr_err("Failed to alloc binder genl reply message\n");
> > +             return -ENOMEM;
>
> no need for error messages on allocation failures, kernel will print an
> OOM report
>

Will remove this unnecessary pr_err.

> > +     }
> > +
> > +     hdr =3D genlmsg_iput(skb, info);
> > +     if (!hdr)
> > +             goto free_skb;
> > +
> > +     if (nla_put_string(skb, BINDER_GENL_A_CMD_CONTEXT, context->name)=
 ||
>
> Have you counted strlen(context->name) to payload?
> TBH for small messages counting payload size is probably an overkill,
> you can use NLMSG_GOODSIZE as the size of the skb.
>

Yes, the message is known to be small. I'll use GENLMSG_DEFAULT_SIZE instea=
d.

> > +         nla_put_u32(skb, BINDER_GENL_A_CMD_PID, pid) ||
> > +         nla_put_u32(skb, BINDER_GENL_A_CMD_FLAGS, flags))
> > +             goto cancel_skb;
> > +
> > +     genlmsg_end(skb, hdr);
> > +
> > +     if (genlmsg_reply(skb, info)) {
> > +             pr_err("Failed to send binder genl reply message\n");
> > +             return -EFAULT;
> > +     }
> > +
> > +     if (!context->report_portid)
> > +             context->report_portid =3D portid;
>
> Is there any locking required?

A lock isn't necessary here. The system administration process always runs
before any other user apps. Even though this is not true, the design is to
allow the first process to claim this netlink. Having a lock doesn't help
in any case.

>
> > +     return 0;
> > +
> > +cancel_skb:
> > +     pr_err("Failed to add reply attributes to binder genl message\n")=
;
> > +     genlmsg_cancel(skb, hdr);
> > +free_skb:
> > +     pr_err("Free binder genl reply message on error\n");
> > +     nlmsg_free(skb);
> > +     return -EMSGSIZE;
> > +}
>

