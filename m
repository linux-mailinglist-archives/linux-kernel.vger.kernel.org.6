Return-Path: <linux-kernel+bounces-387119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3C9B4C31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD841C231C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024582076C1;
	Tue, 29 Oct 2024 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H653H6pn"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3472076AC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212499; cv=none; b=OJVh0P+RBn0Pfc1X9Wpd4mtJJJKxAOtvFvbjYSF6KeZpyJkwofl7JjyK+uH6YyZRK1bjg+Ncn4M+4mm3dE2BJNNkvnuEUP99LHZ3xYQME+po4iEVofJeQhNygpMD2ENodpKRWmsaeF8uFzTxDkW9YngoOha2sOO+PKKeYKXmFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212499; c=relaxed/simple;
	bh=YeRbvCOHpFl2Rls/HG77pjXIqr1UvfxcY5WdbtoW/8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc/HE2oacnzbIE9XqGWmqPMfM7KEzXVrvWVI9JMdb3ipsU5fYKsX/JWUvFkb0DvMd+6wrsBpsR/rF7cSSF8lzZTMBU4jfX6eQhXctAr5+FgnEbhJwljkwTaLNkFRjVTyBL07GDuQFuz4hz9jfh56q5GTRdXe55eBZXz4+56kAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H653H6pn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f72c913aso7205496e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730212495; x=1730817295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iJplz+InT+MvUMI0Dk/Kr6gDvRs81n3hngJD39fUITU=;
        b=H653H6pn3O3geMvPbkm92Mn4q/lWteR260kEcGbGvlGFH7G5jRyYTtf5xzFcxjs75S
         NHHVlT95NtOTfLBI4sj1DIiUtNkvYs1ViIGdy2Jw8s7FykjtFcNEN23bNaLLlR/Miyf/
         53e9JS8enZc4YNZRq6CVEoqQFCkbalSf08eLwaHD9npqcYqtC5gYyGPxZQ/FopIdHhiD
         I5O1fGmNCIKlZbBjDQrhxItAuMXc1mlr9S8+D6FgWsK/w5jobqZbJL/+qG0/HZNgpI/d
         J4y8ENeAxHHcaEGq2D67aY8h2PJVgEGo50tjfIoKR/thV45o7G3bQB7+gNa9h0qjPRir
         3Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730212495; x=1730817295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJplz+InT+MvUMI0Dk/Kr6gDvRs81n3hngJD39fUITU=;
        b=EXPuTLf3wPvmTgI+vtonsgg1ySMi7vfzpBT17BgW2McrWrQQHe6ttE0n/1lAF20MEb
         x/o2mzVrG2d2sSc1t+Brt33jt6oFR2tIyVLB1oSmvXO/sVFFRLqCu8aXatX5bmL2A2i9
         GF4/k0MSfrsYgU9rtEd8UaRQ/HFJ9YdKPZQ0RdXMcE8uvDIfl70vmHDINvHqRpUb2BKa
         OMZqRSyneT5wg4nkIh2f697QF8K7pIh1WUPA2brUMvU873g9r3529gSrmx9qs2j6w0lL
         IAhoKvHQ7u+H6PqJq/XN6PU55/HGh0bHOKEiOayePgauRl7jtBrF1gQhmtzVBvhTOsF9
         rUFg==
X-Forwarded-Encrypted: i=1; AJvYcCXw8jxcNm/fgdEzt/gkySSXdIaZKxoG3ysffkDlpxxOYPHyAaVhFUg+3ccef7GQByrPPiTjcB3a6QyBT4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHOcgLrlsic3VJgGR+yql3BAw8fgisukBgDncgFFJeWlvPmb3S
	1nZ6xw30e9wxqwy8oR/EeDrL7966goUBHteuu2p3iRGK5KWmIzokQ8UF9YlaRRc=
X-Google-Smtp-Source: AGHT+IEOewOEauMbqXmxjyKa4AXP/i4nzKrGrcQlOo+LSGab+OsUvtKOD9KDuD011sUIruFrVhDsYg==
X-Received: by 2002:a05:6512:3d06:b0:539:8df0:4d3f with SMTP id 2adb3069b0e04-53b34a18ff8mr6704884e87.40.1730212495467;
        Tue, 29 Oct 2024 07:34:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1eab9asm1415722e87.273.2024.10.29.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 07:34:54 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:34:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: loic.poulain@linaro.org, rfoss@kernel.org, andi.shyti@kernel.org, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2 -next] i2c: qcom-cci: Remove the unused variable
 cci_clk_rate
Message-ID: <xydlb2gwgkudbgg2q3i3g23lphrh4sj272z6lbthr4vhyaiju6@txxjgof7iz5m>
References: <20241029020931.42311-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029020931.42311-1-jiapeng.chong@linux.alibaba.com>

On Tue, Oct 29, 2024 at 10:09:31AM +0800, Jiapeng Chong wrote:
> Variable ret is not effectively used, so delete it.
> 
> drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Remove redundant code.
> 
>  drivers/i2c/busses/i2c-qcom-cci.c | 9 ---------
>  1 file changed, 9 deletions(-)

Fixes: 823dfb7bdb21 ("i2c: qcom-cci: Stop complaining about DT set clock rate")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

