Return-Path: <linux-kernel+bounces-572051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E978A6C5E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D88E3B21E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB91F4183;
	Fri, 21 Mar 2025 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EL+IrAaZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06101C3F0C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595846; cv=none; b=u4TiUdsWmeOA99w1luXk8Oj/DtgVl5IN9Y9Kk46f/jbGy0G9f4wCVIMuwAq4sC4TSVGna3Oj8pYCemkFn7eTfdBYXI6s4PQbmlm+URnSGLfLrV+g8sKWD2GFx09eNJWE6ugJ2x/fcRHdHgDBYSAWRqvLLJ/UqXohnYrGB3l7e1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595846; c=relaxed/simple;
	bh=Pf80HbUr/DGQjCWPwmII0ZVFPKktGmOvnTdlRbkKMIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sn6BiIwSQYyXzcmSVB5NOAsskhoMPe3Aagms9tHi0fJKnO0Z4UIpTTYoFaAVP7QArG9skrWnS1OWmFGFK++zqdF7y7oLcrc3pWzRXgzAkkLmP14MXGRiX40hsUKfJgHRNoJDaODJUKU27B+DC80fdoPrv2ylfXvQ6YMSJMP7xS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EL+IrAaZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac29fd22163so445187866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595843; x=1743200643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8jrJyKxiHJsFpDm0e3XwO0Ld22rjdn+cIHQuSUcYus=;
        b=EL+IrAaZ0etBEeFqvodr87jH6vKQEFcZutosQURa6y1XId2dG2QegfMEgKiMqJ9mzj
         GU7NHD2RiR6SPafSBG/b2tPUUYy+mlCZSjk7rGsGaECb1jM5Aku2dp6aPJzquFxWnFYJ
         TKuPxtNgbm89UiO0LNNQjAnGbkxsa2SUEgk9D4Dya3N1gC5T0r5nw13hTTNNG7OFMlFp
         moS2uoq9bTb42fRUWFUyK37OmpO0klYjuaNLTQoQiQpV18Ymvev70vw2DZkyzv/ltNtU
         q6XMLIRy0+CNzmXHTGlLIpifEC7azlSC8KxKzLUsmoRtZN9nF930MuTfpZszk0V4Rw6O
         wQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595843; x=1743200643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8jrJyKxiHJsFpDm0e3XwO0Ld22rjdn+cIHQuSUcYus=;
        b=VrRG2dgd/ndedHb50RhmwmOC4Vq2KbKKs+JuhUkBMAa4dC1vkK9153mwZvpGqd8+/X
         3V8xPVIw02HRbBZM8jZosMfggu8bpISaWqibLI3B/mKjzXsqpqZkcFG50jN2xWb750yU
         I2dLSGjDNolv8SaTIX/nPjB321uOcAT2xuCUnMev11b0NKIXKET2vXyVxSM0eOU1wdeu
         BbC+GhzuX1NenL17cKAKzzXkJkU8DIiAIWjlNpYHCTbItAQQ3mCcBuCPfDZ9GKychcvC
         Pzi7oNXsGZ6HYbwBE4a1Vo+p5GvsR1/nmCrlgt7mtqa/ANPlkNhVM8/gMKWorxnQyyEb
         6B8A==
X-Forwarded-Encrypted: i=1; AJvYcCUX0gXzKGUHeUqa3hfQ6qliFtWIuTmUdV25sph4WW6qi6OUnIZsNbP12gIv+38Fd7JPy11Gbh5ppGAR8OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQeB+FEUZlFI+bnWuBHS5+Zqw5ddabbVA5p9AgbMXk4KQq3SZm
	UA9P1m0zvO0gUEXHQJdOw9UpkcKxoN6lanL3hPc1+JwFd9In+YOmBNm5AxvLaMsHe+yfFUtEu6m
	bAni4u4hXlEwVA9nA+wapFQpPjbikMOhgP9kAB+lV0mO+tiKkYPA=
X-Gm-Gg: ASbGncsBW7e5pIFku78PSoyADAjtEADoWavmX6lXp6+jsdW3zAsyaSF5JGBJt6rL0ZN
	9axf++QXMVrOe0Iylvfyc+eKtnz4bBgrAXA3i/HZAueD2b/iSqXuZzr0fiTFYOfzfItH/48w2Lx
	hEoLbMApxV7bnpsrP/t//fAIU=
X-Google-Smtp-Source: AGHT+IGiBo0grQRUu2nHJCjMTQZmtRZhraKKNe/LaYS2ganDDjeQhCx9hOUZj3XHWnRGLvT0rflSbrILe4b94nHCEIA=
X-Received: by 2002:a17:907:c88a:b0:ac3:f35c:755a with SMTP id
 a640c23a62f3a-ac3f35c78e6mr507778166b.15.1742595843070; Fri, 21 Mar 2025
 15:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGG=3QUEY_Gmu-6K7rk6-y8AB7HVuV2V9sP5K3h379teAZXyHQ@mail.gmail.com>
 <20250321220537.507917-1-changyuanl@google.com>
In-Reply-To: <20250321220537.507917-1-changyuanl@google.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 21 Mar 2025 15:23:46 -0700
X-Gm-Features: AQ5f1Jq0IhTuozvPpo_OHyjFNWZyGClQgpdIrwKlxghGJJyad_VMwGeLm_dK1fU
Message-ID: <CAGG=3QUzJ_McPbJWkbcjHn_Uhw9OeBajH8h2u_4Bexc1x4G4zw@mail.gmail.com>
Subject: Re: [PATCH] clang-format: add for_each macros from libfdt
To: Changyuan Lyu <changyuanl@google.com>
Cc: justinstitt@google.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	nishimura@mxp.nes.nec.co.jp, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 3:05=E2=80=AFPM Changyuan Lyu <changyuanl@google.co=
m> wrote:
>
> Hi Bill,
>
> On Fri, Mar 21, 2025 at 12:28:44 -0700, Bill Wendling <morbo@google.com> =
wrote:
> > On Thu, Mar 20, 2025 at 4:59=3DE2=3D80=3DAFPM Changyuan Lyu <changyuanl=
@google.co=3D
> > m> wrote:
> > >
> > > Add two for_each macros from scripts/dtc/libfdt/libfdt.h.
> > >
> > > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > > ---
> > >  .clang-format | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/.clang-format b/.clang-format
> > > index fe1aa1a30d40..4decda7474e1 100644
> > > --- a/.clang-format
> > > +++ b/.clang-format
> > > @@ -210,6 +210,8 @@ ForEachMacros:
> > >    - 'evlist__for_each_entry_from'
> > >    - 'evlist__for_each_entry_reverse'
> > >    - 'evlist__for_each_entry_safe'
> > > +  - 'fdt_for_each_property_offset'
> > > +  - 'fdt_for_each_subnode'
> >
> > Could you alphabetize these please?
> >
> > >    - 'flow_action_for_each'
> > >    - 'for_each_acpi_consumer_dev'
> > >    - 'for_each_acpi_dev_match'
> > > --
> > > 2.49.0.395.g12beb8f557-goog
> > >
>
> Thanks for taking a look, but I think the list `ForEachMacros`
> is already sorted alphabetically.
> Am I missing anything?
>
Oh! I'm sorry. I tought that the 'd' (dee) in 'fdt_...' was an 'o' (oh). My=
 bad.

-bw

