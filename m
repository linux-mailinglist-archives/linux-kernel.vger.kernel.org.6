Return-Path: <linux-kernel+bounces-210758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5BC904859
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9C8B239B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63744C90;
	Wed, 12 Jun 2024 01:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAQ+FcMS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278C4A0A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155336; cv=none; b=KCIZvxKcXcDcP0MNjtP1iiFVS/CTZlu625IxAIoaYZ2TW2M49A0BdF31aOGvHYouu2K6kVRjpR4u/SfS0PKny1H0BXP6ortWvszstNbPb7kasY0aCHJNFIUz10tIDCHCJkscGSASgcPXph+8I9B8iEZR3moF04jVDuvv87IbSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155336; c=relaxed/simple;
	bh=7BzX68RO1I2/4Vm3pIeJ4Bk/qKns0Ww4Z7oexgPI96Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CXIgZ2fXHe9DN+ai5Ip4Xkpb2CNzSwhOOg7Kgo4ZD3GHwSuXLP2U8doFvTBF2ZBmgVB8JF3mjlTWK9yc3nMjgnedY8qM2ktjVCYpKHWbzY6HTPm73AB494F2/AD/m5MKR/6Q+YHhrBABW0NowL7MpurWPV1DV/RCM+Wfl3a+yks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAQ+FcMS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7721f2e70so550317276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718155334; x=1718760134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7o4KyChHjO7DQZ5EyWBpKhADpfYouFD4JKs7qWQz4Q=;
        b=VAQ+FcMSZ/L1xC11y43DkH7pX5ezPfg+t/8333AHpGf4h+MEXw/g2urA+8vayzu2zE
         +v/+xx69mILtfok6+sTr79M3OPkWyfSpvibJNYmtsIUEDMWXe2K5qB+jTMW4LaQ8WjE2
         DJQGSyHQf++FjYPD3XK6E1csf7iUMA7zzLTsqYuzlZX2mspfdBHLoldBSBPh0LoUEwNu
         2OGY+hfpzKmHV2tL7MRuTIYCzbiYBd4XOZpNtltduT8wgtiaKgJhnns/gnQphF4r0wOO
         QhQgQg19qOgDV8UZWiW6JPJSUbkhJNcKMOHxu4nTXNkTGySccWgg8vBftazcKdv85SbF
         INgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718155334; x=1718760134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F7o4KyChHjO7DQZ5EyWBpKhADpfYouFD4JKs7qWQz4Q=;
        b=JfhgZlB/wqz6ul3+k0isOTzWxYtWLi61M6OPbve6dSyPVHPjUgB5ACZfXNmDi4hrp8
         UlMLQ7jWO6Qf7Mx5sgEC5EJMg9H4HL+LyW4SPei4bxVni9n+bU+ZHj++0+XyXpgUPSoe
         Nb5y/caeZy/BJGcBne7VED04wdegjStiXcxI2OJmWcHtyp/VHzrZGkoKkdXON2flWaov
         u9XCdXDfkfNV8/8rFIPSg0H/beAyuJ+Xo+zDjWmMU6zrXxAyE57PfsjEe8SRpHFhbSyo
         PTYsuKHav5UiCjlqyJfSinUlYQHutjhpqELzVvwVfSgshBmBmDPfQeElLcZQIb/VcVv2
         /8bg==
X-Gm-Message-State: AOJu0YwxhWkiD3KG3RV7tzzoBlqrPsrpJZuwC07Ah0T4irk2DM9ikUzU
	hVsZ2BTgw3a9ZOo29lyeH4MzvXjw6PLhEle/A3o532EL885AIcSN6PuKOLsqUWChlF25fPpc72I
	71w==
X-Google-Smtp-Source: AGHT+IES7k6AhTW9oUITWN2zaO07DMQ6Dw4IgJhehKxIQ0R+fFd4jkF/UA2TQldLvAWPTP/nP7LiC2uI0uo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c4:0:b0:dfa:76fc:85b4 with SMTP id
 3f1490d57ef6-dfda01b06f7mr637950276.6.1718155333903; Tue, 11 Jun 2024
 18:22:13 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:18:40 -0700
In-Reply-To: <20240605224527.2907272-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605224527.2907272-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <171803644297.3355626.18364027225741935056.b4-ty@google.com>
Subject: Re: [PATCH 0/2] nVMX: Ensure host's PAT stays sane
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Xiangfei Ma <xiangfeix.ma@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 05 Jun 2024 15:45:25 -0700, Sean Christopherson wrote:
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
> [...]

Applied to kvm-x86 next, thanks!

[1/2] nVMX: Ensure host's PAT is loaded at the end of all VMX tests
      https://github.com/kvm-x86/kvm-unit-tests/commit/8cbb8d3cbca9
[2/2] nVMX: Verify KVM actually loads the value in HOST_PAT into the PAT MSR
      https://github.com/kvm-x86/kvm-unit-tests/commit/d31433807f2b

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next

