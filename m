Return-Path: <linux-kernel+bounces-575745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30A6A706B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067963A80F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8518425B682;
	Tue, 25 Mar 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZxPIbZV"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEED25B68D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919840; cv=none; b=slVzw5Np3j+V7IDRxyKdz6fbLftF2lWqp2RvS13KlmYUd9+kTP1xyYVeXrPG5iCpaWgA0UzKS8x+UCKWlFjOav74jo845K+K/6zKi7Wcdam1cWJuEkxABcQP6/S+UbT5xH7OYpaV+K0tdt2bnQmgQTDND6jqWEZ4vEZrAgy2CVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919840; c=relaxed/simple;
	bh=1oQMgY87+HXoIhnvNr1OgsTQ1uKlztmUhKClc5Srgk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9P6hhLgEYn6secz5fYUpPRMRtAOHq6oSS55msDugM83pjtcw0/Xox+fkyC72AbzaOCi/bmbQrID8e7GauBSWbeOCbEu6H0+yobHZPvuskiPCHHjX/chVzNkUImVmRvgjO3CBkjcKELJypGnKSAyi7BpbxQ1OUecRZxg3f+iBiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZxPIbZV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ff4faf858cso43826677b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742919837; x=1743524637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tvajp1z7h7S0xpIBdVLXi2Xx6HMtp2pRa+CQIj7GVM=;
        b=MZxPIbZVu+7x3Alyv5Yyu8TdlvzDcxg0KQYlHm1T7SduhvOmZiR+BxfxFGjNieKgUP
         BRgzrsfy3yGD3tWYiDUabh64UV1R323nqfDa0VFkUnuamSOpFVIfNgfRIEQv+D+4KSOv
         souykij4bXTVBfInHQ28m7yBB5SiL8ADG8RSVZ86zA4za2gmuDs7tV5sIajtYOyaXl7r
         EBIWaXEGSYEY9JyteaAM6qb9lTjiHQqWccrZd5VdzIlHLdP/BW0AfnANs2CQF1pRtLK1
         VBs3wBx29xrZeKTlbD+dHqhkpJ1crDmUqt+VCe/Nv5XHl32est5ogY+szQMpOpR2L0vM
         HGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742919837; x=1743524637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tvajp1z7h7S0xpIBdVLXi2Xx6HMtp2pRa+CQIj7GVM=;
        b=pxrGkfPe0xqBzqdqGrjliMET68rBCDUC9QL0kpB2TP9MH8gixfWwWKEifrZibUjP4x
         69s0Gk6YhiTRWij2OshMqLcOiJXjMjTS/GXXWzlPxg5Vyen5x/0HeQtu/jCEeSZya9RZ
         MnrGbsNhNfbJjonQsTmdxptuhYOg4tJKRZnmoUxW4niAtuyLvWCAe5MfbKEVDA34x+ty
         kxmUoe7FTb62YFufBv4+WGSmMBdeDrr8TCd2yAAuhFisrKGcWVIRWNgq8593VjhpHeFd
         NVyb4plpK+cX5EQFJ6h+AlGZL89BRmrOYQtUR6ibec6mdu+VnCjTHxByjof2VXO5vRee
         8jPw==
X-Gm-Message-State: AOJu0YyljZpoDJp3MZNl2x4bV3anVGfNk+aEkwvwbE0dEfcPPM91MYri
	Ll+EzrdSVl5XfE50FM1YOMcjPx847IXW3cobuaDybjauHPHiG+7se8MJH62sq6jS72oofhg0SIC
	OZwpbmOk+1i/cWoIL1YicdfuOtpI=
X-Gm-Gg: ASbGncvzG6DMwCwNp3rGVE0e1KHj28gxE50bgBy3nzWxJNasHoC0i2aODQdz7uFZ7eR
	l9LQoAWaSZQpHrXqEV1esvTcwkySR0FJoQ4DCYgjsD6ZFSEFQqaE8Ac9mkzqQntaWgVy1vAGI8X
	7dcAOVx9/RNDHIgvxgh1lo8fKI
X-Google-Smtp-Source: AGHT+IHvdSe6ls10wjFf5bZyI+Qsy8fQwauViiWeGwoJ0PgaQ5nRuZQauZvKQvLsCsA2s5Sf9UtaUnq1uwtCBzUkiGs=
X-Received: by 2002:a05:690c:3708:b0:6f9:afa2:acbd with SMTP id
 00721157ae682-700bad18b66mr239831077b3.38.1742919837042; Tue, 25 Mar 2025
 09:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320185238.447458-1-jim.cromie@gmail.com> <20250320185238.447458-30-jim.cromie@gmail.com>
 <05dff3c7-91e8-4d42-b75a-90c410d6470d@bootlin.com>
In-Reply-To: <05dff3c7-91e8-4d42-b75a-90c410d6470d@bootlin.com>
From: jim.cromie@gmail.com
Date: Tue, 25 Mar 2025 10:23:30 -0600
X-Gm-Features: AQ5f1JqQLsquNqtoxYfgRolUJVYd3SVfRGVGDiVPUxl9S4QdlGwEvycISFycUMY
Message-ID: <CAJfuBxyHzkNOrjsKQ5TmBX8UOpJDKnxZr-t+eQ52Hfkq3BVC-Q@mail.gmail.com>
Subject: Re: [PATCH v2 29/59] dyndbg: change __dynamic_func_call_cls* macros
 into expressions
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-gfx-trybot@lists.freedesktop.org, 
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:19=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 20/03/2025 =C3=A0 19:52, Jim Cromie a =C3=A9crit :
> > The Xe driver's XE_IOCTL_DBG macro calls drm_dbg() from inside an if
> > (expression).  This breaks when CONFIG_DRM_USE_DYNAMIC_DEBUG=3Dy becaus=
e
> > the invoked macro has a do-while-0 wrapper.
> >
> >     if (cond && (drm_dbg("expr-form"),1)) {
> >        ... do some more stuff
> >     }
> >
> > Fix for this usage by changing __dynamic_func_call_cls{,_no_desc}
> > macros into expressions, by replacing the do-while-0s with a ({ })
> > wrapper.  In the common usage, the trailing ';' converts the
> > expression into a statement.
> >
> >     drm_dbg("statement form");
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> > ---
> >   include/linux/dynamic_debug.h | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 8043966a0fd6..80bcaad03400 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -339,20 +339,20 @@ void __dynamic_ibdev_dbg(struct _ddebug *descript=
or,
> >    * (|_cls): adds in _DPRINT_CLASS_DFLT as needed
> >    * (|_no_desc):     former gets callsite descriptor as 1st arg (for p=
rdbgs)
> >    */
> > -#define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {        \
> > -     DEFINE_DYNAMIC_DEBUG_METADATA_CLS((id), cls, fmt);      \
> > +#define __dynamic_func_call_cls(id, cls, fmt, func, ...) ({  \
> > +     DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);        \
>
> Is it normal to remove the parenthesis around id? Or the other way
> around, why did you add parenthesis in PATCH 17?
>

heisen-thinking ?
noisy inputs ?
historically, checkpatch warnings on macros have given me difficulty
so I tend toward defense.
I think this one was a red-herring.

> >       if (DYNAMIC_DEBUG_BRANCH(id))                           \
> > -             func(&id, ##__VA_ARGS__);                       \
> > -} while (0)
> > +             func(&(id), ##__VA_ARGS__);                     \
> > +})
> >   #define __dynamic_func_call(id, fmt, func, ...)                      =
       \
> >       __dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,           \
> >                               func, ##__VA_ARGS__)
> >
> > -#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do { =
       \
> > +#define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) ({  \
> >       DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);                \
>
> I expect the same constraints around id here, both with parenthesis, or
> no parenthesis at all.
>

yes, inconsistent.

> >       if (DYNAMIC_DEBUG_BRANCH(id))                                   \
> >               func(__VA_ARGS__);                                      \
> > -} while (0)
> > +})
> >   #define __dynamic_func_call_no_desc(id, fmt, func, ...)              =
       \
> >       __dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,        \
> >                                       fmt, func, ##__VA_ARGS__)
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

