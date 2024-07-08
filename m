Return-Path: <linux-kernel+bounces-244829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD992AA03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AB0285297
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732C714B97B;
	Mon,  8 Jul 2024 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4tnB4E4o"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A721CD3D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467802; cv=none; b=avTA/brqZ2/pCZ4abKKmNe6MS5Hs/M4VEu6hC7RtQrpu4onCcNM4lX8whd8DbHTaoLg+ydz+NpSZVL2uwEX1Xo52PxOj41HrYOuv+jiEIuUH6/N03m2ylgQ9OebY0CWnk1tTEqU1Ia/W8AgGbyqJRpHn3U/c77VuinWnaEt9b6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467802; c=relaxed/simple;
	bh=PwYSrGvWyp2mBlqZE2ib4DgilT0aa/7G7MIH/kwry+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=In1jhdXqlbIe8NJ8LWDcFtJXjrUQNjOHWSt623qdLy5edfNdrjBTsvy3Q5gDWh8DgVE4Vp0AHfRfbuEKxPj0JbvrvIH3OH5WuVHzz5uWwp4LiQJD9sXdYsUJxvUyURkQ5YBNX8HCjymHfCoALfqMwEdtYgrTvH67eHuXLbA3BgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4tnB4E4o; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7611da4ccecso1890000a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720467801; x=1721072601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TrHQCqF+JwqYvqJUr0A51YGzeG59hgtXICjXqzpTAU=;
        b=4tnB4E4ojZYWfbo/MFnfJ8Pm1E+TKSOlorFoh6b7yCg/IpJdrZkPnDpJv3xL0rk7Qm
         B50Emy3rekleWLlvdojMEtvAR76cTXrZCVJdrhauUEMaUovVcb1XBPVjJWsrUnGsBwts
         kAxqOYl59SNUpbh65zRhLVGcHLNQXaJwoQvjVYCIwItzE7RGnq4cX1rBjdu3OWorA2fP
         6hM9x9uFu/ZqjGtF/+66PZXcaQ45Qubwo9N7dPHUZnX/TliHwOv30Zznj2c2+c/0A51r
         aBrg2xdSKXV8ORJc8CisAEj/66jGLdRegIgOb9ye1Rqi7kDofytsldJSC7oFYaGJpy+B
         uRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467801; x=1721072601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8TrHQCqF+JwqYvqJUr0A51YGzeG59hgtXICjXqzpTAU=;
        b=bM7Wvc//tNC4YjvvtE3gJLc1pFE015IQAbdf9YlN+U4xKgwtZty0Ty11Gm49bSg4uD
         aMknMIpaZOnKAIlYFNS7lk9EvYP9ZA9tZVwzsokTQ4d2r1OjuxfGvW25XrY24yKUcFWQ
         0Cu5Q/ORxBZ8K50RdDqYHG4ju9vtoyn04FfgLmZpV/qvs+IDioi9oun/WzxI6O/ol8Ar
         I0GHnq/4i+ReXZPyUKBA2gskQvHNVUkb3cSnkQ+EcDFy45dNLwh9+rr8px+bkidQWXjD
         pP8PUiznJLKu326eWeysvvaOp+nhmDaWQf7081Lifrlh7VRJBj+H6rBLUaIwGdlj0Va7
         GcsA==
X-Forwarded-Encrypted: i=1; AJvYcCViObgNGxdWjk+YdRTUsPw1ueObjmowR7ZMY0M6cMKUtyepOWN8iPiX+sq2Xug5tupm9lrRTZT0EYFMay4XyWLu7pZPgSq9spCEtyJF
X-Gm-Message-State: AOJu0YzT3AJlCuyPjgNM2D9XDTOfCsCNyNOynDjj7kHK6Wfyypt3nGUi
	PQu8SYBm93DY8zb3IiDAe8g9xiEQ2HDxSIaYYmu3hoR3Ef4KnCm4ZpREkNoPkAZ3Sm87Xa1nM09
	8Rw==
X-Google-Smtp-Source: AGHT+IE0CbTSC/owIKeKE7JulOw2mtjj/4BbP9ckcbthcEXxBZJP6G5oY2A8418pzaLwuuOvPzWeWERsyEY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:ee12:0:b0:772:6903:ac79 with SMTP id
 41be03b00d2f7-77dbefb08aamr829a12.11.1720467800677; Mon, 08 Jul 2024 12:43:20
 -0700 (PDT)
Date: Mon, 8 Jul 2024 19:43:19 +0000
In-Reply-To: <dc19d74e25b9e7e42c693a13b6f98565fb799734.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com> <20240517173926.965351-12-seanjc@google.com>
 <dc19d74e25b9e7e42c693a13b6f98565fb799734.camel@redhat.com>
Message-ID: <ZoxBV6Ihub8eaVAy@google.com>
Subject: Re: [PATCH v2 11/49] KVM: x86: Disallow KVM_CAP_X86_DISABLE_EXITS
 after vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hou Wenlong <houwenlong.hwl@antgroup.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 04, 2024, Maxim Levitsky wrote:
> On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> > Reject KVM_CAP_X86_DISABLE_EXITS if vCPUs have been created, as disabling
> > PAUSE/MWAIT/HLT exits after vCPUs have been created is broken and useless,
> > e.g. except for PAUSE on SVM, the relevant intercepts aren't updated after
> > vCPU creation.  vCPUs may also end up with an inconsistent configuration
> > if exits are disabled between creation of multiple vCPUs.
> 
> Hi,
> 
> I am not sure that PAUSE intercepts are updated either, I wasn't able to find a code
> that does this.
> 
> I agree with this change, but note that there was some talk on the mailing
> list to allow to selectively disable VM exits (e.g PAUSE, MWAIT, ...) only on
> some vCPUs, based on the claim that some vCPUs might run RT tasks, while some
> might be housekeeping.  I haven't followed those discussions closely.

This change is actually pulled from that series[*].  IIRC, v1 of that series
didn't close the VM-scoped hole, and the overall code was much more complex as
a result.

[*] https://lore.kernel.org/all/20230121020738.2973-2-kechenl@nvidia.com

