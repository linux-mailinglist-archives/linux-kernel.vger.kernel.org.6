Return-Path: <linux-kernel+bounces-285694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDCD95116B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BB11F23E48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7D111717;
	Wed, 14 Aug 2024 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wU47e2IE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E0259C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597842; cv=none; b=XNU8AJcvZ/oFvpAUDd3uDUhlwptJGREh89oeaaILWGY0gY/AXX6dhey50a8wT17Btm0fD9URpgYsd8javz6V9+e6/RTq7CXfSCaDOA2qY6fZlPqFAPXSpRvQMN9jR3mxxSJhSi/tBJsJ+AA8tYmXa5oMloOQGMnVKAtMQAcN240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597842; c=relaxed/simple;
	bh=05ctJLqFzmWTtIoxhUdWL+c73B7LApIAABBMmSXwBlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q1XUkUV7iQJuoXe5TKyVHgzrK2rJAWOQK1W/u5SJALWl1+XO/fZZTKgX+XTPkk/eXXfWNo6T9Cdq3YPEHQx6s+2IA3NdHCIML1XAxSCD3KoN+LgTzezZaSZKVHEst1YsDVSKolcKsj06HierXK6IoGvFUHi8at1WHamn0LsMifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wU47e2IE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-66a8ce9eecfso5932587b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723597839; x=1724202639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hOtc8fNAlhLYuIuFFZ4t4foLKOgj+DhOBObaSJm5DQ=;
        b=wU47e2IEgSs9O7ZpUFJ2UGpUMwwfdEH5zUR1tbIaDnaqAIVuBnyRxP4Csc7U9pPP/S
         H5cs3xcS6HmVnTK+0VQbmARPnUYEsGB0IjpFUG5kgiS5lhzyXlPsfdT+ftylHJ8SRErS
         L/plZFr1/J0GbthbJic1I9+VVakpVmyYVg0jwbOKiv7z4z03a5VF1C7fi2Nq/z/wUSTo
         /9etyJOh40BEoPY1PVcKiVjWZSAxZkdiHlz1LHsmh3fQoz6jVlK4iMWCo9B2pMqrEdFp
         j2jwL5dA5ug8GNTtHkggl8ykcBN5RrRyhsxgj39ocs4ZL/nFeGKACW+27gOrz/Ca5pnb
         i6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723597839; x=1724202639;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9hOtc8fNAlhLYuIuFFZ4t4foLKOgj+DhOBObaSJm5DQ=;
        b=e9tKBToZZQ5pA6+tq0qLImICfWySpzEtrcCEvCWsud13uUrHWw7tTduCB2L6Qtzyna
         M2hp+L0TGI1leo5sdN7kxJSRvimFLh1q3ns4lew1VRzmdAPJ1X9oHf6BB7OA/O3QfcUe
         N0toDy/Km38OQmKs+BTtbm95ri/LWanVtTbB2dzQ4ZdSGe/PPpv51DHIAPC7lFpx509a
         NTlRHdGUJifH2qL1bPUJVXOBsvb6WdSBx576U8NQtdkQZ3NcA2FK+eqhzfJPzjjaJuvr
         dcrpTS0PTSNuTwaA4tRshVoMYwyXTGSOyb02HS/RM4d1zZ53hmg5HkraGcwCzN9aQ3BH
         SRTg==
X-Forwarded-Encrypted: i=1; AJvYcCX5+F9HcZfknWq5KZs6fOh6cI1LH6pVFfoY4gP3VZoxp6nO4myQ95k7uhfJYh81hebJcYh/JHXIQkllQu2jAAEBCGjjAyxxlICUxiGS
X-Gm-Message-State: AOJu0YyvWq42EttjWJO2oB6zh2m+yk7czxmJKn9lRNsZpRvNPvBoqEeQ
	rxIW+20iXq3hq7g06edVMcFMY+y9kOfdCGXg2nUYt4gkcXk78MeKVtdbBwL5Q+50aSs5s+taRKh
	Oyw==
X-Google-Smtp-Source: AGHT+IG/2rDr9URUPDl9FM8oMDrvH3jCXr+cSppLGOe0KQE9X5dKiZqG3sFVtvXlrLbhADZaZ6WgRYBXjd8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d147:0:b0:651:2eea:4dfe with SMTP id
 00721157ae682-6a9df63c480mr655687b3.0.1723597839045; Tue, 13 Aug 2024
 18:10:39 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:10:37 -0700
In-Reply-To: <a24f20625203465b54f20d1fc1456a779eee06a1.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-26-rick.p.edgecombe@intel.com> <ZrtEvEh4UJ6ZbPq5@chao-email>
 <a24f20625203465b54f20d1fc1456a779eee06a1.camel@intel.com>
Message-ID: <ZrwEDTrA2SjWJlen@google.com>
Subject: Re: [PATCH 25/25] KVM: x86: Add CPUID bits missing from KVM_GET_SUPPORTED_CPUID
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024, Rick P Edgecombe wrote:
> On Tue, 2024-08-13 at 19:34 +0800, Chao Gao wrote:
> > Mandating that all fixed-1 bits be supported by KVM would be a burden f=
or both
> > KVM and the TDX module: the TDX module couldn't add any fixed-1 bits un=
til KVM
> > supports them, and=C2=A0
>=20
> > KVM shouldn't drop any feature that was ever a fixed-1 bit
> > in any TDX module.
>=20
> Honest question...can/does this happen for normal VMs? KVM dropping suppo=
rt for
> features?

Almost never.  KVM still supports Intel CPUs without virtual NMI support, w=
hich
IIRC was something like one SKU of Yonah that was 32-bit only.  Keeping bac=
kwards
compability is annoying from time to time, but it's generally not that much=
 of a
maintenance burden.  The only CPUs I really wish had never existed are thos=
e that
have EPT without A/D bits.  Other than that, maintaining support for old CP=
Us
doesn't hinder us too much.

> I think I recall even MPX getting limped along for backward compatibility=
 reasons.

Yep, KVM still supports virtualizing MPX.

