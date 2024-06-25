Return-Path: <linux-kernel+bounces-228799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEBC91670C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5D62817C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E420B154C04;
	Tue, 25 Jun 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LcGY4sSj"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBD14A092
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317531; cv=none; b=D//FvvwSks/IP2YIliyWXsBoVAGz8xYbjOhRVJlJw9q2uCBQtL/FUwmor7Q5KG+XFm+XtitgMCC29EjFVBA0NdrBf9Glr60zz57g+1yn/DO5HFQUvgU6JuoUSIkhAwTwvauhv119Rpjp+vfauNcCVMyuNWxMEVAcQ/M/fyLpF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317531; c=relaxed/simple;
	bh=SMmj/s5tPsZBtI0Hp87P6WGLNK33TBlA+oPjMk8mzlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YENBsKmq5BCk2P8YCmVvIqAlO1GTH1Xo9kHDE1PFmaUj1WzOAkYv0p+A0vs9EsQUE1mq7i1ZT/knUsxF0eALC3eBKjRI397MY1BMYJlS45D/5F/MzwCbABsqeITY5BGIVXiR4FZtDqzIWt/hFqe6m0IHMspw0TV7f/syV+kddUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LcGY4sSj; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso57646921fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719317527; x=1719922327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUWxLKV9ZU1i1HqEH7t4Y8lzNFBtk5FDAR2lcVEnJ+o=;
        b=LcGY4sSjx3QAi9vVhd0RZjXwJ1MoK7QR9sBbNqbuuJNcKnm4Dv5zR9o9lMkqact0SE
         RxKCbgdfYyuC9WEekNvce8ecqGAgMpOz+yTYSGVbPxDG/R2HejR2gN36PaO+r4v1hQmK
         PfYOCA8gGyYNR+zn0KYsVVKIkm7Jd2XLwZ8k1t0Zo5oSb2BIi+nMJrYDoPNmxdJFw9Du
         UDm55jmt9rMNiLwNMolmeU7E/JKSUCYycFArQIalA0sdMdTHS9UPiioxxkE0skgJN4l6
         hLhJeN/TDKIk62/MIXZqmx1FMt+CbfHNYgtb1+QyJM+IHQHmNaG1Dfb8uxy/NJ2wIzcf
         4dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719317527; x=1719922327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUWxLKV9ZU1i1HqEH7t4Y8lzNFBtk5FDAR2lcVEnJ+o=;
        b=alqrdGWfyL22gVW/MvT33SV/sDHhqMgRfUBB2kERaUtLnPdMZiGEnthgFFZsEV9WNm
         /ufOY3fu2n02QhQaAsME/8FJzcegBnGnD9JL3Cx4fr2xy3zDfCQdPn4eK0HfRVhdsg4M
         EZx5ZFf9Ey8q5QetnZhAtO8szgbQx0ex5Vzt6vsaj6NRdY4EedwTTbUQjhLoh69VXufd
         Ko9H9Y466lF9fDdC6iL1ETk3CFhJdMR8npU/YoAjFEiij5SgL8hdZTtfQWxyv35SvEiU
         5MVeOloqwWijvau6kU/NM0gggZh5efuj0W138KM36WukybcMzowJ7BMHaIp6AW6ZOmC7
         uNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTghSHfzIgJYcsFZSi/Ea2rweJvSh/jwxric/jXmxcCN030U7V6+HNMIxcLGQuI9JwCXmu1g+YQJmNjv81khBtnjNszqE5zmSFTR0x
X-Gm-Message-State: AOJu0YzoECpEe3kIAfHKHzp5ThHpEuYO8Y9cVL51HRO5qiFAA9sGHJgs
	Ym1yD4dB6accPF3S5ULmcrN9TcodYmN3IlfkQmMo7eYnJePYq63CKn2Ca46bd0k=
X-Google-Smtp-Source: AGHT+IH80A0Q/I9cA3o4S8jLtTyDN052E3s8QDSrLmqKgOdam+ij6v1cwzCOFUinugK9U/0pYOmD/g==
X-Received: by 2002:ac2:4838:0:b0:52b:c27c:ea1f with SMTP id 2adb3069b0e04-52ce185faa8mr3746809e87.55.1719317527555;
        Tue, 25 Jun 2024 05:12:07 -0700 (PDT)
Received: from eriador.lan (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63bcef1sm1214808e87.72.2024.06.25.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:12:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drm/connector: hdmi: shorten too long function name
Date: Tue, 25 Jun 2024 15:11:57 +0300
Message-ID: <171931750561.3859266.10071770084943744269.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624-hdmi-connector-shorten-name-v1-1-5bd3410138db@linaro.org>
References: <20240624-hdmi-connector-shorten-name-v1-1-5bd3410138db@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 20:39:58 +0300, Dmitry Baryshkov wrote:
> If CONFIG_MODVERSIONS is enabled, then using the HDMI Connector
> framework can result in build failures. Rename the function to make it
> fit into the name requirements.
> 
> ERROR: modpost: too long symbol "drm_atomic_helper_connector_hdmi_disable_audio_infoframe" [drivers/gpu/drm/msm/msm.ko]
> 
> 
> [...]

Applied to drm-misc-next, thanks!

[1/1] drm/connector: hdmi: shorten too long function name
      commit: 06ec7893a4b48a1fad9e94cb670862ddd65b6eab

Best regards,
-- 
With best wishes
Dmitry


