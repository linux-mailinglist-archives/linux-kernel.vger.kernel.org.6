Return-Path: <linux-kernel+bounces-300072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4461895DE71
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755931C2136D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7289179958;
	Sat, 24 Aug 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HINPEEL+"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA03153BC7
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510134; cv=none; b=rXqJWYkRs0ljKoSCygkGiwDLCFAT2dHYuY4z/YlHyUHUtY0BSvUl98Qc7h8eu0dmLoJ1o9N6WlbIg6lMmxabL7SHmMp89FZ/z7Bl3KKSQ4KuPSQQHDDNfurYNWKfDE22v6UvGFSnnH7IGQt0Xi7vKAdNFtpvZubJlMJ96GcXjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510134; c=relaxed/simple;
	bh=NMDu/5QSUg1LBE+wu5+jR7p5r32ZQ7MycJQCvwud1m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKaTya9LwkoeFomDhU1knfkIOkhTl96vlq9JK/uxDD+v5L89hRmGnAdPkVhvbM7mayb0ZaR354cI+ug+fyhKs6//9nzirFPfWJXORAsKjkkuBh70OgyQwmMPZ96M4/heI3+w8cC7OQdzDUA5cKhqbGx8XYkL0h2TbmDbTn9CDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HINPEEL+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53438aa64a4so1935034e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724510129; x=1725114929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMDu/5QSUg1LBE+wu5+jR7p5r32ZQ7MycJQCvwud1m0=;
        b=HINPEEL+SfJ/fCL7iWjAkn/bVy7o+KzWFT3XLwjIVe8yLH9kQ5OsKYKVpilacVOqq6
         my4v2lBJoDvHzfCub9Z9eigOU8XPC2NHkThCEKO3WZTqcbRZH0KkvhQ470ESEsg1XYwk
         SkTxNzdZE3y13z4u1u2DQn9wY77TGOEr/DolOXHJnp4MQMDvUjxZDBuhc8nx2zGffAZp
         tfEP/7fN6RmvMgFmfUiR2dirJ+AbS/OSnt9lJ9vMwFjpsexe9T89IW9Db6x0czTTytxw
         15RxCFt0Nkg5xwVIycSq4/PPSIdn9lR813dt50gRI+oC3BDFeM07gUOG8p3x3iKBlilh
         k+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510129; x=1725114929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMDu/5QSUg1LBE+wu5+jR7p5r32ZQ7MycJQCvwud1m0=;
        b=d4OQQmh727ScX4IqK7XjDAPaa5dn6qeDVQ5Ltp266T9+dJJF00TZVQKLhMm+vMj9bk
         j5fonDEtG8C04xQQEwax1PDgP2R1AvIo/t9F9UMS4RWKgmdigCh7fL5Va0f+wH2XR9L9
         JHhmB8zzmXP71hYDQRFVzupmxBd3gJjDESgFU8HKC45GMagvvsNYV7a/GiWnxI5dIchc
         W5JIECoowDOwOl/rJn/haw/R5BScsF5y+//0660Nc1ud7PzGA1EUjruq+0WXbspYXLRH
         B+LdxB850BywHB1+QQcNhcqUjpizeHEoltn97kU2sJKyuEgezWkoCH6EwSrbZTrmR7zw
         Iz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUa8SsFdpTjJsrBhd6CrVNiX4cQ2HMhrhe0aDB0HbrScTlC1+7zWd66C9SWBxX7cl8jlP9bRQjGfmIPAsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXkbB/0JtQ403TpnS+O1/i8Th+kvbTQQUHXkN4xFJMqkoxVbz
	cSENMW7a/6DveexIMFyN9qDOX0jI5cWzaTSSaUFU3j+sTypAK07+DY85l1lBbTUFN69p3FnkXo6
	JuNTPwTqLF1d4hWMgE04sZh4S6HDbgNgxy49D7g==
X-Google-Smtp-Source: AGHT+IFIieYApikMakBIy2Y3QpzEwuw0mKiU5WA+zuD4+YWt0cV9QUkRkfcqBTE1mr46xvDnlQce1Ej5ZePV4LQMVhY=
X-Received: by 2002:a05:6512:695:b0:52c:de3a:839f with SMTP id
 2adb3069b0e04-53438831e5bmr2704242e87.20.1724510129067; Sat, 24 Aug 2024
 07:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zr-gX0dfN4te_8VG@google.com>
In-Reply-To: <Zr-gX0dfN4te_8VG@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Aug 2024 16:35:18 +0200
Message-ID: <CACRpkda-0mh+Ds_KYWKqdf=Joe0yuirLrpcXhEzPNSsHXfbjZw@mail.gmail.com>
Subject: Re: [PATCH] Input: keypad-nomadik-ske - remove the driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 8:54=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The users of this driver were removed in 2013 in commit 28633c54bda6
> ("ARM: ux500: Rip out keypad initialisation which is no longer used").
>
> Remove the driver as well.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This was intended for keypad phones based on ux500 and then
the smartphone/touchscreen revolution happened and it was
never used, it's there, but it's always dark silicon.

Yours,
Linus Walleij

