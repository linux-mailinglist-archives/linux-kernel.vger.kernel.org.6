Return-Path: <linux-kernel+bounces-210569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25339045AD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1B71F23EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF115278E;
	Tue, 11 Jun 2024 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ly4W/jjq"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B732D1509A6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137143; cv=none; b=jOSI0BFdyv9WZWGQ+wf5RBnu6+cO3hknqJ++GLIP4+AqRdcvthu3cVoo8ny8dtfM5ApWzPq4m+Ctz6qcD2X2t8vEBVUiwTM/Qr7zX23caQP3yUEo1NARim/PJEPAHY7DfqwJpRGo8srWfMWymsBMz5r7uN10UlVc5aOtdRTkKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137143; c=relaxed/simple;
	bh=bSh2RdEQQ17esIjvPexy9WFujVk8u8sQ6X72qKHNYRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJ5zogGzgBlzCrAecu7LY6+/wa3hUibKBhkFXJxhoM6WC4jA8ap2KLL9gR5PBO7gljVqLanGQoaTH7XW9WgyKwMlVfwgbLvKhnvnR2zKzg9kZAl74u7BZe7B9GhhgujCiovcnQqQmZDL6dJFVYRSp0DTk4VeROOsm8CNZwz+/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ly4W/jjq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c380e03048so1015539a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718137141; x=1718741941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NW8Neou6aEdeLKpchUK2Zyd6+DJnuRJEnXNyRGFWeUI=;
        b=ly4W/jjqyWRkz4DE6PQefDlfO5sERR0ilbdR/42xneGZf8QsaoDAUthRUDDD2mDB0u
         7fGcheMxDZvatcZ+A7I2SktumsUdc9LmSThlpZ9Vki2cQXS9WkxRdBJuF5KOPIF8VVtq
         jltUO3ZgAxZJyc1WMG9CgUK0OuNlqArNp3Uq15B48LfVLqzqon5TZ9bvQKEw1WkdAaxj
         CmJYJ/TM3Uo/gE1io9KzjSDFUJ21a5cm4pL1uu56lj8kNx3EWBegPLl5R0VnFp7TiZ03
         vbkVtA4G6OPsjld6U8eFjGaobEMkDQeN6QFBw6WX5U3/LYt+OQVMJYKUyIaKIwh1OllX
         6iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718137141; x=1718741941;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NW8Neou6aEdeLKpchUK2Zyd6+DJnuRJEnXNyRGFWeUI=;
        b=Ua7XJ3nEVf1nPmJzEpsma4x3/dJH8aeNdjqU267+vQ58YOyxI05qzHdGoSeNJe2O5B
         tRYsWG8YZgUeq6PB3s0ilKWiOzITYeUjaYMyTDFXinrHY8bYH0XetqLkXjpOEl3BQ+op
         oYvgGxBnmWkMKw/KvNUk94XyYYoJzSUzbdJFtS4IkQnLxeXWFO/TALF8tfA6xS3QVtEi
         D6zW2Gpn2mMr+nmFT6HYDgR3RgSkxHiYIb6erhg3WceiTHTj5RHLV4FQr7VngQIRfhZQ
         EqHNO0OcLymC2xxNMws9hZCPWAvzjc8Bj3y46Pljg0uT0Xf5nAcbAnv4QxOUYprQs3W6
         mULg==
X-Forwarded-Encrypted: i=1; AJvYcCVq7mnOl5ps4re7BXP6Au8TpzjADaFP4Jf8ET4UqoG7lWC0oWrUmTRXhoVqWCc/b/HS3GNP2BRF3ERQIBjtcaEC0uBY6WEFkOv0EURu
X-Gm-Message-State: AOJu0YyKKQ6l0NJTBl/IGntefXQiZ6m3l78mY6db+RGlrkWwWzq5JB97
	w5fOzaWaNYbZ/5jb4RbUykrm39T+m5+HxS0MtD735wJt0ebL0xMDQrdValqKda+B8vhzzt4Wtlw
	AsA==
X-Google-Smtp-Source: AGHT+IEKo5FwlrsFhTXQOQIzDFjfbs8T0sGyk7/tC7QUeBJEmFiMlRMwfC/GiukvGJjf5UHGvixnP5MVKyo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:609:b0:6e4:d411:7c64 with SMTP id
 41be03b00d2f7-6e4d4117dd1mr29166a12.3.1718137140901; Tue, 11 Jun 2024
 13:19:00 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:18:59 -0700
In-Reply-To: <f2cd7136-889d-4a3c-b029-07a8c18ef589@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509075423.156858-1-weijiang.yang@intel.com>
 <20240509075423.156858-2-weijiang.yang@intel.com> <ZmelpPm5YfGifhIj@google.com>
 <f2cd7136-889d-4a3c-b029-07a8c18ef589@intel.com>
Message-ID: <ZmixMxni_YOysAuz@google.com>
Subject: Re: [RFC PATCH 2/2] KVM: x86: Enable guest SSP read/write interface
 with new uAPIs
From: Sean Christopherson <seanjc@google.com>
To: Weijiang Yang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, mlevitsk@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024, Weijiang Yang wrote:
> On 6/11/2024 9:17 AM, Sean Christopherson wrote:
> > On Thu, May 09, 2024, Yang Weijiang wrote:
> > Aha!  And then to prepare for a future where we add synthetic registers=
 that
> > aren't routed through the MSR framework (which seems unlikely, but its =
trivially
> > easy to handle, so why not):
> >=20
> > static int kvm_translate_synthetic_reg(struct kvm_x86_reg_id *reg)
> > {
> > 	switch (reg->index) {
> > 	case MSR_KVM_GUEST_SSP:
> > 		reg->type =3D KVM_X86_REG_MSR;
> > 		reg->index =3D MSR_KVM_INTERNAL_GUEST_SSP;
> > 		break;
> > 	default:
> > 		return -EINVAL;
> > 	}
> > 	return 0;
> > }
> >=20
> > and then the caller would have slightly different ordering:
> >=20
> >          if (id->type =3D=3D KVM_X86_REG_SYNTHETIC_MSR) {
> >                  r =3D kvm_translate_synthetic_msr(&id->index);
> >                  if (r)
> >                          break;
> >          }
> >=20
> >          r =3D -EINVAL;
> >          if (id->type !=3D KVM_X86_REG_MSR)
> >                  break;
> I assume reg->type translation for GUEST_SSP is due to the fact it relies=
 on
> CET common checking stuffs underneath for the register, i.e., it goes thr=
ough
> existing MSR framework. But for future other synthetic MSRs, it needs to

Nit, other synthetic *registers*.

> refactor the code here so that it could be routed into new handling.  e.g=
.:
>=20
> if (id->type =3D=3D KVM_X86_REG_MSR)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go through MSR framework;
> else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go through other new handling;
>=20
> But currently the new uAPIs are only for GUEST_SSP, so above suggested
> id->type check works.  Does it make sense?

Yep, we're on the same page.

