Return-Path: <linux-kernel+bounces-421683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F599D8E80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B4A282A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBA91CD1FD;
	Mon, 25 Nov 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2Ac0jde"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9018218FDDE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573768; cv=none; b=GEruKW0Qxt359KciwuP5juA3YLZNJ3Mq0DUClszKuCwrhMdYbXuNATss/JDWcx5jp6WWJhEc9hOKSSKAfFFurvbsE+8kmpog0c9Pwr9MiLe+74r1/ZAMA9AqImfJGhwSPWgZnkuLUmfx9hvPAHiPVg+gW8ktWsVFcoQ/ytmD9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573768; c=relaxed/simple;
	bh=Zv4igQKh76pMJsT32dZiQKJumIdYGyMxWxv5i5Cxj9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub8TISmoVZgjHBkycOroyxBonfn6y1wyil1aAsBvzPtKvf2Ot5AzeLMidi4/5tEwUPsSQoQfe3OX7M9SWayzLfcGgEPiqEbTJ3tZifaa0+SMoW4menNwvI7jbsei/LTqeaDCbeii4Gxj6kFtgUKLtocWB/0upf0ph4/TOZBFWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l2Ac0jde; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so54512461fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732573764; x=1733178564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7Mjha7mt7/m4DZzh3o0nA7+a6qpYNJG+dFaWFBEpuk=;
        b=l2Ac0jde0jeC41MCjc8QCwIq90/JFKSDJb2ftEezKaI6cQmG5Z5QFaZgyV/3B3dGDH
         B8yutOie+QwbvoKx7C+F6ZIVxfvhS6L7G160yUrvyGxaybZ1IsovD2S+en+honukDhDG
         +OwrEm9isWzYwNv5CcHua+adyQkxz/5gzyeEsBmqeHaS794ks6kydsZpbdUtzilzN0H0
         Ku+Rx1yN3EdVLdA/L+hau4SI+tp5y2emz+ldU4pI5XRPTox6EqdPQ8hVOhUeH23kXXDE
         lLhxjhBiG/jPn9/O5itZKVXiWh+PfwlIDdUwN85e/f/LOAAnLUMWJDa9nQjsEWj8x/7F
         g5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732573764; x=1733178564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7Mjha7mt7/m4DZzh3o0nA7+a6qpYNJG+dFaWFBEpuk=;
        b=ffsEcoDQcn8yK5sKqwYHAsob3H1yI43ltub6831myNHAEKVioL4RJ6svawsyirzGaC
         lZ2SZsQIhSHOPn1B1AJcz5qbFiEARHau+ixTWzS+7oysqtEID992rtpS+S87Uxe66kou
         1uH8jAawCQHczN8fda0dtE7rbhfpl9404N+snIbB4ue69PaqhfFfUZTAwkJwU2KNxKiQ
         vqxmdV+SzGoXNli70fwgQI/Hi78nj8hQzyNP6oJoLAAFaqlhZe/ccUPK1JxJK6YdEMUm
         +qx9pdj0PSba/1KN++VPN116UpcesJFF3LAHFWH6vEDBaLE4zR0ZeOkXy9UvGTnqiUW8
         fEiw==
X-Forwarded-Encrypted: i=1; AJvYcCVKnl8rovR10cjFUGqYCfO+pTO2AMnzIJ/vdOkIjnCryddfiUoURL0EC6NtmIEJY5LynZbwqGhTICkL5CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIaB/5Gcom5eVU7Wzsbw3XZT22VZ1bSw9TD0DtZwaSzaBi1ev+
	Dv0sTTsTZP9MszjksVQ7G3IzyTqyr8uQygmYGae6Yb+UQB+wHxth28mFD8QiB6c=
X-Gm-Gg: ASbGncs+JhvHc4H+qjHA4pNKEE7GeIR9wiyaMnT9tF8Pl2UFXHoUvGrfm7HoyrGlYtF
	uEBaRqbUvpnKgCs1mJFjIjJ5VN5DSlq42M8i0uCG7oZLUMG5T1OUgMA3SOr+skY0BWyPQ+qOcYW
	7jTD0pU7OtE6mdxK+reBWK6KYTAZ7EVqsMdVyIJB537E6aHZp+SSBylmK22VgL0B+MUcJ6kyNiR
	xevIerniA9D6QsTmmj8MnArfOsTcJYwCy6oniDU3A7Ag+a2ydBM0ioByT1X51vV0t12av9pJ6I0
	5QvgQ63Lues8W0NDXWZnmkIYSyGvMA==
X-Google-Smtp-Source: AGHT+IH1IKpz08cjmxxXUbJM5uXr9tgTCebrKIjGwrE87znYHiTuxb+ZVdM3K1db1okc65pMOPjqoQ==
X-Received: by 2002:a05:6512:3a8e:b0:53d:a58c:c5a4 with SMTP id 2adb3069b0e04-53dd39b0e4cmr6366883e87.40.1732573763643;
        Mon, 25 Nov 2024 14:29:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2496ae0sm1820105e87.239.2024.11.25.14.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:29:22 -0800 (PST)
Date: Tue, 26 Nov 2024 00:29:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: maud_spierings@hotmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: x1e80100-vivobook-s15: Add
 bluetooth
Message-ID: <7mmnvrgzmqujse4bz2eosdnqmogyvfdi3ei5ez3es562qncks3@yqre7fakszbb>
References: <20241125-asus_qcom_display-v4-0-61a4da162406@hotmail.com>
 <20241125-asus_qcom_display-v4-3-61a4da162406@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125-asus_qcom_display-v4-3-61a4da162406@hotmail.com>

On Mon, Nov 25, 2024 at 08:11:19PM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maud_spierings@hotmail.com>
> 
> Add bluetooth for the asus vivobook s15
> Describe wlan configuration
> 
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
>  .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   | 164 +++++++++++++++++++++
>  1 file changed, 164 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

