Return-Path: <linux-kernel+bounces-562920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29297A634B2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 09:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A7116E240
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 08:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5FC199FA4;
	Sun, 16 Mar 2025 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQAqQfHq"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91EA937
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742113741; cv=none; b=UJQ5awivNCL/969peI5iXKAJKXZQpiruCTH42BCoWP6bp4Ax+FwmKoVbzY3h5UK1TQU/BT0PXGzS2WzPVyIeQxLxtwkw78C/NuB4awvE/w7c4lLRbAVGrntn73k0fbEgU0kq7Mtg4x6ITcCrt3XM+8PHZfrCKGJrWvgM80CJoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742113741; c=relaxed/simple;
	bh=hKq+x4v1vav1ivExe/fQew/Nnfonc+W+e2Y5jDHc92s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdkqUYbApby7fbfGpp4tlnYe/1C0XbvVdb8M5h31NGvimeb0O4VWCWjRN1Xsh80dG7asbC/J9Z8hx6ZQwxbp3AuUwYFQ0TXfJ0Y4rM6yq7X8hKkPxXQhwovBC62RxiNeKa10ZLNnlAXA6Q8GaJmUCZi0YdYYxRNmzfXoa3bgTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQAqQfHq; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30c05fd126cso32920971fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742113738; x=1742718538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIZQbPcexVvBojT8YTCfGtYY1VAlpntzAPCe6NkzrRE=;
        b=OQAqQfHq8MdKq9XWo9OzWGunwsPz3v00AndrQT1/izli7uh5bP8djbblnd79nMmli5
         Mm4LynMgwshoor88Lb3hBAatXOEWFXtd8GhN25aV8WjaNMwBbFvLcOu53w7MQ7TDaQki
         BxjwcsUoRE4DgnXPnm8IFMti7SrK2+NFS04tdCbqoCtKkIFewKOCYfE+6MgvVv1fSWdh
         xFOoQyH3GzPx/9PyizfBlnULRKa7e1QMTtMdARYFW0OLLMWzw4OH+lprHDZM/VB8FWlG
         /Ip3lKO6t0iY9D59hAG76LfiUEFWGrVkdFduauJ/sUIAiiRHVQLdLFEtM7PpXWQGV4kv
         u9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742113738; x=1742718538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIZQbPcexVvBojT8YTCfGtYY1VAlpntzAPCe6NkzrRE=;
        b=w8CUNOQX6+cswCYAi6O+3UZrEpMHc4XgMkTKhnEn+ikdpTZjZU3FN6VJRuLBoZjjGj
         8sFrUiM95n5jG6bbm7gCbfDgMBx2eITKvYXgXBVopkqpzOo+KLfAedQPCbIPKj9MgQJ1
         kfBUy91Mo7WFfO0cv7UYV8dJlXSW1YWRQ+T80AdDBqZuA8ADlwOagpU+8t9wqo6Hj5CZ
         rXuqF0v7z5RyFzCPkn/tvAytW3gmm4hSSGGBeEduXaOrn7agZbXYHCzZYuoaMy0V3XSa
         9XZhcsIqNWCvLr3mxDv4lSU/RMsYe8lLgQdX7yD4WaV/MCuQ0rwF3qXWw4jy+m0KRX4S
         9YNg==
X-Forwarded-Encrypted: i=1; AJvYcCUJOlkwUQ7DxW/iWpXm0SaIkEpRuHALn+0KNa00UhYM8ogH8BzwSUbjO5PMdRE83D6nsJJMhC7fWUyAlpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcNPP6Jsh8cHKao+yiTERluCHskt2IkD1Ti8Ij1AVSe/StKoo
	KTdZ4xLe6eaKQGZvgE7b+ytPP/vH1Z8V4mLN1BdqLWZRQ9Vu8ppMpMxnYymQdcTUPeUPLwAbcpC
	uwFPQeO/TDLkL+Riry41n/nlIGlw=
X-Gm-Gg: ASbGncuEcVA9uSVeVt1UGG25HthR8HnKs166bdgsuZoDRPjhoI26ioZzZa4mtDcp3RJ
	oi0zqDVfz8U2dloqRlHFAjetBCC3UvxYlrIEwg7PWhOvLqcMTLw/OrxgkrSjPRqPl8CJc302tLK
	2W9aPToMzVgH5aSkqs6P4g1nLxcQ==
X-Google-Smtp-Source: AGHT+IFdwjZqCm2sCMY/k3IL7LluYqZ2yTMx/Ut7uhZ6chnHoW5eJmN3Vjni7pzHJvh0FA6icgWt2m1aji/LrswaGmM=
X-Received: by 2002:a05:651c:b06:b0:308:e5e8:9d4c with SMTP id
 38308e7fff4ca-30c4a8d9084mr31414571fa.28.1742113737494; Sun, 16 Mar 2025
 01:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202503161004.ZmMcxxeB-lkp@intel.com>
In-Reply-To: <202503161004.ZmMcxxeB-lkp@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sun, 16 Mar 2025 09:28:51 +0100
X-Gm-Features: AQ5f1Josv-P203gDTLctoTjqQY4gg7qjJdoXoDgghTVv76G5CY2BxWQ9DsMee-I
Message-ID: <CAFULd4ZX5NvpmvrtSQzz=iBQ20AGZqR2PSMZP4p7PrzE4qNJyA@mail.gmail.com>
Subject: Re: [tip:x86/asm 3/7] lib/test_bitmap.c:1269:2: error: call to
 '__compiletime_assert_279' declared with 'error' attribute: BUILD_BUG_ON
 failed: !__builtin_constant_p(res)
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 3:52=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/a=
sm
> head:   9628d19e91f1ef9e7b1321e74a88bfa646d2a8d3
> commit: 01ba23bf1b3f9a4035faedc2aa450e251bcc2c7c [3/7] x86/hweight: Use A=
SM_CALL_CONSTRAINT in inline asm()
> config: x86_64-buildonly-randconfig-003-20250316 (https://download.01.org=
/0day-ci/archive/20250316/202503161004.ZmMcxxeB-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd70=
8029e0b2869e80abe31ddb175f7c35361f90)
> rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250316/202503161004.ZmMcxxeB-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503161004.ZmMcxxeB-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> lib/test_bitmap.c:1269:2: error: call to '__compiletime_assert_279' de=
clared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(r=
es)
>     1269 |         BUILD_BUG_ON(!__builtin_constant_p(res));

I fail to see how the referred patch can cause an error in:

/* !(BIT(31) & BIT(18)) =3D=3D 1 */
res =3D !test_bit(18, &bitopvar);
BUILD_BUG_ON(!__builtin_constant_p(res));
BUILD_BUG_ON(!res);

Otherwise, the patch fixes a correctness issue, so there is nothing to
do with the patch anyway.

Uros.

