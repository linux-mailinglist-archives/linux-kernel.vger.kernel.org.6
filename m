Return-Path: <linux-kernel+bounces-172555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC68F8BF381
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284B91C2342C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 00:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34DF633;
	Wed,  8 May 2024 00:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsHSVYnl"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3D364
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127666; cv=none; b=eH00IKmNldjj1DC0ceVm/DfhErLPw++q0ZQwsv72W3I6/1hOdbSed2YKyWafrJJ/rFsMn7x6+CcofgvYt+bsyVZFON9Df+Yv0XqFnfA2LE/snFZ0kBygr1rzJzl5T1qiGxTljSe1yQ8FyqlmTViHxFIy72frPu6HM6cRl9yj5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127666; c=relaxed/simple;
	bh=6QNGrVnw6PUGIQqkgtVttbRiZ7WaoPYzwoKhGNB5rZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BpUCo1aOpPpWH6GJZdM+BoolJLe1dPEeqkAybFQIoBxlGUmYv9tff85IXrB3ALg1r5Y+aEAQcKTWi9SyClu8cya9usSjz5UNh9ZZPmEofyo7/1gjI/5VfHPaBBFeZhxmBXM21TCkLUNpvDRyr7GbTJY/e+ElZL3NuHG18rYIDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsHSVYnl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0c296333so4594237b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715127664; x=1715732464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5zLDljjdB2rK7nQXYwlp9FD4GIUWDXqjmQ12YQdFX8=;
        b=dsHSVYnlzJMoTOZqOSvwLo1PNmikCUCyxVrfBiDXmZ9v5bBEsxsKBmG0L+wsSb/UWs
         XjqMXCPy9zTgGCypQFs0ak4NZzs1j2HxIPnt0AbCT60S/gXnOLtEB/oNey36i2vp9d3+
         1ySYf/+sXBxpido/FtRsrQNaN+g2On4hsCV8Ubt168h0tWGTYqNQs5kek2S+x24wAwks
         AUyDbRLoWpYOXEsRFfKAIT7mSoxSbUR3RYjKRHRLKCtRTNDFjY6ZrPgVUhNi/Z34+Nxc
         UFloXntx0LGc8JfCjexhK3M/7MnGhpwD8eWUlw8ijfCIJEMB2BXIgzu2MqRu/12bIS8/
         VKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127664; x=1715732464;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5zLDljjdB2rK7nQXYwlp9FD4GIUWDXqjmQ12YQdFX8=;
        b=IMCAdYIj8NwgrsY6GzflKVDv3Zah4MDZ/RHGrv3Ke9w5WHp9V9s8zTmC7Yp8K4Il5P
         X3ddlcH7RFqtRs172NGDLhGUty3eC1Fv6EfgdeaAUbwX43Bc6cf0pjr14vl8iHQVxZLK
         oFiWvri7YlmLX0gQ9wyENoqBXpkMPxjjUiUTBVHo8MO4gkP6Rvezqlo9A+nN2soJwsp1
         XT2RrSAAHMi+h3q+tPrPsh+IqJKkIYFxziMYWnbXcmbFtVpqqvRB6JeS/UUYh2W8wlMl
         i7lx6qP34/EPP5ysadRlupSq5Tg9Hu3/gaqV60gdkzFbc81nvwkRIqtFzxMYDaHqZXZh
         QHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1SYwMXvlY43dukOWhj/QC0r8F4/ZD6GvvsOV3vG/Oddx3lbTbHlc5SGMhC/4g6Zbl62QmQpbtfhCvTBI3fStqUQ63QtmTkzFtfbp/
X-Gm-Message-State: AOJu0YyW6LaytAIo1QVCPVSgbTPh7cWE1bL4FHpg9L57R5sgLj1bAAod
	y17gd5xYZvq4oaMrE1+qrS10AOMYMWC2SgZszSNGWyVIkLOuICHDEISQwLTrFlovDLSk0Q5YZE0
	Syw==
X-Google-Smtp-Source: AGHT+IFxJMvsXuvfR7+WfinHqEuybGv+6+GJ2/YrtrunJGOl9Hyc0rlRZrKELtyNNAhrSsSrlLz0CwdSzEc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d80e:0:b0:611:6f24:62b1 with SMTP id
 00721157ae682-62085a32ba6mr3654617b3.1.1715127663759; Tue, 07 May 2024
 17:21:03 -0700 (PDT)
Date: Tue, 7 May 2024 17:21:02 -0700
In-Reply-To: <b4892d4cb7fea466fd82bcaf72ad3b29d28ce778.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404121327.3107131-1-pbonzini@redhat.com> <20240404121327.3107131-8-pbonzini@redhat.com>
 <43d1ade0461868016165e964e2bc97f280aee9d4.camel@intel.com>
 <ZhSYEVCHqSOpVKMh@google.com> <b4892d4cb7fea466fd82bcaf72ad3b29d28ce778.camel@intel.com>
Message-ID: <ZjrFblWaPNwXe0my@google.com>
Subject: Re: [PATCH v5 07/17] KVM: x86: add fields to struct kvm_arch for CoCo features
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"michael.roth@amd.com" <michael.roth@amd.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024, Rick P Edgecombe wrote:
> On Mon, 2024-04-08 at 18:21 -0700, Sean Christopherson wrote:
> > > - Give other name for this check like zap_from_leafs (or better name?=
)
> > > =C2=A0=C2=A0 The implementation is same to kvm_gfn_shared_mask() with=
 comment.
> > > =C2=A0=C2=A0 - Or we can add a boolean variable to struct kvm
> >=20
> > If we _don't_ hardcode the behavior, a per-memslot flag or a per-VM
> > capability (and thus boolean) is likely the way to go.=C2=A0 My off-the=
-cuff
> > vote is probably for a per-memslot flag.
>=20
> Hi Sean,
>=20
> Can you elaborate on the reason for a per-memslot flag? We are discussing=
 this
> design point internally, and also the intersection with the previous atte=
mpts to
> do something similar with a per-vm flag[0].
>=20
> I'm wondering if the intention is to try to make a memslot flag, so it ca=
n be
> expanded for the normal VM usage.

Sure, I'll go with that answer.  Like I said, off-the-cuff.

There's no concrete motiviation, it's more that _if_ we're going to expose =
a knob
to userspace, then I'd prefer to make it as precise as possible to minimize=
 the
changes of KVM ending up back in ABI hell again.

> Because the discussion on the original attempts, it seems safer to keep t=
his
> behavior more limited (TDX only) for now.  And for TDX's usage a struct k=
vm
> bool fits best because all memslots need to be set to zap_leafs_only =3D =
true,
> anyway.

No they don't.  They might be set that way in practice for QEMU, but it's n=
ot
strictly required.  E.g. nothing would prevent a VMM from exposing a shared=
-only
memslot to a guest.  The memslots that burned KVM the first time around wer=
e
related to VFIO devices, and I wouldn't put it past someone to be crazy eno=
ugh
to expose an passhtrough an untrusted device to a TDX guest.

> It's simpler for userspace, and less possible situations to worry about f=
or KVM.
>=20
> [0] https://lore.kernel.org/kvm/20200703025047.13987-1-sean.j.christopher=
son@intel.com/


