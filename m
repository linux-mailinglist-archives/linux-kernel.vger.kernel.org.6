Return-Path: <linux-kernel+bounces-225363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89409912FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEDB28445E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B9817C22C;
	Fri, 21 Jun 2024 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZyYh6ta"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C764208C4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719005817; cv=none; b=pjJf/NEQLeLAgE8uJiyYoT/YGyshQlLDY3fttNryD7kmm+L6sGKKP4rRprT+lDdjLHMfcfqo+5E7jEJ7JwBjpn/AbPwwyfTe36YtY6UhGcp+FtwpqfHZ6LXqMw4Cgm7rGSxQD7t6cUpe3OOvZSLTZevgWNzPZssysIlU8nIi5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719005817; c=relaxed/simple;
	bh=FeufF1HL1YMMhls9A8Xl9V863ctUX7it0zlhLxIZtug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6OTngaXEy2OdgizubS93z3eo98k40cFvG9JceKbe25nSJb401xgYw9JzvOkENwk8OTtWoGdNx1m7JpuRdlyXn2Z5/Apa0uyc4dBsCbG0WSDypMEahmMLgcXmMfA8zoR4ottAdCWu9LgAT1EsMzVUdrrguJmPyx39avGP0416E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BZyYh6ta; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso2775132e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719005813; x=1719610613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2Y8caPFpofJDofQGbr7JoAGEcpyWwcb6MECsZ68wNg=;
        b=BZyYh6taSPk2KnartZZJd94j5eWDoBr+NsvLZKwtORyvjWKQxfrS2vK0keWk8cJfWB
         8qnNhQjkzJJvND5tyjDIBQa9ZO6CGqPuM1AxFMgfNdz2olgHn5dcJH2wV5isw/quwCmV
         83sugvBz9FPM5XCU1TJGffeP7ncZ6ZMYuRF35T05HNqhvSJ7l9OR6p2KZNcoOGXVN+Fl
         qUMozrd1yFinKy0Wh1RzUF9LS0aa1AkytDdRm4yRzYn+JGWBY1rieecAjkLB5r5VLCsl
         oT3j/AfycA/3VP6tgF/lC5X45yZNwkA4pTJryIup391q3IhnWXXjH+FTk3PGMCMHZzjb
         aciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719005813; x=1719610613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2Y8caPFpofJDofQGbr7JoAGEcpyWwcb6MECsZ68wNg=;
        b=rCy+xaLrFHr5vhw4GFEUpkQaA/OEiieNgBLm0o77gR/pQxFPV+LX+RJLdWpAV+0frb
         sGrIrylhoqc244oL3n8JMNjiG1ibpTJz6zknwCuJ4zE+O/2afiRHGnaSu1yIOJpNC06I
         6gfUcFYVEIsyHQIjA+taPLXyzypOFgXNf/g9a0M5ahArB0dsJuvw92UUMyfkVqxBUIpl
         Jlf7Uy5lo9kyMtXsciOA6KirshIaGYd+p9CgcxvJji0bcwAspZDsOR6j1xwgxAzAXfN2
         cGVgYk7hKqzGsQMjFyeXDsgaCC36KbuRBIDPnjoet/HqCtrtw3zP5X46YveA4dSrJxJk
         fIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV52PEAcBzL9CA3VHZzi1WLL3E7dCh2QnOmZnV6+9xlMihRBNyscQ55ap8pRcsT1x786aAsXPn5UuwZ03btwNFtqEK4iKbMA8otClI
X-Gm-Message-State: AOJu0Yy/aq/z6vDDRzCPqveEyJJT+mvPXOTAVVV2OVC9IBYskqX24m0k
	jxC40Y9T63/UX8GVWtjCsKjUGd455HOWe0LM5DweCCVHD5WgalRKOOJUphmms90=
X-Google-Smtp-Source: AGHT+IFo0PIuqeQLXvvqEsCuZHNHKkUNuHQ+gVusdDOkthVneOlM1r3F5tAJeZ5I9d5T8YROe42Mrg==
X-Received: by 2002:a05:6512:3988:b0:52b:88c3:b2bc with SMTP id 2adb3069b0e04-52ccaa92717mr7436609e87.48.1719005812830;
        Fri, 21 Jun 2024 14:36:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdd3fe6bcsm52852e87.207.2024.06.21.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 14:36:52 -0700 (PDT)
Date: Sat, 22 Jun 2024 00:36:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Taniya Das <quic_tdas@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] clk: qcom: dispcc-sm8650: add missing
 CLK_SET_RATE_PARENT flag
Message-ID: <bjqqmuvldwg2jsragaqallc2ea7omwfi4q3qhumvh2pdyn2j4i@yqwnj7gj7exv>
References: <20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org>
 <20240621-topic-sm8650-upstream-fix-dispcc-v1-4-7b297dd9fcc1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-topic-sm8650-upstream-fix-dispcc-v1-4-7b297dd9fcc1@linaro.org>

On Fri, Jun 21, 2024 at 04:01:17PM GMT, Neil Armstrong wrote:
> Add the missing CLK_SET_RATE_PARENT for the byte0_div_clk_src
> and byte1_div_clk_src, the clock rate should propagate to
> the corresponding _clk_src.
> 
> Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/qcom/dispcc-sm8650.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

