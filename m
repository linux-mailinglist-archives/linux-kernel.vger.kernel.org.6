Return-Path: <linux-kernel+bounces-361213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94F99A51C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD681F2462E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4FD218D7F;
	Fri, 11 Oct 2024 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwbaJb1O"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CF6216A3B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653500; cv=none; b=GM7a7zOh37mWq5fvQvQ3HLvKyMfvr9PaB9Xy0NFASBKcjmnu5Nf5eydr+26slvqRmAqg6gbeaN2wyMjGsCOBNq3ZHT2y1YsFQoeWxqYRu1OZen0ZnpC0SL4NT1QJEmy5BwpgF/S53SmNHySSQTGKcuzQX+dBggSzaS6rbKdFWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653500; c=relaxed/simple;
	bh=j/wtLlxySXlF9gYSMdXWCVsVjV+CFdAyaQrF3V57TB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBQDHoELOIANQmJGmClpFiT2aE9avooPuqki9NdZQ7NaBF7gSpdgYH/xdIqZ+dHRpqu8QBLUL9pEzH5SSeAr7VHdGkcmcMZZmw4OJj8bnnnjVFmfhx4GB312VvtufbO3RIoAl/FVcjxfTRMXKXs5C6joyztDvA5HHYrARD1d0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WwbaJb1O; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e13375d3so626657e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728653496; x=1729258296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UIlPR/9Tg3tHHscVFQyLHlaqdkpPPKNYkKjRrr77Miw=;
        b=WwbaJb1OgXlDq6wMML81xjqw/G+6Z02zHXiKi6eGVqeTDdFGP9y7yNr6vfWzwD+Cco
         QdYsEVC92NupffUtcSRF/g3OkKDBHx4X9I7hHmHv3qy5QmZH10oBwaXZvhqu2ltXvojX
         sUo7CcFbXl9dHGvHDNoEVUN2XK8Sgaw2PcDUDz/T29q3tIdPiNHntw0GJ9nL+hQwOPkh
         OaHCQJ8QAD6l0ZiolvEZ6xfsc6VfXRMCYPSSKc3TgYskdJg5baN/beofAw2oj+Re349Q
         IwHR2XlcO7a+AlA4QzkaorpCIlPmrHfPg3WKdZxMSDFZwIy3LcQKLyO7xdIJSHQDaX2Y
         +9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653496; x=1729258296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIlPR/9Tg3tHHscVFQyLHlaqdkpPPKNYkKjRrr77Miw=;
        b=H71diBKoGYyaPXIIKOfj8AA4oLmbzG0JBfPdtreGJoHQkzyi1aVJV9ScRqOnOyT6RE
         zQTITAtLAqMBdlms29Ab27htyBd6LoAHl4f21/21veuN9aMTgSa1kudYm0pLBggs4DI9
         XJQoSTKu/mDPpWeb6YE6/fxEAN9F4hEaRA+CLv16OVF1lUO7pMkUM1lYRQki8H1A5Jdj
         VF5emj18lCm5rvestwXCKqKrsMEOQtD9ypxu02HZvemxyrVkIF8BD65kOaM8ySPlY+zE
         bNz0l8ltLgWrVaLFHO/cjraukzF01qSH5ELAxG5kg5xHkLad79m3ewq28qqRWItMpsIf
         5yVA==
X-Forwarded-Encrypted: i=1; AJvYcCWfT4EDYYky95pF/PcnKvxa0CAOnp+uXENlrJggLDsTgUT0wC+UNs1BgubwYfsFGoHPP3/nRsc+A/pRJ+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//bu+NFzvKsh0rTirT0WBo9l/AKOHUEfQvAC97OwUlLcLqJjo
	gXFVXgoo/NmMCJBBjvlW54BUBNC871So+WFUflkfXERafVqFZDOttlpBzvosu+Q=
X-Google-Smtp-Source: AGHT+IER+2T7o5roEOHdG2VzoyGI9V0OMobx4hMMs/g1LQaHCUTDYumSlr4X5UmhEj8PNLhbkOKQYw==
X-Received: by 2002:a05:6512:33ce:b0:538:9eb8:c4a2 with SMTP id 2adb3069b0e04-539da3c1dc0mr1463370e87.6.1728653496446;
        Fri, 11 Oct 2024 06:31:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8f0f9csm604503e87.189.2024.10.11.06.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:31:35 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:31:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 05/10] remoteproc: qcom_q6v5_adsp: Simplify with
 dev_err_probe()
Message-ID: <qqocjewtt57shpscam4vkixsvnj5f2rjqlbek3mbzn34qzdyxu@6pqultmfonpg>
References: <20241011-remote-proc-dev-err-probe-v1-0-5abb4fc61eca@linaro.org>
 <20241011-remote-proc-dev-err-probe-v1-5-5abb4fc61eca@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011-remote-proc-dev-err-probe-v1-5-5abb4fc61eca@linaro.org>

On Fri, Oct 11, 2024 at 03:09:13PM +0200, Krzysztof Kozlowski wrote:
> Use dev_err_probe() to make error and defer code handling simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/remoteproc/qcom_q6v5_adsp.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

