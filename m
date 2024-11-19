Return-Path: <linux-kernel+bounces-414379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBDB9D2727
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFF81F241B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3AE1CC172;
	Tue, 19 Nov 2024 13:40:44 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0E54673
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023644; cv=none; b=lmw+2LHZEfZYcCuy8eMMCWKaZxdMxJ8Uv+VfuRNWZj8Mmj1Jawfw6KFFHvhCYBdebT3UqFjfO8KGwg3j7SddOvxbchwExPthQbsE99xXJIPlSHPFy5ulWHYJhPPx+yFFlQ7oBOgREPOpEfuhkwxR9JyLNhzl9+fXMehYARKNCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023644; c=relaxed/simple;
	bh=N7HjzmWr9O7hclzypYX1boQkmS1locK990oTJWF4ggY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJUga6j8pHSRG/xQFHpAEM8jB7PhQvPiGEjjmbfxp1WNjuKwdfxbUAdt8tE2t25fi4n1vKsQCsOtuyfTsRWDZEtu1RC2IBl6qwrpqgViLTJIBKdd6gXBPy3LAi666J3t4a8wv9fuxABv/VbEkipL9pyKEzrMwZfknFWrKzCSF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eeb66727e7so3132307b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732023641; x=1732628441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvl6fU8oqcVHTSCx2IRbX9G6wype9zKE2zk4xk3Lt6U=;
        b=COsilb6LaSiBeoYkkF8W96MTpx4Lu8sBAIgpRwLSxEwseTbscAqnSsSNXvuCLJsT5G
         ROz6hrReLucoaysV9t9k/C08Rf8NkDUkMjryy6kiFr6L9qWua00F8WKxQwRzUEJUVJca
         mo6pDftzTwRHgxQgwDQ+CE2EOw8JeAyPh3wETrPGwvpAXiPg4oEudy822e8YQB9Tje9c
         bSKCMyzC2UR/FBe6BWgPCiT07Um69Go7aIze0nCzvtqpN8jKLdxGiDRls+9z+OnQcvZv
         0lQqr1P58LcE1/RGzHqIRsN3gXHxZSumoIf8FxPtzfqKMAs4HakLmWCUQQnQBsiyCiG2
         Ndzw==
X-Forwarded-Encrypted: i=1; AJvYcCXxaVwO72jI6rR2nUXyXrWgPgdz6N7bGcuIL+heLkX1lQCQ4O5cOLx7+iPqtpega05G3hEAR6WXteKcszI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+qcO39w2V2tlZQrAm9l9GsffQJastj/sNCpJIwK0W6IzQQnz
	UZB17gdmlXs+kNC93kzb8xVdxbOktNCq/ircBcKh+OJcAXCY1zy8ak39sKfx
X-Google-Smtp-Source: AGHT+IE4STOHHtHu/bzXBpkD3286h4KThaxpvc7XxJX6uRicYstFChVoejVqHuLE5YiZlEHRoNLVJg==
X-Received: by 2002:a05:690c:d19:b0:6e6:248:37bf with SMTP id 00721157ae682-6ee55a781cfmr176740607b3.22.1732023641087;
        Tue, 19 Nov 2024 05:40:41 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee7129b412sm17220647b3.30.2024.11.19.05.40.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 05:40:38 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ee7ea48ad8so11386967b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:40:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbnwkNq4z9M/uPb+Q8qjc1vOE18rwi0bg7VHlX38J9rczDipIEGvt9RwyQThwdTogJ3/CKfXmwbT5cnus=@vger.kernel.org
X-Received: by 2002:a05:690c:4c02:b0:6ea:916f:e897 with SMTP id
 00721157ae682-6ee55c27343mr169514977b3.29.1732023637904; Tue, 19 Nov 2024
 05:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030171009.1853340-1-saravanak@google.com>
In-Reply-To: <20241030171009.1853340-1-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Nov 2024 14:40:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWv+x31-3OaKFKHJHJwK+KB0Hi3yJMRUJ3rqEThY=EE7Q@mail.gmail.com>
Message-ID: <CAMuHMdWv+x31-3OaKFKHJHJwK+KB0Hi3yJMRUJ3rqEThY=EE7Q@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Francesco <francesco.dolcini@toradex.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Wed, Oct 30, 2024 at 6:10=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
> In attempting to optimize fw_devlink runtime, I introduced numerous cycle
> detection bugs by foregoing cycle detection logic under specific
> conditions. Each fix has further narrowed the conditions for optimization=
.
>
> It's time to give up on these optimization attempts and just run the cycl=
e
> detection logic every time fw_devlink tries to create a device link.
>
> The specific bug report that triggered this fix involved a supplier fwnod=
e
> that never gets a device created for it. Instead, the supplier fwnode is
> represented by the device that corresponds to an ancestor fwnode.
>
> In this case, fw_devlink didn't do any cycle detection because the cycle
> detection logic is only run when a device link is created between the
> devices that correspond to the actual consumer and supplier fwnodes.
>
> With this change, fw_devlink will run cycle detection logic even when
> creating SYNC_STATE_ONLY proxy device links from a device that is an
> ancestor of a consumer fwnode.
>
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Closes: https://lore.kernel.org/all/1a1ab663-d068-40fb-8c94-f0715403d276@=
ideasonboard.com/
> Fixes: 6442d79d880c ("driver core: fw_devlink: Improve detection of overl=
apping cycles")
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Thanks for your patch, which is now commit bac3b10b78e54b7d ("driver
core: fw_devlink: Stop trying to optimize cycle detection logic") in
next-20241107 and later.

> Geert/Francesco,
>
> If you want to test this patch, pull it in and compare the output of
> the following:
>
> ls -1 /sys/class/devlink
>
> The only device links that should be missing with the patch should be
> device links in a cycle that weren't detected before.

I gave it a try on all my boards, and compared the output on a few of
them, and everything looks fine.

Thanks!

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

