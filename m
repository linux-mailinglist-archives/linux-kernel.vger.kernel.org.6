Return-Path: <linux-kernel+bounces-169322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855028BC70C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72711C2111F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 05:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED20524AE;
	Mon,  6 May 2024 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKVr+cM/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE8A40847
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714973794; cv=none; b=AcC+ZMKsT0GzW3ByvUs0CYmPamnlwb3YsWq8WYS9SrnSzQtUJrn32pv2xVEcXHWcTVLBlZEa998O66OB0+IHAQLJ0wXlrx2Ll8BVrc6L9B5wRUGbbOMQUKet7MLX65VhCyfCNIYvKyqrSmUKoi4CK+k1MZ40PHbmxs58l4jNaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714973794; c=relaxed/simple;
	bh=G7CdsgNpfTQRen0iYorRaxR7iwHQ+rJicDUKG3UcIeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDo1o/N6H6xTkDe/HWyh7aSRbk5ptYvA0wSI16MUjDfjXigDwLVWzMkiqVxc4k71ceLzGR6WLgsPGXQ54UxJYSr6DbL8gmCZERcshsM/lWHcEvxwFHU7m0sUiig9HxLpzuK1O1C3QbSLaTjo4vtfKGrhfJ/zrx6u9HjUoRvps1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKVr+cM/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a599a298990so364596266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 22:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714973791; x=1715578591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GWWRLCvakvhhYyd3WrFl6nbheuV8ncCxq9hNwV1fNc=;
        b=CKVr+cM/+cVSRoGrSZJWtn+aJxlj5FxmfqbjI6Hbavo4PiFkBHT/5EvOij6zxdaW4f
         bc4ssRBOO8xi1Cy18zK8ZBDULQuzWfthF6hw5Fv8h/1063RK91FZlWZV3sr1Sc26fOOp
         z9g/JznlkPcxD/JnLvfc41uidAXkfBYx5SMM3bi7zC7pJ9iOP84HvDvxosUbYEKCQNin
         BH7qokKpYbWhrGzcbJSh6MAv6q/VAoyk+s6s4vG/+6y71RWryt+2n4bjqaEd+pp2mOgl
         735tF0ZgLDa9GGiuXAXbhR/JQCAcVL0GuaCCJ7fn6glvxChwY5t10GusXJ8KqG+sJRrZ
         ZpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714973791; x=1715578591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GWWRLCvakvhhYyd3WrFl6nbheuV8ncCxq9hNwV1fNc=;
        b=QcECVG+w1EGOUgitd7Hk43/p0crdnPjWUQ+p3WdSze64nPCTkc1N375ORRhbueLeDq
         Jlzxzh2+3H3KRsxPBEM88qoR/XFZeGW2e9XIuMVUePn/Mnf/AU6jVDkJtqydt/sHE5tj
         KHOblyhYYoGMLRbzifykNDsDUVrR2yOKYzktu+Hbt/0U8pObmgIfcyTgmZIOQaB2jEtf
         YbHbWfEOQTj/jNM2y7QcyL9DJDB/cvYjGLfXGKDx3YatyNwgd8byGgMh5ZpHSSNpkEHJ
         hUsLZugf0KkrwLtGnhlrBQfXRT9OB9OwlPGKf8zIxYH7pe7Tjh20eEyMbi3O1cDpN0wj
         q9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWspfsU+7JqQF0qr/uKpJJmDdqnI3QphOOX/L4aOTPPkeLaT7+aUpHjbdFRlXqGnoFBKzFKxzo2JRHdkotQuoO8mSaGzqsP4wuOC8ko
X-Gm-Message-State: AOJu0YzOsqo1MLf75z8ZTvb2+tvf396JJcNbC+wYI6dtlk6Z+MxkhPMs
	iSOvD3xa32H433nLZIloKCenk/8b0UE7nKg7Jrs2MApqKUh0pXZPOTP3vdC752AOBR70Fsg/dZ3
	mQ5kpmdPPU11/NNq1jRtxtPGkGXAENhbj6gaO
X-Google-Smtp-Source: AGHT+IFH75j9Jfg4XNOvXjKUn+IO0imz46ymW5Bese8YTjt3itWQfNiQUeA6Kp+fVGIfekoSHg3Y4Xw08O/aZkSMJsE=
X-Received: by 2002:a17:907:7212:b0:a59:bde5:398 with SMTP id
 dr18-20020a170907721200b00a59bde50398mr2638397ejc.14.1714973790923; Sun, 05
 May 2024 22:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430005239.13527-1-dapeng1.mi@linux.intel.com>
 <CAL715WK9+aXa53DXM3TP2POwAtA2o40wpojfum+SezdxoOsj1A@mail.gmail.com> <22b52180-27a2-4df8-a949-401f73440641@linux.intel.com>
In-Reply-To: <22b52180-27a2-4df8-a949-401f73440641@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Sun, 5 May 2024 22:35:54 -0700
Message-ID: <CAL715W+JTyba76u5BdqHi2u7iBObbBp8cEr42oqm6HWthb_4pg@mail.gmail.com>
Subject: Re: [PATCH 0/2] vPMU code refines
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 6:37=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 5/1/2024 2:15 AM, Mingwei Zhang wrote:
> > On Mon, Apr 29, 2024 at 5:45=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> This small patchset refines the ambiguous naming in kvm_pmu structure
> >> and use macros instead of magic numbers to manipulate FIXED_CTR_CTRL M=
SR
> >> to increase readability.
> >>
> >> No logic change is introduced in this patchset.
> >>
> >> Dapeng Mi (2):
> >>   KVM: x86/pmu: Change ambiguous _mask suffix to _rsvd in kvm_pmu
> > So, it looks like the 1st patch is also in the upcoming RFCv2 for
> > mediated passthrough vPMU. I will remove that from my list then.
>
> Mingwei, we'd better keep this patch in RFCv2 until the this patchset is
> merged, then we don't rebase it again when this patch is merged. Thanks.
>

yeah. too late. I don't want to have a duplicate patch in LKML. On the
other hand, you could have waited a little bit before sending this
one. Next time, coordinate with us before sending.

Thanks.
-Mingwei
>
> > Thanks. Regards
> > -Mingwei
> >
> >>   KVM: x86/pmu: Manipulate FIXED_CTR_CTRL MSR with macros
> >>
> >>  arch/x86/include/asm/kvm_host.h | 10 ++++-----
> >>  arch/x86/kvm/pmu.c              | 26 ++++++++++++------------
> >>  arch/x86/kvm/pmu.h              |  8 +++++---
> >>  arch/x86/kvm/svm/pmu.c          |  4 ++--
> >>  arch/x86/kvm/vmx/pmu_intel.c    | 36 +++++++++++++++++++-------------=
-
> >>  5 files changed, 46 insertions(+), 38 deletions(-)
> >>
> >>
> >> base-commit: 7b076c6a308ec5bce9fc96e2935443ed228b9148
> >> --
> >> 2.40.1
> >>

