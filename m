Return-Path: <linux-kernel+bounces-539623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 214ECA4A6A2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234521722FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CDC1DF267;
	Fri, 28 Feb 2025 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crTPHXi+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBF1DED5C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786040; cv=none; b=pvn+OtMXmjfrLWEP++u6B7qXaZ/rnQl+J0dND1Qb6JCVKwIdRuPfBqzR1LBTgs+EoOTC4AFKdEV2DZy7EKUp4XvUSznVEgtk8gyGbtIBueGw2eOy+e8EDlLuKWan0ziSmCH+yqw1QbjqY8D99BON+e0pyiiT/aLu60SzLd/xU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786040; c=relaxed/simple;
	bh=+YDEWUYRf3MHFT8PzzaqVpg4yGdZTKtMjbqIoYAlFe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JZy2VEDBilEFEjTJySSCNWfsrzLVjGfamjQ3h9r4qBm5lUJUOXyXgSLyhB5uIK+POo9D/eB+Fwla8XwyFyOH43ZQdqiXbH16nozzlqeCH9kdLHs0QUuKtIpEM7YeNykMvR6HYUa38ucJ6A+TRLR7UiF9okIYD7m6Em9n9ydEb44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=crTPHXi+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2feda4729e9so245739a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740786038; x=1741390838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgmZbIs8LrjUAYwQIMHJPsubRoSVLW5yQ0A0xB/9GV0=;
        b=crTPHXi+23mdnmjbVAdWR9P8jxb6GLtHll/0RoD8xz+w7bRrsGalJsoVbGhc8mRt+K
         wJM4qUhFPVX50r3hU8hu58VrCxAYPzWdJnxXN8BLZueSiMWL/U8PCuCUyzjWMZor6HV0
         FHpZvuSxuKkm+UZzqMuRApXbqMRuB82pWAn8gWhKQ2El2qsk+3B1k/FiS/sUTso4+Yx3
         Ejcn3MX2gPeFelNbX2SCfa7hzQhx634RA/ER5uKS/4t+/Ew8bAa7grwW4hwB1UKzsvP7
         QBblymeu5UrfWPWLFlOPM3kLFockta4V0zBce/gReETrzuJOYtBR1zNY8ZVnIXP0USWd
         ovGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740786038; x=1741390838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgmZbIs8LrjUAYwQIMHJPsubRoSVLW5yQ0A0xB/9GV0=;
        b=l0rMsQHr6N/khF75I7uDzyORMq/zCp9/f2rgf08mQAMny3kG2PzqzVO06N5/cj6ObG
         PQeKD70evOPW6pkySRa47Ld1FOD7J4ydis7+WrrC9aTcHePXMYDgkGlgXM8ehNtulnCy
         EjnkGNMn3OJHYyAWY8yo2zwLEhS6qVdslNtLDuURHWU5+73qqS1eDqD1oo5bWyO75uR5
         T+9EC5HaZgfilM8ZYTNamg60ynvp23qiflhEWc9bq+/KvXPERZyXle92c47+PjoDL2/r
         GNNx5wGOKJ4084EIWqjzFWUmgdLTtEweXKaBayeuSbCwQd6leePJVb/ZFpFiQmFtPWpe
         x/mg==
X-Forwarded-Encrypted: i=1; AJvYcCUhYuCCt51PBxvglQDjNgUSvaTvV8sREHJ0BH2GCnLrR5DufJG22q6O8qitj3CgJBTPUk20oB5QE2QiSwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SZ1QuZ3HaxNERSGx+fq6sW0KGynY1pXVykNFkYbKA/QYz4au
	8wwj3tmOkCwdEqbaFLtVWBTJ7WP/xyFYEf1ndcG/bYe2oLy9NR4GfytL0GtO6Ab73odBFJw95QF
	4KQ==
X-Google-Smtp-Source: AGHT+IEgsz4e6jcfc64iTfG+oc/6rOROHmDQlA+xA77VruZkmuESCg3upohcOmnc/OR9kgx8Xg5q2CHxoCw=
X-Received: from pjg7.prod.google.com ([2002:a17:90b:3f47:b0:2f8:49ad:406c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0d:b0:2f4:4003:f3ea
 with SMTP id 98e67ed59e1d1-2febac0659dmr9420269a91.33.1740786038203; Fri, 28
 Feb 2025 15:40:38 -0800 (PST)
Date: Fri, 28 Feb 2025 15:40:24 -0800
In-Reply-To: <20250224165442.2338294-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224165442.2338294-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174076295827.3737602.3025030463131592806.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: SVM: Fix an STI shadow on VMRUN bug
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 24 Feb 2025 08:54:40 -0800, Sean Christopherson wrote:
> Fix a bug where KVM puts VMRUN in an STI shadow, which AMD CPUs bleed
> into guest state if a #VMEXIT occurs before completing the VMRUN, e.g.
> if vectoring an injected exception triggers an exit.
> 
> v2: Use "raw" variants to avoid tracing in noinstr code. [kernel test robot]
> 
> v1: https://lore.kernel.org/all/20250215010946.1201353-1-seanjc@google.com
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/2] KVM: SVM: Set RFLAGS.IF=1 in C code, to get VMRUN out of the STI shadow
      https://github.com/kvm-x86/linux/commit/be45bc4eff33
[2/2] KVM: selftests: Assert that STI blocking isn't set after event injection
      https://github.com/kvm-x86/linux/commit/f3513a335e71

--
https://github.com/kvm-x86/linux/tree/next

