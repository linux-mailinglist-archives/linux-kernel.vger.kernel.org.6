Return-Path: <linux-kernel+bounces-403574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CF9C3771
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5E0281744
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F54595B;
	Mon, 11 Nov 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDObEpn1"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E285260
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298546; cv=none; b=t0d0NbDr1wYgjla88nrSYyEB2RUgA6Z23GtiJTRux/oaC/cY/BLNqBIvKBIo/CutJ1EwPpQr+vyULTvLNWT82Kcw+/F7Xba3jVGYfpR3NOkuToXqlj545vJXgCoYUy5rSKN7xicL1PprOMMEbWHIFfdrU59zPx3ob1PwXE0VWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298546; c=relaxed/simple;
	bh=fle9jir2XkQTPkMIv93KMYsqrh4kDkUf/SHSJR5R1Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRofgCHCTNmnoVYsFpYi4KUOO7Q90yoFWSQnKy3pDv4Ug8wrDM52P07VXdRcK+j4SorxtGefXpfk+doX/eI8J+wnBP4XFRlXXg3JHgdO8Ck9GL6YPTtq0FvKhVxepmpSFcrdDtqbbOBq7wVOuC+7dv3hTxYbuGiMqvrQyVOYa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rDObEpn1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c7edf2872so40789865ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731298544; x=1731903344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knhfiz6v1X/Y5Phw5qTTBL8KQ/Mw5RIdq1X0vCWMUt0=;
        b=rDObEpn1doCrwYhHHvVPh7h2PsZ6zj7LQtC/G6vOMVUlfRWIBt+lIGlYeg7a2yTwIq
         0roUjwZ27fDcH+hDGpLfMsgQC8gmUPQ1JZkEljwzCnkhM+6o5wIkvUWb/CN9sUEaPd/U
         Cc97JuCkjS9GGuItyjYwg/cLx5k1EowGLGj8SrMzEu/RvupYzPCOJI+OESyeuRN4qFwQ
         Fdg9tbAFM0aiTfIPjPoxvZnEMBUw2kkj+LTqpABohaZTg2WsXqyNt1QWgj9ACepHvqFL
         fOZUscFTkQIOQPl5ToVl/OCwpfLCqxCS2X0MI3VV1Wcm0at+lcTGPM5ZEeNLYvuebla0
         H0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298544; x=1731903344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knhfiz6v1X/Y5Phw5qTTBL8KQ/Mw5RIdq1X0vCWMUt0=;
        b=CNSvrWAkQuN9r6ws4pSmxVT0htJ+ZrsA2n+JVZclxrspSgDduvqN16fbRv8+I3he2A
         s5GaKv4BXV0tQqWp1q28dw9LcR6hODWNMBhqMo34WEHM7NrttvF9bB0K1m12+gSPV2/i
         k4pL0cUKaTCQ0EOTHmKjxyB0qtO7H3FIKG214c4q38a8jmeWoZ/05y+nu62Yy92wHa48
         uS8JtMnzDfPQ0+45z5zXiQ1knb51kwjfiqdxiUWB6RmGlm33NyhiClOJKq0oJRzvJXym
         aiGFFo4bovI3hLg8ouP79qezEgyJ8QQ7aeT2g7U1GQWm/tslfEEzdaau1u5NhsJ4hrti
         I57g==
X-Forwarded-Encrypted: i=1; AJvYcCXg9n+RSLnOWrq3gHLsX110GyD3dzMQfWufqBi7J2QkjVysH+H07RUoH0MkQ3tzC5cPCLcqmmqwOkla0k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTq++ihr7WqwQe9sZsS7LGBgHbq+sUVw65zoklK2nN4kZB6r8Z
	1p4yLzLEVK9rHr7MpkDQlMSHU34dqYl2SXGN7MRuIplRV+OPPzFTY09II9N99ic=
X-Google-Smtp-Source: AGHT+IHxCb9wscTjmGmnrU/ke01iamppePTNlMCSebsPTr/XCYGY/bNBzPupEwPaf2R5gdgxQNJBBw==
X-Received: by 2002:a17:902:d486:b0:211:74be:c09b with SMTP id d9443c01a7336-211821ae0e7mr198879005ad.12.1731298544156;
        Sun, 10 Nov 2024 20:15:44 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1a9fsm7577101a91.37.2024.11.10.20.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:15:42 -0800 (PST)
Date: Mon, 11 Nov 2024 09:45:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rafael@kernel.org, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, hector.yuan@mediatek.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 RESEND] cpufreq: mediatek-hw: Fix wrong return value
 in mtk_cpufreq_get_cpu_power()
Message-ID: <20241111041540.7pfksjopw7qfupsx@vireshk-i7>
References: <20241107113841.989475-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107113841.989475-1-ruanjinjie@huawei.com>

On 07-11-24, 19:38, Jinjie Ruan wrote:
> mtk_cpufreq_get_cpu_power() return 0 if the policy is NULL. Then in
> em_create_perf_table(), the later zero check for power is not invalid
> as power is uninitialized. As Lukasz suggested, it must return -EINVAL when
> the 'policy' is not found. So return -EINVAL to fix it.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2 -> v2 RESEND:
> - Update the commit subject and Cc Viresh.
> - Add Reviewed-by.
> v2:
> - Fix the driver instead of em_create_perf_table() as suggested.
> - Update the commit message.
> - Add Suggested-by.
> ---
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

