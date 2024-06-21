Return-Path: <linux-kernel+bounces-225371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BFB912FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C5AB217A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAFF17B419;
	Fri, 21 Jun 2024 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEXAmjuV"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258E729A1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719006337; cv=none; b=OWaOdhdoe/pQxgm8o445+NaeNNbdTkcRv/cJ0O2fcUaxIvLvGAYTuFCCp5RQzjEwvlhPC+KRlCddaVoMoA5vRDKCFJtVH6G0Szr8Dqqa0F5MOHYXMmMVsgARvFhkorKWmZHoxVUbTGIlf0qGNfGnq4HW2CIZ1V0kY+wdSFUGMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719006337; c=relaxed/simple;
	bh=Znb5uiArTh7529OX0gb0BE73ewYX2QhYRziOGfvFOuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCvcZx21YXu1E4IaxnDWNqXGYrYiMSPsEZXzmgxFq/4H7lvoZnww1Y3Vkc+O0LsNrisDsDyvtGA8fe7UqCXUtQ2kYJ68CHKuOkOnJrd5wS35mjzacqFutVPUkzAYwd14oeKIO74/LIbbGyjwjcTOXSBWbUwTPMYlvSFA7BmxcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TEXAmjuV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso2940290e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719006334; x=1719611134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzD9KRiePP7qUwVdbl4pi5G8gN8VbBVoo49624brcO8=;
        b=TEXAmjuVbUiuCL64DHfKt3xyo9RiYFBIahpYA4SnrQ7oZHOZV2pEBo8SdPyzQ6uvu0
         MIiziripuc/lqzz+OGRI10+vRYi2eE1jwrgZXe1TgysP2qV9h4PmBxXUlk38XfakQ1vk
         vpwz486LOm/4ScAG9xQc/UHxNOtxJ9NuagM4kedVsdbz5lHiwJEIhq2gULCDkVy30MvL
         xLDY8pWpTwa2vXS8UX7Lga/umK/f04owS47zN9sCRL8JMi8BOcmZ1/k86C6oVHBuBPSp
         PvInjXAtbmRAXSI3zpDUCbVh5hISSjt9BpMBFTackiGso0Pa3BH5w4WwlPvw7bI5lVV9
         Fuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719006334; x=1719611134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzD9KRiePP7qUwVdbl4pi5G8gN8VbBVoo49624brcO8=;
        b=Cw1xljOiYR7eM1u2awex78SmNFLyAIQNEsLVz+iQwK9nFAyuHNhf0VoqfDTMq2eO0G
         r+kJMnjyWBGy/zIc80/+W+SG7yqLKioUUlvDCbPliw2sHLPhRDEtZBZ41P8KPx0ZIa0s
         H7L/JRtlI3Yjob+xpoXWQscwn99YUPxjilTrNS79j+6waL1xEarm83B20+iavkIMrrTb
         WIhLrCv9j4N3XD8YY7Ue9sDgls86f6kqDYw0bRYVIvs0k1kbN7LEKW7x0vEh2G4jNKH6
         tWWYHeiE8/C4DlCgL9PiI8HOtud0lZCTp+aur9LgU5rsmts53sKyrrcUAIRZw4lgNQ3F
         WSsA==
X-Forwarded-Encrypted: i=1; AJvYcCU2yNALYopwuDS0BUtJxNZjbDY5Uz5EWZfX4aixAKVAyzDMpDcVcbT/bC8j8QtsbmCis0XbeCZ/9ZlmnMjuZHq9ZQmTpua69ONsdV9T
X-Gm-Message-State: AOJu0Yw+El/Dcwml6K/K3aaZ9PDBY+JESUciTkC0BYne9fCen0KbJgzh
	gq9lazNICvo+iZ9PgyG8v8lbTlcbvW5Mg7elsJz5gvP97luRsdHkD+bxz75OZsE=
X-Google-Smtp-Source: AGHT+IGEjkmbRauRN60byxtu1+ntoVgQexF7ioxCO59JtaX4ZGjIs+ZxbGr7ZvTpq5M9hwO9bImPVQ==
X-Received: by 2002:ac2:5636:0:b0:52c:d5ac:d42 with SMTP id 2adb3069b0e04-52cd5ac0e04mr2328670e87.9.1719006334225;
        Fri, 21 Jun 2024 14:45:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6420371sm313048e87.170.2024.06.21.14.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:45:33 -0700 (PDT)
Date: Sat, 22 Jun 2024 00:45:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/panel-xinpeng-xpp055c272: add check for
 mipi_dsi_dcs_enter_sleep_mode
Message-ID: <rgwik53edk3dipeg4v7hjsi73sqhsrpwtjrosnwfqyuicddcxi@dygh2mugchno>
References: <20240620074802.852544-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620074802.852544-1-nichen@iscas.ac.cn>

On Thu, Jun 20, 2024 at 03:48:02PM GMT, Chen Ni wrote:
> Add check for the return value of mipi_dsi_dcs_enter_sleep_mode() and
> return the error if it fails in order to catch the error.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Fixes: d1479d028af2 ("drm/panel: add panel driver for Xinpeng XPP055C272 panels")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

