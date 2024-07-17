Return-Path: <linux-kernel+bounces-255118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D78933C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10911F2433B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3F217F399;
	Wed, 17 Jul 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptGh7WWU"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917121CA9F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215869; cv=none; b=QC8NKde+P7ZnJJAc7iwRj2Pu93Qc/rQj6DHdAK+8PvXYBR7lMSaNNDYPIDw0RQwcAvQjAyYuqVXvjLAfE6kt2oLNLbGk2pp7vRcQnkQt+cE+RJekI7YUdc2BAOR1HV3dZEMuoNPUuzrrwHVaTsCnWbT7MQtjdF+bJfOLt+L8RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215869; c=relaxed/simple;
	bh=j/YRQeImIPhUV+MS4tTrxYdWgyGt1EoYQBbNU/W/Bbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSAbh5JeVplQfhh8sJC2+iTfgiOrjB/3FIHZ0kXHexRvYGqkmVZ2+iR1efBs5zTtmdNh0nwl61Bf5YZoPcFQhhmYeRoHfSY2OPyLWYN5/7xj5HPXD1Ex7QdgpR57n4gIy01Mzo5K8xil154+wGAmYZ0HSIyFMvQaEDtZ7YY0T0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptGh7WWU; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64f4fd64773so74840467b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721215866; x=1721820666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TjcbV6PRhjkqouO1Kr6u0vYUOeQPkLeQL8bm2L2+2n4=;
        b=ptGh7WWUHmj90IJx0LwL0g0OhsggtUc8UvVjRW5ijcn7cjlDMdzYB0mzYMv3hWABAQ
         XbKDgWBUFnBNU0JslpieEwuuMi61YADgV570z/uC11nOtb2/l/eYXrNA/Op0drjbjQQd
         +49fdyJLUyRSnDdyE1RCXooSLKeitEFT+2dLHOcekvjoFEczv4S8Avk6ldGdJZh6XlTn
         DK/HzueefrQ09gUVNqH+XlyxLsf+fZQnXmAP6HV7Ibz9w6yYe63KiJFdyFPJcIlTC26C
         PDGc5aVxNKzyZVedxIpaeb53U4MY2FRRXcJEP6C0ZjLmEwxAx/SYphKO9DIYYGLlkG0R
         rW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721215866; x=1721820666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjcbV6PRhjkqouO1Kr6u0vYUOeQPkLeQL8bm2L2+2n4=;
        b=YUAohCQfWPhurzWPm8j2p59DE928hhTGS77TZVKqmhESLdZwBpbO43HNbGmC/qO2a2
         WDnutiQadGSBW4jbIbOuQtulKdi8k119Q2Bj4XRlLEyznbVAFuLo1OFEb5+BV//MpdvU
         LiyjESxDmdSbfqCofywcq+FLF8aLYo73lp7WIG2DGr7fR3lAvJXmHIQxSl64zBJxyBcT
         C4oXT2jb7KXBVJPZsG6zgoi2CuZ9qlT3Tz9ivy3se/SRhJ5MD60MY71us7KcS8X6B5G5
         1c40k3xVB9hnf/COOZwZmJy758CwqYiqBi1LuqaMQQw2ozfnvQOgckQv1Fuu0usB35Ko
         XxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFizZ36qqfig3VehXt/FvKUuvZqzT7k9HaAexLtIV1zBvU7G8pJj+3IeYjV3wO73vn1yn+oxI5Vnfutqw4kFIKmcK4HJsmuq6rYoz9
X-Gm-Message-State: AOJu0YzKWVyYZTpy/DRk0pctrIbvNz2IFiP8p0/RSWQcEoO8sHooE7/b
	EGCti63c8DbPhAZzyCRkwNlnaKjtHcCD5yotcs3ofInFRvBGZL0lzNgMRJojVKqKC0faY3uid50
	v4eFE1HNOzI5IXKvgUCMrbHFycdp036fDuYyJHA==
X-Google-Smtp-Source: AGHT+IFe86geQlpQGKP7hmjpN4o42Eh67HJePPfk+Jd7pBA+Bpmq3c1TNuJm+qDK3OrLAQbeECL1dlE6i/C5QetSnf8=
X-Received: by 2002:a05:6902:154b:b0:e03:a939:22be with SMTP id
 3f1490d57ef6-e05ed69b9e3mr1672804276.10.1721215866554; Wed, 17 Jul 2024
 04:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717072706.1821584-1-nichen@iscas.ac.cn>
In-Reply-To: <20240717072706.1821584-1-nichen@iscas.ac.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Jul 2024 13:30:29 +0200
Message-ID: <CAPDyKFrcGYocPKy-WB3EdB+Jx0=BztzXz1r=5y3JNTeXF84-7g@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: pl330: Handle the return value of pl330_resume
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 09:29, Chen Ni <nichen@iscas.ac.cn> wrote:
>
> As pm_runtime_force_resume() can return error numbers, it should be
> better to check the return value and deal with the exception.
>
> Fixes: a39cddc9e377 ("dmaengine: pl330: Drop boilerplate code for suspend/resume")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/dma/pl330.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index 60c4de8dac1d..624ab4eee156 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2993,9 +2993,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       pm_runtime_force_resume(dev);
> -
> -       return ret;
> +       return pm_runtime_force_resume(dev);
>  }
>
>  static const struct dev_pm_ops pl330_pm = {
> --
> 2.25.1
>
>

