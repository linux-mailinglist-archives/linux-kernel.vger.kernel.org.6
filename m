Return-Path: <linux-kernel+bounces-225184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5603912D39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6897D289D75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A417417B4E2;
	Fri, 21 Jun 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvbs2Gzz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5617A92E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994759; cv=none; b=WH7OHjzFlokKwbsP98491pqwqSoO6c2TLiHia+EASNcWL1CZY1SNmEjb+VUw/8IEffNH1pFNzpAorE7bYOSUQRLKZGJ/Kg9ogFje5B4YQYcp/g3OBFrwQJpIesYlUVGxPXQ3aE2OY/BpqhLrknmUq/+wdsBDGuT1NoMwokcmcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994759; c=relaxed/simple;
	bh=0H34soARn+l9ua3hOFI0BtyYnn5z/+diQyMIqihfAwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W2ZJUEVLRJO71XUyrJZhp0TdBQADv+8MTb3yc0rIoelzMQ4NiRLJBM5wUYm92qY3P2pL7Nk+MI8dOHni78SpKFx/TWzjhOo2Z/YN0KhFabQpDWt/a5QVNpaRvpC85bUCbZNdZce9tMkZpR15P4biOhKxcPvI3SU6Mc66vhg4vKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvbs2Gzz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-631b498f981so37308697b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718994756; x=1719599556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjq+poPO8VKzj2zS+5inMc+koR44iKdQ85yHH57Hmm4=;
        b=cvbs2Gzz+uUCkXQJddyah/FnohdJxL3JJG2tmjixdVONRsfod4QQvpNV9vf8/68R/A
         GuwkVc5W/vWM4aC383r4NTBBapf0+91nGWUWFo/Kx99zUq17lSm95Dzskt2DYW80F3a2
         CTeO+nsmkAEEH3rj/U1Meu24tw39QNh7ADjGVYkn1L4q8UzpcywSV9XM9a4PiLfMTDPc
         Jy3w2YkNr7NlKk8lOxPa+KFFzwhNCJ69Bw6Xh3ZsScaftie+5MOrzIdalUTQ3BveDQKg
         T9GYGnz1ZQmYjKm2ReGayBb2YyWzVZ0lvThABurWwFALGhAzv/st4oZ5b33Xi/Rp2e97
         ysqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718994756; x=1719599556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjq+poPO8VKzj2zS+5inMc+koR44iKdQ85yHH57Hmm4=;
        b=vXSRXv68ENQtRuH+6diVr7qX06OTUR+oDPqjJFJMg5BqEyMst1FWuUzJ7rM0sGw/M+
         EAaHKwqhw79YACOcMopOLAQhBI0LAHru1LwXLO3aVpBGqaUvBCfR9I2XC+1MRH+qxjlz
         7PYUJdpMwqBDZgMveh36JR04+qrDPgcQhNj1TMscNrAOMIIvmaYzRiLdpYIZiEOtJGFh
         JWdFTOsmwt0tpnh/ubQEzTinI/8Yz2SmgXjS1unCQREI4o7LMrwIOIzTDs05g5OB3bEz
         GpzSBTdabgLyTDD3Lzo55VHeMerRhyJC9DIPtT/EBwMZBL+sePyrF4gvbA6Ukz5wA4aP
         K3JA==
X-Forwarded-Encrypted: i=1; AJvYcCXBS0uaOb+muddsNbBFBkTbGoHegDoL3snm11+s3nnZL1afe1nGnIB372qp8M4SjaUR8e7D+XqgXHPPaB1OPA9GZkekJtND4R1tnE6Q
X-Gm-Message-State: AOJu0Ywr+LtCOpmuiLStJ16e6B3lffjag718VG3P66cvaWrHQkDC517L
	v7v6l3t3hVsAr+PgimuDgXHho+i2SYi1mmZbD+5XsYC6my1O9kXCjmD/CnA4ZhCo40rNcEvoAsx
	1AA==
X-Google-Smtp-Source: AGHT+IGEjW89Y/O/38ZL3Tnu7qb0RJLIju4LabxToEhzi7MadqEX4RhJshNX3Tuav4hl19hd3OuuQC4QDCc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:25c7:b0:62c:de05:5a78 with SMTP id
 00721157ae682-63a8f524cebmr11574467b3.6.1718994756418; Fri, 21 Jun 2024
 11:32:36 -0700 (PDT)
Date: Fri, 21 Jun 2024 11:32:34 -0700
In-Reply-To: <20240229025759.1187910-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229025759.1187910-1-stevensd@google.com>
Message-ID: <ZnXHQid_N1w4kLoC@google.com>
Subject: Re: [PATCH v11 0/8] KVM: allow mapping non-refcounted pages
From: Sean Christopherson <seanjc@google.com>
To: David Stevens <stevensd@chromium.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 29, 2024, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> This patch series adds support for mapping VM_IO and VM_PFNMAP memory
> that is backed by struct pages that aren't currently being refcounted
> (e.g. tail pages of non-compound higher order allocations) into the
> guest.
> 
> Our use case is virtio-gpu blob resources [1], which directly map host
> graphics buffers into the guest as "vram" for the virtio-gpu device.
> This feature currently does not work on systems using the amdgpu driver,
> as that driver allocates non-compound higher order pages via
> ttm_pool_alloc_page().
> 
> First, this series replaces the gfn_to_pfn_memslot() API with a more
> extensible kvm_follow_pfn() API. The updated API rearranges
> gfn_to_pfn_memslot()'s args into a struct and where possible packs the
> bool arguments into a FOLL_ flags argument. The refactoring changes do
> not change any behavior.
> 
> From there, this series extends the kvm_follow_pfn() API so that
> non-refconuted pages can be safely handled. This invloves adding an
> input parameter to indicate whether the caller can safely use
> non-refcounted pfns and an output parameter to tell the caller whether
> or not the returned page is refcounted. This change includes a breaking
> change, by disallowing non-refcounted pfn mappings by default, as such
> mappings are unsafe. To allow such systems to continue to function, an
> opt-in module parameter is added to allow the unsafe behavior.
> 
> This series only adds support for non-refcounted pages to x86. Other
> MMUs can likely be updated without too much difficulty, but it is not
> needed at this point. Updating other parts of KVM (e.g. pfncache) is not
> straightforward [2].

FYI, on the off chance that someone else is eyeballing this, I am working on
revamping this series.  It's still a ways out, but I'm optimistic that we'll be
able to address the concerns raised by Christoph and Christian, and maybe even
get KVM out of the weeds straightaway (PPC looks thorny :-/).

