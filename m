Return-Path: <linux-kernel+bounces-288224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83DF95379B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5205B252E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F01B9B59;
	Thu, 15 Aug 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2yTWgNQn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B61B3F07
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736777; cv=none; b=FXU8/b+aZL5Fdv2Vd5z+UppKmSWPNpJ8WFahlby7P2hl+YzfeaoYah6VS16lETCd1koxQW/Qr8pdfj9yfX7ehPX2r4E0FRqo4q9pvfLIsAf9/YopibMqXq7n2FH0sEIYjNJ6vCSLma7x9Wwde6YaiLA6k5oGfQ0cSufpbuANvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736777; c=relaxed/simple;
	bh=ws8GfdSUu47l+8to0xmGScRHYvMXMXBZ18WnnqVNqf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hcJ0pJTj+mu+lZcrusH5gyx+6x+xJYdECQha0HLgUjNPXuG2w/gbzxEuMy7QWT8DybS+lX0UKkl+gWxC6olIS1Y7BI2agMfgtJHf23Mf/5t2xegQS5CkuyJH7yKwSk7tRyD4lHDeYouZYgEMkbMYLGB8UI9Irxo3jdzEd+LkPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2yTWgNQn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc691f1f83aso486331276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723736774; x=1724341574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AkcXZB6modEdwkxtKeqDp/qh9BD93b7/021rd0GWwg=;
        b=2yTWgNQnI6EQjkftVc6NOS8ObTbqj0kGFLVPv/kQ4/GatzWdv89mOunS5q+coMcGuo
         j82UBB532n0ntr8vQVsyK6ZC+i1iW696b9EYvID60qgg38hmtHIVzWOZ47q5KhgIkPh+
         acAqKxdaGX3AePky7OAT7v3Z4nyM70lQZpeYgiVhpYts8uxn6084G/5JSPE4ZOmaQB15
         faolPEU0s6Tyjy3rwEJTML8sB2rkvtUyGr6KxmDYFpfrqLc1QmO1mEBWmu/gh07Imxgz
         wxgC6zKKyn4nyb4D1FsWSXdsPQku3Dy34OH8LHRvrtZNA6m7FRacYUObeP132qP6s+gC
         SykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723736774; x=1724341574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AkcXZB6modEdwkxtKeqDp/qh9BD93b7/021rd0GWwg=;
        b=sMOwAHAo9vjapzMMiBM4X5MW9kmOBi2Zw49DGuuaWSEUoPHiTiktDrR4NLbkIVMBg+
         8CpGC2V9Tlkz2w2ewSl9IsT454fDSZiIb0HalgLiKld6MjhkzleFOUfGFOSQD+4O4iLp
         yj6ADlX1zcKXIA+JgR3fW9vrHLQLoHvWu7u5lICoZ7ToFxI1gRLPxXlMKjWk+Hq/7hqb
         StkG0je2sk97723CPtS0dqguADWRuCe+APgUuWC83EExWrlE+1SP1VuO+CxI7ZiAErrn
         x2ieuyX9aALexTsJRQGFyGWaf9p1TKBmxrAd6iiu+1n7HCfQqCSeM3UHviMgdC7IVTLJ
         yKlA==
X-Forwarded-Encrypted: i=1; AJvYcCWzblUx9v5YzD2dPCnhvbpSwweYfSIPopfMbPgDLVZTK5M2eLNtroMoIU8OLiql3cUMT40+ANNo9Ud1e5TXpsm2JdujA4wdRsrnWgux
X-Gm-Message-State: AOJu0YzX9sswzw5ytQhUSQ3b3ys71z2bAMyYdOqkPdjxZC0uQ+5n4YbO
	mvFs8SKm1aCGhx+KaIgfyL3iL/UdItVAEo9XX28TnKYT9O1G8zG0UlgCzdOhCVDf2z1RkTwb7+r
	4gA==
X-Google-Smtp-Source: AGHT+IFPglLKZPMGHJwVXlvcv72/tbAsvnR20LyLqWwDc+ZPBG1oo4ecJYW/lensDz3nlnwxMPoCR/Boa0Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:901:0:b0:e0b:acc7:b1fd with SMTP id
 3f1490d57ef6-e116cd9ccbfmr101155276.4.1723736774549; Thu, 15 Aug 2024
 08:46:14 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:46:13 -0700
In-Reply-To: <20240522001817.619072-12-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522001817.619072-1-dwmw2@infradead.org> <20240522001817.619072-12-dwmw2@infradead.org>
Message-ID: <Zr4ixaBGnk_6Zqef@google.com>
Subject: Re: [RFC PATCH v3 11/21] KVM: x86: Simplify and comment kvm_get_time_scale()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jalliste@amazon.co.uk, sveith@amazon.de, zide.chen@intel.com, 
	Dongli Zhang <dongli.zhang@oracle.com>, Chenyi Qiang <chenyi.qiang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 22, 2024, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Commit 3ae13faac400 ("KVM: x86: pass kvm_get_time_scale arguments in hertz")
> made this function take 64-bit values in Hz rather than 32-bit kHz. Thus
> making it entrely pointless to shadow its arguments into local 64-bit
> variables. Just use scaled_hz and base_hz directly.
> 
> Also rename the 'tps32' variable to 'base32', having utterly failed to
> think of any reason why it might have been called that in the first place.

Ticks Per Second?

> +	/*
> +	 * Start by shifting the base_hz right until it fits in 32 bits, and
> +	 * is lower than double the target rate. This introduces a negative
> +	 * shift value which would result in pvclock_scale_delta() shifting
> +	 * the actual tick count right before performing the multiplication.
> +	 */
> +	while (base_hz > scaled_hz*2 || base_hz & 0xffffffff00000000ULL) {
> +		base_hz >>= 1;
>  		shift--;
>  	}
>  
> -	tps32 = (uint32_t)tps64;
> -	while (tps32 <= scaled64 || scaled64 & 0xffffffff00000000ULL) {
> -		if (scaled64 & 0xffffffff00000000ULL || tps32 & 0x80000000)
> -			scaled64 >>= 1;
> +	/* Now the shifted base_hz fits in 32 bits, copy it to base32 */
> +	base32 = (uint32_t)base_hz;
> +
> +	/*
> +	 * Next, shift the scaled_hz right until it fits in 32 bits, and ensure
> +	 * that the shifted base_hz is not larger (so that the result of the
> +	 * final division also fits in 32 bits).
> +	 */
> +	while (base32 <= scaled_hz || scaled_hz & 0xffffffff00000000ULL) {
> +		if (scaled_hz & 0xffffffff00000000ULL || base32 & 0x80000000)
> +			scaled_hz >>= 1;
>  		else
> -			tps32 <<= 1;
> +			base32 <<= 1;
>  		shift++;
>  	}

Any chance you'd want to do this on top, so that it's easier to see that the
loops are waiting for the upper bits to go to zero?  And so that readers don't
have to count effs and zeros :-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d30b12986e17..786d5a855459 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2417,7 +2417,7 @@ static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
         * shift value which would result in pvclock_scale_delta() shifting
         * the actual tick count right before performing the multiplication.
         */
-       while (base_hz > scaled_hz*2 || base_hz & 0xffffffff00000000ULL) {
+       while (base_hz > scaled_hz*2 || base_hz >> 32) {
                base_hz >>= 1;
                shift--;
        }
@@ -2430,8 +2430,8 @@ static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
         * that the shifted base_hz is not larger (so that the result of the
         * final division also fits in 32 bits).
         */
-       while (base32 <= scaled_hz || scaled_hz & 0xffffffff00000000ULL) {
-               if (scaled_hz & 0xffffffff00000000ULL || base32 & 0x80000000)
+       while (base32 <= scaled_hz || scaled_hz >> 32) {
+               if (scaled_hz >> 32 || base32 & BIT(31))
                        scaled_hz >>= 1;
                else
                        base32 <<= 1;

