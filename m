Return-Path: <linux-kernel+bounces-515198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8778A36196
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DDF188E6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C64D8C8;
	Fri, 14 Feb 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbutWQuz"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1415749C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546698; cv=none; b=tI4kC6kLs53XtAnDXTPHiXps5blAIR8gbl7ZbomnNYmSQjDW0C5jRGVnrDsjqcWyvsZPwkMlddLvuMyYEUgNsOhJT4hiahxYwlIrBSfRNG7KY0H1jaN7s5D82i7jiLAmRcn+LALXecA4i1XAJKC2pgtejFowVutyy2U4G4lWju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546698; c=relaxed/simple;
	bh=3AIXK8A4HfhLUSnVmGUk0Vjs1zG9SV3ymB/OECkXC1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVpxz8cR4vRlPNqC0JUe+VuF1p8tSkihL+LDcIm4khHSSHosxCPjtfkgg85iEHYbzuJYV8p37m3pM7V8pqQc8XTg0mvE+5lbUpU8UUTdBm6eNhmXeSCKEaPxs+pWNSancZVacNuRH09Z6yNuohRkU8cYgiIdNIdGUPlnCuhAe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MbutWQuz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5450475df04so2183127e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546695; x=1740151495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43NqkkXmKkwdOYGO6ycij0gMr1OHesReBZTFUoOKNec=;
        b=MbutWQuzrJaKYsaY8jdGhahj0L0woF0al77qb4KvNyecG8WR594uofdo+Yd1YoQYuj
         J92CKYvQcYO8IFsz5M8fnB6hYc/ZGrYf+nFFpwT4y1G/UzVFqXPYVFIL9tLp1HaYHZih
         Ttyl8AThTwHbJf1EfmBYq8tD6uxGs7NEMvaGBW21M87RnaFTmbOuUqMFZlUe1ASwn7+l
         r4IyswdS63sva21gMvPeojc6hKD4OB7yYe5V5nuouK8f1DGzuEY9VrDbWND17eRWaxkG
         TXCaElkY+9ySCwCLzMtUixPSuScvwsj9bgHfmuVrJ0NexGrqakC1HPtAPpyLyLI8o9kp
         baew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546695; x=1740151495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43NqkkXmKkwdOYGO6ycij0gMr1OHesReBZTFUoOKNec=;
        b=QY2FNnxo0oiFL75zAjsKvKSIc3qcgFTgF8nCGgqDKgHua5TEiIrdKR9KbjXOLQXRw8
         mFv7r6icL+pr/AFt9NbYFlLSu6iR65qCoJ5Fo8eJk4WTbk+9rdR+dMU9TeDWgLl184x4
         jH0hHKTA9EpW7+H+AJimhTXc1yEmAmh1DWY00I2aQ4F/1R3DRfrtPKVdNPgycnzUekfx
         Uz7uIYgUfDz1zN/gQjItzNkmAhy3VQWTc3bFE6aHL4dPyDeZZBjxQlgm2fsFx1fIo6fT
         kSWL4jWgZiXZ2cq7KH3ZP9SXQZLrIQIhEYAYNfqSMoqX/o1uZlTeYl8e89igmAg08l0A
         YCqA==
X-Forwarded-Encrypted: i=1; AJvYcCUEvh0g75AIp2oF7lPB0XPhgG4vkeUM6Q3sGu0WeF2hm2kZhVrBom4nZRnjIx6Z+Jaw9UW+KQweucS1EVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9qiqPv+F7FcE6LyCDCnlk2hHc1+QwwHPQKtpzQdXrT1HNaTu
	JGYmuTPX3dOyKhgyRlGQ7vjKXXiFnuDjZV4bj4sjZfSgfDC/TWGo38lJUmywkg8=
X-Gm-Gg: ASbGnctjqvOk2HfnSHQRU052zz46twHpA5jju6/yGBBk3GzfO68QMRGg8lCpWNrsRw5
	/YVEemQpg2ljJ1Sey+Oqa/L2qTMYjJ3nhQPfrHZrY1cu5KCkwphG6tpsbINKJW8dRULmFLEtO6S
	j8Y4T5nmZHsUkp6ovpKCVaOYS0CuCXDds6u1aZ8cxWSi7D5bOjHuAFU9ufgMq62pX8lc+IiuPiu
	kVKnFQdNtKMKuQ1CjA7rIVJ8I8dut7CYYyyTwWSZj8SnRA4Un2SXx/sMNxkKI2wuGMQeWR3Vgnl
	JXWdwYNcCpa3lGHzC3QKkuPbd6NVjeaWHTQvCuWwzzalRfoOkLy1Pyy8gm8PbIZ/ZQv/VUo=
X-Google-Smtp-Source: AGHT+IFMMRc1GwytzG6k6ATLntN6Q3zbP4uW7Ri3VRuH1h0hGLW4B1KSA+4aA5975RklLNi1meEo1w==
X-Received: by 2002:a05:6512:3a84:b0:545:2837:17d0 with SMTP id 2adb3069b0e04-54528371a46mr1151389e87.12.1739546694728;
        Fri, 14 Feb 2025 07:24:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f083528sm556057e87.23.2025.02.14.07.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 07:24:54 -0800 (PST)
Date: Fri, 14 Feb 2025 17:24:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/msm/dsi: Minor whitespace and style cleanup
Message-ID: <7ppfvbbfvlfk4jtqw7acxqjm7flcfpx57ijyqcgc2x4qe6tlhr@jdldkmghceay>
References: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
 <20250214-drm-msm-cleanups-v2-3-1bec50f37dc1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-drm-msm-cleanups-v2-3-1bec50f37dc1@linaro.org>

On Fri, Feb 14, 2025 at 02:17:46PM +0100, Krzysztof Kozlowski wrote:
> Cleanup few obvious kernel coding style violations: missing or
> unnecessary braces in 'if-else', unnecessary break lines, incorrect
> breaking of long function declarations, unnecessary 'else' after a
> 'return'.  No functional impact expected.
> 
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 51 +++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

