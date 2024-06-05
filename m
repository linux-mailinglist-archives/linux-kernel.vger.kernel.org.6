Return-Path: <linux-kernel+bounces-203384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E38FDA24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4946283EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FFF1607B1;
	Wed,  5 Jun 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RN02Ew1r"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1414A9D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717628605; cv=none; b=jeGG8afwgP54c6NzOJRXGrQCS83qMIghqwwCGScOarphNF8FoUrTfBUeOpYZaPYbARZ7Vnc60Hv4HP5sMiAbhfpFE+kZvl05zeA9+pAWALO4q8RPay/NUYDI8A24torUfh/YAxaUsVKwUcZnBB9RgOu1VxGSNv+uisJn+kfOp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717628605; c=relaxed/simple;
	bh=QUbuJckx72g7RO41A3sNIJ/bb4RwQEfYxjj0tregYsY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=U9wi7setlEou1fbhqgZt02P+AMZkeBUtG4ED6kX7Yr0aBYlExRe+9zunXG2TwcyaJF9rQYZiofYI/X+qnLzEDFuwGvgGO587bdbepTurXlFCNTYP96D/EZX5kknh9hoNU3h7DPzIo8ZwBoHo6saLxZkZd5+zn/7TOKTIYwqV0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RN02Ew1r; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f6792bf633so3952495ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717628603; x=1718233403; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miTkXlJa4EIcEsU094faaHjwR6lQj9q1y7dTBhrF6/k=;
        b=RN02Ew1rZoSO27jXUOpD8OQD6P4wMtKnyw9E+T1IfdZtbvJZJwcJV0aZ8PXrgmSMWg
         CsIh/CHm1oi3h7WyUjpvQ+kha/vMwzbg6+1j8/Ezhk6A9tCbAwms+Gquuy2aIwz/0m0k
         rCUOI+aNS8qeY6iHcgT6cnLbkpaUBfZKwBjpwTIhkvXvx7HkELA2eJli7A/i7sXJodf2
         RjtPa9WOrdjkk/UGIcDIo+1D6tVRqZsT1DViS7YlQwo7pxQH4XuPy5nW1jDvgtJlCvL1
         5BSfka40lIQqrDwVEy1mB6bTlspqxHHenfC1dkoxmUaxizth0U6cCI/54zHaSMBY0YEs
         U5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717628603; x=1718233403;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miTkXlJa4EIcEsU094faaHjwR6lQj9q1y7dTBhrF6/k=;
        b=sgaYwqrAiE2rn6Z8OW7Bwi5r4bHSaqmkfEA4OoMrmFgKKonJpFkXAaipzSdhi1D639
         CNNqf9KLi2GMSeZaGrAsy3UPpffdcVCtalUUEjIq2jWapE27VdvxlzKURj0eE8epBgmy
         G0NhksqXzM5yflzoqlSFv+lwA4DVdwVftxojBS3DyDfJVsPzTMddnTxnJtOAs+AQV/4G
         DmkAlXpmsOIs8vSMl0z0o10DkWTOCFeKBiQQqiTMH1hFeHj1DolTmZGGtHr4GuQu8Mhy
         oXA6/bMa00C9zOBZL7EilK3P0i3mJNG2A91BnBxcxI3QSGrO6vAmUf3u03ZvXQenqAbN
         vqtA==
X-Forwarded-Encrypted: i=1; AJvYcCVz0IEvZlNksLHoW1a8b5dmUMpC8C9wmXwqOVSV/VSzYNUOCa+o5L2UhlP4VfAB12oPo1OCxlHE69tj+NEzNb2zgBKrb9eWhUY+DXdy
X-Gm-Message-State: AOJu0Yw2wzlIar1GdsYql/eZwnPEo41hIbwgD+BfMw6Nrs72iuiE1Dkv
	j6/PPZrijkEszmdm4jC1w6ck52l0LgfA9ggDjbGC537wd3fpdSNAxWTF6wQSNBMu4IqtX1e6kZa
	0WQ==
X-Google-Smtp-Source: AGHT+IF9mAAf0bAtgY3ZePrlJPFwwc/KQDJUOAzZ/l765CJfNgpNB6g0IS2VPP9R/C6+ulMCotjVfOehcIY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ecd2:b0:1f6:83e3:fae9 with SMTP id
 d9443c01a7336-1f6a5a0a9e6mr1524915ad.4.1717628602851; Wed, 05 Jun 2024
 16:03:22 -0700 (PDT)
Date: Wed, 5 Jun 2024 16:03:21 -0700
In-Reply-To: <20240605224527.2907272-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605224527.2907272-1-seanjc@google.com>
Message-ID: <ZmDuuRTkG2Y1LcTR@google.com>
Subject: Re: [PATCH 0/2] nVMX: Ensure host's PAT stays sane
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	Xiangfei Ma <xiangfeix.ma@intel.com>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 05, 2024, Sean Christopherson wrote:
> Fix a bug(s) where test_load_host_pat clobbers PAT and causes all
> subsequent tests to effectively run with all memory mapped as UC.  Xiangfei
> first noticed that this caused rdtsc_vmexit_diff_test to fail, but it can
> also lead to timeouts if more tests are added, i.e. if more stuff runs after
> test_load_host_pat.
> 
> Sean Christopherson (2):
>   nVMX: Ensure host's PAT is loaded at the end of all VMX tests
>   nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT MSR
> 
>  x86/vmx.c       |  4 +++-
>  x86/vmx_tests.c | 10 +++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)

Doh, this is for kvm-unit-tests.  Been a while since I sent KUT patches...

