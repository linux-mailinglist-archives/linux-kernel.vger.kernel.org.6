Return-Path: <linux-kernel+bounces-339462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7149986575
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B70C28C89D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8694AEF2;
	Wed, 25 Sep 2024 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6ffPMa5"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C97C481CE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284435; cv=none; b=DRekTggT2CYO7fIxCYpCDIohgJwb8aKtjdYlFi5f2eWVEFAvacK5vvr7m1HdKjhN7NNtbHRJAZr5wSfC5qSW1Bwf8NKGnXTcRWojactKRzzjmZgnfu5NkItBLXU+5e8nnEHO5O9MUQFTa6SuzROR9DrK/5pB7oxjFXJBQJWgZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284435; c=relaxed/simple;
	bh=eazsW8ehOZywqFey+Jsuiry/JLzV8qZShMLGcAgepXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ee4XfLdGn8Vq7lvv/3IkRxh94HQKhdTW0cn1R7opUimzBdSlzmlgXwtwO3RzvUBveJsVg8GiWiiYOBoWroR5uCEm4PRCqL9mROWlz1W0sXYMLZRMWQ9pHfdLCLN4ISPClvTRQ6Jb2WudiTLQ1Ir9sAlAHs+20DaZtEYBav7FBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b6ffPMa5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so129156e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727284432; x=1727889232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TUTSdeI7+JosOudQjHg+52ZpkXUi7IWq0P1aLMu3v2c=;
        b=b6ffPMa5bBvUz/7rajcSB+pSY4PRmjl4cCjyIJYSPSJDp5bSgD4ju22T6hl+1AlQzl
         FlaIvSyHcBVcXNM+g/9dqjPljliY1QgUevvoDIHhlC2GM21cG9P2UHaf8djsHkA/m/Go
         RoMxQJ+KXELaQbhS9rsxbTg7PDLFWia7LB1nLViFFGm+yQPgnAVFMK5KZ3OgcBui5YRg
         81TvOO3zHXGdJiTTdDKBpxX2hUHYKTHWpGrI6Y3suJv5Ng5kPN+MBHWzEmMd5ywei6Iz
         ETkwb3nTxS9pUrzojrdL4YLhXxMDg+yICoNOndMxgex9GQ3bqzu9/HJVMiRCKiC/QZMw
         QE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727284432; x=1727889232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUTSdeI7+JosOudQjHg+52ZpkXUi7IWq0P1aLMu3v2c=;
        b=pCx3CJP/hRgiNW+wR2bzLxqj0tUitRqwXEnBd5MWY/alqde/HeND8v2GN4N8jTNnJ7
         yr5iqQ/IJc7m37eexML+wCAh7T5FSxmc1s5+QAcaLBZFVsbc56GA80WFY7R6jrH5TmNc
         1nL/Pl84iCW2swtNP8ViylAJGJSOyNt7lYXfqM9JzK5nsf3LdfueJA8x/g4sYZ4nzo5y
         jnEjBpQzLUNT8v7egflhirc3fnFD6JF/kdQC9TrAkIq814JtmlYBK/NOuMjrLDClXFEB
         ViQzV/x3/ggXidxlgDtCD46sPrYbRDuzO9ZefoSpzpTbMjiCtXArcpL3PlWer1YtCqfV
         YxOA==
X-Forwarded-Encrypted: i=1; AJvYcCVVjHCrgEIYlb2SiUTaNbXC5X/H4rwA2kP+ZUOZIkZXNkchfK9z3CN9QG5i2E34ty6gHsy5HXBvgNida9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrIlf+IhxUPGw/JOjfdqYeH5IMBslhZSwxPhICnRzbXSoCLi+
	G7PW0NfTavMfEBexS/yYAs7KvVXrY/XM3jcRu01jPA8Xn0U6Cw6lmwRvXOGsxro=
X-Google-Smtp-Source: AGHT+IG4PmHd1hXlytSjkxKrpDsCf4VZ4fji4PJZeek10wMk+0D4DzSIPt8vFZ9pGPQcAUiQ69L38Q==
X-Received: by 2002:a05:6512:b1f:b0:536:7d6b:e2a9 with SMTP id 2adb3069b0e04-5387755e0c6mr2373160e87.47.1727284432097;
        Wed, 25 Sep 2024 10:13:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e1284sm578112e87.43.2024.09.25.10.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:13:51 -0700 (PDT)
Date: Wed, 25 Sep 2024 20:13:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] platform/chrome: cros_ec_typec: Thunderbolt support
Message-ID: <gqceveqpbvmiv3mg5cs3k3qd4rr6fpb3xksvxvdhkugr52paoj@olks6bqjc436>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>

On Wed, Sep 25, 2024 at 09:25:08AM GMT, Abhishek Pandit-Subedi wrote:
> Add support for entering and exiting Thunderbolt alt-mode using AP
> driven alt-mode.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
>  drivers/platform/chrome/Makefile              |   1 +
>  drivers/platform/chrome/cros_ec_typec.c       |  29 +--
>  drivers/platform/chrome/cros_typec_altmode.h  |  14 ++
>  .../platform/chrome/cros_typec_thunderbolt.c  | 184 ++++++++++++++++++
>  4 files changed, 216 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_typec_thunderbolt.c

This patch looks like nearly exact 1:1 copy of the previous one. Please
merge both altmode implementations in the same way as tcpm.c does.

-- 
With best wishes
Dmitry

