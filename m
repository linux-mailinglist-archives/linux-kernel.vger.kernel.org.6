Return-Path: <linux-kernel+bounces-305372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6A7962DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29D2B219F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCDE1A3BD1;
	Wed, 28 Aug 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fqaqd6K/"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D01A257C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862748; cv=none; b=Mee6TRPbJBnpYixJYcaAXsRKHiUXa5Nv9DYCKc6UNE1DauRDtdE7jH+egnbvQbbihjOaelE5fW+aUgoFqzLbpHz+Y+3sSke7x07sYuDZiA4C6WHU23T+PJF5j7hRYtwtbW6uWWNMykKP1W8CR4CtplMZjIgsgb33ZzBDMWdsEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862748; c=relaxed/simple;
	bh=RtyC+DJzSu5OVYSmEs62W49jDoc5U19zL58+7inwVxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdRGqp4jLV5HtmTGts76KcAns+q3Wbk6ISKbjCPDfYVITRc5bGOeXmjAhPdOJ1bBCmrF7GkjcJcLTKa1bsTczQ3GFb0ESYtFZTGwy2IomTOzaOq8r+gJPRPd/hRtk4mrgImYaH65S6pCM3Je4ngcAeBm7461mGQd/vRJsVt1wtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fqaqd6K/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so6817266d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724862745; x=1725467545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocd9Zpo6DgcIf45l8s+t0c2v2FPDJ94NLUV2A2cC1Es=;
        b=Fqaqd6K/ylq6c7NAt+Cm1zJgXAXV8RUkFUUIr9zXS11NCCpNd75v8HMdQX/cgema8O
         IrAO0EpCM1MObC7P/alFinYVC+0Z29YBR8ZJJNQbsYVWMJhsU9jzAsh7DT/vwjvXaAZk
         09tNsgxAUPXgalq1rD4RxYjqYh39JqdEHXF+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724862745; x=1725467545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocd9Zpo6DgcIf45l8s+t0c2v2FPDJ94NLUV2A2cC1Es=;
        b=NAXf8rHkFk/UPxAnITznEDv4pKwo+nLLEIY+DCqLtmOnhsXdgXYwZqB0O1CkNDG94f
         205YcCWyhMBqBcTuWSetRkAAJyBqOgBcdVvBOmAg81c3cxLRxH0+05dYItJPHK0RCowx
         V8WL/M5Bl5e7BHDzBa8JHGofmG16OBhhL69LxyRnn0OaFnrRtBffjR9lOdyxxIMtEf5+
         OpN+cTbjPUo3z47xVy9KtjnW95gc62UL1Qj4Ecl9Ey7QbVggnMXvXP3E8vJ8xueioyFs
         ESqql7I/77DrLjg7QAPw4fOE53ODx4+b8ePUENiGyE92bZg+twmBu6wcMCmq+Wx5gNOT
         tclQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl10YmV9vHF7bQF+BWFraZ+8ZaVKLN6XWYvalWKT6mqWpbp9B31fwqU5nTAp0VxSg9hG4ttJeickTjTN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxktPp/MygLI8XauKDDEVwgdpJ3qshJQW365PdWkNHL6ZEgxaxD
	poM1eQb0/6WRg6Vwy3tUZ44da0eluKKq7HLybcZ87c7z8W5DqhSZKdCdJz1ygV6DYyW/FeZLiSk
	=
X-Google-Smtp-Source: AGHT+IE7cKcSMR8BXetiiFXbBCfXEkbq7DJjXsz28E0vPhLb4VBIqldGmTQlgT8ye7B7bQ5y8eRPyw==
X-Received: by 2002:a0c:f407:0:b0:6b5:d95c:692d with SMTP id 6a1803df08f44-6c33e3a32demr1581126d6.13.1724862745150;
        Wed, 28 Aug 2024 09:32:25 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c1c6sm67152196d6.46.2024.08.28.09.32.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 09:32:21 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so6816496d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:32:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgJkGghUZvHq8WASpYOND15BkwVHcwf5tx0x42OF8GPlBX1miDA1sb0EqZ1gsJKubmBA0JGXqM/qHRWzA=@vger.kernel.org
X-Received: by 2002:a05:6214:21ce:b0:6bf:835a:87b6 with SMTP id
 6a1803df08f44-6c335d97ae7mr43324726d6.27.1724862740933; Wed, 28 Aug 2024
 09:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-0-0cae20d4c55d@linaro.org>
 <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-2-0cae20d4c55d@linaro.org>
In-Reply-To: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-2-0cae20d4c55d@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Aug 2024 09:32:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XY5Sh0Ax6P-LRO6n21EGL7K0tSKRaPyQWg-ZGmi_vRAw@mail.gmail.com>
Message-ID: <CAD=FV=XY5Sh0Ax6P-LRO6n21EGL7K0tSKRaPyQWg-ZGmi_vRAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: visionox-vtdr6130: switch to devm_regulator_bulk_get_const
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 28, 2024 at 9:03=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Switch to devm_regulator_bulk_get_const() to stop setting the supplies
> list in probe(), and move the regulator_bulk_data struct in static const.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 26 +++++++++++++++----=
------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

