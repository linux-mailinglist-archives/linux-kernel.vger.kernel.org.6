Return-Path: <linux-kernel+bounces-214418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4E908423
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52820B211D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EC81487C3;
	Fri, 14 Jun 2024 07:02:30 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491B17C72
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718348550; cv=none; b=a7mKqD+1oZUama8qdYn4N8ODCqZKinUw7hqzba1ATFVDnUwLsL4vGxBkHfeKXF4JPDpWz0YtFiJDK8QBw5SKZLLBGTKXLUjjb9MO7LHjgQbD2j/F4p9whTv1tFRJ10Za/ZT5EMiEyashN/YusgKCRMqaGGvdrCuNEcgdz8DtlCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718348550; c=relaxed/simple;
	bh=UFvYcOWtqBhQmd0pRfoVeLky4JvY5AEr/8VDTEL9BZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+8MbXY/aKz2wUHq5sifbY+ge0/uzxk92uLRMtuEowXgCr4w+Q6AoC+tlSED+Tjud6WC8YpA671ZLiXRnBzDzRSWVzfZkqrv/+Pp23X9pZa4Ls0zF+nZraUslx/TdyLi3kML/YUc5S6jqM+D8K7uSJUvN3XlZmxdGbxfIrg0kL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-627ebbefd85so21879817b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718348546; x=1718953346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocVyg2V3e0HzMdfCsFB/9doeEeEqC8oyUzYXLqjfcnA=;
        b=fk3ItoWSave4XiDtbVn483yIu1MfbdcRzh1BdlZG/wWbj6nwlUGXeiktIjBV+erOCq
         laGFewiQEyMcQ25WDOIY2f/+Q+R4suHbCKB5g7cNWyKfL+VR1fdq4SfyEoAQqL31SkJw
         INrOpkImKZYoEi8ZD6t0GHxlVEWc4agvSyOlPD/qPWfKYqcPibIaLQAkLgJbIYFGXf8i
         vjk8WQA1iIl5FYzDnmPL0RfmwTUvdwHzYi5Lps5r0XBd3QIDSiGmHTIc8ca0uRfLGcwp
         t9naTxFJ4ymHCofbdfrGgqv5lRp+TGqqjAo3NjzgmOUXw4IFzYNVBQduDC6BtDJaQt+L
         CbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHMmOano6ro1ZqxGp7QyYBstUCkgdCN4XRMnuCF0lUCFcWmJMNvwRN36KA/oZhmYoUvkC0C+r7euyksQDUml5017QpBBtRHirj1cVp
X-Gm-Message-State: AOJu0YzB+nnzQ5GrK4GXTkk8c+DxQGlSIst0XcdrFtR7qpTQ7XdXpZdl
	goR4DU/v9607kUmVwiBt3354DfFL3V3BVXrcDJa699qGLYgEb3ZOul/1EyEq
X-Google-Smtp-Source: AGHT+IG8trqBJwK78ay9OFCYodpGygojakhMJXQVIstyraP2stww0Aos/JEcdFnsrcryBsBcvEpD2w==
X-Received: by 2002:a05:690c:385:b0:62f:aaaa:187a with SMTP id 00721157ae682-63222856cfbmr16349527b3.14.1718348545660;
        Fri, 14 Jun 2024 00:02:25 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-631189a783fsm4003947b3.35.2024.06.14.00.02.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 00:02:25 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6312dc52078so17746577b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:02:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmXhGQlTdLgad89tbgsC7J1UeT0WP95v0wUgaBcoVPi2A9b4LinBmQbocAkBFtOmubitS2YuVyyHdRDfixViI3yry0W1sdtQu8N14U
X-Received: by 2002:a05:690c:fc5:b0:62c:c660:72af with SMTP id
 00721157ae682-63222e599efmr22276357b3.24.1718348544784; Fri, 14 Jun 2024
 00:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718311756.git.u.kleine-koenig@baylibre.com> <3d1e308d45cddf67749522ca42d83f5b4f0b9634.1718311756.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <3d1e308d45cddf67749522ca42d83f5b4f0b9634.1718311756.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Jun 2024 09:02:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxM49PiAeoz1R=FnPEEmwMimbkXBuO-N2mF6pRzHummA@mail.gmail.com>
Message-ID: <CAMuHMdWxM49PiAeoz1R=FnPEEmwMimbkXBuO-N2mF6pRzHummA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: Make dev_err_probe() silent for -ENOMEM
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Xiubo Li <xiubli@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:24=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> For an out-of-memory error there should be no additional output. Adapt
> dev_err_probe() to not emit the error message when err is -ENOMEM.
> This simplifies handling errors that might among others be -ENOMEM.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

