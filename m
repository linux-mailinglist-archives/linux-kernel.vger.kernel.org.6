Return-Path: <linux-kernel+bounces-178331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6A8C4C03
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A995F1F239CC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85E1862A;
	Tue, 14 May 2024 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NnmN6ckR"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFB171AB
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715665340; cv=none; b=ajK32Qgn/gmiLpqt/QensYPnDKblgMRHokOng0Zs+nanSQgEJ/thAi8+yOzR6mydzX4JYLoYAI/K/m3TMQz+k5OyfPlP+li1r5ejml1Dq3CWsmL7WPnQKeG1UGdayFXLCsuGPBIMDF+l40ZJTr+OaeQF0evyxr42QFHg5wAqf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715665340; c=relaxed/simple;
	bh=NV+RKllgW4MfDzgJ3TMIxNxUBbHxwtsBD59kkdTT2P4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMHhmmsS/fI0xlOxEslIa5K4ve8ozObUbZQ0CdeVH9asUgBe4iw6TWM24rgUOXwYZUR4nmaBDfHldor5sbbiq9q/AAFH5cCieJJGujK+szw5+AcoYY+CUi7hg3eUuUjsfJRSIJ8NkDdGL6a9KMnk1ziyMj9UTRww9Hj/LNeKMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NnmN6ckR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518931f8d23so5256969e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715665336; x=1716270136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghNup/0cb2n25xmrVjov+0XGCdmbyoDz8Ij++yEdNjA=;
        b=NnmN6ckRuGATYDvFD8oNyNnEkzP3V1Y4Rnkux6ftC0kTua8FTrFHb5/JKnOY/Qpk+p
         wjwDDLKfMJ9OavQ9WFWr3+yq65tg/Y/JEjrZa9SzZR3QlG1jM/zV9MaMEchvWMVRXKse
         xrj2iCtsj57QrT6Tv08akA0cp2BSKGDSX/+Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715665336; x=1716270136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghNup/0cb2n25xmrVjov+0XGCdmbyoDz8Ij++yEdNjA=;
        b=PGcN2/2r4v4rXFllDZzgKk/rcyG1pk80Qc6Xl/RWNeWOZUT+JHH3Psj6Z+TU2WkBhl
         grSF/8yW9JciK3mcLYbscoJ1fYKpegaZWL11pMia9/AQ+raHR9TbQY8v9c/BUrJhtqhB
         fnOVXGizdbxsttAIhCZyEady0vlEPjcvUrSnjgN70R92Pm5bBLkVc9+ANlw7kdTdC1mx
         Pchp5iwEIFGOx4mxZXwNjvx6YHo+049YjVS1yWx2QHEzxruTy+XxGnb+/sSdScELu0s4
         Qtu2WR51uU5XnvDJXyw4OQLY1oUGu3jXGYjD0SuIiZQxuxR7xMNcu5j3Kp6bT/GdoOGN
         9YVg==
X-Forwarded-Encrypted: i=1; AJvYcCVY5aRGKHLzbn9ipJg5Jkl60Lu1hrtp2H6z6DdirSNrx56zcXYrsevAXPAbX3TV+Mwh3SUp/fhcI+Ty7WZDX3GuKiOhpRo+K/be4zTq
X-Gm-Message-State: AOJu0Yygwd3bPqR4J+n5gm7pp+fEHDsZPlf5obV9dsdvc9UVjI1NHnIr
	1QYkIf/5eKic6OHihdGuBots+Eugl9DuiYOJrNXtY7c0b3J6XDWPbS9+njAVMJLOMTbcRp2tmVS
	elNm9zQ==
X-Google-Smtp-Source: AGHT+IF2yVkPlmjZ1p66EllP1/1XxbUTVq7dqkACO79czRWe2uoUjmdx3twmMoP8U90Pld0LgzTK4w==
X-Received: by 2002:a05:6512:2209:b0:51b:180a:7b7c with SMTP id 2adb3069b0e04-5220fb76cebmr9584729e87.3.1715665336165;
        Mon, 13 May 2024 22:42:16 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cc7esm686618666b.19.2024.05.13.22.42.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 22:42:15 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59b49162aeso1284104366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 22:42:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMUUhttRgu9DY8QeL6ZSV3qzEH///I/mCClMzRzO84MvMSz9SkW6Bs55c2OUsvbqzmNonO3TztQWx+GWmuaInR9e4dz3Izyp47IFV5
X-Received: by 2002:a17:906:903:b0:a5a:81b1:6cab with SMTP id
 a640c23a62f3a-a5a81b1716dmr81680366b.51.1715665334991; Mon, 13 May 2024
 22:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au> <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au> <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
 <ZOxnTFhchkTvKpZV@gondor.apana.org.au> <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au>
 <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au> <ZfO6zKtvp2jSO4vF@gondor.apana.org.au>
 <ZkGN64ulwzPVvn6-@gondor.apana.org.au> <CAHk-=wjmwmWv3sDCNq8c4VHWZUtZH72tDqR=TcgfpxTegL=aZw@mail.gmail.com>
 <ZkLz31t6ZJmbsj3o@gondor.apana.org.au>
In-Reply-To: <ZkLz31t6ZJmbsj3o@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 22:41:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1T6wq1USBfU=NjdpSaTiKzV4H2gnUQfKa_mcXqOSk_w@mail.gmail.com>
Message-ID: <CAHk-=wi1T6wq1USBfU=NjdpSaTiKzV4H2gnUQfKa_mcXqOSk_w@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Update for 6.10
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Lukas Wunner <lukas@wunner.de>, "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 22:17, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Yes he did try this out:
>
> https://lore.kernel.org/all/20240302082751.GA25828@wunner.de/
>
> It resulted in an increase in total vmlinux size although I don't
> think anyone looked into the reason for it.

I think the basic issue is that the whole 'assume()' logic of "if (x)
unreachable()" is very fragile.

Basically, it *can* generate the exact code you want by basically
telling the compiler that if some condition is true, then the compiler
can jump to unreachable code, and then depending on the phase of the
moon, the compiler may get the whole "I can assume this is never
true".

BUT.

The reason I hated seeing it so much is exactly that it's basically
depending on everything going just right.

When things do *not* go right, it causes the compiler to instead
actually generate the extra code for the conditional, and actually
generate a conditional jump to something that the compiler then
decides it can do anything to, since it's unreachable.

So now you generate extra code, and generate a branch to nonsense.

> However, this patch still has two outstanding build defects which
> have not been addressed:
>
> https://lore.kernel.org/all/202404240904.Qi3nM37B-lkp@intel.com/

This one just seems to be a sanity check for "you shouldn't check
kmalloc() for ERR_PTR", so it's a validation test that then doesn't
like the new test in that 'assume()'.

And the second one:

> https://lore.kernel.org/all/202404252210.KJE6Uw1h-lkp@intel.com/

looks *very* much like the cases we've seen with clang in particular
where clang goes "this code isn't reachable, so I'll just drop
everything on the floor", and then it just becomes a fallthrough to
whatever else code happens to come next. Most of the time that's just
more (unrelated) code in the same function, but sometimes it causes
that "falls through to next function" instead, entirely randomly
depending on how the code was laid out.

> So I might end up just reverting it.

I suspect that because I removed the whole 'assume()' hackery, neither
of the above issues will now happen, and the code nwo works.

But yes, the above is *exactly* why I don't want to see that
'unreachable()' hackery.

Now, if we had some *other* way to tell the compiler "this condition
never happens", that would be fine. Some compiler builtin for
asserting some condition.

But a conditional "unreachable()" is absolutely not it.

               Linus

