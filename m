Return-Path: <linux-kernel+bounces-335857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B2D97EB95
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C69CB21315
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABFA1990B5;
	Mon, 23 Sep 2024 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gp8ISY1j"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D710194A59
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095122; cv=none; b=NaEDR4+aGDfsjpsxmSoFhh8fHAMV46/czNBqy3JU4HH45JvXHCTUAdyqqwrWACD3no1V27hJx7Uc0YouMYxCeGpx6SqkyfyfjCTGOej10VEkAAWTeWUQyt08deWwzZ+cCcR2WiMpU4ki+B3xtsdClRuT8KdhZTxCkiaVj2puGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095122; c=relaxed/simple;
	bh=r30x0TkCWCPOd2zhd0LmB5b0FvxiWh8i8c5rEtzxM8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc7IrwtN0sv2SVf7nyHqhG+11ChmlQZQeuvcIBxDZSShlR7mEyqc/OoIn5RJ8Tz51abbdZnXmIsyQv+2AD0Jk9ASZf+QY22LhJk5TPL56owEoCBo0zbhFq4pxytYOyRYWPpifJCLGnvjtbqHPJnnoESNAflCDTPUG38eATI9TLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gp8ISY1j; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f6580c2bbfso44485911fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727095119; x=1727699919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yO+7OpIomOWl0iOTdvngOzd9ac0O1rZqsrTnwlfKJ3w=;
        b=gp8ISY1j0bP2PCfvGEW1kX4UR/js906bUg+PeRy/awXu3ayNJixaucESI+r3jzm5XZ
         o9k+MPPjjw56x5aajb586tH9v+TgFli/y1B8w7K9ezzSJmvlM1OsSm+RmzzZOrfEOikI
         mNbtjeikPYO46/s5RrZFrKXy81AVyaFENpvtPccE+l4i7rI4hQaR8RXFyWD/aPMPC5u4
         lfHaRebEunZ7UdD6oXTOT9YEZYoNLgH+ar/u3YuoogzaEdgMH0pEHryI4mKBxZ/HNapn
         X44m7av8BxVF5dVroFlciIOmqobLHhLgD5HS+rOiF4Lj2o+meMSxhbH0srSjL8OnzoXh
         cpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727095119; x=1727699919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO+7OpIomOWl0iOTdvngOzd9ac0O1rZqsrTnwlfKJ3w=;
        b=bQQaiobezh4qhMO4ir80w7OMpDA5BiroMJnN8Q49qjJFzJojVZLW4XC4cBs5+7UC4i
         nw8FpdmdrZxH7HeDE0c9sCBauBai26jJZwtqtk06GnFHswM4u8Kre3b6veN1oIYf+ULs
         11sMBmvhhe9xw8AOF5LVDQbUbBvsc14uP//YSFV8LUJssp/SxvbbrS/B1Yr9UNaZohzd
         vOrWZtR7xrlq60xnzcpym6uoiRCM1qWKA2Hc2+NR3lGARhHJiHmyDeHU47yxTPv+f+oS
         wKeQV6KxyQnwkjgSL7kHqu9kfoJHl60oI4aEC5W4LSM2BhHkKcdhVwv2qRJtChlYg1o6
         YeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj4q5Zr9o1jjsUYFw5SQCN2KYKCryFWP4+dWW54LtwJ+Zkj5hJHCx6TmUwcdyXPfo+KljAbJBRfoj8wRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8U6QP8SloKyXrT8af0VHPhImC1ubd7S1qMpwnHu5AMQH3KzkJ
	XPepDxcf0sPoyR+2ez891MOCFr++EpYQi+v6IUwTVN2I4MEaj11j1/P9EoPBrxo=
X-Google-Smtp-Source: AGHT+IFEfpLdWF67rNXJDjM6L650sxfmqOHP8oi42p0ZGCDagO7bwfQ0rGw+v0Zdf9oEWaOL9zCJVg==
X-Received: by 2002:a2e:a90b:0:b0:2ef:21a6:7c82 with SMTP id 38308e7fff4ca-2f7c3de8567mr52052171fa.20.1727095119082;
        Mon, 23 Sep 2024 05:38:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e1eb5sm28269521fa.27.2024.09.23.05.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:38:37 -0700 (PDT)
Date: Mon, 23 Sep 2024 15:38:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dianders@chromium.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panel: elida-kd35t133: transition to mipi_dsi
 wrapped functions
Message-ID: <wlz7n6cwldqiairefc27kku2gcbix2qcyx4xlzgwatfxweigta@2a5riplj64uk>
References: <20240923122558.728516-1-tejasvipin76@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923122558.728516-1-tejasvipin76@gmail.com>

On Mon, Sep 23, 2024 at 05:55:58PM GMT, Tejas Vipin wrote:
> Changes the elida-kd35t133 panel to use multi style functions for
> improved error handling.
> 
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v2:
>     - Changed mipi_dsi_dcs_write to mipi_dsi_dcs_write_buffer_multi
>     - Cleaned up error handling
> 
> Link to v1: https://lore.kernel.org/all/20240917071710.1254520-1-tejasvipin76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 108 ++++++++-----------
>  1 file changed, 45 insertions(+), 63 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

