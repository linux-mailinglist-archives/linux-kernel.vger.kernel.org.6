Return-Path: <linux-kernel+bounces-398590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B8E9BF333
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A951B25BB6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501B4204F7F;
	Wed,  6 Nov 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeiDOyOs"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4920408B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730910470; cv=none; b=tVzVKOd0mW7WP6vP94NOI9AsJv3NBfAvigyYUYZhf7ZKzaxnofPqFUEL7FJHzwqih+5ceKc9SY1wRfzAS3JisXgLOkxyMc5XqKEXOnAe5z6wc1mbtkXs/Bj8ghkQcGYN3Wwkwp99DDPkXv6MaYj+EwNwTwDwA3jloRbfk/USmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730910470; c=relaxed/simple;
	bh=ph8WgCziHmWfyswsDBnx5qg6csF9c5Z6bkRrBHlPhds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rTQwQMDJlsZr0ibFWSexacMp0yYCpdE4BcOjeIeLMw90MIR9o/9q1P5tEn0FbkOR8JB2BIYKUtfQGfsCiw6vLzZBW/dEQhqLZIFcHsr/xFbXI6Pr5RwM6MT7Zwssf7DnPSXJ0G24JP1WNXfbRb3emJFnPVICoZYwKK1PSvmMML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeiDOyOs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7cbe272efa6so9338a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730910469; x=1731515269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FCXUf644XlkJphA6SVk+8Af9SxQm8DuQmfcSkYLayzs=;
        b=yeiDOyOs/fY4CnfqJW/K33m2cWdqxFCjYyVgWvNMl0Omo9Q45D1uvrVNdpfqZiE8uY
         jhWulJNAcfZNi4p+XEi3/MFO1gfJezFOVf4UpwjLlOgc0DlGtuSAyY4rRjB4fNdlZC29
         KOmUTjpxfxnFcR9rvoxK9Pwqd2NECLdr2Qgb/+QF2u4tevMS7EXjm9iwwl3CHze+omz6
         Ie/2FACHH6CUk3WDddUbrXZzXPXvz0EbHl7a9KglaJeKTU0jGbKJEbETcAFssmly4iJD
         8k7fA0SxH3jXiXEvguj/kqEtrBjUuWBBrsyqFtL2dD79DEJVDh6+UJC4hxB0pIDaJbw2
         RCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730910469; x=1731515269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCXUf644XlkJphA6SVk+8Af9SxQm8DuQmfcSkYLayzs=;
        b=PBAQo6ICmnrlCFP98gVEHR4ktghyCEYh2Nv50Lxl1JfAX0fH3ZwvMCu63R6lah7mo1
         x3FlCGmR0YMsk7DPpltA38c3DcB0DkoprICZzLptoZeWev7j41vioWKL7LgCZx7QWLZa
         tgzPyvWCV1NVgqfB60C9kKes/LdKOlC0gDp5W0DlIZAzpfL78ER39lSEir/jSSUfATFM
         dxduCr5lkIE/hhcuoi4JI8qUU59dYbsZ/qOZaxLwJKj6FORzX9RvfwXBk/wIrrFxid+3
         HHYsc9iPRHeJerYH6kIN77iBL6PWiBRO5CnEtIdYRspaQ71HYdwFLm2a1x+p+lqCyyTB
         mEkw==
X-Forwarded-Encrypted: i=1; AJvYcCVBOT1aPCAhlc3rervLNiZUgs3bB75Cm2YKb8/UQ7xbHlhjPrIQMqqWFJGLwPUY28bSbaS3x3mNclkNfPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2NpC2Widr4JMx2SPYlUsNlxt+jvSBJkJek5X+K1HFMwjPoT1
	vVB4FF1XP9y4DoOMPBL9VDyh+7KYiE03bcF9rHpf2JAKLKAXf+yZVmKQ9Ggd+E+Bb3ZB6LA8IYt
	6Pg==
X-Google-Smtp-Source: AGHT+IG3df/kZk2fCqxxe+LGQm+PfVIDi52PzJ3ZNYNOJoCeWKyXHryfz8LDsbPSuUIbUhymUD1+KWX23yo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:1a0e:0:b0:7e6:b3ab:697 with SMTP id
 41be03b00d2f7-7ee2908a4e4mr46438a12.5.1730910468750; Wed, 06 Nov 2024
 08:27:48 -0800 (PST)
Date: Wed, 6 Nov 2024 08:27:47 -0800
In-Reply-To: <20241106162525.GHZyuYdWswAoGAUEUM@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZypfjFjk5XVL-Grv@google.com> <20241105185622.GEZypqVul2vRh6yDys@fat_crate.local>
 <ZypvePo2M0ZvC4RF@google.com> <20241105192436.GFZypw9DqdNIObaWn5@fat_crate.local>
 <ZyuJQlZqLS6K8zN2@google.com> <20241106152914.GFZyuLSvhKDCRWOeHa@fat_crate.local>
 <ZyuMsz5p26h_XbRR@google.com> <20241106161323.GGZyuVo2Vwg8CCIpxR@fat_crate.local>
 <ZyuWoiUf2ghGvj7s@google.com> <20241106162525.GHZyuYdWswAoGAUEUM@fat_crate.local>
Message-ID: <ZyuZAzqQIXudhbxi@google.com>
Subject: Re: [PATCH] x86/bugs: Adjust SRSO mitigation to new features
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, kvm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 06, 2024, Borislav Petkov wrote:
> On Wed, Nov 06, 2024 at 08:17:38AM -0800, Sean Christopherson wrote:
> > I do subscribe to kvm@, but it's a mailing list, not at alias like x86@.  AFAIK,
> > x86@ is unique in that regard.  In other words, I don't see a need to document
> > the kvm@ behavior, because that's the behavior for every L: entry in MAINTAINERS
> > except the few "L:	x86@kernel.org" cases.
> 
> I have had maintainers in the past not like to be CCed directly as long as the
> corresponding mailing list is CCed.

LOL, doesn't that kind of defeat the purpose of MAINTAINERS?

