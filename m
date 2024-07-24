Return-Path: <linux-kernel+bounces-260582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E893AB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6022849A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7817571;
	Wed, 24 Jul 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ffaZTUAQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7DD79F0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787743; cv=none; b=XxChj5yih9Pwes1MxYjpC/AQ0V9r7n1ghywRaL6aWicTQXHrJsbW3upyvZyvMHT8BxfXl/TdElFy9knIBDRAnwnlf4LnooHEY8wZbskY2zHMvC8sZ31SoKYmqTbNglr0XIyFCe4IakZ2ZpXwEYpCNu6WLRb++RJ4619OoQY3qV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787743; c=relaxed/simple;
	bh=OgQVaqDY0rySlDI6btP8mh6JQKS0vuv4mN87MGR7Sz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYeahPeHGalu5e95esWG4Fp+6VUn7g7lwO95gxHz7mHgjwg6+5cNrnP2QSL3yWU9C8zChMKopb/N2gzqz7wDYANG8Iu5iFXnup2u9efL6KBU9of1ucQnMmzGQzEd8O+eTLAnGIgRPuB7GNwtTvm64YJiUpe7EAVcgMkytZ54/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ffaZTUAQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f0277daa5so4837273e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721787739; x=1722392539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ekp56yXc7x747W9mRmyXQrAfIhU5MfzbipA8BoJNiI=;
        b=ffaZTUAQe+XhhkafUWremn6E8Ah1LFBb1hnMQrBnk3nqgSE2hBnzy7JVdDz8clQbJE
         UWK/F3SmL2h8M8OaEo/8Ax9yHu09jqUaSvGKBDYQhBr7P7VMjn/dBEW8r+VFXlhHVd2U
         NfVKiTIqFkkccQM+5xBBLYduOveSS1Yftw+3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721787739; x=1722392539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ekp56yXc7x747W9mRmyXQrAfIhU5MfzbipA8BoJNiI=;
        b=DwTSV1VCA48jqz3LlaFGkIsDHVqCeYAJ1SXjSghVp6tS2GlAR9H+1umLlWXFMI73mv
         TfSuTqNu3lleraUDHfygNqNMSL87cSBN+PdB+XsiG7EJoFpeusQ8DYeSIrGXxJmiWFnU
         cHdza82obaZV57mevBIx0G43BS6wokbDt3AHbzUdLzc6Cqh65k+iuxgDNCm8bR6P9g3g
         fVYj5KH12i+PMTf2qcGFyEyOceuhhnRWD36C03WGkskb3apiVcfAxxD7z5jM8ppBD/9v
         wY0ccf4heZ07+kPLyJZSb3pLyeyddvTmVNdHtCmldTF0W3ZkobBWRsN2lWm84/V7dGvn
         zf2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0qIphkbqHvC7PTr8eNZxaJSowUZ7wpAfzJRbKcUm2hjmvmWMfK15/wls18GrpcgRBQ/g2xKAdrGLCMwmWSNE/GSR8GEN9AlLR07tE
X-Gm-Message-State: AOJu0YyjOifA1cqmXIppoUdF+MwB6eTHeEiReNIPBrb73uR8zL/95wpi
	NfjB21Lr2u4QcZ252whKgJvmOXcBmH5IOgoQGtblatNDK74cBTbAiAC/MwqvPRAJDlHBab1SSv7
	mTpOH1g==
X-Google-Smtp-Source: AGHT+IFYL1QhYHqGjYeFxWxuSWE8jlfULIt42lyHqosvGFHUs/IqAPtFHk+mmlb4zwdbTCPRA814Og==
X-Received: by 2002:a05:6512:696:b0:52c:e4bf:d55d with SMTP id 2adb3069b0e04-52efb53368dmr8076738e87.8.1721787739295;
        Tue, 23 Jul 2024 19:22:19 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c922b3esm591880866b.184.2024.07.23.19.22.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 19:22:17 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so5077362a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:22:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ+UdsVxALVM8Md2urY9909qXxMpHq1YCauA61l33IjNYRNhARxMxuszdmw4BDI/1YlC7LMa80P2jnUdQEjRXIrXj7G1ti9j/v3Arw
X-Received: by 2002:a05:6402:40d3:b0:5a2:4b34:b76f with SMTP id
 4fb4d7f45d1cf-5a4784834b0mr8870218a12.2.1721787737552; Tue, 23 Jul 2024
 19:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
 <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com> <b84a6ef8-7c3b-4c04-81d3-859692d91137@huawei.com>
In-Reply-To: <b84a6ef8-7c3b-4c04-81d3-859692d91137@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 19:22:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XSXjAUFO8Q@mail.gmail.com>
Message-ID: <CAHk-=wjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XSXjAUFO8Q@mail.gmail.com>
Subject: Re: UML/hostfs - mount failure at tip of tree
To: Hongbo Li <lihongbo22@huawei.com>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Kernel hackers <linux-kernel@vger.kernel.org>, 
	Patrick Rohr <prohr@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 18:35, Hongbo Li <lihongbo22@huawei.com> wrote:
>
> I apologize for causing this issue. I am currently tracking it down.  If
> reverting this can solve the problem, you can revert it first.

I don't get the feeling that this is _so_ urgent that it needs to be
reverted immediately - let's give it at least a few days and see if
you (or somebody else) figures out the bug.

Maciej - if you can verify that folio conversion fix suggestion of
mine (or alternatively report that it doesn't help and I was barking
up the wrong tree), that would be great.

And perhaps remind me about this mount API thing too if it doesn't
seem to be resolved by the end of the week when I'm starting to get
ready to do the rc1?

             Linus

