Return-Path: <linux-kernel+bounces-306594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1749640F3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A875C1F2325F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5115E5C0;
	Thu, 29 Aug 2024 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGCPhCqg"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A664A00
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926158; cv=none; b=GGCwViOGd0YqhcSelrX459W95XwJ61K0ZcDhlAwuaaQbbIgpO8o5gi35MSy/UZCe5WzSDhzBYiklsMZppOgYgoGREeVtXcRhBlk0QZkg7/iu5n+JFnrAc3uPpluP6rVkvF5rX863FhIFDphbqCu8dfdpJnlh1IvCkqmdOkWgnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926158; c=relaxed/simple;
	bh=kWBsuFmGkihSEyQQDgT5DhJM7D7LFu6T4elAYRY96ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezWaYdd4sIvZY7ZmUwAhR/uasLIVSP81czP7g9WHLGOfOJ1Cv8emh296jQaKGb5p3VbEGFzjdGt3EoJMkcM3XUzesufDpt0kzE4RnMm4z91hB2o+f6F8uh9+bs43mYfrBO2jmPUB0SQFrlUrdpA8WtJcTBADSU1SFPzrRRHHq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tGCPhCqg; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533de5a88f8so508605e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926155; x=1725530955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpmTADqgKTRDxLQsnyWv6F/72Kra2IwfcRmr0boWBT0=;
        b=tGCPhCqg4lCoqiYBE6VKzfmDLtLxBOVGyvgv/Prp+a7t3rh4EsOvT/2JvXWu4tjrqs
         e5WqKOYXKcesHaJBdO6/Tj9vtuK66uP0XFmdXJccF82yaS+PysvgktS2p8UV+02X2ptB
         WJUDuxQmqxQ65+RoYhBFLIUofgXOCtAm4gu1ovaOZUQYhMbrY/gk/OcinusJdOzOkI9C
         ikz7++nMDE6njKgO7B4XbfUV2VIBDNhvtYT/uOQCWDlgpR1hzdm3BLyiBd6zljcHFllW
         XlXfauNxQKqmQfqpo61W/imaOb7354KDdjlsLGfF35IpLa/EAWENPDdFA6QYjzf/JEzY
         WsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926155; x=1725530955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpmTADqgKTRDxLQsnyWv6F/72Kra2IwfcRmr0boWBT0=;
        b=mfH3k49eNPg2+32pt4hP32TjQ7i3eT6L/lsEDOSnZrCfUvAdly9ShdvM26O3RZ66Vn
         2G/pXjBlro7rnxLy8pMm8QB8DBA5X/b6xLWw9vs9xJQjKZp7mA2gneg7vG/EJjqQolIt
         S0GWIEuXxriahpnkDVwuY3AVeFfVkG54dDvHT/Bde+hbQFDcO9i/1bH2VmGqOo3uyK5K
         rzSCAcip4hj8DbHncViw17gp4D/wP0InKiOQBTrZclc6OoMmlYt57hocoBWzeeFpRwLs
         Peh9YFO7Zj7/0BUus+5oltYmc6V8DnE6J8/L3TdByql8hXd0Nnd95sRp+xBpQ7dndYrW
         RR2w==
X-Forwarded-Encrypted: i=1; AJvYcCWyzNvgaHc2wHQaPL2px2RNhIm3Dn3ucR6nXpxE2iM04QlPxH3KtXvJJDCRsSrThnSvaIt9y8T7//ObkMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/UvRyRtfxWBOy9dV185iKW7zax+dvXJgwACEQK/NsHS/mQz/
	aNcnEXLky+Tm2YS3JJ6S5am94g2QkVEjB9GJ7cZXOSViqCE9nqyCQOvnPVYdkZCSWcF8Umyir9u
	H
X-Google-Smtp-Source: AGHT+IFTVCDd/VtNow23vJ0byz0hhcjE/CtVCsVdqnShlf6q5GR7gRU4fm+vifvapKfv7govaRhZpw==
X-Received: by 2002:a05:6512:398d:b0:52c:9383:4c16 with SMTP id 2adb3069b0e04-5353e5690a6mr1346437e87.22.1724926154126;
        Thu, 29 Aug 2024 03:09:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540827a11sm112831e87.162.2024.08.29.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:09:13 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:09:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: qcom_spmi: Drop unnecessary
 of_find_property() call
Message-ID: <b374tfltb2vp3gr6nqmamlcl7lkz5crwj7elyxy6wh4izynxut@uin5lvjdhmz7>
References: <20240828130056.3481050-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828130056.3481050-1-robh@kernel.org>

On Wed, Aug 28, 2024 at 08:00:54AM GMT, Rob Herring (Arm) wrote:
> There's no need to check for presence of "qcom,saw-reg" before parsing
> it. If the property doesn't exist, parsing it will return NULL.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/regulator/qcom_spmi-regulator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

