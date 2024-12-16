Return-Path: <linux-kernel+bounces-447890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E87B9F3851
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CA116D12D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05BE20E717;
	Mon, 16 Dec 2024 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QI064CkY"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B920E03F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371919; cv=none; b=LTyiI6CBfYWbiNroaMS9oiwtOYpPdCMqF44kO9Q6N1UxBZQGVcGsxjTbCD5SU9Qwmglqvdn5DT57WHzy6qyxcxNwRibWYLJgDlX8XDBWtuYOyNOjvOxHqXBN8D1JXn8mA4TZk+9l7gfdnmgcxgXVuDpoEuTgjsGD6nhelNoUlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371919; c=relaxed/simple;
	bh=Tj0Fs/SZ0LdYe4bijqABYQiOrU4v7kAAQllRkbZHx8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVuZGC/A0DrQAzaAWReX5qTZufDNRpOMdx7ntC6YManOI5kDO/w3j2NO8DPzVEEJmvL7QmBPn0Z6fsCDdYrNT58cUi5czv1SuYdtdtfQ0X1gEJNdljocUsKPv8rLOXucFNZnBi6TMnjbhkE2sa2UCzig7cbYMDdURtbourvY09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QI064CkY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467896541e1so7021cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371916; x=1734976716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tj0Fs/SZ0LdYe4bijqABYQiOrU4v7kAAQllRkbZHx8g=;
        b=QI064CkYfuulf880aC0rqJFHI1yxYXnD1F6ALr8gtZc/wZYQW3d1fKmXqWKTZLvZS7
         wDiNZDU6fZLZPOAybkb3tYINHHG//ANd07NoUlCBuLgmT8WQoczxHqmWQ7ToM1LuUV5/
         YNwcVwRmToOzR7FkX7AYfNFkZ3dwu2l2ufV+jruc67zwaQ3Rs9keTdw1TWIbxrn9lkdY
         pbOcUiUCiM6dDW7b8O/xHoXHPRt4t6JpPPR6Ncc7beA2qykFvTVcKxe/KgWbHQszFi7X
         Jh9kkFC1EJ5sB+FqmadK4ETW3egDfzqBRdUj81Kc4b7D/cMI1PAH8DNQZIPlxUtHfBI+
         tmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371916; x=1734976716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tj0Fs/SZ0LdYe4bijqABYQiOrU4v7kAAQllRkbZHx8g=;
        b=EUFit86G5qqD5wwAi4zPKDk54fuXWgeV6pUcE2NdXm3gqbTPVwbI9VjFt7f82VET5a
         wIzMPy4fYKo663XLhTe/4RpRadnzTdyntV6Gk1pGus7at2Y6QJNWTCvYnmJIvAhC55Xt
         jQpSjwBE2ItPWFXiEsmut2w2r9i2s9F3i2oJO0R6WWAOfdvE00pSGO8epPCfiUWx3tk+
         T3Fxjpqbv7BH2qVooMlsGNY8pDeadc8Dkyb7PDZm5HQras7ewoLotOgyUsxcnoC6nLVY
         T/KufnrDFYCkywtt+NvoH/NBzRYwncxnITJRbBKCAJmtL+K3mhtOr9XMQxxeT9THqr1J
         +75A==
X-Forwarded-Encrypted: i=1; AJvYcCW4fNQJCyrhRTxrhxTvZaYIjKcs+lEYM13y/9Zp03Ugsb1640IrPP45tX+Yi1knx3KUZJOXa8FPH3aLc7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhq3Z334g2JiPARWN6+1OuPnmHuP2Q1qhcn0HQ/J6sBKUR7yEU
	yP4kmz1drRHiuQF7FUVtz2w2sLdbai3xGQ5DiBeR3foIFhgsmlXd/BjXm2EdIxUuuzwDb9mp539
	ptCE2KsoKul8Sy0kKQsft7mQY0/XIJjtzhiJP
X-Gm-Gg: ASbGncufTjZ6L3lPN7HXGivWbmf54rN4tNsAl6v/G3l6siPrvdFN/f61oEK5KwYRpre
	tWVXZ1w+5kbPpVC0xlqDXyB38oAjmZe3KJ+EGebLREk/vB24fljSJoM7irqMaok5pijGr
X-Google-Smtp-Source: AGHT+IFekFYYD6IdXMk+zakuU02lMxecxZ/HgX8Res1s/0Gqq9iULJ7g+kDWuvlQtsch8RjuiCMw7JleqzoFJAox6+Q=
X-Received: by 2002:a05:622a:550:b0:466:8e4d:e981 with SMTP id
 d75a77b69052e-467b48c562dmr8286291cf.3.1734371915660; Mon, 16 Dec 2024
 09:58:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-force-cpu-bug-v1-1-2aa31c6c1ccf@google.com> <20241216171700.GIZ2BgjPerQ8jQlq8S@fat_crate.local>
In-Reply-To: <20241216171700.GIZ2BgjPerQ8jQlq8S@fat_crate.local>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 16 Dec 2024 18:58:24 +0100
X-Gm-Features: AbW1kvaK3B5lvRqsgND-co29rPEZBo1aRssvLsJTm1GqlpHREhU8ZVp3DET3-dI
Message-ID: <CA+i-1C1HeLfbGg=LdXBYuhXWVPn1O0qtEYxFRYaXPUch4goEtA@mail.gmail.com>
Subject: Re: [PATCH] x86/bugs: Add force_cpu_bug= cmdline param
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 18:17, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Nov 19, 2024 at 06:43:57PM +0000, Brendan Jackman wrote:
> > Sometimes it can be very useful to run CPU vulnerability mitigations on
> > systems where they aren't known to mitigate any real-world
> > vulnerabilities. This can be handy for mundane reasons like "I wanna
> > debug this on the machine that quickly", but also for research reasons:
> > while some mitigations are focussed on individual vulns and uarches,
>
> Unknown word [focussed] in commit message.
> Suggestions: ['focused', 'focuses', 'cussed', 'fussed', 'foxed', "focus's", 'flossed', 'coursed', 'focus', 'fused', 'cursed', 'fessed', 'refocused', "ficus's"]
>
> Spellchecker pls.
>
> > others are fairly general, and it's strategically useful to have an idea
> > how they'd perform on systems where we don't currently need them.
>
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
>
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
>
> Also, see section "Changelog" in
> Documentation/process/maintainer-tip.rst
>
> Bottom line is: personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them
> please.
>
> Also check your comments in the code pls.

Ack.

> > As evidence for this being useful, a flag specifically for Retbleed was
> > added in commit 5c9a92dec323 ("x86/bugs: Add retbleed=force").
> >
> > It's a bit unfortunate that we have to do this by bug instead of by
> > mitigation. However, we don't have clear identifiers for the mitigations
> > that we do, so I don't think it's practical to do better here than "you
> > can pretend you're on a vulnerable CPU - now go and read the docs for
> > the per-vuln cmdline params to figure out how to run the mitigation you
> > want".
> >
> > Being an early_param() means we get to do this before identify_cpu() and
> > cpu_select_mitigations(). But it's possible there's still other types of
> > bugs that get setup earlier and might miss this override...
> >
> > I've only tested this by booting a QEMU guest and checking /proc/cpuinfo.
>
> Right, I don't mind this - question is, how do we make it such that people do
> not use it in production and then come complaining to us why their CPU is
> affected.
>
> Yeah, sure, they better know what they're doing but I've seen pretty evil
> perversions so far and us giving them enough rope just to shoot themselves is
> fine.
>
> What I don't think is fine is for *us* to shoot ourselves in the foot
> by giving the users such a thing.
>
> Btw, there's a clearcpuid= cmdline option which has the same potential and
> that thing taints the kernel. Yours should probably do the same.

OK yeah, tainting definitely makes sense, I think that goes quite a
long way to avoid bogus bug reports? I will also update the docs to
sound scarier.

> And it probably should be called "setcpuid=" as a counterpart to what we have
> now...

So do you think we should allow setting arbitrary cpu features? That
seems like a much bigger footgun. But then again, the difference
between "big footgun" and "very big footgun" is not that important,
either way it needs to be clear to users that this is a scary red
button.

