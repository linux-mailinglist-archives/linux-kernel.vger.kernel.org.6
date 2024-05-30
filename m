Return-Path: <linux-kernel+bounces-196051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBA8D5681
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A595A1C2287B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A886183A6A;
	Thu, 30 May 2024 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+YwX7Jw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A855896
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113035; cv=none; b=T24UTaQX5HwuKQY6jIkguI3eIX+6O2W/jZswlm6GtAzqwvs6CpFFy2uXBNHLUuaSHsnpcVFE8K1JKqXqWeRl4YLq7Lupr5Sw1SlgXXnjL5eS5WRUIENrzns1FybqqFbyJHfaeI/DB+nptJceZ2oVNgjZ9x3u48dYffIvqpJroq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113035; c=relaxed/simple;
	bh=D15m+MyXTHrsVXJPkTMbFZ1Yyx/Tcx3EMn8BItHzm9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNcH9AVlUCsI3CgNuxwC0Eo9LH52hq7uZLlRxsfNpnSW49foBWxTWwQRs6JFDaxLZmVlBCZj002lzocLv/0C6TtrVn4zycOU92xttnqOD2YZFSwG6vDIxy8yfQaqoo+GRrn9A8c6Bt7IaGi+0uOwXBlnQjLxED3Rvu6tKATVpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n+YwX7Jw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b80e5688aso1620628e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717113031; x=1717717831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTw3xrgpK+XczV4V02obwDdH8Sb5LloBfx/h6NiR1nU=;
        b=n+YwX7JwlvMyOt+tAndUEB/jN5wf4ZvRdmTLAYE46TsQPDtJZckInlKqlGXSVs2nYd
         jfoYt9Zxl2EX5zAyD+h/6zjYZaFykiJtvwYnytPTjfT6SMmZCXldyszep2wWmuw/EvMW
         294sy9c/gh4v9fV4uxHRofut/RytV1oN4S/a5DbBbYCU+6xO/+8n3ACNzSwb0vMZlddI
         F7WtGiWGPWJ9QHdjtfTuwHPR4soY1YwKN2/fu3HBLWrpcVNhuQLANUspE1FqtWqJPRnk
         uEEb1nlzNRLep2R8pA8vGx1A5HlXPnZUl7lMbpTS9JZmtNEuv5tKpO7JOvURU6MIKtS9
         zvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717113031; x=1717717831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTw3xrgpK+XczV4V02obwDdH8Sb5LloBfx/h6NiR1nU=;
        b=k3Ay+IKwIW7auyh1p8OemawmUqjQgGnRwTHJM8DP6p92KY2V1eKeWkVfrXxWWbz+k6
         TbM4PuV3HkZxbTge5L96umWGvX0TVITgSd+He5mygXd+R0ubR82Q8JjcN8VjeQbK1B+s
         rOjdY3/UiUo6fsI9qkjnSdy4oDs/pzk5sx1zJyWuEuP8Rj0FJlftcdyl0OjeS7kTHb2/
         WFAblfv0+O12mHOZ+qeMbToHTbw7DqqTHfE+Mo7XTu7R1eBMMGpK/RCL8FURawuoHZEH
         sLvJKiZNdUYJwM+BtJN5zQGUjXrSetkjspcmFloQfklzzI1VZUDxifGyQa03qDX3414k
         QW1A==
X-Forwarded-Encrypted: i=1; AJvYcCVR3ZJkMKqtgEHffBX1ywRhlrmBnGZWMWPo2xkrFY8Y4SZOnGDRLSVyOzU0F7Zgvl9xJd2t+CJfA6BF/CdgEmYqo0dRP5hS/lUEHw7w
X-Gm-Message-State: AOJu0YzV6g3jZ7KxSxkScnkc4dPvNLl8rAFgZrr00Gq2z+p8w01/JZkF
	QAOO91LnHtZksk5e1POzUB5BGdT+4vW7ldgD63kBnFUQY5SvS9FCs3u8N0DGxdQ=
X-Google-Smtp-Source: AGHT+IGCCzPDvqFA0Lhgq9CgIu8tVKPJgqDh6Uuo5pB2UeImhGAIS5xT4O/KxoaBAbe19P+UkCz3sw==
X-Received: by 2002:a19:6a0b:0:b0:521:7846:69d3 with SMTP id 2adb3069b0e04-52b896af22fmr93823e87.55.1717113030884;
        Thu, 30 May 2024 16:50:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d76217sm127052e87.121.2024.05.30.16.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 16:50:30 -0700 (PDT)
Date: Fri, 31 May 2024 02:50:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com
Subject: Re: [PATCH v3 9/9] misc: fastrpc: Add system unsigned PD support
Message-ID: <kxd3jdjzz7lz4a5c4jcmtqvgiq6mz2ryunzhlyfuik73p3wj5z@5qtdfguopnjn>
References: <20240530102032.27179-1-quic_ekangupt@quicinc.com>
 <20240530102032.27179-10-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530102032.27179-10-quic_ekangupt@quicinc.com>

On Thu, May 30, 2024 at 03:50:27PM +0530, Ekansh Gupta wrote:
> Trusted CPU applications currently offload to signed PDs on CDSP to
> gain some additional services provided by root PD. Unsigned PDs have
> access to limited root PD services that may not be sufficient for
> all use-cases. Signed PDs have a higher dynamic loading latency
> which impacts the performance of applications. Limited root PD
> services could be opened up for unsigned PDs but that should be
> restricted for untrusted processes. For this requirement, System
> unsigned PD is introduced which will be same as Unsigned PD for
> most part but will have access to more root PD services. Add
> changes to offload trusted applications to System unsigned PD
> when unsigned offload is requested.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c      | 27 +++++++++++++++++++++------
>  include/uapi/misc/fastrpc.h |  2 ++
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

