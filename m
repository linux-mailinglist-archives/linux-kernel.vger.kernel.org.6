Return-Path: <linux-kernel+bounces-406549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6908D9C60A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE0B2811D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF65218D6B;
	Tue, 12 Nov 2024 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0/ov5ae"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E97217F56
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437058; cv=none; b=BoHwUtAykhxpNvWQ2Rz1bFD8QmK+prugoAnJk4DGlmW+7dUSRvJ9BtQQO/N1f/fsVouJX9sB9X50c0u/THxXhqJVVjAGAH3O5p0LRBZeNs5axlC3whz6sygyNDYnZdUnxqpkPqeNR3cm9i+Hx842Z/gMDYfuu8d1EycE95TRDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437058; c=relaxed/simple;
	bh=h3lBZ0BUTWnT9gUFIOrJJk3mikd9YNTqYkONtmbLDBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVeADfuFwVQBf5J5ubD1iw4Erh6AxUHat24C5BIJRlTCkj7R8yQ6t2ZTbvL//W+d451SB5frkWevoIbXc1RIy0GUd19frOnMxnKC2BUCRG1C3injFJo+PZjmueD94grvL4Ygug2ZTeO0fWFkCeid0qFSyE9e4ifUwknhT+3g+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b0/ov5ae; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e9ed5e57a7so49016427b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437056; x=1732041856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k13lmz+TwzCl0v9DduFFPQacpvaM4QVOkiYZEVxVBV8=;
        b=b0/ov5aecnG3xSkF32oSCIPdmAAaAtXz3wQgNFWXywtxKYj88cbs9UCn1sScEkVSd5
         JGy9eR2oRhOZ5kEsFzt/uMaJFUv0MkalgNZVbrBn6oORzdPStTjGfh8gyNueTvqpnB+o
         q7qM1Dr/3/0Z3ZBrhXFfHi8MO+Pec++4eZ4DN5KD+cwa+eJgOiVKrOa17jYixXDWZMbh
         T1Puq4vUmznwnGCn+Bpgwn2CwWuoRwolg5gwsbsKPodYjCzG6DmjrAGEY/DVmd7jiBIA
         XxYaD/tvuRMgYrBC1n8bHtQgDvukhYAhq/PiiMKUTRNd6xsDk68TVbQ4wMxg8oM/20Et
         Mwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437056; x=1732041856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k13lmz+TwzCl0v9DduFFPQacpvaM4QVOkiYZEVxVBV8=;
        b=hxA/CBEn4T1y7hFTYAx6fdQwE16KBRsf9waheCAA3rLj1Y0YtRE5WSfY4WVAIMt0G1
         zkSBmtjzSpxnyeXRVg7uk+UNeTqYYHfJwwYWpwPGwcvK91kpMQMz1sBJZW1+fgZ2viUv
         2674Oz0hOsZnxU2aPkCEL4LyFY6DyIu73B9T+wklRun2EzqE16R77alWLQrvfjCuY5ho
         P4bzTUpeNjXYE5dNHHtvZjmR/B+oNX9jnz5epYAv5MF2Ks3aHXopytryBoc3CjTJyWel
         hx/8yftg3tCtAK0GvLgxmsZ4/wV1Il5+g02wnNz4m0y4cOVwdiTplgFZBeRFFXDeJ/cN
         MsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDaRDQjfJygR/P3nUaES4nrXtSDkgc4kClfSaPzu/Y4tnP0IcU+B4oXfJf7qkI1UbzmxEe7x1owhaNvvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7E70PuBLX4KOnnyvMz5Gk8RzNk8YeYtfrkJgfk/K1ojbwLT7
	/+HPmfRXtUjfG78jHFtGSDSBOt61hlUSmRoLMlekt7xpol5IEWYEvKYT8Qy7CQRNnhIkl9aKeSD
	5woI9REUBd8TWYUD+5kQfdBuxRHLJLjA9hmwuuQ==
X-Google-Smtp-Source: AGHT+IGPRAh8w+E+1jxL48F4cfxXMr53Di5HPl6ESL/F1T2+h8ajgC5sB+jl95kU9zsE1PzUcm/RjrfMP4kO/Tqwm88=
X-Received: by 2002:a81:f912:0:b0:6e2:413:f19 with SMTP id 00721157ae682-6ecb347fa3emr191607b3.27.1731437056184;
 Tue, 12 Nov 2024 10:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105102901.351429-1-victorshihgli@gmail.com>
In-Reply-To: <20241105102901.351429-1-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:40 +0100
Message-ID: <CAPDyKFrXsnOkwEwosddqeQKg5kFM8fWeJF+pcr1aYypUHqC=fg@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: core: Correction a warning caused by incorrect
 type in assignment for UHS-II
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	kernel test robot <lkp@intel.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 11:29, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> There is a type issue in the assignment in the sd_uhs2_dev_init()
> that will generate a warning when building the kernel.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411051248.wvjHSFNj-lkp@intel.com/
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd_uhs2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index c5847a2084d5..1c31d0dfa961 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -181,7 +181,7 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
>                             UHS2_DEV_INIT_COMPLETE_FLAG |
>                             ((gd & 0xF) << 4) |
>                             (gap & 0xF);
> -               uhs2_cmd.payload[0] = payload0;
> +               uhs2_cmd.payload[0] = (__force __be32)payload0;
>
>                 sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_INIT_PAYLOAD_LEN,
>                                      UHS2_DEV_INIT_RESP_LEN);
> --
> 2.43.0
>

