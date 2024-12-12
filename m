Return-Path: <linux-kernel+bounces-442595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9E39EDF03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EA21889BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073FD16BE17;
	Thu, 12 Dec 2024 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHky8JsR"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64603748A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733982156; cv=none; b=lsnrk8yjobc1BYg+0Z1rJr+XNLvuVfVYyJE40sCUj3JYPINuDSdVh+3uEVWCavu/v6Bsvzuwn3naXjg2rKmX1jaWVhIdzhMZ2iGBlr2Ks3JlFHoA8jJEWHyif9AMeXWK5OFXYjqTZxFz5d7BuCT3T0NfsW9xGsnGXR7jw34EALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733982156; c=relaxed/simple;
	bh=gcWZF19+DRzGzwl8aVWSk1HUkyqc588yBy6aNF+LLvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOfLAewLxE/4Dhq27o24DxRfp7Z4X4SvIPZF4yIQ/iS+o4MlLA7lhY13Alx1otCkVvrixwOLqLUo9loU3CB+QMg8lxZ1606ybeM5DZ6Jm9/mhXzAUy2XK0o12qy1HljdrH5LFTRGput7O9ol+DhhTP+SzWv7X4LReaTQIOhUWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OHky8JsR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso1084135e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733982153; x=1734586953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TSoY8FmmkeLy1cIzhiayaqEXOMLeH2MO/C02Ui4iNR8=;
        b=OHky8JsRnRuc6EwMiTfPD4H8wbGtvhb+gh9b26XogM2tJn2Pf7n7ryoMwgmKkSFq62
         8hAOsW13KLjRc7JPevcCVy41f1J67IcM31SVQhvJsR/6yrEtaPLB379fQd70TeoI5cHs
         NC6trvOdXWNK2vB+zkJSHwi4xUobwJTL0tDYRVEx4Ze9eezIf4Z+2zbW51edx3JQo2/k
         zlU2IidSzwDvRfF5W75TniJGlskP5KZrbiOZfRnlEozFKS1nu/MJzuSdBlUWV9p1EHKS
         rjyai5+Y2vfQUWN6JSkcyqA7bajNgDKfR1pedyhVhkp2zgkZkcFMxo6hSXdPgaKN1M1I
         dtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733982153; x=1734586953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSoY8FmmkeLy1cIzhiayaqEXOMLeH2MO/C02Ui4iNR8=;
        b=Iowcm6Auqky6gRyquQv1Prl/K4YlIthC7M5ufTX2VpAX9zacQccihOrfiEpCV4zR6b
         u5vN+lsF3UfUeyFRTthjoHT1r2pTDGlGuhJdb9fAzemeJ9h8b3m+vfWLE/7L9mR0ST/g
         Gd+6gdyzzg389sI3dOOYDwHl1/TcIAZro5wbDhCJcG3YIsyRPpexxPHn59kfckC8tV71
         S+0lr6aLKw5Mj5JD+Y+TM2/6eVMwnm+8oykwjAJYxqLIU+sr/GQ7i5MSV40qJSRywXhO
         wQWHJ8vVHKQovkl/QhEs50zbcXZRhor0KpjGIv9hqSNS4cf+KrFUrLYNiTqf3Nx49wiB
         Esig==
X-Forwarded-Encrypted: i=1; AJvYcCU4tQtUIw7m1rhOvXlrHy8/nfohKr4xMDvwFkm9s5/Q/ByGy9s8JlbfyxZiGOlWQT4zokAVZWMCGWTACh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95EWYer2R34kNefZlHInvreZATebAHU/5y41I1qhgDd0YO0CC
	/WSrCcQJkKD/Q3sn9hqNfL4RWee9Jbe3900Ug035Nqm2QV+My6EpTtVpL9IFMVo=
X-Gm-Gg: ASbGncu8ddQARHRWlwVJW2X/XYdnYcICUxrpajBL5Z6eYVzm9BvsBbhRdlLdZy21BPa
	80nFqrP7GIkgBVZN04Ywr4CWsH/2Yhu8Nlxatz0ZV5ewhRmmm0r/o1NVrCC8rqbUtWhfnh5Y4eX
	uti4wuxBo5G7jIjCTPFQLCIilDHbL/rJl5mjW1Z8DjPyGEt25dCgrBi69Bqo0s2rGnMfyJBBS4a
	xoCpYA2Yn7Z0qFG54iVXU4LkM8VZAvJVu0VQA5fsFJ6ZzOTNln+MMPdAn162w==
X-Google-Smtp-Source: AGHT+IHrSg7hk/G4icQhSNLkWSliDmfnvtcZ0Hc/oR6N1zAGQ9eaOtiBf/S4QxnV0x+Y88vzskH6Iw==
X-Received: by 2002:a5d:6c6a:0:b0:385:fc97:9c71 with SMTP id ffacd0b85a97d-3864ce895a8mr3702933f8f.12.1733982152823;
        Wed, 11 Dec 2024 21:42:32 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550555sm5552355e9.5.2024.12.11.21.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 21:42:32 -0800 (PST)
Date: Thu, 12 Dec 2024 08:42:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] staging: rtl8723bs: remove code depending on cflag
Message-ID: <2eba9c05-4efc-4060-8cdf-26f701ba9794@stanley.mountain>
References: <20241211233415.37702-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211233415.37702-1-rodrigo.gobbi.7@gmail.com>

On Wed, Dec 11, 2024 at 08:26:38PM -0300, Rodrigo Gobbi wrote:
> The proposal is to remove the code isolated with DBG_RX_SIGNAL_DISPLAY_RAW_DATA and
> all the related code since it was not compiling and there is no information about it's usage.
> 
> v5 is just joining 2th and 3th patches from v4.
> Tks again and regards.
> ---
> Changelog
> v4: https://lore.kernel.org/linux-staging/20241210210741.17101-1-rodrigo.gobbi.7@gmail.com/
> v3: https://lore.kernel.org/linux-staging/20241206230110.11893-1-rodrigo.gobbi.7@gmail.com/
> v2: https://lore.kernel.org/lkml/20241125225308.8702-1-rodrigo.gobbi.7@gmail.com/t/#mf22f30a9c689bd793988d7e7a58c0b119206116c
> v1: https://lore.kernel.org/linux-staging/2024112500-authentic-primarily-b5da@gregkh/T/#mea4fba3775a1015f345dfe322854c55db0cddf43

Perfect.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


