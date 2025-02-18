Return-Path: <linux-kernel+bounces-520266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBD2A3A7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2A67A33D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B851E5200;
	Tue, 18 Feb 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfZSKN6Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360A21B9FF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907417; cv=none; b=Aj8ct3NjCeiyaiWCwIhUjotw3wOMHEYhrqzXyhXR5z2AvlQL/mCDBHjl+WjVHuKmB4pjXa1z1R/+V8KvZnf1mnNjRSY10X8QU9A7zJOY/9Zz3Azq/7/so5L3JHdIqc7Tz7JADkekU+Me2hez/+IbfDfHgOd7AAnIIPcdzBa3xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907417; c=relaxed/simple;
	bh=G8pyyJo/lOYFj0uKvsMIIikr9CBjmIs+dJA5Da5IqBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHZJw/eDZrC4PII/UA8WqQgIOoAQCP0NNg3VjNmbp3oqt65DRpU48Mh1igbWg3TBhFFJ4h66yseZtJ5m3sZXKuPPWukwO8ixTVw8idmMrx/o8ZCDydcaiXlxP189k/qJkkz3v0p3OTTqQBF5qbFG9Xl1phfzHS6Gqq2QTbV4LY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfZSKN6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6B7C4CEE2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739907415;
	bh=G8pyyJo/lOYFj0uKvsMIIikr9CBjmIs+dJA5Da5IqBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OfZSKN6ZQ/s2tMl4RCx1Gp7BOeP3CipcC5QRzis32+J7bGKEpuT0fdQ0i19iLOtNG
	 UFZch7Kj6Iwg1Eh5AKPL97/hzzI/lp4jE3sOwDwMZsYM7ivAFD9z0sBzBTvn+KnQV/
	 /Yjx2acMCJ1T8v/QWJXLcDJIy2laUGb616pIuxxHqeCgatqANz2Gmk9u95wDxzkPeD
	 VfKl8sj4J8fD8rhMiPMsswkKRLlvSzJUcjbLjOlM62eKRXelfsu71SHMPur1qTztnj
	 70MHyvTOGUFCXXRHsx78OytzTXVrDO7vu9angiiIb3NUdpAySgC+ZYNubQtlZgwNaZ
	 eC0Unm6P3Pctw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5452c29bacfso4985752e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:36:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEB7bj26a+sbnCFcKRL3nWqM1Mwy+MqSl6drRRab+e+49g4IoDUA22dkjRwTvSbPTQivNUXKCZ0ize0fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpdSR/EX71QNVo3C1LuWBezux/dgQFVOscEkN3OwhRqF7wRqd8
	wyfkjMa/iKi1hrnVCKcsajqmnU/ObCmDlPpWhQGpkjbRQzRcTJevLVG55mEy/zXkaE2wT7k8AME
	DYTOf6Kln1AzRwU5lQOfFbBYqkkI=
X-Google-Smtp-Source: AGHT+IGOYECX0y3bSc9oPPqcwIyy2ZDM62L97j0oJfQY1sxzo5+1NJbyzSy/eT4G5ZWoerzrUgsTllnoutT4g5VB+CA=
X-Received: by 2002:a05:6512:3e07:b0:545:6a2:e58 with SMTP id
 2adb3069b0e04-5452fe6fb9bmr5430490e87.32.1739907413855; Tue, 18 Feb 2025
 11:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218092538.1903204-2-ardb+git@google.com> <20250218173827.vk4gplulq3pjdnn6@jpoimboe>
 <CAMj1kXHqS=fTOa13LHqs1bqxy-EeD0xNUGxJA4xK=bKya+XBwA@mail.gmail.com> <20250218183108.anuqoojsgkjxwfai@jpoimboe>
In-Reply-To: <20250218183108.anuqoojsgkjxwfai@jpoimboe>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Feb 2025 20:36:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFa==KmSseWD1WK=uHW9BOTF0fDOUX0txsMKZzHqCfE+g@mail.gmail.com>
X-Gm-Features: AWEUYZlAAQuA6Dpgne7N6_GziJ1MtccfpCLuAsY3h8i0cPhJT2SXWAF0IPZSyN4
Message-ID: <CAMj1kXFa==KmSseWD1WK=uHW9BOTF0fDOUX0txsMKZzHqCfE+g@mail.gmail.com>
Subject: Re: [PATCH] objtool: Use idiomatic section name for relocatable
 rodata under PIE
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 19:31, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Tue, Feb 18, 2025 at 06:44:23PM +0100, Ard Biesheuvel wrote:
> > > If I understand correctly, this is fixing an existing bug in loongarch
> > > and any other arches using PIE, right?
> >
> > There are no other arches using PIE as far as I know. But it indeed
> > fixes an oversight in how -fPIE is used in the kernel.
> >
> > > And it has nothing to do with
> > > objtool?
> > >
> >
> > That didn't stop you from taking the previous fix :-)
>
> The whole point of the previous fix was to fix a bug in the objtool
> annotations.  Unlike your patch, it didn't have any intended side
> effects.
>

Right, I skimmed over the missing ORC bit - I thought it was working
around a linker warning.

> > > If so, it feels like this needs to be its own patch, described as a fix.
> > >
> >
> > Fair enough. But better to drop the previous patch from the objtool tree then.
>
> I think we can do that... Peter?
>
> And just to be clear, you'll have two fixes, right?
>
>   1) Make loongarch .data.rel.ro.* actually read-only
>   2) Fix objtool C jump table annotations for clang
>

One fix is to emit .data.rel.ro input sections into .rodata, and fix
objtool accordingly so it also looks for jump tables there.

The other is to emit the BPF jump table into .data.rel.ro.c_jump_table
so that the linker does not complain about conflicting permissions.

Does that sound about right?

