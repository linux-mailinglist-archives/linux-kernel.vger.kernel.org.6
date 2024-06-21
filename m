Return-Path: <linux-kernel+bounces-225461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9129130CD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7351C214B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE516F0E1;
	Fri, 21 Jun 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEshpCmv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF716E899
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 23:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719011399; cv=none; b=SXqvFxij93qKvKfjBug2bv7f1il6o/q4Jn5xcSoTKoblwmRzxibM6TfSzrlTMHIbFcep9IGebsYMIugcMwtgzkKfkC1DCmME8TUFeqPmbsPLlBrdDECf3O8PqTJW6IDfkMBBeWbmU5wUyaD2VftMffABSf6ZPsmLZRdAe+AVl/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719011399; c=relaxed/simple;
	bh=J6CtqUdJBpJR6hj8JzbSvf5qexLGlK3syUfxf69EVdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhDO+efmz3KpQ9BofqGex0VJCjEruAoyqVbsM2ruohX55ZyvhBOq9IrGe7SYrDNYVqW8WNtky3Jlp2tYOVivlQOiEocpWXHnjonwB/dGh3KcrGhlKbKc56R1jeVmvB4YztoQZ39H+wrSUa6+xqlw2hmNHWkG9TbYBXAkDw0EMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VEshpCmv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63c08752872so45286837b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719011397; x=1719616197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ+cfUgT+aBmHL3C3Umw6E7c9yi7lplkG1zz9za8pkI=;
        b=VEshpCmv5DqHGb6EKfATG27cyO+3uaghCI41qF1osvq209/TIxJzKJo8d1ayJP8V5u
         Mt4tvHPIt6Ke1XL5/9QhjqqcpeJjAp0RgEYCFJzAzmXmxqEKnbzPPcuGpCeGL6DFPzYD
         yvxFRQA8+i++/TIcakC3fAQo8+Ba50WKp44T6Gq0goaW2CAAfBFiodh9oAuySI1Jez67
         T0qMAfuX2gmJKXAz8bJEweCON+bZkDOkXbZDpHy+J9ktZdkftf/YFdVWQA2oVeYNvkVh
         uaa2YaT1MVNar6IfQ0QkI+6YHm43/Qe4oXkxrTJAr/FPK/0dIrTWCyV8qRKZFtSp4jI+
         DokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719011397; x=1719616197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ+cfUgT+aBmHL3C3Umw6E7c9yi7lplkG1zz9za8pkI=;
        b=UiAD0a7XxUBRhOOFXNSiYjpZN7KtMyjm7Syzb7m56BaISRnCgsfBFhqt5hPbFwDzfD
         DZ6rlhS0a6ntZA0NE92lx2TTa1cWYU3PmH6OV4/S5NJogGOq84IjseJRl2jIdznapflT
         OfowKU0S41GDlOQhicGGnPN0h0vrLeAB+d/ly5Zwyz4OagkcB42HcOTi5KSRq8kIFWDK
         VK+l8scBrnrBk6YLkmOh/o8jwTN0trTrqRmZcugSNee1LYUDtdNn7lgPYkV5OV6f3c8n
         HhLWJBc0gwOM7629Mg9MwFGYGf27qu0wEcs2SYxdJghaVll80wTOG+pSi4ks+n4sF+cf
         DVfg==
X-Gm-Message-State: AOJu0YzUns4oZL6Z2QML6Fj+plEo5TM76pCXZmQ4I13AZOFTMfs5r1Q9
	Jj2vCLj1XC7eHbbbFWHux1RA7/Siny89zoy0VE8lJlDi+gVGFckgBse7au5TSpgDrReRaQWjiIr
	TYg==
X-Google-Smtp-Source: AGHT+IFCunyip/osVKd1aijWizOlNFOoetomMC7RpdXuhtX9ZSat09KiYIr/FEpK+cRnSEvH2xqfvh70e1A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2e89:b0:dfb:fb2:ebe with SMTP id
 3f1490d57ef6-e02be247c59mr869834276.13.1719011397487; Fri, 21 Jun 2024
 16:09:57 -0700 (PDT)
Date: Fri, 21 Jun 2024 16:09:55 -0700
In-Reply-To: <ZnW2kD1V0EoViS7i@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZnW2kD1V0EoViS7i@sirena.org.uk>
Message-ID: <ZnYIQ9swzOjU1DuU@google.com>
Subject: Re: linux-next: manual merge of the kvm-x86 tree with the origin tree
From: Sean Christopherson <seanjc@google.com>
To: Mark Brown <broonie@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Wei Wang <wei.w.wang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 21, 2024, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm-x86 tree got a conflict in:
> 
>   arch/x86/kvm/x86.c
> 
> between commit:
> 
>   f3ced000a2df5 ("KVM: x86: Always sync PIR to IRR prior to scanning I/O APIC routes")
> 
> from the origin tree and commit:
> 
>   aebed32e4985a ("KVM: x86: Introduce kvm_x86_call() to simplify static calls of kvm_x86_ops")
> 
> from the kvm-x86 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for the heads up!  This (and possibily similar conflicts in the future)
is expected.  I'll rebase kvm-x86/static_calls next week to resolve the conflict
in kvm-x86/next.

