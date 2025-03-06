Return-Path: <linux-kernel+bounces-548893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD933A54A95
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118093A3D27
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FBE20B207;
	Thu,  6 Mar 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VIVHm+Ry"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1F1853
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263830; cv=none; b=pR3PU2zXGftLmimqvhBJ2eH4jSOHC6j2ru2A2V66eK/+7vDW2IgTMASabjXbMFLmi2CxgZnDfqQ6FcLPZY5hGCYCQis857wr8bIF0aEgFFnIqbME457+wPEl4NZKt5w2r9YsZo26D6gRa+T4JSHMKDtyiWyMdaMbU557FstdDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263830; c=relaxed/simple;
	bh=XnsPLRnXSWb7buELfPusaeb+B8AlBgoQQP15h/UL+Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQxBliRh22YJwzX4CuKqEyw56oqL7HUg/mtQaihzol17JHc9TryO2j/1xkVTacpshxgQQqKe0kDITORXwkQWDpqKelC2t1O5pUPARQxeG2zCxoEyrrgjXGt6gC3uzwe0m8SuFLoIUc8Lc4RLO3xLteDPSWGzqDE0+fvAswdlVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VIVHm+Ry; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bbf159247so658055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741263826; x=1741868626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M16Hx03LPq6Hpxa+7YZIfd9IWWJDL42bnuEv+y5yizM=;
        b=VIVHm+RyJq8WE+p3322eTYpgG1NYzUqgF/ySd4KpZlDQJX2sqN7C++0yPJZhyIOKRF
         u+O1u4+JrFQs6ve8P48QZjJIgdUhInvJNsKVvCNzBOuJuk3bMvdxfDltvWApMwB2DagZ
         g5ecaOwERnTOcwPhvDQBZX2x3CyvwDVZvU4SFv0xFL2tJQii/0Azank772wFa6PH+7LQ
         ob47J/aATABG8YNxm8JCQ7VCjyA60pQhfxrPjaU4bz/WRX5CD5NY8XjpnxxQtZYM9Pep
         qJfWHg5net0118fYAauk91UI2G/xMstHOO1YVh1zBP4umx/dRvDb+Z9gKozTc29N83tv
         6c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263826; x=1741868626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M16Hx03LPq6Hpxa+7YZIfd9IWWJDL42bnuEv+y5yizM=;
        b=ttqIEdLK56Mn3l51VfKP2yGFrMa+y63/O4JKxZ+1OHv6sbWI7CxpWVIA2lIfvjAWJW
         uFyaLqeZgNsLggPHpjXOgo1SPEo1jQdbxhdenLg7qkXTiK0OuV619npUzDZWAwp1shvi
         V4SjYURswytiYXCQDEhZDiEyVo+nWgeaR3i37esDE6dLVRbjHd+NochlXUk6SVKwi3KE
         SWjxY/BLn7hHPNrxP3ClfpC/dTfxmZF3xU7jfEmwgBvhmHias4bPfA2IflCyarxNJzie
         li6OwBsVK8Vpp5B6rXB+OzoQqikana+qHGdwNXdSpd1rFwBa98pSY+tNFW9TfGJ+UqvG
         5KDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIupRX6SoUdjfEVZHmYRvFPJIW7B4s0CQrHnAGB5Z5HPTFPbDrJ8rvAE+UEj4k3NBEopsWv3S2kUry9kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuuWNZpbTrA4Ffp3h2PfhKypdOw618LwzivuOmJ7IWKbjPSO/B
	kPQISCllqYQcX6D8j0TtqzUvSlk1EvKlRVIUXjOJo9RLBmhZ/NRmC1fDLDr7yB4=
X-Gm-Gg: ASbGncsOpsqqJ+AA3PbrdpWu/Vrh255d78XjO2lvcdiCfPk6kDosFTa/Kv6Of826sRb
	r2ekxluGPcDbH0+Wp/dPKvQZH74icMbKqitgplPLl74RKsOPGJH/ueJ0QExJw9D0BHN5KaLjrFP
	aSr9u/gvgWt0f60MtS5wg8pCZMlILLknU6oTBrfdJ7SY2ROfKz8jqb+x21+qWmExlWdbEbG7JMt
	OCF4tlqthOq6EtUJ8OM3hjWuz96X52Ld5ryneEihpCIUTtdHMrZljpHGhsIRkEYgOcfj8dDxxZv
	wReoBmmzYI0FBvu/pljHET10GxORlQWs5EXRYUK7iXqMIEDj9p6iHDSDAntgyuXlIPAgZRbRfty
	to7KluHLAtD8f3fWdx7ninFFG14SFuhpLV+FkTBE5XIkCCm23XA==
X-Google-Smtp-Source: AGHT+IFsubZy1stzLlAQAO2x9t8qCSSvv55Pi5w0YDWBthveEExrqPR8Wq2/UXbzt8+RS0SQ+6/D5w==
X-Received: by 2002:a05:600c:3d1a:b0:439:9a1f:d73d with SMTP id 5b1f17b1804b1-43bd2ae647bmr19310215e9.8.1741263826596;
        Thu, 06 Mar 2025 04:23:46 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb79b9sm1886787f8f.3.2025.03.06.04.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:23:46 -0800 (PST)
Date: Thu, 6 Mar 2025 13:23:43 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>, Peter
 Collingbourne <pcc@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Thiago Jung Bauermann
 <thiago.bauermann@linaro.org>, Mark Brown <broonie@kernel.org>, Kristina
 Martsenko <kristina.martsenko@arm.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Jinjie Ruan <ruanjinjie@huawei.com>, Juri Lelli
 <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 1/1] arm64: enable PREEMPT_LAZY
Message-ID: <20250306132343.6b902a3d@mordecai.tesarici.cz>
In-Reply-To: <Z8hAZ09Q40fxLJSk@J2N7QTR9R3>
References: <20250305104925.189198-1-vschneid@redhat.com>
	<20250305104925.189198-2-vschneid@redhat.com>
	<Z8hAZ09Q40fxLJSk@J2N7QTR9R3>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 12:15:35 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Mar 05, 2025 at 11:49:25AM +0100, Valentin Schneider wrote:
> > From: Mark Rutland <mark.rutland@arm.com>
> > 
> > For an architecture to enable CONFIG_ARCH_HAS_RESCHED_LAZY, two things are
> > required:
> > 1) Adding a TIF_NEED_RESCHED_LAZY flag definition
> > 2) Checking for TIF_NEED_RESCHED_LAZY in the appropriate locations
> > 
> > 2) is handled in a generic manner by CONFIG_GENERIC_ENTRY, which isn't
> > (yet) implemented for arm64. However, outside of core scheduler code,
> > TIF_NEED_RESCHED_LAZY only needs to be checked on a kernel exit, meaning:
> > o return/entry to userspace.
> > o return/entry to guest.
> > 
> > The return/entry to a guest is all handled by xfer_to_guest_mode_handle_work()
> > which already does the right thing, so it can be left as-is.
> > 
> > arm64 doesn't use common entry's exit_to_user_mode_prepare(), so update its
> > return to user path to check for TIF_NEED_RESCHED_LAZY and call into
> > schedule() accordingly.
> > 
> > Link: https://lore.kernel.org/linux-rt-users/20241216190451.1c61977c@mordecai.tesarici.cz/
> > Link: https://lore.kernel.org/all/xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb/
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > [testdrive, _TIF_WORK_MASK fixlet and changelog.]
> > Signed-off-by: Mike Galbraith <efault@gmx.de>
> > [Another round of testing; changelog faff]
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > ---
> >  arch/arm64/Kconfig                   |  1 +
> >  arch/arm64/include/asm/thread_info.h | 16 +++++++++-------
> >  arch/arm64/kernel/entry-common.c     |  2 +-
> >  3 files changed, 11 insertions(+), 8 deletions(-)  
> 
> Catalin, Will, given this is small and self-contained, I reckon it makes
> sense to pick this up ahead of Jinjie's series to move arm64 over to the
> generic entry library (which is on my queue of things to review). Even
> if we pick up both, it'll be easier to bisect and debug issues caused by
> this patch alone.
> 
> The fixes/cleanups from Mike and Valentin look right to me, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thank you, all. Much appreciated.

Petr T

