Return-Path: <linux-kernel+bounces-193618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AD08D2EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E347F1C20A70
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17764167DB5;
	Wed, 29 May 2024 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIgkC4Vh"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03E167D98
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968688; cv=none; b=Uy0+931qHsbMltAW/0v+VCTzZ5xsKq0QtxEVTCegyntl1lYWYJ5VxRoKHBUnOmGdLwKgT2XFgn7B/XOoqIo0iZ0IGjSo2OxbMbOFDzW8B6pnoo29NBvkoN+n32oJLm3ptl5EeDAc8EtWPMYCWiLaCi/TdPblp8ToPZSMDTRaIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968688; c=relaxed/simple;
	bh=V2Tay+cwE/xAfntGJvfIlOvq+Bb4o/mzQBalXXWGSTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzVtdlmVu1f3C5KWmJeKuub/ZWgI04cSxeTNnPSa+PHqAyGse4fCEwjM+Es8bLKlRpRLZXE+aDmAcF+b830lzt68RQ6QsoeFdgiLVeu6iCVesN5y55g+c9vT+DyPPrHZ5cNg7YU+8WIAeNykEC/bTNUrJfDQkYok3Z5+dbEeL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aIgkC4Vh; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e716e3030aso15809961fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716968685; x=1717573485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S1XyMvug7w7dhtxZdl8ZlGvff2YgfxxUHgfNNPJEirc=;
        b=aIgkC4VhDFkGSlpcz3NPbMDKwR97q6csBvbafWQYVWhsMpCcZBRfq2SQ9IV8apsnf7
         OntV39Lu4gbqPpTyRROPtd5fMcrOl96/fBfzh8r3kt2nvzrp7k4KI/zED/TD95Ms0FIa
         9fOAaSENVgebAqO7G5PwZyvANl5jAZKvaQuBiz5MNdZdBMKW30gvDtySmihO48Y/spb1
         RiuYxG/GXf1krAtxIsVQ3ZaI9PG0BZVZWlGWK3RDuBRAuwLiEYi3L0vU//fUyMqiZpgL
         hm8uj6wYf46abh4lGNfM8HY1ONxKO3dwlOgfZVw5bdRzPDBqNuLO04g9tJoaooQ64GPG
         lJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968685; x=1717573485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1XyMvug7w7dhtxZdl8ZlGvff2YgfxxUHgfNNPJEirc=;
        b=ZcqXSOVJM2oadgUB13Nks48BRco2SJCsnX/QoBajjplvov6DqyJyal7YcyKHtBzn0D
         DC8eJF+/Z1BDozXBK9QctrWP/Q8fPRaF2Rtm4Ibwpj6Co6kqkrFyEqxVHTrf5xEuZmuC
         QwePz739Hr/YWayTvLalaE2IU1NKNLQQ03cWeS5NvPNGX0N1doU+xfXljnpiC0GS2/uU
         VDJknC9X8+wyQ1r5BpjnR0yPkLblThHq4DsPuRqG1lFPw03+ukTpwWG3hmNcgIgbjWD4
         sm8vl9vm71wlnxKAXAR2FA3jrZhOgeOaUKxxN9QR6R2HocbTJ8RXIWNuxtBHlShM09LL
         lxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjAfcIpQaODwWi5rkyfbqc7kz5cDxaR9gMICIU0bBOrSVE92uIk9XQlrjrfXtYM5ykng+NQs8ZRlP89+xKWcoCLsSuJX03q9tC9bZt
X-Gm-Message-State: AOJu0YyJip7OZgUitGlkXaV/RifhODPLntvH0Iztx6BQ8cIJENdjR10K
	/L+GfjSjGHzq4Ri1CAmuy7neRvx0Iko4jiV58UCzaKMFg1arUwDP5fQypcMezws=
X-Google-Smtp-Source: AGHT+IHWA2lvLG0B0kntbUD/V5owakoa3EW0tQI6tq3UwCSFqELYaCxoJok/0cawUBov1/1KRXreEw==
X-Received: by 2002:a2e:b05a:0:b0:2e7:c29:dadc with SMTP id 38308e7fff4ca-2e95b24e06amr72686241fa.34.1716968684582;
        Wed, 29 May 2024 00:44:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e9816943d2sm6297271fa.61.2024.05.29.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:44:44 -0700 (PDT)
Date: Wed, 29 May 2024 10:44:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] drm/ci: generate testlist from build
Message-ID: <nsamdoevg6fhop3otikwsmu4ga6ysyrg2ogxbqhw3sqg2nbqq2@n5xbqid7ltiw>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-4-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-4-vignesh.raman@collabora.com>

On Wed, May 29, 2024 at 08:10:46AM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Fix testlist generation for arm and arm64 builds.
> 
> v3:
>   - Rename generated testlist file to ci-testlist.
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   35 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 40 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

