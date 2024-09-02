Return-Path: <linux-kernel+bounces-310808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F32196817A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C931F21082
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3878F185B7F;
	Mon,  2 Sep 2024 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBYy5lKx"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D817F4EC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264909; cv=none; b=CKars0+RWImIsqFeTcYUqdYvz7eEY+o2h683NHc8ZoCd8Pv5t9/rI2KT271WqE5zVE+cGQGybXlhXNC8rtsZNtJy8b0c1YTEluf0G6qINCxFhMmQvfhVXVS+kxvJ/0eO44ZDSvfynn4iwqDqGg5xVCAnyNUj/M1pmDuWMod2O+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264909; c=relaxed/simple;
	bh=cNHXjqKgLWMds2OgFensstlmKCOeVqEB2Hiik7pkYFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksrzSy59cFBums0EgRA3Q5XqBZ+85xKh6f6+Vu0GatFLOMmZ+Jf2fkdeB2ZNVbtzlFz4PNo8DtnUUAYoh8B6BQvY1egajN4aB+yu1wHOJR6t8Rl/0/opolv+9yLBQ9WDyKlnkHd0Qph1EyOYIFqQs0CZHhaEkc6JsKoX+5aBQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UBYy5lKx; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533488ffaddso4920158e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725264906; x=1725869706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jrjj9ToqPLcqSegJWScldNm8STblDAUw49Si0ujiXY=;
        b=UBYy5lKxqXzjRM+8ZgjgXAE0wgefVz9JmoHY6mGdAgkV/3iW5hfNrKQbae9yAgzGkd
         7q1SjQzXM8YCOJ4Xprg9DSnHw7hVKmZcrNv4/FanMH+ab8mgxy+Rnjl4koXKi+4ziZ0R
         cnGv0/S2z3kvo+hk8bxmw/M64VR/2l2zOFFMYBPqkYplniISLk/LGTeXZV03ilPwl55R
         24g4Lv4XrkLCa7oco1+EJGfVRw07wBo1osqUGCVIlVOZ8CT22Y772d1oQ6b4jY2E2ZF8
         r5q7OCHdBzpNkinNC3IRvna0jZ2pzIn5gU83IYhMW7SQeihoFASDYVNNvt8B9xI4PbcA
         2oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725264906; x=1725869706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jrjj9ToqPLcqSegJWScldNm8STblDAUw49Si0ujiXY=;
        b=ZsAu5JhDw8Ytqj8TMXS9qsV6lwHUrlDMrqIelCSfmg3wchc+1gynudz1UZUigooVdm
         JjybZtJ7/Vhrb18/Z6qAHeIFW41yBY0iTrgEAO1qo3Yld2qD2B1Kal1BGw8Rxd4tzpMS
         qq42dTm9tsiS6NVnS6jja8IOZnZUvdxSkCYQSIkjvXQ2u41tK/kflbBs2JS3uixk9sTD
         uYQLkD790vg0QT9+AMVXtU9Y/VL/pUF7RbuK+ejLdT0sP5YVBTVeYIfKtclRthP2BFMS
         jCTZg12Dzk06wS6PV+tncajmRuNO2QWj2vnRSgnjg7x/USBhmFurXJSz91NH0bUvAMmh
         YDSg==
X-Forwarded-Encrypted: i=1; AJvYcCVi5zZzwdF6wfzSoStGYCJZTEKnkP73dhEndc3Z2dGXSWCA5ohUOj9eDmacjFBN+2znU7iq9Hq0iIv3Mv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGmRg3DpojKxcRO5AetRWBeyjLxwRhtz8M3q8Fwo/HWnXH59V
	4V8XHdCeD+bNLUr4hd7sWWErb5DZ1HYq5eSheEnSQ00bM7UiD2ya+9H5pjilE/i+M4e47NlQ7q2
	dxuV9Hm9q0qKJOspca644slB7GBtk94YHsza6tGGRixY+Kc6W
X-Google-Smtp-Source: AGHT+IEIcZ714lRv4sDFrAlbMjbnTzlUd9K/kGrUu5kdiOEEZV9QWTofPNmqjzUs2KxOcyJbrYr5+8vL79gdS78rfC4=
X-Received: by 2002:a05:6512:e94:b0:52e:74d5:89ae with SMTP id
 2adb3069b0e04-53546b8e017mr7635959e87.39.1725264905563; Mon, 02 Sep 2024
 01:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c8e3feeedbf42a130936a5afaea0f129bcda51f6.1724938156.git.geert+renesas@glider.be>
In-Reply-To: <c8e3feeedbf42a130936a5afaea0f129bcda51f6.1724938156.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:14:54 +0200
Message-ID: <CACRpkdaokb7+C=gYqZYR3_RO3HRPKK6AFB5O07fbzC4Xx5-vPQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Join split messages and remove double whitespace
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Stephen Warren <swarren@nvidia.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:30=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Splitting error messages across multiple lines makes it harder to find
> them in the kernel sources.  Fix this by joining the messages.
> Remove double whitespace (end of first line + begin of second line).
>
> Fixes: 1c8e794432c2ee75 ("pinctrl: improve warning messages")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied!

Yours,
Linus Walleij

