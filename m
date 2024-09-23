Return-Path: <linux-kernel+bounces-336678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6C1983F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A09C2828EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D01482F3;
	Tue, 24 Sep 2024 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DewFfEuo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976EE142E78
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163123; cv=none; b=ki97BVJIh4rx7QI2xUPu0E5wdQUYKwBj9g4qlwXyXdp1qgZvGfFsssMRPqP2scIfbT3/HxHnzVKFfCkZSBjO1gTkPBcgeqqDMrQAMQQBFNNbeK6LCKBuCyJK6yJUUQZP409UrqSYB+doefDWWbBZL6P7NvUBErwCyv89YBDBCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163123; c=relaxed/simple;
	bh=7O+CXPnTSksQhlE1WYFBvfR1OCzLYspV9WTzEf8Dj/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qoMR7V7N5EHv6XcdZMUjPnH9zQsXunxc31tS0nMTtFhCShmCCZvKsbU8FeS51kVkjlSDykfhUjSQfN8PLGwZdHtWU1y8cFysico2CCGHH29CP9FrE7j83sym1MhWyyHR3/2yKTxWsn9lTXXRieTju46Fj/Z89i2S96xuZfJFZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DewFfEuo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ddbcc96984so81395447b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727163120; x=1727767920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7O+CXPnTSksQhlE1WYFBvfR1OCzLYspV9WTzEf8Dj/k=;
        b=DewFfEuoC6EeLDf9BKywn1No28EUXDKpulPOBaVAPn/T/OdODyxSRfYi1pKQfF0GuH
         Caw751PImDuzywSkTQs/lf7qmuKqlIiCQEvGi3JwEdRgF6qkNFw//rzE/aapDV5SSZeC
         X/802JkJK8M5jDm2NMDjLBdEcKHvA2r6vYw9rWuX9t1AUVSFzkt9kTTPPJe1Vc9sIOGI
         AnKyr7H3DPvFiXtt7ttLmWg+uW+0Fy+idbqeBnHZlZmQvEGuRGAPXuTGZUtOaUkEf8ct
         693x2NAi+4e9FavpGfhIzfZlL3nHArWSkliUTpce1zsiRAs53EXFwbAmyAJMaJbp+qFc
         N8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163120; x=1727767920;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7O+CXPnTSksQhlE1WYFBvfR1OCzLYspV9WTzEf8Dj/k=;
        b=Ne+u9peH4f8uGq2jVcCQ8KmPQuoVvpcK64B4FjbgBEQWX+HyDMf9/4lycA+NBNS8aR
         9o7ME1GJVc3bJFllE5ayMlYAF39mAUiHR8KEsv/H1BKc5mF7VFZqAeFTfgJQZbq6LmSu
         E5AJK04kc/8dChtoZYPooeu1IGSvHOGiDyXQRbXWjG9KyRvbBNN/gCqbfJbLxHUHrkdY
         2uYRKp/lfHrrHle3kxUepo4ichkKBoGwAiOQ98tol44YR0Z3Mp3TI0nBXM21qOvzlPZt
         zUbSYaZAL8+HbuZ0zg8N3Pxkn+mc5HfTDPfkAm1cl9c0tqEKkCN6MgTT0IxyKmK++zg8
         7Tgw==
X-Forwarded-Encrypted: i=1; AJvYcCXhUtM+gi3p7fBks5MgctBCCPbFmIYuYX/nEQgrz2kEp8NRfVft3jWm1YI1RgvgL82whZo9YPglDOeXpOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tajsOdZX4eAfhU5BdUL83spj5oA3mj9kzPWOP+I3pqYhSVPJ
	6SFCh312Puq4VimHawlnFA7jfp6mPJMhKkrMplgKyjiu18loBFr7H4JV8ggxSzKcAFcYjeKTii1
	8Yw==
X-Google-Smtp-Source: AGHT+IHIvfFWdiWh91SJhJ3q3oJZ+CokUdqnnzQjcHBfAmTjXSleF3H3xG8poCJJ2BpECc61ov955ihOH6Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:fdc7:0:b0:6dd:bc07:2850 with SMTP id
 00721157ae682-6dfef028d1amr243517b3.6.1727163120369; Tue, 24 Sep 2024
 00:32:00 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:46:17 -0700
In-Reply-To: <cb06b33acdad04bef8c9541b4247a36f51cf2d36.camel@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923141810.76331-1-iorlov@amazon.com> <ZvGfnARMqZS0mkg-@google.com>
 <cb06b33acdad04bef8c9541b4247a36f51cf2d36.camel@amazon.co.uk>
Message-ID: <ZvHhqRWW04jmk8TW@google.com>
Subject: Re: [PATCH 0/4] Process some MMIO-related errors without KVM exit
From: Sean Christopherson <seanjc@google.com>
To: Jack Allister <jalliste@amazon.co.uk>
Cc: Ivan Orlov <iorlov@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024, Jack Allister wrote:
> On Mon, 2024-09-23 at 10:04 -0700, Sean Christopherson wrote:
> >=20
> > On Mon, Sep 23, 2024, Ivan Orlov wrote:
> > > Currently, KVM may return a variety of internal errors to VMM when
> > > accessing MMIO, and some of them could be gracefully handled on the
> > > KVM
> > > level instead. Moreover, some of the MMIO-related errors are
> > > handled
> > > differently in VMX in comparison with SVM, which produces certain
> > > inconsistency and should be fixed. This patch series introduces
> > > KVM-level handling for the following situations:
> > >=20
> > > 1) Guest is accessing MMIO during event delivery: triple fault
> > > instead
> > > of internal error on VMX and infinite loop on SVM
> > >=20
> > > 2) Guest fetches an instruction from MMIO: inject #UD and resume
> > > guest
> > > execution without internal error
> >=20
> > No.=C2=A0 This is not architectural behavior.=C2=A0 It's not even remot=
ely
> > close to
> > architectural behavior.=C2=A0 KVM's behavior isn't great, but making up
> > _guest visible_
> > behavior is not going to happen.
>=20
> Is this a no to the whole series or from the cover letter?=C2=A0

The whole series.

> For patch 1 we have observed that if a guest has incorrectly set it's
> IDT base to point inside=C2=A0of an MMIO region it will result in a tripl=
e
> fault (bare metal Cascake Lake Intel).

That happens because the IDT is garbage and/or the CPU is getting master ab=
ort
semantics back, not because anything in the x86 architectures says that acc=
essing
MMIO during exception vectoring goes straight to shutdown.

> Yes a sane operating system is not really going to be doing setting it's =
IDT
> or GDT base to point into an MMIO region, but we've seen occurrences.
> Normally when other external things have gone horribly wrong.
>=20
> Ivan can clarify as to what's been seen on AMD platforms regarding the
> infinite loop for patch one. This was also tested on bare metal
> hardware. Injection of the #UD within patch 2 may be debatable but I
> believe Ivan has some more data from experiments backing this up.

I have no problems improving KVM's handling of scenarios that KVM can't emu=
late,
but there needs to be reasonable justification for taking on complexity, an=
d KVM
must not make up guest visible behavior.

