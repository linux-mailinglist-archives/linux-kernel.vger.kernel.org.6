Return-Path: <linux-kernel+bounces-368116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4B9A0B67
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ED61C22B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3C20720B;
	Wed, 16 Oct 2024 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGX/pFJh"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CBC1C2325
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085176; cv=none; b=iKCULDAus7zuI1d0oRCYYwKfFPeltFdGjX0/Vm83wgJyGW8RH4mQGGCgjStOMund6wJFTCWfCQJMAxghj5PhVYBnYF/5Ypokhy+4hiJx41shB7rcsvKOa3tcy05r4a4Gpi50CMf3Bacy/dxpjdgNkMr4Po4UDOOQ846JtLuYRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085176; c=relaxed/simple;
	bh=O7EgR5OSjoWSs3q+41nfNzDZd6mbVvdVr2357ZxksYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvWWbX5n5sQ/6o5NggxIzmAIhVsaLknZv4lVCAfBDbszlqhE53AaA243zZuYxq+HLC4Pk+MwVBXj/r9uEAA3bTO4hEBi/Dp2AksvHAiGiBFdYPA5B2XnOoQpmryh6YdXvMNUasDxJAtjmbkx/a51WsSwOPiQJGSefQX3wilmo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGX/pFJh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so18731a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729085173; x=1729689973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7EgR5OSjoWSs3q+41nfNzDZd6mbVvdVr2357ZxksYQ=;
        b=nGX/pFJh+wzH1/diPW9LoH78Xy/4/Gs8GVJAwGrsr43WqGcuVcqH0F2jt+GjeGRjzV
         ykB+Cgp8AN/rtf16UBaw+mhmVfpVGV6jtbWiPExeGYhiXxZDV/OXhz3B+jbU8YN9Xrbx
         L7E2HHK+TXPo9e2QSU3Cd9S/XzV4kI5s3pSVLEIOsqlV3KytlY4BgJs8Ppuo6aQMmUyM
         S5bFHWrPpjne+vYkante4qsk+ZGMfbLwEoHDJuZvQO0X3//C0ojB57ncawVQdlMzADId
         A9aEDrfQkNPbraQEeHSrSRlnizylfZ4nKDubqXMgd4dFXfeMI6OmwZzo04hkMv86wcKa
         1kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729085173; x=1729689973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7EgR5OSjoWSs3q+41nfNzDZd6mbVvdVr2357ZxksYQ=;
        b=H0bvhTx29cpUKvoDeBcDkGT2H5sOKrEZPxP3Absc8UHmXuFKgSIoXB9PGINZ3IqCdO
         s3kK0pQc4lBTRnCi2objPzJqTpI3jyK0lJK3Dj62srFVgDiBCfgxGJDpqujRxEoEceLe
         E56ca1heXijRkoxMYSKffGCJy7gkxoNeO1b+Oq0fT8nklXjBPB58t79SN9wmSLkkmX4a
         yEw83h454bCpP4ceT2Z9o1FcpZjzG/frE8aeY+wX+s0Fo2A5v3Ne9ZtEZuFDlSyF6CIJ
         2QX1uFRx+yMGbqFtZgm/E+6cICtSfQahMslreOGfAB5Q54io4pNX62B5tCprzuCYEne6
         8W1g==
X-Forwarded-Encrypted: i=1; AJvYcCVGa20CThB2UJKo6MdIbzOWHg1/MKKL6b/2LR87e+kvTEIpkWuhsXKxrsSPrTCq6L2clmVPVOBC6KzFdTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztgMIeXRlB5TnPSSRe4McJQjgExQdaFiU72dSOhYyeNvnC9mXW
	1bkJa1OaZosa1AP5Ztx/YdpFFuFM1fe36R6vXVMSRBAcY5hkIJAw/RaZ/Q/JMguHXnM/IcQlBwC
	RcP6J6NL1TnIkRF9Dg+p/oJvUsmt69tPfbA14
X-Google-Smtp-Source: AGHT+IHm4uAnm6x4gqyE8JxaDYdv12A+djBdgtqoCDD2tCHeA1XFE3cLD3QA0GXWVVrvkSNF4Qk2pPtyOLiHFomBKfc=
X-Received: by 2002:a05:6402:234a:b0:5c8:a0fd:64f0 with SMTP id
 4fb4d7f45d1cf-5c9979d0b81mr492682a12.2.1729085172800; Wed, 16 Oct 2024
 06:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <CAG48ez0=9O-V0V6v_LUgRcF46BooJdk3eqb6xgDpKpNZuW1L2A@mail.gmail.com> <a185df19-c8a5-4b2f-8bed-19770744a944@oracle.com>
In-Reply-To: <a185df19-c8a5-4b2f-8bed-19770744a944@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 16 Oct 2024 15:25:34 +0200
Message-ID: <CAG48ez33CQmWnQR13WvuP+eiX=MEXch2s6n2+Ck+zT5Tgi5fEg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 2:59=E2=80=AFAM Anthony Yznaga
<anthony.yznaga@oracle.com> wrote:
> On 10/14/24 1:07 PM, Jann Horn wrote:
> > Second, there is a newer mode for IOMMUv2 stuff (using the
> > mmu_notifier_ops::invalidate_range callback), where the idea is that
> > you have secondary MMUs that share the normal page tables, and so you
> > basically send them invalidations at the same time you invalidate the
> > primary MMU for the process. I think that's the right fit for this
> > usecase; however, last I looked, this code was extremely broken (see
> > https://lore.kernel.org/lkml/CAG48ez2NQKVbv=3DyG_fq_jtZjf8Q=3D+Wy54FxcF=
rK_OujFg5BwSQ@mail.gmail.com/
> > for context). Unless that's changed in the meantime, I think someone
> > would have to fix that code before it can be relied on for new
> > usecases.
>
> Thank you for this background! Looks like there have since been some
> changes to the mmu notifiers, and the invalidate_range callback became
> arch_invalidate_secondary_tlbs. I'm currently looking into using it to
> flush all TLBs.

Ah, nice, that looks much better now. With the caveat that, from what
I can tell, the notifiers only work on x86/arm64/powerpc - I guess
maybe that infrastructure should be gated on a HAVE_... arch config
flag...

