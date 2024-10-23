Return-Path: <linux-kernel+bounces-378711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D1F9AD441
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA0FB2230A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512541D0E22;
	Wed, 23 Oct 2024 18:50:26 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647261CB330
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709425; cv=none; b=ld7E1aGBH2BimzLvmDlsQboxILh/cPhtNnED33I/jh/p7Rcw4YZOlNIxcGYE1NPVKCAxblREa4HL6IzHl/nu2Os8fOuBuZ1eyV0Ug9NBWxdLc5dKdf7esMmHjc/Z6a66MWTtxNxdjVxUQd1TgG2REEWiQo+STNRVjLBV3cpWXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709425; c=relaxed/simple;
	bh=nM4GHTAct824hgNQTffHgJkZKx3+nDD1iyj7MpKVlF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSFptsej4kLQYHV7CgevKpYCno0tP6FJMuaJSqceVaRT9ynk5R5ZHQnkN54oXCLnCXJmuwmYQJQxRV5JjvCRYv2XGZcKyd23H+jHFQGvVN6w89PHAR60Wz/qPIpoFHGcmsKbAWCMfNeQejFlFgPmuodmq9A2CiB9H99E6LG52Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5e5c43497so588667b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709422; x=1730314222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx5iw+dXV5zNGB9sz5cE4SmDR17PiRyOqtTpREu4aVE=;
        b=kzK59+Jp7095fl+adHJbqzS9JPnNNKzFKdUozNPS8wgnseo+obr5rsStfAJy8JnWrw
         iIJDkJaQ1YAXwyp6wNf5PTmM0rzr2tTM8pCHD6QGwiVlrSoFsnEKAETmVFiR/1Lc/+mf
         6MVzkJGzpWZwtcv+mgJF2HNh9P8kaJxkX1M+2A/jmQXK9k2zVnjgz6MQstFcvqwkHO9H
         yLKFuCd1jo3Rp9O30grGCGS2e7KQjQkE6VS7cUreTLg3ScNiwmxVSSPeKkF1nWv9SG6f
         jfvggxvg6NqcmhgF7+TCUFX/crWlsiVYgaP9S34ykoSsi4gypShqpm1DpcmimbnaeZV7
         IqUg==
X-Forwarded-Encrypted: i=1; AJvYcCVqc4n2TJovqSMM/pF0MXp3pRRG0FM/81Wg63CnMqolYpRh400Q3jgHSVJnlRIdTT4lZ5hstGzvpkStgF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1eXvcddYCGFdH+i0rRieg3NFoG16j2vUx+N7qYf8v6e5BdHzV
	evEqqPNjwFFdtM0theY6ldRhqTzGB/0nD2stxwJNaIxjoCjJvydnumrvjf7U
X-Google-Smtp-Source: AGHT+IEM+hREJ8aGhDpvpo7qc63Qf4tUFblC6AP0AibvCLVoPOM5UAxDB0HjHVoFCZUMsIEB4VTt8w==
X-Received: by 2002:a05:690c:62c5:b0:6e5:aaf7:68d0 with SMTP id 00721157ae682-6e7f0e3fffamr39888857b3.18.1729709422180;
        Wed, 23 Oct 2024 11:50:22 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d6f8f9sm16461817b3.136.2024.10.23.11.50.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 11:50:21 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5e5c43497so588297b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:50:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhRikmLFxmAnQdO7LlOtkBM8d/0sbhJsOtn62aahfjy+VmIQ9y8rbEoD786e0Yj9prbk/cmioIG9tik3U=@vger.kernel.org
X-Received: by 2002:a05:690c:3145:b0:6e2:985:f4df with SMTP id
 00721157ae682-6e7f0ffc91cmr32597547b3.44.1729709420902; Wed, 23 Oct 2024
 11:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxZ8MStt4e8JXeJb@sashalap> <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org> <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
 <61e62ab7-50d4-40a3-8230-9c5e6814829a@roeck-us.net> <CAHk-=wh1j+yj6X9vaj6i+oy+CtwnUvK+2J9LkheLjHtKAFYrjg@mail.gmail.com>
In-Reply-To: <CAHk-=wh1j+yj6X9vaj6i+oy+CtwnUvK+2J9LkheLjHtKAFYrjg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Oct 2024 20:50:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWMtr5jvPcn2KQvWFCRC1nhcdci_jzXh=M1a12XJTQmKA@mail.gmail.com>
Message-ID: <CAMuHMdWMtr5jvPcn2KQvWFCRC1nhcdci_jzXh=M1a12XJTQmKA@mail.gmail.com>
Subject: Re: linus-next: improving functional testing for to-be-merged pull requests
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, paulmck@kernel.org, 
	Christoph Hellwig <hch@infradead.org>, Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, Oct 23, 2024 at 8:10=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, 23 Oct 2024 at 11:05, Guenter Roeck <linux@roeck-us.net> wrote:
> > And that is a good day. Sometimes dozens of builds and hundreds
> > of boot tests fail. Analyzing those failures would be a full-time job.
> > Who do you expect would or should do that ?
>
> Yeah, this is the problem. I think it's only useful if some automation
> (not humans! That would make people burn out immediately) can actually
> pinpoint the trees that introduced the failures.
>
> And I think that would be absolutely lovely. But I suspect the testing
> requirements then have latencies long enough that getting to that
> point might not be entirely realistic.

At least for the build failures, zero day does a good job, and does
inform the author and appropriate maintainer.
Unfortunately maintainers can still ignore any reported issues...

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

