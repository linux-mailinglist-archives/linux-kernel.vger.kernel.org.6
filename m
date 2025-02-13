Return-Path: <linux-kernel+bounces-513403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D2DA34A69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12033B3C57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082F26FA6B;
	Thu, 13 Feb 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3G0+Az2"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DB26FA5D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463475; cv=none; b=JhHtxv+7hW8RvNt/GsFQxudVQGynw82DdUq3+ckdqxfwTyiZuTTX/5PUzWB1MEwPz1+YEpyzMaT9yky9NwdQ+O/TU5VW+OazUrrrnXvwC3b0mVr5govPd3Rqkj63qwID8QliTG5DD4Qzl5p80xB5ujZ1p3GuNYxt65Cu9q92tMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463475; c=relaxed/simple;
	bh=NEodwUThL9+dcHiRmvWNXyuvZUMSic74t0Nbwh8HOyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quD7ZzOZt/sQWGISIDFz7TqpIZS1nA1paJN4QZd+gStXPRoiKK+QIE47YZuBjDOZE/0nZ2FvicN8hczBqzkEP+7PWclysqtrk2QlxoWDZ4KyBrt37XV8ix4M2RBe4kZNYTlAbhq+Rx53e+04qW7xNun8PRAl8FzcMaoCzRR1vPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3G0+Az2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1082216e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739463472; x=1740068272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDyhBZMln1bycs64uQnjujYs7wjZ1a8hAKD4vRr/hAU=;
        b=E3G0+Az2RJQtJcJR3k4hsUg5PccAsXTk7Ru0Sckd9l9mbOGBYavT3aqN5GmxKVoVxP
         dGfzBfXbrVHwSj4AiTsJ4rPkZF0KyrkyQm7n1bN0SMpgTvRVoIS2fQTfZU43GRE9tzXc
         LEDZO7z8RSwplwlNGx+Yw66zQGsy9Q7NBsmPYhMxEqaSpU5yehYruPyOA9DWr1iYYxFF
         e1BgW6uOwW5bpFZgOlCfCeIawpK28Knd+WvzcpsSjCTqtb5HpGWO6D6dvNJ9wgqJVh0K
         9r5V5B8Ji5ZW4SPrrSIeeLcbk1x2t1oquX56VIeuLTdUJz747YX56i0uwAXGk5TOGPj8
         A+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463472; x=1740068272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDyhBZMln1bycs64uQnjujYs7wjZ1a8hAKD4vRr/hAU=;
        b=dLDksgoq+LtJL210LLSCyy7ZF5s4OGguPxUnBb/AUfEcoBTsxfy6ZiYHnRxwI7YT/f
         SfFJxZiv0i1UgRuDLCrJ2xfebYcFYgpZUJ3dklhfyqMd/bp0oLK9r+Efe2ZY91Uj5NeI
         b3Ht6bZ+XHdqT119WPgGZ2256sxmeWC3nrXyQT6gtmybavi8B/TnR9egNaRFeJqHj7bg
         Sp9p5BsmgMavQE+qOHt76BmRqdJX/G5fKD2F9euai7TlIr4NTICjTHayGwDA5GoGKz8c
         Iwy9FWFAY1t7YqAl9qJPE/5CWpxZcc4vpqHMY9TsWWZDasV6yR1OSCozmYWcG1E/lTQA
         lj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQg9T18Ejmedu97hUFrrmtn2b61ebgMwHB/Dix32p9Tyv/SzKaXDUp8HdWFDWAT12DrpAMLyXmQhnrHbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4i2AalJZ5UgCCYFfIS/SvHFqk5pNTO9HMSA8oSle9PvJ+V4K
	XYMJXdwYpnq58TMGftDt6BTuX9rn7TMJb2tGOf8P0Y+iLkzSZ7m1MneqRJcVgVo=
X-Gm-Gg: ASbGncv5glvI3fqQdzhlYDyDV96Hs0XMFN9nGXVB3r7rMxhyt5tXT1Eb7JzRx+WD7E6
	PggcwIqqYAYiCkz3nvD9CjM27oXgUJsFFIfFBoWnj/+XzXaP0N4prjcmvx+8cT+gJ6Pl+aoWCgz
	2GCl1jPpQdrxny/roFZOgZafXLMD+zzU74CasXCK26A4wjoJ91TA2wpsflvKcXkw5PRkjrjhmRN
	wab5GFuzzN3fUvoSmKwcaGACGsawHY6OPPd+cYjz61a1O9bEehQ2EX7WCsHBluL9nlruaziwgIe
	nhboU/zaxo4+7WinYP1NpaPqPDVfHhwJ1T43IOh3n2WQYCxV7ipQCC5byVvufq/XDt8xHxI=
X-Google-Smtp-Source: AGHT+IHN3tJKBCB+UaH1+WiBe+MXFHV+FlApLTdlK08d+t7mvXHf0yH9bADDvOWtecgwSkRMdcmKWA==
X-Received: by 2002:a05:6512:128a:b0:545:1182:183f with SMTP id 2adb3069b0e04-5451dfc1418mr1293963e87.4.1739463471653;
        Thu, 13 Feb 2025 08:17:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105d08sm209001e87.134.2025.02.13.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:17:51 -0800 (PST)
Date: Thu, 13 Feb 2025 18:17:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/37] drm/bridge: Change parameter name of
 drm_atomic_bridge_chain_post_disable()
Message-ID: <s5fsxzk4kkaxv4fqtrjggvjvvaaln3eavyb7lwy7m2l2q6huwy@blttne5ir4rf>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-13-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-13-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:32PM +0100, Maxime Ripard wrote:
> drm_atomic_bridge_chain_post_disable() disables all bridges affected by
> a new commit. It takes the drm_atomic_state being committed as a
> parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

