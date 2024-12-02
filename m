Return-Path: <linux-kernel+bounces-427879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9799E06FF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBC0284BD3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988C20ADEE;
	Mon,  2 Dec 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwq3+P7i"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08220ADD3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153071; cv=none; b=Chfz0zmcUPJ34f+NrYTi7kgcmbXSl2B0Twh5NaFviu0ffyb4G//lgkDVjWD/0/nz9Ka3p2BqG1+qa2Tl82Bt00R4Psx+6SwfaIytQz2IkmJlLyQM9uQj6jxBgh1nAP7XeCkQZsTjHtftl3ZC4Go+fzPXbLvB4/MUI3ZEhQhvhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153071; c=relaxed/simple;
	bh=3gPoqlU/lVE5xUuM0NiL+r0pSn8/8rHBVsYTlF7NftA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haRggVtNXVsR+K3iJ2f/goe5iBwp1rN3TdpW4u10GXwAwXjPeR3BLkyokPif7yuTLb/7wXudAJPGdti6BJzCAXNGlDPsF52FVYaC/crVQJ3MnrxZYWxPCbfvcC+uggDji7RtJGVOQmzHbxxxEXlluT/Kleh3x+ajWCxVej+x7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwq3+P7i; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e3983fe3aadso2935057276.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153068; x=1733757868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YjTimCeXKhqZkZ2I4f+pexjlxgsq58p8L6qd2thgsT8=;
        b=iwq3+P7iJnd9FSww65hMYq52EqsRfn9fElg8M/j2fyg+i0z/KkzZYB3+/RShyg6kxh
         4uCCdBYOUrF5Z+Hr+J4ru4VC7ixE94NUqwj6myg/ddNoatcAQ/5WV9Lbm5A5odXk7aU7
         xGM0HFIwFbYfmdGMHc5aHbjhik3LxmaOxcsVUxkJqIaUBdpmgCObKdh9dFQJlgbdAayH
         w7jmGtLT2D6j8qpVGSbzTil5pAs2bCi3+j4K9VlvDOwz3BJqmFbn/KjZCx4cDdb60PDC
         oJrZm91bBipDOfZ/nIMtjuMs4bDpMetYA/p/EqjEU76ciraeFhDKAAsOrPGrPHITXtXL
         FSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153068; x=1733757868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjTimCeXKhqZkZ2I4f+pexjlxgsq58p8L6qd2thgsT8=;
        b=WHWhtin/oZP3rVDY4qI4cehFwffz6KadCA3uJViRzs7LsA4slM3s8TtaY76MmEQIL5
         PoZxeUHumfTBEKHKuE6UaA7ePOtKP2lmOueJeBi6FmC+9rPI3RDp+TWVpJWITXK3OBjy
         wcL5enkw93myZxLCwCCVbGJrJuFCR2ZaD3Bd7qZgr2+W/d/48QDTjpuSE1OQEdsO8aos
         G1r7IPSHqnQ5nQ+xiP93ttLe8aCcDFmsaL0m1/gwNhH+spRKaQKygkoXT4V7fUiR/2E0
         XgkUDCwc+ZQuHASobKBd8559vIAoD6QeqKEput2taNl95bktne2fL0TGj+AByQ0RVE+e
         1Xng==
X-Gm-Message-State: AOJu0Yw/qnRQkxlrap0ShskyCnRExGplobUyLAEiu5dLPj+MUmSZNVRD
	jwMGklS9u1RJCn/DOm4BZcM6MAwFUlgFYebHlNMW8sBwWtlceQTZ+Ae/F5Rb7YZMap3q7lkYJwt
	gzswwyWKBMUuqPXBYw1JNFMW7alSikE+oGIv5hw==
X-Gm-Gg: ASbGncvxj6GMnHaSZZOiUapD0N4jVSYwYBvsEK+cxgZSRkLTcFgaupsl3ewjEu5mS0G
	seVCRrZQCLb5jeEBZfxw4Gs8DIF4Gynhq
X-Google-Smtp-Source: AGHT+IEhR2D/dt/Vw7dqmP3c1NfSMof6dcurrBG0/Efhevbt891KsJCPtAS1p2Tq5jM22ure7AFSts86rVb6VBUO0Vk=
X-Received: by 2002:a05:6902:120c:b0:e38:8e02:1f13 with SMTP id
 3f1490d57ef6-e395b869cc6mr21365154276.10.1733153068170; Mon, 02 Dec 2024
 07:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com> <20241118072917.3853-9-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241118072917.3853-9-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:51 +0100
Message-ID: <CAPDyKFpNTCEGzi43GABuQNo6rHV_OWWLhemu3p7Za0+rs3zVTg@mail.gmail.com>
Subject: Re: [PATCH 08/15] mmc: core: don't include 'pm_wakeup.h' directly
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 08:29, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/core.c | 1 -
>  drivers/mmc/core/host.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d6c819dd68ed..c877dae8b4e2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -19,7 +19,6 @@
>  #include <linux/scatterlist.h>
>  #include <linux/log2.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/pm_wakeup.h>
>  #include <linux/suspend.h>
>  #include <linux/fault-inject.h>
>  #include <linux/random.h>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 48bda70145ee..bdb22998357e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -14,7 +14,6 @@
>  #include <linux/idr.h>
>  #include <linux/of.h>
>  #include <linux/pagemap.h>
> -#include <linux/pm_wakeup.h>
>  #include <linux/export.h>
>  #include <linux/leds.h>
>  #include <linux/slab.h>
> --
> 2.39.2
>

