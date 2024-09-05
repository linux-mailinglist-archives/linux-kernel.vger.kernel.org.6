Return-Path: <linux-kernel+bounces-316802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4E696D5A9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A59E1C23206
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A6D198827;
	Thu,  5 Sep 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuABxPIZ"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27D191F7E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531538; cv=none; b=lpBTIJzCR8LFcyq+eZ2VpD72PXK3sBXdKLJbkDseXNmfR89Y732mfeB4bnwVLeiM+xqa3mkg531k1dSy2Hl7CdmElpTbPIpI8zc7YHQWXjbL1tH3l49Je4iy3ITI5itO/dihzpuoJhLv4cFY5rK1CAgJkR06tHOnbudKFVkxGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531538; c=relaxed/simple;
	bh=LvoeKGy9rwyFUTdJtqIlZp8oy/b9I5WNgqi6kny6M+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKZUajGfh+9WlCSTfKwn7z+M4B/kil4vS1Zv3tk1PBTY9K4u+dYeJXLQsuy1G9HNRtyqLCZAOu5PB6voLp1u9KKLA0WfMjhccGT8n9O1RzcWJZf7rfXZk+MRhJ/x2oSzrGofc7MLIwiHmtCiaohhpwxzrzpaxdwMCaf4wyugXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XuABxPIZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a74ee4c0cso714101276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725531535; x=1726136335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+oY6BaE1ynE7zLjqZE/FTyE2vdgPJk9JztQqZbEjgo=;
        b=XuABxPIZ/Bdr2Mvcb1s+ZpHGFmDwfzfaJoMo15yc5Cxdu49+5Btf9LpsgPEBPX9feD
         tl72WcEX5vyJP4YAqDbdHY2gcS92YJgVOy7+EYTsV/Bim0v37vF5nRCFBmzHgOYUMDrQ
         hhyJiiWQTIyVjzxLNuN1WpoPeoP+b1K4h32mQeQoQFYCJtFbCKMwJoGAvBKt5R6bwOTt
         xBKectciS9MmBxni/ULZptk3uOL3iXQhOnfTF3c+bzB24RZ+fIG6+8echUKE7QwdEbRb
         OXfIC41LHjNuudDChZqGRmRc6AjEfxMYOODfv1eiUf2EhEmyF090GyL9IXi2zBikSF5x
         ACPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531535; x=1726136335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+oY6BaE1ynE7zLjqZE/FTyE2vdgPJk9JztQqZbEjgo=;
        b=eWcQbFPWVgxaXL20ISEbrLiC2B32NwJmPTT/gzBLP6NE8uzbjqKC+g/nuAodbibTjE
         rLTmVKTXzlvh766W0709DXasJlD9AsHjA4qDSzo1PGodukNm9jVk+nJoESNJe50HQpNK
         XatblFUlmEiFjtWpQQ+PzsIgAp58iLkpMjtI5131037QYaKEmS+w7EUppT2CBygmvW6F
         5B2OhFzHxE0TjeGewkEazKRBoYLe9sjazGRlXIemUwVOfK2uYlu60IOU+AcVaJ0Uq0+h
         ujPBuLFdJimyVC2wUVrKeY87zPM2j2z5VTHc3Fxp2bvVPsoQCbKleZPe6zKevRBYMTLx
         4c+g==
X-Forwarded-Encrypted: i=1; AJvYcCXatXXB2Tm2hzPiXGNmqkd+3WfNlqJYrfeEZ5erJm2iydvQOXXeDNHt2Ou/8O1+cN5dpMttJNtYP7AO2jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPtc4ojHCNtggFFzmGVsUcSLCrwpbISVsWthw1AOkCoyis3x2
	FCVxv3wc3BTnfDK8Jnmfo9BoqoGU1yBtCZvLquaEtrA2E5t/4hWNwlhBoLmGcJskR6QpvPQdAPA
	9h30GJtdXMMbFCn3Yn0qk635QyVgjMaLfOTDbeg==
X-Google-Smtp-Source: AGHT+IHuelAEtHGfJqd4cMp1fQLqMT7mIlLYd7mYntKCpCV6iNSsUlkVhguMLQWaZS9WxDOAH0lSnuB4JF5PJW02eW8=
X-Received: by 2002:a05:6902:2d08:b0:dff:2ce8:cc1b with SMTP id
 3f1490d57ef6-e1a7a17a74bmr22861488276.35.1725531535404; Thu, 05 Sep 2024
 03:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904232512.830778-1-jm@ti.com>
In-Reply-To: <20240904232512.830778-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 12:18:18 +0200
Message-ID: <CAPDyKFqt-dATBPTFmAjqocMt_tKh0s_GHHprBLWSmuV0wn9kQA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add retry tuning sequence
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 01:25, Judith Mendez <jm@ti.com> wrote:
>
> Due to failures to find failing region issues seen on some
> boards, add retry tuning sequence to make the tuning algorithm
> more robust. The tuning algorithm will re-execute up to 10
> times if there is no failing or passing itapdly.
>
> Due to the same issue above, add prints to the tuning algorithm
> to make debugging these corner-cases easier.
>
> Changes since v3:
> - Fix compile warnings
>
> link to v1:
> https://lore.kernel.org/linux-mmc/20240815201542.421653-1-jm@ti.com
> link to v2:
> https://lore.kernel.org/linux-mmc/20240821192435.1619271-1-jm@ti.com
> link to v3:
> https://lore.kernel.org/linux-mmc/20240826210454.3928033-1-jm@ti.com/
>
> Judith Mendez (2):
>   mmc: sdhci_am654: Add retry tuning
>   mmc: sdhci_am654: Add prints to tuning algorithm
>
>  drivers/mmc/host/sdhci_am654.c | 54 +++++++++++++++++++++++++++-------
>  1 file changed, 43 insertions(+), 11 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe

