Return-Path: <linux-kernel+bounces-357288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2472996F13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4D51C215BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375C1A2625;
	Wed,  9 Oct 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAEebPt/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DB1A2658
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486003; cv=none; b=YrivC5zy6PsrADeQrF12v3eQfjSaSmW9DjjqfhYz22RI51PzZllKgbs37PYCHFlET0OMp8fLZva5bH0yW2Q8396wwuzRYZEDKDAvMlyvGEKYnKaPpeNPSY89m7UAFEh2WgbCHhwRFnit5SW35oJ1/93PNZECDNibSj2paR3dubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486003; c=relaxed/simple;
	bh=LGY4oUqQWryGMKVmPMGwdkvn25gik+HeWTMLPKKxQyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NP1wzWPONZJ2gaJgw2D0HQAwhw+1b7owAmoD+ujTd79LaojF+h68F6coq+bPhpWh1PiihFfO004F1klE4n4J4c9ozcuunCYKFoi+jV8Fs0ZIy+yfmTmXkTxnb7IrH8bQC8b/NuaWIaUU/gsTLxDvxoEDBPKOuN3+DycNkfCkjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAEebPt/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2270a147aso103046997b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728486001; x=1729090801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0uUBPQSFAQQIdkTMB/6iIcqnDNVMg8rmlOcTA+5BoE=;
        b=JAEebPt/5nRYD7wkHEjunlzSc5DGrHq6y7KbEhM23jxI2b93B1PGtD21vN0A0EEVbC
         vr2d8RoL4Q27UK+xbfI4UfCoZEjnrXx8CNBicAeyx/bkCahvgnkubFL59xwC8AWzbvQw
         1jV8rst0TYI5ciuxXjU2my/nlJmse3MWLYL88lG7stXBpMrBiMnFgylI0KtLM5klbmPI
         j0wuJ7gS/weC+qSXBaPrO/D0M+zzAy//mX4E5DQFRh/GfTQbkdbpeLXZm1sF8LnNJc4u
         1Dvz8hVIv2Yx7KJkN9onxlTqxY6UHuXR1VrPbzvjaP4lFPor+RIMUZ7XoNsc0vJquPrQ
         2Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728486001; x=1729090801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0uUBPQSFAQQIdkTMB/6iIcqnDNVMg8rmlOcTA+5BoE=;
        b=SXU7UGnYVLabbfSZAJVYb/q950KpAjx4G9SGZFdT5+sJkrpBC0vxFldxbp5ksPLdac
         6/2pEzXU7joQRqvImw6mAzOQI7toM28JsLgHiCdebfh/Tr9qYHDN6cHHI1VPrfsgckpM
         +kM3TShliSEVM0eSrm0fAfwa4A1d7yZ/cFEa6BITal/F3Bdt/tR6EDVGlb1X8wTmkLjq
         U1uzGe8xLLyyt0b3kkfk204TH559nLWE17T4KaI6ULjqMhJbGX+InCQDVfw0KkB9Lvvy
         WClEyR+ny0FPhwQ8AbaPupn8k+qk1sF64erz+NJg6QaU6KXgMb2SHMkNjFZmf1YHY5qT
         oKrA==
X-Forwarded-Encrypted: i=1; AJvYcCUrIFfHpXU8B730+IF2KRnuAr4MYt13ekTKXL4yAU4v8lMYOEkdOI5D4hPdRal/U1GST8vMtoiHd210M6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAyiViDRBpDX89GE0Zb4ccv4J+ircYIBgLlHeaoaJg0vgJDRSD
	+R/FY6dtqmqcedZ4laRfOLKdL4gvPQuOJP6cSjDhm+K7ozb7jj2Zzfur9kqKYkT00gX41Qi4Zl+
	cEA==
X-Google-Smtp-Source: AGHT+IF/nkuM8mTX6eEIPtpXC3uFcim6/FbrmSBU5spuO/mMq9bhEb/S7uXyfA/6mqy+WzaQwvCHjRh5kYw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a0d:f043:0:b0:6db:c6eb:bae9 with SMTP id
 00721157ae682-6e3220dbc31mr347747b3.2.1728486000856; Wed, 09 Oct 2024
 08:00:00 -0700 (PDT)
Date: Wed,  9 Oct 2024 07:58:22 -0700
In-Reply-To: <20241004220153.287459-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004220153.287459-1-mlevitsk@redhat.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <172848588854.1055233.16718265016131437325.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: increase guest sync timeout
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 04 Oct 2024 18:01:53 -0400, Maxim Levitsky wrote:
> When memslot_perf_test is run nested, first iteration of test_memslot_rw_loop
> testcase, sometimes takes more than 2 seconds due to build of shadow page tables.
> 
> Following iterations are fast.
> 
> To be on the safe side, bump the timeout to 10 seconds.
> 
> [...]

Nice timing (lol), the alarm can also fire spuriously when running selftests
on a loaded arm64 host.

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: selftests: memslot_perf_test: increase guest sync timeout
      https://github.com/kvm-x86/linux/commit/7d4e28327d7e

--
https://github.com/kvm-x86/linux/tree/next

