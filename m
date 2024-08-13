Return-Path: <linux-kernel+bounces-285204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04396950A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF951F23B19
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB12C1A255E;
	Tue, 13 Aug 2024 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GWcwcXf"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5019CCF2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567396; cv=none; b=ZmIb3+6VJ2Vu5boPPQ1R6TD8Xp4HOChfUnB9ec2B+sZY+tm1S14xZ/HQB/yKJnwfUmusvRrE+MkzgMgW+z9Bv/qqCCk8vnwwVPmu46uWMhqnJnbtTwwdBmcBEZRWPxNLYR09JnMOg0tdw3ZW6gw5F3MM1Z7ILTNjDXNkmnqt9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567396; c=relaxed/simple;
	bh=a76Sn8lUGnQIx1tPlDSzmCkNqiGpbPkord6pZ2O1lNA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p9vDA9rGEEVrMSUSyBIYVKuabywl3wjnI0wF8hbJZM8PwKHIC6oqukop+mSDebiK0uqXmxoQMLSKb1UIrvNWlprLhi1NtELg9XSnncRLAq6BzzSEavF5nX6eE/q5eRh1zGRrkwsKqf3gOvMym/HsL075w8N1Q1RQGupR8tP7L6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GWcwcXf; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-81f8edd7370so723099139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723567394; x=1724172194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jk7IQol6duajyqIm/9vwpiSEjjpf9mSBlNXL0oxxX8g=;
        b=2GWcwcXfj7vogo9cxryMT0WfApNC+IET82huWJEPSrXXWXKvnaJ+5ha6n4gOa0ZbAh
         b46FffgEJll1VTUDlGZJTu9y/YyIszhJWnmMN3CUR04NTlqvhSi/F4paVKENVCJLP+j7
         6toX1I2QEC4AtIpjNrdKvx6/lxbvG/ovTt9HOEDRx4IjZ98yvp1hf58d/hoQiW71QWbb
         nzy3KSrN+E0MHLveunrcXHjRFparwKjMzxjERrJ6UodFd7wTvaWu6hIB7wHAgHtai0Ye
         3S2SpFuEydAiN31iIke7pkWdkHibAmpmA3W+l830So3+37linAoTHaq4Ed1MhiZDnCQC
         WA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567394; x=1724172194;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jk7IQol6duajyqIm/9vwpiSEjjpf9mSBlNXL0oxxX8g=;
        b=DS9twVk5GjgadEG5eRyWtZ8HCrc/+xMifdzLAFgKExlZakpDR1/gYT5LXwLEKXl+GF
         E+Hkeuxm2pNbS6n+HZfY/QPk3VGOOHt6ZrG0b26uYl99j1YULko8l/KoiYCE6Ongb+Iz
         qnzC7M9xBpkgeXmvP9xPg8Ra96M+a7cGscuUgBQkUVw1Gd5VnOpIiH7+Ir6TAjL4XREe
         aps1ciOe08BIHCsJMLjMfvINE4pWEZonvleIHWr9D3FNTYlMwYhRKFtBmwjzBaSI7zMu
         CQHBgyGXKEd81bNB0GhpQ6Ska9W0kZxpEJYT5fBPAHXsi+XYbgz0rGZWVNOvh+r5eIAp
         Jqkg==
X-Forwarded-Encrypted: i=1; AJvYcCVeC+qfKTVafpZ9pIsPtJzSM1Vl2TsqZnrjSII9lRS+k8PBioRwSJ6bfDI/wJvzM8GL/14/WSBX3kkv63eKwJKaPtRMr8FCbQjlvRMy
X-Gm-Message-State: AOJu0Yx0OL5Dh52Lk+sZ4uZPh6cZitLrtgBDgr3bwPeMGJgfPh6VONws
	sqtM1FhVVD96fPJARw5PCztTMbY3RoRcubSatV7Ge6RgsWBgQ54lBYNiwGmw5GgdC5+TWDBcxUV
	V2HYUlh4Hekp9YkFZul2JFw==
X-Google-Smtp-Source: AGHT+IHlSFQqmN9TKjjYPCTzVt/OdeV4DkEj+bFrAV1W7DSNq4vagSFdnRo0HqbFUXWJpNm2rfh5f2AZY2PBIEOLKA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6e02:12ca:b0:383:4db4:cbe0 with
 SMTP id e9e14a558f8ab-39d12502a17mr150075ab.5.1723567393828; Tue, 13 Aug 2024
 09:43:13 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:42:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813164244.751597-1-coltonlewis@google.com>
Subject: [PATCH 0/6] Extend pmu_counters_test to AMD CPUs
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

(I was positive I had sent this already, but I couldn't find it on the
mailing list to reply to and ask for reviews.)

Extend pmu_counters_test to AMD CPUs.

As the AMD PMU is quite different from Intel with different events and
feature sets, this series introduces a new code path to test it,
specifically focusing on the core counters including the
PerfCtrExtCore and PerfMonV2 features. Northbridge counters and cache
counters exist, but are not as important and can be deferred to a
later series.

The first patch is a bug fix that could be submitted separately.

The series has been tested on both Intel and AMD machines, but I have
not found an AMD machine old enough to lack PerfCtrExtCore. I have
made efforts that no part of the code has any dependency on its
presence.

I am aware of similar work in this direction done by Jinrong Liang
[1]. He told me he is not working on it currently and I am not
intruding by making my own submission.

[1] https://lore.kernel.org/kvm/20231121115457.76269-1-cloudliang@tencent.com/

Colton Lewis (6):
  KVM: x86: selftests: Fix typos in macro variable use
  KVM: x86: selftests: Define AMD PMU CPUID leaves
  KVM: x86: selftests: Set up AMD VM in pmu_counters_test
  KVM: x86: selftests: Test read/write core counters
  KVM: x86: selftests: Test core events
  KVM: x86: selftests: Test PerfMonV2

 .../selftests/kvm/include/x86_64/processor.h  |   7 +
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 267 ++++++++++++++++--
 2 files changed, 249 insertions(+), 25 deletions(-)

--
2.46.0.76.ge559c4bf1a-goog

