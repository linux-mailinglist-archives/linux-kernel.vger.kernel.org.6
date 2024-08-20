Return-Path: <linux-kernel+bounces-294583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A711958FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A939F1C21CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FA41BA87C;
	Tue, 20 Aug 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oh6nLsqp"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1918E342
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189118; cv=none; b=Wu8xEzPVqSdqKL7SO2NRaLM10ecvFJ3uHF4HVjkDs+tgYF400QLAplVw9bjICXqcjZ4SMFlZ6owLI9Ic67aCaboP/zwII/tbyXgJ2tXPZHvwoWkrb/4swnUHgFe964ov+m/klPNSmpUIG4ZcE4DFQe0sduyqc17tjNjOUDFbk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189118; c=relaxed/simple;
	bh=Qv4ehGRjXy6Q4wX9nUtlj+ZO/TrQBSknRT6zm7ZNKr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alVNUohLXYMkrCnoCgDwtyQDk3zDOgZKjMzkKOSkwR5MbeGPW3osJvoX71rCuxbSiQe8bPeekkb53xgKRXJnbGzbD36EhAP1J3zvViTFiU2cy/OSmM+fTlEqb7Lw3TVt9kQwwtYy+HbCWdYHwg1sLUa+cb9pPHveD5tr71CK07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oh6nLsqp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso4775991a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724189113; x=1724793913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLr3Sp9hILIFM7YEA6veudfeiN2EX53d+215jFnEYFQ=;
        b=Oh6nLsqp7DWPqDmvjaiq3VuCLFMzQVox2XR4AYZnMiUaDGWwHfgX84Tbt6FZPkFAWH
         zGWzqc45fvkxVnx1CuR6bujvgKbXltpybrBt2UV6x8+OKaLhNgjrdjMzhfFJqC1V+jDI
         /hBKVszBNTJowPaFEukwWmLwEBWVdFO9e2u6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724189113; x=1724793913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLr3Sp9hILIFM7YEA6veudfeiN2EX53d+215jFnEYFQ=;
        b=EzVEcF/ml2fuWeyFLqlrPa+WCt+vAD48PYkDJTJj2aHUvmlNLlc5soPwpkVWcmlJP0
         COkplSpNbnBmjPMIPnI+zLWDw60quIMgQRHFR2Qmfulv4txJE5ONg9woKr/n39rESdB2
         44tr4q5ghVZdB0N8YmjyUiZljDcGiJkbLOLaECLs1XTZomMV02u6IebdrZ2rO0tAj5Db
         xLjqCGcCNcjc+sqiA3sG+pweU/8kq2nfVHXV6zOBwkj4aLO8uprs45XqeqVIxFnjoJhg
         /MGLRRG18BcuPafaJByDRsiuR58ZAoWctn701biveW0uq555qm4kUSRgymRWSXaBfynh
         XKxg==
X-Forwarded-Encrypted: i=1; AJvYcCVQnMw2RSBa+SgQonPBfM4jkEx/INQ7dOS4e0cYuIDxlMPUxFom7VGe2k1iQ3UqoXSubb1ZlOJQl8xsmK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRzlJtp+J+zNauypWDCultoerBsrY1m3LwXqbI/ri09HsoLwif
	FaC9V4zP4w6x96pbKipaAOSylvcd3n+YzV8r3ocJ4b6e8rblTPkIpO5xZ8hjjMBf1t+0xqcNwdI
	YvA==
X-Google-Smtp-Source: AGHT+IG9Buk17LvZRq7pnNLcXejHxYzT9WFchYVJXmgaTgeRrVrlrPIYo5ZdzzFhcao+rVTiqRpnRg==
X-Received: by 2002:a17:907:e2d6:b0:a7a:ab8a:384 with SMTP id a640c23a62f3a-a866fa002d4mr26007466b.64.1724189112912;
        Tue, 20 Aug 2024 14:25:12 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394645dsm816107566b.144.2024.08.20.14.25.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:25:05 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371c5187198so944669f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:25:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsT5jTQjPZdg1Na6h7kQhWbE0/ThfqLqC/+Bcp2QhT2AwK/1ya3clQ5/rlzwUKlmC6qNvQvqBTd8miKjc=@vger.kernel.org
X-Received: by 2002:adf:e0d0:0:b0:371:7db6:89df with SMTP id
 ffacd0b85a97d-372fd5abb45mr141748f8f.31.1724189104354; Tue, 20 Aug 2024
 14:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818060816.848784-1-tejasvipin76@gmail.com> <20240818060816.848784-2-tejasvipin76@gmail.com>
In-Reply-To: <20240818060816.848784-2-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 20 Aug 2024 14:24:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XuF=WVMd7AsyhUcrn9P_O0YQDjUQuCDfArXZV=ZTeuMw@mail.gmail.com>
Message-ID: <CAD=FV=XuF=WVMd7AsyhUcrn9P_O0YQDjUQuCDfArXZV=ZTeuMw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 17, 2024 at 11:08=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> mipi_dsi_dcs_set_tear_scanline_multi can heavily benefit from being
> converted to a multi style function as it is often called in the context =
of
> similar functions.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  2 ++
>  2 files changed, 33 insertions(+)

Since I adjusted the whitespace on the previous patch when applying I
had to adjust this one to fix the merge conflict. Then I also fixed
the whitespace on this patch since the DRM tools run checkpatch in a
more strict mode. :P

In any case, pushed to drm-misc-next.

[1/2] drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
      commit: 051c86afc342aed1f84d66ff5d09dc9e1c1685a1

