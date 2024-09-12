Return-Path: <linux-kernel+bounces-327248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4039772D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746A01F24B31
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D31C1AB5;
	Thu, 12 Sep 2024 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFlx9HxJ"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4B1BFE12
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173844; cv=none; b=nESi8tiRPQu3XDgBHSmobssYlSmxCqO1Yv+tRBdFh6/3U/gWg/7QisauoUVwljCaQ5U7bpHOEORWI/IAwoO/qHKXxWZQ9LvAhrQYGd7f717WKZSz04/C86zi+e4/gBLHRD+zrTVR63fli/EGDXVkZTqqbLMTeTbV8HT924ohIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173844; c=relaxed/simple;
	bh=POeMZyrSzWfT0c/EFYH4aVeVC1H3dWbv5VrEhXmoxgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3SK1vHrLXssgmGg8etp2uBM/Ni3cKcOQhKSEAXsAMVYfgM6dWWoCwG+wM23JCb+ZF76xXxgA9x6xaDEanjVe1pr1ROKWe/MvsoQsFryNjHQKOO3VgbVMEtYa366vAXWeGdJAfKDhbFq35O2u8vRpgykbpLuXs8ZFAFvQ0jO6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFlx9HxJ; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-49bc44e52d0so513926137.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726173841; x=1726778641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DjwiIxMiUHr1M6b4I5f9AEu55zXyA3J0twzo/v710c=;
        b=wFlx9HxJS6WhEJjtnpyuDRH6cxGr+0GWzT35/x2kDdCv9W2k4A7/T3uzsAHFgjNkQ+
         TdAEI9ebLq91wjS8R2Ot8kKSRmHf93bwVmU/KoLBDP4Q5x72t/Z51T9rLT7wn9DueLSU
         D0hGu/BRwlcdn6CMokng56PFRoSakH9BmsO2Ik9R4WabwzyEGdC/a4hOlCZJcxKpVih4
         EPIJcTzVkUqF7+WFPr5icBgxt7mDRWTcFX6m/Jc3xAoBb6lfVA5TD+1w89bqIZGEY+CE
         ljHVZpjgLB9UnclbR2aCe0r9k7cKmWV6f2slht/jUIRBOgtvkYeHP441A3ht5vSoAaK6
         ykmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726173841; x=1726778641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DjwiIxMiUHr1M6b4I5f9AEu55zXyA3J0twzo/v710c=;
        b=AeLhVv4y8ydNvzdvWLKrs6xQC2aKn4Ar7eoln43ARPbYp+9g5OPBC20TPJW6gPNTIk
         JNaFaWgP3hoIw5ov04EgQ1F64WpuEmr7hGxxQiN5IZsfLsbkSRBB8VCsYXr0Sn5T8wzY
         vTet2evLCMcT9mgpV+fTkM3hbOX0Ye55Yoj5VoxatTCyitX9XFk2ACrngYHLS1g2lknQ
         lRHeEOhl00jEQreHr73aEC7Fxw4nhMUVZ32Mh37EjWakYo1c8D2axw5HWS817hYUUvT1
         6wU1UFhSvEIgD1VxLuXi7Z3i468RSd+SKS75IvtPafgDiuZ7fJjSHM8c/S316S9BgtJy
         hZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKEGS0ikJxue7+M+fcDhyb5s9j3kEiHo0Miw05MghBKFOOYUbgoQPUIeIaN9y36sNBNrT/G2hVaSSbqz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSkxoaxXd38FmJhB2MNdIT8DuvRYqtaeHuTT1mMS3zNS9pFDHN
	f5stmNV7X4ixlq3WqOenKe2/zdxbpq9ZUZY4S2oIdQ9c533dfqTRvQh5tRY0+3R6jL49yU4GYy5
	cxOoM743aIszztfI59Hm0NmnCux/JhB9gqdK6
X-Google-Smtp-Source: AGHT+IHCLGoDTbD9LAUphE9SPUrx3KUcIqiqyoGvbi+stviqZGZ5BDOXy0oCRC9AnOS0a9EEOZIMy5Ntm4L7cGK4dJE=
X-Received: by 2002:a05:6102:a48:b0:49b:e7d7:3e1b with SMTP id
 ada2fe7eead31-49d41468125mr4919245137.3.1726173840757; Thu, 12 Sep 2024
 13:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com>
 <20240910093751.GA572255@kernel.org>
In-Reply-To: <20240910093751.GA572255@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Sep 2024 13:43:49 -0700
Message-ID: <CAFhGd8qQ_e_rh1xQqAnaAZmA7R+ftRGjprxGp+njoqg_FGMCSw@mail.gmail.com>
Subject: Re: [PATCH] caif: replace deprecated strncpy with strscpy_pad
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 2:37=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Sep 09, 2024 at 04:39:28PM -0700, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings [=
1] and
> > as such we should prefer more robust and less ambiguous string interfac=
es.
> >
> > Towards the goal of [2], replace strncpy() with an alternative that
> > guarantees NUL-termination and NUL-padding for the destination buffer.
>
> Hi Justin,
>
> I am curious to know why the _pad variant was chosen.

I chose the _pad variant as it matches the behavior of strncpy in this
context, ensuring minimal functional change. I think the point you're
trying to get at is that the net_device should be zero allocated to
begin with -- rendering all thus NUL-padding superfluous. I have some
questions out of curiosity: 1) do all control paths leading here
zero-allocate the net_device struct? and 2) does it matter that this
private data be NUL-padded (I assume not).

With all that being said, I'd be happy to send a v2 using the regular
strscpy variant if needed.

>
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90 [2]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  net/caif/chnl_net.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
> > index 47901bd4def1..ff37dceefa26 100644
> > --- a/net/caif/chnl_net.c
> > +++ b/net/caif/chnl_net.c
> > @@ -347,7 +347,7 @@ static int chnl_net_init(struct net_device *dev)
> >       struct chnl_net *priv;
> >       ASSERT_RTNL();
> >       priv =3D netdev_priv(dev);
> > -     strncpy(priv->name, dev->name, sizeof(priv->name));
> > +     strscpy_pad(priv->name, dev->name);
> >       INIT_LIST_HEAD(&priv->list_field);
> >       return 0;
> >  }
> >
> > ---
> > base-commit: bc83b4d1f08695e85e85d36f7b803da58010161d
> > change-id: 20240909-strncpy-net-caif-chnl_net-c-a505e955e697
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
> >

I appreciate the review.

Thanks
Justin

