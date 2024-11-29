Return-Path: <linux-kernel+bounces-425987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF49DED6F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC78163C55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39B2189B8F;
	Fri, 29 Nov 2024 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwJ5CPcg"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155C155345
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921461; cv=none; b=O93bFgHzry+HcoE/73pSbMp7ScHJfIiDMByR4i+UiHnY2ygfnIMN8fXVyErdYl+aIStJ2XC0S3KHtxk6vtK/RO0FOGrCwflmmW61fdf3055UxQYFy1S7GuKayfg7QI0FEq/lz+v2MJ5F08PPfKfjnzby6LnUc4dT+Dt5ksUo83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921461; c=relaxed/simple;
	bh=seB6UW9IycuF54ukhdc4REUjoQdDXvWiy3Xguh/XgQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDriTLYeHoyMNncjR5+71Uk5Ehgl3rAeNiQdFWsmM6BxO0hrb+DviJAZB3+Mvo2NZfRnEwfmJwcdG6NfsMpFlV4Q1icPFdDbkq1vtdL+nJ0/47nvjZC5/wWzC1/pBPt0MMZWDgQURtCV2I88015duTaN11m1h+TTQBPpzBjjUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BwJ5CPcg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4668194603cso514151cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732921458; x=1733526258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKtB0RpLth2bOD0fClxdqB5Wa0QPOvEvW/KXc9ZWwkg=;
        b=BwJ5CPcgHbuP8ITpQT3AyhkOEbDGgHiOvs+mXASbQ+oYTYemdAXx9YmSM54qei9736
         /miAUdbSYoN8o4oHkXjcrwfXyTr312ENk6xbcrOuhsXUi4eLgCRjXwAiKEtz9z4iBMd7
         +QV5A4mVShcL/jlZLOi54TzoHZHqNXfgohK6HDUp94ETMR3R5GjxD2c89d/bHsOpezS0
         raWaIFQZbc/ulIxc77sVAzv0ILwOQlRZEx9GOJs0QcXTbmbDiT4SKmtY4Opx2UOf8Rnz
         JZcXF9MbF97g1bhjUjVK3PIt7ar5i+rsya2QCW8yHJeJgyAWU1yaAkYz1Hs94qJHNZmg
         DV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732921458; x=1733526258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKtB0RpLth2bOD0fClxdqB5Wa0QPOvEvW/KXc9ZWwkg=;
        b=XuSnf97migdXEVFTZlCocR92EbUAM/vsYgBQi3AxZs7aD5hEAbo+vSVFxwXnMle/Um
         aS94OvMGkvA0zkjkZKp+Htw5CmO1uQmK0HOjCRLrHfHd8yOixmePGyUb8o2zTlgDbvSh
         UOhqW2mgg8B3++1m4IkRqPfmeXFshg6rtzvrnhI6yOi4cyZKdk1D8mvKCxJ0MGp+d1M8
         WzSkkJgMMPnnT7LoZ+q1znLRtP6Ubi1Jz27WfHoWIfjmG7WKIdi/uPa0PNVzh/WNhhk4
         oQZpUvWoMV1jRv10/U3KLj3EgZr7zyZPpDJK2xSpbua9BBp1AmwAJcfPgZCb00k9pMxX
         TQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU48VxH1kTayC2m8BrZ3aDaNeVB0DMM0oweMlDgyLPP1EuOo5S4JqPRLXXbnisCF4GNiy5r+JilFkLPFQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyheJIh/5WNW23m8Yn7f4GTfO7+8F1sEmvAH9wRfVN6MA7RINS6
	gIJ5WL1youH5zjHCtxzPvupzdWk9ib2hwrTJ5XkfyI/fZU2uUE7bxZw/tjnhyi9ujaKpxLw1hFn
	iFZ0130uGKU6Jn5NHvAmAqXuSf0jKYpMrz3ho
X-Gm-Gg: ASbGncvg48//DoTUtv+8h1NPKXIcK8YBfjyvNypkODY3r3bNmdHV4cEXqJQg1lr3i/m
	cQFVpv74238cuzv2N/NKN5NhylVDYWqA=
X-Google-Smtp-Source: AGHT+IEYEA5Txnmt4qq8tmfYoV9AK7E2YOZYxkyrJMUQAr8mmBjceGkjSLy1+eAs7JBTAewoQrq0zMk5zP2FfpYoxcU=
X-Received: by 2002:a05:622a:5290:b0:466:7a06:2d03 with SMTP id
 d75a77b69052e-466c3ead1d1mr5403211cf.1.1732921458382; Fri, 29 Nov 2024
 15:04:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082926.20647-1-quic_pintu@quicinc.com>
 <CAJuCfpE+LSd7hogwGnLMT5y831unLjCpS3DpOASgphDFxDjGJw@mail.gmail.com>
 <CAOuPNLjm2_Hg69pVY7fb9wqc-6mpys3P67wUF4Vz3+H77x3t_g@mail.gmail.com> <CAOuPNLjzx2u420D0fSosy=omR8c8cQmcYHWYe=EEmLn_D4sj-Q@mail.gmail.com>
In-Reply-To: <CAOuPNLjzx2u420D0fSosy=omR8c8cQmcYHWYe=EEmLn_D4sj-Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 29 Nov 2024 15:04:07 -0800
Message-ID: <CAJuCfpEso835Lqqz5ZpZJz5-iptcP3WMtY6g2moT2bOA1+bZ8Q@mail.gmail.com>
Subject: Re: [PATCH v5] sched/psi: fix memory barrier without comment warnings
To: peterz@infradead.org, Pintu Agarwal <pintu.ping@gmail.com>
Cc: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org, mingo@redhat.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	christophe.jaillet@wanadoo.fr, linux-kernel@vger.kernel.org, joe@perches.com, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 5:25=E2=80=AFPM Pintu Agarwal <pintu.ping@gmail.com=
> wrote:
>
> Hi,
>
> On Wed, 23 Oct 2024 at 19:57, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > Hi,
> >
> > On Tue, 15 Oct 2024 at 02:36, Suren Baghdasaryan <surenb@google.com> wr=
ote:
> > >
> > > On Sun, Oct 6, 2024 at 1:29=E2=80=AFAM Pintu Kumar <quic_pintu@quicin=
c.com> wrote:
> > > >
> > > > These warnings were reported by checkpatch.
> > > > Fix them with minor changes.
> > > > No functional changes.
> > > >
> > > > WARNING: memory barrier without comment
> > > > +       t =3D smp_load_acquire(trigger_ptr);
> > > >
> > > > WARNING: memory barrier without comment
> > > > +       smp_store_release(&seq->private, new);
> > > >
> > > > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > >
> > > Acked-by: Suren Baghdasaryan <surenb@google.com>
> > >
> >
> > Any further comment on this ?
>
> Just a follow up. Are we picking this or I need to push again ?

I'm guessing it just fell through the cracks. Peter, could you please
pick it into your tree?
Thanks,
Suren.

>
> Thanks,
> Pintu

