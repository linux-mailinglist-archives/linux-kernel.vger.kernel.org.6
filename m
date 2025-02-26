Return-Path: <linux-kernel+bounces-532791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BFA4523A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F413170C66
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DA194A6C;
	Wed, 26 Feb 2025 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MO3PZ/Xw"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D844D192B63
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740533758; cv=none; b=DZ7zFXN1692n/pbBJYWQ5tYAGwmt5qeGQGewodDr+oUcnDrAhy2fmnuN2NiaArIeEJn40ggNN+NgPmJgwhPikUR57Y7a07NrpHFCec6gEbuRJQugNjmVYxe7atuyPG8gdM+EZ8BaXPnAM3Ao/FcGSzd1kDaJZoSoeUKGVoqArIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740533758; c=relaxed/simple;
	bh=+a/8Rnwq3M59jG/h6pOx1MvWKehiDVKh9LFb8+XkUcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=koHfhijWJvSpcgc6zjobVA/6y+NjH0Mk6MUzyg0alwFZlzhlWfFKZQ3azoqnvJEKoozWxdxUcQjk6tFCP3J+RZQUbQPK9lbiqZZFdcA50F4muGaGMSzbc1b3U/YKMYUW8Q8/3JpqFJxYjygoRZ48bD81dVVsNOIerotfjR5G64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MO3PZ/Xw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fbff6426f5so12960450a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740533756; x=1741138556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bwkMEQZZWa7h4K0NWv+dMOi3x/q9ujiLZV0nsTlZNA=;
        b=MO3PZ/XwrqsIIu9qVwWotKKccrRiKZEd5f0ARTK59RvwHH0Xi91qDaaWnjf2u6RamC
         FEszGhUW+lDA5cXSiQuV5HajExtkVaqJPFu9LJ4X4DaLaODuND7nhe15k7IRtSW29/v/
         ZORgLclzrambUeOokxZ3GA2m1Y3GG4lqNm6uGrzJH0qWyH184cpyLbHOP2wNzwBRBOmZ
         Hmdc6ktNq2wvy3StqfWZz3fhLIWBYRNezDat6s/H9WzrQwiLP1SAetBaYKNEP+1MjGVB
         MrrhiHrQkETs7W4EX8dG0eMnx9mxTXLpimPRmqroJx3e4vvWc2mQ+VLthP/jlhFCgwbv
         3JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740533756; x=1741138556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4bwkMEQZZWa7h4K0NWv+dMOi3x/q9ujiLZV0nsTlZNA=;
        b=F9F1xF57SIjgvQEMzjz2bG74/AzfHPSHfLUa1Na38n6FTMlZKDfUAuG7OxrTVUuI7k
         0A+53fJmRWP4arLyi2m3xzrklLUC0TY3mxY1fspHwkEZWxGIvpfuSOYTCcyl4Rri3Gu2
         IGRcz309wULEfjoc1MIx3imzEn7WC1V/mH5/OETutyU+cdqsfy2+YIoFk85mw9scjtdK
         6+p2OV/hGVLC3K0I+vwruLDg+/1v8bhmetJs1/6POGHoicqc1hn+wp5iE+/jw+MtgIGO
         jeNTK6wg2HOtz/Fmfk+BhKQvGB8Ptj00OpzOGXzk/BRQUj/o6cc5tcvddurlzR2FSB8V
         uvrQ==
X-Gm-Message-State: AOJu0YykyEN7V3ISDmc2n4IX9OSBfwYipMKSsk5HVwHbxxjueuGRJ9OI
	OIktFUj4jpMnr5V9euE8mlsY64uTtsA8jKPGXd42K8M9tx24OgUPDi4IOzZlrgVNRmdLT9hprm5
	3ag==
X-Google-Smtp-Source: AGHT+IETvbRVrxXRHnpW+9mE2FrumQ0EMxOPE73/r92E+MK8Sttdkq2JT/HBaFrwixzCkTPTbJac7xQUoeM=
X-Received: from pjboh3.prod.google.com ([2002:a17:90b:3a43:b0:2fc:af0c:4be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2d0:b0:2ea:37b4:5373
 with SMTP id 98e67ed59e1d1-2fe68ada2a5mr8962899a91.10.1740533755483; Tue, 25
 Feb 2025 17:35:55 -0800 (PST)
Date: Tue, 25 Feb 2025 17:35:54 -0800
In-Reply-To: <20250123002422.1632517-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122013438.731416-1-kevinloughlin@google.com> <20250123002422.1632517-1-kevinloughlin@google.com>
Message-ID: <Z75v-hT5SxKlqdwt@google.com>
Subject: Re: [PATCH v5 0/2] KVM: SEV: Prefer WBNOINVD over WBINVD for cache
 maintenance efficiency
From: Sean Christopherson <seanjc@google.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	pbonzini@redhat.com, kirill.shutemov@linux.intel.com, kai.huang@intel.com, 
	ubizjak@gmail.com, jgross@suse.com, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, pgonda@google.com, sidtelang@google.com, 
	mizhang@google.com, rientjes@google.com, manalinandan@google.com, 
	szy0127@sjtu.edu.cn
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 23, 2025, Kevin Loughlin wrote:
> v5:
> - explicitly encode wbnoinvd as 0xf3 0x0f 0x09 for binutils backwards compatibility

Please, please, please do not send new series with In-Reply-To.  Trying to sort
through the different versions in my workflow was painful.  From
Documentation/process/maintainer-kvm-x86.rst:

Links
~~~~~
Do not explicitly reference bug reports, prior versions of a patch/series, etc.
via ``In-Reply-To:`` headers.  Using ``In-Reply-To:`` becomes an unholy mess
for large series and/or when the version count gets high, and ``In-Reply-To:``
is useless for anyone that doesn't have the original message, e.g. if someone
wasn't Cc'd on the bug report or if the list of recipients changes between
versions.

To link to a bug report, previous version, or anything of interest, use lore
links.  For referencing previous version(s), generally speaking do not include
a Link: in the changelog as there is no need to record the history in git, i.e.
put the link in the cover letter or in the section git ignores.  Do provide a
formal Link: for bug reports and/or discussions that led to the patch.  The
context of why a change was made is highly valuable for future readers.

