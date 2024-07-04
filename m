Return-Path: <linux-kernel+bounces-241589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F43927CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A7DB2150B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4366DD0D;
	Thu,  4 Jul 2024 18:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TXv+9XZc"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65A46447
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117138; cv=none; b=Nq6XkVV8cY/HZuidxOlf2kF2VsuTw1qnufklZUHAOAu95PBDPkPsRj18lfSTF/po3wWLP8EbcJps8qaj9tPCs9Mh3T1WVjg0p4sFxTCxeevI2GgNjvsF5XkvN7nsYJ/zkIPEqbNN6AqGfILAYb0bKPzbT83//Zgh2p3w4iLuPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117138; c=relaxed/simple;
	bh=Jqk5AHHKAZBRsZ84VySQ8SKhY3vVvvQTU67u5VgKl9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBTHsUseyVYK8HEQNuMVcvIc/axZei+wABHS2mVvT0/3HGyYbz5Dulz/PYO+WnBo50BL0wjyfDNx1LBeb9fcLI81FpLsJZho/rHRi0kg/0ubKoeK6c1VyjKihnp6dnwba5X0swEvqAyg4ODZmwgQE3SSGrB8W4goHNpb2V+uxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TXv+9XZc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77c349bb81so45163666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720117134; x=1720721934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/u/21+exbv8kr2CIBigcyw4XXMdj7U9g8Cet7QwWi8c=;
        b=TXv+9XZcktWvSuBS+cXwyPYEszynipLoSg1KGJnNpZaCWqxiHtQJqwbMtU3K6f9H0K
         FoEnYP0EU0tiZnO3a2v0C66n491KomLpGLbJfd6/hqc145lXvbkx8kx+IHsdz9r6tJxU
         ENU1Lt4XMw5Tpq4ZglBctnbV3OpOd0E0LuUBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720117134; x=1720721934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/u/21+exbv8kr2CIBigcyw4XXMdj7U9g8Cet7QwWi8c=;
        b=CJuhikK7QVQ3MfGo9keFWsHPVMjpWezRxrsvlEXuFoijrLh7Yf6GEC632BDPp50hgP
         8PAbGlW3lEvPEI8QiKR7TTGG9Gucxb0T4pYdDkSlXlgXUGujR2Ip71u72c5ijrDbVhKq
         n50soWxyXuZr5Eo81mndNXHY3Q81wEfj1YPciIoxlrBjOq9LEn9/lvgu7zGq3cxfaq2c
         sGtMgxhhlG8e6MUGNSYNxnwKpd+luCrsd7fMEuKPRrCRGtZxnJ2Cb2/SKWeXtIFvWqYH
         6JHX/jRy+JqxfT1c2Clef6ezqnO1XAC37YmvxPU4q0fFFlohgpGADhCL/rKvZWwIjwSy
         RBUg==
X-Forwarded-Encrypted: i=1; AJvYcCXm5Pm5eXj6t2s0SUligVcoMDbLqt4VmZEsRmOLyKJh4agoHnx8idVRXjUhH1GIHMn43La91RIaOambesfsym+bMfNSo5txhqeIUkyr
X-Gm-Message-State: AOJu0YwpskOA1Z0g0IPwXrPzASzUO4JQEOMYvY1euWryuuYJW39TzcX8
	2YEMaBtsLHPBi3V7f3GDd8EH4wTCsQa/nnBr/Cgj+LNB3tXC/NcHBsXnxmysaWsOkpX8YF6gcya
	dG7hXOg==
X-Google-Smtp-Source: AGHT+IH3PM7YkDjdqU2omq1uo5ZEP23GbR5WHn2x6F3PJh4K0wdGJeD1tFTIKF9AdYOwv8BzQyOkLw==
X-Received: by 2002:a17:906:5293:b0:a77:b054:ba7d with SMTP id a640c23a62f3a-a77ba48eb17mr156345466b.46.1720117134296;
        Thu, 04 Jul 2024 11:18:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf60447sm612677966b.59.2024.07.04.11.18.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 11:18:53 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77b4387302so115587166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:18:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXP4xJUxPiQzOj+rXLBFc3d1kYigzXqRggrk8d1IBKIJSl5vfYckjKf5RaoHZxpeTQl6s8x6a/vLt9GNcqGfkArr0MUMb0XJf6ShZye
X-Received: by 2002:a17:907:97c8:b0:a72:8c15:c73e with SMTP id
 a640c23a62f3a-a77ba7099dbmr171178966b.55.1720117132936; Thu, 04 Jul 2024
 11:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZobXdDCYBi8OM-Fo@zx2c4.com> <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <Zobf3fZOuvOJOGPN@zx2c4.com> <CAHk-=whf2Pb8fSmUsLRSn6CnYvQoyUkLikKpFDWN_xnTJqix=A@mail.gmail.com>
 <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
In-Reply-To: <CAHmME9pm+ZE2_qf1DNxukB6ufPrjTAsnwin05-VX_gS03Yq-ag@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jul 2024 11:18:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
Message-ID: <CAHk-=whTjdO6szgRKp51ZeDLDmA1+YYSbg+vEUt9OsxTMDUtjQ@mail.gmail.com>
Subject: Re: deconflicting new syscall numbers for 6.11
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: jolsa@kernel.org, mhiramat@kernel.org, cgzones@googlemail.com, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jul 2024 at 11:04, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> >
> > I want to hear *from* those users. Because I would have expected all
> > those users to already have perfectly working setups in place already.
>
> What do you want me to do here?

You literally said "those users exist".

Make them pipe up.

Make them explain why what they don't have now doesn't work. What this
solves. In real terms.

Make them explain why that random "we duplicated the VM, and now we
worry that mixing in TSC doesn't help" is an actual real-world
concern, rather than something COMPLETELY MADE UP BY RANDOM NUMBER
PEOPLE.

See what my argument is? My argument is literally that theoretical
random number people will make up arguments that aren't actually
relevant in real life.

Do real people migrate VMs? Hell yes they do. Do they care about the
numbers being magically "stale" after said migration? I seriously
doubt that.

Do real people start multiple VMs from one single starting image?
Again, hell yes they do.

But do they start those multiple VMs from some random slapdash
snapshot that they just picked without any concern and cannot just
reseed in user space? And if they do, why should *WE* clean up after
their mindbogglingly stupid setup?

See what my argument is? I suspect _strongly_ that this is all
completely over-engineered based on theoretical grounds that aren't
actually practical grounds.

And dammit, I'm asking for the practical grounds. For the actual users.

And if you have trouble finding those, you just proved my point.

           Linus

