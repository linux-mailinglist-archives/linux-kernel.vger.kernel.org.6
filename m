Return-Path: <linux-kernel+bounces-259497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6492F939735
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 01:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CED31F2217F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A87344A;
	Mon, 22 Jul 2024 23:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbeTtmJT"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC956EB46
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692690; cv=none; b=eSQ197k/8KaDGDIICRj1Yn1BPhqLl9bXm7igpIu0WwBXmlldx+81jz9h3FZeYXWqzadrRvKob9WEaCZ9kkp0AzbNlcshPwHbUuvmmE9c3MKfONhsrzIL9jypaufnHtyyRmCelKqwLwVHz+T3GfOUru6AwF9oX6Q84ZTqMHFH09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692690; c=relaxed/simple;
	bh=DkseDYfGNcDzvbqyqU0DKg6iWql0jky4zKQP/8CT7IQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXTmxk48L+8j7u3cNudjTyUSuttyaBHi6rcI/EAGNFQgT8N2At794RHSCvCJHTqem89L0ZBQRHa2XvlNPwuVD5wGgUAXYrVzw+KP0THq6TjQPl8Yw7nQRRdcMsE2wCEYerIKakZq3G/9iGtDFDHqJG4qLmrh2MuTNaioIzWx4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbeTtmJT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fd8a1a75e7so830995ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721692688; x=1722297488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiszAb6OEqq/qypn9MCSLFVFctQpfQJGPfYT/lahHTw=;
        b=gbeTtmJTKeWPlkVg5mJMEotFpEDrEIaK5+/qOiljBBUXFd0ByApQBtBohLGwDuED5t
         te+4SmnXdrQyh7iGL47rZhvxcpZqyNe307EllKUcPWn2kLOAFXlj1WWIDtarMI2gJoiR
         X8Fyr9qIN+jin5fxyDeAbiNVEZKzMB1vdn35frvMfZ/BIwLJHr85PamnBa/0Dk31Hy/l
         kzEfG+O5EVH2UCp/7fb8hhwm9jffCKS3l9T0j/VWZ7SNmjsQCkSSlXzo9ItkQNugATUt
         FqaW5eqYtW++IsvXnChWfELHHaKSaw3PAF+C4DO7R5FqkCWkAelgefIJgmcbxEvn7saj
         KT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721692688; x=1722297488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiszAb6OEqq/qypn9MCSLFVFctQpfQJGPfYT/lahHTw=;
        b=aCa4mVLzsqmGFBej0MhHwpKjSBq1dYmY1EwVhoSjj1ho2LBz19hyxv6QtlNRcdTdqd
         4oVcjvTJFJcl0KXvY7+6kuoVa4HDsskW7QOZIb2bCc7bq7cNzsPdQqY4vrNfzod2pG0U
         P3LNgawZrv9+fsSObgGidM4zTlF81IvWw4/tC2nZZrlN8Byxsfyy2csP+Z8cb+AdGUDp
         7BJi3+Gpm75jUBB9NhQMdkZ/2IH9/YQb6DejgEZTDWf6lsceE5NRYWU87l6NkxJZo/C7
         8NOSweACOsXXiERiBbn0eZyNw0bHmqs3heb+urM1pT75TBRy4Mlno0waY2dmYDQFU5BA
         HKIw==
X-Forwarded-Encrypted: i=1; AJvYcCXvT8HxKEzZZj6h6l4GF0gRuKUb7DSKJKGM7nDssXihREd9GO+NMTLhlMhvpcsq+pU4Cgh7PoqXLh2j5quWQy0/18DRpTxQykJQslBx
X-Gm-Message-State: AOJu0Yzv82Oyk80moXXjhjVPzYV+KQj4NgtAZ/rt+PF1ABaR13rFT4BI
	zaszEYZqccS953Tg0v/hxH2ex+RbHNPC6HdxPYCt5JPkdzOg6uKdZl0W9gEQCcIbhmN4C3L8w8y
	9sQ==
X-Google-Smtp-Source: AGHT+IGMCIJ7k/wO1EtyoCI8S2HbGG8sVrIvZRS9cKnBzdCHGWdrefCpopFvU1Qotp33npJMX/2I7gM4+Os=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e887:b0:1fb:1ae6:6aab with SMTP id
 d9443c01a7336-1fd74513c53mr8074635ad.2.1721692688226; Mon, 22 Jul 2024
 16:58:08 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:58:06 -0700
In-Reply-To: <Zp5Wq1h40JMSYL5a@chao-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240720000138.3027780-1-seanjc@google.com> <Zp5Wq1h40JMSYL5a@chao-email>
Message-ID: <Zp7yDvcwfPtgED0j@google.com>
Subject: Re: [PATCH 0/6] KVM: nVMX: Fix IPIv vs. nested posted interrupts
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 22, 2024, Chao Gao wrote:
> On Fri, Jul 19, 2024 at 05:01:32PM -0700, Sean Christopherson wrote:
> >Fix a bug where KVM injects L2's nested posted interrupt into L1 as a
> >nested VM-Exit instead of triggering PI processing.  The actual bug is
> >technically a generic nested posted interrupts problem, but due to the
> >way that KVM handles interrupt delivery, I'm 99.9% certain the issue is
> >limited to IPI virtualization being enabled.
> 
> Theoretically VT-d posted interrupt can also trigger this issue.

Hmm, yeah, I think you're right.  L1 could program an assigned device to _post_
an interrupt to L2's vector, via L1's PID.PIR.  Which would let the interrupt
into vIRR without KVM checking vmcs12's NV.  It seems unlikely L1 would do that,
but it definitely seems possible.

Unless I'm missing something (else), I'll update the changelog and Fixes: to make
it clear that IPI virtualization just makes the bug easier to hit, but that the
issue exists with nested assigned devices, too.

