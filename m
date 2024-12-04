Return-Path: <linux-kernel+bounces-431510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D69E3E57
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33FF283080
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88B420C479;
	Wed,  4 Dec 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7cfGAPq"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8F1F708F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326262; cv=none; b=Tmw+UUntsDhlp9Lx7pFI6/PUZmxqfniLBO+JPRWfVyhgWYG074jptFhR0H/UZCmfnssosIMfnm1OCgAtMPrSqMzOmxC7/pHmvOoHTxcPCaopGoF1kAbnQsKos2vI+kdxEpJw2Jp7IZ8Hg2ew+CkiKmDJbIKwT0DYmCSckXwm5DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326262; c=relaxed/simple;
	bh=raZSwCSoIxMAMxZedsY7kgc1gQPkh8K/6vkYq+qQ0yU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cUAxwhQ6lgirhy0MVyfZUod3rR6Q5SnuZQm1JO0fFpV9FmtQkeaBCDjmp6bgTVyJOMoa+m+O/3cHz/QRjpYl4mTmBevSzAYrrrxvy7aigCRpwb5yKD+VYZKHJL6l+PjqVW2A2NAoVZUrB58AwstuTwdT4dmsyRb3pQenf9eaK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7cfGAPq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e5efb04da7so6490093a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733326260; x=1733931060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWzYXhh1XGle9PKP984gp5jQmjBdiOdHdzDrlgt7MZk=;
        b=s7cfGAPqPixORq7s40p3eeNZ/H1XR5cPKckVKg9m2ggNuD61U8uFHMGNSh5YYHOw10
         PWLRT8ocbR8jRE7eFe8qEQHHCvtINmDWRtHDPVIT8ZRQf2lijLxqDnx6ctnNzl8w7ltd
         5XKX+vMjqscW+ArK9+OzUgcr9T9YzWGXmvw1ymuRLiWJ7nsdvE1n+GXFWU3WTC8hL6z9
         vG4S6lHJUkQdTKys0Qy4BrcXPZlT7+wcqKlyr618RWtSi3AFrSuhxewrwPA6fIMjigMK
         hLCupV5MSqWMJgG/O2IkIdW7D2a6fQcMMNadBY87dR3T9r2Xxus3VCMEhhT6b9r0V1fk
         k/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326260; x=1733931060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWzYXhh1XGle9PKP984gp5jQmjBdiOdHdzDrlgt7MZk=;
        b=wdm6I2gVUTYC6WS6h0RqJ+ml5tpEhZ3ArEv718rj9lHIUtln5i1tCulIwdYvXI3Udl
         FBCDleVG8vQVWl6YbborxWtkowPCdTOyS4xSG+31UQ0FfB0TdU+sOVkFw2swBlvNJ66V
         Misp96UieeapqUM/qJxRg2uN5H9PYmJ7QpkX88TFbbUj4gm9MMmGClp0EUy8tBH7VEqY
         uTDvJHXer2lhCLA0YPrX+DJ+DcrRiBrD5//nToPm5bUe9uDZlX4WKSv2HGCSbAHKv0a3
         7TQow1LY/lC9OHoOsS1orZToMTp73SFibD/c8eBHhndXlHIX6WYejBT2XLff9mAZqYIe
         mc0Q==
X-Gm-Message-State: AOJu0Yz8+kKT4lW+MXem3OYho7uyQKnEN7vh7OBt12XfqAsZAAdFjPWD
	4s2DkVWBCFM3nKKeRhj4YCPMWHe87hkCfH6x19ZlRNUxCoHCtuWYjI6fv1TqhaNHB7dJDvqZUJS
	BFA==
X-Google-Smtp-Source: AGHT+IG8hKZnFRirR/ao2e8umiwaB/AV15nxqrbtp2UlNP2cgH4Q1y4HPfvHflLtOx0OwlnKrZjyoia9Lc8=
X-Received: from pjj15.prod.google.com ([2002:a17:90b:554f:b0:2e5:5ffc:1c36])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8e:b0:2ee:f550:3848
 with SMTP id 98e67ed59e1d1-2ef011e3802mr8465345a91.5.1733326260234; Wed, 04
 Dec 2024 07:31:00 -0800 (PST)
Date: Wed, 4 Dec 2024 07:30:58 -0800
In-Reply-To: <20241204103042.1904639-12-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204103042.1904639-1-arnd@kernel.org> <20241204103042.1904639-12-arnd@kernel.org>
Message-ID: <Z1B1phcpbiYWLgCD@google.com>
Subject: Re: [PATCH 11/11] x86: drop 32-bit KVM host support
From: Sean Christopherson <seanjc@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Davide Ciminaghi <ciminaghi@gnudd.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 04, 2024, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are very few 32-bit machines that support KVM, the main exceptions
> are the "Yonah" Generation Xeon-LV and Core Duo from 2006 and the Atom
> Z5xx "Silverthorne" from 2008 that were all release just before their
> 64-bit counterparts.
> 
> Using KVM as a host on a 64-bit CPU using a 32-bit kernel generally
> works fine, but is rather pointless since 64-bit kernels are much better
> supported and deal better with the memory requirements of VM guests.
> 
> Drop all the 32-bit-only portions and the "#ifdef CONFIG_X86_64" checks
> of the x86 KVM code and add a Kconfig dependency to only allow building
> this on 64-bit kernels.

While 32-bit KVM doesn't need to be a thing for x86 usage, Paolo expressed concerns
that dropping 32-bit support on x86 would cause general 32-bit KVM support to
bitrot horribly.  32-bit x86 doesn't get much testing, but I do at least boot VMs
with it on a semi-regular basis.  I don't think we can say the same for other
architectures with 32-bit variants.

PPC apparently still has 32-bit users[1][2], and 32-bit RISC-V is a thing, so I
think we're stuck with 32-bit x86 for the time being. :-(

[1] https://lore.kernel.org/all/87zg4aveow.fsf@mail.lhotse
[2] https://lore.kernel.org/all/fc43f9eb-a60f-5c4a-a694-83029234a9c4@xenosoft.de

