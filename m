Return-Path: <linux-kernel+bounces-437028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF089E8E45
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D371886EAE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FAB2163AE;
	Mon,  9 Dec 2024 08:54:35 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277DB215702;
	Mon,  9 Dec 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734474; cv=none; b=Y56wkZ26Hb3juXE9RLiT9PQds0jhqjFjYWA7bn7//pBp7pIcF3YU4Fy+omHGEDkZJ0OfKXB8LdlAY5/uZozouKyj6nUgpAg+8zBAqPlFTwrghGwRXMX+9iv+XIbEJOb3obwjfjKBXMoSlVTfhkRI102iRerV5SJP85fYGNlCXCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734474; c=relaxed/simple;
	bh=CMr0ejLDYjtXYlA6IqkdUt85qavVpPFi8xohTJ9D/lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qp95M4XN/DkfwbCCKe22Dhl1ogzFyW+8n8UJCTAG9rUwbLd3mDDHy9eec3FOROunDbLRz+X4jrZtcyv9HcieRR9+mrnYTHXAMcX+lr7KSfE0p3tL04L01Bd5T3aqwCY1G8P3uRW0OmRMIdeRhzuCTwQDIV5poCo1YGrW84D7l9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5187f0b893dso108844e0c.3;
        Mon, 09 Dec 2024 00:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734471; x=1734339271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVBP7XvnBcuh/PXktaH7YEQGkavE5L6qkU6nVkTi5lc=;
        b=OLdtY7xIhWQPv6IdbWweG1iB/hBch0orOltv333ttIwUrjvU1jGBgWay1/JoOreAJL
         rZn6xqA5pF5GwD1aJeuTLap+Aq6374JTck4k1yuf/Z4Wf2UwpxGXw6dxvUrp4ZGt8DYj
         PMZjqXXsZ4lkymXao419cbKT0WXAsLPVh1A+xTLKA+vn9wzqAogRPEgfZilxAtHoYsSV
         WubGmZPQUIRzpJssfG2UNsCz3daeE7PTfQL3Xzx0a3bSAp2ZnxwNiMsphV1YIX1FTZbV
         7bWdEtr3fMMJaV//KjlqyZ+aEfRXSfPYjH9pDv1KB44J4WcnrkE4Hw+Kb0d6on09iK5p
         r4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYXqPScrOUR0xworofuYwnM2jofQwbsTlsRGFBGPJGJvW/8OkZ3KkEp5s2+iTbPuQxjF1Yxj4vGtbbc7oRVQQ=@vger.kernel.org, AJvYcCUvXzwQ1/ET9bkUVlimUWcsjFF3vNnxE2mvBQK7loVhr4V+wB0H46SzkUT03iNf3SQ5bZ0SRUkmau1uCa/M@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5J5fCZV3XVc3OkLDWG9Ml8YxwQUg4846hOgsKFZOgg6obXYnK
	+4l04Y0xg4SFFbUrGqUbsd+OfHY9ZjwvxZ1hQSI3I4Qr9CmQmTfL6M4v3cezTSQ=
X-Gm-Gg: ASbGncssgLi6KScvtvqSC7R1BvDqaUNaVHns3zwzsR0o6A1XZW/oYNiTRlIhgE4USj0
	ai06dIWbfEMoNFQVggYKrSKaDof+kthILPv7D7+roAjXVFLoME/EURofSCdNbKou1zQ1fw3aNLg
	6rmv8BoOQ6WePzEHZT8on32Vc4TNnbSSlTwo/qrZ7H1ys9Umq/Vx5p/CUEsnVDx5xPinXUdsJ2j
	IIG96GJZ1/wIKjmjTZ9q6ByGJqK7m4H9Yq9S0LxxX56MyK2KokA4pCCAoIooi4bp9kEIsOm7Z8t
	BPUWR/J86p1b
X-Google-Smtp-Source: AGHT+IHoUbgh11hW8tJnsIgITery9JMJILZH7TWY2d4FIXTx00HOZI0wOmQB9HwC0mWgK6Yj0dOhwg==
X-Received: by 2002:a05:6122:489a:b0:517:4fca:86d4 with SMTP id 71dfb90a1353d-5174fca8a9amr2176074e0c.11.1733734471275;
        Mon, 09 Dec 2024 00:54:31 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-515eae69aa8sm774998e0c.29.2024.12.09.00.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:54:31 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4af3bfbb721so1323525137.3;
        Mon, 09 Dec 2024 00:54:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuRk/yZXLyxdUsGUMbXyecMv/1sHEf/HOdjzGVrcb3e8kmiV3FXqOrwxhSSehwpsdfi1d6DyD7v4fUKtr/@vger.kernel.org, AJvYcCWJb7/I/nTVbkwNGLf/UM2TEJbDwslDJezHMLwqWEZbgpC7oglzPWPsoHRr4p/+amghj+4C7LIKCXQyPyWnvXk=@vger.kernel.org
X-Received: by 2002:a05:6102:54aa:b0:4af:fc14:f13c with SMTP id
 ada2fe7eead31-4affc14f95cmr1336643137.15.1733734470926; Mon, 09 Dec 2024
 00:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35fab997bcac76cd4135797a4968c2c72511dcb9.1733523925.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <35fab997bcac76cd4135797a4968c2c72511dcb9.1733523925.git.christophe.jaillet@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Dec 2024 09:54:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVL8J4=ufYf0nyoQo9f1Dd3ER4wf1wtAGtqFnN74GWJxw@mail.gmail.com>
Message-ID: <CAMuHMdVL8J4=ufYf0nyoQo9f1Dd3ER4wf1wtAGtqFnN74GWJxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: img-ascii-lcd: Remove an unused field in
 struct img_ascii_lcd_ctx
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Paul Burton <paulburton@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:26=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Remove 'cfg' from struct img_ascii_lcd_ctx. It is unused since commit
> 7e76aece6f03 ("auxdisplay: Extract character line display core support")
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

