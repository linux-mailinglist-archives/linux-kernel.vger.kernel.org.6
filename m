Return-Path: <linux-kernel+bounces-422992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0449DA0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEAC5287327
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8C0481CD;
	Wed, 27 Nov 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AHy+x2Gn"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2A41760
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676434; cv=none; b=lx6q3NOHwl//3V0uDoRLcEIAFifGDPOyIKyglAd9BScR4WY3ytmQY9dLJX9bPC0Rt8o4hUmD2eoK2+oF9Z3MdFVFRfwS+0NYsTh/7O55LHEhlDH+gJJJNuOODwDJ/raHSBJ/s30jwVTRyre2jmCKutcHC7K8atzDkfJHDZhbb4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676434; c=relaxed/simple;
	bh=BwexJOM8Lt6eGEeXs/wFnXLrXF44Ff0XiaeHC8NyObQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVfP/Yx2e7ELOLIN6G/+NkAWMkkG8ITyw3gHxl2OYci1XIT9i6SamLWw8VhLWTiLxYLBwpMu54oXmAqykLaCLvG0pGKNqvUsRNu2QIvr/6xvevv8WGfSbfgO6BFDRgi/831eIsYbOM3yp2awmDAWxt7CeVQ/qs0x6pjrrg1GJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AHy+x2Gn; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-515391d9b76so754526e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732676432; x=1733281232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwexJOM8Lt6eGEeXs/wFnXLrXF44Ff0XiaeHC8NyObQ=;
        b=AHy+x2GnJRzD22SCYs7kWdevMOCsPayz1L4y5sp09lcApRc579HrWvSkH810XuNrE1
         QMmyEYj/4QC+EGvn/e+h+ErVRtVQUtvzDMZhiw72kiL+9o74CjBB4ysQpxQkGv6zDcdL
         15Jn5KTmNwslCS16OQl40Y3jr5uV/3Dr9xtVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676432; x=1733281232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwexJOM8Lt6eGEeXs/wFnXLrXF44Ff0XiaeHC8NyObQ=;
        b=KC6YhTPGGznaMDBwG9Z5Ubq8NB28IgwGj9H2G+cnPq2XYFFpbp+zj5pzLnDKL9l7VI
         BVyywOiosg5gJIPlCUckrH90mJu48KGBaF3/N5Ng3uXuQQ3+hJTJbwWKCy/TDhPxvWnn
         hIGfT5UGtzVsVv/EL4uF1Udxw4E8jdZsuW8iazDHCIKhjqHpwKkBlzV3G3rP2Q+JDeAe
         pKG6l2cm9OYfHjQRm4hLBmxifzMw5oxy0kZIJkc67CPlf6Wrru3200XqSbnKBMCKPqf9
         Ba7p+ADDO0TmIL3uWZS6/xz0E7wVKfCGahO+9HjVHLOLVMUO9fBJ4DzuksFMDt3KMMj7
         GNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW49bKJHFG/aXPA2hJDIhG/7GNIpSxXJx/avkQVeUXNtMYmk4361ikP7aTsvW+0rUOaIJoNYIuCrW4hV6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnPynjGQ7gCnzUW9EQaAA54OrgGNc/6NwVB3/UH/vqguDWvLU
	AAo3lNTdscdPYrDyOgrd93TkW9ZxL6ctEM3r9DU28mZGfqfH3gTQ7HpPAfBiyH6RSXpFQbdet6E
	=
X-Gm-Gg: ASbGncuDE4iRunbiMCcb3wzYAwiIwWalcua0BQAnGIYNJZfnagZw/HyRIr6Y7tdwsjY
	oQilUncqaXx/EkhlzkBQ62YLohFxNYRcbdEIA3hqrhw24vL4xtZBC6ypLYiH8kz+vLYxW82H9ti
	tK6N9XIPjIs7Tx5nRENALGaCcbeEnZxu/pj3rV1fksaKg1RElPXTkBeDo4jrTNLxwZb9Li3FckB
	yhhZqncS6i0nVCJ1IOB22b13+iih4tebfSI8Hh/SONxwtPwd954pXsH7AYyjdSnyTFFtr04Q47q
	Lc9zUjH1LA==
X-Google-Smtp-Source: AGHT+IHQCw2nGRnOxd5SUQThnjr3OIGpmHAFN5QjyIhkX6X671J/ErSPH323xtN8wIGbwC4YD8DxpA==
X-Received: by 2002:a05:6122:251b:b0:50d:5095:f02b with SMTP id 71dfb90a1353d-5155681726amr2479133e0c.0.1732676431990;
        Tue, 26 Nov 2024 19:00:31 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51544550c7esm345832e0c.32.2024.11.26.19.00.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 19:00:29 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4adc672f2ffso1576358137.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:00:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMlc4wS9ztj5JA8hxm1kHMzahvCvAEmx6ejRRCUN5Tbgo2+oNtQ0BqxvcHKBWa95crecNYO7HxexJrDQw=@vger.kernel.org
X-Received: by 2002:a05:6102:c03:b0:4af:4b03:4b8 with SMTP id
 ada2fe7eead31-4af4b0306b9mr275735137.7.1732676429255; Tue, 26 Nov 2024
 19:00:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
In-Reply-To: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 27 Nov 2024 10:59:53 +0800
X-Gmail-Original-Message-ID: <CAC=S1nh6nE1+whLEUcAVG7LyoJ=o7oakR_k6=rjoYYoMSnfS2Q@mail.gmail.com>
Message-ID: <CAC=S1nh6nE1+whLEUcAVG7LyoJ=o7oakR_k6=rjoYYoMSnfS2Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: Check num_codecs is not zero to avoid
 panic during probe
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, kernel@collabora.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 4:10=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Following commit 13f58267cda3 ("ASoC: soc.h: don't create dummy
> Component via COMP_DUMMY()"), COMP_DUMMY() became an array with zero
> length, and only gets populated with the dummy struct after the card is
> registered. Since the sound card driver's probe happens before the card
> registration, accessing any of the members of a dummy component during
> probe will result in undefined behavior.
>
> This can be observed in the mt8188 and mt8195 machine sound drivers. By
> omitting a dai link subnode in the sound card's node in the Devicetree,
> the default uninitialized dummy codec is used, and when its dai_name
> pointer gets passed to strcmp() it results in a null pointer dereference
> and a kernel panic.
>
> In addition to that, set_card_codec_info() in the generic helpers file,
> mtk-soundcard-driver.c, will populate a dai link with a dummy codec when
> a dai link node is present in DT but with no codec property.
>
> The result is that at probe time, a dummy codec can either be
> uninitialized with num_codecs =3D 0, or be an initialized dummy codec,
> with num_codecs =3D 1 and dai_name =3D "snd-soc-dummy-dai". In order to
> accommodate for both situations, check that num_codecs is not zero
> before accessing the codecs' fields but still check for the codec's dai
> name against "snd-soc-dummy-dai" as needed.
>
> While at it, also drop the check that dai_name is not null in the mt8192
> driver, introduced in commit 4d4e1b6319e5 ("ASoC: mediatek: mt8192:
> Check existence of dai_name before dereferencing"), as it is actually
> redundant given the preceding num_codecs !=3D 0 check.
>
> Fixes: 13f58267cda3 ("ASoC: soc.h: don't create dummy Component via COMP_=
DUMMY()")
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

I noticed the same issue on MT8188, so it's really nice to see this
fix. Many thanks!

Regards,
Fei

