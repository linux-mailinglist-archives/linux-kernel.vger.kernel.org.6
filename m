Return-Path: <linux-kernel+bounces-271716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DC94526F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE0282AF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD87144D00;
	Thu,  1 Aug 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVrCivwS"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2BC13D63A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535217; cv=none; b=Q4kM03yAsWxJHoQ4Z8tzKRqJfPTkrALSmuSh0fUoRBaEBwI+JLZjVNKF8nXXwPgmV9mYbM8TxnNONO9wlIJBSHU99PGr36cQQETyEjXSbdo09y1HRJ/CU2kHDX9G/kqHsfas9OGEC6oosRgdnonhOz28vfb+7dWbr+sBkjuOWYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535217; c=relaxed/simple;
	bh=jhGbP7nHvLdw8c3N8ItR7ROW4JPxGIcyfk2Yqpfr4Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdIwoos1WOK28F9gkEMtLoGvE/uMCYVyIpMoakKjszowZdaecokQe2epFLmsZIo0FhuOcJjrQ2ZYx6+9a3I0q3jMH3TyQyC+L9AhEwN42x/2XP94r2kJXkfJjl1goqTJph/n0mckjnrE6/InNUKyr01n/jw6IgVWYgUPWmDrOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rVrCivwS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aac70e30dso36530266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722535214; x=1723140014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhGbP7nHvLdw8c3N8ItR7ROW4JPxGIcyfk2Yqpfr4Sw=;
        b=rVrCivwS3O3AjHMv/89tuTSUEKAwyo0iffsyvAy2tU2t53KjmHheWBK5K+pm75TeOC
         v5fDzpZEkclzFeAQJQRwBhhqFWt12VHfdm2DykqgTmv/zWPBMxBWHAZxHzWNL2C17lsk
         ntNVUdROMXFim1l7+98DNtBBwyihgYr1In9y8BAHD4zmkmN9ebD4sbhMTEjo9vIN4B+4
         mF5mUFGOp2ihp4cfPgETTEvjlc7n26i5/zQSpMEmVs7VMFRe2e24+K+S7VnKleBtOpwm
         QC57HKMdkcHhazA764bJ45dyD067QVM2OPouNGKNzcI2jm/gSnqhORnWl04/x2bEsQg0
         6/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722535214; x=1723140014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhGbP7nHvLdw8c3N8ItR7ROW4JPxGIcyfk2Yqpfr4Sw=;
        b=c73pnuvnzXJIYbwmgJLroKLQBdkL/fnmuyxqOEp41sWOQvFSMxEc+gHdL1r0cl9zyc
         qzWo7f9rNKM5+3G8wN3aVAe6MeKuWPX2dqarDoJq4804wyIq8VXBO5p/fOjcWEvQCq5k
         i8qEn9vXXqMtvC/KSJfO/7FkDWxtpnowA2QnB96aaefbXJcCDDjluphMQ1JrCjKADdx/
         NrfjxTtgMhzj3MQksiqmmbB20d74WFrsnRh8Qv1mfNOQV3hlopJVIFDX2LIy5hHuzHS9
         GBPOb9tD9HwpRpoMTbijIgxdNEhgYUG00Ff5qINX2I3HFc4dykphduJD5vDW4pcSR8uo
         3Ncw==
X-Forwarded-Encrypted: i=1; AJvYcCUoTX8x8FRsyQmFVb8+kYfDJrXGIKWSwgdjvrPGihaeQRnBl6FrS3+5t/zp12oCoABplKgTdDvAsYudxFmEvD6U1uIS0vbOwr9f2UB9
X-Gm-Message-State: AOJu0YxUZ25oH53pF9SRz333G0xqtzrNUT/xHKdSSguscon/+2fq23LH
	/KWS+XZVGhlC48BwADNmKenpOrZBzLhSfDjDC2PxZuKjG5kaMoZw6Z6yQPjp8O9RKlEc2j9b/SC
	fuSHwP4VHazJFE1qAY4hBIMQIuCPWzsNHcPKq
X-Google-Smtp-Source: AGHT+IFE0cLdxL3ym8WvsUt9Le3O2EWwnFz8MqEAbRvWcP10izGVT6YQWPv3mZsvMOJaaXqsRYFpmW2RSv8fqGG8Ilw=
X-Received: by 2002:a17:907:3f0b:b0:a7a:a2b7:93ff with SMTP id
 a640c23a62f3a-a7dc51bd262mr73976866b.57.1722535213273; Thu, 01 Aug 2024
 11:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501085210.2213060-3-michael.roth@amd.com>
 <20240801173955.1975034-1-ackerleytng@google.com> <ZqvMnz8203fJYr5L@google.com>
In-Reply-To: <ZqvMnz8203fJYr5L@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 1 Aug 2024 10:59:35 -0700
Message-ID: <CAJD7tkZM8o=B5mGedFpqNL46RRNdmq8FcTVXzS78BrHjGHBzEA@mail.gmail.com>
Subject: Re: [PATCH] Fixes: f32fb32820b1 ("KVM: x86: Add hook for determining
 max NPT mapping level")
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, michael.roth@amd.com, ak@linux.intel.com, 
	alpergun@google.com, ardb@kernel.org, ashish.kalra@amd.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, dovmurik@linux.ibm.com, hpa@zytor.com, 
	jarkko@kernel.org, jmattson@google.com, vannapurve@google.com, 
	erdemaktas@google.com, jroedel@suse.de, kirill@shutemov.name, 
	kvm@vger.kernel.org, liam.merwick@oracle.com, linux-coco@lists.linux.dev, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com, 
	nikunj.dadhania@amd.com, pankaj.gupta@amd.com, pbonzini@redhat.com, 
	peterz@infradead.org, pgonda@google.com, rientjes@google.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, slp@redhat.com, 
	srinivas.pandruvada@linux.intel.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, tobin@ibm.com, tony.luck@intel.com, vbabka@suse.cz, 
	vkuznets@redhat.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 10:58=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Aug 01, 2024, Ackerley Tng wrote:
> > The `if (req_max_level)` test was meant ignore req_max_level if
> > PG_LEVEL_NONE was returned. Hence, this function should return
> > max_level instead of the ignored req_max_level.
> >
>
> Fixes: ?

I think it's in the subject :)

>
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Change-Id: I403898aacc379ed98ba5caa41c9f1c52f277adc2
>
> Bad gerrit, bad!
>

