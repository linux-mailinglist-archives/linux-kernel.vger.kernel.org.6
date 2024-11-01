Return-Path: <linux-kernel+bounces-392739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB47B9B97A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778491F229B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F9B1CF5E8;
	Fri,  1 Nov 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzBkOS6X"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86EB1CF5DD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486064; cv=none; b=Qc9Ajtn1OnLkWXRYPT8dgnAJcD0s8cU+HwjUKO7j/BmF2nEB9PoCTtRzbg4xeOhz5LAFC5G6Z1SHNpsSg2U2+q+2wkNlPv12B45M+zlP0ZSr3OuzfY4bFv1w6uVfu6YXRe7NgFFe4YHJTr9AiyjWGNtvNeCDALwGx7NYf5PAylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486064; c=relaxed/simple;
	bh=MgNN85AoZlpJ+j0403O3qyOGxdtxkF3CGvjjnD5p+R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qje2hNZUS5wli2OC1DDBA1QYmW883zD1EMVvEgv2qssh97D4hEVHdGIOkxPE9FhrFu1kb2rddSYENIckhVr5bqh51CxlWbIsX+0pNQdiUj26cebnIvd7Vqc9z5kDW1JTIXaLKZXqbgiq6NRg9ijEGNst9qu2SG/waw7zMv1bNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzBkOS6X; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so17497735e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730486061; x=1731090861; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MgNN85AoZlpJ+j0403O3qyOGxdtxkF3CGvjjnD5p+R0=;
        b=lzBkOS6Xii/mYBcCMdhUCq0yRR2TM0fqsLvf40I6zsuRhYTb2QmQg6AzefRnfQLOk2
         XpEw0lZczatR69R5UdMafk5I9oYsxS7yUUUXvA2GjeFv53GbmrvVgsvLRxh1eTLwlstt
         GHVdJe7RlwtTGSLiLpp5DlzhJGXvwS/jsR9AJJW3kvuCntQLgc4twz682FJeNJwr+KFu
         XfE25FIQvaDEQPjyCSvTJqmUdaEPdgdHi39hgjgwqBd0+b7heHtrz2htjQjikLgeF5sV
         z1hK1TjCV7OU4mqnldnsNiCL+zFdnwKt2hPzZITH21jf7DrYswWU2kS9vS5YHKfrPDnX
         hcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486061; x=1731090861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MgNN85AoZlpJ+j0403O3qyOGxdtxkF3CGvjjnD5p+R0=;
        b=tkqaGPy+z6DE0SRtqnX9H2Xft1B4RNhX6Nqa9xa2w+GuH79PXceVmDbbhJQOakvaKC
         yKFujrNgPg5xccqlPZInrqugIM6E11PvEy5uIJSujQ9Jek5da+5rVyp5mXGXu4xuq3AT
         u5vZkcIoPSAVRS61zG13fgJ6KZjpLHSfFuPjSO3uAo3kNfRhQINGUvvKYSx6Khi8slzL
         W6CiWEryI3SRKFMH7iIRQ36xOiENTcnXWYNEkFs3ZwLz7WtWTHmieQD+GYTGG3sYo4KT
         eW23XU3uEbfNdg6hXspGNdqFOqY+nT4xPtfhUp+mUIcPXUT9TJ6ID4FFIvQZPaI0ofUA
         M4ow==
X-Forwarded-Encrypted: i=1; AJvYcCWptSwjFsvw62c9zwkGDemcK86M7X3UDDH5O2rP3bu6sKxduas1TmhvQD8JUZPPl6xsJRoBGZ+A6Ybn9cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFw6buPtxjVqsPMIBEDp9RBg0JHJXY/aLoBhVcGYCNQc4rVRS9
	qjJ0E+mH/5YfjiotcgXHcDJJ6ri4uUafcDngroTffvo9uBWrvlWorm9HPK1Bb8M=
X-Google-Smtp-Source: AGHT+IFd1B18u59V44K5CpVzXuRn8M+JIFTClqQnLfopG2BwnAJSE5PJtsxd4HFHpqh6aXOhZGYmCg==
X-Received: by 2002:a05:600c:5114:b0:431:60ac:9aef with SMTP id 5b1f17b1804b1-431bb9de94bmr109794675e9.29.1730486060987;
        Fri, 01 Nov 2024 11:34:20 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a99c8sm99737145e9.29.2024.11.01.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:34:20 -0700 (PDT)
Date: Fri, 1 Nov 2024 18:34:18 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Nir Lichtman <nir@lichtman.org>, jason.wessel@windriver.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix incorrect naming of history arrow keys in code
Message-ID: <20241101183418.GB752705@aspen.lan>
References: <20241031192350.GA26688@lichtman.org>
 <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>
 <20241101002612.GA29456@lichtman.org>
 <CAD=FV=V+EJf--J29YM7XuHbNO0fFzLgOYBhBA5VsnnMTG-LArQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V+EJf--J29YM7XuHbNO0fFzLgOYBhBA5VsnnMTG-LArQ@mail.gmail.com>

On Fri, Nov 01, 2024 at 08:29:39AM -0700, Doug Anderson wrote:
> Hi,
>
> On Thu, Oct 31, 2024 at 5:26 PM Nir Lichtman <nir@lichtman.org> wrote:
> >
> > On Thu, Oct 31, 2024 at 04:06:03PM -0700, Doug Anderson wrote:
> > > >
> > > > kdb doesn't react to ctrl p and n, and following the code flow with GDB
> > > > reveals that these values map to the up and down arrows.
> > >
> > > Really? kdb reacts to "ctrl-P" and "ctrl-N" for me. It also reacts to
> > > "ctrl-F" and "ctrl-B".
> > >
> >
> > Interesting, how do you run kdb? I use the kgdboc=kbd kernel boot param.
> > I haven't checked with serial as the console since I work with the keyboard,
> > but if serial does go through this using ctrl+p/n then the code in the
> > current state is misleading since the keys change depending on the I/O method.
>
> Wow, I've never used the keyboard method since I've never run kdb on a
> machine that supports it. :-P
>
>
> > Evidence in the code for usage of arrow keys in the case of keyboard can
> > be seen by examining kdb_read in kernel/debug/kdb/kdb_io.c, in the /* Down */
> > and /* Up */ cases the values 14 and 16 can be seen.
>
> Right. Essentially the logic is converting the Up and Down sequences
> to the characters Ctrl-P and Ctrl-N. ...so by the time we get to
> handle_ctrl_cmd() the characters really are Ctrl commands, not arrow
> commands. Thus handle_ctrl_cmd() is correct as is.

Those comments, which I'm pretty sure I added, are arguably more a
reminder about how the input systems map up/down (which on serial are
multi-byte escape sequences) into single character control codes.


> > Do you suggest to keep as is or to work on a patch with a more generic name that
> > would fit both?
>
> IMO it's a bug that the keyboard code isn't properly reporting Ctrl-N
> and Ctrl-P. Does it handle other Ctrl characters? Ctrl-A should go to
> the start of the line and Ctrl-E the end. Maybe you can track down why
> this isn't happening?

I'm with Doug on this one. What values does the kdb code generate
Ctrl-<letter>? IMHO it should be generating 14 for ctrl-N and 16 for
ctrl-P.

BTW ctrl-N and ctrl-P are very common keystrokes for command line
history (try them in any readline program such as bash).


Daniel.

