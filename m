Return-Path: <linux-kernel+bounces-173902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D518C0766
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4B728442B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A14288AE;
	Wed,  8 May 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hgKBO+1t"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7950168DC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715208090; cv=none; b=ebVOcfJoCa+ZcO18IyUvqdWEYWwnzjnR1IP7Jz2Y9BNQFwSjIRyjMfLjLz1pVoDYWh+3YfXbQ3jmGquCaJXzNWwEcHC5fqv2X+Lx88S0JGQcPXXBWsBML6z6vWgluY4waaVdUu8g4Z7i6/I+0/kHu6744CbyofJhaq59JfoQUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715208090; c=relaxed/simple;
	bh=URL+ux74FcLHKQ/ZvQJboYQjgTPCQONFknkyVXoRCOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7PuT5gXAYYhhaTnbq7Xuiz5WczevzukfkcX1R6RU6CF628ae1xxKGSan8RR/jUQvG5U1C3Cbo139XWYtpIht96czOfUa6GeGD/gJZ/oSd/nU9Jnq44M66Wayiusi4uuW9ZUdoRWJYPlO/5FJpWSpSse5ntD16dUFEjoX4A6Yjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hgKBO+1t; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a0013d551so23623066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715208087; x=1715812887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwxEO1i5UPI2XEISzMMX9ftGaU8p/mPogEOhXcQuJ0Q=;
        b=hgKBO+1tGl2fxpcNnBBbDNubCZZvb3OxUzfSUAf2iIOMinZMNB5c/UPYlNsn1DG2cU
         oEI0wqNgDArVov6Y3bb/2rps46By51BOlhtgARgSzQDGx2Am6Z+2G2/ZHoVLMjnRibzp
         0wBBtghE61ynB7CQNrl3BXeDwIqqsSxG3XrzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715208087; x=1715812887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwxEO1i5UPI2XEISzMMX9ftGaU8p/mPogEOhXcQuJ0Q=;
        b=HQXAH3F6ymQOwNiWjST8ZZ0XYiMfo8mRme/lJIaYkw+nSgzRnWW/oaudYGDGvEkXgF
         ABFqMCWH/92QqYfcm5tm8xaKJDAyJ7nhj6520nN/Tol2Yc//vR8UwT0aAhoVGgqQENbM
         qfrGlcWj4vyrTVcxyRIdng92IpT+0rzOpiRx15Oq8mVIVKzyIrXRWTbXRsK0Eq6vQWNG
         HphyBN9qR1P7BYPKb4cqEhQqUmj56BUNlVfA9HOTelRR52vTwwGtF9sBl5tamLeAllyM
         jpUzZOlU+GM73yhUNwYBRQpngBIbQKBaVU6NrSBYSuyyQX18zR/oFf+gJm6UFy112bil
         we1g==
X-Forwarded-Encrypted: i=1; AJvYcCVuG77FuN3k0muOxX/DMIdpfIdpH0HvhUYcakSuj2GYOVRTlS4NAfginiY+qTGCG+3wEpukBHO45vGCR2Ensh3U82sOFMpaTYUXDD40
X-Gm-Message-State: AOJu0Yya4bdb4ddCELFC7L5lTw+QNVu4yn8msKd04rkqopgGF7yPsj80
	Lb6cWqp8+kJ9SvWJCXnNVJSmqwihibKKs3SwcYjkwyMYmAvgsZnYb38clIZl/DUNnFZrXFtINT0
	+cQ==
X-Google-Smtp-Source: AGHT+IGMbRoArTZPQShoms4RBLzYw6guvw5O3BrOJ/ZcCQLmKdoAi8/wlxR5+eoV7ObYc3nTcKNN+Q==
X-Received: by 2002:a50:8d06:0:b0:570:3bb:e099 with SMTP id 4fb4d7f45d1cf-5731d99b86dmr3263753a12.1.1715208086824;
        Wed, 08 May 2024 15:41:26 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322c3csm50153a12.83.2024.05.08.15.41.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 15:41:26 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41b48daaaf4so33885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:41:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsLFJTfFWUIs/Wk3ZxNbZoJensJPWdKkRTyz3OkW0hiFXcbE/KwYRmA0etQ3t1G5BrzYJfSvb9o1cbKNn6YXEJgeTKRc+NG/Eo5rSK
X-Received: by 2002:a05:600c:b5a:b0:41b:e416:1073 with SMTP id
 5b1f17b1804b1-41fc27b0e81mr775855e9.0.1715208085721; Wed, 08 May 2024
 15:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503-fd-fix-lxml-v2-0-f80a60ce21a1@linaro.org> <20240503-fd-fix-lxml-v2-1-f80a60ce21a1@linaro.org>
In-Reply-To: <20240503-fd-fix-lxml-v2-1-f80a60ce21a1@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 8 May 2024 15:41:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnpS-=CookKxzFM8og9WCSEMxfESmfTYH811438qg4ng@mail.gmail.com>
Message-ID: <CAD=FV=XnpS-=CookKxzFM8og9WCSEMxfESmfTYH811438qg4ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/msm/gen_header: allow skipping the validation
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Helen Koike <helen.koike@collabora.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 3, 2024 at 11:15=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> @@ -941,6 +948,7 @@ def main():
>         parser =3D argparse.ArgumentParser()
>         parser.add_argument('--rnn', type=3Dstr, required=3DTrue)
>         parser.add_argument('--xml', type=3Dstr, required=3DTrue)
> +       parser.add_argument('--validate', action=3Dargparse.BooleanOption=
alAction)

FWIW, the above (argparse.BooleanOptionalAction) appears to be a
python 3.9 thing. My own build environment happens to have python3
default to python 3.8 and thus I get a build error related to this. I
have no idea what the kernel usually assumes for a baseline, but
others might get build errors too. I don't even see python listed in:

https://docs.kernel.org/process/changes.html

..in any case, if it's easy to change this to not require python3.9
that would at least help for my build environment. :-P

-Doug

