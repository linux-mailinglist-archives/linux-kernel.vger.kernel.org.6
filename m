Return-Path: <linux-kernel+bounces-260604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C659A93AB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C73285192
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAF91BC58;
	Wed, 24 Jul 2024 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giiIJKXb"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABB4A00
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789770; cv=none; b=iJ7D0CwyjkkWcbLf1miVXJyRx0mpfwotgncrwfcEHH1ZWqecnJC4naMRlVpUm4Mk6oX/CDUlp98bCs6IvSb5FYb+4Gm5SRi9wDPRoZzuj26Zg8wIR4t+kN/q2gV6qHLeCKt+JyJqr8LZIMMuPf7RHR/dKOdCy6OmkbE8g84lf68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789770; c=relaxed/simple;
	bh=6dazdspn/UJf04zERvuSpqRt7BUfTP2fLHFIMc+TG3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETu9+CZF3qN9d2U0KLFDFUPVnr8R12rOQLWDcx7PVDvbHWwGNA9m0SVH3IGVFpP4p/lfkm8DP6YHE0AVX2OOyyM/CzoT1lhlDoZmza+idZurDx77jK7AN8puQk1GPQeOpTDxnY1EvEMa9j+kDu8y7GRgUchmBRGEZus7WfAZSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giiIJKXb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so7037a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721789767; x=1722394567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjX0N1/uVKtXz1Xh6pijDV4fXZ2/BtLbeBxXdMaD7wo=;
        b=giiIJKXbRqLHKQeb5luV70TRYp3Zkg5T2OrmzagGgpFP/J7nwkS/c//ko9gqBWAdnn
         mLFle7AH4F5NL3ZPL73XZtMAes3X5M8z3mgaQV8mVCDU0sgHPIgYtpEb4e3LNBw/lS95
         j4lLlN3M7jU3Od54kHrvFOgv3o7qKJ3ga7FHs2i4l05Cf0stQqK7zsvF4NX+zyuS+DCL
         o7oRfPCBduMmmnYE/thb+/qNidu2NiYzUeGrB0Q98ZP6bcTkd1gb+UPwCcSdI4KTZweE
         8rVh3ISNGj3rHX5cSOHB45CBVGk0aO8tuFdY5UAy/0uXHG91LBXKspjwanQWgAoe/R7o
         aXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721789767; x=1722394567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjX0N1/uVKtXz1Xh6pijDV4fXZ2/BtLbeBxXdMaD7wo=;
        b=MVbVgLiXK5gNA5L3JTkYmAn/xilqK/t2+TyH1Bwdh/sXFwS8I4IhEGgGlnsKCnf0ux
         mc0BkOKBN+4dIKOXS2kVQekLJLnxeI1QBeh06+gSSrQ5wY62SeXlwmVjIOhFZfM1bKJR
         tCtUmNSdSrp7TANfkSETnkE1ZCcFkgJDJg2Jjy/iuDIFoO5ZExYV6nBVtYMAd2Z2xXDh
         EZR+UgGa8PvF+sQKDQzB3DyLYjwS1tYrKurY2IrTe4MXx2OtlVvNFBKEMbzq9yctFJjb
         mQEqe2zAV6VOrhbLdzldg7J5vaz759JGhQu8oRTafe3rFL+Ny2mZGL4eOzorjZplIYeB
         RKyw==
X-Forwarded-Encrypted: i=1; AJvYcCVYen6/m8OvGwj7ePV77CvwswTP3gAXIxkHfxIMbwOt/bUvRJmgoxI5raCg8vmmQ/wxvLN/PUmBxv1iKt4mcsa5OeWAYfxPp9Lywb/f
X-Gm-Message-State: AOJu0Yx7K0Md/pYT1Y5rbnvV0eNnblSt1Rwxw+0w6PV4iYtSip/rxzXD
	1NOEd0sdEwDf+ujKSYJl8jxq3qvPQchUWDfPF123bmdvTsXH7fkTLWznkMUJohwMSAszrxzOQHz
	fXN8eKo7ylvxyOsMM2g/4r3w5aOdE+WFkNOWT
X-Google-Smtp-Source: AGHT+IFLa02Z21r5Ac6eMz2t7IJp0D+05sQOo6f1Y0QZhV5xStq/BFSn/AJq/aFtQLCXGvzUtPeRb3oI299hJMEGoK4=
X-Received: by 2002:a05:6402:40d0:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5aacc38167emr153193a12.7.1721789766585; Tue, 23 Jul 2024
 19:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
 <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com>
 <b84a6ef8-7c3b-4c04-81d3-859692d91137@huawei.com> <CAHk-=wjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XSXjAUFO8Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XSXjAUFO8Q@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 23 Jul 2024 19:55:52 -0700
Message-ID: <CANP3RGdgnXOXjnAFe6irf2JwrPsStTLvihKkowpY2ggSgNw7KA@mail.gmail.com>
Subject: Re: UML/hostfs - mount failure at tip of tree
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, Matthew Wilcox <willy@infradead.org>, 
	Kernel hackers <linux-kernel@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 23 Jul 2024 at 18:35, Hongbo Li <lihongbo22@huawei.com> wrote:
> >
> > I apologize for causing this issue. I am currently tracking it down.  I=
f
> > reverting this can solve the problem, you can revert it first.
>
> I don't get the feeling that this is _so_ urgent that it needs to be
> reverted immediately - let's give it at least a few days and see if
> you (or somebody else) figures out the bug.
>
> Maciej - if you can verify that folio conversion fix suggestion of
> mine (or alternatively report that it doesn't help and I was barking
> up the wrong tree), that would be great.

That appears to fix the folio patch indeed (ie. I no longer need to revert =
it).

The tests are still super unhappy, but I've yet to fix our tests very
broken netlink parser for changes that released in 6.10, so that may
be unrelated ;-)

> And perhaps remind me about this mount API thing too if it doesn't
> seem to be resolved by the end of the week when I'm starting to get
> ready to do the rc1?
>
>              Linus

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

