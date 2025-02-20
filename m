Return-Path: <linux-kernel+bounces-524520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0858A3E413
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06C73B5146
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2915214A82;
	Thu, 20 Feb 2025 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzaldBYj"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D811FDA7B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076606; cv=none; b=ZDlCGJMjOxglz8uuxMtUFhbWlok+XcR48vrVA5QDtBZs7/pANrqRDVX9BC+bPlzQUtoSkiw9NYQxjzV3HV1RTMs5vwRjr5FGU18jHpIuB6CUSVzSfesREBOUFkyp4JU+BD9apWp/vW3hNu8XclrhxJezNQQ1gi6OHEGVh5d5YJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076606; c=relaxed/simple;
	bh=KlLfu1MkFZm5HEQhrB3pQU86Of3CyX4PnSBkP+c7phk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X6ioNtJhbox5TfDuBiyc0MUUNXsReRnch0F8oBrCLzBBotz+lKrJajmGYbI+mzNHweKVUp6DkUlCGk7iZ7ZReJpD32qQ4HTwJd3SOL1aQvDZi8SwRFAfNzyFxDgJ7RA7Nq76JFU9r4V7UPMrDaV/rNsYfR3qTHzDPr3J4G5ZEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzaldBYj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22112e86501so24169445ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740076603; x=1740681403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDNUvxXFmySrAvdSQJQ7oCShATU6CPkIP5Amx5DX2gM=;
        b=qzaldBYju7YKzjPMKoymufxXkvBPr898YFr8OTVCCbKQeAYu6M1wG82mWyh3yAeEcD
         /oEtLexkyXIhJ2pf5O8+QJ1yOmAI8TPWBsU0xAl1lYa3KcTdx2b8VJYpBibVB/BuKgva
         ht0HDLb8f61a7zSXzHVWpPaqrIffWFS6FwKBZYqWk5wsCGp3elbzIE7QHvZM33WZHXet
         G5LWREAXiqoMZUBIAvmlJKzey4ccpfhBpJqcxLkCqFkelM/Paz/QR4wW4UO4wt/7tOsN
         RgHJKQ3zvBzgZULV/14NEQG/i+IIF6EcO71C3LDhEj0h3DAvvKWdGrLXx5eP7Mg+MQT5
         cAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740076603; x=1740681403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDNUvxXFmySrAvdSQJQ7oCShATU6CPkIP5Amx5DX2gM=;
        b=o/HSo0zGNl0pxNC0XooBACBN90GV0rbQHE1hIDC58q46P8urM6s+5sFoBGaCyEUNBB
         CIEnqUdDvp6Qp2oCCZpdlpZAQqfLB5inZtGAvCDd4w63nJdRMrx3vm2PR7yOdfJqZaln
         EtCLinohYT2ykyK7sYa1phlUgStZJ7/JKAzbtYa51N6p+IiGhOeGK0WOiped/AYo48M8
         aEhjrqbRK9yP96j7PFJm1/SpnLOU1Dgou003zgVWZIpOgUcfVUaIvhw5v/z4SS7DOOdS
         FKjwDNgDlvZdlzhjIF4mQEWFwUc1Vf/zAxWk42RwXBQS1O+G7d0b0ucYYZ8zFFwz6hEe
         2w9w==
X-Forwarded-Encrypted: i=1; AJvYcCUMjhdz2czH/X842aiq5xnqxe3KugKVXh9b6km2eTK+CjhSJPTviH3VHogUbzV5j9g5Yq4SrOVcTWO+oG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSL31FMxGW9+sRwU36n710cS1kxa6t8/WcBBhX66cFDU+m9++
	2BGYPQQlTvcmo+AjIYCH+kb3aVOdADPGUrHXwRiPGIQZUVZi6gi3Vujoo7tmVLipMNwdQabDc7b
	23w==
X-Google-Smtp-Source: AGHT+IEJil2ZW7pHAGLzwraa/fR/QRtEg4mHPzfjLeTf/sMrCYQHYA2Opge3qlpebbm4GGfgfIrW2itPA/c=
X-Received: from pjbsy7.prod.google.com ([2002:a17:90b:2d07:b0:2ea:4a74:ac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c5:b0:220:e63c:5b10
 with SMTP id d9443c01a7336-221a0015676mr2719115ad.34.1740076602974; Thu, 20
 Feb 2025 10:36:42 -0800 (PST)
Date: Thu, 20 Feb 2025 10:36:41 -0800
In-Reply-To: <DC438DC0-CC4B-4EE2-ABA8-8E0F9D15DD46@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215011437.1203084-1-seanjc@google.com> <20250215011437.1203084-2-seanjc@google.com>
 <DC438DC0-CC4B-4EE2-ABA8-8E0F9D15DD46@infradead.org>
Message-ID: <Z7d2OSNSXIi5PAiR@google.com>
Subject: Re: [PATCH v2 1/5] KVM: x86/xen: Restrict hypercall MSR to unofficial
 synthetic range
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 15, 2025, David Woodhouse wrote:
> On 15 February 2025 02:14:33 CET, Sean Christopherson <seanjc@google.com> wrote:
> >Reject userspace attempts to set the Xen hypercall page MSR to an index
> >outside of the "standard" virtualization range [0x40000000, 0x4fffffff],
> >as KVM is not equipped to handle collisions with real MSRs, e.g. KVM
> >doesn't update MSR interception, conflicts with VMCS/VMCB fields, special
> >case writes in KVM, etc.
> >
> >While the MSR index isn't strictly ABI, i.e. can theoretically float to
> >any value, in practice no known VMM sets the MSR index to anything other
> >than 0x40000000 or 0x40000200.

...

> This patch should probably have a docs update too.

To avoid sending an entirely new version only to discover I suck at writing docs,
how does this look?

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 2b52eb77e29c..5fe84f2427b5 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1000,6 +1000,10 @@ blobs in userspace.  When the guest writes the MSR, kvm copies one
 page of a blob (32- or 64-bit, depending on the vcpu mode) to guest
 memory.
 
+The MSR index must be in the range [0x40000000, 0x4fffffff], i.e. must reside
+in the range that is unofficially reserved for use by hypervisors.  The min/max
+values are enumerated via KVM_XEN_MSR_MIN_INDEX and KVM_XEN_MSR_MAX_INDEX.
+
 ::
 
   struct kvm_xen_hvm_config {

