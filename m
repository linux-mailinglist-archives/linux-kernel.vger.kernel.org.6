Return-Path: <linux-kernel+bounces-427297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C39DFF52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4A128112F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517E1FCCE4;
	Mon,  2 Dec 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iHwo48+B"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3BD1F9F6A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733136634; cv=none; b=j3bTzbAbSdI+DaxHnkEzsULA6VT4nDJ7ojIrs+lHPYAz+imgFu0j4wdQj6l+WXulye0Vn1yuwX8W4StNTv0tWVGkmEJI5uJosbWPxvPXybvYBzSdmdARB1s8RugheDcx60NBBxjEGq5uxQayNywbAkwlyOcqHHNj06bRs1F6xwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733136634; c=relaxed/simple;
	bh=YoO40zl/s7ZnqzqIb0x9bS2VWKzdum6rohqZrbmtpKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr/kbtyeFcVfC3MsoO3NDL6iG0bgK+5fflQj+qdx/gT0Oy1tgpbl72QyASr5wxLIoWMYmnGTyxrr1zJPGOnHMxfCqEbqbbjxyoe+ggL8OI2BABg40HJ27VHaD5YhvWoaOH64wHh/dPXoEiFwFZeqJb+R056JHxsNT0CDEBTS3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iHwo48+B; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e397269c68fso3177434276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733136630; x=1733741430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoO40zl/s7ZnqzqIb0x9bS2VWKzdum6rohqZrbmtpKY=;
        b=iHwo48+Bmg3U7AKrMtAg8Cr5nyGuWtWSXQ2cEYUGdjYgXYhMXBUc9uaRLDmCb1/Cml
         uI9OcxGcplcrOgokfOVQIqYoOsEiuOapj1eAJXSyWagAKFzz55klVE/4f4vcigQwhacr
         AQ2jT/mSLDv9GW+aLrf2JvaXY4yVGKwEAv5YkEYTnS6afYw27Jn3uZs9nPXdDmjfsRUw
         BX5YOH6BSeSzZ0ckhO4YPIR81iJl7MWYOEswY8jXPOoz2ETmrxeq8tiSTXacq3dHtRqR
         ev4xA/xElgyFLgQbCPO3N8STSGnT8DRznSRmePheuSUr84BMvQqlhmrvOsCCr7559YrZ
         giHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733136630; x=1733741430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoO40zl/s7ZnqzqIb0x9bS2VWKzdum6rohqZrbmtpKY=;
        b=npO1lcPrlkpuCApYgsFD8O38XT5p2MMervZfKjrfnALC1DKiND483poG7wNs9fClr5
         tkGbgaCpEmhylMnf/Cz3CIbxnJegYUlTNV0AHy8WL3J+l9y6Zl7YKPlU6m23PguPuT9W
         RFqMFOsFHdKFjkfs7fCARoFXJPlI1GS021gKTdksIA1XZURV1DkB0j4Rese1K1FI+jEO
         kfVrCD91sXlP9osilQbF/GTS0tpAwao6AnOtKptkBb0btQ9umHAqGHoUZ5IcfFWeSDj4
         g9BIA4VQuIbVNAnWjeIqcBk1LWls3egLYxu7Fyn+yMP8BqDeOEI7p3H4qPgyqE/aWMOH
         kcsA==
X-Forwarded-Encrypted: i=1; AJvYcCWqZ0n26zyhRtqbVPjtfHDErvNySnW0mx/qU5J1hs8DjbGIDCRTCmEScBI24FC+PIqrRt3ElX2JLk12efM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqWkQwHQ0t2aLvEkQ2/JSpgblmw/M5YE9X0CsiKMSYg7bwIsvu
	FXwHPwmz42sLUV07CXr14qVLu0maLYa22qLztlKjsrsydp40Wyzcf5l1v17dK/lj+zPy2vPT7QR
	Rqj6o8PYYRQuG/Ku2MFmjDV88mbjgePVaTFiCcQ==
X-Gm-Gg: ASbGnct7VEdOML0ejELoSxZZOEP0Xsz7sU7DRfUmiee8O1OhtR3+GHiDEnNISpZPrrE
	0XuBlXdPs+isaWeZYBnPAiFs/yHAKkN5U
X-Google-Smtp-Source: AGHT+IExerCQ7sAUwgoXkBOkYbDVHSC68g+nFnlF4d2JadWUyhW3V21jeoCT4WtL5P/vbC1ORnld9fcul7IdcQprIzo=
X-Received: by 2002:a05:6902:c13:b0:e33:67d8:654e with SMTP id
 3f1490d57ef6-e395b9548f7mr22613536276.49.1733136630377; Mon, 02 Dec 2024
 02:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112105030.93337-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241112105030.93337-1-angelogioacchino.delregno@collabora.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Mon, 2 Dec 2024 11:50:19 +0100
Message-ID: <CAFGrd9qe5Q60zBEXyCokcLtFQVk+qa9yajO4_gHZR381i9cVOA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Initialize pointer in mtk_drm_of_ddp_path_build_one()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, matthias.bgg@gmail.com, sui.jingfeng@linux.dev, 
	ck.hu@mediatek.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	dan.carpenter@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:50=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The struct device_node *next pointer is not initialized, and it is
> used in an error path in which it may have never been modified by
> function mtk_drm_of_get_ddp_ep_cid().
>
> Since the error path is relying on that pointer being NULL for the
> OVL Adaptor and/or invalid component check and since said pointer
> is being used in prints for %pOF, in the case that it points to a
> bogus address, the print may cause a KP.
>
> To resolve that, initialize the *next pointer to NULL before usage.
>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

