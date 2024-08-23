Return-Path: <linux-kernel+bounces-299780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41795DA05
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584391C22178
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D71CCB33;
	Fri, 23 Aug 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYapxf1F"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4E1CB326
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457500; cv=none; b=WhdTihxKmMP6T80grNkV5ca2t7CoOGl6KLon4b63nKKTiSstUTqfCDw59rlxvbhXvNl5mt8XLqh8epx7bntMCUaQ8b4IRXpUsXdH+eJgma5IWXZkD3uEZGVuh1lH/DOCGUvt+nBKXj9Jq3ccwOcL67f1jjodcM4XTnsLe5PyvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457500; c=relaxed/simple;
	bh=iwDzKRZnG4hlMNX5TjZTWIkoP7zyKuWwHE6qz8B9Lng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ano+kw7B/sqUwnL79lRCM5GCsYvWmuzc1DhGQWoZyf2yIogv8+Ajr0gkwL9kgy84PVvgSG0ubXAzAGVvuM9Qw2SGetZTyXSq0TwlgwszugXGuynNjD9pr0G36McIrrpok1zrmXSSumWvknU+G23aQqIEjX69B343gI+TftQdzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYapxf1F; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7143ae1b4d6so2042517b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724457498; x=1725062298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgSapDmp4NaCPBPiiI85f5G2uulp/d8xCq2rC1N7MJc=;
        b=eYapxf1FOIyPKhM4rQyxfSXkySrzEwuv2oW2b7Od3s8O4rbrhbqvU7TNi20arLXVpl
         N5wUFQVdqcMeg9Z++nOHPYROED+NPrRtmTTtlTn5oiUk0Lu9w5wVjQns8EmkYpJanqKN
         8MNPQr/sWhzRY0qd6GDP80KfNo4G1cA7gtppgC1/skAlSzH2rNWD5QyCwolCFJHgpvs2
         Hecnj+Q8bKeBjVvKV6cNs9p3ZUyGutRNvMn2RKgx2AO6+qhBAMIat4aXTlPiGCQ/mog5
         +HZla9V6gqVHHMkiIgQN06zWc7S3VqpgQj7YUxJ+z+q7QRiq7ZTVV9WCzYAIwBuV+C44
         0jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457498; x=1725062298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgSapDmp4NaCPBPiiI85f5G2uulp/d8xCq2rC1N7MJc=;
        b=TnF0RAdC8yVZb1r1pBn5Qxg7QySG+ooGfBoKlzLwjScluLaYXgCnvRbtb3PT5bG6ej
         DaO13HmHU9MtWHKRqLlfq4yz2Qf+D9wffNHDkl2mYn8U9DJ7+fJip0egnEs3wx2C7+Oy
         Xa6jvOKCT5FpzHOL7lY/gii4BTNtQU6Ojc/ScrZ8h9iHMHArgVda5lUUgn3YiocuUs5W
         RHkw5DkfzaxctPy9BC2gu6nFq5LWaQILLk7HngVT4bm0qn7H9Am+pKfq5KoaNKxXJcg9
         wZmFEW1SPfOuzpnx+xPacYjN4YVk4doke2bFwcjan00+/suAken62x1XXXx2bA3qDARh
         Hj2w==
X-Gm-Message-State: AOJu0YwatnAucVECJ1JKIn5kmd+2S7irjEKYBCxhohqEXs33Pdf5jwCc
	ZDd9OQwIDs7VLzFeDuvr2B0WbXlGvwcu2BmSW2CvjQ+JNJ1IENYPGoNAL64tnSAWi5MxWTBIEJc
	tmw==
X-Google-Smtp-Source: AGHT+IE1d8TBDLwGkrW5nVVxwcQCpspHPcAe8LCG0VEYVFwXoAKUvaGGZvcSC3fjR0y0NNZOKfUsm/QJkaU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2f57:b0:706:3421:7406 with SMTP id
 d2e1a72fcca58-714457d564amr23733b3a.1.1724457498052; Fri, 23 Aug 2024
 16:58:18 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:48:01 -0700
In-Reply-To: <20240715101224.90958-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240715101224.90958-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <172442194175.3956558.4839132385632552650.b4-ty@google.com>
Subject: Re: [PATCH] KVM: VMX: Do not account for temporary memory allocation
 in ECREATE emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 15 Jul 2024 22:12:24 +1200, Kai Huang wrote:
> In handle_encls_ecreate(), a page is allocated to store a copy of SECS
> structure used by the ENCLS[ECREATE] leaf from the guest.  This page is
> only used temporarily and is freed after use in handle_encls_ecreate().
> 
> Don't account for the memory allocation of this page per [1].
> 
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/1] KVM: VMX: Do not account for temporary memory allocation in ECREATE emulation
      https://github.com/kvm-x86/linux/commit/d9aa56edad35

--
https://github.com/kvm-x86/linux/tree/next

