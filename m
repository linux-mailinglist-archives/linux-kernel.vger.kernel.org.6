Return-Path: <linux-kernel+bounces-575625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB908A704FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C39B188652B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1499C1DED46;
	Tue, 25 Mar 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F24vtrfz"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD881749
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916259; cv=none; b=Bc4CE8zkyafVhNvaH0nzDogcOh9PehksohWrY5fZXhztoG99zRmih9h6+SXqz1+f42vfAW36jGnhelXbzDES/mBLHElTvbQe9j0NKJhlfLZKwGhBedHveTaDWVFIl3VZxdT9oM1jDzuGkHLxSHR2Hy4LbnejSBbKrzaubyGLW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916259; c=relaxed/simple;
	bh=L7na/8WdST7iNZ4InUa+H5JMUaPlzDdGv1VdBm7+V40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIlAjvJaLo80uur9KB1WsfWpN2q3F+HbzkLcRL94oDE3VgZ+thpVaxtEYmK/9Npqfk3B579YidPlppCF5TouHg3PEq+k4CuL8S06/Jim7e0C7dE+5/NLA1dqNFr6iKxCb5Mun8KqdtH7XNA0h2ViU19glAbT5cZv+F3/lW8mzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F24vtrfz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549b159c84cso6452055e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742916250; x=1743521050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3+8bsc2QVqd8YR+1dNBTuUVkIye6hV+ORmbDcd3a38=;
        b=F24vtrfz72WbsuVQPsuNZX44TD7d9CYiahzUYgBWlJrcb4RcTp9bHiMI1B0/UtcH/n
         GdgDySABqnUEHSBl+VAY/sXjQHVELr9mzF037BzadVZb1fBm0O0ogNYmUFskR9KC+LN5
         dqsZZCtbyWigpQMGnrNDYOUkgJbfqQW/Ke2ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916250; x=1743521050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3+8bsc2QVqd8YR+1dNBTuUVkIye6hV+ORmbDcd3a38=;
        b=fBCslhKH1SdcHJvOzm3VupjVO+b/bHg9XakVtx9eMF0XtxM3LLTrkX/6+G1AcHIV4u
         8/q+ujMhp2DXBm3r4ZYyBWoqqaHdNJ9MYkuqyjuGxgARc4FevXkuTSAvOoQJ+ZEjwEbk
         ZPQfiZa5U/mgm8iERIBp0g06zznPM2BlmHrmO7cYDs1MfN6Q3TRDdrvGiP5NTLEzKwLt
         Oyh9Cmfnv+4bS/iPUxzQw89xI1d9kKP+eLh4v2oJbc8/hQOiD6gpLS+ifWJtBDCVaHlP
         GovThnaLeOZQYaVZ9ClTYcmzfKtoi7TsHoUvIS5oyXCqjZ7f8t6XB2YwtOuYm5DYKh2F
         2Ziw==
X-Forwarded-Encrypted: i=1; AJvYcCVm8RmknMz5uIJr2BpMd75OZbzHbZeYQNRBJu0mcxgFfrmowVd83UkW0QJ5I0ffyFqqQ268efMGVupyM08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn0Nm2idTExiLDQ10W1XFzhIYybahbIUoeRp/ohbvzUPOrUjBu
	A/WwOPTvp2apBxpVgnbn6Qh9uVo3cOM/HUZdG3I30DAPOuw5+AdJhqxg2tAQUwnocuaX7DjPrbB
	v8pO4
X-Gm-Gg: ASbGnctoY4b+ArQKnVnY820wpprPNwK7gSahGTMz/YA2VKWUjfF/+v4BjpyMxCrz6lQ
	ohFfrAv28GoPexxK7nBQDwk1O5C27uxps7/1er1LJDL4KMEJJSBk0UnoiXMEwfyZxAthbH9E6mB
	uu5Zr5hlx3Yn/yXJh9Q/m6LB2oxPEurcxIfrpmFOm1o2dpifcoG/R0+aYjgi/ydP8wrZ7yldNoK
	RwNU/JoQIo3m8EsRfLctawU4AWZpOXtqYPkfzfJMzpInkM+N3t/kFRT5WJupTV/catx92RR88M8
	GUCyN2Bei+16T4bB2ieHUwZYZmSmbk/qEtWZfFM7+QCww27Jphu7vRkHTiEXYSn9VQqkl1JDwZN
	q+OTPr1lcwYaV
X-Google-Smtp-Source: AGHT+IHdqlKVwhJZ+0FwLnPVDAl7cNGKpgW9Ymq3QkHUYPEa8cAkyf8GckBWYkAkPcyBBXr6dzbicw==
X-Received: by 2002:a05:6512:3b06:b0:549:b0f3:439c with SMTP id 2adb3069b0e04-54ad64869b7mr5213667e87.21.1742916250370;
        Tue, 25 Mar 2025 08:24:10 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad647c9e5sm1522930e87.85.2025.03.25.08.24.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:24:09 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso57557581fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:24:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLCDAxSgnMyEqgdmHxtL2QNksgl/cS3XZ6Kl3vQDvygZFWnxTOa6dW7Byj25FbZ077LnBS1v7qvtJPz10=@vger.kernel.org
X-Received: by 2002:a2e:be0a:0:b0:30d:62c1:3bdd with SMTP id
 38308e7fff4ca-30d7e2ba26emr74845121fa.23.1742916247223; Tue, 25 Mar 2025
 08:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325094707.961349-1-tejasvipin76@gmail.com>
In-Reply-To: <20250325094707.961349-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Mar 2025 08:23:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WhVYBjGYJFn7Ooszx5Wgk47vLPj_59MWU6t=LQ-iJbTQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrWE2x9JIn0TPRim15TMFG4kF_9Ffm6HQx-1emxlt_BczIgP8cT-z7urPc
Message-ID: <CAD=FV=WhVYBjGYJFn7Ooszx5Wgk47vLPj_59MWU6t=LQ-iJbTQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: himax-hx8394: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	megi@xff.cz, javierm@redhat.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	asrivats@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 25, 2025 at 2:47=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Changes the himax-hx8394 panel to use multi style functions for
> improved error handling.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v2:
>     - Revert behavior change in hx8394_enable
>     - Move variable declaration to top of function
>
> Link to v1: https://lore.kernel.org/all/20250323053007.681346-1-tejasvipi=
n76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-himax-hx8394.c | 441 ++++++++++-----------
>  1 file changed, 210 insertions(+), 231 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

