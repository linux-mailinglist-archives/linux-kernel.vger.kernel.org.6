Return-Path: <linux-kernel+bounces-203403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A758FDA59
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AD4280E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409A01667EE;
	Wed,  5 Jun 2024 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RF328UpJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9A15FA95
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629662; cv=none; b=gOODvQdxwHg+TU4UfiKvDlRvu6J126e348UYl/zUowDkSX77nh/w+oOhDqCqGH8nPD5aGmKh/qkYigIDvo4A2XHY0Do9GKtYgmvL3KgjeM4ti3TwTqfDgZqFEf6lE0Ny7Bjrm8kcVEhhTtjs8tWVJdR0hfAAU95ws7JS6IlLEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629662; c=relaxed/simple;
	bh=frkyJZ2vGbdRl5sjkeJ5Q3ZNjnaMVWE/xmToLpR8sCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jwn1YAqoqw/oy6aBfD9K0kJPujijGyRJWM1WnJBTzA+MrY9neyeVHlZnNZ3cz7WmDs4c//UzJ6xkoHGh70cNznbolgpYYJUJdOxhI/xqLtcrXOK7LUhC6vgahzZBRa9cWQWXEh4koRz4L4Ea4Edq7KN8gglRjEg0eErYc8xF1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RF328UpJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a50486746so4354677b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717629660; x=1718234460; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+vQOFeRAu3mXSVWVZ+hPFVZiGSzjjVFszB9/MUxbxI=;
        b=RF328UpJqYfvaxWzQ2Y/mv0myDNDwNCxGRZQkabASVGhDBWNYNji5MrwiDliJaKlSH
         CBc//7uANJHY0NYJ4QPa5/I+Ay5cwyrRd0uYx9qPPLtgAh3/jqsEGmdCeg8SvwQRYGRn
         xxHuP8iGZF/0cAhQL60ZzqJSN5AFf987ijU+EJp9+K+F8iAtwr3BbSB5wCKaqjshNk/M
         cw5IwFL8Fc3AuvmNw97sYnYmJcBGyr/fQjVjp+otFMK4EPaMFR5THrEvFA5GKR7fEYWT
         JqutOO429hJRokZxa2ZryuAvmt9pQ13Qhfy1YvufnFoX+yBI0WsrhUWNiFk4YAZtL7+C
         v0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629660; x=1718234460;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+vQOFeRAu3mXSVWVZ+hPFVZiGSzjjVFszB9/MUxbxI=;
        b=DvD4BneM6zfx4Z0A/mT2tcUY2MSHE9bTI2HPKm1mzP7iOMpRR4FqUTqQzdShwdq/b+
         lS1cCWnBCsI/TT0s/+DxjeOAVJk6qOH7Z0LkLpz3EX1O7Hs+UUyE4Pwu5Ihrgw/KNUss
         ONpJprMAlUgnnZdbtr3qLCtt+kVgPO/A9UYsPltA0oLnlPPdHinY4GbFK+5EcwYZvuXR
         yacdNeIn0HUqJ1zSYp8FHw/Iww9LGXcC9I5xahDgxSNgrw0BNMRbptkujaNisuTxBOQJ
         fZYsM20oau/TBD2Ru78/xNBfV/WUb9JU/lPMKy/FBcqvRFb5OWXDH81jKnlXxnyJGMFY
         BAiA==
X-Forwarded-Encrypted: i=1; AJvYcCWzOdHQpHbcRm6HLkEsR5dlHI26bL5eziDoDlludg/KSE5UarJRHsyQ2gpWE5cmt4WuZmtlHf9lsXGFaxlQeEtKEa4FGt4HE65Kh7ht
X-Gm-Message-State: AOJu0YxETB0tu8DZypX0xEa09emjELaovnNAeuJh4yD3WF3nZRcJBKsb
	v0E7SIM7w6KiZdcPyKcPryWJD5FN5BKTWSErfBB6aCeG6aXz4KtvqTXofRzDJdFzZS0MvPGilxc
	CFA==
X-Google-Smtp-Source: AGHT+IFIb+lmg+90fxq0vcczmWL2ENusQSCK4vmMn5+0aophPMSG6qAJzirTbvdVzpQeXIXgS+ORvjRcmyQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:707:b0:dee:659a:f58c with SMTP id
 3f1490d57ef6-dfacac4264dmr405513276.4.1717629660054; Wed, 05 Jun 2024
 16:21:00 -0700 (PDT)
Date: Wed,  5 Jun 2024 16:20:34 -0700
In-Reply-To: <20240309010929.1403984-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309010929.1403984-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <171762600665.2901886.14234246510506582276.b4-ty@google.com>
Subject: Re: [PATCH 0/5] KVM: VMX: Drop MTRR virtualization, honor guest PAT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>
Cc: kvm@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Yiwei Zhang <zzyiwei@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 08 Mar 2024 17:09:24 -0800, Sean Christopherson wrote:
> First, rip out KVM's support for virtualizing guest MTRRs on VMX.  The
> code is costly to main, a drag on guest boot performance, imperfect, and
> not required for functional correctness with modern guest kernels.  Many
> details in patch 1's changelog.
> 
> With MTRR virtualization gone, always honor guest PAT on Intel CPUs that
> support self-snoop, as such CPUs are guaranteed to maintain coherency
> even if the guest is aliasing memtypes, e.g. if the host is using WB but
> the guest is using WC.  Honoring guest PAT is desirable for use cases
> where the guest must use WC when accessing memory that is DMA'd from a
> non-coherent device that does NOT bounce through VFIO, e.g. for mediated
> virtual GPUs.
> 
> [...]

Applied to kvm-x86 mtrrs, to get as much testing as possible before a potential
merge in 6.11.

Paul, if you can take a gander at patch 3, it would be much appreciated.

Thanks!

[1/5] KVM: x86: Remove VMX support for virtualizing guest MTRR memtypes
      https://github.com/kvm-x86/linux/commit/0a7b73559b39
[2/5] KVM: VMX: Drop support for forcing UC memory when guest CR0.CD=1
      https://github.com/kvm-x86/linux/commit/e1548088ff54
[3/5] srcu: Add an API for a memory barrier after SRCU read lock
      https://github.com/kvm-x86/linux/commit/fcfe671e0879
[4/5] KVM: x86: Ensure a full memory barrier is emitted in the VM-Exit path
      https://github.com/kvm-x86/linux/commit/eb8d8fc29286
[5/5] KVM: VMX: Always honor guest PAT on CPUs that support self-snoop
      https://github.com/kvm-x86/linux/commit/95200f24b862

--
https://github.com/kvm-x86/linux/tree/next

