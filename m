Return-Path: <linux-kernel+bounces-410547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF06A9CDD1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC78B21DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AF51B4F24;
	Fri, 15 Nov 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNCBS4pC"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95B1B6CFA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668321; cv=none; b=mJYJ/dEAfYOZ6nVMH1mpH5UVQLZMNaB+F6hlKz5sIkw+AJGv3AJfxJbYm30NhY8Foo218O1JRAqZwxkzLYFJiU49LlzoWvcI3GKSDR3nCMeRrZwLvtKUSgODQxhhuLGA0gpTrthwfR78Tp6aECWkRKJ73XlWpTYrf3gMwitmg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668321; c=relaxed/simple;
	bh=KeO9xmAr8xW7IJL8rOvn/GP3RENPi2I6iCoPv1qFA8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6bmo8YIN44F3Kuw1PiutSTWULlXLIUsp6BMv9ka6oZT2elGI00Qxnre4UEEF9PgluEKepur5vKJLM4urI6S9MnyJhlfdj+PGwiO1dgdXngfsse0nRZDl1JMpY0zmrNMaK7bhNz07Ky+ADvE+YIly+PXHPwKVtAR2k2PdVcIne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YNCBS4pC; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa20944ce8cso316969966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731668317; x=1732273117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4hZnzTlNhqS+EnW+1fU6zOMxAZ7jqUOVpxiFS42KLI=;
        b=YNCBS4pC4oEKAqRkGBq6hil7KrNHvNABvnRur7uOZdtbkSb7BtJRKVSqrTCVPl0vvV
         Eh9dBQCSBSN1/dGAUq0NagJ7ar/WxshqgZPkbIricOOIwS9LTlIuG5IDpuzFsEr+oOrs
         NhV4M3eBE8lOYeMSE8ioK8VZLt09GTXWmyw30oA4V1UeNnwD35nGCfaSi/jFJQw4r+Hg
         qFEfHC5QnedxSdmvwH7rcjimn5zc+FycNXAd+1n5FTTv5Ty6AVB01UJtwI6g5m72T7RW
         +cEvDDlFz3amp2CllPT8XDGZwoz2Pui+MfmQseyASrFIeSDPjsVDWFDJc5bOW4BOi4JV
         TpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731668317; x=1732273117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4hZnzTlNhqS+EnW+1fU6zOMxAZ7jqUOVpxiFS42KLI=;
        b=alirJIJleBLq5o+Maxf/KyAEv/UdSnxk23hyE48e48j1BgHkzP4Ono9ZfqKvi7Kky2
         Sn1zaa/RVgkYikbpLO+UFteY5zPAlZNNU2MqAItd2bxiGXawIEyvQ3cD9FkoRX0Kztrd
         oD1xSejxZlC2L0JuDLXkZ7FALl+inBqgpqbihp3Ovrhsd8O4ZxhIgt9Z9AQiWayxPVOp
         s9NURjoQJIhNAvb3pLpUzJo1UkX029rohA563yuulxwfYyTuQogHsn1XVJDuqEMmLWb+
         iNTYi1Tf6oXYEFGw+6BT7TecWZ8y4Prdrh+B+HJlpMR+LvF8GtcYo2F8y33tV2wPf8al
         ExtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxcCFX9vj+Ai55ghxYsSHfzOmMs/ybPIE5LU4CSLNLyjXUmWxHuPU8NvRch4+7a1GOW6FeWkiWIJHH6bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmfgZv3L18IIg7GXqSELJmIZujutGOlrwWNTrM1rOCLaKykGYO
	FxjI6fJLc77OvT1TDtXwJPe2TU+ZAEtwBdy5mqBKy6DL35YCsBWr6fQDgPNtjba9w2unib9KzNM
	ecwt9nUXKeW12NMEF7bE6fqZv8EKuH1N0fvrfiw==
X-Google-Smtp-Source: AGHT+IGSVYiUhsWj6zeltJjcNWqHnW6GPQb1Itj/wJyDtSuZKguUH81kjOYfKW/cySwbACmp91nXvMM6OFlu/bFyHhI=
X-Received: by 2002:a17:907:2d29:b0:a9a:8042:cb9b with SMTP id
 a640c23a62f3a-aa481a08499mr187630866b.20.1731668317082; Fri, 15 Nov 2024
 02:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104060722.10642-1-quic_sartgarg@quicinc.com>
In-Reply-To: <20241104060722.10642-1-quic_sartgarg@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 15 Nov 2024 11:58:00 +0100
Message-ID: <CAPDyKFrYkKFJ=+4t4ad=a4GJUCBVO7FuaRqdxSTUWtHOWgUA_w@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 07:07, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>
> Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> This enables runtime PM for eMMC/SD card.
>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>

In general I think using MMC_CAP_AGGRESSIVE_PM needs to be carefully
selected. I am not saying it's a bad idea to use it, but the commit
message above kind of indicates that this has only been enabled to
make sure we avoid wasting energy at any cost. Maybe I am wrong?

Today the default autosuspend timeout is set to 3000 ms, which means
that beyond this idle-period the card internally will no longer be
able to manage "garbage collect". For a poorly behaving SD card, for
example, that could hurt future read/writes. Or maybe that isn't such
a big problem after all?

Also note that userspace via sysfs is able to change the autosuspend
timeout and even disable runtime PM for the card, if that is needed.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..6657f7db1b8e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2626,6 +2626,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>                 goto clk_disable;
>         }
>
> +       msm_host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
>         msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>
>         /* Set the timeout value to max possible */
> --
> 2.17.1
>

