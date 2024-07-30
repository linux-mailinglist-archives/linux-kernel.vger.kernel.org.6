Return-Path: <linux-kernel+bounces-268269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2A942281
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2207828595B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AB418E024;
	Tue, 30 Jul 2024 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdFDRwtU"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134041AA3EE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376848; cv=none; b=JuDuSSqCgd0oO1T2DUCOEiU4kt9yNOvloXiOMNyVS7zwIH74WEVeR3cVTHFtQfeszF1Nev2vlrhJolIHG9Vu5f8SzOvNxVDwqemDPXxavW2iXGnumvgMhL842d1y/F9XCYor+5I4wM5x7ksUOq+rmPEBfQoXdNgP22IwX96u0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376848; c=relaxed/simple;
	bh=x2SmapH/wHIMam6YSDSdYmxNd2TYCeoGfZw98Y7pFB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goepQVgY5q2AlORn/R/bIKlJ/H934DGE7iWfcg6Vpi2UdjgP+Or5+vGcwb6zAywnR5oxD8osTFXjZOfAc0IibXb6jFO7XOzmY0+lGW+VRp0KIc0fKFQdJ7c1BAdfSi4skZlonNGXL7mDFAV4udR+y4hCPbTDPBTep4FiCqdndSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdFDRwtU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so4926a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722376844; x=1722981644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0zp/PZK1hqhhla6gYIN9ymMRT/WA95vOpDBdsQdGHc=;
        b=WdFDRwtUkkhm/rVIVML/nE8rrkP2ESQHSaBQKSJJXfYestVJbbvmu4ln67WJcr/p2L
         OBAZAEGS9+mV4XwvPQwOhErRrxlgRweb5DGFQc8iDZPQJ0rcdV00rMfZ62K1/TGwk9ob
         T1kz8Xw0LRDJVcqttdzw7zFDPTfApNIpM0zheSeoThIL0qTurHQanQ4z4VWF0HMb1yQT
         2ZgC4YQXWkz1zf6DjI4tlfRdomMH/xNWH7syiat3tLQU/YhAWTBGih+70rqiEEDxTVYC
         8UdUpJVvLLThw+IMMgmVWLSkFET5Ky7rAYfpQBxIIgRB6+lAMKrogFBVT0wZo2b+psfM
         LrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722376844; x=1722981644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0zp/PZK1hqhhla6gYIN9ymMRT/WA95vOpDBdsQdGHc=;
        b=Zvi3KFH9gH/XBYTO1Osb/qIXNbazdjtm/dJkUoFJg/0eZJS4/DoNbf/Kn2JiJj1Nsg
         EoLlz6e6W9gtTi9If5kMkEgymLuQF2BAB8eYYeFjXFqxdALHB8bF/+MfG2H5BSvCwjzu
         EGAHZ1EwsXyam5JsP45oP0MNW+0D0qAyOiDwhBuryLZi5y3Wc/zDwwd4EHJgbLjv6HrM
         dXmJ2lIryv9/xNmu+RanDL6GUNBR6KA99O6DQam+raJ0IPwGPWvY+JmFAZqTDUjCEw+4
         vn6hNdgP2uW2Kg12NMTdeXf3YJzfEgo+7KObE4TAFufBlGlXDSBfOm4rMqRdO0EdtRDN
         gpPg==
X-Forwarded-Encrypted: i=1; AJvYcCVtEC1zvJSRWJ9+sOHc4HYbalWhozEoHSe6r+KBNOYCQAyQ1rtpFkdtCGhMItXiobF1umr3Nmof2acQgsf/pkiaAFcfL44DNEiPrBiw
X-Gm-Message-State: AOJu0YwpuTWq+mFByWZ5A5HqspR80gqK3vZfuijGki8thXKJRoFBVnRu
	V8NL3qdTrecaiTqw6a9wn4yGbZygA0Y7gRxjDLgMReOlVpD+VXMZSBHuN9Ct9GOn8irqlHo5nPM
	KHrydkTfutqTuRCayYB4CbTOVlUpV2youYpe5
X-Google-Smtp-Source: AGHT+IG1zvAf88kvECpwWuAK4aUDUCUYd+tbv9v+ciRfmZouVijML/NxH84fWbcGu3kLWdsAzcV3tyF57vtGTsFC+Oo=
X-Received: by 2002:a05:6402:11cd:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b58ea443d5mr64632a12.6.1722376843313; Tue, 30 Jul 2024
 15:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-runtime-constants-refactor-v1-1-90c2c884c3f8@google.com> <dba4f23f-385c-4b8c-84ee-cb2a7c791aae@app.fastmail.com>
In-Reply-To: <dba4f23f-385c-4b8c-84ee-cb2a7c791aae@app.fastmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 31 Jul 2024 00:00:07 +0200
Message-ID: <CAG48ez1hJg+178Z8i6Toc1dBYBF4O2jm7HNZy-a594En6AP5Ug@mail.gmail.com>
Subject: Re: [PATCH] runtime constants: move list of constants to vmlinux.lds.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:29=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Tue, Jul 30, 2024, at 22:15, Jann Horn wrote:
> > Refactor the list of constant variables into a macro.
> > This should make it easier to add more constants in the future.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I'm not sure whose tree this has to go through - I guess Arnd's?
>
> This is for 6.12, right?

Yeah.

> I can take it through the asm-generic
> tree if that helps, but someone else should review it first.
>
> If you have any other patches that would depend on this patch,
> you can also take it through the other tree and add
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> for cross-architecture bits.

Thanks!

I was thinking of maybe trying to write a patch based on it that'd
have to go through the MM tree (for using this in kfence), though I'm
not sure whether I'll actually do that yet. So your suggestion makes
sense, maybe hold off on putting this in a tree for now...

>
>     Arnd

