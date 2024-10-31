Return-Path: <linux-kernel+bounces-391192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE09B83AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685CE282BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE951CC151;
	Thu, 31 Oct 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTGiUqhv"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792A1CBE88
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404317; cv=none; b=tfp+KQwMfEKkCPrw4VMqRyt3p6BNirbyOQEjrw/fdC3Zp0mb0vzOJ9xl0FyFVvJAWYMHhodcDM7lr5190biPxkcNGJrHFHWb2RVk9XUFt4Y6mrdL6iysOq8aol6edsGFp8Fa6zPMtcDifmYeSpDcF4jjw18gzhJiVveRdZZRK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404317; c=relaxed/simple;
	bh=wLw5iwt2gypufMKb/EV9w0fhXKsOY3s0moM3uYxxFko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s0cVxl1n1F6BxnuttQ7YbX6eya9xWSFcjZGC+QO2jd+fa5go/1DFbgy44eXi4H2HjwrQq1Tunsw08tZf1XAZVCAZhEppRjvp6KxJOxvWPBMtJe+Ba6B7U3OkCG7rmpBRSJDzBAZKq5wUjL4bq5fMpvif8S++u5OEFOBrJxo6I3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kTGiUqhv; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ee4e642954so621872a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404314; x=1731009114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ftx9JHLtQDyGtXwHqfD+2M9M5G9Bcwu3Ym3sXqsUfs=;
        b=kTGiUqhvFD7EjMsty6O1wAoIrHLI/VkBh+hLstd7Ny+VZy0m19UGuD4SZT/gIz1sb/
         0/oGTPmXI1zanUZMkUJu9upP/RhaFDtwAjRHStVVhaPiJMCetV4s3Sj4qW4RE37U9sUt
         KhB81V4oqB/GpKDw9174tylZQMYNTcNhjEdTGlZnhs8SbJBMWb3O79RvfAOMfiAYKG5l
         XKDarzrAbHHWJ25qPqMFTzRwYmcyetnmIm8a2iLghrRc2RY+en9l0sEFCXXULDpsn6B8
         tZHr7PDNElYDxQ0d7N1MGLKZt/Rk2YIj1X7Y5/kek/uSKnaQ55ip/q+JalCc/gtwOGGa
         SeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404314; x=1731009114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ftx9JHLtQDyGtXwHqfD+2M9M5G9Bcwu3Ym3sXqsUfs=;
        b=AA9w05IAtt1uB/Tzze38NHkomaPq89p/DluWV3CMIaljsuD7Bhqfsf/zP5XSGIxZFP
         m3YxRxs3eTHnQ0DlIz9zyKWONFcQE2YoX4S+YV6B4b2YdYLFR8iFOARUwEaROP08jtJ/
         F9EwYgoHVATfcDXC98vEh4EvXLPpNy0HQdn8+yyiVbAxKCoz0AtC9QaIcsUGaY4YQ2Zx
         j3Zjv2oLJNyrqR/gkopGU3FUu3zyMFrcNh0cyfjZw/lLhdO0wzk8OIpP8ChZU0P30sG+
         SUZ908cvIfqrwJchTU04U1N0scyAuYVRYBBnfg4RDooGGd9ivIBWNVA43RCvDeEflGmb
         Q5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqxZlEKZgqReAqzKh+qiEMcT/509dvAUFvhrP/MRpg2/rGhfUAsRuoxC9r59UnHlfRT/OpELzxrWtwCqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1iwMG5+AtUI1pETxIKkJ9860lPajALlOu6PWa2r/avL2QWQ+P
	M6iiVBM8ox98KBzMcbuIvHFzW0cBroBkCGcIBpsXSQSD5ajrf89X14sT9qkyuKu3X45toutq1jG
	96Q==
X-Google-Smtp-Source: AGHT+IFlEZIkNXudx2X7J7YjSx8fHVO7lf47DdNIwVTSOKGkLmjFGPk8e0YZm0RFEMyjBPPV59yEo/X+h1E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a65:4389:0:b0:7ea:618:32b8 with SMTP id
 41be03b00d2f7-7edd7c9109bmr32518a12.10.1730404313729; Thu, 31 Oct 2024
 12:51:53 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:27 -0700
In-Reply-To: <20241024095956.3668818-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024095956.3668818-1-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039504313.1508539.4634909288183844362.b4-ty@google.com>
Subject: Re: [PATCH] kvm: selftest: fix noop test in guest_memfd_test.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Patrick Roy <roypat@amazon.co.uk>
Cc: chao.p.peng@linux.intel.com, ackerleytng@google.com, graf@amazon.com, 
	jgowans@amazon.com
Content-Type: text/plain; charset="utf-8"

On Thu, 24 Oct 2024 10:59:53 +0100, Patrick Roy wrote:
> The loop in test_create_guest_memfd_invalid that is supposed to test
> that nothing is accepted as a valid flag to KVM_CREATE_GUEST_MEMFD was
> initializing `flag` as 0 instead of BIT(0). This caused the loop to
> immediately exit instead of iterating over BIT(0), BIT(1), ... .

Applied to kvm-x86 fixes, thanks!

[1/1] kvm: selftest: fix noop test in guest_memfd_test.c
      https://github.com/kvm-x86/linux/commit/fd5b88cc7fbf

--
https://github.com/kvm-x86/linux/tree/next

