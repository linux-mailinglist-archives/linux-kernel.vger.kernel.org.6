Return-Path: <linux-kernel+bounces-176252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1004D8C2C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F352845E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D11713CF95;
	Fri, 10 May 2024 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G5H0K81Q"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585013CABA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377570; cv=none; b=Fe48mBFInucL23eT7746NLCppm/D6jt22qPRikRWkp2gpLgzUnTV/AkXjhpJ5W1bPJKBVlpTiFSMv5mY07tzyUiXF47yoI96q4Yx1QLwK6QEFxUud/ibf4HqHzDIM9LGDw0SDN8F/BoIrLuDDGp/c+7ljzZdVrnH5Yrkf+2IIw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377570; c=relaxed/simple;
	bh=8hyhtvYTwN5czgZGq8pHp5LFD/yan+Y00HMkOubB6Ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kx3O+aNH0flSvxU7di1Zw99va1SStClOVFBUw0sGLnqHEbgOLvMyVC1ah6lpacjLpV/7ltVEFdOQ4a6ngzK0CMxkLoKRoXf9g51BkhGF4jgHCrW8BNbhLUC/i+W18h/vFxE3+oueRc/uqzgDqt/k2HdjjAhM8KU/WLIIXcQ08k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G5H0K81Q; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78f05341128so161074285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715377563; x=1715982363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bvvrDFDvWHbWDsL+5kPsJMRg9ZQU9jFtg6oP+9eLyU=;
        b=G5H0K81Qpy4ad+UCaeAVoOcKXjQgo6WejIHSkBPyjDPxw7rmwpSMinF6eEd+4EgYNn
         kG7kKRWo3Ha0kRYbZ8TbqQlhYOym574yR2++sW+gbqDR1qCYR4+tqmW05grBJq1MfP/X
         IbU40LzFz4MuOV4vG41D7UxhRwmQ7lYJamI6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377563; x=1715982363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bvvrDFDvWHbWDsL+5kPsJMRg9ZQU9jFtg6oP+9eLyU=;
        b=AfNXEoEYX7xuxi5HEv3gW7vadXpPhMk3hhyAGcCfn3BxikG/glyxh2Aqk5AfTWty5T
         QEwgX4Je/BRX3gLczV7uBc0AQg41sIfW4+D+ivyCNba3/Lj38z0mYuT5XFHS9dsxHcO/
         qDqNoFR3nwt80jItIg7P0M1b3l8dfWPb61RNrhsBgl3sFcPsPhxf1HZGKl62vLBWIA96
         4KaClVgOGLL5AJq9a3ArFm+Vy+1TczVq/1nyTx2AkOtIwsrawKi1HYzg9mgaifd2rQqV
         0r8w0C9t8QTDTEq/tDVZ5qZyQyOnY4X18VrDjNAnp8v3D1MguUg0BRp8Aw7MuznnC6Iv
         eVzg==
X-Forwarded-Encrypted: i=1; AJvYcCVWmEgcetBC0LlOpxpiXJ9AoE9L02p7ocXDjrbXmXv++fr4eDKoSP7if8nAhJd36nnUrYokGU4PDgrY5syntIcptOJM3ppmdOZvnAJk
X-Gm-Message-State: AOJu0Yx9AildMzokgxW0DmbVMAN5LSYom0wCHJUIvUKVs1DraHT4mxgu
	jT3jW/XL+g5J+hVXNBxuJmmrwDfDW3VZ5Gp/P1oPY+W/KYOOt9hWbVDzs8Gi3OwZKARZFljH6po
	=
X-Google-Smtp-Source: AGHT+IFKfBpDiM3ItIAuMtpS4e+3OYiNq+ESvII6JPDMO4oH8G3JDGWsIo08n06OK8bmE+5EqCBTMA==
X-Received: by 2002:a05:620a:cee:b0:792:8dc3:d714 with SMTP id af79cd13be357-792c7610931mr339947385a.76.1715377563372;
        Fri, 10 May 2024 14:46:03 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf315009sm217860685a.118.2024.05.10.14.46.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:46:02 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43df9ac3ebcso97221cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:46:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvJqmavHtt5ZEWJ9KtQenvKQ4UnEMGqQ17cQfWjwB8xegmxprWDhivP/hi/ApX6hfDDeQPmrap/wI0UjVn1eDan1iUzyepKhQ3m5ho
X-Received: by 2002:a05:622a:5407:b0:43d:e9ce:63ad with SMTP id
 d75a77b69052e-43e09222ee6mr1021081cf.0.1715377561384; Fri, 10 May 2024
 14:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org> <20240510-dsi-panels-upd-api-v1-1-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-1-317c78a0dcc8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 14:45:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UuJF5Nv6qLzH8SK8NPfHa6Qwp4XOwkLUYt2Rv8ACjfeQ@mail.gmail.com>
Message-ID: <CAD=FV=UuJF5Nv6qLzH8SK8NPfHa6Qwp4XOwkLUYt2Rv8ACjfeQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/7] drm/mipi-dsi: wrap more functions for streamline handling
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 9, 2024 at 3:37=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> +/**
> + * mipi_dsi_compression_mode_ext() - enable/disable DSC on the periphera=
l
> + * @ctx: Context for multiple DSI transactions
> + * @enable: Whether to enable or disable the DSC
> + * @algo: Selected compression algorithm
> + * @pps_selector: Select PPS from the table of pre-stored or uploaded PP=
S entries
> + *
> + * Like mipi_dsi_compression_mode_ext_multi() but deals with errors in a=
 way that
> + * makes it convenient to make several calls in a row.

Your comment is backward. The name of the function is
mipi_dsi_compression_mode_ext_multi() not
mipi_dsi_compression_mode_ext(). ...and it's like
mipi_dsi_compression_mode_ext() not like
mipi_dsi_compression_mode_ext_multi().


> @@ -338,6 +345,18 @@ int mipi_dsi_dcs_set_display_brightness_large(struct=
 mipi_dsi_device *dsi,
>  int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *ds=
i,
>                                              u16 *brightness);
>
> +void mipi_dsi_dcs_nop_multi(struct mipi_dsi_multi_context *ctx);
> +void mipi_dsi_dcs_enter_sleep_mode_multi(struct mipi_dsi_multi_context *=
ctx);
> +void mipi_dsi_dcs_exit_sleep_mode_multi(struct mipi_dsi_multi_context *c=
tx);
> +void mipi_dsi_dcs_set_display_off_multi(struct mipi_dsi_multi_context *c=
tx);
> +void mipi_dsi_dcs_set_display_on_multi(struct mipi_dsi_multi_context *ct=
x);
> +void mipi_dsi_dcs_set_tear_on_multi(struct mipi_dsi_multi_context *ctx,
> +                                   enum mipi_dsi_dcs_tear_mode mode);
> +
> +#define mipi_dsi_msleep(ctx, delay)    \
> +       if (!ctx.accum_err)             \
> +               msleep(delay)           \

Please enclose the above in a "do { ... } while (0)" as typical for
macros. Otherwise you could possibly get some very surprising
behavior:

if (needs_big_delay)
  mipi_dsi_msleep(ctx, 50)
else
  mipi_dsi_msleep(ctx, 10)

..with your macro as it is I think the "else" will match up against
the "if !(ctx.accum_err)" inside the macro and not against the "if
(needs_big_delay)"

Also: nit that the mipi_dsi_msleep() should probably be defined above
the "mipi_dsi_dcs" section.


-Doug

