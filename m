Return-Path: <linux-kernel+bounces-250852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE692FD9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502DF1C20CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9D173355;
	Fri, 12 Jul 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9IgT1Cx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA106BE65
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798294; cv=none; b=YI6FrWRRwqSj9XLyTqBW5mRkW7E+woH93pa2bwunLrOU2EJ9SNtSm/tIglp99EVTLYmAhvafR0mIBobd4/uzVqrrNLji4X5+lRLNJwyTKJhn3mdvG3HvvOAjVd/ZO9LmYVHEC8RXkMRAH8pVWxclmd3trVueqNCrhuSmrUsJeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798294; c=relaxed/simple;
	bh=yuUkgSUd6vmj6tHpzYFlSGQESGT/hX3N3hMolRd/53s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWFn/zvjQ9ACV9TmTzIE4hsaMHr8zHUNcgZ0zzg1BwCbPvG/UjzGZ+ukd3g0f9Q5HIgvn1ZTpu4WF+b/MT/v7nbU4xvHDzBMYQix7nxNht/Wgw46mRDi1Ays3nX/1g7A8N3si44Ly+y8TMV7W07y64zCb/+45zIOwqgWa7wi7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9IgT1Cx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720798291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pYjkzLgzHvy7cWc4vPkKfOHo7WvPjxKqpxHFA0Pgts=;
	b=T9IgT1CxOHdDT5rcAtJn6HFxX0KytrpnUMO+N+bdXtjHJifW9eJhQEtoGEaM+ZR5ZSIuXw
	eRkXXNvC8QI4vPdzKwuUcu+3eodlM276ZQoRIAPvW6QHDj2OBEqhK49nMnARejXPcgRVYi
	OFKwwIOmJ6VrDou6SVavceG2t8I//rw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-TiPba2mkMWukFnmbuDV-0g-1; Fri, 12 Jul 2024 11:31:28 -0400
X-MC-Unique: TiPba2mkMWukFnmbuDV-0g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42490ae735dso19863675e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720798286; x=1721403086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pYjkzLgzHvy7cWc4vPkKfOHo7WvPjxKqpxHFA0Pgts=;
        b=vqiKb2EmZQLAiG8RvTSG8H67/RubKTEssfxNrl0tEiQEjXWMRTSNq0QfNgpBX4r76n
         cPVJwhG7X2NbIjFe8UclZ8AvFkX/snrz+UG5zEeeEs0SZP3rNDYx2Ic+Q53B+H/HJAie
         vzdrKykmjcJRFGfXrxp0AvHNZEjsIEr7LivapFApwpDr+Y9K42MGz6GOl2XRDkgmD4mt
         0Tpr7kUCgICQvQZ12D2/HSbqrPbUlE7Tjx79NJuJraR2tv+3LnUhMJoNyUE/6EdZwcyF
         NlyFeLkglpoMRzReuhjaOHnAyCfYlf9usP/aW/oLkI3Ffti4Fl7ZL7Qob2vEI82sTPKg
         51YA==
X-Forwarded-Encrypted: i=1; AJvYcCX5YnFHWUL34TNl67+s1BFfDWvjnDjoOTOj9qDdl70lpK91mHpsqFAF2GjleXW8YbDSCSEA9NyhoTJxaLQ152c9tyL2kwojNEggnriY
X-Gm-Message-State: AOJu0Yx15IpdinVkzXDt7vh704HgvNuoo5pQ3eFmWHV2+eTnhBGY3Fnx
	6W4sbcm1Z1YqUk6scXt9/4+yAAPMylMDx0c0WOrAPoLAejvhB3l1WwGC12KvT2SgNbfSzg/WAWl
	DcirvVvGRFOj3CotwsBM3lqvOPkxpUwLNQwD10rfGLXwgDqYigrBrDKaBrGLGBqCIcd1av2Dm3I
	2luBbEUZ+IVu11A2XBmvZLv9qNlajfzrfeTHhXkOvVIqHF
X-Received: by 2002:a05:600c:47c7:b0:426:6ed5:fcb with SMTP id 5b1f17b1804b1-426706c62c0mr103472105e9.4.1720798286750;
        Fri, 12 Jul 2024 08:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpwU6rx2/rdjP1qBUZaPIgntGNbKwFTW7FjwPn5/uO82kUiFkIG1Brg/z5ZHfnsc9cT0EpUfc5/AnoXthMn3k=
X-Received: by 2002:a05:600c:47c7:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-426706c62c0mr103471885e9.4.1720798286392; Fri, 12 Jul 2024
 08:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710104923.2569660-1-chenhuacai@loongson.cn>
In-Reply-To: <20240710104923.2569660-1-chenhuacai@loongson.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jul 2024 17:31:15 +0200
Message-ID: <CABgObfZd1ugY4cFygnvFtiO9p3iE1GA3Wn7Avdkajz_9iXVNTQ@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch KVM changes for v6.11
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:58=E2=80=AFPM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> The following changes since commit 256abd8e550ce977b728be79a74e1729438b49=
48:
>
>   Linux 6.10-rc7 (2024-07-07 14:23:46 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git tags/loongarch-kvm-6.11
>
> for you to fetch changes up to 492ac37fa38faf520b5beae44c930063265ee183:
>
>   perf kvm: Add kvm-stat for loongarch64 (2024-07-10 16:50:27 +0800)
>
> ----------------------------------------------------------------
> LoongArch KVM changes for v6.11
>
> 1. Add ParaVirt steal time support.
> 2. Add some VM migration enhancement.
> 3. Add perf kvm-stat support for loongarch.
>
> ----------------------------------------------------------------

Pulled, thanks.

Paolo


