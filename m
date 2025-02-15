Return-Path: <linux-kernel+bounces-515875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD6A36A18
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E2C170AA8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750134315F;
	Sat, 15 Feb 2025 00:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S05eg5MG"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779591373
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580643; cv=none; b=ECS3Hq6CTo888MEk7CBeECGWgB2jsBI5hob030erJLxZI11PWn49GOcAL3pVBtMb1qTrfsbnO17Qp6b7Dg9tkpiAtiYFqc3fYnvp0ba8DXsEE/ytXzCLC2hf89t+SOPzRx8rtkpE5H3KxFDa7mzCmRqwS3isCgKIOJMH/25jogU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580643; c=relaxed/simple;
	bh=POYEUzJf4F7hR6ErGP8+kECs4BJCAdIjReed4JoMUes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mXFCLUlZu/xWZJU++0WN+hnQ0GD9HrEc97/iINP836e4Bc2LUOy1wZRmDphHXhDSj0zThhPK9xx1LIJkODDD5C7vE3TiDrTfIYV27w+ogWbsDUZ9+/3DfnVCsYWEN35O0x37xY3qxCPeG3FnVpf1ijUk5+G0L2uu37mzfDTqOe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S05eg5MG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fa166cf656so5181635a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739580642; x=1740185442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8zARw4+ZV2w+QskDlMwskXcGP20di1IcERKsXgaTywA=;
        b=S05eg5MGb7+H/ed8tgKfCkK7Eo0lsqwrtjHxw2vkP5MYmKnW/pb/GJZcp0XJ8Ytxza
         qiIDViQtBjqnFnMXsPfV5KwfmULqZkwFR4tHOluc5W0KG0ebTKnQALJDcLY3RbPZdxCk
         ficaPXcnEghgzJZDjcq7TxHy3TZhyj4FsI24NWu/BDe7x6E0wjs8Ztxk54i/iyBHC8T5
         0dRHHlJ/Op2Pq0DHzH+kGhK2Yx7R74dX4MTNHUKnLpwyqIHGLbSpyIYt3LDyNguFpXBY
         8vJ2CZK4TQxtb2pVjtWnmbEh8DH735XE2VvHjtnsz2SkxbRI44q2uGvXYwvXvu5mt1eq
         l7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580642; x=1740185442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zARw4+ZV2w+QskDlMwskXcGP20di1IcERKsXgaTywA=;
        b=Qiaf53Bhx71sbRvwP4smRZRlVZodGIQRSRuK0lXgIAKDlFrfAoxOTW7KHDvfcWO/pi
         eBCpAzsEoLECVN+6DdtpZ5LvAil8YxOGDLvUqwjoFnSpIryHwAfR9GiVtbRG/9EOaHF+
         O47+cUHKFNm7Xjd7sQeMph1heOjv6q8VhGCbT1KhpcKrsYtjXzTFMeFd4KpEl9eqlvaI
         dKsL3w2gJErcF78kKprO6ZY+trKkzCwc1qnQb7MMx+pEPv5ZqxrpxKv0ekYpZYGNScYM
         lET8Tdd9oEVUM7CVUmbYcSSMHHlu8iobl7hlCFfUVD3EjkvRUImis0DKsYgImLNh8HVa
         +U+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkb6Mkt5fbycG+EdMUb71Q6EsbH2NCMA/EOzTee05Ny7ACRdD3iq51fz4lAopRDwsKUk0wLu3DNPqo+jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWW8J8X6Y7Svg7n51iDo7P2tOUli90bdAQ2a2LPEePLfqVpN4R
	C6fpFVegsp7RCNi1uoV++mvfykfnGXV42XtJHNDql0M6aLl5Xmk4Z6Q1rPFqrP5ijFnpGjiMLTh
	fEg==
X-Google-Smtp-Source: AGHT+IFz4wSyDecNXJFqvihaxPn+qeYB3cCNRHI/ww3DuyZD0TGU1JQo3GTzf2tFJmRc3FF10QG3ATPZpok=
X-Received: from pfmv8.prod.google.com ([2002:a62:a508:0:b0:730:7b0c:592c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a07:b0:732:5b10:572b
 with SMTP id d2e1a72fcca58-732617bd3c5mr2231913b3a.10.1739580641807; Fri, 14
 Feb 2025 16:50:41 -0800 (PST)
Date: Fri, 14 Feb 2025 16:50:09 -0800
In-Reply-To: <20250125011833.3644371-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250125011833.3644371-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <173958027023.1189487.12347713108460200107.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Load DR6 with guest value only before entering
 .vcpu_run() loop
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Stultz <jstultz@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 24 Jan 2025 17:18:33 -0800, Sean Christopherson wrote:
> Move the conditional loading of hardware DR6 with the guest's DR6 value
> out of the core .vcpu_run() loop to fix a bug where KVM can load hardware
> with a stale vcpu->arch.dr6.
> 
> When the guest accesses a DR and host userspace isn't debugging the guest,
> KVM disables DR interception and loads the guest's values into hardware on
> VM-Enter and saves them on VM-Exit.  This allows the guest to access DRs
> at will, e.g. so that a sequence of DR accesses to configure a breakpoint
> only generates one VM-Exit.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: x86: Load DR6 with guest value only before entering .vcpu_run() loop
      https://github.com/kvm-x86/linux/commit/c2fee09fc167

--
https://github.com/kvm-x86/linux/tree/next

