Return-Path: <linux-kernel+bounces-226377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65DD913D85
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE25A1C20F91
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E578F1836F5;
	Sun, 23 Jun 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LDHEO5kM"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083E2AD22
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719166079; cv=none; b=CoTPdfWVcotCdSN652Mz+ATi4K9rMuksZEPQTxZxBJW1oEC/x47FqCcSpLPuGBKprz/XQR10SMtjShMFRsXBPcYt11s2qEP6hJCqEofCk6JuL5GRovemL4ydvpeFajJsXtafMd6v+P3v3Ii0zRdZNqlhL6bcu+Tsa0mycjIquDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719166079; c=relaxed/simple;
	bh=gN5gx/2bgxPc7Ha4uj6zKWoJM3HzTcGze3wrKsRZO74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE1L+2Zc2gYpSAugZqb18r/Bi+f/rX6ICqYrtfBPtb1BXFIBcZjlgp3d2CTNBKKLuITl2rJL1zxpQHq8X3kgGZIVkcXyEGqI342sOq+evnlxo6wcyxsvmwJgaAfaa5jHy04Azj1GoGdgGdPa/va2vLeW7fVsY4JUGDsb6dM1Mnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LDHEO5kM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a72585032f1so2013466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719166075; x=1719770875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2q/oGp1Uj11i8ttCrYoX4CQ1yZ9C29tZG3LwII1sKnc=;
        b=LDHEO5kMbXw9jZziqvkoj9OBR/z5m91IdNeYZASyTbm42lQqLPTb3NAU6eHp4prAln
         DvLkZz5zd3QKXz9eUOryezP+Lw3uG5kh3tJcKvIF2OHlui+gHc/iZQ8WWVy+hcNvOwMP
         2CqQlrAUbP0t1gALf32yiIknknu4vrjsjS8kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719166075; x=1719770875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2q/oGp1Uj11i8ttCrYoX4CQ1yZ9C29tZG3LwII1sKnc=;
        b=cUNNFLd/2XmXS2xgaWgkImN7S0DGc7Dk8/TQWbhmEaC/wqw4kg93qXKBREEZhyWRYo
         W0wgEkEW3O3Kqc5HUVVYxpHsnZpYD7AyrMjYju/Yw7fKKNsZasbqf6Cu+L1g7eL/3MC8
         S1SOqqRecLhhODyItEzLiI28DPyO47EOmDezCDMT2ePw1o0TiuWubMRwcjHeOgZ5vUOZ
         /VEVTcBS4Wo0Lj9yrHaibeF1Ie1x5/JawudAbOJMfKB85qXo19MubS4uAwWjc4w3gzsA
         MzBPtM57u3hy/pPeplQYfuvH0FZbcT8GdQTbN7aV2TyFWJNyY1xAjq31O8T+4J1GiiKR
         sZHg==
X-Forwarded-Encrypted: i=1; AJvYcCW8dMDzIKFJhP0tutMPkcPqcFfheK+WteRPM/KacJ4P4HgcGa0PSkhK2Mtqp2Vf8F+P96GP1LqGFV8fH9O0prOcWk1T9lkdGhZu5Xih
X-Gm-Message-State: AOJu0YyCIj6Ef3GxaYGvOceo7fb2plHyh8wJWsD9zbsWA9V+eVNzasc5
	/pjD2Vd4njyZ9EiLAsPs0uSMt3QORrTFeNNid2A8g4Vg+0vxIsleXYlKmEEm7C9ab23C95ZEzsC
	jcvNhvQ==
X-Google-Smtp-Source: AGHT+IEh+12QSMBQFZbwUrDD3mArevMZjbzqM4GJPF3dMC4MDAJ5PjmOQ+Jz2udj77P4B3WTtwMU9w==
X-Received: by 2002:a17:906:eb09:b0:a6f:c886:b68b with SMTP id a640c23a62f3a-a715f9799e0mr177469566b.43.1719166075450;
        Sun, 23 Jun 2024 11:07:55 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe30e6a1esm211580566b.216.2024.06.23.11.07.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 11:07:54 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a72585032f1so2011566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:07:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjdiAR3l9f6H2w7GkSFztPf/Z2ge/b+OxBCi9tWrC3Lkqvd9jFC/qMbzt2OaKzaJz8YsiIkFluGnB0j3Kl0shkQWA0Z/SGQ2prLU8X
X-Received: by 2002:a17:906:318e:b0:a6f:5adc:6533 with SMTP id
 a640c23a62f3a-a715f9795femr222604566b.46.1719166074441; Sun, 23 Jun 2024
 11:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com> <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
In-Reply-To: <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 14:07:37 -0400
X-Gmail-Original-Message-ID: <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
Message-ID: <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 13:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, from having looked a bit at this, I can point you to the
> differences introduced by having to have the emulation fallback.

Ahh.

Itr does all the same things *and* it has

    "S" (_ptr)

as an added register pressure, because if we take the "call
cmpxchg8b_emu", we need the address in a fixed place.

I don't see any immediately obvious workaround.

              Linus

