Return-Path: <linux-kernel+bounces-384203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141189B284E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87051F21A34
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A818E749;
	Mon, 28 Oct 2024 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LFV9rV8T"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426B9156960
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098858; cv=none; b=rxXTgEl9u+ctfiuMZpMIyRZsZwjePwykmc6EC9rcCNCuJqltehc/u3gnskC1F2exgrnHvInCR7iYIQll6Tf1eJ7gQukgk/Gv00WW5pMHvKL37gVQOQukQhXnjIas4JduWUXgU6FOCT2sWVpw+lcsf+WWbiCfWyTZe9OR6Lgv+o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098858; c=relaxed/simple;
	bh=Cmwyegq7pd+RNDhv4uH4MzNeE4hWCQOLImM4aqdf6HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOLQwLxNTOaAAz0Wm5O3yydW1yrzIX0jOe4HIhgt8VgDw3EbfCmZdKYj+Kj0HIj3gQOdnzw/UFcyaYcT8dzX2RuXyQIV3ykmU+FaScDImMl0Abn6TWWNwznDBT9DehnIjhISgQm5+sTacTqdH3qDQq9P/TOxnY0xzDi2w4NQ81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LFV9rV8T; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so5213498e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730098854; x=1730703654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cmwyegq7pd+RNDhv4uH4MzNeE4hWCQOLImM4aqdf6HM=;
        b=LFV9rV8TAxG/KJjUfe9gDc78JqNtErD9owvxKRBhEj3TDzi2vKWLBk62mKtghkXu5r
         ZNUndFYj2hRnmPvEDnkje69oYs5dfiiK0hD4HZXCfogbWYBnF7IC5BVgKXXOgh+pDgc1
         bUzlu5WH4HFgS4fDPX/r7B4ApRMm8wwA/pzZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730098854; x=1730703654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmwyegq7pd+RNDhv4uH4MzNeE4hWCQOLImM4aqdf6HM=;
        b=cr758xcvILoBe7wiFUbXS1RdAIVvC2OLbSgiTbsa1uzW2f1TS4MTs3dbGvgXPyGfIb
         st1bSVh7+v6chdBcnNVRryD2blzRSr1G2cKwGiuVsm/br5ANtG37ZmZkqnE3C5tiAnFw
         Uj+ErDyPbCJzyvktU9CAtR7KQG/YdpahYLBMWmPojOEZvVRk1kQBAgXBz/wv5YQQfPwZ
         sIdYoLHWt3qLs4F90ioihBlGnOSTS2u4qdzTk+tN9U4uF6EwmeRfJqsZTkC8N2kPBtPg
         YChToV4O9tYb1TmR8aDRoWSUUxzV/Vh3mvZfrZXaYLuFo3shLC+33weTE9h0Q5LW1NcX
         dJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0BU2WutK8RjSrmeE5Rkf+JGCMYX0Nl2SzVSE5L5h+VkaJptzcDdBlgXKcZ8uVKiHegRmC9QT0nPgJjJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/4RQgobzLrq2NOxH8Iv7xapGqAtNY2C5B0YOD/sL/VO3nmlt
	lnWWbuRq6OwVFO/R3Kn26+nyRZ98EUr8V4NDpU8FEd5VzdrACC6+gfpreLO+7Leq9FdImI3DXny
	C2VgrZupWtbk0Rt5Unu534WscnUbuTzW210ZN
X-Google-Smtp-Source: AGHT+IFCTK/9t8GApx2c313ElibGHVQt1aCzEHXMhwQB7y5ngpH9maQprAhY8bEpEJF/nzrqaJAxSEh5HOrX6QHHt28=
X-Received: by 2002:a05:6512:3ca7:b0:539:e873:6e2 with SMTP id
 2adb3069b0e04-53b348ec22cmr2169421e87.8.1730098854425; Mon, 28 Oct 2024
 00:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com> <20241011-mtk_drm_drv_memleak-v1-2-2b40c74c8d75@gmail.com>
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-2-2b40c74c8d75@gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 28 Oct 2024 15:00:43 +0800
Message-ID: <CAGXv+5HAXuqxZM+CwfseXbAr2bsPgP__wc34mfmiJfui_fLOOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mediatek: Switch to for_each_child_of_node_scoped()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 3:22=E2=80=AFAM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Introduce the scoped variant of the loop to automatically release the
> child node when it goes out of scope, which is more robust than the
> non-scoped variant, and accounts for new early exits that could be added
> in the future.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

