Return-Path: <linux-kernel+bounces-536608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B2BA48215
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C90B17A866
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AD623AE9A;
	Thu, 27 Feb 2025 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35xqrGF4"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20826237717
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667187; cv=none; b=XtmZItmYJnudqav3VLsNQMtTyTgMz2XISTn1y9H+6MBf7OSI06py8lOJyVnB+GEMAVGTm5sPWcg9DUL+6BLTGxMsxOcXNd9V/Nix8+b4X9mL+ASceu1B6vgD8F0t98xbARNcbknPW20efEBSsYQYgbXa3Ib6U8/UdKT4GbOFGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667187; c=relaxed/simple;
	bh=C42kb8jZYl09xjQISSvxQc2ob3/FWGQuxy1rlAyDRgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iHec+10IagdcPG8ua84qvVxXUsWJP3/MGlkqGJ+C/PKujHJdmCmpVRl6lG3e+ELtBmRmJXv17rxCOOQnX+C8Srh5cFWg2Ihg5PF18HtctudFNJtO/ri4XU4ehax5gaRE1U+aFNEWJ05bCtc+hIkW8iWDLrt5SAWo2i2kIsJ+L+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35xqrGF4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8fa38f6eso2266887a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740667185; x=1741271985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxH+On3rOFzz2SdFAE8SEry5Nrx+QsPGCIQtGhiP8po=;
        b=35xqrGF4JmSollVj8v6VmwqKWC2sC13040OWTzu9qYwqilPSaXQskv8CH9KBEps29X
         Mp/SYRuA7KwzesRDzAE8J8WQTU3BzFQMsYYcB7P8mc05fNZ/VN4W0iRBhW7FUuAm8QLi
         QKyPXqEGpZ8PaMWJ9jDraoHndvKrMmsYyIjrNqbaUmI7hLjNrv178C8obyq2P7D25U/3
         /5C9x8BIWWpuDUgV5LzJ/bQ0bV5EafJQ9SMg2ku0hNF6Isdttq2Buc9xL67glaeBtf3Q
         39uR8m59WdglqMr2AIlUPJWk/O/U1DRM0estyqLyuH7LRjARQnoB6Yh1q1XHN1Md27DU
         6Vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667185; x=1741271985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxH+On3rOFzz2SdFAE8SEry5Nrx+QsPGCIQtGhiP8po=;
        b=w6AroUAH6ei6VwPOdSr1YDuf6HgkFbXld2Q8ADqhm29DlQ4Emi/OhO8WiG23Pkcp8y
         5j5/xcsG3Z04NtWgaWd/5R8BKT4x++6mqILu/o98yRJ8Ds3GMhEqK38lCt0kYnZVl9Es
         c4TYqVz9c4DFaOv5wivHFl7Fclav1Zxun+6Cr+TZyLnzrxiu46kuDGlPibisZ687ElA7
         mhXtJqRdYYD/uE/nmGs7417M1pC/pGTG1Zr6v3WbaIgiaJ+reJrLWhKZb+Apa4S1xXQ+
         fwBGgghZz8fNd0G+aLAqbFPB4cZDFuuhyiVyATNn8xdz96ZMt3fVrTHDKbdWp7Myeqs2
         Ukuw==
X-Gm-Message-State: AOJu0YzO1YCCCY0+k0J1uR4G0w4X40H4a5TY/3tqf0UTwewMWTyZPUq7
	YpPIy8Yzwc+JYg3xLyoRYnM1vZIEDW7OjlmzaFpllYMV/sZsS1RpUbgH8/L+/pXQ1YbUqLe/ti+
	83g==
X-Google-Smtp-Source: AGHT+IFJ3wN5DANqSer5hQVwE1SxZTBD0Lvfi1B1zqpxom5zbstWSZgZeTQEsaQZtulu7UPNR3qjkDRor8w=
X-Received: from pjbsh16.prod.google.com ([2002:a17:90b:5250:b0:2fb:fa62:d40])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5407:b0:2ee:c91a:ad05
 with SMTP id 98e67ed59e1d1-2fe68ac9087mr16599772a91.3.1740667185442; Thu, 27
 Feb 2025 06:39:45 -0800 (PST)
Date: Thu, 27 Feb 2025 06:39:44 -0800
In-Reply-To: <f114eb3a8a21e1cd1a120db32258340504464458.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218202618.567363-1-sieberf@amazon.com> <Z755r4S_7BLbHlWa@google.com>
 <e8cd99b4c4f93a581203449db9caee29b9751373.camel@amazon.com>
 <Z7-A76KjcYB8HAP8@google.com> <f114eb3a8a21e1cd1a120db32258340504464458.camel@amazon.com>
Message-ID: <Z8B5MMCzBGwkTT0X@google.com>
Subject: Re: [RFC PATCH 0/3] kvm,sched: Add gtime halted
From: Sean Christopherson <seanjc@google.com>
To: Fernand Sieber <sieberf@amazon.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Fernand Sieber wrote:
> On Wed, 2025-02-26 at 13:00 -0800, Sean Christopherson wrote:
> > On Wed, Feb 26, 2025, Fernand Sieber wrote:
> > > On Tue, 2025-02-25 at 18:17 -0800, Sean Christopherson wrote:
> > > > And if you're running vCPUs on tickless CPUs, and you're doing
> > > > HLT/MWAIT passthrough, *and* you want to schedule other tasks on those
> > > > CPUs, then IMO you're abusing all of those things and it's not KVM's
> > > > problem to solve, especially now that sched_ext is a thing.
> > > 
> > > We are running vCPUs with ticks, the rest of your observations are
> > > correct.
> > 
> > If there's a host tick, why do you need KVM's help to make scheduling
> > decisions?  It sounds like what you want is a scheduler that is primarily
> > driven by MPERF (and APERF?), and sched_tick() => arch_scale_freq_tick()
> > already knows about MPERF.
> 
> Having the measure around VM enter/exit makes it easy to attribute the
> unhalted cycles to a specific task (vCPU), which solves both our use
> cases of VM metrics and scheduling. That said we may be able to avoid
> it and achieve the same results.
> 
> i.e
> * the VM metrics use case can be solved by using /proc/cpuinfo from
> userspace.
> * for the scheduling use case, the tick based sampling of MPERF means
> we could potentially introduce a correcting factor on PELT accounting
> of pinned vCPU tasks based on its value (similar to what I do in the
> last patch of the series).
> 
> The combination of these would remove the requirement of adding any
> logic around VM entrer/exit to support our use cases.
> 
> I'm happy to prototype that if we think it's going in the right
> direction?

That's mostly a question for the scheduler folks.  That said, from a KVM perspective,
sampling MPERF around entry/exit for scheduling purposes is a non-starter.

