Return-Path: <linux-kernel+bounces-257722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F25937E1F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAFDBB2172F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B409148FFF;
	Fri, 19 Jul 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eEbVhdYV"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BA7148844
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432923; cv=none; b=D9e8JHy8Zqhxn0qzt8e3+WtQ62rk5kzRbUcVZZqOtnoeNRjrtZKlTIIXnBAApu/JShVU51X+8cOVp4w/B60afl0J/WJS/EIfVTz7v8hA9sZlFrFuQhwtr1h1pXiYqFzTzeY5arVa/53wfCammxT9r0jWYxZB9Y7x4yj+L930A3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432923; c=relaxed/simple;
	bh=Ab6RE9GbqC3T1133n8R4ZdDryTnA+UEpik+0gNQzPlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kLLgzNeU7WMADPPNWAwWv2EfznDF878KIpJO0jsOwvRtPzABZebu7ubFBDX5PjUWzTBdn+7dBusQ+BMlXB+GyIrVohSjp7NbxBH9ggOHdpmhqWbvVOoHrDMXWwoAvXbScNFTijvgnVoBaFFGBPXna+ZCpo6YpqDCkvcAj3DwWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eEbVhdYV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso1788331a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721432920; x=1722037720; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVJY6UcBnDOeBzsT729i8tru81f/9za3Grw++dfFdJE=;
        b=eEbVhdYVSiMxLcEO7UvUlVEdC8ZPxHeAUVJRTS34H9RIphrKeTmyDFHgjis2xNkOSZ
         n3DE4d+LYokYaHxiU2TIikKy6LOB0Gkoh/gwGoD6gmfHhAgWM1SQ0P89+CwrI8S+YuBG
         ToeBRFHM8aoDGVqwliYnVrjDj6Pmk5Lug6dQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432920; x=1722037720;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVJY6UcBnDOeBzsT729i8tru81f/9za3Grw++dfFdJE=;
        b=YmWiRILgnBmHXvvCiPorYVHW4fKSqZIEwpFBtEYaiABnOgcrkX2PP9wbbyoSO21I/q
         1JvEi5WZ7cKRLd/3cZG8geePflRI1Ct8IHXXqceXGDn+GV7z4ts4KIh9bMcbaARyRMdc
         GmXoVjaqfMoMNL5E3YXnhf+b+CwTRAwtNV/wuE2S9TJIjpGjTnBMlsJp6PING1PAFntE
         g3zDLsQPPGrh59kKWujMxRUwcgH5vbb2QO2HmhHU0KUz4mYyz1s9FbWwNO9rlxqUabLR
         GwxaM2hRfbynGIVw179Mhwl3cCMoHc6Cj4WlESoiofGlMtXmYNv7Eav54cI3eRxWHM/z
         YaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkB9RbFAVgHXZC/JVAX1Bfw9/YB7XVVn/JK7eow13Ze0tx9sgIYotkbSB+Sbvp6hHOt8KInf1SpqfmziUU6PeO24esN1rXAR+ooPqo
X-Gm-Message-State: AOJu0YwSTLT2rv1mSf4tHzDdsjdAZbvQqD6/zyq/zi4/6BgJxObdF+nf
	eac0Rq3ILw7GrxFwm0ozfJshrGNGF4i+S7EZ/6dMOZIt7izSeVwUaMGYdNfycRr6Z7B80SEMSun
	6Vb4=
X-Google-Smtp-Source: AGHT+IFab25bcOxdNXT1DewWXTq/GHD0rBzKryrjVw6UYVadkcW7vvBTJ6m5xkdUSwpqOUVFVu68tw==
X-Received: by 2002:a17:907:7296:b0:a79:8149:966e with SMTP id a640c23a62f3a-a7a4bfe6355mr1555066b.1.1721432920246;
        Fri, 19 Jul 2024 16:48:40 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c8c1abesm86038666b.114.2024.07.19.16.48.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 16:48:39 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611d9so1573027a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:48:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLBKst9KgbwhzuTmUzF0975n3x/b2RXQIEML1zkkhhaqEI0wFoNgsEiqXiO3nefYssM5eHR6hIBXciEIbldUuAZxX2VEhcaVaVCUBN
X-Received: by 2002:a05:6402:35d0:b0:5a1:863b:e572 with SMTP id
 4fb4d7f45d1cf-5a479a6aa18mr25696a12.32.1721432918997; Fri, 19 Jul 2024
 16:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpqCjrdsScuA7CgO@shikoro>
In-Reply-To: <ZpqCjrdsScuA7CgO@shikoro>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Jul 2024 16:48:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJJSR5=1C4Vf6NRvE1Yp5-bFOvQVR3RCGYt+yYEF0Z5A@mail.gmail.com>
Message-ID: <CAHk-=wiJJSR5=1C4Vf6NRvE1Yp5-bFOvQVR3RCGYt+yYEF0Z5A@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c-for-6.11-rc1-try2
To: Wolfram Sang <wsa@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jul 2024 at 08:13, Wolfram Sang <wsa@kernel.org> wrote:
>
> Here is my updated pull request with the summaries of the included
> merges.

Thanks, pulled.

                Linus

