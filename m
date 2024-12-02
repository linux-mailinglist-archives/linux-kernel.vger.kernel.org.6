Return-Path: <linux-kernel+bounces-428184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DD89E0B22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72C92812F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A731DE2BA;
	Mon,  2 Dec 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GwPTX+we"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07761DDC2D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733164569; cv=none; b=jufffAtehHbFOfOJZty0NclNlIE7zKYxpjKyb5sS5IOXb2fY6C3wCLreBeC+eXQDWGmRzQXt0Z0X3FgVtztQY3HNn7OurJWObBBgDTWW9SD7L8m9rFQWPOB/7Wqq3IsfmQPvHqMZCTecKfhKldviinyy3zExVHj5/5YcTX5s670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733164569; c=relaxed/simple;
	bh=JhPRv+gPDMTF92gaKR88jFjruNF+A0nmJtg8odH4PDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p7ZoumA4NhhGrYqY6TwIVUnYqjWTw9ToCGBsFu/xaOGcomE7mCS7UmvVqHqr42ugsnoQpGno2aNfU2uP9+ZMmEwWlYFXLIwcaGl/5DHWquYqk9TbrIwNCP0M36+wLlJAh9h4VncEXooCmCOA3X7olCuTWo2CKFUBWHFhiPt9dtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GwPTX+we; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eea74eb7e6so1677109a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733164567; x=1733769367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dmhoE4cYt7rjQRHzT+iWiPMuGFQ3/gi9W/Su2Z8nl8A=;
        b=GwPTX+wexZa1w2E7LcIVqu4jNea4h97hp1wyVyQ0WpJvj/kpvfIIguj4rrmo/tNd9q
         LIlwE0Wz/ce9Jn0xyKz1krRy55+5c56p/A5/tShp3shIoQ7jKlLkGApmhC29MCWpljvR
         HptgIyL75BYEeoPosOw+AUtdI0lozuzCFg56Rv7/Nj2CaCfgNeiLe1pGYbOYhFbdZ8ak
         k8K67YLFtvNYOcynYQu1qGN31tMaAck6gLAEb/PYv00B/Cw6y8soyRBXaDOt9nYseJ/o
         JN6lRifwmGrEhGzzz6BYLG7UW6Mv0y49oYmTqFFtGD5xkI7Ru3tRizHTvOFb6QuU24qw
         Bx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733164567; x=1733769367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmhoE4cYt7rjQRHzT+iWiPMuGFQ3/gi9W/Su2Z8nl8A=;
        b=QJHrVfeukO3VvGww8bIEJk6TnW7O5mUeZAiCuZlY5jcicNvcBSIvDgp+ZJm3tkQi3g
         igStDPm35jgi0OASuL/YyW6z0sqBAW1wzoXcWqvu24NWnKxKpWUAwQfS9caudURtLIwF
         0JOK6ad9iLHT2gT0n2o0xr4i+wdsMWoH716xn8nyX4PuQREjtvrf6wX2KEHFT9/Zvfpx
         FekscP5O9qmmpY309Si5ueohLB2KfBKsB7xWshBYsogGe822Iv73CsydozAzl+fTKYX7
         u1vS5EF3B/G4RPixgLUOyOGPyG6byTGfMC/SthZHOoNqNGwos1tVJpXjixtPt7olb/9k
         DE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpnK7EbwZePmp98Ddq6uw2b1GBwpGLN9J+w4oOf+SGHwTv8DfOyCNruLI1/kZHi4egzXPjKJocMuKWD70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTYBNjZPOAZvvivpk81YdJtNIqMl0SlfuyoShtCPfqTbmxvQsl
	EUd3p7Z944zlgtHafDVo0v24MWN7bxQdjFjLT1JZOPt3OfN4U9hUcNOe+aQhVozZaSL7WNnU/MK
	B3g==
X-Google-Smtp-Source: AGHT+IG+yibGcr3UBT8GYMqK9RUzkIylDwqwGeEVnrlV5H+vn+hjSd3rZQdwVZ+U5jysAAzoOzzga9AddC8=
X-Received: from pjbsw8.prod.google.com ([2002:a17:90b:2c88:b0:2e0:915d:d594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c07:b0:2ee:ab29:1a63
 with SMTP id 98e67ed59e1d1-2eeab291d40mr9629060a91.3.1733164567155; Mon, 02
 Dec 2024 10:36:07 -0800 (PST)
Date: Mon, 2 Dec 2024 10:36:05 -0800
In-Reply-To: <0dd91e39-c4b7-4740-b469-6f71e48b72de@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1732219175.git.jpoimboe@kernel.org> <20241128132834.15126-1-amit@kernel.org>
 <20241128132834.15126-2-amit@kernel.org> <7222b969-30a8-42de-b2ca-601f6d1b03cd@intel.com>
 <4601ca077c95393837eb40909c941a4d67bb04dd.camel@kernel.org> <0dd91e39-c4b7-4740-b469-6f71e48b72de@intel.com>
Message-ID: <Z03-FSa6nvVbFjwc@google.com>
Subject: Re: [RFC PATCH v3 1/2] x86: cpu/bugs: add AMD ERAPS support; hardware
 flushes RSB
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, linux-doc@vger.kernel.org, thomas.lendacky@amd.com, 
	bp@alien8.de, tglx@linutronix.de, peterz@infradead.org, jpoimboe@kernel.org, 
	pawan.kumar.gupta@linux.intel.com, corbet@lwn.net, mingo@redhat.com, 
	dave.hansen@linux.intel.com, hpa@zytor.com, pbonzini@redhat.com, 
	daniel.sneddon@linux.intel.com, kai.huang@intel.com, sandipan.das@amd.com, 
	boris.ostrovsky@oracle.com, Babu.Moger@amd.com, david.kaplan@amd.com, 
	dwmw@amazon.co.uk, andrew.cooper3@citrix.com, Amit Shah <Amit.Shah@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 02, 2024, Dave Hansen wrote:
> On 12/2/24 10:09, Amit Shah wrote:
> > I can still include the summary of the discussion in this patch - I
> > just feel it isn't necessary with the rework.
> 
> It's necessary.
> 
> There's a new hardware feature. You want it to replace a software
> sequence in certain situations. You have to make an actual, coherent
> argument argument as to why the hardware feature is a suitable replacement.
> 
> For instance (and I'm pretty sure we've gone over this more than once),
> the changelog here still makes the claim that a "context switch" and a
> "mov-to-CR3" are the same thing.

+1000.  I want a crisp, precise description of the actual hardware behavior, so
that KVM can do the right thing when virtualizing ERAPS.

