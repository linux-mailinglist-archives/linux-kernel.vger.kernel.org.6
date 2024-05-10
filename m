Return-Path: <linux-kernel+bounces-176260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E78D8C2C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DFF1C21D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15E13CFA3;
	Fri, 10 May 2024 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hgqPFu2t"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F3481BA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377956; cv=none; b=i4/ZifvIdSK1s5wpwMrG0vQYBnUzmr1/QEGhXYEp5rxmN7/VziwlZwq1NB89fOOWAETvLrk6uAi3bda8+YAaZ0+jQAIYUpRMVxuaFrKa4RNXjVj6lrca4WQyLQYqf7rAY1v0+MUVt0AcDEQY2+U+iwMr8zHDq4kYIuXmlO402pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377956; c=relaxed/simple;
	bh=khCbg0yE1Li4/MZYO8gGgn9Pitc/AT8beLG2tCwBEkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COXjraCiTNf+OQuuMsn4BTh3GIDgHKpeHLng7XFNqf9g2z83jURqy5TqCbB8HUL6sFFtZvYGq5GU0iagBuDhmkIjSImlXWEVy5n3xqLwcU0O9OFUgl6u8kr6L5tu0qp0qEtoRVJXoXN6Tr9WY9dAYtsfednSlye1Ho63uqrbl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hgqPFu2t; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e1bff0bc35so33543939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715377953; x=1715982753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt6iJAjgKn/wqu2ZEGbXptum/Kwuofy0xQtcrLEeDd0=;
        b=hgqPFu2tvHkPsjAeLCFcg07b9ylU0Lsne31P+d72gDaGTOaZGrOfCf8lcD0It8QP+a
         44TeaoquvUgDPsJ55i7GTwfhTD7loBkvrMncghihhC1kkG8M+UOATtmZ6POqJ3Out/jX
         1YyGcRYmmrzYGVgyUvcW6XvdlqlyBA766R3lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377953; x=1715982753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rt6iJAjgKn/wqu2ZEGbXptum/Kwuofy0xQtcrLEeDd0=;
        b=GMVRAe9WdOlxqE8Ks4TaQlk+oBgxbFdma2RwqKAXyG79j+OE3K6Lw2pNK72vCAq9mn
         H7fqyjYilgpXKOLkIv0FucPtiHqhArhu4L3a4um9mK7m3V64lNewGkRF0pXh5r6nnsNp
         dwDEedpREpcvKSuhd/owQLx1X0Kzh1zy9ng1kcNmFHI2qFH2qbRkRFU+0DTOaH8PN2+A
         U/5iDT6U8peKgBodn7uR4d192dYhwc0/JSRppw9lHAGPQCHdzZ96sv19Y8WAn/HwTCdh
         Y8Vz93LusDEbIQ8U6KUp8BmekoXmruQtJId0ED1wZSKnkHJxlhizhVfYYrEeu5S0Rz0k
         4ZFA==
X-Forwarded-Encrypted: i=1; AJvYcCUa0O40RvmuzNxL7b7GsTMolij8kVwn3dkjRWVGQAu66xQL59gvDfqz2aLLHuW/Wixlj5TgKFd+D+HzaC0aZrqhAyu86xz8eX4pOF+I
X-Gm-Message-State: AOJu0YwDlN5gKiBpUid/BsrOZl+vrD/jye+RMfMoC8Hl8UmpasEBXXry
	hkzqB8zvcmDNQpoJ/UkvuarIm5RwvKjD2UJSAX5FaDtpKQUZYM0nMUlkzkb2XLtUlYBIWhktIXY
	=
X-Google-Smtp-Source: AGHT+IH3kHngrY8eNZP+HvW8KD39U0CrXmkAR5I5B/iZkxX6890hN2CUx0VqqD+QwJxFellfho0PBw==
X-Received: by 2002:a92:cdad:0:b0:36c:4c81:424c with SMTP id e9e14a558f8ab-36cc1391cfbmr50129175ab.0.1715377953134;
        Fri, 10 May 2024 14:52:33 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c1363sm1145772173.89.2024.05.10.14.52.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:52:29 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36c6789b520so12835ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:52:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9y4TTeFqtXhrheI1it1wSgXFpeydfow0tW1L8rBn8czhaduIInONEc5xstvISXcoMa9GoBu5g6xsffJ3VYrL6CEHQwVVFifqXdh++
X-Received: by 2002:a05:622a:2610:b0:437:c4ae:f3b4 with SMTP id
 d75a77b69052e-43e09557d5bmr805221cf.26.1715377642591; Fri, 10 May 2024
 14:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org> <20240510-dsi-panels-upd-api-v1-7-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-7-317c78a0dcc8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 14:47:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vs4-vWby5YXxzbb1881DjeFWm0fRQCkPTDJYzTX61wSA@mail.gmail.com>
Message-ID: <CAD=FV=Vs4-vWby5YXxzbb1881DjeFWm0fRQCkPTDJYzTX61wSA@mail.gmail.com>
Subject: Re: [PATCH RFC 7/7] drm/panel: lg-sw43408: use new streamlined MIPI
 DSI API
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
> Use newer mipi_dsi_*_multi() functions in order to simplify and cleanup
> panel's prepare() and unprepare() functions.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-lg-sw43408.c | 95 +++++++++++++-------------=
------
>  1 file changed, 37 insertions(+), 58 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

