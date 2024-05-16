Return-Path: <linux-kernel+bounces-181166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D0F8C7860
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C661F22446
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47122149E00;
	Thu, 16 May 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJQ/3MEO"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7F1474C6
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869328; cv=none; b=ZD6EVLQn1Myag6QjK6rQYzxv9XWAHy3kwHG9zCEKOShnURE0sXNkLYJNLqEI/7YrCF2n8f+b8UaTbKS45ZbonyRh587t5otRxt2DFwT4oVOlPU4wGB06HWlShLcNvKwSFGRQEiyIGht4tKAfmKI7tU0mV+KL3PMC9Hm7Cs+nR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869328; c=relaxed/simple;
	bh=wFZ+XymyfVDdDN1urUMuLqHT5lZSaSNxvhuy49pKSK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nU5m6Y/322QgDi+cj3CZ2CC3n+/TUKHJosUm7ugAYYlJtqlN8iEUO4L+6yuNYKYw4ONY+u8mGBSVVNMGoSvoLgZDtBXyTVeO5GryKvJSCI+O+GYrRaq1AAxFUGvdFxCj3eXcXmcHMvgBBB1meqWCV037TVRiR8TFnX3yRZ7tKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJQ/3MEO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dee902341c0so6639846276.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715869326; x=1716474126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4m68YkA2S92Eguxrloa+GQL1JjaiZ2vojYrAtugN7XQ=;
        b=lJQ/3MEO2xgTBtTuE0PaNjIvy+gRU2bds+R2vjwNLR8TRqf5kKMxhaoI6AT26gpHVH
         K6loFp5CgysAIBigkY+hazi9K0wDzHMoT6d03wBidAIwFN4o49ZzJwDe2EpRd52qqrV1
         qSeFFiOq7ADWPJXcNLsLdH+5OISM138lw0Oe3o5Jlo0/xPrc6Pylq+J+OwZXJGNJhCtz
         Gq4UW0tcpvlCIGiDvnjXOpKz1svIdsFLqXH+TnZ5lk4B411Hh/NoqTmMKxILwU1F0Xdi
         6g50bSlx1JZ00zQmj0y1/fp5sV3/uqYV4k8ogpoDGqax4g5dzbRaP5zRs7MttOvRaOtQ
         QszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715869326; x=1716474126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4m68YkA2S92Eguxrloa+GQL1JjaiZ2vojYrAtugN7XQ=;
        b=VhCpYuFLRlgbp1IpoROCvyA+WibsShw4IdsrfEO8uQkqz5J59RLB002K6tRTOnZOZM
         Nx3/3G8qltUfgvupK4Xu3k9/zKtuI9A9JoAhLheGcPOtvHRll85f3z3uS0gYDlc/YhZE
         eRF97ZR5Q4/4dreB2o60BKDgapzgN4RVXMw+M2eUPil1mHeVtGccgSexsqjD69CVpF6X
         /Onr0rFsjRycc2ZiA4Q3uKbJikU6q6sf+cAsiA3/q7/sDGZniHA7TfOgFCutblaLO2KE
         YAFFsd2Q7PdmZo6UytTQ+dRYzb4vTzvL9vHCktHiccHajtaNJnaybpvxMMPviwcnh7QW
         YuJg==
X-Forwarded-Encrypted: i=1; AJvYcCXKtTjJQcNzGpRglKsDiprhCxMsUyyXZ52xWTjdHimGnEHNw4QuH/YbgTtYNkntu+uVgAbfUGQ1yp9/WMdiIF3zIcwdoPekT/s3c+ea
X-Gm-Message-State: AOJu0YwJMSlY190JYEuIvoNfm4BvKW7WFGjndbPuvNpS0tJjB9TMRXkS
	jWdHizGeqoR7eHPtxyQx6fTs5ohu3FstlVC1LC/zYVXyGzGXQMw83bn5O6G6oR5KAZzAYzVoj6X
	A7A==
X-Google-Smtp-Source: AGHT+IELwAHgmf9QMA0EShOsWWV59MMoouxKZtjoShq1IflB10ZDo2Cz/CCMHIFS6TX9j2SWARMjV9r/sG8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:10c3:b0:dee:7c5c:e336 with SMTP id
 3f1490d57ef6-dee7c5ce8a4mr1028023276.10.1715869326194; Thu, 16 May 2024
 07:22:06 -0700 (PDT)
Date: Thu, 16 May 2024 07:22:04 -0700
In-Reply-To: <CAPM=9twCVkx9OqndCcvjjgx+P7ixBRwttiz25-R=bkycEo5vrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPM=9tw-53PCvveRcdLUUQ+mjq2X2er5zp6n1KeE8Nu8x=VP2g@mail.gmail.com>
 <CAHk-=whxT8D_0j=bjtrvj-O=VEOjn6GW8GK4j2V+BiDUntZKAQ@mail.gmail.com>
 <CAPM=9tyOtH24Mw_2X+bgV9iChOQV3LtmRCoR5x6KXhSUD6FjUg@mail.gmail.com>
 <CAHk-=wh8DWSMrtuhZOzanfBCFcuJCihO9x7fkzx-dBhLddXF-Q@mail.gmail.com> <CAPM=9twCVkx9OqndCcvjjgx+P7ixBRwttiz25-R=bkycEo5vrQ@mail.gmail.com>
Message-ID: <ZkYWjEaPcsT2-4dz@google.com>
Subject: Re: [git pull] drm for 6.10-rc1
From: Sean Christopherson <seanjc@google.com>
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Jani Nikula <jani.nikula@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 16, 2024, Dave Airlie wrote:
> On Thu, 16 May 2024 at 08:56, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > If the *main* CONFIG_WERROR is on, then it does NOT MATTER if somebody
> > sets CONFIG_DRM_WERROR or not. It's a no-op. It's pointless.

+1

> It's also possible it's just that hey there's a few others in the tree
> 
> KVM_WERROR not tied to it
> PPC_WERROR (why does CXL uses this?)
> AMDGPU, I915 and XE all have !COMPILE_TEST on their variants
> 
> We should probably add !WERROR to all of these at this point.

That creates its own weirdness though, e.g. I guarantee I'll forget about the
global WERROR at some point and wonder why I'm seeing -Werror despite having
KVM_WERROR=n in my .config.  I would rather force KVM_WERROR if WERROR=y, so this?

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 2a7f69abcac3..75082c4a9ac4 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -44,6 +44,7 @@ config KVM
        select KVM_VFIO
        select HAVE_KVM_PM_NOTIFIER if PM
        select KVM_GENERIC_HARDWARE_ENABLING
+       select KVM_WERROR if WERROR
        help
          Support hosting fully virtualized guest machines using hardware
          virtualization extensions.  You will need a fairly recent
@@ -66,7 +67,7 @@ config KVM_WERROR
        # FRAME_WARN, i.e. KVM_WERROR=y with KASAN=y requires special tuning.
        # Building KVM with -Werror and KASAN is still doable via enabling
        # the kernel-wide WERROR=y.
-       depends on KVM && EXPERT && !KASAN
+       depends on KVM && ((EXPERT && !KASAN) || WERROR)
        help
          Add -Werror to the build flags for KVM.

