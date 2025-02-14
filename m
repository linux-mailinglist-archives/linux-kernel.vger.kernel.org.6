Return-Path: <linux-kernel+bounces-515377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF4A363F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F337A4032
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F0267F43;
	Fri, 14 Feb 2025 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jYXVGdia"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FE267706
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552892; cv=none; b=H2XCYDdvBcM1qSoy/768FuNdEkmopR57vrQJNj68Ovm9FBC8fisT3TB/vWdiWXY1hC4F0gZ8o4JhddHuy/A0Cxg6IV2NLNPTx1TAQE568W2CgAnMJoNnjggtRwuv+CMEri1Ay0xQ+q9QLB+fX4XivORudxJU98Xmwrc8XGMJc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552892; c=relaxed/simple;
	bh=sfSWvTDVuKBwzqLK0PPm55nCocWKZqvFQZj7DIziw3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppfOoGmFP18iQNjp9HYcbhCaDyrWzr4/QGwWVyVKcVrCifLPjavzhqmSXM41Y5DZ0tr1ztfK/LUBNuveaKkQFMsZtUryP5GVXsFsVO/xQUoO5EHVJEyVSrvzeixOTurNiwTUZt6P3BujroPlWVJORI4zkWk8ke85pQC6LCBISi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jYXVGdia; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso4004491a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739552889; x=1740157689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfSWvTDVuKBwzqLK0PPm55nCocWKZqvFQZj7DIziw3A=;
        b=jYXVGdiaHw4Ivy32lZ17kG9O9psyyVTZOkdZHmiyrkF9MXgdId4Pc8GzBkKweaW8hw
         iqcMclC2HAsUn209zGVVnG9qC+BqWa6DGMZ0+W6VMJd1waV8tNs2dV58sRFtrJ/Kw91N
         kdSd+zo1aUkf9f3ccGk2CtOJiGxSCsYjbiHQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739552889; x=1740157689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfSWvTDVuKBwzqLK0PPm55nCocWKZqvFQZj7DIziw3A=;
        b=aZAHGCaDyGQSFkAru1mj9R/daV44ZuxDXS6lWUgcD8P7teF+NorAdnKMRIhFMgWy/P
         /x8hbK6WXdD5j2qqC6qgHRPhM5xopPY06YjhJss8i7Ubdnss3prSxpEzCtgHcZMBzAog
         wxL3OqJCk87Rw+WYNm/6LboK2923QManj4bswHO4ilIS8LvbTHtNCjbvnB+gaZGkNmXm
         ElW7XIWoH2xpuBkmzhQUKFLxaL/Wz9t77DJfq+dwZwfoIny1dWQzJUHONeeD2ildidSN
         79OFjK+kKlZ3T2vKLm/40fb986/JhsK+Av09+pa7b1qHFr+hTmJIhkm9EUMIBwapLJP6
         taYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtim+CwzCiFsUYTXi/dfWlygaTbCIhJY/8jyhvdadh10VKpSUyjtFdb+35OSdI3gwEI58YGkOe6XLKi38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqB1OgGyfvpJTSYwnVMul214yq7ZoxXF4FPhiVjj7sptLAeNe
	VzZn6wmjdlsHindq1OGzZb7Pe8ry7o2bLAnV6/ac699XPEIwx+a0gpf41wBLD65vpgHCl4pPjCe
	w2ctV
X-Gm-Gg: ASbGncvQ16m1DPEmvDoFYDqqnusm24u6RdgmxDjGjDOMrnSb2Fn0PBJHdNPfWSfF4Ai
	eBLHZM5wtXc/3S+hTvtqx686f1E/3lF24yFNQQ9B4lF5P+1IyHg7RzXuGt57e2RJxx+wTjZUmw9
	C8UL6eVpqd66EQprVH+vp2sndk+kdyb3Z+gV3fib2UZ9e34uv/HIKupOdW3+yI1EIPdNNFrB0S2
	U3CetFO6DBtMBd6rUA/0xQPPi+fmHkNcxGG+47ePJsH2dLJjfUeGHjisAXeJ8b55jFJAY5SOpix
	gH4n81dsLqDcklqJUD490dLIUXISR6fszx6HnQjc0eX8sbzCc42pTIY=
X-Google-Smtp-Source: AGHT+IHuRL7RUgyX9ieEM1f56ZSZWfNW7d7YODOcNZ4prOmbKB5u9SjxajzjQiqCioRCZsJAvJyFrA==
X-Received: by 2002:a05:6402:3488:b0:5de:4b81:d3fd with SMTP id 4fb4d7f45d1cf-5e0360a781cmr292845a12.13.1739552888773;
        Fri, 14 Feb 2025 09:08:08 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c58e2sm3246361a12.20.2025.02.14.09.08.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 09:08:08 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7e3d0921bso408209766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:08:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0Nm+g8NrTE0ihFNRDGV4NlJ/d3wBhvT/jKOf79ZndoLY6QpzoIVXQOH3t83RyZxHnZ7pyk1lzm9Q1DR0=@vger.kernel.org
X-Received: by 2002:a2e:878c:0:b0:309:2627:8b04 with SMTP id
 38308e7fff4ca-30927a6f375mr745551fa.9.1739552451496; Fri, 14 Feb 2025
 09:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org> <20250213-bridge-connector-v3-27-e71598f49c8f@kernel.org>
In-Reply-To: <20250213-bridge-connector-v3-27-e71598f49c8f@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 14 Feb 2025 09:00:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XtRg_sqbLMuE9FTtPvDtkMTRBFfAbgekhBWokjAQ4LfQ@mail.gmail.com>
X-Gm-Features: AWEUYZlycZGUKuhTCeIZrvmtO14Z1ZtvZMcFxiavcA6wW5KOV4XKvByQZ_fdTVQ
Message-ID: <CAD=FV=XtRg_sqbLMuE9FTtPvDtkMTRBFfAbgekhBWokjAQ4LfQ@mail.gmail.com>
Subject: Re: [PATCH v3 27/37] drm/bridge: Add encoder parameter to drm_bridge_funcs.attach
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2025 at 6:45=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> The drm_bridge structure contains an encoder pointer that is widely used
> by bridge drivers. This pattern is largely documented as deprecated in
> other KMS entities for atomic drivers.
>
> However, one of the main use of that pointer is done in attach to just
> call drm_bridge_attach on the next bridge to add it to the bridge list.
> While this dereferences the bridge->encoder pointer, it's effectively
> the same encoder the bridge was being attached to.
>
> We can make it more explicit by adding the encoder the bridge is
> attached to to the list of attach parameters. This also removes the need
> to dereference bridge->encoder in most drivers.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

From the point of view of ti-sn65dsi86 and parade-ps8640:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

