Return-Path: <linux-kernel+bounces-378170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559EE9ACC40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167E62838E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531A21BE23F;
	Wed, 23 Oct 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB4bG99o"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128919885B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693687; cv=none; b=A3+Tcuj2sJUUGa0YSdlR3tOldJTld5jX9/9Jf2IUVbf7y/HQus2rTR5eTAfCXbw9WYuOcgQWFiFdygTQPMtCOjgz+L+nqB3ISxuIdfsFMSPIfsKNIw6zJ82+xKEJIrP93/yvUlgSCdgJzX+YKphYHgr+kmq60nNK01tF4hvbyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693687; c=relaxed/simple;
	bh=yrAxnzfknBgMppGtpKTsAjcLTLbxxXTW3XoIElKDTgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZWwEOjI/OuMWPta6y4Fw2fg+MDxF8FxU+tKlg787gVv0HyB1PgkEwDj8egq/rzNhPHbBUMue+q5R7Ttf3/ru2XdO2iUNlNvbOLuhgJC4/j4+1fWIOZFKBytGZ7s5F4TjMnoemYtNMkqYKgwfSFzQyPUiUheLtW3jystthPvGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB4bG99o; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so7928240a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729693684; x=1730298484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFxqYQ9NsQiv3PG8Bo3GxdMXwLMnbnXOuR0+p/D4usc=;
        b=HB4bG99oYWrLiIlOmw+DMlBcSVbrtNZVaIs02h4Z4CXdYxlrQbRvv1ZXwABEbQZ0tg
         2IJRNb9o96nS+sdm/LsF41sZBGOYcYkJ9gBZCJdf5k1PN+tPgjA90zq5ys9OtH8eVFXe
         A7c9uGIblPN6FvslK1g+BNdYBKLxwTkm+JoRwSRJgiaqNhHm90U0SnOIIKbTzCSmUl97
         WoRQglisNxTW3QYdHPWGrCEMy4M5r9GI6ISXU24I0r2IO6iwJL0+SD6FmI67XEpAYqUw
         qw/o1/RzysillBRFLnjC6pkp6/jNUpcuyTVVDBNBVHxW3PINHms+nTjoiGvFmvoj9WA6
         CRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693684; x=1730298484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFxqYQ9NsQiv3PG8Bo3GxdMXwLMnbnXOuR0+p/D4usc=;
        b=g+0cJmBS6ku6C5O33vJp+/XZ6De/Bb/Tmcl+9a7lzACvDUfkgpTPDUqERO6VS6rQAI
         4TxZmsDMPD8QVBkGYOYDXBc4xwwpqk11o7PMOEC/4d+b3LIJIaoTvYcuqaedsPrWZ02y
         CtNlh6qGqxqOiejZPxlr0MH5OpHsXPNEzMil4vHDs4QrgzUswP52vqYKCaAlRQ6ht8k2
         Ti0NJ0VnemWm8A4D4S/hAku2h4ldHzqqq0hkDKQ6LQD7CvoHVuu3z3uuBTI52PsBBIFi
         U6zMOCmZz+cg3VWS1hA/nj45bpNKUgFmFUJbUqWoWfOXaoPxTwD88kC3Y4s5E4eX34wu
         abTg==
X-Forwarded-Encrypted: i=1; AJvYcCUFme8rJp2IY0QrhH3eSrzdWiUu4V8LThPiCIBZ+mOs+OU29llq6BZSxesT6EYUxsoUiLDuqoR5S7/kKJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOXuFS1xOq/CEdoq+6pSR9eLppV6mMwXEKwJFAvdoiX6er6OE
	V9aRJUDjIVe7g1rI/oGy95BF1Fot206Vm5zhaP5e3SW4zP9ganZEIzpfXgYjrjxLyfqj1uV8DHt
	2ZSAWicsGGbPbdOzGO3iKjLLQo54=
X-Google-Smtp-Source: AGHT+IEBPl/HuAo9d6O+WGv7AEOD6uPENeoFcAoj4O8lJRqglroe4iik5OrlaQMPxI+Vq96eES5JI8u70LFIkAzLQGY=
X-Received: by 2002:a05:6402:26c9:b0:5ca:efb:b87d with SMTP id
 4fb4d7f45d1cf-5cb8ace82fcmr2301454a12.15.1729693684155; Wed, 23 Oct 2024
 07:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082926.20647-1-quic_pintu@quicinc.com> <CAJuCfpE+LSd7hogwGnLMT5y831unLjCpS3DpOASgphDFxDjGJw@mail.gmail.com>
In-Reply-To: <CAJuCfpE+LSd7hogwGnLMT5y831unLjCpS3DpOASgphDFxDjGJw@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Wed, 23 Oct 2024 19:57:51 +0530
Message-ID: <CAOuPNLjm2_Hg69pVY7fb9wqc-6mpys3P67wUF4Vz3+H77x3t_g@mail.gmail.com>
Subject: Re: [PATCH v5] sched/psi: fix memory barrier without comment warnings
To: Suren Baghdasaryan <surenb@google.com>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org, peterz@infradead.org, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, christophe.jaillet@wanadoo.fr, 
	linux-kernel@vger.kernel.org, joe@perches.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 15 Oct 2024 at 02:36, Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Sun, Oct 6, 2024 at 1:29=E2=80=AFAM Pintu Kumar <quic_pintu@quicinc.co=
m> wrote:
> >
> > These warnings were reported by checkpatch.
> > Fix them with minor changes.
> > No functional changes.
> >
> > WARNING: memory barrier without comment
> > +       t =3D smp_load_acquire(trigger_ptr);
> >
> > WARNING: memory barrier without comment
> > +       smp_store_release(&seq->private, new);
> >
> > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
>

Any further comment on this ?

