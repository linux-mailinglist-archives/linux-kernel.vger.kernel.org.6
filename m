Return-Path: <linux-kernel+bounces-539012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F34A49FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3573B6033
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574DB27002E;
	Fri, 28 Feb 2025 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqvGWLM6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3781F09B3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762454; cv=none; b=B85Re9AMtFoq6kNe53uNaGAYIpTSf8Jypdh6lKMbx+KWkbAemZbqACq97+j2M7+dnOzdXoEtNnbeRwYPpEz1Ztjjuem5PZEkLIjUwdFodDBkuKDIoaTcprreGvqgY2yuuwZi1z0SsqVKaKDcNMXlHk0C5hXPWexO7fF2xhjkkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762454; c=relaxed/simple;
	bh=w7y2s0B3QwmL541+KhqH3zAEMb4igdVlTd1+RqXIW8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F/aQCFClA7Jjz+vizCajyFuKC4t/NDfLl4TeErcFAYFPI0TQmV3RcvnqPD6mnA7N6JtJ5HLkKhaDxjD07acLNH80h/Lv8RC0mR8e8eWtEs6FqdJ1bAMRjB5iL9Slnoce9ZI4llwYGhZ0toADh7ERoxWAM9ephQkSDV58Y0ZZXQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqvGWLM6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8de1297eso4935803a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740762453; x=1741367253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=11RyS1qAmuD2mxkuzJ3XfGIHqJM7lrBNPnN7KbZ8xI8=;
        b=VqvGWLM6jTzCujYKkmlc/QoaKfG74CcKbaPrtTje9kDdUTmUJf+dTL4pUhHDJKoLPr
         S3wOtfseqbloipEXxf2XIHrJZ5qyqm+5xW2Qu1GOsPbuiYPJ3tssTNfkNaSu1ZCOw55W
         f4+AMOyGVoYt6FZAlc0cZUk2AiHothhLRCORB2TuY2MShXf0mFyNnpO3rvOUMkytKcvh
         +UK5lp6rybfxC6YZ4ldT9Lux8Jfhr6pSq908g1xHyGF1ao2mZNd2yCxpWSGTWZFCZv/A
         ncGRv5QmN5eDHYRqVRXDLZR11I3A2VvNK2yXAGEv9D6LYY6JqvMSRhzlmKXO5OOK2sT6
         owJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762453; x=1741367253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11RyS1qAmuD2mxkuzJ3XfGIHqJM7lrBNPnN7KbZ8xI8=;
        b=uBPoAnoBkM6xMeheIewijqCGFEy5fIR9GtwivEpyV2kzfGJwv/gvoyn0VGIyuzJ6pi
         nOaywTU5nrXeQ0fmU/ffECLP+zXEqZoVcot+XsEygb4rmt3F29kEe6HZrV0Q4GRRfCd0
         FnESCziuuMZFR9yE5+AM7FXTyw7epG3QuMt5zrlESWGGhyf/b23FasgzbnFy8++xg7oU
         tRz3PO8V0bVcoy+0wZEph5u3NKlLfj5ZZrO6a4Q2DEEf4ElZnIPqF3lJPhPTHeqvYTFS
         TXhraA+iDW/o4C/zOmCg7xVXzXj7dZpbmlvM/HbhPOYzpioD8PEsP6ZP/DpEozcxhlQR
         UB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVslxN3qyv7Xh/4aPLEwjQ4QkCdJ8xIj/QaoP6phJM7eMCsPI24xgzC1HKW26O/ZHTg/qugWo6C9jLsxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yWfCoIpOv27Fd1QVznhjmHH1Ct97omWu373eXDBtSFMA7sJQ
	VmsVWhQkUCWLLYMpwC+Q9SjueiXydUnpx0F5MNpIJ9ckOIpXzKqCFE3DPMm2/uOe2fIBXpTNmV2
	jVw==
X-Google-Smtp-Source: AGHT+IGtepwM5F/LuyNwPFp9mL56IyVr+JkjAT/Y8+92RjrJh08i369mOA2z0npcbf4ntgKlYhLbbXLng2o=
X-Received: from pjbsy5.prod.google.com ([2002:a17:90b:2d05:b0:2fc:b544:749e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:498b:b0:2ee:8253:9a9f
 with SMTP id 98e67ed59e1d1-2fea1346613mr13467504a91.11.1740762452710; Fri, 28
 Feb 2025 09:07:32 -0800 (PST)
Date: Fri, 28 Feb 2025 09:06:30 -0800
In-Reply-To: <20250225213937.2471419-1-huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225213937.2471419-1-huibo.wang@amd.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174076236724.3733269.4004616538941976314.b4-ty@google.com>
Subject: Re: [PATCH v5 0/2] KVM: SVM: Make VMGEXIT GHCB exit codes more readable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Melody Wang <huibo.wang@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paluri PavanKumar <pavankumar.paluri@amd.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 25 Feb 2025 21:39:35 +0000, Melody Wang wrote:
> This patchset includes two patches to make VMGEXIT GHCB exit codes returned by the
> hypervisor more readable. One patch coverts plain error code numbers to defines, the
> other one adds helpers to set the error code.
> 
> No functionality changed.
> 
> Thanks,
> Melody
> 
> [...]

Applied to kvm-x86 svm, with some massaging.  Thanks!

[1/2] KVM: SVM: Convert plain error code numbers to defines
      https://github.com/kvm-x86/linux/commit/ea4c2f2f5ed3
[2/2] KVM: SVM: Provide helpers to set the error code
      https://github.com/kvm-x86/linux/commit/c3392d0ab714

--
https://github.com/kvm-x86/linux/tree/next

