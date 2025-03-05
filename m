Return-Path: <linux-kernel+bounces-545892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB41A4F332
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6E23A78FB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320AF84FAD;
	Wed,  5 Mar 2025 01:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAA4SsI8"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE581E50B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136726; cv=none; b=N7SKYuJc6CVyY/UCE8kAQ0bAMmpmAGnYTzJpBy/fm9dB7iO0uqdHTAFDE1IIgzlSZ4SndOtI5iUEodDyliXPtsyz0ctmfSE+QOGTsQWDZTkMo9hMc/kbKtrZgaA32048CkDcQxXvqArYULYQf8SzhmoBmlyF33pIPClXmwwcplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136726; c=relaxed/simple;
	bh=wShgWdPbM6jGU2419za23vFDM4K7IyG90XjDg/wsL3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tUJIejfcXt8oQhcEDm9ZDnlm4wMtJjQGuD7PUzCGVqXnQcJWdYULX2mJzDG/xediK6VLOeI4FHOCsHBfQxoTAQtwexgsf8kLMtpmsG8o9dh62YUgWgApzL7EUzyZ6Hdoj4VG0m7ntv55ft568EV3pILZLFSPYc6StJkyVlqyZjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAA4SsI8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22331df540aso182911625ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 17:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741136724; x=1741741524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PyytL6RWgngZAWNTVxaJae87poWubuVZXsEbznEraZ8=;
        b=oAA4SsI8CpJOJKK5zDCYCd5Jxs7iQIiAkXeV/jwLlwEsoSbCv3tg8V7qumYQJqe8gm
         /ZxVaMWDps9hc/HZAEvOw+x1/2coVVi6dkLwxiCKHNoho0pfHQMwaRpcxdKtOQ+bEToh
         +tRtH+Z6g8aAnZAzL/drQ03x/nkWt6pryxfVXXWh6VmpOWv7jAtCQytxRx+EMb89/r/d
         xTcKAdW0PJAqy6kLnSvm+LmtLvDRIg3Lkmg5GatusPKKCtsyMAxOFOodoAEH9fqrFSgq
         +EbvSQiuutMVr/bzsUyWKgGIxMocOc8J3ubNlY2MidpZ4v9+UJ8B9A44V1kulQBqYd1+
         UocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741136724; x=1741741524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyytL6RWgngZAWNTVxaJae87poWubuVZXsEbznEraZ8=;
        b=TRWL4fyDasb7v2hAPCrOW3/RO27fNySL+Nxa4oj6Io7cVdUYkIrEMLMTYaOu7dS2zk
         93flX0lA2e+GDmHWB2cI04+4SbYO9B5DuBpQwy8uESSgSyh7CpOgHYUHOIWBloJi1sz5
         fxrcBdeMWNCcBGZiT6I3yTfJ76KFEjD6UfyqV7H8DIR43/iONvRuAwwFrO4v6Yf3zqk+
         9pv5Whcg2P6WUcJc9k4+/7cW+hS/PtvDJXvr9BuYJERKl88bf4Cr57eKEY19TcNG+utM
         tCA+toLC/rrbX7hfI+jjAg6H5U+OWcz1N9sdBIGIwYDMOcmzdlW9uXizzMDsUk13JXMh
         5Lxw==
X-Forwarded-Encrypted: i=1; AJvYcCWPuR+SZy/ieWgeVUt3XS9zToK2b4POyG5rWLGd2R9G/ZgEAu3tZr7+27Qk3rNw1TO641dnMYofTtrZQnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqjSb0wKc3Ul7YzOW/BXvLEZAfM84rldNQE26GdBO7jI8HnXc
	f7KuKT47MYug1qu2/aUESzJvxEHObbjtZp4O7puRpZcc5tRkNox9Yd2ujmL28/gQxc9uXJzpzSs
	Kdg==
X-Google-Smtp-Source: AGHT+IG7hrL8iysRg7HI20C5pg/n/j0wepPak7RC2J0Nx+UI5UHj705nm6UvLybs+TWHmYoX5vcV95KuZhg=
X-Received: from plbmo13.prod.google.com ([2002:a17:903:a8d:b0:223:637d:8bf7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4e:b0:21f:dc3:8901
 with SMTP id d9443c01a7336-223f1d2645amr19814055ad.34.1741136724598; Tue, 04
 Mar 2025 17:05:24 -0800 (PST)
Date: Tue,  4 Mar 2025 17:05:08 -0800
In-Reply-To: <20250228230804.3845860-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228230804.3845860-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174101637372.3904037.6271235554709270288.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Ensure all vCPUs hit -EFAULT during
 initial RO stage
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 28 Feb 2025 15:08:04 -0800, Sean Christopherson wrote:
> During the initial mprotect(RO) stage of mmu_stress_test, keep vCPUs
> spinning until all vCPUs have hit -EFAULT, i.e. until all vCPUs have tried
> to write to a read-only page.  If a vCPU manages to complete an entire
> iteration of the loop without hitting a read-only page, *and* the vCPU
> observes mprotect_ro_done before starting a second iteration, then the
> vCPU will prematurely fall through to GUEST_SYNC(3) (on x86 and arm64) and
> get out of sequence.
> 
> [...]

Applied to kvm-x86 fixes, with Fixes and Closes.  Thanks!

[1/1] KVM: selftests: Ensure all vCPUs hit -EFAULT during initial RO stage
      https://github.com/kvm-x86/linux/commit/d88ed5fb7c88

--
https://github.com/kvm-x86/linux/tree/next

