Return-Path: <linux-kernel+bounces-183294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1948C9748
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2BFB20BEB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5871745;
	Sun, 19 May 2024 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyLcBX08"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABE86BFD4
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157655; cv=none; b=VfDUFjg1G+R0iPZf0tDANMFonWY/b3eHHFk42w/YDobXluOGnAcqRFA0oZkb1NqgzrBjASbFwxnA05xaJD2zpw0TkUI8/8V0oFpWcOyZXss7KP8/lOSL+ln9djhFifD/TzjsmUnZJF4taESA3VrjWLMzSUPYSHyceKPuacvR0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157655; c=relaxed/simple;
	bh=V+jBZ/v/5VgtONx7XA+ITPLu0vtIFUAZCg8cvqQUU8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlBBYkBL9ELzO/9Qh6RmI3LPwxqw2LA62kMh3C2ATACsKiASK2tnIEDfF1HblZhZCmqEVfAnoUCpqToOrkoWDrf+mwmDWM3TLY/lLpClN1mf42pUdnOJhl5PK/xUkBzi6Y+nX/0qrTup2dT+4PWk2qm2QASGyuLyfiKbyxVLZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MyLcBX08; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso4545809e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716157652; x=1716762452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lnECSMTEYDy4nTJ8XR7yUOLISX1UUcDq0pG+XpyQGjk=;
        b=MyLcBX08CEZ+CEyyGvNQYdXD3/HPv30D/ck1Ei1TY8pcH+OUa9SYc1OnfpTmPyitoe
         1uUc4DUYPpb5njGEa1kaXzH+HRjXlnwGja1sUPkkYEnBvQJ0g0INqNrAIN8vEKsC00OH
         wDhk7dwKg6k/lIntK+cvoXSKYcihQN94mDMGbTVER7n8yAmOLXpA3Rnqm3HciMKqJvrp
         2jana6oddlKIEeQcJ7n2R112HmanNXuaxMtvWFJzmnDlu9eJunFLn141CC5w7y6eXrFS
         eZqsqlC3DNxK3IW/kqHA1z8CY/pF3hDYRChELbo++rfqw1shkeH5GnWZTPDkola1tTIC
         WVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157652; x=1716762452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnECSMTEYDy4nTJ8XR7yUOLISX1UUcDq0pG+XpyQGjk=;
        b=AGcZ2PoMT+u9NlLwV5Aq1za9jDGUg/RAdmYxfxxNEe4B60kkxo4Fl8yE+tfTWArFQi
         r0yMgC+Jc06fwA3F6ZiQkjQkZVwZX/Rc8LAqBTX6ZCtk8G/Ut/VpErRP5jaTd2BNzPgY
         FKzC0AO2gLlIUc1E8tzAPK6WF5vPLrLsAQ8FelEyiUfOUhqjFQCHtOFjwZHkY3XywnFG
         qF7zuqROqR7DQsgiyHfxsGgjMlFjrsCigE4YaWPM9CAIS7dimHerz43RWQG8u07EQ4MR
         9NGE8kX5E8GAyZXlUaruAgX3kTctpBBu6WxRiOZvHZ6w4H6aVp3eH7CMdl3jHowj3Yto
         D1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVGO3SD3E0E+UrPgGIxQgHIq5t+KsUa2tLTDXrtMEJ6sOtHHFgFp8n9zOf37O7ma5s4+Oa6ugAZmtJpM0ct06VVxhpEhNgFDKXM0rpd
X-Gm-Message-State: AOJu0YyEOGM8pZVXrW20ViwU3+jvdcAQA9WULQKhJr2htG3zBxYP+jui
	nFuwW0V5WrZXQKeOeQW3Su3/at8fkSINESbJc6HYEwlppdEjMjEAbhsS8AbIv3Y=
X-Google-Smtp-Source: AGHT+IFmJLVVml45EX56fiuVIfMfFL3aYxh/CATwE+BPez8baOgA97I7iabAgns9wfYAn1MCF3l4Kg==
X-Received: by 2002:ac2:4d06:0:b0:51d:1239:21e8 with SMTP id 2adb3069b0e04-5221017e0a8mr17480872e87.37.1716157651912;
        Sun, 19 May 2024 15:27:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d3a78sm4056943e87.177.2024.05.19.15.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:27:31 -0700 (PDT)
Date: Mon, 20 May 2024 01:27:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] drm/panel: ilitek-ili9882t: Check for errors on the
 NOP in prepare()
Message-ID: <exnkjttsewv4i2feh52h2q57ynxei2ny5cv2oxoqzjojvrlxoo@p2grdrhxmqzu>
References: <20240517213712.3135166-1-dianders@chromium.org>
 <20240517143643.5.I323476ba9fa8cc7a5adee4c1ec95202785cc5686@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517143643.5.I323476ba9fa8cc7a5adee4c1ec95202785cc5686@changeid>

On Fri, May 17, 2024 at 02:36:40PM -0700, Douglas Anderson wrote:
> The mipi_dsi_dcs_nop() function returns an error but we weren't
> checking it in ili9882t_prepare(). Add a check. This is highly
> unlikely to matter in practice. If the NOP failed then likely later
> MIPI commands would fail too.
> 
> Found by code inspection.
> 
> Fixes: e2450d32e5fb ("drm/panel: ili9882t: Break out as separate driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

