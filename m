Return-Path: <linux-kernel+bounces-389333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1D9B6B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52A91F22386
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871321314B;
	Wed, 30 Oct 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1mG1TBC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987491EE02F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311028; cv=none; b=P8Ldsirk7llbxkv9FGNX51WwPSaAnEu7fRv/mfobo2/oTapV6nA63+TcBPorF3qPxwVieF3n5KYuOKEgktH8MOuwIdG7c2Gz0Zr8aCY2Mj/QEdwuVfu0UEvt1JcIluC4fM6L+aufLS3Dba2pEyUpmS2SkYGdl8vHiyOs34K4zaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311028; c=relaxed/simple;
	bh=HXbZbbEbISWZDvCQL2LRu8qBoXGWfihRMp1PGTLERlA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CWAnGCsA4TJ3Fcf2QJq4qtvK2yPMdbH4ovnY7hYSZN15t/ZcmmADVAh3JzSnFz65tasOD7JQCrx4EtArx/1lfeiqZChpj3RdU4qfOabynpy2bx9N5T5WUS1kDJEce4HX939KkVzFFV58hBbiEyd+eS432CGncUmxCaCwkAx9t6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1mG1TBC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea33aad097so14076827b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730311025; x=1730915825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Js0851Wg/yN4BQPMb8zIhsnP1AdasvixqJsqtfPfy8=;
        b=S1mG1TBCpJXphib/kmXkuqCxlsxoPJyuMwCFIKRYBgNR1YdIA3G4tS6Y33fKDCQ0eV
         rh7f9CDC4/zRzpwrn82rM8ePXG8SYqFgQSI4+Kd5pmMCHeduhcPg25Cp58KNXYXw7CS8
         MTeiZUZSg66sbFZXVFJgPwelCUvr1091HxQI2rOZgYpzXgGHuZAZuDHDTAalxP9Fx/09
         kyHfyEXwO3KkQu+my9qbPBjN5cKtQGtH0KY18K3f4ge3vOvxEeChdzaBABqhZF/npeUH
         wBFL+TDsFlQVTAftn86CkqlMtu9sAqyHYiebjGFLt66ToqZy4PUelICv+b54fSlz/2r5
         yULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730311025; x=1730915825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Js0851Wg/yN4BQPMb8zIhsnP1AdasvixqJsqtfPfy8=;
        b=peo/2V03tKsSBYgitceZ5rcxn7gDaJMdAKEOQFi3l1djWq7yPTGraXvihUpa6iVN8M
         wOVSvAtk5JlpQSCic7FhW9P+oERnPTlQtRFH4gF1z3EX5in0wXOCqYd0oRNeyaV5ePOj
         bRAET3/onvW0PL2hpxmeEi9B4stpJ/KzOKkIeYgkimMx4XLWrEdOmxTtnRZ4IjvyuTv1
         VOSCGPSG5r0VE8YB8JxE9hyoxLb9nN58+9keZt+WToB8vKsYPs8qSMxDhgE6qysSxjTe
         ewsqOJiAlo2Hui8bjXZBqciJdFKg56jiXwbWkMdinO8e/bItqgyXuo5n1cUC++z2SVQB
         +WMA==
X-Forwarded-Encrypted: i=1; AJvYcCVk0PeG291Rneo/JV6AZ/08GTBmhv5040lFaXClYi2DA9sZHE10RnlLZRFNL18ywzGhzg6Z9xKyPleGK0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUaH5AksmlQjuTmPZ4mcItb2h2ah/zfoyXUHiOsKd+X9UDsdf0
	lCsTcXahRSw3AVPChq/IGrksc9kKwLMg5/4J3qXHksU6cbPEu9ZEdOPwSt/1WHjHJbinAa31zi8
	U8w==
X-Google-Smtp-Source: AGHT+IEYu76tmgovzI1MJ4Q0ogjcSHvzLY7LpCf9XIb8Oyf3mLX6BXz6eqH4rINu/IoBsyC7/Or/ksRFTcQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:ad5b:0:b0:e30:b89f:e3d with SMTP id
 3f1490d57ef6-e30d51da951mr62418276.1.1730311025650; Wed, 30 Oct 2024 10:57:05
 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:57:04 -0700
In-Reply-To: <de2a6758-a906-4dc0-b481-6ce73aba24b9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com> <Zw2fW2AJU-_Yi5U6@google.com>
 <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com> <Zx_QJJ1iAYewvP-k@google.com>
 <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com> <ZyI4cRLsaTQ3FMk7@google.com> <de2a6758-a906-4dc0-b481-6ce73aba24b9@amd.com>
Message-ID: <ZyJzcOCPJstrumbE@google.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 30, 2024, Pratik R. Sampat wrote:
> On 10/30/2024 8:46 AM, Sean Christopherson wrote:
> > +/* Minimum firmware version required for the SEV-SNP support */
> > +#define SNP_FW_REQ_VER_MAJOR   1
> > +#define SNP_FW_REQ_VER_MINOR   51
> > 
> > Side topic, why are these hardcoded?  And where did they come from?  If they're
> > arbitrary KVM selftests values, make that super duper clear.
> 
> Well, it's not entirely arbitrary. This was the version that SNP GA'd
> with first so that kind of became the minimum required version needed.
> 
> I think the only place we've documented this is here -
> https://github.com/AMDESE/AMDSEV/tree/snp-latest?tab=readme-ov-file#upgrade-sev-firmware.
> 
> Maybe, I can modify the comment above to say something like -
> Minimum general availability release firmware required for SEV-SNP support.

Hmm, so if AMD says SNP is only supported for firmware version >= 1.51, why on
earth is that not checked and enforced by the kernel?  Relying on userspace to
not crash the host (or worse) because of unsupported firmware is not a winning
strategy.

