Return-Path: <linux-kernel+bounces-368352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD59A0ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6FA1F21671
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D2320FA9E;
	Wed, 16 Oct 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J865w4As"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7F1F8189
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093508; cv=none; b=sA8zXHuYxbaHcskJfoSdYnrd6lndj2Jx76jF18y2gjIZznBYOl9qWPucqKANIL7ijhrpmvXrGQA5DToPZ+0xd98AncGBHuFumvCHu2JKxJ0Ri214SxpXcsw/HnUwjQ5ZwZuNHp0bv4nTaBgO7lPpb+nKaYWTgHeuJdgifaVB0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093508; c=relaxed/simple;
	bh=TgzrkvgyruSxp/GyWnOJ8vI2zTVE6CXKwpfh2BBM8lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzH4Xa0TKsQAv9Z0lZ8V9FPAJHUwApnDB/vpVEj4xYW5TsvNAgjQXJd/JG5WKYlk/lMJH0JNa2Fb/by9EOamd/Vl2vM993qzBqfmkVv0kWwva3mKJvNQxhs1+GsJH/eE6i6H/t0YjWZ5W3d2P4V74PAmm42VasXneKrLYEFCMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J865w4As; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d50fad249so4469833f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729093504; x=1729698304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=anU227wWD5p9c6NGfk2++dpWhZp0Cho/esdFJsOtL3w=;
        b=J865w4AsG0d0Fkcc+tkjjfj4CTuqlWKOkxzqpoVgl4tqcBqTETSLgdVcjVoMq44R7I
         pj3Hpo3/V59fjd88jiMjdoBo4f2QTvE1J8itkr1QkGTQg9P1y8d5LSHc6iFeyW12kY3m
         JXxZH9ewOTy0J+Uu55BqPIVI6nyKhXGymuHxd8DMpxYpQ6bDeB4OroiOna6tYL22n63h
         PTmEHQwHizdWUV6cq2II7XMjBWUxb5ETBcG/7WOkiZX/xBzsqI1r8n8KU6Dqt1LUu9iD
         Gy1TBQcxd6ezYp5C3GefO5mjVI55xtwbrFHTkV+I/ktFa0WS0AlBcvBqXFWW8+HVo+Yi
         USnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729093504; x=1729698304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anU227wWD5p9c6NGfk2++dpWhZp0Cho/esdFJsOtL3w=;
        b=skzIK63wynxoKWboo/Z06P3t2KC9PcvTGtZOPxXNvaob++Lxxf+PjCj/+5dBHszUu/
         eWr16B6hsNI8iILa0F0Vpn/poKZQHwSnlM+6Qmz+4PdTzHnkdusSRj8GUkZNa9f/u2H6
         hYTP42PVISJT9dKiIQenREqN/BKwcafgdgr1WdYkDukXewrU31D07MhK/VgcsUo2+BIm
         5AjMitPwZCkXV+Hmf6FNGgRDQWBt5HIptyCab/SbqpBRk5O4z6xgN8DL0rBfe6RcWas/
         U6I06WP2L5EiPQBMs6FJdpvM0ltifI0Mb4leGr9ly6yFvLx9ohXfNXhZP3YXUr37q3Qh
         vMmw==
X-Forwarded-Encrypted: i=1; AJvYcCUM0uEaHxoJcMN/vlliSgmK6B9xvaKD/iSrO2JnRTpA9ZL5aJrbL6rzyKl9larz6JRNyRi0L3Ljp2dDEoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsaqZUTKWzEueqFj+3oiGjb5ThAEqs87a7vLKR5ok79jwR/Y9
	38rIKCBjvRaw5KjVe11vfaEVQUIO4rRmCHt4x43BXckp4fK2JmR4+qiXva8UdoM=
X-Google-Smtp-Source: AGHT+IGRr+iJ+JXBjhKHnWyJ8btrX2CzaFEg+jEL8fHLi2mI3kdazj2sf5ZCHFXS0FJnqiDhJm6dag==
X-Received: by 2002:adf:ee44:0:b0:37d:52db:a0a1 with SMTP id ffacd0b85a97d-37d86bda4dfmr2927571f8f.30.1729093504072;
        Wed, 16 Oct 2024 08:45:04 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:a75b:8bbb:91be:de0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc44a84sm4623361f8f.114.2024.10.16.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:45:03 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:44:59 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>,
	Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: dts: qcom: x1e80100: fix nvme regulator boot
 glitch
Message-ID: <Zw_fe1tN_rdRR659@linaro.org>
References: <20241016145112.24785-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016145112.24785-1-johan+linaro@kernel.org>

On Wed, Oct 16, 2024 at 04:51:06PM +0200, Johan Hovold wrote:
> The NVMe regulator has been left enabled by the boot firmware. Mark it
> as such to avoid disabling the regulator temporarily during boot.
> 
> Johan

These look good to me, thanks!

Can you or Aleksandrs send another one for the x1e80100-dell-xps13-9345
that was applied by Bjorn yesterday?

FWIW, for these patches:

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

> 
> 
> Johan Hovold (6):
>   arm64: dts: qcom: x1e78100-t14s: fix nvme regulator boot glitch
>   arm64: dts: qcom: x1e80100-crd: fix nvme regulator boot glitch
>   arm64: dts: qcom: x1e80100-vivobook-s15: fix nvme regulator boot
>     glitch
>   arm64: dts: qcom: x1e80100-yoga-slim7x: fix nvme regulator boot glitch
>   arm64: dts: qcom: x1e80100-microsoft-romulus: fix nvme regulator boot
>     glitch
>   arm64: dts: qcom: x1e80100-qcp: fix nvme regulator boot glitch
> 
>  arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts | 2 ++
>  arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts    | 2 ++
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts                  | 2 ++
>  arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts   | 2 ++
>  arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi   | 2 ++
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                  | 2 ++
>  6 files changed, 12 insertions(+)
> 
> -- 
> 2.45.2
> 

