Return-Path: <linux-kernel+bounces-574042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E84CA6DFE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97753A8FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C24261390;
	Mon, 24 Mar 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QVKyFxnR"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F2261380
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834211; cv=none; b=KnYsdeiwNmCP/N7ldoP9B/SqWhmpo4YyqxTsD4p6Sg/H+jmr1aZRB2Gs3Wbh/s9bH166XS7K4iKr5bSLJ+JyO/WC1QTcYp7bIpE+CI3NiKasSTbBTJVjVbPXmvYVBztQhykBbGMVHAn0sCoub+hRULPAy1OcI2l3gRLSa0f7QvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834211; c=relaxed/simple;
	bh=T0OaTV3U3YTC8+B6JtQmMAnjF+aMrFR3h1bWX2bdKDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0GbFMbUbtBILfod1mVM9obpXus7bV2ITew27Fry+FtqiZdmVtuJw32j5fuY/dNrYsINw1EXbFs7rERLlZ2B3oCqcW1qyAx9SS3PqoxObAo6gMFQptQ6KOTUuYr/cn3/ydMrJ3J6EaFFbcfWa3pfi0FrrQu167sAPfylcYsFjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QVKyFxnR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5499614d3d2so5318215e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742834206; x=1743439006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbVSfwSwUsyBVRZtdurPZ1fEIzsDEzw5c2RH7LloXHc=;
        b=QVKyFxnRlEG1ssj0yDCQgTERshQizqssTNczgMQ0gukIJMWiY34c/8ctnI/JzzDRpU
         EfKYIsbxw1lDhxNZ4LV2VtohellwDAosQ4SQhYEyWegR4Cc6FrjP9ClLZhwfYli1YL94
         64s6rRtJ8BPLvS8+hC/hqaGS7TmoUAGYAPQIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834206; x=1743439006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbVSfwSwUsyBVRZtdurPZ1fEIzsDEzw5c2RH7LloXHc=;
        b=urd9RTAZfbUbEX8MOQlsMcaWktkk1epsiwSCnYbTYuEmT+RHAyLugvvaNx+Ob3FE2U
         HR1MASricPwuY4utcw3AEElQM0+117df4Vtu9aD/7gbnLHjLNL8Guf73u2qemgxhPytV
         uNtK6UBeWTN1S1Q97BsOO2d4vkGLBJZuACcjorIyXWs/DaN2IsJoH/Ghs8SY09hzpM+Q
         qzvMp4k4o55KEOnlcl2JT05mo6oCaxi8lAzZDE+7JllH+4dbX7ExfS4dSRePuGrWyBsD
         u8Y2FTwF7gIMjn6ckoJ/ytS4JwjHh+bsqt5vXwIiy6XddQgYF9/OffGYdkwPwqU4CKoL
         kvKw==
X-Forwarded-Encrypted: i=1; AJvYcCVJDRATmzW8YQ0LWr5bRGQ7CuHvHFQaOlMkXGNDiKRQVAAXx6kromDDTaIkIiR3Edvxh66YElfLPmHu954=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHJj6fcwuHRdARf7kA+0TIRhkB+KB6lyWXjF+SVq04+Xq5Om0
	BJ8hswlbQXbFYBhnuCU0gAAQq7Huts0cIcqRSA0gYq6pXgvQC37OpwkLZh235oHP1nsdRJOgGTH
	KpA==
X-Gm-Gg: ASbGncvo1NdytvNrGA9bLKzSCgvW6Oc+jaZH4J9bCLRIit1BNFwEJZMCnWqvWo3PLx2
	AY1xOWy1h+jaJyVYAiSoo+7FabhmhN6Ppf0ILWw7Sqt9hL97CeYCsvbmzff3AxjJQTifstTWDXO
	30sFsF+NHBvbFJfjFC3ZLbgpddosv3+UbQL93/R2A1Ys1Jms/wBNaiinRPruhXQnY3zJRLKG05/
	Ve971gf78UyOtTceD1iy6zSfvbmgk9f/AM5k/J1WFDk+rqeQ1LEraxqqxUwvmWyLJlo4aYDVS7S
	M7d04KZzBAhP3h0gWi2jQ9ovezernERYtHoD0fHSE/eI/UFGNWR5k23pFgvaILBxeMdxyglAqxH
	hujpueTGo1/qp
X-Google-Smtp-Source: AGHT+IFq2CHSfuK8hE7OuHIhcS/bd7ba8ojWVzH/gxwTT6AagGY5Ep5QbQpGmFLVzgcYCrSnWYmauw==
X-Received: by 2002:a05:6512:118e:b0:545:2f0c:a29c with SMTP id 2adb3069b0e04-54ad64ef026mr4977316e87.36.1742834205845;
        Mon, 24 Mar 2025 09:36:45 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647ca43sm1195360e87.68.2025.03.24.09.36.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 09:36:40 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30613802a59so48475761fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:36:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCG/VQ080sJDRwGMLnTIwqO7q2h3EEKIQ61It7acbedNlMvuXDvSIH2Lz92N/kn0I/JhlqbLVlP7lf6oQ=@vger.kernel.org
X-Received: by 2002:a05:6512:2394:b0:549:5866:6489 with SMTP id
 2adb3069b0e04-54ad64fc6c1mr5079567e87.47.1742834199580; Mon, 24 Mar 2025
 09:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315182522.628187-1-tejasvipin76@gmail.com>
In-Reply-To: <20250315182522.628187-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Mar 2025 09:36:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X0Tn+=M8oYsxtT=g7etQ1Fsusn_O3_K4MD=n2rQRdxJg@mail.gmail.com>
X-Gm-Features: AQ5f1JqXvIcRz_JthPYvuupBe3v23vMi4-VDj2o_1AcvqTjIjsr3L9gaH4gwORg
Message-ID: <CAD=FV=X0Tn+=M8oYsxtT=g7etQ1Fsusn_O3_K4MD=n2rQRdxJg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	lujianhua000@gmail.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	asrivats@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 15, 2025 at 11:25=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> Changes the novatek-nt36523 panel to use multi style functions for
> improved error handling.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v4:
>     - Cleanup nt36523_prepare
>
> Link to v3: https://lore.kernel.org/all/20250309040355.381386-1-tejasvipi=
n76@gmail.com/
>
> Changes in v3:
>     - Remove mipi_dsi_dual_msleep
>     - Change mipi_dsi_dual_dcs_write_seq_multi to use the same dsi_ctx
>       by swapping the dsi accordingly.
>
> Link to v2: https://lore.kernel.org/all/20250307091519.245889-1-tejasvipi=
n76@gmail.com/
>
> Changes in v2:
>     - Uses mipi_dsi_dual_msleep
>     - Changed mipi_dsi_dual_dcs_write_seq_multi to not equate accum_err
>       of either dsi_ctx.
>
> Link to v1: https://lore.kernel.org/all/20250306134350.139792-1-tejasvipi=
n76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++---------
>  1 file changed, 823 insertions(+), 860 deletions(-)

When applying, I did get a yell from the stricter checkpatch mode:

-:28: CHECK:MACRO_ARG_REUSE: Macro argument reuse 'dsi_ctx' - possible
side-effects?
#28: FILE: drivers/gpu/drm/panel/panel-novatek-nt36523.c:26:
+#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd,
seq...)    \
+               do {
         \
+                       dsi_ctx.dsi =3D dsi0;
         \
+                       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd,
seq);       \
+                       dsi_ctx.dsi =3D dsi1;
         \
+                       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd,
seq);       \
                } while (0)

That's not new though, so I went ahead and applied the patch anyway. I
think the easiest way to solve it is to just assign "cmd" to a local
variable inside the "do {} while(0)" scope. Pushed to drm-misc-next:

[1/1] drm/panel: novatek-nt36523: transition to mipi_dsi wrapped functions
      commit: 15a226179c55ffef2e0a883b6bc15eaceff4a08d

