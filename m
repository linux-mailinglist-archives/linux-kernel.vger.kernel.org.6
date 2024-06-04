Return-Path: <linux-kernel+bounces-200175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD2F8FAC5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBE51F2134E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BF21411F7;
	Tue,  4 Jun 2024 07:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/AQN3J0"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB331411C3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487094; cv=none; b=F2rLVBzngNrtvd1U5z5FTWD/9MlhahJQjKP7+bpAB9wmnI27BevXzjLyVFMTDwqkMx5IZT9krojFfp3pQJPaD/wWlHnl6woC3Paq7dX4kWX1DrB8BgypxKe7eOPd6Kg8nD4y92S+hv1BUnWcDiOYri/eEzmpZPdsZ6LV/gjENUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487094; c=relaxed/simple;
	bh=K3JztJJNDmxWgE8NZyb5e/BN4rv4y/pr6l7o7i2SxDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIY6Da2MK/OGnYjJOdKKufUARC9UyxgGxvbj5nT+F4QqgICjGAZ7RDX8vhpbMumR52Iy+Kmlrj5oaKj5aZDlNCkdP3XeUVS3hYrXhhbHeKvVG329gWvB7n+8b8fj17t/sn2QOgf+l4v3/CAYvzwoNiMcO2ZIFeaoc56qKiAWZMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/AQN3J0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e73359b900so7154221fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717487090; x=1718091890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcYWYntWAO2W3LAxMAaPVJr5Ylhpz9Mj9naAFGZsCvE=;
        b=q/AQN3J0lmuofO9t1KTBuJoY1vEKpZE7l6GNwd723NtJYXiYKedPfNx4wmd7W22vfl
         ++2GCQviMLJeO/o73zfTQkvhZsZYDUFuhDCxbmzVaCIfFg5LJJxLvQzwvKl3sQqYvB9m
         nD0m9IsQkxkY5s2Xlg/YDt4m2g5FgRh+BS9gjVl3jyDu1Ubxv/ADnJ7TC3YJxRiTCVvQ
         OZ4XMrDYVZL320PQJrZ2N59PRFbxQcvEi2qFH2dJb3dvcim5+oi5vTLUS5Qp/FztIhbV
         CYqHRBB88MZ+tuXCh9/LyoRiaY5EXvVkd5nA3y/ugrvwtt2y1R0MVutC4pQtbtI+jHG+
         Ug/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717487090; x=1718091890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcYWYntWAO2W3LAxMAaPVJr5Ylhpz9Mj9naAFGZsCvE=;
        b=tp62Jxy/bMb70cdobWAEAw60JywoZ/mATaNugDbBOwn86l9L9xuk5ETO9kqQHwSibK
         GZnM+NRazards1hEaKEG+aht1v7omwf46UTvdNwd5yjXKrK/apdBLdzE05oCoyDgve5F
         75kBJfGeyxQzzsOdwiiswAY/Rn6lrg8NwOdwjC5UK6JW9kFWuFkLoqhMYrwCq7p48FMN
         3sPBO1+8yiaDT5JirB/NyTAi/oeVvaKNqbyFNeuGVqsH6APsKjBWtzjn8qxd9/yKy4v5
         C4pcRTKG074M3qmT/IOsen9uTAPz6tIwiLQ4FhNRMRcL8bNvbjxDzBIss9TvT7w/DVwk
         WH4g==
X-Forwarded-Encrypted: i=1; AJvYcCUdpeY1b8sugrmhojuPApdX6CyD4pY389MMZCmOBM1tdAOUrtRKz6V4fHladoieGnowQk4QoZvKEFVZMM6ufYa0/OCdams5zNJqiD/j
X-Gm-Message-State: AOJu0Yy3XTgTBudziX32OTEDKOhjKRtGq3WA+Mmz0pbu7XyO8DUQXxez
	FaDAjOKV22pPWlRGNBnTvB/Uuzj/QV4NYZ5qndUvn6wJVnWsST8ukE5IyElSnA4=
X-Google-Smtp-Source: AGHT+IHqZb9LYTpAH7wKglm6YhvwHz6YjOAKROkXHiyd6z8lsMM1DOFC6a++Wkm2gmrWAq+7DRwBww==
X-Received: by 2002:a2e:9d12:0:b0:2ea:7cca:31aa with SMTP id 38308e7fff4ca-2ea950e64ebmr74116151fa.16.1717487089638;
        Tue, 04 Jun 2024 00:44:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91b9d5f0sm14300931fa.21.2024.06.04.00.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 00:44:49 -0700 (PDT)
Date: Tue, 4 Jun 2024 10:44:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH] soc: qcom: spm: add missing MODULE_DESCRIPTION()
Message-ID: <wuozxhrtce5udbn5aqxb65e5ox6hqs7tncb6biutqoetlhtouj@rew5b25dc2tg>
References: <20240603-md-soc-qcom-spm-v1-1-617730f08d22@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-md-soc-qcom-spm-v1-1-617730f08d22@quicinc.com>

On Mon, Jun 03, 2024 at 05:09:34PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 warns:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/soc/qcom/spm.o
> 
> Add the missing MODULE_DESCRIPTION(), using the same description as
> the underlying QCOM_SPM Kconfig item.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/soc/qcom/spm.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

