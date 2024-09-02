Return-Path: <linux-kernel+bounces-311567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1170968A81
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F36FB219EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F71CB50D;
	Mon,  2 Sep 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV8Vx42t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370D1CB503
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289180; cv=none; b=QGEcOJun+RRrKXk9SbDc1asKFk084C6mY4o0T/SdhV4T+7mV0xYIPFZ6T66VThdVkAeMkK3NY7MKmMnn+2RYFLnq/kPgM+q/qHXxeKmnnOWkgfwKdOSgRoQ0Vclypa5WODIKoTiYbjjgtEJ599MRi3dZLdiJvFy2W0G5X70iVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289180; c=relaxed/simple;
	bh=CgTyxOo8Jl5Q+k9OoEFPn1JOt4mCXe8pIKl51Z9r2Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9Al/Wx0ZXwfaMSWeM8/Xd2Ep2JHwMkfOBUbaqFgKmgpIGAMPzW7gufyZNGh3TKPRTHPxCEgxaqrhoPynUgxqlNpOUr/7QrFsDGQg35JPS//ULFFhfBpIPKB2PDNviZOR6wqXHboPjAnrEvMb07RgBmg4q9lx19LWXBJa147lGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LV8Vx42t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725289177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgTyxOo8Jl5Q+k9OoEFPn1JOt4mCXe8pIKl51Z9r2Zs=;
	b=LV8Vx42tAAZaZ36mdUjQ4MTM8A17brHdDv7mBrK0BiT4l+7BYqaMAUikzNzqGfHOtV/GQA
	GJvpCQGF6/em+V+sbKzhdQBhl6JKryJNFNU9JC9xFH7ESn2jOpMWqAFsBiGF9D2n0Aj80W
	R+5SkPUi8xY5h3cCRummllTiPjilBaY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-OdCTi_dOO0m6ParNzlyPIQ-1; Mon, 02 Sep 2024 10:59:36 -0400
X-MC-Unique: OdCTi_dOO0m6ParNzlyPIQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374b35856aeso2065641f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289175; x=1725893975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgTyxOo8Jl5Q+k9OoEFPn1JOt4mCXe8pIKl51Z9r2Zs=;
        b=FHtaiz8njr0qlaa5l6uQEvLnTR9Qw26cXhf6GLRJWRRH6wkLnpNL5AVQYh5ouBtZoX
         /BmGNX3fsp33YQjO4ZJha42IVRVJRhySGcNbV9XFhdZ5c8a5MFQ3aJ9tQmwcNYc3lRzl
         6PIAoT58FhFx4EmEm9NFGiSqXBJuFeFs+Gwb4EmjLSS70oUZAiqzUWWWqAi21+QUnOYQ
         8mqtu/Do87XVODphkr7Tpds7JETKVc685bc6mTctvsaxHECuSll7XL99J7s8q3mMa7vR
         GejBaIJr+/Tuj48aV6MAUViaCnqIXYqZDcippF15IEvuEiM8kh/afkHCiLk/4JudtvdV
         Z+0w==
X-Forwarded-Encrypted: i=1; AJvYcCWdPxK2c8Cv9Gr1ZWNhy7q1x0oPpvM/NeTKF5jK84GaeYBK/qZA6WRMlV25xPpj/3+V6Mx2UvWaxMYC5Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5IIVN/OxyIs0qHLZfYVMx7sQe14Qix9HHQ0/4NH5ceaDyqALs
	Px6ZVa9abSZzorUR2hHtRgPMCkOkc4wT6btsuY4RmihyzZh6ddeVkCr8lc7LgwGTl7XoswDSsDE
	azy0qkwZAT2dS5ILFdeb/OuGURbl6A2yTKCEWIzB3cinYoXmFLhgT1wDthlT/fpMJ/SoyA3yLWu
	UzpiNAgUvyWvAqhy1w/xlntumMY1o8PTDCaPrD
X-Received: by 2002:a5d:4e01:0:b0:374:bd03:ab7c with SMTP id ffacd0b85a97d-374eccc299bmr199097f8f.33.1725289175431;
        Mon, 02 Sep 2024 07:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgxSO4P7+F3cMCBY369yImj7GvTpdVVLeLtGciNsfYGQwOJyWr8f63VuFOvFicjE9kRzThXGBTwX2LQ8U0ciA=
X-Received: by 2002:a5d:4e01:0:b0:374:bd03:ab7c with SMTP id
 ffacd0b85a97d-374eccc299bmr199075f8f.33.1725289174997; Mon, 02 Sep 2024
 07:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zsb4kbq6FAfgg4WA@linux.dev> <ZshONupF3nIhAlRf@arm.com>
In-Reply-To: <ZshONupF3nIhAlRf@arm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Sep 2024 16:59:23 +0200
Message-ID: <CABgObfZ=P-Qc20SD=duFtDbCefWGO9YoEcA=S0DaTo59x58iYg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/arm64 fixes for 6.11, round #2
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:54=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Hi Oliver,
>
> On Thu, Aug 22, 2024 at 01:36:33AM -0700, Oliver Upton wrote:
> > Paolo is on holiday for a few weeks and has asked that KVM arch maintai=
ners
> > send pulls through the architecture trees in his absence.
> >
> > So lucky you, here's a pile of kvmarm crap from the past week.
> >
> > Details can be found in the tag, but this is a set of small fixes
> > around the shop thanks to syzkaller bringup on KVM/arm64 and a few
> > recently introduced bugs.
>
> Pulled into the arm64 for-next/fixes branch. I'll send a pull request to
> Linus later today.

Looks like this pull request was never sent (the last arm64 fixes PR
is from August 16), so I pulled this now.

Duplicate commits are generally harmless so it shouldn't be an issue
if they end up being sent by Catalin as well.

Thanks,

Paolo

> BTW, I'm also away next week. I'll randomly check emails but if you have
> another pull request, better send it to Will.
>
> Thanks.
>
> --
> Catalin
>


