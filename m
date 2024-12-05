Return-Path: <linux-kernel+bounces-433780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6998C9E5CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F85282136
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D9224AF6;
	Thu,  5 Dec 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XdSRUXZV"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8622259A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419214; cv=none; b=G5nXCHbAkVkSjgM0v2a7n54Q4sO8d+MNSRCNedPSPf3shDS7M1s1cIx+/3pUES+ki05xzqucMGrzCj6Sb/C7ia/ZxR+0mneVz3ao4OiYyNl4KI3NgoeCeoK46ukFjmeJIrMfMYlmrQuQQT9w4ZM7VQGApLnifJNgBktRg3pDUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419214; c=relaxed/simple;
	bh=nRt9BZ3wOGi04HMdMerr9WY8ojlxeowCuGzxx41P1zY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cv96vr2UTxteudDlYI3tFaXSukPiFvoPaIUBaQm21+zc2VIbcxkThFOw7sVkIDHHPxigggePi737wIK4dl/k1vMpPiqxFFvCw6qy5BA2plEsRnoewxfyfiJ+X1rhGqlqqb8wlNQ7ztZchde95ulRgPCzl1Anx+8D3IVm2kqwBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XdSRUXZV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0b85c5574so172570a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733419211; x=1734024011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7yig2Aaj1cF+uoOcuOTHwfQCd/qo7BAxwYpQ38Ftu4=;
        b=XdSRUXZV70nrseHo170qgv7g1FceiGj8DYeBT8JoFCorPcX+jcXEoqVN+nOWhr2JjC
         cPKjXKJ5f4DRmz8fNU8+0dAV9LUmIzHycm5e4h/ZywR2qpimNkTFws/jpPzPJ3+vITqs
         8HgmCVHjAmAbMVMqRbv40xeIgZOKAVMSzCtxvgAgD/LONvxnnZcIkKcU6IwtlDxfKkbS
         7G7Mq4TXb2AVj7rlG+X4gw+UmfXZwISxjTTuPZ4sPlHf0wc0yYmkbt8ukPvNyzJk6vHt
         31pMA09WE3yzcwtzQPnoqwcm2j35hMGTWvfoqT9KYMM17j2J1nMt/b9S0dELY5kqHQ6J
         zbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419211; x=1734024011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7yig2Aaj1cF+uoOcuOTHwfQCd/qo7BAxwYpQ38Ftu4=;
        b=a1kuOJkw4jEY5z5bXtLHCUWxRjk8ZVj0hfYakNtstWxsBkQCB2Po/EVKLXteB+bBdz
         QMHtw7cEquO6Y7FRkZjXDlO9s1XWpEfBpxqm1JseBmitaJMwczEKOuPrB426qLnWr3Nz
         rbRSjMlQRl+Y0KpUBWSpid5mOgktUFfX9V7MR6xBV4/vEiEMcCq+MSM0eR8Giqd40sym
         59bQYzOcC2+3H083O8fQelo+B0dAFTHaV6fwdlS5N3EqEY5eiRDd17ZuKsy6dqRfD9+P
         jtA4x9hEMXWrAZhzVD5SHe0v6ciFtLYgqcmR1wKg1xi3WDkuuAHJcxo3IVRiHOhm82dg
         1+TA==
X-Forwarded-Encrypted: i=1; AJvYcCX5NzYKUSofgYrxkjPxhFRxjNjblkTmXbg8hgE8IZqTsjNyby2BPyhmpiH5dWpxCIjfPO41tjFr4vMwsjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwARpHFpyLRGq59kg8fh9CUqIDJN27hS6D/4tROWX5OeY8lXKNv
	i7Nw0IS/Nyg5dCJHBmngujD9arqibs2+Hn92YAQvj6MD1/o055T2YZ266yZGq0Q=
X-Gm-Gg: ASbGncsVQFnD5q8cA8ZfbiHwn31L44vMgsM0801PPLLKGOH3v2gK9ffKnior1h4iaJ8
	7jTmY81UEbeMakWLcKTlD6q7Dno9VGH9/k8hg9e4YF0wfxCNridnA/QJU+nCPJI/DdL+aCMZLWj
	df/FPLU1FVfjpL1wpy+59Un8fj7hl+YfVHRsL0f74rYxqNVeRppy58DG988KaKZJz3FNf4C08FV
	9CghRs2F7OFGTZCBCZDGkxj8YqDkSFG2M4UQbUrXz20Jy0Hq+3sFAZme2XtsnrxyQmYuuT787cN
	S2HzcezE2GAGJA+3eJr65cRoMvEOs5y9FzyOr7Cq87CpSgIlEFzr4PQ=
X-Google-Smtp-Source: AGHT+IHQT5uO2ud1UQt44xQIYeAthB46apVlg4D3uRW41UHhyYXuzbyoQSLWZQMImKqi2K1w5Bh/HA==
X-Received: by 2002:a17:907:2d09:b0:aa6:2eb3:40ea with SMTP id a640c23a62f3a-aa62eb34bc8mr78820866b.11.1733419211129;
        Thu, 05 Dec 2024 09:20:11 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eedcb9sm118859266b.89.2024.12.05.09.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:20:10 -0800 (PST)
Date: Thu, 5 Dec 2024 18:20:08 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241205182008.2b36476a@mordecai.tesarici.cz>
In-Reply-To: <aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Thu, 17 Oct 2024 13:32:43 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 17/10/2024 13:27, Petr Tesarik wrote:
> > On Mon, 14 Oct 2024 11:55:11 +0100
> > Ryan Roberts <ryan.roberts@arm.com> wrote:
> >  =20
> >> [...]
> >> The series is arranged as follows:
> >>
> >>   - patch 1:	   Add macros required for converting non-arch code to su=
pport
> >>   		   boot-time page size selection
> >>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption f=
rom all
> >>   		   non-arch code =20
> >=20
> > I have just tried to recompile the openSUSE kernel with these patches
> > applied, and I'm running into this:
> >=20
> >   CC      arch/arm64/hyperv/hv_core.o
> > In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
> > ../include/linux/hyperv.h:158:5: error: variably modified =E2=80=98rese=
rved2=E2=80=99 at file scope
> >   u8 reserved2[PAGE_SIZE - 68];
> >      ^~~~~~~~~
> >=20
> > It looks like one more place which needs a patch, right? =20
>=20
> As mentioned in the cover letter, so far I've only converted enough to ge=
t the
> defconfig *image* building (i.e. no modules). If you are compiling a diff=
erent
> config or compiling the modules for defconfig, you will likely run into t=
hese
> types of issues.
>=20
> That said, I do have some patches to fix Hyper-V, which Michael Kelley wa=
s kind
> enough to send me.
>=20
> I understand that Suse might be able to help with wider performance testi=
ng - if
> that's the reason you are trying to compile, you could send me your confi=
g and
> I'll start working on fixing up other drivers?

This project was de-prioritised for some time, but I have just returned
to it, and one of our test systems uses a Mellanox 5 NIC, which did not bui=
ld.

If you still have time to work on your patch series, please, can you
look into enabling MLX5_CORE_EN?

Oh, and have you rebased the series to 6.12 yet?

Petr T

