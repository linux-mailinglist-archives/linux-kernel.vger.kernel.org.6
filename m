Return-Path: <linux-kernel+bounces-528011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9EAA4127A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC7D3B5758
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F741078F;
	Mon, 24 Feb 2025 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUlQ1RHl"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B772B9A5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740356366; cv=none; b=i2Rg21br1UEI/hiAUaXkaefk7W1OQ/R/2emSW38vP0O+7enF51smWffGkdMXOpgtDR7sVSjU74PcnL5AplSoGO+X56XyzShvMvXrH0SiqpICeAna1lUzRuFhfi6iKGf2C7NWhJje9GztanQSqc8L4UdVgYmiyEC1FNhY+lwdXjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740356366; c=relaxed/simple;
	bh=mJRxLtLX96QPS+W09kQbtgthZev7JKYRvBjAfO240g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN2hLwlVQgfw4SWmdUK7fGt+imgYSMPRygipFWm4JS55qgGbXDJmKjFrd783US08CDQ5LikqJeTW/31Zg+RdKOpSrv6rX91zjd+0zoX00qabrL+E4bzaGJk7OJrZePoTZyIUWixuxtddmtKSKj83RCFuoalMV8rPs0ENVQe2MZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aUlQ1RHl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5439a6179a7so4300384e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 16:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740356363; x=1740961163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R446aIN2RLdqu5QwrgfAwmYyzyFgaoXG1ioytOKBEEU=;
        b=aUlQ1RHlt9cIe9SM5rK4MHnDxjhDD3hDYCFtnTjlqWUso2oJaE4O7dgRWoMsRrEb92
         xNeeGPPynAsCptvxisEjJyNi/fxVBO7epH6r2OHt/MYXRT8fFaNY1/ZrVNFpp6Qjx8F4
         +VZGEuBOzdlWATgncxqNgDUHcjnrzd/icGix9GvEA47xQ7H+BOAv8g46LV9kMDmWGx+x
         FnhKYez/4kKRL+F1SpeXMNXGWovOLphpu2bAdlpHkcJKBmtBZ5v0KPdZCobrNUkCOvG+
         rF3VRQqYhK4Y/bxmM5mashBG5xTZNlo90iWZKhPL+nJSMIy0wSN3jtk87Nhv9hSeyAOQ
         aGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740356363; x=1740961163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R446aIN2RLdqu5QwrgfAwmYyzyFgaoXG1ioytOKBEEU=;
        b=LZM9PbICZv74fK9dYiSoBw5R7QlRDea5GGvh013cGWhhANbxuKF8qDFaPgGIXkvMu8
         XChnG/i/MCZyrsWX4eNHPQR+lzD5/+GpafkyJgetLg57EZKCa26fugs7LjDoGNzuS+y9
         Oq3d+FwXne8uoFTpGWYcWkKWuoNoGY9FXkggTZrFjwSsfzkJqdW2kNYCYMda+dYsAlpl
         55dpzVNZQF2Onb4xkWbYzOpKndHoP8q2bgRmKIi9/JcomkQzTJ1pYYTISma8FQZkZ5T3
         tLyfQ/RLPsAEMrtaIxc56FNWI4nvyyI39DYtgi0zn6DeiLufAUQE2+Ycq9+wDpuRuDMP
         CfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXswNTcAWQieyeWkBi3ItZnQkuBhtstuCqTMKCclW5C7crRrjem+OwyZg8y1Jrod89KI2L8tKAqBkesaLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyCjX2HRC5d9zvTtIJOXZjnnIRL0xrMxR09ThmsCoS3HZZ2i6
	wza4PMCoNzvjdrW9W1iEAbGDV67xtLUdEazirI2nMo+wE/QKgz+yoLVO4meJVWo=
X-Gm-Gg: ASbGnctHmFqbsYjsJHNywhtjYCFqLpwX8Ke+dLCI1vZXJmcufDw4SIneMeVIBdrqUOs
	MCoEkwbUxdpc/XUY6zp2hD9W1B4XdeqY4X827ApFaS3mKZIaC/m+Z7WgRwn/Ib89Rmsa4jEXBds
	8QyaN0GXKOYZdOub8DD8l6FPc8yh8K5A4zMSw+ruE+iZf7tCTO3GvqCX7Riyzsg1IatslaUhSX0
	bGmuYonzuFpzFZbD+hpCcudHkqF9GN2eBmmwX1989OoaIZ6l1RgKYdaadvwU4thFjkFeidn+rLv
	qJts0fYTjDZgByDimSyM+qmb+M8TB9FMHa8UCgHvZTsON/N0r1XP017NxxljiS0c58igIbS+isp
	rLWSJVQ==
X-Google-Smtp-Source: AGHT+IEpkhmi94KeSpVWykQL8VUd3CBwi10V/U7azWBMHlDu+KWmIDkAfZsUghpQkQNQWo9rzJEtLw==
X-Received: by 2002:a05:6512:3b86:b0:545:4ca:d395 with SMTP id 2adb3069b0e04-54838c56efdmr3781893e87.2.1740356362733;
        Sun, 23 Feb 2025 16:19:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54530df9016sm2710726e87.36.2025.02.23.16.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 16:19:21 -0800 (PST)
Date: Mon, 24 Feb 2025 02:19:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sdm632-fairphone-fp3: Add newlines
 between regulator nodes
Message-ID: <b7atryuxrqqo24q6rg5s3nmt3f54nzayaaipvoekf5yb4zv5bz@57zg7s7qgk2t>
References: <20250222-fp3-remoteprocs-firmware-v1-0-237ed21c334a@lucaweiss.eu>
 <20250222-fp3-remoteprocs-firmware-v1-2-237ed21c334a@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222-fp3-remoteprocs-firmware-v1-2-237ed21c334a@lucaweiss.eu>

On Sat, Feb 22, 2025 at 02:00:48PM +0100, Luca Weiss wrote:
> As is common style nowadays, make sure there's an empty line between
> regulator subnodes.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm64/boot/dts/qcom/sdm632-fairphone-fp3.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

