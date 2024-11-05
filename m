Return-Path: <linux-kernel+bounces-395927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52419BC514
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DDF281B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEAA1FEFAE;
	Tue,  5 Nov 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+M44il+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801E286A1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786132; cv=none; b=DPc1B17lgT5VoYV0/yrog/nenP4RpKGyUfQ1b6MUoUZsGp/UjFR8jcHmcud5m8DchbGPSrVndNEhlKx+mPP22Vb6DJavIpMannzY/ih4ygaVDddRQnNBWBCXQ0PhInHl3jKzLu9xd2cHjOBHFZEERtt1pQ/JmRuwr3OQoN2XmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786132; c=relaxed/simple;
	bh=EM+nXUdvDCm6N3UmMRTXiFNomsft+6ngsfGryxa8oRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SkQSl1IcrWmf4e2OO+CyrZ3tb1m08TLuMwMW47LMUnXoqpOfE7VquuU8YMvIh/uSTU3pmLw/7Rxa9aZ2G5icNIODCh+6u5MktiCce3yaZGs8+8jw904A3JQ3t+eS89OBE1iy0lbLTIEl2AUBlW0A6CpdOZIh78GR/bAXzex6RIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+M44il+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c70cc9d27so52489175ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 21:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730786130; x=1731390930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwQ41DxPwHg/LBZhq9U/e3vXFnxJog0O/oye+eR+OCc=;
        b=e+M44il+sxOWb3DmRtN9R8gggYSFTLNOR+lm+ljnfO7pl9eMdZH8lVD22xu0zedewA
         gJ7p7C/zI9b2eWUBX/VgyyUY/tBFqldpZlyCZLPC7cs/l88LAOpv6at9uWm13EMgaSgQ
         ZE8i3YewAFOTqgVVYmrwqlCYS/LRmhii3/IGsL/W4nqc1tH4jGVrcIm+9ovWcJ+5sW1m
         vQC5X3+xZtatRbZ0+2obNGtKcLsDMAnS9JlPDHosx+egc/WAdO5WN8Hxe9wA2i3WiX9J
         7UWzUgawIdn6XaFN1K/YD09h2bnYGs3mdS7BZLB7wv6QVqozNYiI4p0V/KZAhVu9oCUA
         tIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786130; x=1731390930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwQ41DxPwHg/LBZhq9U/e3vXFnxJog0O/oye+eR+OCc=;
        b=UHnKMEKkxeBCIHuuCH6KJtUmU5HEQ96NWGLOeH3OPsCK/eXlvxZqJiOJhwIrTlXddh
         OMa6Z+L9fN//VMG+kwrNNW7pcX6lK/gWzvkmhqtDOeXWCNafhFY6lQKSbbp5/iiVJZ4j
         bemHs4LNNATOr1wy4tB32mdmxCqw/oPluoXHkK/IEBmhldlYPl7joGgWSlI8r1NP+F8P
         dD8C0HPEp0AR03iMOQgBfDCfndCgvwiEz7NjtCyzRWd7KCucZRkxPB+BQFD4o1UzKWRS
         +n6MEAJckVdk0CO8OHIWC0o7Qp4bKT5P2or3vsL0aAEODrGZnMoKC3K2BBl0LqyFTYay
         H1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbUciW63aCcCC5IRyd1oyGhhXiqulcG+8doPSu1EuJhwv90V8+N7GjMkMAFpkHPwCvlk8ozu+rAojtPd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNt3YlJRktrXmmDQ03IL14ffCo5C3iLTdcIYJxqzl1Ag2LRhgP
	vGGZmFWcIF4lX6gU5JgUb3tnTq921cFHWMRDPLQmJUFbSYDkLvPXRJ4Wl6DghDcAMqXcxKUa4ER
	scg==
X-Google-Smtp-Source: AGHT+IEuUBIfr0pmpR1vDVKnUKE8uRFFxdiJcuGz5MS7Q3zeXILMN/DoM1JZEMxM44JWZ8BW2DwV5M3g8tM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:f681:b0:20c:ce1f:13b6 with SMTP id
 d9443c01a7336-210c68cf3b0mr1015755ad.3.1730786130327; Mon, 04 Nov 2024
 21:55:30 -0800 (PST)
Date: Mon, 4 Nov 2024 21:55:28 -0800
In-Reply-To: <172848588854.1055233.16718265016131437325.b4-ty@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004220153.287459-1-mlevitsk@redhat.com> <172848588854.1055233.16718265016131437325.b4-ty@google.com>
Message-ID: <ZymzUI3HnkYMxyjk@google.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: increase guest sync timeout
From: Sean Christopherson <seanjc@google.com>
To: kvm@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 09, 2024, Sean Christopherson wrote:
> On Fri, 04 Oct 2024 18:01:53 -0400, Maxim Levitsky wrote:
> > When memslot_perf_test is run nested, first iteration of test_memslot_rw_loop
> > testcase, sometimes takes more than 2 seconds due to build of shadow page tables.
> > 
> > Following iterations are fast.
> > 
> > To be on the safe side, bump the timeout to 10 seconds.
> > 
> > [...]
> 
> Nice timing (lol), the alarm can also fire spuriously when running selftests
> on a loaded arm64 host.
> 
> Applied to kvm-x86 fixes, thanks!
> 
> [1/1] KVM: selftests: memslot_perf_test: increase guest sync timeout
>       https://github.com/kvm-x86/linux/commit/7d4e28327d7e

FYI, I rebased "fixes" onto 6.12-rc5 to avoid conflicts in other patches, new hash:

[1/1] KVM: selftests: memslot_perf_test: increase guest sync timeout
      https://github.com/kvm-x86/linux/commit/2d0f2a648147

FWIW, I am planning on getting this to Paolo in time for -rc7.

