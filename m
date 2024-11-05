Return-Path: <linux-kernel+bounces-395784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386BF9BC2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC82E28278B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563DB3987D;
	Tue,  5 Nov 2024 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibPVgMBK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD02BD1D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772280; cv=none; b=sooSaGufn+1NtnYGHg6mkCcYwPj4P4+lLOYdCoR20X87tszvpGvBgqTJgRyGxcaSzIz2oqVpbpaaUMUTH7v7qap18vJcCuqok2kPXrP3tQbSESuxDI4DcixRGzAauCwON8y1D8koQ3u8xdO8+KA9UzFBXbZpjVrkSPqdRUZX9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772280; c=relaxed/simple;
	bh=Px2UrD1WtJLQV1y1MdFkWdL7/El5A+OOpqGEl+V2UeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NzxllmU0yvXS+a0FEA/Dto24ntUTH3M869lvhyVilYrz05oHSeYQGGlGU2Set5G/uw7k0Lm+Ahrpx9IDC+XyfpfHJv08lrxI9+StixtK4LI4hj68pyi2SxvJNH7PzBG8Rr9LlosUkJKk90fVoTA9wG8oV2cl7zF+EWHMau5ea4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibPVgMBK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e36cfed818so75811387b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 18:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730772278; x=1731377078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5L5dnfdAE7fJifprAddIOXBk2Ev32fRpfJ2vkUD2T0=;
        b=ibPVgMBKrDO8niUJxnLccMzDCdnQEwzs/vnlsIM2BVRaN5TytE0WlHYi+++PzACKua
         ApHfRQjOL7FdrBCwUeLoNDjZZ1EdIcUcFpMG86s1wdHbHOzSDG19CRhCATR/luQKCOzY
         zHhDBTOiJ76tDmxnsi1lh6lg3c6ohfgx+e2wgMo3TWh49Qv8X8poO7JvuCseNpD4XJaA
         fFXqyREdZiAZEWnK7fG6eO7MaPpwdgq7SuVyv+zw9in7uKbTX4+Ig+NMPQlV0rAXxWvr
         a5VG7IZWvNOBeMk/xzND/lHbH9CWRQdRRZPqWQBvUXtD0fGfpE1qVPilKm2GAXpqTtay
         EtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730772278; x=1731377078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5L5dnfdAE7fJifprAddIOXBk2Ev32fRpfJ2vkUD2T0=;
        b=lAOy213v6zslKpBruOBKcURngxhi6jY1Yf8gLBGmGcvgj0AICEwfuGDOGaYC14VmNI
         FLwQDx0wV0B3kuGuLNGTKD9UXVJZ1Jk2Y9jFMz+ht06VKy6Vcz2Vpi1ezx9i2ANWJIux
         ODv3hG3Co2Y8bXRNoaDY2w8aKBpYtc0ekrjreUkujuqM31c/Ya/OaEe2IOkf5nDnO2Yn
         LzSi3mlwdHVkfY8zXK6XPb5+ZOF0ZYd54XMwkoO7zoLiEcCC2Q3qNBhAabVf4If/1Kti
         uBdviZd1VyUD+8AX8PmpiXzlLvkzmtqVSVoAw56qlBpx5SNkHmZVTEGyEJb7+R55ul07
         XhIw==
X-Forwarded-Encrypted: i=1; AJvYcCVCNFFeHWinc4hxpuvF5rmIp2et8dXZOswU+/4Q6iVJgkRSmF5zsBB2Two4HinKC278JWUmn+3Zan64K9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDNsmkgGrtj1HD8NAKOZG6NhGxBw7zBP2wprXu8nh56kR2Pgqc
	ON396vPEudr2MzjiBM3nRVVXfgrjc1wcxEV43T5Mikjnm8MzDMq7gvjzgSPF8vu58oxZbKKs3zc
	umQ==
X-Google-Smtp-Source: AGHT+IHMK9sBy0o5WCz5f+or3wRkmvFO25qKpPtZy1jdIlY82mUCq5KF2m3Gp5QTi1w79cs4YUwitHY9nRQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:7448:b0:6e3:f12:1ad3 with SMTP id
 00721157ae682-6ea64be01cdmr1460447b3.6.1730772277617; Mon, 04 Nov 2024
 18:04:37 -0800 (PST)
Date: Mon, 4 Nov 2024 18:04:36 -0800
In-Reply-To: <ZyiDJhTkPclSQYIk@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101192114.1810198-1-seanjc@google.com> <20241101192114.1810198-3-seanjc@google.com>
 <ZyiDJhTkPclSQYIk@intel.com>
Message-ID: <Zyl9NABhmVTDvnQT@google.com>
Subject: Re: [PATCH 2/2] KVM: nVMX: Defer SVI update to vmcs01 on EOI when L2
 is active w/o VID
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Markku =?utf-8?Q?Ahvenj=C3=A4rvi?=" <mankku@gmail.com>, Janne Karhunen <janne.karhunen@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 04, 2024, Chao Gao wrote:
> >@@ -6873,6 +6873,23 @@ void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
> > 	u16 status;
> > 	u8 old;
> > 
> >+	/*
> >+	 * If L2 is active, defer the SVI update until vmcs01 is loaded, as SVI
> >+	 * is only relevant for if and only if Virtual Interrupt Delivery is
> >+	 * enabled in vmcs12, and if VID is enabled then L2 EOIs affect L2's
> >+	 * vAPIC, not L1's vAPIC.  KVM must update vmcs01 on the next nested
> >+	 * VM-Exit, otherwise L1 with run with a stale SVI.
> >+	 */
> >+	if (is_guest_mode(vcpu)) {
> >+		/*
> >+		 * KVM is supposed to forward intercepted L2 EOIs to L1 if VID
> >+		 * is enabled in vmcs12; as above, the EOIs affect L2's vAPIC.
> >+		 */
> >+		WARN_ON_ONCE(nested_cpu_has_vid(get_vmcs12(vcpu)));
> 
> This function can be called in other scenarios, e.g., from
> kvm_apic_set_state(). Is it possible for the userspace VMM to set the APIC
> state while L2 is running and VID is enabled for L2? If so, this warning could
> be triggered by the userspace VMM.

Ugh, yeah, that's reachable.  Bummer.  Ooh!  I think we can use the recently
added "wants_to_run" to filter out state stuffing.  I.e. this

		WARN_ON_ONCE(vcpu->wants_to_run &&
			     nested_cpu_has_vid(get_vmcs12(vcpu)));

plus an updated comment.

