Return-Path: <linux-kernel+bounces-242800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C4928D55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13C51C21330
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD18A14B075;
	Fri,  5 Jul 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VMxA293M"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7B7E9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202905; cv=none; b=MuJBNY8Yn5SQMqEQtd8r+P9gZQLXNdyc914ubpxxbs74hkbbyS4b2nsGKkmuZOXfSpNwihgvjw+z0tXEhdr0E4dvR6RBEqdjNI7u8sUkxd5VO97hQzWKHiYqXp2x7WZasOTGWQsBSTlbQqJRjsPSzh5r9xZdMoTmYsrgef5gRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202905; c=relaxed/simple;
	bh=3ttiwdgvwfzISC5CxWtmve2AcBrKKsL4htP0joWhI5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pk7wn+uwC+NkTECrc8jrtNA4nim9+vE6jQXDRYJGz8A77LVF39iaD83rbgnYtA6rEoggGCNeDiJjMs7OFfnxfSbBv0WuIhqEtESysMGQFfj4QhZH1KzJtW0A1WpIK51xSN9m9YPk4znsxx28TSZaeVkWIPJRicKvh4180yl25Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VMxA293M; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-700cc388839so1265972a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720202903; x=1720807703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=foHHobVG1YENv+h57RGN7xhs4NOgPketX6LvtW2Rpi4=;
        b=VMxA293MMwj08tNDaHEIFjEyc96Umzt47p+Y34cQ/nSvB1r2RBxZyccB43Vq2/NNky
         QtiGKS6Ixs8+S11zsepL62w176OlVOvK2AIp0qcroj0hfcrsYiaUYrSlQfuHbfnFYRv8
         ShYvByvGhnpZcck6xIsAfE3WQVZj0C2px/pYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720202903; x=1720807703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foHHobVG1YENv+h57RGN7xhs4NOgPketX6LvtW2Rpi4=;
        b=nlv6Uu8MGeRvu28vl5Rdq7CQe4R5kioA8BcEfjSkOkkrXgk6aAC1c8cuLSGQgVyqpK
         atOBqyJt3WFr7UtOtupmywaEdPJThBdACVEfly8EZ8avsul6pE5NzYBIDAw/JLxY0IiY
         3TQeV9jDHvrySik/BDnNYPtf2in59QebsQDjttYRKgqlP73HiHmBOLhaH/0nJQXVzs4N
         nddP0GI4MscrO0xOn69GrIHz1CPUIOrC8wqG4Ef4PJxBzFv6sQ76EHPqrLZ3LwGwIRhy
         tYSIs/bB1uSRGbiBv/6QistJDq9ovVeYvna0AO2ce1ibig+jXB3gvVE3b3MekexmdNC2
         U3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWizaVj0MOyyfPWLl5ZI/BmFak4is7x93Yrs/WqRYBCViFkZ4YpdbIvF/4/o+v8gb4rHIRNukuuY8zfwdllaK/DzuoPwrodHIXF00a+
X-Gm-Message-State: AOJu0YyIwQgIjVyxrHKSgLbHz37a87zSuTaPLJds9R/RoWQhySvRi3Lt
	c7Op1vm1QB14DZHYfGZfSTYqin27rwKMtk5Ft9gk2qFtxcxX79CrkVIKOXiYYsymbsukpRU+fcr
	SKlQ=
X-Google-Smtp-Source: AGHT+IHOmOXkmkqf3ILs4FtQkUU1pZNqQJ+YyfT+k+cvpf6L+gKaalBWJSnW4zf5yzHOL48/olPxuA==
X-Received: by 2002:a9d:6a17:0:b0:700:d012:d414 with SMTP id 46e09a7af769-7034a7375bcmr5823397a34.7.1720202903077;
        Fri, 05 Jul 2024 11:08:23 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b3679asm2670959a34.67.2024.07.05.11.08.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 11:08:22 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d55ec570a7so1097244b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 11:08:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU19kNf/KwPZvAgzX1gW3twfkKRi4i+uF1Q1KTZ40gK3ZF4sQa5EhSQnqObKPHM6c3eZkDvTIbwTQvcbrw2DshdaXR3escTbmXNM9vb
X-Received: by 2002:a05:6808:23c2:b0:3d2:1e2c:3a7c with SMTP id
 5614622812f47-3d914ea1e57mr5988222b6e.44.1720202902123; Fri, 05 Jul 2024
 11:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
 <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
 <CAHk-=wgqD9h0Eb-n94ZEuK9SugnkczXvX497X=OdACVEhsw5xQ@mail.gmail.com>
 <Zobt_M91PEnVobML@zx2c4.com> <CAHk-=wh47WSNQYuSWqdu_8XeRzfpWbozzTDL6KtkGbSmLrWU4g@mail.gmail.com>
 <CAHmME9pgFXhSdWpTwt_x51pFu2Qm878dhcQjG9WhPXV_XFXm9w@mail.gmail.com>
 <CAHk-=wjCmw1L42W-o=pW7_i=nJK5r0_HFQTWD_agKWGt4hE7JQ@mail.gmail.com>
 <CAHk-=win2mesMNEfL-KZQ_jk1YH8N8dL9r=7XOLp28_WMazpVg@mail.gmail.com>
 <ZogcxjLv3NAeQYvA@zx2c4.com> <CAHk-=whRpLyY+U9mkKo8O=2_BXNk=7sjYeObzFr3fGi0KLjLJw@mail.gmail.com>
 <ZogzJCb66vwxwSLN@zx2c4.com>
In-Reply-To: <ZogzJCb66vwxwSLN@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jul 2024 11:08:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
Message-ID: <CAHk-=wgH=d8MUzJ32QNW_=KDQz7U5g_1Mm9sR9zB1iNUpxft7Q@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 10:53, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> That sounds not so good: the current state is 144 bytes, and it's
> expected that there'll be one of these per thread. Mapping 16k or 4k per
> thread seems pretty bad. At least it certainly seems that way? Wasting
> 16240 bytes per thread + a new vmap I can't imagine is okay.

Well, I guess the simple solution would be "just pick a size that is
guaranteed to be at most a page, and a power-of-two, and big enough".

You really don't have that many choices. Presumably we won't have
per-architecture random states anyway, so the smallest supported page
size is the upper limit, and if the current size is 144 bytes, we know
that 256 is the lower limit.

IOW, we pretty much know that the number is _always_ going to be 2**n
where 8 <= n <= 12.

Just pick one.

> | - Future memory tagging CPU extensions might allow us to prevent the
> |   memory from being accessed unless the accesses are coming from vDSO
> |   code, which would avoid heartbleed-like bugs. This is very appealing.

No. Stop this idiocy.

Now you are getting into cray-cray land. Nobody cares about random
numbers so much that they'd worry about leaking them from other
sources thanks to hardware bugs.

Seriously. This is the kind of "crazy random number" talk that makes
me go "I don't want to touch this".

Get your act together. There is *NO* way we care about this kind of
garbage, and just bringing it up makes me doubt that you have the
right mindset.

You claimed to not be one of the crazy people. SHOW IT.

                   Linus

