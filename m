Return-Path: <linux-kernel+bounces-515922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AFCA36A81
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC98171A14
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1611FF1B5;
	Sat, 15 Feb 2025 00:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oO+1Ii1T"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30321FECCE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580994; cv=none; b=lvRuLVJ6RGOp1bOnJ5NyJlCIUbrgrOoWtHaoQDcfqWv1Uj4N1XdbNoI6/xQtqBpeToHYX6uATBdoxPrt+k+E4ExXWxQnM+bD9N3yAfreGalZj7uCjCxuoy6XQFHLX9w5+xiO3SvK+FhWP1PWhBaexmUhiY4avAfQY6bXmlu4lqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580994; c=relaxed/simple;
	bh=/hAefXnaeUQOLJAD068YncGJHvwpvW31wzx0E75tOHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bHMLwTTagtuDI92opOu+QGxGU4SXj1hMjIry6aSfoapyOzvAszk+8eDxrl3fBJCOXLY+YWiuSMP/l1ETv1Cwj08bR5P+Eqnc29eEW19pmWqVr1qjMToIfBmAw23BqzJSTlrc/ThB9YHhyOa4H2EgPZ1fwi+W2z3mtx9cgO3skoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oO+1Ii1T; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6cb3097bso69758325ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739580992; x=1740185792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WOCpqD3OmoKFCitWmpsKHSH+flvob98tVbwxJl34ao=;
        b=oO+1Ii1T4wfcfIiJPBSC3lBXRCICXGJTOz3h4orG4Q2rgNtTAmuuHumd5Mb0onm7qp
         7eGkTqJW6GtGK7ei3ucGICH/26XHYjpd5AAh9Ny2PtPLqQWNd0udIvGhAdTirSN84y4u
         3hHk6vfs7K3aMEC0udoaRaSWfA5XG0pfiUwDUQSRe7/Rt2bvCbr6wgWzCLNq2aqcY02I
         XEXCiK/rJnOnRVH9ShdnVmbQg1MFe5sDjeLOZ9o/iFEBtPSaVCd1/axpYiDuHPyvSVn7
         zUqZYSUXK9bxvin1MWLsmsL9z+9UEMdpMupHBdmGYGmbUcLPu4ulJ6yVsNthsoUUtY2h
         SEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580992; x=1740185792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WOCpqD3OmoKFCitWmpsKHSH+flvob98tVbwxJl34ao=;
        b=dWBAxtM0qz9vcMuc5u5qhGkmgbkKKfY/BJ1JqXQdKs8wIMGaaKSb1WIc+s7jYYdudJ
         aBDxiGTUsUUHpTmmtdH4LUbBWO+IhHdv/9UZaN5xIIvZERk9gtnbYaSnulfti/EI+oq2
         IKeqz/WZGfqym3f4/ZBJgIbo3qAUQnUDEyXt5Xq7J1V276Ypo5uk8anL7Ra7/QZjbpW5
         buqdh4JPnhPiF5j5TlW/UdeNUGoPMO5DfwHiB7Et8QwKmxBDaQWPLJUPR7VsV7sNymDw
         sU1vBYjB6pHjGhGrhT7CCoSn/GJWlCEfW0/VJeVskuhPgVGmgqbaXAXVTNxQKVqddGY6
         yEBg==
X-Forwarded-Encrypted: i=1; AJvYcCV6uTKShZVrwUPOEb0QKj1TfrnsRaYrdTqgcge1DihQwCzqw4QR2fgor27R0MEa3gF8dk1TenTpQ05wMcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA74TVGxuChJA8r5KyWYo8tsFsnbGnpDw2kIA7a5UTyLQPlBDd
	FkWT8BUCn0kWqZJIRrnt/BJ/a5+ii/YBElcdL3qrU8jpkfE5PRTYcZ5hikEMLchWMiG/920aqQe
	jzQ==
X-Google-Smtp-Source: AGHT+IEPACTyNZhPmAesdCigajK/hhHFVyYj4QDZCWFEftTaRLTuaeHaHDu8WeBfIEidDThP71wZXeUvmEw=
X-Received: from pgr36.prod.google.com ([2002:a63:1164:0:b0:ad5:3d3b:5d96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999e:b0:1ee:7db7:b4b9
 with SMTP id adf61e73a8af0-1ee8cb4f827mr2732553637.18.1739580991977; Fri, 14
 Feb 2025 16:56:31 -0800 (PST)
Date: Fri, 14 Feb 2025 16:50:33 -0800
In-Reply-To: <20250111003004.1235645-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250111003004.1235645-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <173958028019.1189673.881553465537742211.b4-ty@google.com>
Subject: Re: [PATCH v2 00/20] KVM: selftests: Fixes and cleanups for dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 10 Jan 2025 16:29:44 -0800, Sean Christopherson wrote:
> Fix a variety of flaws and false failures/passes in dirty_log_test, and
> drop code/behavior that adds complexity while adding little-to-no benefit.
> 
> Lots of details in the changelogs, and a partial list of complaints[1] in
> Maxim's original thread[2].
> 
> [1] https://lore.kernel.org/all/Z1vR25ylN5m_DRSy@google.com
> [2] https://lore.kernel.org/all/20241211193706.469817-1-mlevitsk@redhat.com
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[01/20] KVM: selftests: Support multiple write retires in dirty_log_test
        https://github.com/kvm-x86/linux/commit/fe49f8005257
[02/20] KVM: selftests: Sync dirty_log_test iteration to guest *before* resuming
        https://github.com/kvm-x86/linux/commit/67428ee7b746
[03/20] KVM: selftests: Drop signal/kick from dirty ring testcase
        https://github.com/kvm-x86/linux/commit/ff0efc77bc96
[04/20] KVM: selftests: Drop stale srandom() initialization from dirty_log_test
        https://github.com/kvm-x86/linux/commit/1230907864d7
[05/20] KVM: selftests: Precisely track number of dirty/clear pages for each iteration
        https://github.com/kvm-x86/linux/commit/af2d85d34d15
[06/20] KVM: selftests: Read per-page value into local var when verifying dirty_log_test
        https://github.com/kvm-x86/linux/commit/f2228aa08324
[07/20] KVM: selftests: Continuously reap dirty ring while vCPU is running
        https://github.com/kvm-x86/linux/commit/9b1feec83e1a
[08/20] KVM: selftests: Limit dirty_log_test's s390x workaround to s390x
        https://github.com/kvm-x86/linux/commit/deb8b8400e31
[09/20] KVM: selftests: Honor "stop" request in dirty ring test
        https://github.com/kvm-x86/linux/commit/f3629c0ef167
[10/20] KVM: selftests: Keep dirty_log_test vCPU in guest until it needs to stop
        https://github.com/kvm-x86/linux/commit/0a818b3541af
[11/20] KVM: selftests: Post to sem_vcpu_stop if and only if vcpu_stop is true
        https://github.com/kvm-x86/linux/commit/9a91f6542435
[12/20] KVM: selftests: Use continue to handle all "pass" scenarios in dirty_log_test
        https://github.com/kvm-x86/linux/commit/c616f36a1002
[13/20] KVM: selftests: Print (previous) last_page on dirty page value mismatch
        https://github.com/kvm-x86/linux/commit/24b9a2a61377
[14/20] KVM: selftests: Collect *all* dirty entries in each dirty_log_test iteration
        https://github.com/kvm-x86/linux/commit/d0bd72cb9160
[15/20] KVM: sefltests: Verify value of dirty_log_test last page isn't bogus
        https://github.com/kvm-x86/linux/commit/485e27ed208f
[16/20] KVM: selftests: Ensure guest writes min number of pages in dirty_log_test
        https://github.com/kvm-x86/linux/commit/73eaa2aa14b7
[17/20] KVM: selftests: Tighten checks around prev iter's last dirty page in ring
        https://github.com/kvm-x86/linux/commit/2020d3b77a5a
[18/20] KVM: selftests: Set per-iteration variables at the start of each iteration
        https://github.com/kvm-x86/linux/commit/2680dcfb34e2
[19/20] KVM: selftests: Fix an off-by-one in the number of dirty_log_test iterations
        https://github.com/kvm-x86/linux/commit/7f225650e099
[20/20] KVM: selftests: Allow running a single iteration of dirty_log_test
        https://github.com/kvm-x86/linux/commit/dae7d81e8d58

--
https://github.com/kvm-x86/linux/tree/next

