Return-Path: <linux-kernel+bounces-388546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A89B6114
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1823C1F21C34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCBA1E47BA;
	Wed, 30 Oct 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1yGVSm3"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD371E47B9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286492; cv=none; b=K8DeXeX19EH9M9kymHAoOnSWboP+aEFpWjn7pLgs+xHtOimImD0rWIypKuMWeeIB7G+oSM35c2epov+uercCxivAGBJBCGg3R7NsyZ2oqzjqzQa+f3fkxiiHwz21iwGpmS88wxjKGElHVPNcdDfebVM7GuYJ4HluICLpEh9sAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286492; c=relaxed/simple;
	bh=1lwKuaby2rxdJvGX7FjuVGno98Zy+KsJ0slckdUyDPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKXwCLM0H0jhS0BXD7UMIhxrPq/xFjSWiHOnlBX2ElwxkzbaSdHPqKDP4lfp7jq4jezRVuca+3rAQYGnuDI6lTjDaq/RmPmotckIktwUBHrKBkWIWCCiCaSfl2d99EKMDCl+qseUSIYbLTaGeZdgDOEnDmu2gbPzKZzoSYGWYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b1yGVSm3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so7407440a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730286488; x=1730891288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UnqA1/VyP2GaUG0I6DWNe9vsGfHeO2r+Xl4NmfSfDTE=;
        b=b1yGVSm3Mf3FZ8hTa9lCv2UopraAiEoAKwjsvBDJD3OtQrzjhxsIX9U4w4OlpDYc1E
         V9YWX0RyAEinpShPuGJfwbN6DKLPqdvqug6ZfPhU25GsmtNd7R6DruOzpAIHZNHK6bm4
         0Uhs0nRXNoIG0fKjkZXKeEcYwD3jY5NpWEJyX2PY3Us5hvwhnCJAn2R2PsL7ZhKXe762
         Rhp583SnVeqfL4Q0OJHSO9L0IuF5kjKIbmmXQfXX9OeB2EFp0wDxy/xvqPbmUskVPesY
         CfhUiE3nusOljGzZaWdHamxqjeOCeDs4CF5IdQr/EptgWkm5hyMgmZIWfgaWDhnkvo8i
         CT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286488; x=1730891288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnqA1/VyP2GaUG0I6DWNe9vsGfHeO2r+Xl4NmfSfDTE=;
        b=oEzW/zSz6MG8r7iig7UOiuig34laK8navHP6LTXt00uIOTe7UvNA33ZdQKqsoXJqSX
         br1o+WLB5R6SUcH8C2bfnNyX6QBATD+2aV/8Xtc8LyBfWSXmiIFtTgU3doQLuM3He/uS
         0/ivfgjvHnEpc9ECq7PJJ0DEFeiBw0sp9Nd8G6jWMgMcaBKDIKspBH7NMaa6BBGF9mEc
         B6dnzF4+j10UMZvksKUyqq8LwI4XgveDVc5jmFcxcHU74leivQTj/F+aLcg3YZwq2KsQ
         KFYvaNZlDO7Xg5QjDa9hu0lbZBay+X2ERaBxDqJX7IBCvtUyEEMMX0WIrtYwBFjj+ZHu
         6m2g==
X-Forwarded-Encrypted: i=1; AJvYcCWxSHufhG+zq/Qy78m3Y59WJPLltzxuUpUdukWc3M4FHdgt1jBImcRYRXGy6EZ+Wxm5S8iJJec29b4AigY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93BJlPtRjswWoS9lQ0W+oQOWBybPrd0BuQd4OF34KSTEYyEwx
	dyoas9F2S4eUlKmo/FvvxXcGoOMuKvOdI28BGz8kILz0lJIbd1EoUaxlfBXLaP2UtuOhwFWG0Xr
	HEThl0kKMW0R+5qtQn5Aktu2+h3J1XHJlEpbmbA==
X-Google-Smtp-Source: AGHT+IGdyGcqOldNvwewAC0KpsUZIXUtN/yALriYjSXCcd6dndKmnspOWwUk9QcF5DI4DfwPz6hBbGu50dx7SxZEuO0=
X-Received: by 2002:a05:6402:520c:b0:5c8:8416:cda7 with SMTP id
 4fb4d7f45d1cf-5cbbf8b11e8mr10328645a12.15.1730286488358; Wed, 30 Oct 2024
 04:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030015326.2289070-1-benchuanggli@gmail.com>
In-Reply-To: <20241030015326.2289070-1-benchuanggli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 30 Oct 2024 12:07:28 +0100
Message-ID: <CAPDyKFqNxMG8d_rSnmy6XrweH+YSdejmR3Ma9=1UVKYaGAnapw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-uhs2: Remove unnecessary NULL check
To: Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw, 
	greg.tu@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	victor.shih@genesyslogic.com.tw, dan.carpenter@linaro.org, 
	takahiro.akashi@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Oct 2024 at 02:54, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The "host->ops" pointer points to an offset into the "sdhci_ops" struct
> so it cannot be NULL. Remove "host->ops" check in "if" statement.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202410271835.tqz9s9JV-lkp@intel.com/
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next and by amending the commit message a bit, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-uhs2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c488c6d56015..b0e4ab852a94 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -413,7 +413,7 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
>
>         DBG("Begin do uhs2 detect init.\n");
>
> -       if (host->ops && host->ops->uhs2_pre_detect_init)
> +       if (host->ops->uhs2_pre_detect_init)
>                 host->ops->uhs2_pre_detect_init(host);
>
>         if (sdhci_uhs2_interface_detect(host)) {
> --
> 2.47.0
>

