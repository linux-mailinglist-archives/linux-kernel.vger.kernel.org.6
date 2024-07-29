Return-Path: <linux-kernel+bounces-266332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A793FE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC451B221CC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E204B188CD5;
	Mon, 29 Jul 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rau8zEAd"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6653218734F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281248; cv=none; b=QxgInnnICiCgLuYXycjvUwyvVz/Ev6EnX8coj6FY9ndKQTt8yGFny1pCNI3DYpW/Ge2Yb6A5qRv5JsZKC6tpEjFSZ9EDwDFp7QjGJQTfEZaA6WlgzATBnH9P7omh4iNJwu8YsVMUu0E3jvNBvyP1cTJ5rIpK92kfcZWtb9L+v98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281248; c=relaxed/simple;
	bh=wuV0CJ6b56yl9jpPmCcBO0ysR9/+51iVD3eCn2Pl17c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0wbL1gZPVZjMf8dkYR0sN4YCcjkyKa0NBveWBQLawYcHhBkWzd0vU1P6p+JWdXiuY59tlmS7DsXeEjqiZj1c8JOhY+GZHvTP3rpL4d1g0MxyiKIoLoYnzrfycXmi1rOgfsRTZXD21xZkVxH7mCuPHfjVApqa+UFcldNCEuP+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rau8zEAd; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efdf02d13so6011992e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722281243; x=1722886043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kSNi0pjVxejT/B7YEh+vGAJOW4I46TVEhUbFiwaZ0+8=;
        b=Rau8zEAdV8TJq8wRN3hgwLVEfS3NFAgQfMMpoVJ1wDygcZRQzxLai+zlP/zYcHJrSz
         IKgR7kHfKzTc9d+UMGsDUSo87tn50BUxQvHFCJXhmnTIM5Llzx7cxzhFWojrXxYjl37i
         ssXHrdPLDWuuGYsiEGa6vw+Zs3IUwFnE9WRf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281243; x=1722886043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSNi0pjVxejT/B7YEh+vGAJOW4I46TVEhUbFiwaZ0+8=;
        b=XsjmO2nVxWWJ1B/PG5vCvpQIf4zLTYU/b0kgMibdGkYCOlnz20h0fqjV5OwsR7VMf+
         IXuPkAvVJx3F8MhL2n/Lwkf9pzNBUZT6c7xei55YaASInDQv/5pRb9JpNT+3WNkMBLdY
         HFArELQtGQElIbsI+1y0UYTrGv01Vz7mbHsYAK8H4ohPNb77QWcfX+kwph8xWO9DMYXa
         Z5BLzw6NnMuvpdyJ4wOKZ75XGWneB/KrGLJo3ln1mirI2MuA9f/80p7RSE/2bzkASYK4
         R6cIfXzymIw0rBq2Fcf9R7qGl548kwEx9E3eOMz6errQ3hKrqaaxpqcOrKp5oiDxjpEZ
         FDkA==
X-Forwarded-Encrypted: i=1; AJvYcCW5uqBJbZo9gw/zHWVn1sNDK3LswRgNXcomow3udM6+OqFCd8uBFx/uaR92n5ma4fWOkbTlpbsVssQPhZpSIsQWCp8OBnir3W8lvVr9
X-Gm-Message-State: AOJu0Yyq29j6sZbGQpv5EUWdqUG5oc9y6UI+2vOTx8WJZXPWChOxF7sG
	ip93Q0ikx21nBjlhZ/nP/9CzI5V8UN+Kv1LHnxI/9ep/VV/V1I5U/VYJFvYtcN5aNF61SKgTNQx
	mQf3HKQ==
X-Google-Smtp-Source: AGHT+IHWFCpL59x9LMC+wALeH6FrpWpDc2mfPGtg8eow1bWlGnTg7ct0HWFyBxQNBoxmpnKLuAbdVg==
X-Received: by 2002:ac2:5506:0:b0:52e:710e:e4d2 with SMTP id 2adb3069b0e04-5309b2a5cdemr6567220e87.33.1722281243189;
        Mon, 29 Jul 2024 12:27:23 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab231f2sm543246466b.7.2024.07.29.12.27.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:27:22 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ab63a388bso304921866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:27:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5zHcHWy5G9ktR+h+FxwUlSxmPcgnO06GZ6hroClM9q7Ou8Sw5zJsL+Sy0ln2yK6OBRBp1qHhqwwU6Zf1R7M3uEpkgCCkzqv7JmCdE
X-Received: by 2002:a05:6402:268d:b0:5a2:65cb:7335 with SMTP id
 4fb4d7f45d1cf-5b021d22bf0mr7507356a12.19.1722281241607; Mon, 29 Jul 2024
 12:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7eb34e0-28cf-4e18-b642-ea8d7959f0c7@I-love.SAKURA.ne.jp>
 <2024072944-appraisal-panning-a0b1@gregkh> <f9b4ff23-ee3e-418f-b65d-c40fe28fbba8@I-love.SAKURA.ne.jp>
 <2024072930-badge-trilogy-c041@gregkh> <Zqe76gATYUcDVLaG@google.com>
 <CAHk-=wgweFg4hOus9rhDEa437kpkdV88cvmOHeZWwhgSa5ia1g@mail.gmail.com>
 <ZqfYfIp3n7Qfo1-Q@google.com> <CAHk-=wiT8RzFUVXe=r3S9dfCpV+FhARgtb5SxLDSOKCJKCLOZA@mail.gmail.com>
 <Zqfg8FW-SFFedebo@google.com> <CAHk-=wg4peLPGB+Lyvdtwxe6nVeprvTbZiO8_=E8-R_M+VyWow@mail.gmail.com>
 <ZqfpgmmLgKti0Xrf@google.com>
In-Reply-To: <ZqfpgmmLgKti0Xrf@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jul 2024 12:27:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgo9iEZ20wB4rOpt6h36Dymudqf6HXww1N094bVoqyMmg@mail.gmail.com>
Message-ID: <CAHk-=wgo9iEZ20wB4rOpt6h36Dymudqf6HXww1N094bVoqyMmg@mail.gmail.com>
Subject: Re: [PATCH (resend)] Input: MT - limit max slots
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Henrik Rydberg <rydberg@bitmath.org>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jul 2024 at 12:12, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> OK, if you want to have limits be it. You probably want to lower from
> 1024 to 128 or something, because with 1024 slots the structure will be
> larger than one page and like I said mt->red table will be 4Mb.

So this is why subsystem maintainers should be involved and helpful.
It's hard to know what practical limits are.

That said, a 4MB allocation for some test code is nothing.

And yes, if syzbot hits other cases where the input layer just takes
user input without any limit sanity checking, those should be fixed
*too*.

"The allocation failed" is not some graceful thing. Large pointless
allocations can be very very very expensive *before* they fail,
because the VM layer will spend lots of time trying to clean things
up.

So a sane limit *UP FRONT* instead of "let's see if this random
allocation succeeds" is always the right answer when at all possible.

                Linus

