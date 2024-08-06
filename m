Return-Path: <linux-kernel+bounces-276575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC7949571
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487051F25B1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65442CCB4;
	Tue,  6 Aug 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiKAs2Gz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E062D613
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961304; cv=none; b=jW4J5nOJHSVg7urhcISYmWm7IndPlcMI8fbiKwCIVgQMMBvtXaMEyfIUAe6f2hoabqhhUz0lyoLviH+F9PaEqjPI1pdJMZLXn3ibz7F4EZ97KXKP1T24EZD45XX8FRVa7b7mlSjx3CIoR7IqYUYcZzdNcPur/ujf7tJ+WlhiG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961304; c=relaxed/simple;
	bh=MiXXafwse1Ho0ogWmbf243gxNuNXsRyUhzg/zHyNTAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVi7G8wVRIPgxLg5pxSuAEouyA/XsykfeOpj9fVOkFsczrvb+WL0DIjhkECTo8kUMSlUPzHRbUaUVhj+tKlgXzF4vxrOmsBz61NFHKAM+LNaC3DL5Gjq/nTSVXbsyjb3g0JC5nq0SwQ++JlzoHFv8RGaFhn2S6wWU0lzA35HZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiKAs2Gz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722961301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2FeBeGVvfW8PBlHksAEroqOcnOyuOxAZ4FSuVaz9/So=;
	b=TiKAs2GzkGsgoj3/B7e1p0B+OlKwDlvM3ysrlG/A7ha88D+yXcBa4DFw/GIZTh3iz3VuwS
	CqSIE2X7wqfK2Psc6NVphDA0qHlbTdkBuYpa5SExmZlSr8NmPyUK1UcUB96Z0BCHj62mTl
	qz8epYDq1QOYKjmO9gWB5gUYTrE6yPI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-UhlRgQ8XOLK2vO0I4gYS7w-1; Tue, 06 Aug 2024 12:21:39 -0400
X-MC-Unique: UhlRgQ8XOLK2vO0I4gYS7w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-428040f49f9so4998165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 09:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961298; x=1723566098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FeBeGVvfW8PBlHksAEroqOcnOyuOxAZ4FSuVaz9/So=;
        b=e7lF+Ya/smgII8P3D2m5NEb9VIq9SsIrJP6r1DjxGl1kKeZcAYZZPJnm2iBd5xzKTC
         YXzoe/dGwnE6F78vMyK6Qn2fRHe7R8QX/FjFxzSwgmgKBFadBV8sgxXq78xPCuCHh3W6
         VOUVf3rm7miXbOC1kGqP+1xNsl5zlJfovX5ReH/zlcor7BTB9N+5B7yo56MtaV7lYvzj
         mdDL7AjYQEOhhmqjkW6Gzedb7djL+sPxZSnwVMcPUaEPGD+AhI7JEmLEfNu4EkhsVo5b
         HibTNqjeW9FQxLPR5QvgF4KRu8olEM8t++UKEvxMLh86NTayspiOyH4c/gUMuA8aa7Zu
         aqtw==
X-Forwarded-Encrypted: i=1; AJvYcCWis9lZVYGlIZ5iNszL24qWbPu+U8CwwVWrs/lHTy4ZP7/J3QSS4Mn4aNS7NB1xrKJIApzVrrIRuVBTtnB/af1pQ9jhpSoMaYr8X4MJ
X-Gm-Message-State: AOJu0YzfsDdL+HAbe+Z/sETiYgga0AFILbQh6MMSJ5kc9ONE4Flf0avR
	byMMiRRJFfx9cqyc9FUeFl+91oprpqtL6lIQG8i3om8O6aCC/Z5dJdLKTaJWqPxvGU5kV+DzIWv
	bPtqdOQHViGjeZ6CAZqmmlg4Fi0tpnHDv79Xg9ReDe/Bef1bJiG7CeObOPQ47nL9rK4U5tLWbxv
	nqTYhPeKDH49N6uTX7d20ikU0GXg1OVP1+17OH
X-Received: by 2002:a05:600c:1546:b0:428:141b:ddfc with SMTP id 5b1f17b1804b1-428e6b9380emr105540625e9.31.1722961298529;
        Tue, 06 Aug 2024 09:21:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU1q3RMsranuxYkdZFpDwHO0qfjlEH0Ad/+UdEwGzzyeZWLt3wvbDG2XrLGZK5hSgx/PGnMZDLcktFLi9HY78=
X-Received: by 2002:a05:600c:1546:b0:428:141b:ddfc with SMTP id
 5b1f17b1804b1-428e6b9380emr105540345e9.31.1722961298087; Tue, 06 Aug 2024
 09:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806053701.138337-1-eiichi.tsukata@nutanix.com> <ZrJJPwX-1YjichNB@google.com>
In-Reply-To: <ZrJJPwX-1YjichNB@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 Aug 2024 18:21:25 +0200
Message-ID: <CABgObfZQsCVYO5v47p=X0CoHQCYnAfgpyYR=3PTwv7BWhdm5vw@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: x86: hyper-v: Inhibit APICv with VP Assist on SPR/EMR
To: Sean Christopherson <seanjc@google.com>
Cc: Eiichi Tsukata <eiichi.tsukata@nutanix.com>, chao.gao@intel.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, vkuznets@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jon@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 6:03=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> > As is noted in [1], this issue is considered to be a microcode issue
> > specific to SPR/EMR.
>
> I don't think we can claim that without a more explicit statement from In=
tel.
> And I would really like Intel to clarify exactly what is going on, so tha=
t (a)
> it can be properly documented and (b) we can implement a precise, targete=
d
> workaround in KVM.

It is not even clear to me why this patch has any effect at all,
because PV EOI and APICv don't work together anyway: PV EOI requires
apic->highest_isr_cache =3D=3D -1 (see apic_sync_pv_eoi_to_guest()) but
the cache is only set without APICv (see apic_set_isr()).  Therefore,
PV EOI should be basically a no-op with APICv in use.

Second, there should be no need to disable APICv: as long as
kvm_lapic_set_pv_eoi() is not called, the VP assist page can be
enabled but PV EOI never triggered.  That should be tested and, if it
doesn't work, that's even more proof that we don't know what's going
on.

Also note that the PV EOI mechanism exists in the same way with KVM
paravirtualization, even without Hyper-V enabled, and should trigger
the same microcode issue.  The only difference is that Windows does
not know about it and, it seems, the issue does not trigger with
Linux.

Paolo


> Chao?
>
> > Disable APICv when guest tries to enable VP Assist page only when it's
> > running on those problematic CPU models.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218267 [1]
> > Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> > ---
>


