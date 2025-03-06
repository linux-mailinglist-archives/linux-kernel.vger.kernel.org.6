Return-Path: <linux-kernel+bounces-549088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87215A54D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD628188686C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A31509BD;
	Thu,  6 Mar 2025 14:10:44 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C9CA6B;
	Thu,  6 Mar 2025 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270244; cv=none; b=kIVN2yQ39wHWmODomoTlnMCmtRf1Pg5GTTktQx+e11qnESjhR1J8tygGftauRjeLCWTgScKwVDcYPCYjF6bH6NvWUAbG+2dklO3Vf7ZwoKe3xDLeLt64DTc6x1RCqVaRtqHPjRi+5BXB6PFGlEoT8t+9XxP8ekL3CYe6lI6/K3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270244; c=relaxed/simple;
	bh=tMUiNL1JfsiWCo2yrLVRKdF3GdPL3Pthlyw30VuXphQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufclro5U4VvKGlcwFg4Kd89Fbo3d0rfGchzAj7pYx+kAtMKYZzP0CUbHhSayngAKVa6t+mYDscNDTwdAXqgYqdWs3OSLvw5QklOZw/XqoOa2QjaDRGLMlpM0tjwVkyK0RwitqyT3F0lkRCe8VTozy7xAwBfmYZmIJIcWRv21Wzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c3b4c4b409so108804185a.3;
        Thu, 06 Mar 2025 06:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270237; x=1741875037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5tWRsmAkNRl3CcCpEBYNoShz/dMC+I168fgqmDeCw4=;
        b=cIPWrsBFfvHafnKQkNwQEHdg4Gh5xNL+tx31VmUgFODEtIbIIIF5iR/OtQnAf86CUr
         xuZzb6WdvYQrTBBLbuEK3Cb/1NklkMkVrRZFMT7tHl6Gff08/h/S71D7T+wrxlo7eWrO
         tKPCWJUVdrcsaoZHsksnAcxHolndOr0WuJ3udk7c74stcknPgD73rM5WlWJ22xKwX3Js
         Od4fYco9GcuHqFvd/+DnO4yjjTAkmyOyok33R2Uo0iz1NnzNNeGugOAqvK5U9KqsOHnl
         x8jPGPjJo3GcHy+3JbzOAyC+wy2bkC7YViIdYspKNOwla/s1XQXy+/e0Fp8tSM9wNbhl
         kf+A==
X-Forwarded-Encrypted: i=1; AJvYcCUKE3TmgbEE/nmFjaoyLrMnUZF2c1AWTjf8aPxVLbR2KsamET1/ZLpG0kD2bFJmSrbHoH7brGFRItN1PPkn@vger.kernel.org, AJvYcCWSTmBQCxnbL7t2UV7JLWeJEWUGP43k1dSx5ctta9higNlnSyJYrNNanTe+Vj8CSH4G0mPB/1wVIBlI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qujreEFIzLEjtKxVoevxRamAwlY948Pe1AtR5Fa9qMeGE+FQ
	8QdJ0hafPyi7os5Bw3fk0mQvIc5Dbl3igR03bPdQztYSevhbWByi9o8vQvGF
X-Gm-Gg: ASbGncs7DginB+gYFrexC+HuEpYVY7Zr9I13zTXHg0yLRUnZq9JhTSfvYTNFNzKZNYy
	1CfOURLPq5PTFTAxYCfolCVFVliRKr1TGfVqVksnfRmaQ1NaplB83MBvKrm2asJSWSDLlCI+tQu
	bxHUzb2zEE9oLTtMqRUpG/kbCtytIBm8qqAS9CJyKbJjtv/dMDOqHIh01ZoEhzjSz91ADPSVXkR
	amG7M1YNLuNaTbErfksPpARkpR6ce77YAMnBi2qykknMzMGXBJXQcxofrIlLB+f8PD3JCQfBU4B
	7F79lDr6O8R7h6CFaSoBaSQiCnL5ynUceqvutnWwWPhDpsjzG4bSU6FyJHfH/crdcmwNmNioF66
	Nn9lTZZfJVpw=
X-Google-Smtp-Source: AGHT+IESvc1LeM+RqGdLyiHv4lHBcfQIUlSePncT7eUrsnthkSf1LC5tbg4joa1XrGBU0JwYYjBTdw==
X-Received: by 2002:a05:620a:6285:b0:7c3:9645:354c with SMTP id af79cd13be357-7c3d8e41794mr1307745485a.21.1741270237079;
        Thu, 06 Mar 2025 06:10:37 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a474sm95696785a.20.2025.03.06.06.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:10:36 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0155af484so100156385a.0;
        Thu, 06 Mar 2025 06:10:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUF9m2KQuhtV2cBOV1vUlEDafMUn0EPyfuRFxxDRS11T9YqKIEhUD+XWrG/5YJFw+K72uY06hp7NbAZDxM0@vger.kernel.org, AJvYcCW0wWVSBY0uokRN5p90S/Q0m4vnlr3y1bGqei6CMv4sv0J7zRZWK/8n1+y6UdyPI85AuISfohtjzcOy@vger.kernel.org
X-Received: by 2002:a05:6214:f26:b0:6e4:4393:de7 with SMTP id
 6a1803df08f44-6e8e6cc7519mr101951716d6.2.1741270233688; Thu, 06 Mar 2025
 06:10:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225210316.3043357-1-robh@kernel.org>
In-Reply-To: <20250225210316.3043357-1-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Mar 2025 15:10:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUc1Gx8bQu0ePZFxNgy0=MZv909V74A-2y6wPTy8=MEDg@mail.gmail.com>
X-Gm-Features: AQ5f1JosAcu1iTpm2frNZuQquQZI0u4F7EQoGM3oNMP34Y7utGYqLFLTZUH1d1A
Message-ID: <CAMuHMdUc1Gx8bQu0ePZFxNgy0=MZv909V74A-2y6wPTy8=MEDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: mitsubishi,aa104xd12: Allow
 jeida-18 for data-mapping
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 22:03, Rob Herring (Arm) <robh@kernel.org> wrote:
> There's both a user and the datasheet[1] indicate that 6-bpp is supported
> as well.
>
> [1] https://agdisplays.com/pub/media/catalog/datasheet/Mitsubishi/AA104XD12.pdf
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

