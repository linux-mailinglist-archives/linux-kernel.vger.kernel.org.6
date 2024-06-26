Return-Path: <linux-kernel+bounces-230093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44F917848
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A23B22F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C628565E;
	Wed, 26 Jun 2024 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyzDk1UP"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7CA48
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380829; cv=none; b=OTE+n1S6amw0FQxx+0vzY4o63B3QXMKhSXC/GSzF+dCif5Cj7b9/yu+fGgkJioS38g1pObATKciyDJwitxXqX/9XcZa8R0gVPGpUNU5LU8ackTfM4+m0QfEsWEvQ5D1XDtChD7NmjCODL3mwGj86Lah2R/HEuCiE8+V2RrVNS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380829; c=relaxed/simple;
	bh=GjLOELpmiccVwzecOSbZTD5nzCHnm/PYCJ7Fl8I+nec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdKKVo+7AI52EAyAqor0wdhOAr2NXL+1ndl8vNSsmglZ7jyQmF34gYCzixjGrGDmH8/tlwKYxZDxgicpDrFywK1J8SgUtVKqUrw9d1omeLlOrVNp0jHnbGBKBAqJ+IBloPXdcXKqTF4DSdbpbKXXXfhrA+HwoByS1jFGP2OkLts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyzDk1UP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c7b3c513f9so4874023a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719380827; x=1719985627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGbCOLfGf5G5R0Gqywufybmht3aiBsjc/asVfFAxRO4=;
        b=OyzDk1UPlNCBw+iRpBbRFLlAxbi1BPu2+DXkD14HFdNQiNSvc11+b7oEXdxEjEdinH
         o5kVnSsvL5seo3yiDHrMLFanIGCRCXP/AkJwfsJUiFDzFeNZBopmeznf2+Rz6LkCsVaS
         UIkwWozNyuGtXxCqoV2J1FMb9Y04j5B7pKLl0Wd8qKd8WheCv0ocZCdFg7k7AF9wTygm
         qM5m7VqEsxGkr+Q5+C/2aMvSGDYTl1nlEMjgrtsXR6n6gYZO5U/jQVmQudFYTzlbRoRp
         ybMOtUVgEwubsb0uvi0AvSvVnkW7kywQpHS+PfheKzgRGQIrEgmF0G4rVG52YMdzUReu
         lo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719380827; x=1719985627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGbCOLfGf5G5R0Gqywufybmht3aiBsjc/asVfFAxRO4=;
        b=VgZ8UB5mvPTfcsXnrFAmlS7GembUM1oNlmYq+iz9v62GuC+HqGh5TG1i7YonqXNktF
         xbTqzVev8VtwlLz7lrF+z90jlSVMJbdNUxwLFTtRGcpXCFhtnyDBoNbdIxX1vdyGOcoe
         U/fMppmkb1yCh6WrFwcQaiu8govzuvZr/sLxAU0MXZgV9K78etX78Z5ZjKKgnDfBdQvu
         s5GmR6SJ8jfoj2BMUBW0DiPyor3nDvMehNok5EBDbEDcFM74cTOcZQaRjUO6F9Mm2M5f
         XTmRGnnJ87oQZuzifKdWV7seHOIHCzHU09p35gVpJ3S1qrc53J2QfpeNcx3aa6xMrLPR
         LQHg==
X-Forwarded-Encrypted: i=1; AJvYcCUu4rXNlSmEqzCp//Sq+JFKONjicFiVFtlglHA1qbjh3gvdGHN4iWAjBFIoCzij3JBYkTvRCMwHcyXcTLeZsCnxzIYaq4ruGqvUg/UF
X-Gm-Message-State: AOJu0YxzsYj3piMkUrPfrvmTANb5vk4ITjrAHxgb6Ss2Uli8QJJio0Lz
	4i3Qc7wofwAyeChWFOR8gPrTvpi9ZnGcrkvTqiYUhPM2cQJ6JKHw+DxHb39GM7Y=
X-Google-Smtp-Source: AGHT+IHV/WWx7Uys+drZxQOvOENlnOZrmogqtv7AVUv7W0awSUJ64Zoku+40EReCsGFNpHg1KY9HYQ==
X-Received: by 2002:a17:90a:6007:b0:2c8:5de8:c85f with SMTP id 98e67ed59e1d1-2c85de8c954mr8129754a91.8.1719380827440;
        Tue, 25 Jun 2024 22:47:07 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d807ed63sm687018a91.46.2024.06.25.22.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 22:47:06 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:17:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] OPP: Drop a redundant in-parameter to
 _set_opp_level()
Message-ID: <20240626054704.u23vx7wlldkdrlkn@vireshk-i7>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-3-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619140849.368580-3-ulf.hansson@linaro.org>

On 19-06-24, 16:08, Ulf Hansson wrote:
> The in-parameter "opp_table" isn't needed by _set_opp_level(). Let's
> therefore drop it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/opp/core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Applied. Thanks.

-- 
viresh

