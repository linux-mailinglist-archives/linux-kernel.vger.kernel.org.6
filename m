Return-Path: <linux-kernel+bounces-322406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A909728AB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187761F250B3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9695167265;
	Tue, 10 Sep 2024 04:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lxYoN65"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1433F745F2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944286; cv=none; b=rnpcQg4tssZIGAwPVCJtzVyA0VxruzA2nuyOZ26Mte+nb2g0QqApMdzxJp3kKcJaNjJ+0q6ygvy9sG5qRu17hn6UH0LDx4cJsU1tbnsKHVlx2Orx96lWfNj9hC2INOVM7NdwfJ3v6mNKL54W2GzqGigOJNGDYsyAEbNrpRb9wpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944286; c=relaxed/simple;
	bh=FANfRBs9745F/n8nS/13ygH9b5OMuZPiI9Otwuh9L2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rJRR/4XQqtYi4W9cehpAdY/9NaLWncbfMloMkaK4P9OuYxVaCKAAPGfeCHvwWF06rcK8BrA7QAwsLTYjcEXUQhRipG0uwxFNuITO9k4RzqrfQ+QBT2Dcfcm7FhZ11zHxB4XZ+fbc3ycHRjfHBf9MRtkHjm7DBBWwLaSDHxrE32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lxYoN65; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-717948624beso6209136b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725944284; x=1726549084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QFB1ugfLL0fxQUREq4PMsDAdlVWDpux+xApuQ6RvIss=;
        b=4lxYoN65hKpCM5Bh624ejHqocL/zx2V58uF9kP+9zrtrEBZ90FWOWadXLrxKzAirFU
         O3y5SUfajHIrCvoTUMRfwPCHzRAGQKDp4G/nmhsCXC89jNy54oN6K+6xCTC5ljqLgfpn
         8DReCWTnhHg1Ta/k2SjKtQ8GiVNonxbg+ICOiZJVYonvcltD58kqXIKgTQsXUCK9wMwx
         hrpYD+rhbI3p1HCB1UaQ9r7Ke8PtUfwMYsiIDd1qTCiRZJAeU+d9+gheYgFvzO2mVD3P
         rXsc1//XbrpC9oINQ/o+j5w7DpjVwxmWAOr+8+2Qnr7ROI2r3eIHQOCYpP7cir10heBT
         4TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944284; x=1726549084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFB1ugfLL0fxQUREq4PMsDAdlVWDpux+xApuQ6RvIss=;
        b=wpgd5kr5c8KmDX7zQts9Y7TG+3OvYxgGnqWCmSnfbBKBnKMyPFE+m5p+UGrfQEaZbS
         VfEsC+9/RqU7AJWvM88Xpk/qMwSgzK1cqA8VBfgcV9Yzmr3FOWM/54BooV6e/odZrhYL
         F1zltbbaVdvjy6xRN5bIFgh8RTMobJOcj2y3UcvMg0nSZf8h1yNUxaW+GVsBA3AUT8Sm
         s4ISotyVw4xgvzFxZqtyg8R/DJI4TKeiskljQV9cukHmjIS8+nMV/SRtqU19NJ3Fm0Lb
         7ifBc8hhAm1EdLWD6/K75NT+9F5NaUnNF1Wo5MpDtFZ9eO+8s2Xcm07cGkO8RsSyahHV
         3hoA==
X-Gm-Message-State: AOJu0YzbsPccmUj7lgJk2TPujoqwJeeCnmfFH+mTlWGxoZo+UM4m+vas
	XbNNDldLbV1PQtRJOd6ad3tY6KRoVaxSDHpyhCe0w373lWARVDFiYoV1eQQc1Fe+5g0ADOfyyxf
	Niw==
X-Google-Smtp-Source: AGHT+IHJ3q9o7Hw+urLC6vWjslGKQ51olv7RabeHao64VlhABcBEZ2h5Qafdakqj5I1Dh9B1tnmEHf1/vqk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:98da:0:b0:70d:1338:8270 with SMTP id
 d2e1a72fcca58-718d5c35075mr86312b3a.0.1725944284049; Mon, 09 Sep 2024
 21:58:04 -0700 (PDT)
Date: Mon,  9 Sep 2024 21:56:28 -0700
In-Reply-To: <20240905120837.579102-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905120837.579102-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <172594250677.1552518.5898875487744726113.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Also clear SGX EDECCSSA in KVM CPU caps when
 SGX is disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 06 Sep 2024 00:08:37 +1200, Kai Huang wrote:
> When SGX EDECCSSA support was added to KVM in commit 16a7fe3728a8
> ("KVM/VMX: Allow exposing EDECCSSA user leaf function to KVM guest"), it
> forgot to clear the X86_FEATURE_SGX_EDECCSSA bit in KVM CPU caps when
> KVM SGX is disabled.  Fix it.

Applied to kvm-x86 vmx.  At some point, we should probably look at using the
kernel's cpufeatures dependency chains, but that's no reason to hold this fix.

Thanks!

[1/1] KVM: VMX: Also clear SGX EDECCSSA in KVM CPU caps when SGX is disabled
      https://github.com/kvm-x86/linux/commit/7efb4d8a392a

--
https://github.com/kvm-x86/linux/tree/next

