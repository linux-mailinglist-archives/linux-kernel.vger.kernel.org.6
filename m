Return-Path: <linux-kernel+bounces-171564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F98BE5C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE481F23032
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1BF16C84B;
	Tue,  7 May 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZOYk/qm"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8116C686
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091692; cv=none; b=HDIpuJjPHl2R+rQ1IvkyLJCgi8Q3H02lz+bDtD0h88vVGZo+HoRyAGGFWNCE6WqYk2LPqx7xnQD+ozHMP0ziiE0lekAsP7sPmrSt3loCpRIhsIdKj6fEiW4H7cgK2IbbJ4+EQQqJItf6I+qdtsTDUyeUr923O0BgsY2/ZHJqYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091692; c=relaxed/simple;
	bh=8QYdibYVRNGlJBkqihgTrWLMvE6OLOwqy6jEWIRcti8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbC+57uHV70/8w55TtS+wTQL4IflWM8IKZdIdCK5hUvAIpj+NVDHJnX+bFubvySewfKKruSmmLM5JTG+52cK5srGgmKZvZdVEGHuHr6LAgOAeQl9ni89bNE4g8HsNhmvP/PwF/jYwamZlqwM3ksunwMKRZQW+qXcTpDNlBjEYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZOYk/qm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54ccab44aso6489442276.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715091690; x=1715696490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WlQ1ODIcC8LnzvsFQdv3tqPlhpmjYXCiPBeyIiWiI7o=;
        b=FZOYk/qmgGxpQKKrmMyDY5df994gwzVMb+ejlxrGSqcP1HxZ8qofU8HUg9SqiNnL45
         029oQAeOXM7oUx8N4zSfZ6Dike+MnZZ3b7zAAdYf0fy7PZZU2i8c810m3LJBkf7f3xwb
         +xm7DRTKM1H/dhb/qABxLdiawlpIejGtVzwT2wE75O5KKrlH4X+/9SCHFpnGM4eCAjah
         TaX9VlBgTqnvCVwCNhbth5x9IFdB5hwr4zol0qUCLVpDQi+RE4vCrJ2x0NEpS6Pu0OuY
         /8sq8ZdORlhuuOglfY3tJk9TL6ff3pXWjhofWep5frsDmqDyHh9ivsq+0lp2+pBvt2ol
         mCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091690; x=1715696490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlQ1ODIcC8LnzvsFQdv3tqPlhpmjYXCiPBeyIiWiI7o=;
        b=lK1jBH3U7BxNdyf9fP3FAcew6D5PSbz++UGMTJSynJAjgPxhLSZB6zXfcOKyLW4fLk
         8Z9UJNEBYedlQtmfsXRAOU8NIX7T6/9rAkGQiFuMYGXpihwO5aH5yrycvxKbZ3n1rmso
         yk5B7WMb8ilh3nYKmGn0/EaMjRlHuGfdNZ6NRky/oj3jl8weniZ1SOqmAm/LLQ6q6lTP
         i2m2tOZbAVP4iPHUqsFxNiXnopHOPBrJX5nPj8xebToy0jVmDFbrAvtdvJl1xsk5zmxS
         R8y7S+4UUEF6gL06qYBMVzoU0ya1pZDoVvWuzZfjsPknGbqSETxoCraFTtpRWtnz2AJ0
         aNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkBYQ2vZ5AXsQtD2Kc7GHYbiCpPP/Yf7nkGz5xwfHwdzyzU320m95T/WtMkZNmSSmFfFa4g/Bp+S7QRKnStPZlSn4CLnWm6ARUKpF9
X-Gm-Message-State: AOJu0YxBJZlQfkw/UfXVusaeJly21ERRp7Xgqw5ItIlLTb/C1mhzCQlm
	EKlU3/o96uny7G6IYTbWhj+8+fUn9QQRDtqIP5LYSzXAVebYCuDTPBGO+vGgMr3Efatsi0MOWYV
	lkA==
X-Google-Smtp-Source: AGHT+IGQflJmsb6ITkvKxK5+27cDVP96WKoxLdJLDdOq9myYIbuYllja2Yh8BEpJiRr7bbUZVOQJEVjPros=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1004:b0:de4:7be7:1c2d with SMTP id
 w4-20020a056902100400b00de47be71c2dmr4460818ybt.11.1715091690487; Tue, 07 May
 2024 07:21:30 -0700 (PDT)
Date: Tue, 7 May 2024 07:21:28 -0700
In-Reply-To: <8a6c88c7457f9677449b0be3835c7844b34b4e8a.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219074733.122080-1-weijiang.yang@intel.com>
 <20240219074733.122080-25-weijiang.yang@intel.com> <ZjLNEPwXwPFJ5HJ3@google.com>
 <e39f609f-314b-43c7-b297-5c01e90c023a@intel.com> <038379acaf26dd942a744290bde0fc772084dbe9.camel@intel.com>
 <ZjlovaBlLicFb6Z_@google.com> <8a6c88c7457f9677449b0be3835c7844b34b4e8a.camel@intel.com>
Message-ID: <Zjo46HkBg2eKYMc7@google.com>
Subject: Re: [PATCH v10 24/27] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "john.allen@amd.com" <john.allen@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Weijiang Yang <weijiang.yang@intel.com>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, May 06, 2024, Rick P Edgecombe wrote:
> I don't immediately see what trouble will be in giving kernel IBT a disable
> parameter that doesn't touch X86_FEATURE_IBT at some point in the future.

Keeping X86_FEATURE_IBT set will result in "ibt" being reported in /proc/cpuinfo,
i.e. will mislead userspace into thinking IBT is supported and fully enabled by
the kernel.  For a security feature, that's a pretty big issue.

To fudge around that, we could add a synthetic feature flag to let the kernel
tell KVM whether or not it's safe to virtualize IBT, but I don't see what value
that adds over KVM checking raw host CPUID.

