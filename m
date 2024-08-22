Return-Path: <linux-kernel+bounces-297687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3277E95BC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EC92841AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49F71CDFBE;
	Thu, 22 Aug 2024 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qGFLLSnF"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A790B1CDA2E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345516; cv=none; b=mjjtEVE5GOxFPTyOwHRI1nVoCC5tkUZGD+VBJxLw/6IfugiT4WKtKzTDT/O+0mK6Ghyea2YW4mcW8b7EbPKStKVQpGfWc7wtflCYKEAzUwgDqTW1ZdREl/GOZx+x2msWiEhalnOAqXTflXw0Omty/JqiWCwY8oh2vZ+F1yHKGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345516; c=relaxed/simple;
	bh=cVNamRgTTPUph/x/fshdqE346mjYXp6WSqqsiB6idt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NB4XD0YPpx3G0aRs/06jkL0s68hZXKPz/GrKYp4qvRVKOI5ekApaxcAu22XJwFM74HUd0wXzr/GXyAss9jkJmpiyTPUM8Con8sATwCRXGBpjwSPYqspJ9j6NZz/4tn3zLJkC2otXDoJBApzxPs1/AooP09jWg13/UUCck1pS0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qGFLLSnF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b41e02c255so21177487b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724345513; x=1724950313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zCSmE1QYxaiHFt6KetUwFCv8uHKoHBDLEP/u43ooJI=;
        b=qGFLLSnFmyXnYbqE/WLsE5p/QOli4gCVsrFJWPdH3LrwbT5ymRT1NIpG/Decq10VnT
         yI+6P5uquQUr3mX6XOlqFc7gXVKBcbPs51UifRA0sP9X5wUkgxHh0y9iR0z3oQLcqyjk
         CIHMVIDXcdcjE9zRYbkJ0ETJ8bpWj6Z4/AK8lmcVEXUGfQQnuJALHBRzCi0uao3R1LAk
         v46wPmPI7QHTSpY0nNs3xxhb/aAgkyAmtb1OTOqw/NoryB5p4wjxLZiLfcYueeF6y5lX
         kliBSo0v57GrrMtiPR7v8E0GfzFkOvvQ1hAxk/EawkOUl9rusmUguZ0wUVAQuKLu0YP3
         bGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345513; x=1724950313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zCSmE1QYxaiHFt6KetUwFCv8uHKoHBDLEP/u43ooJI=;
        b=CYY/m+kTtmBvFbBTuP22xLjfRNTjf7Dhdfht0qhHWon5JSMZZ2r1vfTDlg4hLH8GO7
         qeAIeqiFRgGL2KmpACZSBZw9NhtlygQSjD39koT2ja/0IK/D7oOAv6J4k0AraSqnCi7F
         EtZ9h5LbeU6k0OmPyhHei2p+IuGvqItx+Iwu6IbmQ2ziY3rWTTV7TbrvVn8droUT1Vfg
         7Jas6dTcL+rRxn513SM3DO2/8Rnqo+yuZL4E+gfSndVlMxPV0Gm6PnQywtt9ONdpOxaT
         /nuhhT6jEqLryuIoLVqME65RolcAPSmRsBlmbw248DUA4c2DWvnpQoaSHdazPfrPzGLQ
         5Nhw==
X-Forwarded-Encrypted: i=1; AJvYcCWjEYJYSizQEZqcM/MaXKcGBGYbsi25DsEOHKKhIiQdBreMN38uwPo6jWIE8QNfCPKfOCHMyIZ8xU3qmQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwReshHoEJtG12ufiJoFEzLdrshOiQhUnqWbkwZKrAmQRUGHtQk
	87zy+DwsBzBkyboWxLpaMBnaPuy+2Vq2XBS+dpBMabgvHjH+0t8E8xRh3bp/HkMQdaRskM4w6NO
	ajA==
X-Google-Smtp-Source: AGHT+IFHOWS5Qeaqc0Nhr6r3oYMWdFCr1ADlrhpJoXEsAKlJvD8VkWrvIUhtoln4+l7SBE5HM5Lsnip04DE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2ca:b0:e03:31ec:8a24 with SMTP id
 3f1490d57ef6-e17a45012e7mr580276.8.1724345513652; Thu, 22 Aug 2024 09:51:53
 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:51:52 -0700
In-Reply-To: <20240822065544.65013-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822065544.65013-1-zhangpeng.00@bytedance.com>
Message-ID: <ZsdsqHOtsMDSWMuC@google.com>
Subject: Re: [PATCH RFC] KVM: Use maple tree to manage memory attributes.
From: Sean Christopherson <seanjc@google.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: pbonzini@redhat.com, chao.p.peng@linux.intel.com, Liam.Howlett@oracle.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 22, 2024, Peng Zhang wrote:
> Currently, xarray is used to manage memory attributes. The memory
> attributes management here is an interval problem. However, xarray is
> not suitable for handling interval problems. It may cause memory waste
> and is not efficient. Switching it to maple tree is more elegant. Using
> maple tree here has the following three advantages:
> 1. Less memory overhead.
> 2. More efficient interval operations.
> 3. Simpler code.
> 
> This is the first user of the maple tree interface mas_find_range(),
> and it does not have any test cases yet, so its stability is unclear.
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  include/linux/kvm_host.h |  5 +++--
>  virt/kvm/kvm_main.c      | 47 ++++++++++++++--------------------------
>  2 files changed, 19 insertions(+), 33 deletions(-)
> 
> I haven't tested this code yet, and I'm not very familiar with kvm, so I'd
> be happy if someone could help test it. This is just an RFC now. Any comments
> are welcome.

Unfortunatley, you are unlikely to get much feedback (although Matthew already
jumped in).  We (KVM folks) know the xarray usage for memory attribute is
(very) suboptimal, and it's on the todo list to address.  We specifically went
with a simple-but-slow implementation in order to prioritize correctness above
all else for initial merge.

