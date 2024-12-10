Return-Path: <linux-kernel+bounces-439839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC59EB497
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E39283EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE71C07F7;
	Tue, 10 Dec 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdcWnAXZ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F3B1C07C4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843931; cv=none; b=hIBK6vcw6vw2znRPQ1zMMECAS9TxVBOmgW+Rx/TVKs3jIe75cM4AVaAKYhgbemraXMwtPG+FLl9ROzEkKOSdz7jfMDmVMcFEhrHsUcru6SwAwwt/f7pG0rGeIWV8DlMD4j/qtey8usXXBw49w8iCUZKqv9ip5gC27c+TP4kjvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843931; c=relaxed/simple;
	bh=14R7FqYtgR/sdDrXhpMNQcZzfO2eoV9JkSTu7NaZdpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zj9qgTzChpV1xnGT+bFTaQp9XnVyoGUGLFetiQ2mb8rAf/B8f5K+4uVWsKeAjXSVb3se27PLWZdrMFWb+aZW42E2ansutOSZ0cP3WYgXe6QS3nhbwyovgKr1YDKAyyTSu6ylX4mb91zv7AXeC7lzG3cnBoNBJxXgspxGqf+y3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdcWnAXZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so8917676a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733843928; x=1734448728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqc/wmntdmQL61+jaSas1ihORLqlVlNHXWNaCn2fxLE=;
        b=AdcWnAXZpObCk8A+jzMQ79u83tPuXZNsqOKQ+9Emq/9bYKaLv14fvaEvU435ZzMRE1
         qUFDQHLcaG54RscO+17QFWUH4cRhBGi7n0JsoVe9aLfhZJyMQSjlhooWPUy0rKIPPZEO
         AROnyhxw2VtU5hOfr/EDZQmY3M0KzkEDb1FW2hYdB9Ny+rw2g1p5K3n3CbIYysYlJbZr
         h2qZJ/Lj0P5z78KcWbx7EMbp1XaFXMCh/ZM3DTS2g56iTriTl5ijEe6ci9WfyHcFYoUa
         ok9+J9Rz36Vtjh4FWlF10BStrVHfyedetxG2/+VZmcdiOSVAI1ppFPoDhysOQBtmdwcr
         Gg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733843928; x=1734448728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqc/wmntdmQL61+jaSas1ihORLqlVlNHXWNaCn2fxLE=;
        b=EUeHM7iEny8SdSYR03AA3MiC++bw38ZNgrzrnIxRAkiOvrJB3/LWPt9mvFpzzaqxe0
         XiAkXUBv7m+eCZKd8oWx455KhLdiTQTzzHOpkW8equ2K9uKh4yQQKG6P+DOrIfmswuBg
         tacvIEZ6RwNwqQ8CaLTqTIg4mmOrXDcxE+L7n6prWi65kL0sx3+GAC6zgsUEmvmNBrDg
         ZkanfsNJVvU2O9900qPSxjHTc4FPJftGeHgC8igC3EMhpvMUVbjlm0apPXMEN8CKqjd2
         hAp1I8m486nvkSkfBONLFfh0LIEv40WG3zBHBp96jZlVKbwAsA7zVWKLo33mXmmLiA8t
         7u9A==
X-Forwarded-Encrypted: i=1; AJvYcCWJO//lZQ+yo8UdwUATSyxRfGWV9ev9imTAFW0/DL/jlbKJuP2UXKpfQsoL5SGJJZtxUosNEeD/Ne6Dn7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKu5+0KvaDWTSgzD4tcGJwpPEA2iCXC5PyrHkTXZxuHcEiGE2
	klQt96LSDkWrtKxsIStNwVhO64ztm2iPmdwAdDMrjWu0VDlirmUw1NA1z0qSOS4U2h1FxMseoyB
	aO8btZm3xj0ilJ6MWILuhn/HflnP5oA==
X-Gm-Gg: ASbGncs1CrGOpvXxtDhx4EkASEgh2zbF1ckrP9FtMGJi2TdmlobE1F9u+jutbfrtMzQ
	kOyapJj1aK23rwu5p5blVFv3zTQz7y9BYU2Lpcg==
X-Google-Smtp-Source: AGHT+IErTYv0jv5qjK4wWhz6Q7hkUwbMWHmDiZu+s9Bu8oUREjzkv9M9Ir5yii6oFLoSfXcmwmMaAf/L2QeUxViaaNM=
X-Received: by 2002:a05:6402:1d54:b0:5d3:f6cb:73e7 with SMTP id
 4fb4d7f45d1cf-5d418534a08mr5012988a12.13.1733843927682; Tue, 10 Dec 2024
 07:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082926.20647-1-quic_pintu@quicinc.com>
 <CAJuCfpE+LSd7hogwGnLMT5y831unLjCpS3DpOASgphDFxDjGJw@mail.gmail.com>
 <CAOuPNLjm2_Hg69pVY7fb9wqc-6mpys3P67wUF4Vz3+H77x3t_g@mail.gmail.com>
 <CAOuPNLjzx2u420D0fSosy=omR8c8cQmcYHWYe=EEmLn_D4sj-Q@mail.gmail.com> <CAJuCfpEso835Lqqz5ZpZJz5-iptcP3WMtY6g2moT2bOA1+bZ8Q@mail.gmail.com>
In-Reply-To: <CAJuCfpEso835Lqqz5ZpZJz5-iptcP3WMtY6g2moT2bOA1+bZ8Q@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Tue, 10 Dec 2024 20:48:35 +0530
Message-ID: <CAOuPNLgHjXXSVkrb20uVBHSOjNwGdkf7TRK6_r-0m2usyTVzoA@mail.gmail.com>
Subject: Re: [PATCH v5] sched/psi: fix memory barrier without comment warnings
To: Suren Baghdasaryan <surenb@google.com>, mingo@kernel.org
Cc: peterz@infradead.org, Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org, 
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, christophe.jaillet@wanadoo.fr, 
	linux-kernel@vger.kernel.org, joe@perches.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Nov 2024 at 04:34, Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Nov 27, 2024 at 5:25=E2=80=AFPM Pintu Agarwal <pintu.ping@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > On Wed, 23 Oct 2024 at 19:57, Pintu Agarwal <pintu.ping@gmail.com> wrot=
e:
> > >
> > > Hi,
> > >
> > > On Tue, 15 Oct 2024 at 02:36, Suren Baghdasaryan <surenb@google.com> =
wrote:
> > > >
> > > > On Sun, Oct 6, 2024 at 1:29=E2=80=AFAM Pintu Kumar <quic_pintu@quic=
inc.com> wrote:
> > > > >
> > > > > These warnings were reported by checkpatch.
> > > > > Fix them with minor changes.
> > > > > No functional changes.
> > > > >
> > > > > WARNING: memory barrier without comment
> > > > > +       t =3D smp_load_acquire(trigger_ptr);
> > > > >
> > > > > WARNING: memory barrier without comment
> > > > > +       smp_store_release(&seq->private, new);
> > > > >
> > > > > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > > >
> > > > Acked-by: Suren Baghdasaryan <surenb@google.com>
> > > >
> > >
> > > Any further comment on this ?
> >
> > Just a follow up. Are we picking this or I need to push again ?
>
> I'm guessing it just fell through the cracks. Peter, could you please
> pick it into your tree?

Thanks Suren for the update.


Regards,
Pintu

