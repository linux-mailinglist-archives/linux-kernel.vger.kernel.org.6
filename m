Return-Path: <linux-kernel+bounces-311900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC2E968F28
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A871C22384
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82981C62DD;
	Mon,  2 Sep 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkDyK867"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0341A4E9C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725312405; cv=none; b=u/BMYJUyPwI3rX0pxkcuYIavk22HSogFfkksOgZKsyeM183M0IifSZ5S3GS9q0gQjA7sDx94aZBGdUT3dD29gs/kgO6e02nCgZfCiwkqhl4ycG28PMLAGqtvA++lDofZcVozTqUnmXF44CKe+XC34B2QNOxABGbsw7JnfFovVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725312405; c=relaxed/simple;
	bh=7D0+ujGNxr/oMLWxk9V90KOD2exXKgfiR9FgcDqVboU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEXgdKLwbcPHbS84BGvCyal631C9L4sYyMjiKll9YZmGY4Itc0F+6rBnE1upXs4NLK+E+tzxnVMkH7sLF1F9VzsD7PAxI05cT77xyORBuNEamN/zt/HdmOQ0Fv0HxDjN2A/sfCSSYu8Yf36f2qLYQCZawYiQx+/mgpzc+CJmUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkDyK867; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3352C4CEC9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725312404;
	bh=7D0+ujGNxr/oMLWxk9V90KOD2exXKgfiR9FgcDqVboU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BkDyK867kTHgEfXmbrcJCW70zLjfOxxfR3fXEJsHS6kE2lmeBjzH6Pnq5sEHKj6pP
	 iFpjomPYZYrKDtpSbzKTuTBzlET1KnNMqau9DPLd3kuvJP0WMf7ZQog74ORZbDadYl
	 b8F9I1ef86N6Ecp4BstoOnfEEF6lY5qZkKgwbgUEdwbOElqY3b3jV9m/k/vNN4kGYP
	 o8qT+v5B5E7ijESr+c2z6X/GzNBrPhT79eHeoGISd0m84zUmYNJWHedeOpfMPW91zP
	 sxWOBXt3je9esqmVR50KZwJNg7fS3IiRn1l+N3w3HW5pVMQ/nIRuLOr8BBtuv7gsvU
	 2OyGUw7Gsu0eg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53351642021so4949730e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 14:26:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlodA8ni5fetlaeWUDV+AaAl75EFbiVCvDyh2GW0FkS9SAR2o2sQiXJOX6jtFpLK0w7FHXkqAkZv4/5x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMkW/vAh3UUe+4KmcpjGNIsksNgixQbaaVDF4j7nAYyURxhIq7
	tMMh8d1Gc1YHxpiyat6j+b9wsKmVQtc1WUp8VtE3IcixUSqfe+BWbN5rLR2lh7gHS2RsNIueKzS
	Jiioj+K5bf6tIMVclCoaUFS5G7dE=
X-Google-Smtp-Source: AGHT+IGm8eIOeLca63f83AqImC+zVqFGI93UuBfBZ5xueBxTEARESEtsHEq22J09YaHER9vhHPJ4rDa/9u3scuSd9Qc=
X-Received: by 2002:a05:6512:238d:b0:531:4c6d:b8ef with SMTP id
 2adb3069b0e04-53546aef19fmr9277332e87.6.1725312403293; Mon, 02 Sep 2024
 14:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <214e37e9-7aba-1e61-f63f-85cb10c9a878@huawei.com>
 <86zfotuoio.wl-maz@kernel.org> <CAMj1kXGocnZPe4EfzsB6xd2QZacp-a45R5f5f6FDpVtVEXCcGQ@mail.gmail.com>
 <86y14dun1f.wl-maz@kernel.org>
In-Reply-To: <86y14dun1f.wl-maz@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 2 Sep 2024 23:26:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF3JrDs=xvRmvTxS9du1F-gjSVe5qVZrPO5JLT5ho0riA@mail.gmail.com>
Message-ID: <CAMj1kXF3JrDs=xvRmvTxS9du1F-gjSVe5qVZrPO5JLT5ho0riA@mail.gmail.com>
Subject: Re: Question on get random long worse in VM than on host
To: Marc Zyngier <maz@kernel.org>
Cc: Tangnianyao <tangnianyao@huawei.com>, Will Deacon <will@kernel.org>, oliver.upton@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, "guoyang (C)" <guoyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Aug 2024 at 10:14, Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 31 Aug 2024 08:56:23 +0100,
> Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > As for RNDR/RNDRRS vs TRNG: the former is not a raw entropy source, it
> > is a DRBG (or CSPRNG) which provides cryptographically secure random
> > numbers whose security strength is limited by the size of the seed.
> > TRNG does not have this limitation in principle, although non-p KVM
> > happily seeds it from the kernel's entropy pool, which has the same
> > limitation in practice.
>
> Is that something we should address? I assume that this has an impact
> on the quality of the provided random numbers?
>

To be honest, I personally find the distinction rather theoretical - I
think it will be mostly the FIPS fetishists who may object to the
seeding of a DRBG of security strength 'n' from the kernel entropy
pool without proving that the sample has 'n' bits of entropy.

For pKVM, the concern was that the untrusted host could observe and
manipulate the entropy and therefore the protected guest's entropy
source, which is why the hypervisor relays TRNG SMCCC calls directly
to the secure firmware in that case. The quality of the entropy was
never a concern here.

