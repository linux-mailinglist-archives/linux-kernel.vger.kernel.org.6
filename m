Return-Path: <linux-kernel+bounces-308262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE511965982
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFFE1F23E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0393D16D4E5;
	Fri, 30 Aug 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgqgEnA1"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40516D325
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005250; cv=none; b=nYVTnFCC/kkRDUvOUSxWrH/ZCuLhEZpY5FHFbeUoCmUT93Gbx/cOMMfzxvpQ+R/u8TozOWB7p8jDv7OMK3yvlxYcsFF01Ox1u/npB3MYNxmzNq5fLYXWGt6qRPK62aBQPjrXctL8j2squZtWNygWlHSfkS8E+/xkndL5OY3PjbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005250; c=relaxed/simple;
	bh=djhJwdPEBClU58p/NBjRr2izhAJvns+9St76RaABT5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uufVZpZEgk8gPRmaAsp+frG57J9kwYdkqgnFcZclqasExzZMOH42Y7rg1NdP9GYe9N7Y3QaOADnr4tEOdASSVEDHUyQvNWI89jC/6g8HbFLkwVFzVXEp2XXr/CZIBt4/LUer5YgHUA0xtcVKWnzyyWuA3Mwk4RVf2zbZxFyxxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JgqgEnA1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so16850961fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725005247; x=1725610047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eF2+sx/rSYChOj/2mau28Wj23L44k4ntysCb18YnwTo=;
        b=JgqgEnA1GPu7FZrOeNdQmoRqABnpwiHSzp3d7emwxHIRj9Wgnzq6PBGDNmnnBzmYYL
         x3LJwz+R7IBqQ40+k3rKDXrIJ88L3napEvpMBG+7wMkS2FNPZRZXM5omkQn5btl7byXt
         qpIYkacHPwzKEkgCY2knnkHGpf6kJVKT/dt/oq2RMflfVwM+9JDSPAa54gjP6AlAI+aY
         4/8cLkk7IBqihSjKWPzqJcf/8pWJ5uZrRT2yAC/37o6f+43adSwwhD9iEgTnftbJMdbU
         Cw9sfjNnx6ssKHEl3igS+VacFhu7r8gc+Vjq1U5UKET8ln8qTBjtXr/+GHXIM2Itzv1g
         A0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725005247; x=1725610047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF2+sx/rSYChOj/2mau28Wj23L44k4ntysCb18YnwTo=;
        b=Acdl/bOo7PgSFap7N1zNheiHSjQXpTy9d4sYW+GV8h0SyK0kqmWra7nXHCRamXglqj
         J9Bs3ZIvEz6Tqy84Xb1D0hDm1Fz3V7c/Krx7E51ebkSDhExM/7sd5JfS9XpXYImrA3QN
         aFpGvZN4u3cMhOeAOV2aSPNLjEHlbdBACDmgN1C6AD8f+VreJrDDnxJ/J3IzB2hxMWro
         Q2dGkx7jbEfxz7LT1lIdITNpfU90bXtZhMDQYpqysdR2De0c3KUraaSwAbgT9A5RyZeX
         sYQtrsZOwxAJrAUG2eSN7Xn9brVLNV0aurtdxus2EsHTitoqqbHGGgS/ViobxmLKKM3n
         fKyw==
X-Forwarded-Encrypted: i=1; AJvYcCXSiGL3TkPhfa0Wo/x64omW5Wzp33UNU0tNrsQpeEBNats8w00dTvdDgxMYg5HPMLyAIAC3IZPoT+K/Rgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBRoQkcRfY1oN8Gbcrxgm/ru9bG2LsfBbGhZqjJ48QSspCrx2
	qMo3v125Lu3a5NsCBfEU3z1pacPSpxwvXjTAhk+c0BHapuyccS5pwhpRbsXtYdo=
X-Google-Smtp-Source: AGHT+IGLGyFncOCO8wysxVTyS2DCKX0ca/6jgHo5yOoDP9+DIjbDvXHAA6oekjEyFn5hFdhhY5PoUA==
X-Received: by 2002:a2e:701:0:b0:2ef:27ab:40e6 with SMTP id 38308e7fff4ca-2f61055b5d9mr33274671fa.49.1725005246070;
        Fri, 30 Aug 2024 01:07:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614f4ac91sm5326961fa.72.2024.08.30.01.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 01:07:25 -0700 (PDT)
Date: Fri, 30 Aug 2024 11:07:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, amit.pundir@linaro.org
Subject: Re: [PATCH v2] ASoC: codecs: lpass-va-macro: set the default codec
 version for sm8250
Message-ID: <rlb53soai6dhhfcnpwmdyqgblsbofngh2ewub6hphh2d43oofy@arcqq7edrm6c>
References: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>

On Fri, Aug 16, 2024 at 10:12:10AM GMT, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> sm8250 and sc7280 have lpass codec version 1.0, as these are very old
> platforms, they do not have a reliable way to get the codec version
> from core_id registers.
> 
> On codec versions below 2.0, even though the core_id registers are
> available to read, the values of these registers are not unique to be
> able to determine the version of the codec dynamically.
> 
> Add the version info into of_data, so that driver does not need to use
> core_id registers to get version number for such situations.
> 
> Fixes: 378918d59181 ("ASoC: codecs: lpass-macro: add helpers to get codec version")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
> 	- updated commit text to add more details
> 
>  sound/soc/codecs/lpass-va-macro.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

