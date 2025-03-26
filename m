Return-Path: <linux-kernel+bounces-577058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A24A717CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8F53AB8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3B61EDA3F;
	Wed, 26 Mar 2025 13:52:30 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F5189919
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997150; cv=none; b=FCGPhwVyPElf6HipvpYeC317a5gnvxrzYE/Ebvwn/aw3rIoDxp8G4QOfk+4ZqVH1DW0iEgdFszwn/EJ2wxrxcjIOrO0dn/e2c0uZVM8d6ddutilSgQa46Ugpz+BuYCvjs7CggN3cCYi4/HpLt8HJ/BfC/KH2NfeKV6K1HbqcRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997150; c=relaxed/simple;
	bh=KbFGG1M2y5oU6TICtm2iJC8yme25i6OSPgZrTMhA99U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QD9Cq6oyQwdRcJR4sXkpcBVTqHy/PkMEqcpZfZJk6kqo6wppbzNcBZl2LyCXwqjXUWvA28/fEksV645iBO43ig1Y5o2b1WyZcH6agJfNrBshfNF6fQTJn8DGb8vJmIGekH/2ea/LIgWLYu1y8f0Ks9gnzxfzI+cmm+1/KeWksUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso7206793e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997146; x=1743601946;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcKm5/tXdE/0WU8n3kR6lQGyuHWkdDdazDILzFNqfS0=;
        b=Ef4GkJRWrfIrlCCKL4crUzZ+bmNRqPNzH81MSuYTEZEltu6/lYSoKpYa7kgoWMauzj
         gkm0YLPAv8OYZ2QG9LHR+WsFmI/UKEpwyr2NAWzlOneS3oYK/6QiWpgyQIkrCIslBumH
         kJ65RWS1sLNQuJuQwJswdMjf/uxj+AmfJcaf6s8R0cH9S7q8zTDg1VvBEF9KmsS4hFs7
         C9QhyHJOdRrvH0CnyP/0nbQbuV3ZDVxcq8xfoNiLXA53eYGqDPNp8Vw3SEFsNhJnYkcC
         u4Mw3N8XG9pOxVzHHn+LvhIh6LYaek0m9UmOzWjb1RuZm4MUf+NUoKQ6jljMncs+lm96
         HpaA==
X-Forwarded-Encrypted: i=1; AJvYcCU+JZncK5RX1NHTtO2wgfr1QoReM9ybshoYiDTN/EmYWBw6ClBrrgpQhnTJD577iv3z3RVo0vF/C/LicSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnI8rINOvGAERDGidPKfx+N7Fr8yk20Y5oQriVzuMAv4a1wT1S
	q1gIXxtQQ11pQNZe8gkWGZmy2VzdXEqugRjFdKkRbCeZ8bAUz/QAJCJ81/qiyyI=
X-Gm-Gg: ASbGncvxqsbXB16WaYILva/julLWtv26+GB95ybk/0Ny9/Ctfv4/hqcGtjOJ16Gso80
	p9t7h8F8R8dAqA6mvV9pk51VeGohDM4yW8iW8fn+QsMScNG7obvGlv13fUPmc8kqwrQnkhbhcNq
	OUyrgg2HmffeIcsO84zHRfcVsF5+gvMMlaXGjhY4Oly4GPQ0c1y57YCb4znaTF8mEYNFvqdZdRP
	2ZhkIp4fDz6kqxarJhGa42x2xnMPNY6DoLfodMikKmzCHnfGLdVMdLa8B8G9ktM7RveDLEzPAlR
	9aTTJSAGHb2eSd58C9+LrAklfgPubPjpxs5hpc1OftL3mjpS5UM7w5QYylT+CRKQgeB4CxIt91j
	c6T5zPrI=
X-Google-Smtp-Source: AGHT+IGdExbhGY+CXoOUtR9cV4T54CwUM1kMHEVqDlk/yOwSjvRDnKWpOkRNIlNfpIYuJBkhEBh22g==
X-Received: by 2002:a05:6102:4403:b0:4bb:e8c5:b168 with SMTP id ada2fe7eead31-4c50d4b65e9mr15237119137.10.1742997145973;
        Wed, 26 Mar 2025 06:52:25 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bdb5cccsm2335196137.26.2025.03.26.06.52.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 06:52:25 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86b9d1f7249so6259920241.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6xPB96QhZ8xzmsCDe0WouQ9Hoh0MgI82EfIPUeS6+Cbs0KYVPsestJCdJGSyI+Xz+hT1zEFXJOnc1K7s=@vger.kernel.org
X-Received: by 2002:a05:6102:3590:b0:4c3:2803:61c1 with SMTP id
 ada2fe7eead31-4c50d5e36edmr14466273137.18.1742997144422; Wed, 26 Mar 2025
 06:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com> <20250326-xilinx-formats-v4-3-322a300c6d72@ideasonboard.com>
In-Reply-To: <20250326-xilinx-formats-v4-3-322a300c6d72@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2025 14:52:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXM1B1c=62EpcuUdpdpaBRZSJLXb1GBB0egzp7Fyeo5-w@mail.gmail.com>
X-Gm-Features: AQ5f1JovrLSxq6Q_jny8lkH2G_0PglV4cgpMVVF5cOjinLTQjx6uJi6K2dpIvwc
Message-ID: <CAMuHMdXM1B1c=62EpcuUdpdpaBRZSJLXb1GBB0egzp7Fyeo5-w@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] drm/fourcc: Add DRM_FORMAT_Y8
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Vishal Sagar <vishal.sagar@amd.com>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Tomi,

On Wed, 26 Mar 2025 at 14:23, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> Add greyscale Y8 format.
>
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Thanks for your patch!

> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -405,6 +405,9 @@ extern "C" {
>  #define DRM_FORMAT_YUV444      fourcc_code('Y', 'U', '2', '4') /* non-subsampled Cb (1) and Cr (2) planes */
>  #define DRM_FORMAT_YVU444      fourcc_code('Y', 'V', '2', '4') /* non-subsampled Cr (1) and Cb (2) planes */
>
> +/* Greyscale formats */
> +
> +#define DRM_FORMAT_Y8          fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */

This format differs from e.g. DRM_FORMAT_R8, which encodes
the number of bits in the FOURCC format. What do you envision
for e.g. DRM_FORMAT_Y16? fourcc_code('G', 'R', '1', '6')?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

