Return-Path: <linux-kernel+bounces-532856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA68A452FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB3E7A152B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB29218EB8;
	Wed, 26 Feb 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMHw9PEH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E51A9B24
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536406; cv=none; b=Zi3pHLcfp4omzGlFvAMjttgbaxAGaJtExJrChvyw3+2I2IRGLvuHg+2XdgYnIyiMMR2MQUfWlB+LE22RLma611GprkTmJ34JhPyfPPXZ+ksPKcg/uVMC/iKZWcX9/QcZj9XiXM0QRRQK5LYTV9yyTiQsN0jSWVzw3ZuVzQkB0Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536406; c=relaxed/simple;
	bh=8FH5pIuvy1Jac6/lG3x6E2PJ8f8DqbB/+e+//FMv740=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sjxT6j90zmJlzqOtdqhQAFa/uRvbxXTh+G+KxeHXL3qlfznHJ9eGPsADWwdXPBI4eXYEOg70ePOsQbvONPlkfjsxmgMaiGcIOn4sNDWi9+n9ljwFGzqL0iYU82za4mYefe8A1doQ7IAZS42UVNpjnmQKuI+tlUnnCYX2tzoJbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMHw9PEH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1e7efdffso20585060a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740536404; x=1741141204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+U3kxkwkHHzAe5cXbK7f0ULstgU63GdnX7RFz40oJY=;
        b=zMHw9PEHQu+hs+z7irRop0MvCnmM20rZkSxANkjqd4+mzO/jzXgx+eEQ4bKewLyYa7
         Xf1m8An14BKFjFFbAQ/lxwhoU0j3vAeQRoiA0si8XrKO+CMx9MLMm90uOU1qOOFSMdDa
         m3QsFDb2+GgBN3D6XuJ/ES/TQyOO0LUdaY1Yc5nVOGNEpyHSuNBx1IQsVo8sPPaZ4IRh
         pldFZzUVXm4iw4RwGI45QkpGbk/wgjrE5w6jYKSXOXhv7GE8K3Z1AJyQ7Wykp6tITdUi
         ZMs4a89ec5do7ktNti3YtNJUeqOfaRCOvW7ovHSFKKYqrHdnUdQm9BBnuf3DCHL6iHpg
         0zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740536404; x=1741141204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U+U3kxkwkHHzAe5cXbK7f0ULstgU63GdnX7RFz40oJY=;
        b=HWksaLbdE1K/3pC8ztpD0PUilC+GTgnGyk6TbTcV2UsHxYKo8tZaA+Eb6g+I7mrRGa
         ogBzVurorYcQ/42u+MMoTGd0kmYa9r6wO2DRjkDDB9Eeb4LCNgnDt5BMbhLZAsVkyQ/S
         +IcHVlcMauxexDh8L2WUY+Wsx84ubp5OjgBfbpRvctZozYFT/pczatyA7W2fHpJivC8E
         jsdLJwzmXTy203N9bfE9BIl0sl1vY8sLy01LRQVy1n0oGylcT+RD0FGczgqHTjv6dPb6
         2kBYf4leCnpTpvuM30O8KVIVeNHLtw/9le4tlLKnd5EfXoOW/zvRi/+bG8V2GJ3QxkXl
         xU2w==
X-Forwarded-Encrypted: i=1; AJvYcCXBUWMn5bjoMn9lkW+RCOogXgzq9XA4jfQoatVTDDNvHf/UJOVbAouBv1FwLXXFusAN/nIRSh70/uFnKtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKq5Q48Sg73cSrgz8xHatId0Jmd/5yb1/dLWqwUgxbUcc5uyDh
	7Wb9kgDGLLQCy/QEyswbo4U4Sm3mTDn0tcMRXzNksM4H5/r6trYnlbQhWJdrlKD4kloTT7bN84R
	xnw==
X-Google-Smtp-Source: AGHT+IHv0DOH83fHjVuw42bSimWjWgTNGc2uJt+qXrf5Xmz4kGUc9ioLEA4EM3FcRkNofpV39I+3+EFaEg0=
X-Received: from pjbeu5.prod.google.com ([2002:a17:90a:f945:b0:2ef:82c0:cb8d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6cc:b0:2ee:ad18:b309
 with SMTP id 98e67ed59e1d1-2fe68accf77mr8037822a91.3.1740536404233; Tue, 25
 Feb 2025 18:20:04 -0800 (PST)
Date: Tue, 25 Feb 2025 18:20:02 -0800
In-Reply-To: <Z753eenv5NKkw2j/@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208105318.16861-1-yan.y.zhao@intel.com> <23ea46d54e423b30fa71503a823c97213a864a98.camel@intel.com>
 <Z6qrEHDviKB2Hf6o@yzhao56-desk.sh.intel.com> <69a1443e73dc1c10a23cf0632a507c01eece9760.camel@intel.com>
 <Z750LaPTDS6z6DAK@google.com> <Z753eenv5NKkw2j/@yzhao56-desk.sh.intel.com>
Message-ID: <Z756Usy6JNkf43PP@google.com>
Subject: Re: [PATCH] KVM: selftests: Wait mprotect_ro_done before write to RO
 in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 26, 2025, Yan Zhao wrote:
> On Tue, Feb 25, 2025 at 05:53:49PM -0800, Sean Christopherson wrote:
> > On Tue, Feb 11, 2025, Rick P Edgecombe wrote:
> > > On Tue, 2025-02-11 at 09:42 +0800, Yan Zhao wrote:
> > > > > On the fix though, doesn't this remove the coverage of writing to a
> > > > > region that is in the process of being made RO? I'm thinking about
> > > > > warnings, etc that may trigger intermittently based on bugs with a race
> > > > > component. I don't know if we could fix the test and still leave the
> > > > > write while the "mprotect(PROT_READ) is underway". It seems to be
> > > > > deliberate.
> > > > Write before "mprotect(PROT_READ)" has been tested in stage 0.
> > > > Not sure it's deliberate to test write in the process of being made RO.
> > 
> > Writing while VMAs are being made RO is 100% intended.  The goal is to stress
> > KVM's interactions with the mmu_notifier, and to verify KVM delivers -EFAULT to
> > userspace.
> > 
> > Something isn't quite right in the original analysis.  We need to drill down on
> > that before change anything.
> > 
> > FWIW, I run this test frequently on large systems and have never observed failures.
> Could you try adding CONFIG_LOCK_STAT=y?

Will do, though it'll probably be a few days before I can take a look.

> With this config, the failure rate is more than 90% in my SPR non-TDX machine,
> and 20%~80% in my TDX machine.

