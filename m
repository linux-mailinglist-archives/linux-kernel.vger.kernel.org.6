Return-Path: <linux-kernel+bounces-182667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB248C8E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA9AB21B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B71411FF;
	Fri, 17 May 2024 22:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cs65yOiU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F492208F
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715983520; cv=none; b=rmeVVIqdjGv2GbSUJGF6ENHJ3PBn8iiSon1axC3z58Db5vFY6fQicFNjKqFtlUaKEbZ/D0E5x/yGJEaPWxJoO/jQPZMXfgQISq/1GB4OfFwN3OIcRyMD9gBWPOzCK6AlgFtNaDV0uxL6kdLBc/O2dNhsiZpMc9LY99dPtXg8hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715983520; c=relaxed/simple;
	bh=AHx8CIhs2HHm+fB0sCzYsJzW+7XsKO52cFDTr2C0qY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmrMsiMs6EOOG6Smk2T3N8roZoRtnAtSvIrkwX8vhzkuRIaWsyfbJ/mn1cPAlerNSwkB9HUtzHl58FWhcWCIrqg8adNWQZzzv5VE1obbLJ96fPcl3aiBK2rF86jSRDJmyKVqGvDzZ18V4Jp1s/n8P4QqosTD/yyEd8LaaKinBR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cs65yOiU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715983518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zt2YQ8as06qnba86WmttjcIU7BwJ2cSLKT1s3ZSljEo=;
	b=Cs65yOiUvFNlreTHDFQS9TOKfsYJsf7xBE8mH86xFPPfui6KT63kZg/FTLCvMsyG6HbUzb
	ldcY5SBMYKdMKKXRpVDW2gGgeivxmAMiFZDyUk7YYPsZ/Ml0UeKpVDTx9rxhB1rxssZwat
	QLdBDp+GE5y3A8zL9vJja/H87tKVRzs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-zJaLiAmLOa2sZ-YsAklFAQ-1; Fri, 17 May 2024 18:05:16 -0400
X-MC-Unique: zJaLiAmLOa2sZ-YsAklFAQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34e0d47c9b7so4499646f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715983515; x=1716588315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zt2YQ8as06qnba86WmttjcIU7BwJ2cSLKT1s3ZSljEo=;
        b=wY6OFGqOgtnX7ikVyzk7lPOCqxlCvLbU4bYfQ3uq9V38own38H4b1UrtW+TWQyCyY5
         2QhHGdkqbBvA2wa7ipQMUJcieUARr2T86V3qVM8LVJ3pd7Cz3TVh3zoHuLE9bDA5hV8c
         LrTyZ2gAvEAh1Cnd9jMuWm9OXysbtbOigo+CrNiJ6dMZmsNEz9ZQyDpEzrVJTQMr2cFa
         yYylkG3E29Mw42lRxOWZOYrgX8OvCVP18t8GzA99o16DW4skaalMXK/CXk2BCOfy1KMT
         yuf3MUpPyrmG1c9Meq/MY69Ho+FgcSzGpDJWlz2dnmORkTGRbrUORxf1HFhzNM/EFsCC
         pkbQ==
X-Gm-Message-State: AOJu0YyvO7L+LemNDkndrhy05OPw6rRtdFpJzlcSzYmibXwETIMN9Gy7
	uVU2Sb50gC74PjPaQ+fDIoXX4Terb4uPJ8EiLeghP9lhxDUEzaj3yoHzyHoyDiKsdphkgKO4Ouy
	egCRfZS1au3HleKjSEyeUt64eLBHgcwR/X9ax/a5qo5mWJF/krHucLhEHRVvm3q8WpMDegdZzjI
	mdkfVHZdoD2xiwuIhnA6YC6ru9De2GHIcoPArq
X-Received: by 2002:adf:cb14:0:b0:34c:f87b:f9fb with SMTP id ffacd0b85a97d-354b8e677aamr269061f8f.25.1715983515289;
        Fri, 17 May 2024 15:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCykS6wvyjHIXN8dpfn4UDJzkZBOEpL4smez8eBByWg6Ebpx8Upm7/QjviJimReTQbmgO7ksC6tbxtT31lW1g=
X-Received: by 2002:adf:cb14:0:b0:34c:f87b:f9fb with SMTP id
 ffacd0b85a97d-354b8e677aamr269052f8f.25.1715983514904; Fri, 17 May 2024
 15:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507154459.3950778-1-pbonzini@redhat.com> <20240507154459.3950778-8-pbonzini@redhat.com>
 <ZkVHh49Hn8gB3_9o@google.com> <7c0bbec7-fa5c-4f55-9c08-ca0e94e68f7c@redhat.com>
 <ZkeH8agqiHzay5r9@google.com> <2450ce49-2230-45a2-bc0d-b21071f2cce6@redhat.com>
 <ZkefU_PhjvnaEE7Q@google.com>
In-Reply-To: <ZkefU_PhjvnaEE7Q@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 18 May 2024 00:05:01 +0200
Message-ID: <CABgObfYwxN7yoRUDfYVPb57=p90nUqfW9+y_=Ndeg4oXKaZNQg@mail.gmail.com>
Subject: Re: [PATCH 7/7] KVM: VMX: Introduce test mode related to EPT
 violation VE
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 8:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> > Ok, so it does look like a CPU issue.  Even with the fixes you identifi=
ed, I
> > don't see any other solution than adding scary text in Kconfig, default=
ing
> > it to "n", and adding an also-very-scary pr_err_once("...") the first t=
ime
> > VMPTRLD is executed with CONFIG_KVM_INTEL_PROVE_VE.
>
> I don't think we need to make it super scary, at least not yet.  KVM just=
 needs
> to not kill the VM, which thanks to the BUSY flag is trivial: just resume=
 the guest.
> Then the failure is "just" a WARN, which won't be anywhere near as proble=
matic for
> KVM developers.
>
> If we don't have a resolution by rc6 or so, then maybe consider doing som=
ething
> more drastic?
>
> I agree that it should be off by default though.  And the help text shoul=
d be
> more clear that this intended only for developers and testing environment=
s.
>
> I have a handful of patches, including one to not kill the VM.  I'll try =
to post
> them later today, mostly just need to write changelogs.
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 75082c4a9ac4..5c22186671e9 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -98,15 +98,15 @@ config KVM_INTEL
>
>  config KVM_INTEL_PROVE_VE
>          bool "Check that guests do not receive #VE exceptions"
> -        default KVM_PROVE_MMU || DEBUG_KERNEL
> -        depends on KVM_INTEL
> +        depends on KVM_INTEL && KVM_PROVE_MMU
>          help

"depends on KVM_PROVE_MMU" is wrong, I think.  I'd like to keep it
enabled without slowing down too much the VMs, for example.

On the other hand "default DEBUG_KERNEL" is definitely too heavy
with these CPU issues.

Paolo


