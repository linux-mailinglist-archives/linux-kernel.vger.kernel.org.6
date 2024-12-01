Return-Path: <linux-kernel+bounces-426749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DAE9DF746
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 23:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAE41627AA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04061D88B1;
	Sun,  1 Dec 2024 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BT7midV6"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E0134A8
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733092098; cv=none; b=o1bC/eDQgEM9UFX6N8LoaN0yGvgEEjIQecMvnaMjLAUlsYNgzsdVlgkHIAJEX5aKB44NeM4xrVaK8kvqZ7KbZBmwUj+6+sV1mg9nf2zT8stv+Es8SCrrmRwwXzCKtTOlFRQVX/hflMWP1C292ovLrbNTGmTge8Gpa+he1hiX6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733092098; c=relaxed/simple;
	bh=HVHjqd5ArMInsTlzeAE1K8Fc/fXUnl5xq9dembC7XP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+YLehPd33ClTjnZidjeihi9Vvzjwr58AXTkaOIXGZeGPhowkVT13AWQGzJWi1cNcJHbaOEviiO2UNkxpJUs4DWIrpeSdO8SrHNWjYhdFdgHkebAwUBjoywiMWtuinL7QNG63DCj3GFzGUcq2yQq2sduOky9uWVFbukeTtJtbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BT7midV6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ceb03aaddeso4604564a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 14:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733092094; x=1733696894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pueL5vLC1i3O7SsGqxmJ3wHWCUirMgwN+qZMp3Xlvs4=;
        b=BT7midV6O9+b7clZ902zMMqkcm/EKkCr2iuHVVD9ah/hTBZXDrZf+DHlfAI/DVnQ4X
         QKUXG9KA2nwvbrEb3w9giLBrbU+7Ie+mG7oqE3xezPwloRCWSi6SWc0gqdR28Nn8EC1H
         xN3M/gD25GxZ936HHpR66lHPchYFbo5aBZWag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733092094; x=1733696894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pueL5vLC1i3O7SsGqxmJ3wHWCUirMgwN+qZMp3Xlvs4=;
        b=Z7SMtu9stlazqVTExRy7ddMz0ba6Uze3KcOzROMIF9ZsylP/16Ug3idWY6LWMy8VXE
         SgnfFKx8eWHGE+hWLm0D4KxWUEZ1TTjZ2zSUoVqqQq0B3GVFUx3dwiSpqtf0/3g7+V0U
         nDXid9hDaqjFLj9g4kaBwtZ5BX6z3J+4eGbd6Pq02RjicrtCF0yHv7dNPol31o3+Bykj
         xj0so1aBmiUDNVOowRt5YYIpbucDnUoi78sXlRxu7qK+yVTIUM7TFhtMixMXnWMNSvaH
         X8cDr7I+zQ/pCLizTdS1vY+qvB+9+pr8GgtszKea4/Qxrdez45Pmnr67IiLsJsy8kL//
         TF3A==
X-Forwarded-Encrypted: i=1; AJvYcCXaKu4wx0XCHXB7bd9tzubxbeHl7Kkw19bGvcbntwJdr0hx+R+XneC8M/mTdszqLl/Om7O2BAVkC4mYQag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51X4UFQpZvblPpWB8onnvHJGSWzddjWNFXodzkAc3760iRsAb
	c3dk0MWd3jwSmG528bshcxDONGdhtr608bLG8hVO/cupQJSxXj/0FQI5jFtSxm/hdBwMOYHgwHR
	tXyaVWw==
X-Gm-Gg: ASbGncuC7pp83g7OERdTRRGHM+QhauoRgmJhtfyF1zIzFn7A1qCRfBX1MaYGOfbJrDw
	lwFmf2JR6tSFyvlQmdZCEJvy03jX5v0w/Oav7iCTizO+HuENwoR9PTNhYOOqATTviie54JTO18W
	wzs13yJZ0/3B3wqpXA6kEczAhGNSQsO48EmI6+WoRo/8Wo0T2cwzMTJmNQkLUAzcsiUJ/5v8hEp
	NzsDYRE4za5aUKCK4RJ1+QeANyGm5P+e16Swy2cge58/w4c1rSzJ9OhX83YZ3bJr7stCMMoQWcg
	KQHat6WnkWshSfqquWEVAPg=
X-Google-Smtp-Source: AGHT+IFFSkvBheOgLLp3wLPlC9tWv/fq1ZmtX5/stC4b3OK0nZpsZjjjWzIJ3giNhopO63ESj1ZUMA==
X-Received: by 2002:a05:6402:3484:b0:5cf:5ff9:2a24 with SMTP id 4fb4d7f45d1cf-5d080c68f70mr21465145a12.32.1733092094267;
        Sun, 01 Dec 2024 14:28:14 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd617asm4274659a12.42.2024.12.01.14.28.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 14:28:12 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso543536766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 14:28:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQlRe0bzKBIp90vIwM9Vf01QMhT8VuWWlOxznIuBc885tHsr3RcSJEVW1YvBXS7cSw5cyIKKgZELwUdE0=@vger.kernel.org
X-Received: by 2002:a17:906:23e1:b0:aa4:9ab1:19d5 with SMTP id
 a640c23a62f3a-aa58102abc1mr1635001466b.42.1733092091729; Sun, 01 Dec 2024
 14:28:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e654a20c9045487eaacbd256f584ce45@AcuMS.aculab.com>
 <CAHk-=wiG7dGtE6UsynOP3FuvApkh=FYrv1Q42DEVZmosuOFXnQ@mail.gmail.com> <b853710c4cb94ec0bf869edb41a685b6@AcuMS.aculab.com>
In-Reply-To: <b853710c4cb94ec0bf869edb41a685b6@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 1 Dec 2024 14:27:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wirneQCq0uMkQbudTKK4Gm-AjzvuZNkxhCaNfu0jw=aLw@mail.gmail.com>
Message-ID: <CAHk-=wirneQCq0uMkQbudTKK4Gm-AjzvuZNkxhCaNfu0jw=aLw@mail.gmail.com>
Subject: Re: [PATCH next] x86: mask_user_address() return base of guard page
 for kernel addresses
To: David Laight <David.Laight@aculab.com>
Cc: "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Dec 2024 at 14:24, David Laight <David.Laight@aculab.com> wrote:
>
> OTOH AMD have is as '4 per clock' (the same as mov) so could be
> a 'mov' with the write disabled' (but I'm not sure how that
> would work if 'mov' is a register rename).

It could work exactly by just predicting it one way or the other.

That's my point.

I don't think / hope anybody does it, but it's a particularly easy
mistake to do.

             Linus

