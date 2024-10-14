Return-Path: <linux-kernel+bounces-364174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B199CC3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A6F1C20E65
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3611AAE26;
	Mon, 14 Oct 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQl053cZ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9271AAE0B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914739; cv=none; b=HSKaMzHJItPN9/cei/q4HNCS2JYM4cSbdf9z3XARUadgLnjOYTsLFwTo5d34g+QoMGydi12vgLAGZLZybC8VsVkgPl5M5/Zpj+Mlksja+TPKc62SVAoh8OzCpQwcKTPxiO8ewWRqkAUXwMz3gC2Y8MxkYFjNXnvY/A+3REmrCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914739; c=relaxed/simple;
	bh=Zx4kOUjsin/Smwwt63z29hEE20CKMUrtwqQGvkvhqC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzCJ1YOqRBqEzUNcUnjrMngP97r10EjuzrChrSDesbNa9t7SOldRnMQcrL+zi0zUt8HCYmXrlHwd5QJi5oRRI5dWchfS59bABsFxhA6PyK6+z03BfT3+mpdh4Ecr+wSKbukLD3o3MVxg3u30CqzoHlIzYj7nqWDKJWVns8Mq6/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQl053cZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso8603681fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728914735; x=1729519535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3ZWorb8+RZKagcCRZE5upz10RMDYXXfKqea7CqMPBA=;
        b=AQl053cZkzV1+Wn4MHT7vQbheovsluPES3u64S1V07WPAiAXgDGo535YMtjAqyU402
         ny4hDW8UHzsHBSX4zfsFGtRNibFpREAj6v6JytNIZus42Nem6S/g6S7JzUyUNqJL41Ev
         Wei8w6l/cklDy5bCpRqfd9ia2+798UAlumlnSZpunjpbi9SSbYNes9NmICnmmjOoOw+1
         Jz/NYXbbeN+tPuc58wtadty3TmwbwF5voQ0CNfH9fMZyWIG1AmjtbYL6QA6W++EP/f6E
         v91tG/l/uEY9i8hNga9BiqmpXQqsgQ5so36frgurKKkbxICxT7xYyp/fTS6rPdNxwo98
         PtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728914735; x=1729519535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3ZWorb8+RZKagcCRZE5upz10RMDYXXfKqea7CqMPBA=;
        b=QCZgtd+gIqIPoUHwEtzEEPjXVzwnI/jRVuqWvih3IMHyP3BkYgYeAVVYWrwYxuj0ok
         HyvVH7fsZ4Y/jZ0a1UGVBaIabUbuKrObBDYPp6w3iXltnJrkBkXnVlImeo1vyPkIT7bl
         ASZ+J3qUwfkfQS6S5s4wFvy+khZgSB3brOLhb2We7Wprs3mQWzjikZOVI7RMqekPIjyJ
         Twd5o6C5EePBkS6giZAO7fV5E19zLDxBIF8EIPDeT0MovYcwiOhSumht4c7B2U9crjB/
         bkd6v1ZmC0TQVdBRaKzwOIqcU4s7YtcTo2Wm3tlLyIAk7GLYRBNueYjFlgzC2AISM5R1
         ILEA==
X-Forwarded-Encrypted: i=1; AJvYcCW02nvSPWh7bp4kJBeIG1iRL+nULVrxBqbsBzH+lKDTK6kEIDuFEOHSkuem5VVDCEDRt5SuZjvLRK4tUUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7baNcuddivmA1sDb2kGdqrUMENSTjXfJm0+THrcsZdGzAFqNv
	aYpg5YlUi5VQmQJwInclW6TVHpdkqzhjpdFeiCCl5v/TDo5iQO9saEDXBFVUKpA=
X-Google-Smtp-Source: AGHT+IGr3Nd5QXm3kjAkubtvYwT8DSFOO1CVmXbvWR421hBitV2drZZRqqgT48RCtHLlQbhkfWPYwg==
X-Received: by 2002:a2e:131a:0:b0:2fa:d84a:bd83 with SMTP id 38308e7fff4ca-2fb32770fbamr41639751fa.24.1728914735111;
        Mon, 14 Oct 2024 07:05:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb4c52d6dcsm4884491fa.103.2024.10.14.07.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:05:34 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:05:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
	Allen Chen <allen.chen@ite.com.tw>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, open list <linux-kernel@vger.kernel.org>, 
	Robert Foss <rfoss@kernel.org>
Subject: Re: [PATCH v5 00/10]drm/bridge: it6505: fix HDCP CTS fail items and
 add MCCS support
Message-ID: <jd2wxdsgcgqhiek557i32c7god3cb2ic6bovyrmwsljkqtdofb@lrerfednnobl>
References: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>

On Tue, Oct 01, 2024 at 02:42:59PM +0800, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> This is a v5 patch-set.

Please check the way you are sending your patches. For some reason my
email client lists patches 0-4 separately, patches 6-8 as a separate
thread and patches 5, 9, 10 as individual patches. Please use single git
send-email command to send the whole patchset.

> 
> There are lots of failure items while running HDCP CTS using UNIGRAF DPR-100.
> In Order to fix those failures, HDCP flow needs to be changed.
> 
> The DisplayPort AUX protocol supports I2C transport.
> In Order to support MCCS via the aux channel, the aux-i2c operation is added.
> 
> v4 ->v5:
> 	-add more messages for changes.
> 	-[2/10] modified AUX transfer data size judgment.
> 		change for-loop to do-while.
> 	-[7/10] change for-loop to do-while.
> 	-[9/10] change wait timer with timer_after()
> 
> 	links:
> 	https://lore.kernel.org/all/20240926074755.22176-4-Hermes.Wu@ite.com.tw/
> 	https://lore.kernel.org/all/20240926075134.22394-1-Hermes.Wu@ite.com.tw/
> 
> v3 ->v4:
> 	-split changes  into patches.
> 
> v2- > v3:
> 	-split aux read  KSV function to a patch.
> 	-[1/3] new in v3
> 	-[2/3] add description of patch
> 
> v1 -> v2 :
> 	- ignored.
> 
> 
> 
> Hermes Wu (10):
>   drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
>   drm/bridge: it6505: improve AUX operation for edid read
>   drm/bridge: it6505: add AUX operation for HDCP KSV list read
>   drm/bridge: it6505: Change definition MAX_HDCP_DOWN_STREAM_COUNT
>   drm/bridge: it6505: fix HDCP Bstatus check
>   drm/bridge: it6505: fix HDCP encryption when R0 ready
>   drm/bridge: it6505: fix HDCP CTS KSV list read with UNIGRAF DPR-100.
>   drm/bridge: it6505: fix HDCP CTS compare V matching
>   drm/bridge: it6505: fix HDCP CTS KSV list wait timer
>   drm/bridge: it6505: add I2C functionality on AUX
> 
>  drivers/gpu/drm/bridge/ite-it6505.c | 334 +++++++++++++++++++++++-----
>  1 file changed, 277 insertions(+), 57 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

