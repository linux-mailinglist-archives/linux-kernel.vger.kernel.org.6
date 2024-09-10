Return-Path: <linux-kernel+bounces-322407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C0C9728AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC17B23BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF991176AAD;
	Tue, 10 Sep 2024 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tv43ppdS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD4745F2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944294; cv=none; b=QdxDlKk+gFYrEmwCDQiEq3gB73J2ShW4mvGthmZUNWX5MYWtbqm/XkyJLBCmuHNxKjhL8xMHoBeVTiFXzfAfm0U/XyaW9sDrncvMjdhNdSt/rBXGLwgKTtFBj2i59QI3S61Ii/VzJwVAF0gwySnCQYImHaKA56IMXg/5okLxKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944294; c=relaxed/simple;
	bh=hRP9EOjlVmHgdQR2msW8evL+g5mWAVEDR+BggMQmsNo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0Ak+5BN1KV1LuL6dZWW/3Puredx5SqnKjKoHajhDCSIvEenzv0+s7/7hvcnjO2oWo4WXNjxo+gPTM8EbCsopGtoGt5eFKYp9Z2X8/guyaa6wXi7WKNgjRXLYohpei2OZk6uL16eQYNXHK0lH7xqIlNzAZv6u/y00fKT1euRPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tv43ppdS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1ce98dcafaso10633384276.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 21:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725944291; x=1726549091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6vjzTgXltx1fPYsxVo4tYdvoWWLG0pjK0gDo/oyaeA=;
        b=tv43ppdSSqTeIJJSjaK5XE5i5CSm6RdE6sfz/3XuN6gVbdgGYEfEHZ+KWXCwt1/ePh
         u1jTO9kbMbNFbaDzb7+CfWH6KbOOn9AdZ3Qq+CClle0OJ3JRY1CC2HoXNAIGOwmdj0cW
         CEqzXo/O0oiSV2MkN9S5ETB1K0v7cq+7sBHyXGNT8mH6UFXPWBalgZdh4I3CgtJ0Mxp3
         U6kG2IzW/0HEd5QXvWld85PtinIa2duLwOlhcM0Sa8LE7wGaM2ku7AtBLaeNcSd+w3Rj
         yfKCGm9BBRPOfgEdMdnrqW/QCL8jq7AacUHn4lnhnKHAOgA47dFstURF0o2dr9XYLLT4
         V2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944291; x=1726549091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6vjzTgXltx1fPYsxVo4tYdvoWWLG0pjK0gDo/oyaeA=;
        b=ChYTK6gO5AamC8JdG2lLg02/UsDNC1gLM06idxbwVp7qX0G8M7RTrBxiwj8AeBtQBa
         UVay2edPuDJ+SXsxvJXfzf73iQQB5D2vZ2NakWDIYCMQTYYfddDWT/KaByu4LbO4oIJB
         QEOM4H9Y9sBpyUlbgEgweUop98daydpDu+Q8EXPteTNFiI7/0/QFEEK+yiMsvVvUOpyu
         7diWB8x42UMzKqQifqvstCyfEZDsSsOh/JmUfwZRRi+b0TxUO+4CapuqDDGAIayHcJ3n
         v3FvaCInGY9Qr1S1WsWlLg6lz6f6s55owwxfELm4EEqiJPVwOqqYrOI5nkIwcwUMBFdF
         +0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZI7T+Lk6cj88Z7tDC/oMRftOrhM3qcBr7R8EBaavmrNfNS0ghy/jUCbKkOuSjeHgeLmePwiP7J4R9j7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0TtzQdyKMgOQpi+YTEy1p2xr7fSBe9Z+Pr555zUbcIYsEgXZG
	fb5CGnAqHmp6Jj+o8njt110RmyRdNoCEkM5hS9AtEnehtFWL0JilP7xIBprOcuZBMUsU1KrPSRs
	hog==
X-Google-Smtp-Source: AGHT+IF4rNg9cz0eICN3q6fWIPCxA+V7sJd3ueh3vdqJRU244zjCYSUaRe7DMjSxQ/T6Q/MHyh+PjY77HGI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d3cd:0:b0:e1d:20cf:aec5 with SMTP id
 3f1490d57ef6-e1d34a4dfa5mr73111276.9.1725944291064; Mon, 09 Sep 2024 21:58:11
 -0700 (PDT)
Date: Mon,  9 Sep 2024 21:56:30 -0700
In-Reply-To: <20240906161337.1118412-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906161337.1118412-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <172594250394.1552483.14960866497505256647.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Forcibly leave nested if RSM to L2 hits shutdown
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+988d9efcdf137bc05f66@syzkaller.appspotmail.com, 
	Zheyu Ma <zheyuma97@gmail.com>, Kishen Maloor <kishen.maloor@intel.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 06 Sep 2024 09:13:37 -0700, Sean Christopherson wrote:
> Leave nested mode before synthesizing shutdown (a.k.a. TRIPLE_FAULT) if
> RSM fails when resuming L2 (a.k.a. guest mode).  Architecturally, shutdown
> on RSM occurs _before_ the transition back to guest mode on both Intel and
> AMD.
> 
> On Intel, per the SDM pseudocode, SMRAM state is loaded before critical
> VMX state:
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Forcibly leave nested if RSM to L2 hits shutdown
      https://github.com/kvm-x86/linux/commit/3f6821aa147b

--
https://github.com/kvm-x86/linux/tree/next

