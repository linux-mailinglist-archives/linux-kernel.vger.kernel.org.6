Return-Path: <linux-kernel+bounces-329721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1159794F8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 09:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042BC1C2229F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 07:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5025760;
	Sun, 15 Sep 2024 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g7MfO1ZT"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C45F1BC3C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726384287; cv=none; b=ZN0ALlIiKxFnIWefQeKxpKW6yykXoZp5Yfw3B0TQvCpWU/SAo6VgNX3Gdvj/p9ssLKX2lvTpvaBMSNa5b7r4Eskv+gc9BDBbp/P0mjOm4N2L3i5MQZAEJg6IEMuaSmTQP3QqQxV2BmVXsK3pw2iwl3Zfey33vsY2HdGvHEhRYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726384287; c=relaxed/simple;
	bh=xjWojUc1mLB5ktKYpFXYU5sO8vFqeC4TxRTtvNAcNTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOt2XmaLd+bUPT4lH4h+d9IjJ+299zhUK4sLltaOdXJ5tkKc7efB8/p8Vl8vwVR9+g1wJYbaWLtZQQtxlK6HY0o+MLp6HfS+S4LDOqCHW57dkFuVrgCQ3V/9z4SjlIP8BoZRlKjUAh1SLtnHUuMwT5vvxGIQziwMYEXCEYVft9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g7MfO1ZT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbe0so661188a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726384284; x=1726989084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc55qxpiIVFj7PWD1KIvBrEfXf3cIQSNj9lFEjAYl9E=;
        b=g7MfO1ZTCqtEcsI2uxXwQYB41trv/aYnxKEeu/ZUWPq9H1MbiarpVfCXhjRQ4/cdfr
         a70CAIBqKCYm/2/woaPgbGTv3FMv6GVEpbrAcXvkH/UWoTmjiF8xWaSWZYYtoxxy9IPj
         h0R1zuhcy2MZg3z2EFD1uLOkeOSKPEOtpIBa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726384284; x=1726989084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc55qxpiIVFj7PWD1KIvBrEfXf3cIQSNj9lFEjAYl9E=;
        b=s9joXFpkJ2TM0oy21LkIHMF4diICwKbs22GXeVdHSqGjvucHGVsvhK0FpzqfvG80T9
         4jun950GgSXOqXIRK6bWKO/gM1gFEqgGJbvgWaJRzbUO/6Da7/vkZLq08NvYvOrRIwUG
         wCvFUNKzIYNilDrnGA3h98ozDqdmHVew8zV7/xapy17dIQEO6SPIK2ghIE/VzadwqXYv
         mdoBSSq5aYE8BG4Ac0Ve8+fyQZi4BcbrffX1fIOxsXFHb1e/JhaDXxNWCmgY0sqXKqh1
         hfgMyZedTcySavIt8O+AFJYrU6sFcBUqPpUXEkCq04O31/ZE1XzKPl/tMFqwnnKh5qk4
         APDg==
X-Forwarded-Encrypted: i=1; AJvYcCVIXnN6Be7pHjUitxcc9ZY5AKr3D80EVbowxA5jd4Pnzp45lx6EGYD2PZFKm//kwEtDzO56TClBz3y26T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5TzgjBYJi+tnHJpOsRlaLY7o0bPfDid2chwAucSg7kyIzUis
	Glp+bfrOOnuk34ePdwrVoTGRUZm4OrSTDc9M9JYfMkN1hxbhHDV4w/ETcfoEnv9D6TklZ5YXZ58
	S/ckyFA==
X-Google-Smtp-Source: AGHT+IEVrKpfp9zWwvECqNTLNh4WmO+Fes25JQHcXoLDi51dylclu7sMMIjEXiHfpXAfiDdRl8zq/A==
X-Received: by 2002:a05:6402:350d:b0:5c2:6311:8478 with SMTP id 4fb4d7f45d1cf-5c413e4c208mr9333155a12.25.1726384283282;
        Sun, 15 Sep 2024 00:11:23 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5dc0dsm1370719a12.42.2024.09.15.00.11.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 00:11:21 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so3848082a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 00:11:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9MOg0vFlfdVC+FrpPb8ton+JeTtFCcKwMFZCldoDb09q3kMU6NDwFHWV2L4eLD/lpC/O+fZHmDKJZd3E=@vger.kernel.org
X-Received: by 2002:a05:6402:5193:b0:5c2:7002:7cf8 with SMTP id
 4fb4d7f45d1cf-5c413e1f43bmr8669748a12.17.1726384281208; Sun, 15 Sep 2024
 00:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au> <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
In-Reply-To: <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Sep 2024 09:11:04 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Message-ID: <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, dhowells@redhat.com, dwmw2@infradead.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, roberto.sassu@huawei.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 10:30, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Fri, 2024-09-13 at 12:45 +0800, Herbert Xu wrote:
> >
> > Does this address Linus's objections? If not then we cannot proceed.
>
> I hope to get an answer from him.

So honestly, just the series adding pgp key verification I have no
objection to. The use case where some firmware uses pgp to validate
allowed keys in EFI variables etc sounds like a "ok, then we need to
parse them".

The objections I had were against the whole "start doing policy in
kernel", with what sounded like actually parsing and unpacking rpm
contents and verifying them with a pgp key. *That* still sounds like a
disaster to me, and is the part that made me go "why isn't that done
in user space together with then generating the fsverifty
information"?

The argument that the kernel is the only part of the system you trust
is bogus. The kernel does nothing on its own (apart from device
enumeration etc of course), so if you have no trustworthy user space,
then you might as well just give up entirely. At a *minimum* you have
initrd, and that can then be the start of a chain of user space trust.

Parsing rpm files in the kernel really sounds horrendous. But that
doesn't mean that I hate *this* series that just adds pgp key handling
in case there are other valid uses for it.

But maybe I misunderstood the original suggestion from Roberto.

              Linus

