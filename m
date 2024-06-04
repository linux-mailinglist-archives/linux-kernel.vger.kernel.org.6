Return-Path: <linux-kernel+bounces-201082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F3C8FB919
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8EC1F219EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C1146D6E;
	Tue,  4 Jun 2024 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W4CGU0Pv"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2814885E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518824; cv=none; b=mChtaITgEjyT+0wE9uwN6K5bWjJWUCAecV7ObqhOlUMykDDumbwdE5MtdcbndqPsOCRJL9mPUmFSKnOoGrfgb9O3k7edg2anfd7Ii3WL5htDdwvm5g6RTdkuYeVYYhqmz0Q6Us2nPcSCKEUfXk7Hf/pPx9xqybb+F5B64vXioNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518824; c=relaxed/simple;
	bh=0sjG0tqlKzolcqbhmchRyBzY61TASS8q3u0cZwwqMg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NvKRYvu+7EEhj8p2BysztD+Bc151PYxrVJCuF7323R7VOi00e0yxZhsTR3K2RkgIXLmCSW8jj4G8n0b/ZuKecfoNCmTvqvjgtEorJNcgTGxh8CESlYRdYIqoLITDTDZpTv4MEeSjGIyTPV2IT+FBmWbgcvaTAQmRfetZMWlHgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W4CGU0Pv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae4d4abeb8so24939956d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717518821; x=1718123621; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ3fzqU7zIJSZIaEHoz1dBE+4a5Pc5bbz++LUqESkpE=;
        b=W4CGU0PvWe/ITnumQkYU1g/tLCgPrrs8LgoWafFHEbNHSikDAL7mj1L0sThcFlxaon
         RbfpF9HrPWYvGkljVTsc9NqYQ44o2Pt80LKdnHRj6gqItfcyej8DgbNo6h0BJ92Rim7I
         PsdJyEgizl1Ig98QcYVpls5T+a9n30y19xIiv0b4MfV9nCKhMprf8XFRe16B9FfMEgMe
         WA/j8+apWSjeHi71d2CgQWc71rnuyLQV8fyeH8XsMg50HsywbZQwdqPbb2yTA5l1Z2B4
         8O2SffMxg24pUBR7UMVmktsGH850UndIF9+o32GGf9DljsUBbGXMCb/khhOHN6JvECnB
         B5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518821; x=1718123621;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ3fzqU7zIJSZIaEHoz1dBE+4a5Pc5bbz++LUqESkpE=;
        b=mSF/X41j/HinoSmbd13dV9DiyhIqNguDbBhMo3ppU5bmnp0rjQLM9Q0p4wTb3ecCwo
         a6G9TFAHKnqIhzn+ijBkxv32VSOc9tYt4WFdEU5mvh98hXmV1ZEDWbMH07IXTx2SpOEE
         l6N0WCHnb9V7xx4pC4UVh0yszPrOUOR5BB++vVEqv2I6cb9j91HUbo70qcKEjYLBagw7
         SsG7OhN4PGkZPcxIqC8YBqpMb7Zz0JS+X+GrwdxjaHldM5oJGeDmGzqkN111qVDGjX2j
         HEjNlUMhkDpI7XeJWjKjdN2ja091gOyjMNh+1Ih09MOj3ncVIvyHoAV0+s+9QCRnn02S
         PfmA==
X-Forwarded-Encrypted: i=1; AJvYcCUNjZiuD5qjDo1tcyz1naYdxoSNYWYUI28u/foMmPLNlIgaHSD6Hri+8uN9GwfXTAQay4k/li+3xrd3/GdZlgPZcRYH6Jt0kEtAeDkH
X-Gm-Message-State: AOJu0Yxd7s6tMbN9r1mX1CIjCFC3hwHIUcd5bpko3gHU5s8GMctIFafz
	KY3qDSpVKaQdxQN7EQu4VeWIXYVCEGfr2zPFyqy8iiuDa7pVtZyHStpziovMZEk=
X-Google-Smtp-Source: AGHT+IHd2opDiMK9J56b4t8UYsWXPdl+c252CiMlGiyJylrxgyVHd1pODis8mm4KS0VPSIQYkVKiLw==
X-Received: by 2002:a05:6214:588a:b0:6af:4fb6:22fd with SMTP id 6a1803df08f44-6af4fb62450mr95965726d6.3.1717518821099;
        Tue, 04 Jun 2024 09:33:41 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a73dfa8sm39997536d6.23.2024.06.04.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:33:40 -0700 (PDT)
Date: Tue, 4 Jun 2024 12:33:39 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
cc: Julien Panis <jpanis@baylibre.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Return error in
 case of invalid efuse data
In-Reply-To: <af024ad1-93f6-4d7a-b139-7eb2fa12eb81@collabora.com>
Message-ID: <359n7s98-08p8-177q-n51s-33rs215soqq2@onlyvoer.pbz>
References: <20240603-mtk-thermal-calib-check-v1-1-5d6bf040414c@baylibre.com> <af024ad1-93f6-4d7a-b139-7eb2fa12eb81@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Jun 2024, AngeloGioacchino Del Regno wrote:

> Il 03/06/24 14:06, Julien Panis ha scritto:
> > This patch prevents from registering thermal entries and letting the
> > driver misbehave if efuse data is invalid. A device is not properly
> > calibrated if the golden temperature is zero.
> > 
> > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> 
> Fixes tag, please.

What should it refer to? This is arguably a robustness enhancement for a 
defficiency that has been there all along.


Nicolas

