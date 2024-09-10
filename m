Return-Path: <linux-kernel+bounces-323903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FB49744E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47524285336
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD561AB500;
	Tue, 10 Sep 2024 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GArSXWjU"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41886190047
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004031; cv=none; b=R72eC9lMhm8uwA54hv2JcgqFqoVaZ6rS3ocCgLBhyKK1WtaJ0L5R/5MkObbNyjCRrcCLJNE2/s+zniX7j3pBb11L4cMVXTlEvLsdKSVn27i+R7cEoLrF1zQmfakfFjkYNldSY4hYiFNwj4o88gv3lk1Cz4IuEnat4ahPCxMQ4CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004031; c=relaxed/simple;
	bh=ssQtDFHYfouWkAApUDSMCB+dib1a0aZ+pDxwsvNvWmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMFRdHaJX8daG5e0AbHHUmn0OiDpXkNM1N51wbWPv0nEe0GVK+d3OR8Hws03UQulSLGu+oOPEmb2O63Immi0haxigJRyfhEuLVRGCGdRZpjUqlO7oaRzw4X8GLaW6PXl7gKorIiXx7JCk7JDbnUDcXACETVK1WDzUIWgY3f8ces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GArSXWjU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c35427935eso33784426d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726004028; x=1726608828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcLyo9qz2j7Y9T1HkAzmlsK07Giu2sYtTKhQoC98CTQ=;
        b=GArSXWjUXg2Y0+Y8tZgH3wMtj5C/byXOik9JASv7MGrXKg1bXFi1lcVnFs38zMv3VX
         YVutT1+ww+/M2c+opSig5EjDImXd5WEeiRD1u+4ka36lHwOLYC8fQO4tPWiPSKFP/Q0/
         BnUrBzejXJSqhjbT2LACr1Wiyw9xAhTo7QwIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726004028; x=1726608828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcLyo9qz2j7Y9T1HkAzmlsK07Giu2sYtTKhQoC98CTQ=;
        b=gEMc3uIdSoyt7BAY9mrdjC6R2oxfj+jmtwn/VG4FVkarb+5TzaA/t719frxMJT9InJ
         SMLyOijT4fegjFZBK8HV5O46apuJtgu8tISZYxs5hvciDP29rVK8HwDdJxrtuQT03zG4
         ODA2D1zBUDyKf7icmaVOnhFlFtrZFFdh4LarqsrfgjrKvwgl1KLMPpDjF0VAzvuvoqDZ
         ePplfPtdwAt5t++L8pMs3pqI8LnnUzXi9W2f3Cvk5laRLv4Tt+n+vcEruA5X/+C+Zvxg
         8avoHXb58dp09RS1N1icDw4YkOGK++zUSmuoO2vEksxrTePiYAFwXOjQJBfOzTWanQca
         UeCg==
X-Forwarded-Encrypted: i=1; AJvYcCWAgvr1V0c3tduwquKUltPyu46NgdDz5fBaAZRQMoyga3GAku6Wf/01O6QXCtb1LaLSW3+t+5TfDO48PdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyK0TiJteUomUCnrv36zgseErCpIhreou+/YVaEgiwTWkK8C1D
	g7sw8s37B8WqSH5Fk6l9FyqhekNa2wKmBPULEKqWUtuY25K09qYOUwhEmz8d3f+5O0pMMn/HyjA
	=
X-Google-Smtp-Source: AGHT+IEJvQnCwjIduGisce2/5EvBBS/FoO6EV0mzltNtDtY30wME6BD7E4X6DTMb0q6ZHjo4a26Udg==
X-Received: by 2002:a05:6214:328c:b0:6c3:5e11:53d8 with SMTP id 6a1803df08f44-6c5284f87a7mr247041576d6.30.1726004028651;
        Tue, 10 Sep 2024 14:33:48 -0700 (PDT)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com. [209.85.219.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5343473afsm33572706d6.68.2024.09.10.14.33.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 14:33:48 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c34c02ff1cso34773816d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:33:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxK2y9UzX7S7hBRFsOk4WkVKlRfFShiPd+JcQDixLtVOLee4UGiGZaFJZGqzj5p1pZTo2uVnUmsFvVmKs=@vger.kernel.org
X-Received: by 2002:a05:6214:590b:b0:6c3:657b:4111 with SMTP id
 6a1803df08f44-6c52851ac83mr269171416d6.52.1726004027447; Tue, 10 Sep 2024
 14:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907140130.410349-1-tejasvipin76@gmail.com>
In-Reply-To: <20240907140130.410349-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Sep 2024 14:33:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VMAUB4yiOZto9_iJ8rbQHtLsfiDF9K8KSvdac9brJ2Gg@mail.gmail.com>
Message-ID: <CAD=FV=VMAUB4yiOZto9_iJ8rbQHtLsfiDF9K8KSvdac9brJ2Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: raydium-rm69380: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 7, 2024 at 7:01=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> Changes the raydium-rm69380 panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-raydium-rm69380.c | 95 ++++++-------------
>  1 file changed, 30 insertions(+), 65 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

