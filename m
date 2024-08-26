Return-Path: <linux-kernel+bounces-302156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545FF95FAA6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8764D1C222C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F59619ABC3;
	Mon, 26 Aug 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3sDyybO"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A75199EB4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704109; cv=none; b=XxNRCwPbZhu1xAWK0oKgKsJy7Xh3Ns1Tyh5lF7ge4RUF81KhIoDfFLUSZlBsmrmVaZvaoQ5MiP2Tu88rFaDxK0pDHTcBDsz6hHAneHCRvoOE/Q8ryvfGYBAqf4bNn767IstoFDCkm2DKkA8nFB+450g+NN6H2SaSwG9kO31q0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704109; c=relaxed/simple;
	bh=3aLGWNFml1fs6ET7vU4TR6a4dUKkunevdgnP5XM6DFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L6dIx/Q3MWdbhLpdNercRx97MHOFVLbRC3UKnnUJ1+wo4EhPL3RXUnqxbwigjP0X4RojVrUjr0K/IkRU/PvYMXwwuS5898ZX4W6iJyeP/ajIdrVyjGOuADIXkdIqP0uoqRBJnOI3m+MNrOr5gXRz6VGesB954vpwYe2LqV/90B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3sDyybO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso7630747276.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724704107; x=1725308907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4CuIS2O9/fj+lBdt8ymvV+Stc9+h4xTSSAPFKw9WU0=;
        b=c3sDyybOX74t6cnLJ7vu6bytaZ/pfDV6f3RqG11bxF7Z/PuY1pYdPHkIDyxhMr5Au/
         p/uIvSzDTr5ozdbcR7n2PjR1wIwmIQY53QX3K1XS5CtrnxgO0SmhqMEriGnvyl0gWM74
         dKrPBP8W7m1aUM/jllUUs6e19cPeioW6Hj2E0M3pBSJyErI/JbUfugalnfQsfyyR3e3v
         /PpEvX7V13Ft1nGLBn1Fb6F4A1lq9zaEf2En4P/hTA8GBfB6sa49GLKAcLpyoialNNRT
         ghyHscflNlfsTnHhZxISyXT4SBDgOaj7V57SAkf+gMRXxS2dcXyFTFkxm/pLYktyY02w
         bHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724704107; x=1725308907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y4CuIS2O9/fj+lBdt8ymvV+Stc9+h4xTSSAPFKw9WU0=;
        b=AZar0xxjlq0+2HcG3oglkJqd3uVvz4IAk2i2DItUnuHNcybMITB8KTYF/IQfXczleU
         VWCq/gRPn3JGQpztxltLqNvsgJu2lv8iSia3Pd8WtFK72IfNd8fd5TtGuJFjz29j4rwD
         P2cPprUox4+1TTBztCoYKKBvahRAPSKGzuDy4LfZiVZSxSoB03HOAs01PlRU3S4VxChr
         4iG4gtZMHDQcqA+gKeuaC9+cXSUMx56zh504XIeJxnuUnYfuBwjDic7WxlmSlF8PdLLA
         ONwGDdTMN6hA8xfJpVvjDUNpIdAKNwaXa0vjmn42/pnSxBWjJug6yIZtMk+vBwphMbWg
         JOiw==
X-Forwarded-Encrypted: i=1; AJvYcCW20kyac4uP0UUVB4tCYH4hbniCedUeDVD/E6BMmtLjdHfnv4M4lzwa9Af0Zt2njqEIua+Laxg/DFL44g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgbrubAKLj7putnKSsBVctN8IxJTURBqbF9u2G3s3R0ueRn6W+
	bcDmNWymHy4PshLbvn9FupcseduP7aBLMlv8+YwViHMB6ncs1XHWTvq0IdtFMYZPs3T7+pgDRSa
	QQQ==
X-Google-Smtp-Source: AGHT+IE3PaHVFO73GTuBHSkg/Bp1BYVf64Z5BDMiZlAp1N72Zy30VoStroBvnjGNz6tOuhVG9XuSt7nX3dw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:202:b0:e0b:a712:2ceb with SMTP id
 3f1490d57ef6-e1a2a5a664cmr12509276.5.1724704106889; Mon, 26 Aug 2024 13:28:26
 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:28:25 -0700
In-Reply-To: <ZskfY2XOken50etZ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com> <20240809190319.1710470-5-seanjc@google.com>
 <20240814142256.7neuthobi7k2ilr6@yy-desk-7060> <6fsgci4fceoin7fp3ejeulbaybaitx3yo3nylzecanoba5gvhd@3ubrvlykgonn>
 <ZsfaMes4Atc3-O7h@google.com> <ZskfY2XOken50etZ@google.com>
Message-ID: <Zszlab0BMPKmnOsy@google.com>
Subject: Re: [PATCH 04/22] KVM: x86/mmu: Skip emulation on page fault iff 1+
 SPs were unprotected
From: Sean Christopherson <seanjc@google.com>
To: Yao Yuan <yaoyuan0329os@gmail.com>
Cc: Yuan Yao <yuan.yao@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>, 
	Michael Roth <michael.roth@amd.com>, Vishal Annapurve <vannapurve@google.com>, 
	Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 23, 2024, Sean Christopherson wrote:
> On Thu, Aug 22, 2024, Sean Christopherson wrote:
> Intel support is especially misleading, because sharing page tables between EPT
> and IA32 is rather nonsensical due to them having different formats.  I.e. I doubt
> Paolo had a use case for the VMX changes, and was just providing parity with SVM.
> Of course, reusing L1's page tables as the NPT tables for L2 is quite crazy too,

Actually, it's not _that_ crazy, e.g. KVM s390 does this for last-level page tables
so that changes to the host userspace mappings don't require mmu_notifier-induced
changes in KVM.

> but at least the PTE formats are identical. 

