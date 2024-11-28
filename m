Return-Path: <linux-kernel+bounces-424108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FDC9DB0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB308281E89
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF22745C;
	Thu, 28 Nov 2024 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0s41F8x"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB21DDEA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757153; cv=none; b=DrUTMKq8bHOwwJNbzfTLkPsyeH3Ka+hSUA9UFIj5cs1Jiq6p4OXd6NeYxsisGyq5VMbLO3fY43VFhUcqOQIUxODHrgKQYFglIZZ6M7l+pY/EaQxUFX4A4I5wwuC7CkohBUWYrSbxJtm7th4T+sb93dDXm4eJ2RnA5IiTFormCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757153; c=relaxed/simple;
	bh=Z7HiCpCGv3QAcT2KoPPzmqnqzoSYMDetkJDUlPvHoMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEBFs0LuvL2myUEBNpkYoVYAZyv8TmzZJfzAld+BFy1/Me1BkgkjkRvmieF2uEpuN5uxB3bkQ6/e0rgfinnYh7RAUQDQLIW5i0gvkODGpjyj23byo1KdZa/adZPMDQvTrCc6dS3nLZ/v44FqiSVuMUw4GEihMKUOeitu+tkYJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0s41F8x; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38231e9d518so235810f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732757150; x=1733361950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGcNcUs/WWPWblJ6YeMYvCyRc22c5Ob0gwaqn1kBROQ=;
        b=W0s41F8x4LTBNgfTRmc29vNkYGKFvBnmTKWqhz0ZiU3YPZhLQthZBs3796q62+7VMF
         W8GiKlMAtuI7gfQ6zNC/C0brEZLSf59TAcUoFOqUultHY7x6jdzJFR/Z6uE/IqcQmrkF
         v1Y0enuaAEK73tiQ0mwxrdUq8DkLixsr7vd7a3koBM/ybZVGXCEvT2uZAUC729kGZGI8
         8uFs68YDZQTvn2om/cXgwCC6QlbsF+sApOCN4lpVW2BPBhfbHgxQhKi4+7hbJq7tqYIZ
         MPei01Wgyc31P9ykOgKnq8/Qo32pSe8IEn8AYQ+OEv3O8mqozwUCJepxLfTTlxZknlSf
         nKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757150; x=1733361950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGcNcUs/WWPWblJ6YeMYvCyRc22c5Ob0gwaqn1kBROQ=;
        b=lflcUm/ogsSptNXUkJs6LSXVYOSET1Re+b6eXTTC71oMfchvYNpOc/VQUv7WmCaM3w
         EXT6v4/Ludy3PPaFYxFy8wZeGftYm9OAQgEwRHH+DoLeW9paCB3eUDlPpwRq5l5fvtMD
         EWc5psG2eMTBDEhfsvEo6/Eube6Q+9Kgzjt5hgBGDiLqL7yHI0uhIvQrzl0QCX0zRdEE
         Xsc2zWlU1xzF//iLqbis5JEcvYUEdGoq+lvrcABXfCUVMdROB4sIbTQKrTjWdvAPYpX5
         0eO/Wi9QoM407LCO7JKNAj2czDOibL6vvgs5mQR21UV72odCQw8OIu6ZIOa0BZpElCA7
         6T1g==
X-Forwarded-Encrypted: i=1; AJvYcCWSfcSbfa4pcd//5faKyGLdyTcmErcJL9QphruBaB99f3YR4QgXg543vbSvmkgZOWFdfETIQRnlbcpMzWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkiGrSPC2xMP5zLzaHiUNAi1RYp6rA8NQgqPCQzwg3j1pHuXw
	BN853Ils2DSGPNgRvltYCjUu3BTaFuWMF6pxTAPs72TPGEwp4TlnASxC48QW9ZmUNsacS2D1DYe
	wqiYMVjfBkkCdRHFO4NKl0SjxtkY=
X-Gm-Gg: ASbGncvp5mVBYO8nhEGJJxuezGrLc81IADSk1/how2hnP0lSywxCXLQvRC/w8Tp8R44
	b7JQJHvZ9xp8Zfb0CNI5cQn3P0NDtXWmf2Q==
X-Google-Smtp-Source: AGHT+IF1z0Z4MjL/iaFhZaGkldVc3W0q09wrxSINic2VJbZBYUQzzgBRYTo/VW/8ycPTgRh+r1znS7OFJWs/8o4ICoM=
X-Received: by 2002:a5d:47ae:0:b0:37d:5173:7a54 with SMTP id
 ffacd0b85a97d-385c6ee124cmr4323352f8f.52.1732757149628; Wed, 27 Nov 2024
 17:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082926.20647-1-quic_pintu@quicinc.com>
 <CAJuCfpE+LSd7hogwGnLMT5y831unLjCpS3DpOASgphDFxDjGJw@mail.gmail.com> <CAOuPNLjm2_Hg69pVY7fb9wqc-6mpys3P67wUF4Vz3+H77x3t_g@mail.gmail.com>
In-Reply-To: <CAOuPNLjm2_Hg69pVY7fb9wqc-6mpys3P67wUF4Vz3+H77x3t_g@mail.gmail.com>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Thu, 28 Nov 2024 06:55:37 +0530
Message-ID: <CAOuPNLjzx2u420D0fSosy=omR8c8cQmcYHWYe=EEmLn_D4sj-Q@mail.gmail.com>
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

On Wed, 23 Oct 2024 at 19:57, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
> On Tue, 15 Oct 2024 at 02:36, Suren Baghdasaryan <surenb@google.com> wrot=
e:
> >
> > On Sun, Oct 6, 2024 at 1:29=E2=80=AFAM Pintu Kumar <quic_pintu@quicinc.=
com> wrote:
> > >
> > > These warnings were reported by checkpatch.
> > > Fix them with minor changes.
> > > No functional changes.
> > >
> > > WARNING: memory barrier without comment
> > > +       t =3D smp_load_acquire(trigger_ptr);
> > >
> > > WARNING: memory barrier without comment
> > > +       smp_store_release(&seq->private, new);
> > >
> > > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> >
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
> >
>
> Any further comment on this ?

Just a follow up. Are we picking this or I need to push again ?

Thanks,
Pintu

