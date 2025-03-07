Return-Path: <linux-kernel+bounces-550728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97976A56358
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05B716D917
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7C61FC7CB;
	Fri,  7 Mar 2025 09:15:05 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2991EA7E5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338905; cv=none; b=jr65NxCYBIM8COPhNQkdr4zrrnFib6QuNvZUpaRlFj4sSkzaRnjN7xnAUFjvCdwWfI9Q86+K8tBtl8nr3SKDBsJA+C4aIiOvYjWUHOtj+f2sYQ/LBTxcAwMgiZ/OYcSixZxzLDvb1bfQUjEGZ6oG6NUlgDf5QzmiW0oRl3XAoPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338905; c=relaxed/simple;
	bh=Y5kT83QJ+WlQlrSP5dZssrgly7QmlCclPhOhD/NKs9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjX+oo5ogbw7TGn+zatnrs+Cx4NcbXwvm8r/Afa7xZlLJIJk33ErvQo2Gn/qUCzaiUUOmdVAUsOB6US9j8+sjldRRJ1MUtJ72i9P+1tiWQy/tliY/67ZTxnjJyfY3xvOAv5quIJ8XQ6DVazGVAs3x+oW7UdzM6QL/fvHDw/mLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so1262175241.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338901; x=1741943701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBkwdF91V4OIV9kICComuaEE3SZsHnTdUC0XzzdSHBU=;
        b=UoyKanOJVdEP67SxD1vXgQMC22RDX93HC+pV500W7KB8Z0QhGpgMRJ8QEO7Ci/aog3
         rnMbot+q59wxH8hXgjiiLGrhSgu5FFaF6Nns4d/1u5K1kZMNzdC4AgvaIB+f79uo/uZa
         joUNBq6/9HiBnH1PZlZrVPPJBy0A8v/ZtatAK07yH2tmJwySr/0SdOSNexZ7aML9p+Ti
         QvElCMsrvCepBY0p0KWPnjlPkMoXRzYHxz6IwktpZgPEvUgpfvx5IbBlyk/lPI43fLlf
         nfRkT2nxs7tcdCBgpwcyt5OYEggDAttnwejQHv4qJJZ4UrvSJ+W1gFG2Sv8Zf2pGNi/U
         0iXA==
X-Gm-Message-State: AOJu0Yyb4XPEjs3makYtLxXb2pN5SpkswiMazC4uINSxvZRvpc3+nFyL
	zkKz1nnJOFKXIgL8KrQZvBcpEkafSj9WAYEilEBhPQCuulErEien3ypnTLY6YjI=
X-Gm-Gg: ASbGncuuRCjhjco1S8jW8jSR4NaQulbd1WZxRqUO8VnnPxex1X/e50Pf2Oy5BK00nAG
	IP2jdQNkW5wFFQRgWL80CYgrkoYDBi/V8baM1P3puRQ7/+jApy2Y/gFZQ03IWnV2AimUf+gegpQ
	jZajba9a4Ax4jlGe4WQXxdiQ8AfXU1c62j2G0r2YUE5GM/ibdQzk/XHjMBH96jpQ/iaCHBWuhJz
	eau//K+k9WypckznT4iNVsWzf1JwCDxi+sw3JBCE8Cof/myLm46MZ0ck0ZGswwJ9qVHmM6VOK99
	vnM7+V0G16B4BMxQ6PzWZHDMHZ5fTyMx93AdsdyUioHkN9jFNtr+Fzs9k7jhZTuUbbouOOgjxz3
	syA7u5t0hOnM=
X-Google-Smtp-Source: AGHT+IG9a3zlWcY5IBHUeS2HgYbSAU3acf85aUKVQIGLTew0kUBb4rdH8ndBAbhiNEHzvUwwxKRVJQ==
X-Received: by 2002:a05:6102:578f:b0:4bb:dc3c:1b47 with SMTP id ada2fe7eead31-4c30a621eddmr1404773137.14.1741338901292;
        Fri, 07 Mar 2025 01:15:01 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bfe426sm592434241.19.2025.03.07.01.15.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:15:00 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52384afabdeso1623260e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:15:00 -0800 (PST)
X-Received: by 2002:a05:6102:578f:b0:4c1:9526:a636 with SMTP id
 ada2fe7eead31-4c30a63e871mr1455090137.15.1741338900354; Fri, 07 Mar 2025
 01:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com> <20250224173010.219024-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250224173010.219024-7-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 10:14:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXP1=7YJzYp=_WJsqx2mtBYcwAjpOGK2_9SH+r4w6v2Ug@mail.gmail.com>
X-Gm-Features: AQ5f1Jp8ZJjTofnmcyqY64fACoeT3uwt6h8WHhG0s4MZHk-Rm0G-RWuLPoGldz0
Message-ID: <CAMuHMdXP1=7YJzYp=_WJsqx2mtBYcwAjpOGK2_9SH+r4w6v2Ug@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] auxdisplay: hd44780: Call charlcd_alloc() from hd44780_common_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Willy Tarreau <willy@haproxy.com>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thanks for your patch!

On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> HD44780 APIs are operate on struct charlcd object. Moreover, the current users

s/are/all/
s/object/objects/

> always call charlcd_alloc() and hd44780_common_alloc(). Make the latter call
> the former, so eliminate the additional allocation, make it consistent with

either s/make/making/, or s/make/to make/

> the rest of API and avoid duplication.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As the code looks correct to me:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/auxdisplay/hd44780_common.c
> +++ b/drivers/auxdisplay/hd44780_common.c
> @@ -351,24 +351,26 @@ int hd44780_common_redefine_char(struct charlcd *lcd, char *esc)
>  }
>  EXPORT_SYMBOL_GPL(hd44780_common_redefine_char);
>
> -struct hd44780_common *hd44780_common_alloc(void)
> +struct charlcd *hd44780_common_alloc(void)
>  {
>         struct hd44780_common *hd;
> +       struct charlcd *lcd;
>
> -       hd = kzalloc(sizeof(*hd), GFP_KERNEL);
> -       if (!hd)
> +       lcd = charlcd_alloc(sizeof(*hd));
> +       if (!lcd)
>                 return NULL;
>
> +       hd = lcd->drvdata;
>         hd->ifwidth = 8;
>         hd->bwidth = DEFAULT_LCD_BWIDTH;
>         hd->hwidth = DEFAULT_LCD_HWIDTH;
> -       return hd;
> +       return lcd;
>  }
>  EXPORT_SYMBOL_GPL(hd44780_common_alloc);

While I like the general idea, there are two things in the API I do
not like:
  1. The function is called "hd44780_common_alloc()", but returns
     a pointer to a different struct type than the name suggests,
  2. The real "struct hd44780_common" must be obtained by the caller
     from charlcd.drvdata, which is of type "void *", i.e. unsafe.

What about changing it to e.g.?

    struct hd44780_common *hd44780_common_alloc(struct charlcd **lcd)

so you can return pointers to both structs?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

