Return-Path: <linux-kernel+bounces-395949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFDF9BC537
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031251F22C86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA41FDFA1;
	Tue,  5 Nov 2024 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w5c4CXLK"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D61FA25C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 06:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786514; cv=none; b=FCz0dPQMLPlSiXp2IyexUkE/jdPEtuzB6rRPfsMvyXjWYmkTUXFftVPsnT119TmQCHEK6PHqGC5QZrP6R6pxv15h3eGscTvvdoiAXU3fnKJpLqHiY/0sJ47V/847U7121VKyV+6kWLnB5xwG8jLR/dWoTU4cDihgiUYHTxkxUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786514; c=relaxed/simple;
	bh=/UlOrFTZSFlr0Nzg7BNU9vAMbBRUCMAOKdKubKzwGHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N5K0WPApFdvUubgxRWXEMh8LUwpS+FvX5ynOBOPpEOQDpw8BhpBuf85BlcHtRX0eMcJWlcHQZNrqQAkfwTWXuD9Uv0qQRW9CYZ2ynsFsLI4CVNfNHMdbdKHa/13/PfC3bD6hbtgqG+j6BFNaxjNz3gI8ieD3QunhkDb1HRcqoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w5c4CXLK; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d1fe1dd173so4505325a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 22:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730786512; x=1731391312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFxRma95FJlL/AZ0ZFonjChFS5fjisz3cC7jq4qdDmw=;
        b=w5c4CXLK9uLT005PJlvIbNJmVGmWLKVyqrIopJZXfDCHYkOXe2feIxaKvh9ztNVR9W
         qg7hlFKANtH3266tQ3ho5sJz0AOplicb+USeeZg8NBIcmtl7GCtm06Zt+yJXWTAeauKE
         E6oGk6d81QtKJ2y9gUKqxsr5SZwKkbo7ZmaYt+gJun2pv+jk7Y1BKFAYrRTeZOvBQBRb
         eF5F4L7CoL5yP9cMy6WNqERhFntyaME4rzNaLXEzRLnRfVteXSGL6BbgpzhVoYrHXHAN
         Xo7QxYDSi/7foQmojesOeXv+ytLsc/4XYkmW4UFxPWbLfTzPoba45HLxJ4KpVDKmjwL1
         G9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786512; x=1731391312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFxRma95FJlL/AZ0ZFonjChFS5fjisz3cC7jq4qdDmw=;
        b=CaSPTIwSv5g9EUvxI6RwtB7Szl5I0+PqqY/gSJLov7Pgh0jMkc79Pma5CGvYQTX8NX
         2guvTjouEluFs4WUYOm6XmmACb6mN5Phn5KrkcSqrBNFrMu3fzyNHG54r6XhgGWLTgQg
         n2iikq5aqSIyciyh5/6Ugdo+sPv4Na9RTCmpWzJR8tWL+2lLGad4ZjBgarZfBDrqiXmk
         mRCJEae5KHT86fehEaBupmE2R6WvimPaPgbObuWTwvwGs9yrftYYEH/KFWU6DaHKPaiw
         67D+ITrqTW4vLrrPOi9j2iFd/pzRS2lTjMdPgYx25ZIb76UqOvMhDjujAr56ge8Vatwe
         GrYA==
X-Forwarded-Encrypted: i=1; AJvYcCWsN1gCS0oHu9vNHcCRwIye1qAlGU5+SPQsYWbO+4oDcoV3cs1k0i0k3QMfPUyM5yvoIZ6mz2IYUXf5WrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUGy0qlwbV6kbowMp8OvPkDuBkHiFPnh/kqUbdRnm1BD0iRyB
	J9A+xFJ8Fnl5zJ217MhEDrl8N6YwN3GCmOXT+hKvwaKrrA/t/S8g2FPvRryHG/PzIFjiAH9DaOY
	DQw==
X-Google-Smtp-Source: AGHT+IH9T5jG5+lq53S2D8rKsYDIM5HfeP4IAZaAh9l7gKD/WhV0dE367bDM6wdTRwPCFZQ3eWzJ/JKJ50g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:2a92:b0:7d6:4cd5:32f4 with SMTP id
 41be03b00d2f7-7ee3a38c4a1mr23159a12.3.1730786511409; Mon, 04 Nov 2024
 22:01:51 -0800 (PST)
Date: Mon,  4 Nov 2024 21:56:11 -0800
In-Reply-To: <20241101201437.1604321-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101201437.1604321-1-vipinsh@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <173078270653.2038440.10448863177930046934.b4-ty@google.com>
Subject: Re: [PATCH v3 0/1] Remove KVM MMU shrinker
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, dmatlack@google.com, 
	Vipin Sharma <vipinsh@google.com>
Cc: zhi.wang.linux@gmail.com, weijiang.yang@intel.com, mizhang@google.com, 
	liangchen.linux@gmail.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 01 Nov 2024 13:14:36 -0700, Vipin Sharma wrote:
> Based on the feedback from v2, this patch is now completely removing KVM MMU
> shrinker whereas earlier versions were repurposing KVM MMU shrinker
> behavior to shrink vCPU caches. Now, there is no change to vCPU caches
> behavior.
> 
> KVM MMU shrinker is not very effective in alleviating pain during memory
> pressure. It frees up the pages actively being used which results in VM
> degradation. VM will take fault and bring them again in page tables.
> More discussions happened at [1]. Overall, consensus was to reprupose it
> into the code which frees pages from KVM MMU page caches.
> 
> [...]

Applied to kvm-x86 mmu, with the massaging and splitting.  Definitely feel free
to propose changes/object.  I wanted to get this queued asap to get coverage in
-next, but I don't anticipate any more MMU commits, i.e. I can fix these up
without too much fuss.  Thanks!

[1/2] KVM: x86/mmu: Remove KVM's MMU shrinker
      https://github.com/kvm-x86/linux/commit/fe140e611d34
[2/2] KVM: x86/mmu: Drop per-VM zapped_obsolete_pages list
      https://github.com/kvm-x86/linux/commit/4cf20d42543c

--
https://github.com/kvm-x86/linux/tree/next

