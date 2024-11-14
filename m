Return-Path: <linux-kernel+bounces-410008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788979C9562
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F610282FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670001B0F38;
	Thu, 14 Nov 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k/Vgn1Ju"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B01AF0AE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624756; cv=none; b=VWg0gZ3VdEFT32lGvY0vJEmfuRld7OuD3k5yjRVBKscuW1jgw3/8Ju66oahr2bm8cLitYJtG88kNXP358I9Euskg5ct9dYi/REu2esN9VrbRxAe6cRnu1/awPJwAPLB6XJm7XyA0oxfLEyLvsr8S3ber9jqti28kyMT40pnKvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624756; c=relaxed/simple;
	bh=m7oPMa5p3+A3gTDQzbTb0wlLn1g0hZsNiZTqmAqcIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgUeoNhjfGvVut3v4oNu85vYnORqOwOh2qqQdaEAaPWgkG5IL/6peT7kwQKY/g18XhM+TssF96s+ucLAxtH+BZ2cHIFVzRcIXlOy8FxfVEN58xsC3lGts6b3SqqiWPTGsd1V9rMm0d//HoCFkgx+9OCkjdpl7GWC/nKY4ndbTP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k/Vgn1Ju; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so1175938e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731624753; x=1732229553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NDs1P9XbNpOqNm+yiQqI/JC4xjIru8KSYOpS3Yol4k=;
        b=k/Vgn1Ju5yJb+XQ7cdh4eDRzjXyWa+VSDT/J1+wxv7zJuXzcTOwc11TyAn3ruQxIZx
         TTIke5NrCsSrZhG7w3+5fqmiSzgh0pmJ3T5P4lcoRsLfoWjjsTnZ3zZaTMP3Jy3F6ZeW
         eqIZ09+HUI2YcFYS/OXwqNBC9UvZEjhWzeDlL2xgcE9hWM8bDbJ9J76k2lZXgtt1KGxu
         M/BpxBWCaeACOVzNQxpEfwWvFklFmelK68oNr7IqPfveIpvqyP8wHz+t1wQ4eFGHLvNQ
         B7tbVeArQYJ6fId9x0xeCDmqMthkrnCZHPojHsD3aAnDbPQbm1Ldn8g9bdOJVJoNcY9l
         Cc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731624753; x=1732229553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NDs1P9XbNpOqNm+yiQqI/JC4xjIru8KSYOpS3Yol4k=;
        b=vjcYenYmwHIo4V57tT12oo/Xl22lwVl/rdXJwJhMwnIbHlDgvB4TQaBHuoWIkunkYz
         FBngg0Fc9QWjIDR7k3TT11yl+hb/VFVoqAk4cUXVLGNqhoDlW29GIuNxWrnc9LuB64KQ
         YsIZymKci5OPu7v7KjtW3fzzP9C+3tn0F0gW5itsQtICykbB5dMBWKB72MoxKBVW2rip
         eFNv2hxA4i7v4XLRJv6STij08sKEJVZ2o+8JU9IHmt7DMI7LkjzUyiSWgWao1veDJKp2
         voG7U1I7ECUvE/bgZCAtCum68V5G1NoyIYTJDR0h35NOVgIJaGqMqL3G7ZZAYyb4TCL+
         xeaA==
X-Forwarded-Encrypted: i=1; AJvYcCXrNaIxPBmzf7+FU+/2LtOqkArAP6vUbngmsxj2XjVLStY+USGgiBQIw/p0cEP3b8+Tnf0RupDzpxI1V3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUa2bV9P7MLoz8CXsgkVpgBsGIzAPVtDEhWw0qorcRxMMrmHs6
	NFeueE9pRE7YWrK/z0/PNhT7MNroEbL1YQ2DWgy6eoG2HcWxRBIjqOdxbw38VjM=
X-Google-Smtp-Source: AGHT+IFuC70u0clLXzI+efCQgj8/nhkMPYj+HkxNyQR/JxhH3/4SZl0J6nunyzypEY45VN+oypMVNQ==
X-Received: by 2002:a05:6512:1149:b0:539:fd10:f07b with SMTP id 2adb3069b0e04-53dab3bf0a2mr191638e87.55.1731624753180;
        Thu, 14 Nov 2024 14:52:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6500e39sm337161e87.93.2024.11.14.14.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:52:31 -0800 (PST)
Date: Fri, 15 Nov 2024 00:52:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qup: use generic device property accessors
Message-ID: <yce7vswjat2bhda2l4c4ji4idtozo24c7tbmpahz56tmedmpw7@fn2h2t4hv7dd>
References: <20241008160947.81045-1-brgl@bgdev.pl>
 <173151232541.92239.8233789832026323394.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173151232541.92239.8233789832026323394.b4-ty@linaro.org>

On Wed, Nov 13, 2024 at 04:39:23PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> 
> On Tue, 08 Oct 2024 18:09:47 +0200, Bartosz Golaszewski wrote:
> > There's no reason for this driver to use OF-specific property helpers.
> > Drop the last one in favor of the generic variant and no longer include
> > of.h.
> > 
> > 
> 
> Applied, to the GPIO tree as the maintainer has been unresposive for two
> months and the change is trivial.
> 
> [1/1] i2c: qup: use generic device property accessors
>       commit: 400913bd4edd76ef1775bfd95543846bd6f5ed71

I think it's a bad idea to pull unrelated patches just because you have
a GPIO tree.

-- 
With best wishes
Dmitry

