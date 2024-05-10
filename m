Return-Path: <linux-kernel+bounces-176255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766388C2C11
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BE51F21F08
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BCF13CFBA;
	Fri, 10 May 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aop+5SSf"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30793481BA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377601; cv=none; b=Zl/WWBrl41h9YbMmP3AXe8vWjMNdAJmmgYX/vP+zDg4j8hp/eC7ymjdeR1MLfha6Ys96Xaj6gAYvDtlvyb/K0buHStD8rlRijz1Su5cklWwTTf3J/GuoJg3ykQHJ2ivM59A2D61T1Vb4rUzyeu1sED921zhgNU/DL0FUpNmJNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377601; c=relaxed/simple;
	bh=Ww1Sz9MIS14wcu4hRiwvKhU81B0kn90wuFKXC5NtTjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cs5pFO9wbow9hJtcSXhYIzuUJVDzEIh8sge98m/9w7knMoWqp8iMp9WKsxd3/3oLzCYNsLNRdqS5BX1v3/i1jSAYWAwfQ5aa7MjHsnP+lEEBguqT27zjzvYKeTeMCu+y1G+HWSmjIcqe++3ydK4dXBpN4AYnJVJKHTW058Vx4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Aop+5SSf; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43692353718so16251041cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715377598; x=1715982398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d1FNJJ0J0NTz+lnDF9EyOouM1r5fViFb+y/0QDXvNM=;
        b=Aop+5SSfIhAU7Edij7gv3NqGL9q1pVxr6ma1+biIb6rdh9VDI4OPFTn9OX92iTkg32
         pNtRVPA7GcfzV/XCuo4CWifeVWYfzN/1mq1mz2fesRwMiXQ6iCK8JkEK2/e2brAHSnp1
         9SOoy8pAH5DKpEk1XiyW+IRcPL1E9J1MDNkqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377598; x=1715982398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6d1FNJJ0J0NTz+lnDF9EyOouM1r5fViFb+y/0QDXvNM=;
        b=QUpAMPWOJci3bjslS+ll2QynuunovflOdCBwAbDGZlTVL+eHK8fVyQx614X7JAQi42
         UBx6EzX6R/6q+I6j46yMceOZ8X3WgMqF6sGitjCCbDWuisHT/9P3mkNEOwZTSenk8CyU
         kQADppuZWKgJpsd99jwBHZz2carz/IN6XYEWYrU5MXctJfzeVuXEuUXxjUkeQHakyfd1
         5tCVq8fsiC4zQV+tMysZGzyptBfz1p2Ap0ewgvTfqcoSU94DKZ6010nAr0WM6KUHRKB5
         iNfIwORFXlNB1+kARYMF+Xg/Xt65XfkcZobbNOqWowpkgcsjQZjHdvz4sTnAKqoAi0Ai
         a3/A==
X-Forwarded-Encrypted: i=1; AJvYcCVoOuHbmP1yNlt5Db9K2UZf2yn8XV+FEXSmItbU5zlcOkHCYqjUJo3vtDxUcu2/Lqpw3/lTJAbjNlSpHZUSMoXHtVOFDmiCW+s3xfA+
X-Gm-Message-State: AOJu0YyQYEt25LCO7DAx51hjw9RpdOHO/JN+R3EDwqAi2AMO9Fw3bMqO
	WJujGZ2bTUv2Yun1h1c8qnpnGKyQGBGkgw/jEdoAW7eKstZduhUJdsfp5GXBypa2OHGWx8grDXo
	=
X-Google-Smtp-Source: AGHT+IG3GqgP1phwz8icllmzxNcnQJyCaqxlvNd1sHjGLn/lECxlJixY18+mycMv/9fxPYaAneS7rg==
X-Received: by 2002:a05:622a:4895:b0:43a:829b:a447 with SMTP id d75a77b69052e-43dfdadfb30mr44891661cf.35.1715377598418;
        Fri, 10 May 2024 14:46:38 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54dda3dsm25475901cf.29.2024.05.10.14.46.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:46:34 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-439b1c72676so41811cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:46:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/WdB26RNOMVX0itxTyfqgd4ff0AFoO4dzXopLWkyiDFkja7qBXFuEAawiqqiycg+kriNtaHPEmKnWV32VUWvnbFKhmZij9VGaNXW+
X-Received: by 2002:a05:622a:4808:b0:43a:c9a0:6dae with SMTP id
 d75a77b69052e-43e0a1d2690mr272721cf.13.1715377594210; Fri, 10 May 2024
 14:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org> <20240510-dsi-panels-upd-api-v1-4-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-4-317c78a0dcc8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 14:46:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ud3ocRYyGPPUvv4V8KN2pBTFPZey1vYTvBSNL6ty-knw@mail.gmail.com>
Message-ID: <CAD=FV=Ud3ocRYyGPPUvv4V8KN2pBTFPZey1vYTvBSNL6ty-knw@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] drm/panel: innolux-p079zca: use mipi_dsi_dcs_nop_multi()
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
> Remove conditional code and use mipi_dsi_dcs_nop_multi() wrapper to
> simplify driver code.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-innolux-p079zca.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

