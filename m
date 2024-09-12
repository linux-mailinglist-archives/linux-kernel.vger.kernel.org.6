Return-Path: <linux-kernel+bounces-327087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0659770DE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3823B1C2113F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036DB1BFE12;
	Thu, 12 Sep 2024 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrgtlElg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656EC18FDD7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726166493; cv=none; b=rpbWSsGzlqeIB8ZnhqXnGXZBfTjPOogr6FDvFZSroVTXapmjWFqdENItRznt4lIrWD3aBlKRpkkhneFn9uZETJ1zZhOVo31iML8wT8kPxz5D3UQEUFFm021h95nS3xBngr/M4rxoaBjBjliKxp3bJtiXp0sJuBbcOeHWdUTDkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726166493; c=relaxed/simple;
	bh=BFs81fz+/fKkGQ/9h98oeaKtvMGTr0K0X4JKPhX7S/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H2hYqRX++dsCOroRgnsamoZ3gEpElX5WloJi6R+mg8wAP1Zaki66zNOC92StwqqEcQXTdk3eNDCOwIqtuhw4ejTp2RSqM3LfH6ecjV5ONPIEZj3pYgvDwq0ONC7DCtSw/SHKnzj9r6EgIYLK2bzkWKnadUYwQ3m099b3WxkA+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrgtlElg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6cf78470a56so29264077b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726166490; x=1726771290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKXybCzsjXolS9UcuOQMALQBHp9XXAXKDPNYebFpzCA=;
        b=wrgtlElgukdb1l6nMH9R0btagEd+J2MEUAqpEeD9488/+B6v7lTWn/VYJDzCu5MVDc
         yitO8rsGp8hNaSOhW5jqGsIlHFuRNaknIFrif+mcKHoKaTsroDbG3tERufQNsjlQqkow
         2/9n4dwUCz7muITWHor00EXVxsVcI1vwIbrFKR0lM49u6Qw1CGF2gim/HcR3xhRnDmD6
         ZO6kl93K9SHqAYkSDVrajg1gtXaCB3EjJHkuaxPCu3tNbfmcaMneqT5mb23gKay3rNCg
         zqnM1zQJZpwH3O/5mSSMIcXNPRMtYDzzQdDMcFNrUTls6D4q37r+n9BpMdDuFmV6UYP+
         ZjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726166490; x=1726771290;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKXybCzsjXolS9UcuOQMALQBHp9XXAXKDPNYebFpzCA=;
        b=hMR+w5R85voGDjEh00+6+8MtrFXZQ7DkJOWvtyqTuz1LLC2GRfdWds1MKq3WKQfB4Y
         9fhEPqnklRhy6luPCp5gqdgv4dg+L3j46/C//ivYMtC6CPALARbyFLRfDRnM0BRxu+V+
         +3V7Ird0WLG88uxI8xfKDgJPhafETXh/AJlatobMEAKUHCKBMzt/zXwcUShkg6PTyUDA
         pnFangEP2UEj+Lr7LHFW6AhJ02yISaMkytCj5FCjndqvMR3D2i3NCyayCI1BmHY7oppf
         gxa1405QSXL3G3C85Ur3aHI/AQ4Fyojiv1cpdT9+xQcKi49wke+DgJmW7KDUcB0q7LNm
         WERA==
X-Forwarded-Encrypted: i=1; AJvYcCUDH0T1Ex294BSp9BAUKaETMLzw88BPOYbbGxm30dAgPI5J7zxNFoWvi7rxutsZhI9MAr4da1aMyVySK1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxDidCPi45BTNUn2Rp8w802JGHkMYb9nrZjvQSUxTZ22cSKO5
	ZuHCr2pSuPOhdrwflTYCGopPSOfje6D0fVSbvLq79iQMny4L1W455IWEuDnMTlJS0MsmjW4lEYL
	yUg==
X-Google-Smtp-Source: AGHT+IEe7W/SCYY7Jtcilvig7Nir8LqKuHfAsfIwTwdcmtqiZ1O+o5Y9CHfzQtoHDU2kyU1NO7hvKxN3Bn8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:5b88:0:b0:6db:c6d8:678 with SMTP id
 00721157ae682-6dbc6d807f6mr534257b3.0.1726166490365; Thu, 12 Sep 2024
 11:41:30 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:41:28 -0700
In-Reply-To: <CABgObfZV3-xRSALfS6syL3pzdMoep82OjWT4m7=4fLRaiWp=XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-26-rick.p.edgecombe@intel.com> <05cf3e20-6508-48c3-9e4c-9f2a2a719012@redhat.com>
 <cd236026-0bc9-424c-8d49-6bdc9daf5743@intel.com> <CABgObfbyd-a_bD-3fKmF3jVgrTiCDa3SHmrmugRji8BB-vs5GA@mail.gmail.com>
 <df05e4fe-a50b-49a8-9ea0-2077cb061c44@intel.com> <CABgObfZ5ssWK=Beu7t+7RqyZGMiY2zbmAKPy_Sk0URDZ9zbhJA@mail.gmail.com>
 <ZuMZ2u937xQzeA-v@google.com> <CABgObfZV3-xRSALfS6syL3pzdMoep82OjWT4m7=4fLRaiWp=XQ@mail.gmail.com>
Message-ID: <ZuM12EFbOXmpHHVQ@google.com>
Subject: Re: [PATCH 25/25] KVM: x86: Add CPUID bits missing from KVM_GET_SUPPORTED_CPUID
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	kvm@vger.kernel.org, kai.huang@intel.com, isaku.yamahata@gmail.com, 
	tony.lindgren@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024, Paolo Bonzini wrote:
> On Thu, Sep 12, 2024 at 6:42=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Sep 12, 2024, Paolo Bonzini wrote:
> > > On Thu, Sep 12, 2024 at 4:45=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.=
com> wrote:
> > > > > KVM is not going to have any checks, it's only going to pass the
> > > > > CPUID to the TDX module and return an error if the check fails
> > > > > in the TDX module.
> > > >
> > > > If so, new feature can be enabled for TDs out of KVM's control.
> > > >
> > > > Is it acceptable?
> > >
> > > It's the same as for non-TDX VMs, I think it's acceptable.
> >
> > No?  IIUC, it's not the same.
> >
> > E.g. KVM doesn't yet support CET, and while userspace can enumerate CET=
 support
> > to VMs all it wants, guests will never be able to set CR4.CET and thus =
can't
> > actually enable CET.
> >
> > IIUC, the proposal here is to allow userspace to configure the features=
 that are
> > exposed _and enabled_ for a TDX VM without any enforcement from KVM.
>=20
> Yeah, that's correct, on the other hand a lot of features are just
> new instructions and no new registers.  Those pass under the radar
> and in fact you can even use them if the CPUID bit is 0 (of course).
> Others are just data, and again you can pass any crap you'd like.

Right, I don't care about those precisely because there's nothing KVM can o=
r
_needs_ to do for features that don't have interception controls.

> And for SNP we had the case where we are forced to leave features
> enabled if their state is in the VMSA, because we cannot block
> writes to XCR0 and XSS that we'd like to be invalid.

Oh, I'm well aware :-)

> > CET might be a bad example because it looks like it's controlled by TDC=
S.XFAM, but
> > presumably there are other CPUID-based features that would actively ena=
ble some
> > feature for a TDX VM.
>=20
> XFAM is controlled by userspace though, not KVM, so we've got no
> control on that either.

I assume it's plain text though?  I.e. whatever ioctl() sets TDCS.XFAM can =
be
rejected by KVM if it attempts to enable unsupported features?

I don't expect that we'll want KVM to gatekeep many, if any features, but I=
 do
think we should require explicit enabling in KVM whenever possible, even if=
 the
enabling is boring and largely ceremonial.

