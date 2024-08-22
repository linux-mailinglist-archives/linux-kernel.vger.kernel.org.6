Return-Path: <linux-kernel+bounces-298068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BB095C184
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 01:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF44F1F236D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC11183CCA;
	Thu, 22 Aug 2024 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vt+sOKh9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6717E006
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369507; cv=none; b=JYEjMiZ5VxG6aJH2nhthWgLHLW0IfIkQbEe8qcLcwdjko7gaA5orMJTInhquZdhjtSDZCXNGhzanypp32gDKzUeIA+qv+MPBfF640Q8c7I3fqJQ0I2MBNjJZT02u+Q3sKivEeHro4/NALmuvxN71zTe30N/5unrJPCykuiDN9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369507; c=relaxed/simple;
	bh=BLP0/E1yn6PT0bUiz7FMfJaAX886FCAKrwY3F7vRFmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TYzH5HUKZTRrnYj271XCN2T/dma9y5G7MTWy4Afnf5Aw8qBi0kio2eWKrRH5upU330XoYAIuwBAE2sPOIWldb1aCbxpAZqONi/6WJqFm4qIMwdWHAi8xpU1efJKUpSvWYwJxsEspYlWp78O8JX5669TZlgGjn5uP/dFODvd3LSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vt+sOKh9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad660add0fso19753467b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724369505; x=1724974305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2VK4gsJnT9GBGpBnsDrs62KK+JLaRL75WIZ8QjWkPI=;
        b=vt+sOKh9rtVgOmu8VwGvYCA+cLlbq2/nqZymvNVHrSynGCzDR+d0/W5OjhPI9NHYXR
         9caZ5vG8PRjwzcsnUdSRclVLQr30+zS0AbmB0G58VhIbcLANLs1bQVEMz1RT6wN5xCz4
         dP5WeEOt4iaAeggOlEjihkYfKv8Noi2cNsSCC0dClfZa6/jFwrPK3EFya+lVRvDde/od
         94RF4kbbozkes6Ly6rs9vSyDxNTglgmlSf26Sazuutw9lIzB4Fc9ML67CvJ9DKX8s/qC
         eqYu10Smso9z3YOwmWsMpqKZgm9ZBWowf4eByQe4Lp0ROPPdLbO7GZ3/0kx7oZ4nsNkx
         IxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724369505; x=1724974305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2VK4gsJnT9GBGpBnsDrs62KK+JLaRL75WIZ8QjWkPI=;
        b=vLlYWd+LdFOgQha6K7ILG8EDpNUg2dtIDEd8ZLV3GGnUBAj9tntYedvWExkuAbdjfB
         0XmS0RZgdnEbGuI+GAG1ZICGEA2Z+RHmgo0+sKm/waD498IMBtkHKBw8DWsfjMzvWbzX
         AwEMSBGC8azeWFGPq5E36IoIod0uQ2J8BOgEkKg0nVjZvVBStsLaxCI1Gj7NwYyK6no1
         pY0g1pMtGQ5cW8LMovPcI/tc+lF68Z7IZ+zbfCaHPIQoqhfnkeSAlBjPD0BfcR0sYQIO
         kAAgq9Y24nHOa9/wIvfF9Ia/S6qlbRWULUhpNgKeuCGk84xOACSRGixO1m8Xa1f25XjE
         8PYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT1mvz9Gajk7/pblr4Tv3+BiM3kX57p1cACvs1uEl9vFmtnRMfM/KVS/w3eLLvYswrc5M1uOkjhF4wVRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiZSRNuqRU9eBbbxNg9cIv1VbOLp6v7RSBJEUSJit9/kY1Aod
	gASUs7Hh933N21LHi1gF4CgheFiWQEF6kKAInearDBHGZjk2/pUCoyHY/XDqmDHTHJnEtTB9uzb
	/Tg==
X-Google-Smtp-Source: AGHT+IH1bSLgCDinu8YCjQb7w11nLcPVDULR3x9aSTV+XkWP7TA453YTQfvUWCeaQvVV9FvJlSUiOiG9JEU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:498c:b0:651:2eea:4dfe with SMTP id
 00721157ae682-6c2fd9f89d1mr2277367b3.0.1724369505385; Thu, 22 Aug 2024
 16:31:45 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:31:44 -0700
In-Reply-To: <20240822221938.2192109-3-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822221938.2192109-1-kim.phillips@amd.com> <20240822221938.2192109-3-kim.phillips@amd.com>
Message-ID: <ZsfKYHFkWA-Rh23C@google.com>
Subject: Re: [PATCH v2 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB Field
From: Sean Christopherson <seanjc@google.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, "Nikunj A . Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 22, 2024, Kim Phillips wrote:
> AMD EPYC 5th generation processors have introduced a feature that allows
> the hypervisor to control the SEV_FEATURES that are set for, or by, a
> guest [1].  ALLOWED_SEV_FEATURES can be used by the hypervisor to enforce
> that SEV-ES and SEV-SNP guests cannot enable features that the
> hypervisor does not want to be enabled.
> 
> When ALLOWED_SEV_FEATURES is enabled, a VMRUN will fail if any
> non-reserved bits are 1 in SEV_FEATURES but are 0 in
> ALLOWED_SEV_FEATURES.

This may need additional uAPI so that userspace can opt-in.  Dunno.  I hope guests
aren't abusing features, but IIUC, flipping this on has the potential to break
existing VMs, correct?

