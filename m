Return-Path: <linux-kernel+bounces-322426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821699728D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9BD1C23E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF1E16C850;
	Tue, 10 Sep 2024 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kxAmN0L8"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222477119
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945361; cv=none; b=MIHD2fogqKGd+KySOAB9rhKwAjX2vDF1dxVqfrrL6wjwRjuNrU8G+JGUcZQZQol5Wg92Zy+g4bTIsUvLBZHgRzsaINu49AsFSbHbJNOJ29t9ynPwod9xI68tx2PUzBCbUu24ccg0ZiHiO0mKK904k+4taHIMpMWzKYBQ182JyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945361; c=relaxed/simple;
	bh=KkKyun3pACw9OkcAef3QM14XISf5GtqqFq5NzbfLfhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZCgkYw4zpujrazy6898GGbYjYnW5gkofSN1JefIztnmSTbhefi6L6eanXnt2nL2DgabjqwpSyUu/RGpgn5FhK/gV2VzeTsS1S5sbMNYo49q35qNNiUTJDuDDhhuXS/i9bq8mibXzvNXVfn7xQkjnr6HxSQl2JLcjFDwoEz6Wag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kxAmN0L8; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-846cc83c3c4so1434993241.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725945358; x=1726550158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkKyun3pACw9OkcAef3QM14XISf5GtqqFq5NzbfLfhA=;
        b=kxAmN0L8qaEgsMSssm+YjAEEcGbK+OiTakpdDKlF7LWK86BqPVeTnFRVple2symOhe
         4QQLPb9eAVMS0Ge0hG3YjGe8oynD0kgmIhY6huxTJXNyZ5Ws2kCyoaG1aUqHEwvS6Fb4
         LUNZ1XyQHL9UPdqQiPQ/7X9ALyO11cAQ2KQR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725945358; x=1726550158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkKyun3pACw9OkcAef3QM14XISf5GtqqFq5NzbfLfhA=;
        b=TjAiEHwa1bOs+D7yJZcgQBda0luMjFrAvW6ygIE+Rz6ijsWOe632x39h8OVEXjhOCA
         C5ezBtYNqggRIBLyJZM9HVdVcHN5fGRdxcWWiHYGVEedL0ve+VaQs8uZPMzNiJlbXHmy
         bME2mwFy+ZBmff4D8YHgftfKEnzES6Vko+iEveCJwq2wWDw6nuphYBZgREdGUjo/cc5D
         EjKpTCdBnLZ7ahIjlXJFeMFyb6SzB1xCiPxam/RC3gnFZRW+g0fwmwWF83pRLbK5hyrv
         r/J4Bliwvi/hkJU6+wE7ty4sBI5dgJaWwU1g+BY1TtrT1nY6Al2IRFk74HvoB6nAxRut
         4a0w==
X-Forwarded-Encrypted: i=1; AJvYcCUjIld0i2Neubw9Wjmr1OjhVHpQSEM66yrasT3E+zH+yeTutRltvBnmY45ni0vbssL8nJn0fQV6BvgP+Sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQrDd2Y7+nzgafq/Db9bdglXTTBULHFbpPIGs0nrONV0qBhxpg
	IDnrImki7S/pQ5vFJ5E7224OXpMt1af25+MZpjuS2S6fhAPKrpvfRWbd8HUK7jjFTquaHbu8z6a
	PYA==
X-Google-Smtp-Source: AGHT+IFUd0B9B025ZT3vSjHnLIcZKePhVimHLdIjrgDdo2RnIMweqjYthH61Ilzh8eAi4K4I2Xz+0w==
X-Received: by 2002:a05:6102:3a0e:b0:497:5eed:cd89 with SMTP id ada2fe7eead31-49bde262e84mr13308025137.22.1725945358045;
        Mon, 09 Sep 2024 22:15:58 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8489ad43dd0sm665270241.27.2024.09.09.22.15.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 22:15:57 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-502adfff646so1124327e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:15:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCYxxPspYMRE3e/6lEZm/g0qUl1tcNHEMDYVjeXE7JYKildWQiSHDsorsPP+RskiCXrNf9W9gZXYK/XOY=@vger.kernel.org
X-Received: by 2002:a05:6122:45aa:b0:4f6:b160:3806 with SMTP id
 71dfb90a1353d-5021438e58emr15631095e0c.11.1725945356258; Mon, 09 Sep 2024
 22:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909111535.528624-1-fshao@chromium.org> <20240909111535.528624-2-fshao@chromium.org>
 <b5b540f7-d26f-4529-8066-506aa02a0654@kernel.org>
In-Reply-To: <b5b540f7-d26f-4529-8066-506aa02a0654@kernel.org>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 10 Sep 2024 13:15:20 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhaNE3qoL=H1cx2XLszLO7EqTHX13KoKwgFENX_=Eqqvw@mail.gmail.com>
Message-ID: <CAC=S1nhaNE3qoL=H1cx2XLszLO7EqTHX13KoKwgFENX_=Eqqvw@mail.gmail.com>
Subject: Re: [PATCH 01/13] arm64: dts: mediatek: mt8188: Add CPU performance
 controller for CPUFreq
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 7:42=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 09/09/2024 13:14, Fei Shao wrote:
> > Add performance controller node and performance-domains properties for
> > CPUFreq support on MT8188 SoC.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
>
> Order of these patches is not helping. You mix new features with fixes
> and bindings.
>
> Please split fixes from the rest. Bindings are expected to be first in
> the series.

Understood. I'll resend the fixes and features in separate series, and
group the binding changes in the beginning.
Thanks for the feedback.

Regards,
Fei

>
> Best regards,
> Krzysztof
>

