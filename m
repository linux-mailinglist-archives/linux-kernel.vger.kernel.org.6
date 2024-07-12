Return-Path: <linux-kernel+bounces-250825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9679692FD47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D461F2407F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106F173346;
	Fri, 12 Jul 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blOvoGIz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFF172BD2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797174; cv=none; b=MSxOzji449DzuSk8rNtF7EZz3nyJXx6abcPeiueDTbHir8hWBgdH/mS2Nn+gsixwqpCQp4b0FrWeY2IqYO51OzGL1qlHLsHsp1mcUxBOnSLCLpfx/iLSYrmnkkCpQDQbpiTy2PVw3+YJwYXQ0FkG9wUfSBvFvXeXPpzy4M9oPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797174; c=relaxed/simple;
	bh=9BeUzXJjHysaSyowS0b6W+lvKasnTxqlLnwfpZRUPQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vd+jPsf7xN4/Tb+CNR12wwsuc4cTLu3UtKViUEZoirundPLNWHvNadc1WTbLuTpQoNXQ5Cafdjmm4zMDHhTQIM//t5rmeOS4hXuwsdPSESalWgVgGAOmb9MUu3wOBakvl0qM4Yid11li3lLKj/XKY1t4uiTvFxZJYYtr6jvoDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blOvoGIz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1faf91cbe19so14153755ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720797172; x=1721401972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUu8mGS1OQxBMeoqKcwdn/WJeVzZBowT4FUswTBpL4Q=;
        b=blOvoGIzxsHDi8Y+0Vgl4RtYLBGA1dDa4UPElgJ6nVS4ncmkyaVTsCu45OuAuk6x+/
         V9x0E7pARXOdGeG/yQvjX08uSWIjb7OKPmH84CabpJi7rD1Cbc7JE//048fnX9D4Fdfx
         n16Ma+ZRJVK4A/VLSNHgvpZ/4lON+jxijAQ+3Uw5Oc692EI2/DT1dokIIv2yMd3FsvDW
         jJsQ4cynRYWtvhu3kxI1Y1iDz3VW15fpzzx0C8jaJk8vpVoJeo6BZJ0mRcOaFdER8hFp
         6PO7nBlKE3WGO+UIAYYdc3oTW1YfZ7DXyFs4qNq/KBR4HZfCTazrbCl+JeLpA5uciKWZ
         3awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720797172; x=1721401972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUu8mGS1OQxBMeoqKcwdn/WJeVzZBowT4FUswTBpL4Q=;
        b=SfXrWLjXlolohNqbctxBN9FFi+6INMIFsCzHT28iWTmfxuJdY2/nrLod7pYve1EAgw
         7clhkw4LBbcVCndNmhB5leqHkbUdeJndH6nI89y0KsZj+HlMmedIpN8Vqnbz5XbFAbza
         tkVDvn4hNBH8+nkaVw1PoULncdzGxN0qbNrIAM9qIQ7cIoT+PdIL7UEv1z4IPMmjxkBg
         Pb1RwSaWYDfBcuveUuTMrcDV2EQLeEWkf1CJaK8nSyL1QNl9D8nK7mnh9eaE66hgDvI7
         Xx9dk4dvkbRqm5N6G34tiBSt8LLnch8GZNsLE48SsjFQ+C4ZtRdVL3ocG+Qzzkqz8Tys
         cjqg==
X-Gm-Message-State: AOJu0Yzz2KRpWn0/5kHflzGBY01hShu0WC7CprunvEbtghqameatWQUM
	4QTqfNFnbPLxBysmiaSZFVsGAsRVP5l6q/c5H6Pd1fH1LFJxOnMCRFsR4U818hgM5IhfXwqwxGf
	18A==
X-Google-Smtp-Source: AGHT+IEUE3RwZfydvmvGzSOcHXyGrTF07p1ZkjrHKehYizMX0HteiU6qGOi9myjkfJZgQKr0WaGhxCPzpHg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2bcb:b0:1f7:1d6a:786c with SMTP id
 d9443c01a7336-1fbb6edea46mr234215ad.11.1720797172460; Fri, 12 Jul 2024
 08:12:52 -0700 (PDT)
Date: Fri, 12 Jul 2024 08:12:51 -0700
In-Reply-To: <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-10-xin3.li@intel.com>
 <ZmoYvcbFBPJ5ARma@google.com> <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <ZpFH86n_YY5ModwK@google.com>
Subject: Re: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and guest
From: Sean Christopherson <seanjc@google.com>
To: Xin3 Li <xin3.li@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	Ravi V Shankar <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 10, 2024, Xin3 Li wrote:
> > On Wed, Feb 07, 2024, Xin Li wrote:
> > > Switch MSR_IA32_FRED_RSP0 between host and guest in
> > > vmx_prepare_switch_to_{host,guest}().
> > >
> > > MSR_IA32_FRED_RSP0 is used during ring 3 event delivery only, thus
> > > KVM, running on ring 0, can run safely with guest FRED RSP0, i.e., no
> > > need to switch between host/guest FRED RSP0 during VM entry and exit.
> > >
> > > KVM should switch to host FRED RSP0 before returning to user level,
> > > and switch to guest FRED RSP0 before entering guest mode.
> > 
> > Heh, if only KVM had a framework that was specifically designed for context
> > switching MSRs on return to userspace.  Translation: please use the
> > user_return_msr() APIs.
> 
> IIUC the user return MSR framework works for MSRs that are per CPU
> constants, but like MSR_KERNEL_GS_BASE, MSR_IA32_FRED_RSP0 is a per
> *task* constant, thus we can't use it.

Ah, in that case, the changelog is very misleading and needs to be fixed.
Alternatively, is the desired RSP0 value tracked anywhere other than the MSR?
E.g. if it's somewhere in task_struct, then kvm_on_user_return() would restore
the current task's desired RSP0.  Even if we don't get fancy, avoiding the RDMSR
to get the current task's value would be nice.

