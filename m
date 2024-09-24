Return-Path: <linux-kernel+bounces-336641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665AE983D66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25D4B23702
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC68181745;
	Tue, 24 Sep 2024 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PWpyYam/"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA881AB1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160827; cv=none; b=HhbZ6Q5HeTpQWi0/CZa/GBhCOC7LyO3DYbMCgEfBs8CUMtGvG1ucuJz40AY0baBNDVmSkPlANXopHq1CzeNn0dNgJYmYLpE3mXqGMJyUKfFibW5ksFNG8Br9PHvB+B1sZvXm8kGjIvr+IpUPmFFqszCjZP57N/8QVocnIm3pruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160827; c=relaxed/simple;
	bh=X/4RRCzTG59h/jycIeKGY0Kc1eoTfu1hnDWTyrH+9g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT5+i6L99Q+JQ76s3KUk9iuvg7fY1s5SBhKTgOk4EzpItR0NTY6NEYWb76P0i8KcicHhmfjneBE59wpsGAAnGX+zxkdE+TG1auTe5Ya/YPJ+AqcnaCcIJYFSUt1+Y7KbZU9ZJfWuGubkBN52tbMfbYhDoyp++UIrE+s2CRJgjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PWpyYam/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75f116d11so50137671fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727160824; x=1727765624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZF/NHnf/x9FbKZHy3TRIN4j+o2GmvD5PjB1e51dEMc=;
        b=PWpyYam/GcS2rvmPXmS0eios00k5xExRbrPsmtsUzvZXdxaGQjk5nw5cyqK8HiVHhL
         fw4S/JxxD0AeBPQjwjtLkMmflRZRZaW1c2rBNd6qFvaZnikIT0RXXpByBx4kcIqfVMuD
         ljZ5oG3peWfoPjQ82f/DUP1qZ+HQe8QHU+8mLJpEjTENsd1BhZ217x6HqMk+znjTisR4
         sdgIzPxEhzHJuZpepWmWAlfdziD14/ZiF102qAv4/g1r8GWmLQOMBbEzWEffNEpcg9ZC
         i/BCmckKq+vAzm8CzctGxSq4siEKKaHHpGlHcWkNTNz7CPWGekpjpKNq7SxLF8wwBpOj
         mZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727160824; x=1727765624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZF/NHnf/x9FbKZHy3TRIN4j+o2GmvD5PjB1e51dEMc=;
        b=T30LrFNZCpd3Y048R9D1ECp9g/UUg2paGaCsXp2mg/gymxgP4tVmPS3vQoz5ECacnc
         IBIWiyrAXA2ivjjUuERaAvW4jNg1H5D+KUqd0PwesvcaSLz+EWYCHNPYJL8VmWsabCbC
         e2LFxIBqvR/UCkG+u7sr+MjFLdFyKxe4Ki+cu7FWG27Lc+cs7qUNvF899en1xFBk2gov
         3DnqqMTq060tm7ZOGAKGOpe7vjnc2hbPJDxWXspRS81UeB7Op5tM8KE9EWNnqI6AEqsU
         3KkjLi99n1fMU8DZAuU2MpmZvzICsHs3f0U11l1Xwww9i45FZxmQWTc1x+NB/7juQNXL
         ygkg==
X-Forwarded-Encrypted: i=1; AJvYcCWwOYQJvsmlFMBnWRCRJpvHD3CIUOnKu6xGS919+CjGksNyO0aB3R54md5ib5TNPT3jazfelagiGuuEdAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPFKQapxK5ustI6QKCu5fhTTLTQUW183Zm5MdLklHc4VZt2tBe
	VuD7fxovw51ql9a7e/Pw5JXmHa8/R+oSEqm2oCtDgPk1b7TznfsiCHB2KJg5qlE=
X-Google-Smtp-Source: AGHT+IHxYXqItuZuuL7B92AozBUG30T1l/LeTzUmqvphuqmbNaplH9jS24oIFO33lmSgW0U88tUVLQ==
X-Received: by 2002:a05:651c:198d:b0:2f4:f22c:53d5 with SMTP id 38308e7fff4ca-2f7cb2e6944mr82126561fa.8.1727160823707;
        Mon, 23 Sep 2024 23:53:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d28b5a5asm1225001fa.134.2024.09.23.23.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:53:42 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:53:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, 
	dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] drm/bridge: anx7625: Drop EDID cache on bridge power
 off
Message-ID: <2tuetmn72w2dttbwe42k7wckamdqzswutlrvrvilg5j2jgj6ow@eaf2pbstfnju>
References: <20240924035231.1163670-1-treapking@chromium.org>
 <20240924035231.1163670-2-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924035231.1163670-2-treapking@chromium.org>

On Tue, Sep 24, 2024 at 11:51:46AM GMT, Pin-yen Lin wrote:
> The bridge might miss the display change events when it's powered off.
> This happens when a user changes the external monitor when the system
> is suspended and the embedded controller doesn't not wake AP up.
> 
> It's also observed that one DP-to-HDMI bridge doesn't work correctly
> when there is no EDID read after it is powered on.
> 
> Drop the cache to force an EDID read after system resume to fix this.
> 
> Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
> 
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

