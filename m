Return-Path: <linux-kernel+bounces-244609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39492A6CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0852B21033
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693461442FE;
	Mon,  8 Jul 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Loi3SDcF"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D360EC7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454767; cv=none; b=PHFkf/m9Nk1hVa0jRFFT58UgcBZlGqm1qN7fN5EU4ORotaRmSuQp4LSBOV3//RPsfcutydw+sBhaT//d850YPkIM1LqbGhIWofoUpptwvGM3JeRRQVz+6Yuw+2uI3c3R1s4D6WQrhsngSouLW7s4LlySzBRzANx/o9UZ/1pSPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454767; c=relaxed/simple;
	bh=lGPmJeUaHAtXVao18UW/KktsnLKISywsTLBsKiL//kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpEL6AdaDf7XuDA/lSV4qzPSDID4crYzR9qurLvjZWrMKA2S9Rh8fl80W7P9AvShzKbK9745+aYihpa1AP8KO7zpG4n1vDVS60jJdHAu20DoQAJ0+9qf3s/xFGOX2xtZc8MoNMocjtmnmdC7CXXkKDrQ8K5oQbuoSHfK/Xyy2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Loi3SDcF; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so1972286a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720454765; x=1721059565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yotOwh1dtE5DgMK4jrp0VM5GfIPbQCVEmdEcJAa+qI=;
        b=Loi3SDcF4sto1qJme4c15I7DvUwCgu8huwCjqFA9+FnIIZLHLTt1VtyyZbjF/VDYVe
         RrVJFo6yhUk/SoZgiFWLNGxie6zitgbB58GH77424EBea0ITPYdryXJ2MrAI13mhDNMf
         7GIPi6mYTniVj/6vO7lVIOO0wJ3uIVS/8REj+wFI0A9L5oiCJ82YZEFL40ywyFpqFcYd
         ghg1mpR/MDINfUAvTDOuGJtrua/Gs8Z0PMURXzIN5/QZ39fp1oqo7EI9pU8K/G48HDxY
         8TzLi1E+rAdJD9Y/DOr6vAZdAaoVzl7ZblNnmp5Vx9Zi1KQ6cisoZDwi1GW0XcJQHd3T
         ni9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454765; x=1721059565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yotOwh1dtE5DgMK4jrp0VM5GfIPbQCVEmdEcJAa+qI=;
        b=da2M7E2J3wru8b39JxqQFCYvmhQbFQxFhDl+iizNw/18RpTJFlHC5V976Vw4YdM7WA
         Ayh91oFeQ4Djoyc3CuTjEkhbC2NiMwVrOPOfOyvxfg6PgJUfTxUEprf6YdPmw22jDIjd
         INBO/5SceXEmgrbNlNiaqBZTx/4KBO6xecbCc5LIr+H0l6Nv7S2ZH0vWH05D6E4Gj4ad
         1RFcYtPgeCw2YQBpiYw871kLssYAwDjQhbEyh4sdQSOMDGCu7Un2nDy5rjqR8dJ9lqu4
         +MJorLwn6hJS4qry3zKiB505xAY4fvbOs8zGZWO4ESePA9KQ1EP5wE0SOO18G8u6fX4Z
         C/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSR5bbIU7ZMrGHDeAoUoMG1SbvyzUdfTNnlmn0Nk3paeSFQru/iSXig2bo1khiaFGZ154zzM20ZbAuWhtpPpPOqv+PNXm9wvr8l3qo
X-Gm-Message-State: AOJu0Yx4NDRI89LI9onOKOrhfx9JfwrueS5s1SVLE3YboyJtMFIIrVvF
	p/6vJefrVlkZOcQR8+2azmwCIjsgG5W3+s0nHKojSzLjyv5ReCeFPAc38sE1JRQ=
X-Google-Smtp-Source: AGHT+IF4pL8APdY3c5DhYc7WskK7MW7W4Z9fYaj4VTZU8WRclPesMbXiUmaRA3FuKwavhdhGST/T1Q==
X-Received: by 2002:a05:6a20:db0c:b0:1c2:8a36:29d with SMTP id adf61e73a8af0-1c28a3613d0mr2559231637.6.1720454765685;
        Mon, 08 Jul 2024 09:06:05 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f189:baee:28ea:c31c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b5585sm20701b3a.188.2024.07.08.09.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:06:05 -0700 (PDT)
Date: Mon, 8 Jul 2024 10:06:01 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jason Chen <Jason-ch.Chen@mediatek.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] remoteproc: mediatek: Increase MT8188/MT8195 SCP core0
 DRAM size
Message-ID: <ZowOaQ7Atf9D4uoM@p14s>
References: <20240703034409.698-1-Jason-ch.Chen@mediatek.com>
 <f9cbd088-c00c-455f-912b-cc119566e62c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9cbd088-c00c-455f-912b-cc119566e62c@collabora.com>

On Wed, Jul 03, 2024 at 11:05:59AM +0200, AngeloGioacchino Del Regno wrote:
> Il 03/07/24 05:44, Jason Chen ha scritto:
> > The current DRAM size is insufficient for the HEVC feature, which
> > requires more memory for proper functionality. This change ensures the
> > feature has the necessary resources.
> > 
> > Signed-off-by: Jason Chen <Jason-ch.Chen@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>

I have applied this patch.

Thanks,
Mathieu

> 

