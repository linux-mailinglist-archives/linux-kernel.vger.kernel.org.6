Return-Path: <linux-kernel+bounces-201549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3958FBFDF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C38283F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF9314D6F6;
	Tue,  4 Jun 2024 23:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrbSCWrl"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFAA5F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544081; cv=none; b=cGYB4Hf4AvK+hnf4MW2UJpQL1Vanc+swyVHu7Wd80u8AsV1yJEItQr2z9lq3iM7tVLp1fWpXpK1199oNBrVqaDZGRr/7ARSHKizuoO+SRtTEIsfZx+QZgP4eqrS7oE5dvTNP++a1H72mLUNc9FZJledjcQzvaLIxSxqOJHuqy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544081; c=relaxed/simple;
	bh=/RyllKS71H+IC820enjmIT75ZvOYvn2A1K/k4ayEGS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JM78XPaPgE4Auh7pf278Tj7IvqntFU1sXs2mGjbRhr81c+SEWzRC4P0K5FWYT7UknTuGjZptMZ7aIQ6XUoc+MAjCCb+Yju/VsaqPGjezDbnjtWvKO1nvC8VxEMpdaEZANw+ZjhE7YlqJibg13QJxlsn9eMGdDzTPxedwDzTbnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrbSCWrl; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6cc288a7ee6so254603a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717544079; x=1718148879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WiOlI2KgvibXBloj2qE38W2kmcg/QICR4XC0NHpgGeA=;
        b=RrbSCWrl7cPBQ679DsI2cMdWhp/tUoKClRowOdGsW2SGFl+twxDxIUPa65t0xPbKcJ
         87QALdPajRHrFubf3hqe7A8p/Rjgk6K8B60gnvbWcacLK+mlRaxMmDWQekmUGjLOxQwX
         p+lx5SEQt1dmdjYtHElpY6FDUPBt7mdJvnRUncVAWIp8E04dm3oIj5iA8gRWkORD6wrh
         eXPLFWWVA3y0wo79qRZodypujBwiWyv7ms60c+8LRofvyF4313MOpBeUYrIZQqgg4DFl
         CbqN80KkVaV5SRUjbi74Q8PSySRtx6OXdnn4bZTeRNEF+y1lDHJIR71k7PRFNe00o5HW
         0s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544079; x=1718148879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiOlI2KgvibXBloj2qE38W2kmcg/QICR4XC0NHpgGeA=;
        b=TAjo8Povl2khDZssQIWdVsJqzaUPaEoE82phXjoE7zW86ZRGiiE68FKM8VDfdfmA3P
         UmhzmYRKi2jg/LWU6cot6gipLbJSK0i59lQsPfSDNSGvSpfaDU9hp1JVoZHSdkgSYc/X
         zw16ZTItY327HyNpTejL1MjM7myyaHZg0jAXaoUUZoQvAWnS18PvxAz7WWQCXPG1FDde
         XebiGwdnCOlcSt58CvLU9ZFpSXFDv7NLBjnwmQVjKBdrUVt8T4SiY8YEqYT3S+ZOzpwd
         +UpT2l0PLlW8IYKs2DsmGzAu0TPOY8v9Z933VxKodPTVKOcpcUVG8oqu6awMWZEUstrj
         /jkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaWRGV5z4oAz6Ypdp1XoBWneybXXa+ZHQ9QQepdJznNJH/RwskQj7GWRSDYIjAonelSOD+4EXX9WxuW/Tqk+3Cv/gxKhk2q81tEqnN
X-Gm-Message-State: AOJu0YywEZlW1OMhqx39RKcgWRmokFHwkzL3ZIG9+YIz8L9Qic/eBf1j
	pbKVqH7o+h4m1caoeP5Dpq4XA+qS43kp2lyvJO551v9bjXiYWnwfsQTBXWmkLS0XB7NSgVHEB4C
	qAQ==
X-Google-Smtp-Source: AGHT+IG9/QfGlk3w+QqLKKOftRIh42oh6bp6yqD4YsiF/v3U3LPU8jLyNQQmMLcvrkoGApD1kHD0qQ+VMT4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2309:b0:2b4:32df:9b7b with SMTP id
 98e67ed59e1d1-2c25300652fmr48802a91.1.1717544079451; Tue, 04 Jun 2024
 16:34:39 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:27 -0700
In-Reply-To: <20240520143220.340737-1-julian.stecklina@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520143220.340737-1-julian.stecklina@cyberus-technology.de>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754323407.2778815.4127978352090083510.b4-ty@google.com>
Subject: Re: [PATCH 1/2] KVM: fix documentation rendering for KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 20 May 2024 16:32:18 +0200, Julian Stecklina wrote:
> The documentation for KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM doesn't use the
> correct keyword formatting, which breaks rendering on
> https://www.kernel.org/doc/html/latest/virt/kvm/api.html.
> 
> 

Applied patch 1 to kvm-x86 generic, thanks!

[1/2] KVM: fix documentation rendering for KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
      https://github.com/kvm-x86/linux/commit/f2362c04752c
[2/2] KVM: fix spelling of KVM_RUN_X86_BUS_LOCK in docs
      (not applied)
--
https://github.com/kvm-x86/linux/tree/next

