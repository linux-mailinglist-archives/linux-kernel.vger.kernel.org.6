Return-Path: <linux-kernel+bounces-232827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6C91AEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AED91C21C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520A619AA60;
	Thu, 27 Jun 2024 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QO4zEX1b"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BB37165
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511631; cv=none; b=b7FRhwRit/TMngVZ3gQa8htALK+Vn1WI0dBLLRpFXBbCfgHgSwU6crwA4wxCWYiVmzEadRGRnCRo6ResNmm30eGL/9O11EssCxCYlBdL5OdRG3d7zTyhmeT7hHoQtpty5XGFRqoNyufcKFzs/qehzmP9bdJhYdrtooz6iUPLMVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511631; c=relaxed/simple;
	bh=EAiH5AcxDGizDsjRBCmIonmcVf1bNXt8AIH/QALB0Ns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FKsJt1s44x2uWhO9YBoI3hLNQBpy9XZJB+P6sTt0t9PEBtQzuS+GPEpuGok1Kn1FTbmuJJmrPFjpii5XIn5krE77Nkv4xD9KzzFnnMEpvxkFiDSLEhnz9ovOnpr+DTyEI2+0btRd5S3EE4VJk0jGuPVB+wrod8vMo9KeQs62jIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QO4zEX1b; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6e67742bee6so6272332a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719511630; x=1720116430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6j+LQp+Ou/MLEtOL32JfRKdC+LpNg62gKylauHIOE=;
        b=QO4zEX1b4IwHvNnNyRT5gUXRD/ueBhs4uQ7v5IR+8hD54GFYFxyx/LToot385fvT2p
         l76yTPuxgUif/1fvxZDTSDunZvET3WwSOplnEKI9B0Tu6y0VBtxng+1Dl9NryidrcDQR
         eloL4Hmh8Y0JRtDousrBZiezwyFQARuFkT4dGcDoLqhMnZnh01ZRtnitbnVi9UUaci9H
         8NLX/XrJabzAoP0KSHQ91fTawLy8BRmBU+lYnl8mrcHJXbrpBuPx6gVuU6mAK281zYHO
         DojpEYyj0iENiqDv7JjKYw1f8F2UshhYEuEBDC7fG2qVzulVLqoaY66c/TlNzWG/JJrI
         kb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719511630; x=1720116430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly6j+LQp+Ou/MLEtOL32JfRKdC+LpNg62gKylauHIOE=;
        b=snykkB3GvOpR/O9VD1xY8CwQngnYN8VocdKSYQjjKT/C8yY6uKuY+7wYR5kc4qMUKC
         dPwjwOJzWmQIx2LXSNEHi+A/K7mc10n+kk9+hCoFQrm33nWeRC5QWWtBWXYIqCrbcYjJ
         lCP48CVKZ86znTqk1RzwLHKvLxqzvBb7V1916C6B3oMmzF8nTtQrnknhrS8zpOlig5Qw
         kva58P0nuce3isfV1AWiLMl+dmNBwfXICR7GeoEnI4kPMvrNLW7Xk9SLOoKJgoq9f/XT
         D140xg1JJ4jeQag7eKqXvCeEV0s0gQAM+3+oqrEtustyaWythbMmNwLGa6CllRrbw52n
         Jv4A==
X-Forwarded-Encrypted: i=1; AJvYcCWZZdcyTJdIyUnmTTvEb4yGufWulA6BNkIjaeAbn0ixEo9zVqg7znx9mhE9U+opr5X/VT8pmN0UeFJTun9qaqqSNK05jnF5C172YJq+
X-Gm-Message-State: AOJu0Yz9fef2AFeEEX6FfaLn/SKr1057O6Frdsc/f4NKVvi+zObu+zm1
	tnctjZnSmKXb0HGNLIg6h8ZNo5VFk3LzVFMr0sRy8+czfMuOAkdZcn0h1yQ3L8yL/Yb90lWN2lN
	ncw==
X-Google-Smtp-Source: AGHT+IGB7UmqG7gr2s7ZFzglQssq+22/a1ExsgepdyatAXjw/z8ykZWCdPSekWALd2u1nA+fi04auchOvYs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:591:b0:71a:e413:b0ef with SMTP id
 41be03b00d2f7-71b5a24f606mr39867a12.3.1719511628344; Thu, 27 Jun 2024
 11:07:08 -0700 (PDT)
Date: Thu, 27 Jun 2024 11:07:06 -0700
In-Reply-To: <30988934-c325-64eb-a4b1-8f3e46b53a55@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621134041.3170480-1-michael.roth@amd.com>
 <20240621134041.3170480-2-michael.roth@amd.com> <ZnwecZ5SZ8MrTRRT@google.com>
 <6sczq2nmoefcociyffssdtoav2zjtuenzmhybgdtqyyvk5zps6@nnkw2u74j7pu>
 <ZnxMSEVR_2NRKMRy@google.com> <fbzi5bals5rmva3efgdpnljsfzdbehg4akwli7b5io7kqs3ikw@qfpdpxfec7ks>
 <ZnxyAWmKIu680R_5@google.com> <87320ee5-8a66-6437-8c91-c6de1b7d80c1@amd.com>
 <Zn2GpHFZkXciuJOw@google.com> <30988934-c325-64eb-a4b1-8f3e46b53a55@amd.com>
Message-ID: <Zn2qSl2zAjCKAgSi@google.com>
Subject: Re: [PATCH v1 1/5] KVM: SEV: Provide support for SNP_GUEST_REQUEST
 NAE event
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com, 
	jroedel@suse.de, pgonda@google.com, ashish.kalra@amd.com, bp@alien8.de, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, 
	Brijesh Singh <brijesh.singh@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 27, 2024, Tom Lendacky wrote:
> On 6/27/24 10:35, Sean Christopherson wrote:
> >> The page states are documented in the SNP API (Chapter 5, Page
> >> Management):
> > 
> > Heh, but then that section says:
> > 
> >   Pages in the Firmware state are owned by the firmware. Because the RMP.Immutable
> >                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^
> >   bit is set, the hypervisor cannot write to Firmware pages nor alter the RMP entry
> >   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   with the RMPUPDATE instruction.
> > 
> > which to me very clearly suggests that the RMP.Immutable bit is what makes the
> > page read-only.
> > 
> > Can you ask^Wbribe someone to add a "Table 11. Page State Properties" or something?
> > E.g. to explicitly list out the read vs. write protections and the state of the
> > page's data (encrypted, integrity-protected, zeroed?, etc).  I've read through
> > all of "5.2 Page States" and genuinely have no clue as to what protections most
> > of the states have.
> 
> I'll get with the document owner and provide that feedback and see what we
> can do to remove some of the ambiguity and improve upon it.

Thanks!

> > Ah, never mind, I found "Table 15-39. RMP Memory Access Checks" in the APM.  FWIW,
> > that somewhat contradicts this blurb from the SNP ABI spec:
> > 
> >   The content of a Context page is encrypted and integrity protected so that the
> >   hypervisor cannot read or write to it.
> > 
> > I also find that statement confusing.  IIUC, the fact that the Context page is
> > encrypted and integrity protected doesn't actually have anything to do with the
> > host's ability to access the data.  The host _can_ read the data, but it will get
> > ciphertext.  But the host can't write the data because the page isn't HV-owned.
> > 
> > Actually, isn't the intregrity protected part wrong?  I thought one of the benefits
> 
> The RMP protection is what helps provide the integrity protection. So if a
> hypervisor tries to write to a non-hypervisor owned page, it will generate
> an RMP #PF. If the page can't be RMPUPDATEd (the immutable bit is set for
> the page in the RMP), then the page can't be written to by the hypervisor.

My confusion (ok, maybe it's more annoyance than true confusion) is that that
applies to _all_ non-hypervisor pages, not just Context pages.  Reading things
from a "the exception proves the rule" viewpoint, stating that Context pages are
encrypted and integrity protected strongly suggests that all other pages are NOT
encrypted and NOT integrity protected.

