Return-Path: <linux-kernel+bounces-340341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2BF9871CD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764A91F294F4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5FD1AE843;
	Thu, 26 Sep 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUl9cgB9"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652261AD9F4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347340; cv=none; b=tbgmHehGipMMKsWzIqTo4d4LOrIUPvBdsyn7KoVpVh0/3SNPjk0LqXBZt0c4s5ky/4Wirs2YOfhFjh/F5dVVogUAgIlZUvOi9xj5XLpE9TIb4WaUDzlrpnGYhH48LmznBh/q1YV4f/JRh5BxeTZ83jR2LLrEitAQZ9PWXWDKgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347340; c=relaxed/simple;
	bh=yX4eW2hLFE+pD/0oU3sBpz42gUQTQtE0boReuMH0kxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dj5acllGeHo0YY3/Rucp0JHcvVJXgkozFQEaL7CBeXIkigYqaZA0U0LQ60AqsdIL/CHySFGU2Iz6hAvKi724vS8j+ao9lXQJjX6pGyVNSDQSOufE9hT3tG8VAH/tGma3qbx7jiBjV9LqGfqyytguuKuoMSsysDyU0tegUXXmoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KUl9cgB9; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84e8406d082so298710241.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727347338; x=1727952138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX4eW2hLFE+pD/0oU3sBpz42gUQTQtE0boReuMH0kxY=;
        b=KUl9cgB90tJ1bnu2SAN50XfQ+4JXcPGNwwuOqyyxjVfnXBZi8WK13I/WgZiWowe5dv
         8kfwtu93CBpaTiRZQQohlXZ5FTYKBANo77a1voK3RanQlppNCCPzEAcpeWsDXUhHFWWP
         n5NCqt4TgRDxXaK29T4zpWX9rjVal3npl7GlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727347338; x=1727952138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yX4eW2hLFE+pD/0oU3sBpz42gUQTQtE0boReuMH0kxY=;
        b=qBZnZQsEhgC0g5qMKni9F9BSstQAQbjTFf8qr2F5ppF+7nO0TB3g3NjUw+A0IHjHXx
         rvpoRKiO7Pwm9o25MOlw0RQb3TZVtFL0AreKYu3euxAYp9E8yP3jXPcMbjHaEokYM+ud
         Dh7vgbiYemQowh0pKZyM2R6BDQGeAXz+ZbmGR0SpXr8l2tLsgigeS4Ul2ZESEVtqoLlK
         jrEkvCxsj3EguCsyZ+DphI6MX9EpUP8D5cNMYDsItKnZkDWqo8aF6/6nrCnczuZNuXnd
         nCiyE4oy4m2j/qT5e9hcw6JkUn4yu8b+s21i6JRBaY7Bo0IRBhf9AMGFUv0rpkDdlrao
         Pnaw==
X-Forwarded-Encrypted: i=1; AJvYcCWKLWLN6oP9GG5b+zWotMqKb5tzPpToU/fcAn0eavwWt2PaBhvMtivkeSyQ6DFsK+6pf6u+1yuGn0dT1ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvvGMJMCF2DhDUk5ARUCtfrwjW9vY3UgofbDSClf+AWQQxzNiv
	Uee8mCzCslGTipdu9fXLux1h3wl6bghLYKyQ4/PyiXaZBUAZI7xH24mRMrqJWOufsb2upcmgr28
	mdw==
X-Google-Smtp-Source: AGHT+IEex/Nikx/Td5wIcCz/ShcZZkPGB3J+2wWqbD8pFy/OKpkMp1eM0UGhJ6oavFp+do15/aK16g==
X-Received: by 2002:a05:6102:3706:b0:498:dd44:32c with SMTP id ada2fe7eead31-4a15dd4b28emr7474995137.28.1727347337823;
        Thu, 26 Sep 2024 03:42:17 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a15187d1besm3183648137.28.2024.09.26.03.42.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 03:42:17 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-503f944f174so303232e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:42:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7NuaJU3ClNw0Q0QvOjzCn4CLGvuX7QOfs3DQXsO6nv0IZaTcYwlHjJen0TzAO8i4nqhIgFz3ojnO2yMM=@vger.kernel.org
X-Received: by 2002:a05:6122:2a05:b0:4f2:ffa9:78b5 with SMTP id
 71dfb90a1353d-505c20ddd0fmr7058726e0c.11.1727347336501; Thu, 26 Sep 2024
 03:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925110044.3678055-1-fshao@chromium.org> <20240925110044.3678055-4-fshao@chromium.org>
 <fbdbe9ff-586a-429c-a987-b8ec39b485e8@collabora.com>
In-Reply-To: <fbdbe9ff-586a-429c-a987-b8ec39b485e8@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 26 Sep 2024 18:41:39 +0800
X-Gmail-Original-Message-ID: <CAC=S1njehOqkM26o=vfirZ9L8bec0jbtnvH0J2miYR_qEDeSVA@mail.gmail.com>
Message-ID: <CAC=S1njehOqkM26o=vfirZ9L8bec0jbtnvH0J2miYR_qEDeSVA@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: mediatek: mt8188: Define CPU big core cluster
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:33=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/09/24 12:57, Fei Shao ha scritto:
> > The MT8188 SoC features two CPU clusters: one with 6 little Cortex-A55
> > cores, and the other with 2 big Cortex-A78 cores.
>
> No, it doesn't. It features only one cluster, so...
>
> >
> > Update the CPU topology to reflect the actual hardware configurations.
>
> ...the actual hardware configuration is already reflected by the currentl=
y
> declared CPU topology, so for this commit: NAK.
>
> This SoC uses the ARM DynamIQ technology and embeds both LITTLE and big
> cores in one single cluster.
> Check the MT8188 datasheet for more information :-)

You are absolutely right. I found that description in the datasheet,
and this patch is completely wrong.
Thanks for pointing it out!

Regards,
Fei

>
> Cheers,
> Angelo

