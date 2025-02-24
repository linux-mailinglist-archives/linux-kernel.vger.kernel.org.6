Return-Path: <linux-kernel+bounces-529203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01D5A42162
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254A41701AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C178244190;
	Mon, 24 Feb 2025 13:40:06 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95E17C61
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404405; cv=none; b=syJvgF2NqqSFoXICoVovpQ0WNPrlmpSBW9vN+CYcVEgW+taMSBR/ERFbjLEn7zEmCLqb2J7Jp1ulscyShgze5bzpi9/+K/zBOY6ltfH5eq5SDDr6/59H4jU3JmItA9fau1PI9+4Pi/DlNL3Ope7F6wHtEp2zrQ5KOqZgNlB1RV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404405; c=relaxed/simple;
	bh=OABBp3F7xZnVtJ8j2ImkNbbgci48N/tSfJ4bED+4y+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7uTxmbKRLfv6nSurKZS7pnq8Mx2CHfhYz8z9mcQKIDF6Oksg2Vys1am88v8DAu3CMkX2NJyxvwsOuSJD8ynx79T7udonINb52pmzUGf2QsNImwTG/DcLE26awoklLwSx0c2KgKa5UuEkrhyvbWMvmE1bG0Zi469FkjhSfr9omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4bd3c887545so2849403137.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404403; x=1741009203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pLLnLuI7unpcPLe82g6GEHxfi2cBXIpbaa1ozjNYsM=;
        b=Cvoeoji5VBnlSDj7nf0MGe9pU1a68jirXbt2J3xjuQ5qiKWln4fXNnYa7YcMVIMaem
         LSptlNatO5VdxPG7ppXi9H58mid7kzGLUqEG9ZZ3OzjfvRXOCRgJMSJY+TvhHA0wHI36
         I1Pl0PO7kHPCojXCIEACBMjkz19XCY+ySEMbJoLlX3C4eoxDtR/75bglZazAOBOLCV+z
         gY/tjkyJ6P4owRHWbIS3f8wCKYIs2cnnLQ/OZbyn6wZGzI12smHfyQqPT7hW05jzL6fY
         EEkDB19Ty/qrS9iHuiEJFX8QIetcWddHx4PeYeub1f/PHf1QZufa0KQ+KQ991QWFKRWX
         PNrw==
X-Gm-Message-State: AOJu0YwctLPxeR4lwOMLoqud+3bPVKTohnbZMFHQaKxQQFL/PuO2Xi2S
	Wyb/Juc9SQAp+tZTIr4jY6fY0AWq6kzE8TUnQldxDJX+HGdWy91stre6l8aHmLw=
X-Gm-Gg: ASbGncsyhTQd/PV0Kl7EhVl2qmipkEJ51qpcW21SdkAlvrrvGfgVr1xnvPWQgtos0TE
	fEdbU6OSJKGvth27AIsg5a67Bt7neeJpMrBdS5qK458lNhWkMGZm3npGUyMsCHkNaedXNOe0TmZ
	/Chqo+z8lqNgD1UUipquSF+K1SdogZUHairUkD3XrkAjnOKMmwzi+qTkvHJM5F1ymFNXODuDB8k
	9SILzJTLyh+TvI/8s92Jeta+FmkR6zU1cW8ihTPVBPo7flonmqX7EnaIRDrMOlBJq3uwWKozNV8
	0J0PxLIHFvlNuQ1WybCoQ6TPC6RHr6pCbfRyNaaIr/qyALtkyCMaWavVixusZqyu
X-Google-Smtp-Source: AGHT+IGd0nAT3KuAu4cRCSNoeHIiOi+sd+tChntMwi0Jv7YQJEipAkC+rvYrJ01zp5PmOWg+vF+Uxw==
X-Received: by 2002:a05:6102:3593:b0:4bb:d7f0:6e7b with SMTP id ada2fe7eead31-4bfbffd0cf1mr6713763137.2.1740404402801;
        Mon, 24 Feb 2025 05:40:02 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4bc2f7b9b70sm4442021137.7.2025.02.24.05.40.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 05:40:02 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4bd3c887545so2849385137.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:40:02 -0800 (PST)
X-Received: by 2002:a05:6102:38cc:b0:4ba:7469:78ce with SMTP id
 ada2fe7eead31-4bfc02873d9mr5219291137.21.1740404402154; Mon, 24 Feb 2025
 05:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224123625.3816062-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250224123625.3816062-1-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 14:39:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8E=+p1YS5c=UEwGtT+4GGgAPN9ej+T4eDv-+MmZ7SjA@mail.gmail.com>
X-Gm-Features: AWEUYZnErvJx20y4QYH5nykY-Nc9f3_yNgrqAiHIjHB4hzpWOxDkR1sKA9_uvpw
Message-ID: <CAMuHMdW8E=+p1YS5c=UEwGtT+4GGgAPN9ej+T4eDv-+MmZ7SjA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] auxdisplay: panel: Fix an API misuse in panel.c
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>, 
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 13:36, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Variable allocated by charlcd_alloc() should be released
> by charlcd_free(). The following patch changed kfree() to
> charlcd_free() to fix an API misuse.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

