Return-Path: <linux-kernel+bounces-210761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6F904860
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A2BB233AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A44A20;
	Wed, 12 Jun 2024 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5+0wxIW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9634411
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718155417; cv=none; b=M0UK6PQj+WNPFOAwZy7TEmgITAJ4fiMt4M62a2c3MIoTFnmM4bZ+EPFTAVNH4CS59j5C1xJSGGRftdf0Bqiqgp8I3wszjTugsRrPuwMNU1Br3FqwSLi39CgprdeqjSK3o8d9Wxry+38RDVRmkvnirnd3wvOQHvlyLTyRI8dfRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718155417; c=relaxed/simple;
	bh=9joCK+5QYCvw814DBtCIuJ51y0uYUX8Tgug9gGwYU58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RaID2bKXAtlETvonqqFSXd1NHFC9GocDwayxJ/Z6EAvf4b80eppDX54bcQ6LOt/ZXrKcjcZI7BvKG4dpFbZuzZasLNYesHK38Zu8vdQ3/c/aSXrm5wHlZQDFsZRUcPfLTAMcYroju8BeIMbgWeXHuzzBTCABoc+tRDR2w/KY8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5+0wxIW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa77d54cd2so9779536276.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718155415; x=1718760215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9RzYaJguaQI8ezMD1wLQZOMHWWd0f/qf7YACXyF/8fY=;
        b=R5+0wxIWSbXYi5W3HQoiMfntIpjoSAqwbPLG/wTzn1CPAAg3NTzLTYY8zOs8Ljl+NA
         adq18X8NIhl45m1IJX721TW/A8Otu5wOYlz7yhbkpUWjPXJqpcRtIzL0ld0rcjmbbLsI
         ohlaxfeJpjDZRNfQYDk4Ykzz0mWmuWlnCoz3Y2R8GDR/fKJuXETn91b/KiCwWaN/Phwf
         bcZN+1I9Jq6b2p2fkmoZtrt0wuf3OLbMLd/pT23z7Tjkdc13tu1hgqyA1NKMbUwzUisd
         LIem6s1loda08mc3qCmFIDQENMCwfS++TZG9ELpnD9dQzxnCPNK1RHoFDoKJ7Qu0wCiX
         nDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718155415; x=1718760215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9RzYaJguaQI8ezMD1wLQZOMHWWd0f/qf7YACXyF/8fY=;
        b=vZ+aPLn9sKD9Hwl2MI1Ppqms2sRlRj3uUsd/FImwKQ5CLmC1eRqXX3ouARTf9OafeL
         TQ9/6yT9Yfxk+3bMIJ10z3O8AQnvsQEmonu5abumo95Yd3FjbkJqjuNAtM2Ev+awk+I2
         qAd2UczUYgdJjKnNSG9dbWA9r67+c0soQUCpMFCqcSx+BOkWwxIf+itDgCkF0kTJfLP+
         WKxI87Dti3A7EAXzfOm0y8sX97b3ck2KI0WBOp22B3jQ715AORI/S4LYUR5L+XD9wicc
         zPmhlQxx/EeGmvYJagjLdW0+9UeQ8PGRBEwN4eHvxNcy7tE/FQEBF0O8+yuDgcdg2Q4X
         dJ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIo4nt1+O4NVWIAJ3W66F7FQsS/dDx6abVelIz1giQsLQV7upY3flSl1Q0JHH/q3gdwu2oIFpJq/MEn2jF9dG4hubBnVaXrEO5M0LI
X-Gm-Message-State: AOJu0Yy3wzIoUZl1v2A+wC3wr7xaG0Pn/WpfZUaxIWog4Yym9afhv+6Q
	7YLSiHLj0Xut88EJ900/JHL4lJILpQNGQVtGcewlUjU6JcXVOvauRMx5r45HZnFehhk7YEJbvao
	E1Q==
X-Google-Smtp-Source: AGHT+IEjJZGRKCQcHh9FXJ7J1f//y7xo6LzdBEJEvjj24wLGzsUbimQAjBo7Ve3dQ7CFgjY96N6Qv0fPgkU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b0c:b0:dfa:b47e:b99f with SMTP id
 3f1490d57ef6-dfe65f78355mr33849276.2.1718155415290; Tue, 11 Jun 2024 18:23:35
 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:18:46 -0700
In-Reply-To: <20240507133103.15052-1-wei.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240507133103.15052-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <171805499012.3417292.16148545321570928307.b4-ty@google.com>
Subject: Re: [PATCH v4 0/3] KVM/x86: Enhancements to static calls
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, Wei Wang <wei.w.wang@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 07 May 2024 21:31:00 +0800, Wei Wang wrote:
> This patchset introduces the kvm_x86_call() and kvm_pmu_call() macros to
> streamline the usage of static calls of kvm_x86_ops and kvm_pmu_ops. The
> current static_call() usage is a bit verbose and can lead to code
> alignment challenges, and the addition of kvm_x86_ prefix to hooks at the
> static_call() sites hinders code readability and navigation. The use of
> static_call_cond() is essentially the same as static_call() on x86, so it
> is replaced by static_call() to simplify the code. The changes have gone
> through my tests (guest launch, a few vPMU tests, live migration tests)
> without an issue.
> 
> [...]

Applied to kvm-x86 static_calls.  I may or may not rebase these commits
depending on what all gets queued for 6.10.  There are already three conflicts
that I know of, but they aren't _that_ annoying.  Yet.  :-)

Thanks!

[1/3] KVM: x86: Replace static_call_cond() with static_call()
      https://github.com/kvm-x86/linux/commit/161827082760
[2/3] KVM: x86: Introduce kvm_x86_call() to simplify static calls of kvm_x86_ops
      https://github.com/kvm-x86/linux/commit/aebed32e4985
[3/3] KVM: x86/pmu: Add kvm_pmu_call() to simplify static calls of kvm_pmu_ops
      https://github.com/kvm-x86/linux/commit/4dbd1f66c5bf

--
https://github.com/kvm-x86/linux/tree/next

