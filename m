Return-Path: <linux-kernel+bounces-535579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74120A474C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB127A5DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EA42222B7;
	Thu, 27 Feb 2025 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHeNWJAT"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C521C9FA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631070; cv=none; b=aENd0LJSvEbXBqFuapKh8AngVgMe1lgq/aKKcIvACOI71BDGueQ6kqH980CYn7hF2HuH4LH3a8NDOPXGP+swtl/3FIoTybjY1qyWjqA3TALHqjROw0HChW0RpYF1KmOpAFa5+Ic1PYLct3P+xfZHMpAhrVbm0RP6GUWSTbGT6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631070; c=relaxed/simple;
	bh=vpCutPqoDxQnJQCPEd51KBxUZ5j1zIGXF3PAmD3Zp3g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIS7Ro/5zXnV+FONfYc/HUbaXvIE5cBltYX5WiBiGXNEB5QWmnXuKBIaEIk0jlogkPbDsgVKuXhf18NEZHhtzxWEVnojzTVm7ZXmayS100JY+rJbE6Kl0OhFUdaqzxNnlhBhFi7oZbhsGI9kFu5fPjFbN1M12WMKW3EitA+Wavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UHeNWJAT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so5661701fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631066; x=1741235866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb4hUKvEHYfmi+I4u7PNH6BBXGvHJ7207dDOff1Xgt4=;
        b=UHeNWJATzpJq11M/5kKGiYpV6MsrvqFG/hjtQXX8KqPjQBTiAIk+oNCk+SG8H31BcK
         p7S6Yth7r+ddb+eaQnQcUUOd/twxEyxfRR60VMxl00gziFDEgcL/3aJHR9MRNwEvrl7I
         s94S9gm+Gkv0m8I3GDh8rBuvP7wxqzTn57pfflcaBYtG4cueU5EMstqGe7xGfTOJulPJ
         q7gzWbJWq71bX+qEHlUAjJ5SzUe8CC/4a00olJStu9QsSmbfFRU4yJLUm8QtiGZYcoA8
         kF6V+zGhhHuM3TzDHMh4TFj2hwT1XLmaGpttDxcXgpnskW31QNkWhG8AYZ8RCXK0Boq1
         We8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631066; x=1741235866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb4hUKvEHYfmi+I4u7PNH6BBXGvHJ7207dDOff1Xgt4=;
        b=GX4unN9qBIzKyOCaK+xpUf1B5NYiXhQ7D7O8+6vvRwh8cqZQ2t+UTH2YB4DUBAtqiS
         dA/kFOyAsJDjUFyKZze0WcM1DU7D1rkF5qanuYoQMHbCxxD+EWnpUH7oqXBCVJ+FQMNG
         DaLlrRBQnuHFCcVoSuebvbCMrEqNhQ7YD5E3vQpc1ENya2eP69fsI27bdFEkD6gmK35c
         J6fslL3WNkuLxZIiNkJwBZF+pxpAJW0D9H8kkVj5XtqrcEEjTDxHCFAK/96Tk33vGrPB
         z5eA60HNothsrTk87vSkCZ829X+kowRNF/cTLUK1B4cl3ukKO3mIzlyBo8fJasOyiKGk
         RGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYkdJRkDamV2Rh4bF7bodnWUBQPPdErUineAI/Vdj8xdRdlp9k6fXBk8EE7/hxS/mKVOfKdfJa24MkZqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnvrkl84BTOb33AwDii1EcQeAZAHRXsUU4YKsnTzstZ84tzXmG
	ncOTWZLtQG10nM5lFdIq4Fcil38heMpmbpMWKi1NNgiIGvVLbrwYIDu5+tAPBOY=
X-Gm-Gg: ASbGncsMZKtxV98Rx4wOVvVt485yDgbiI+QvnPrASU9IQWXiPC4K/seH9ILdNIaatUU
	LwyyQP85c74tX9s98031WAMQ0E6egpFalsabVx+alv//yuQU+C5VFX82FNjgozn2u8rWsIT4REl
	zeqBG7JLq2fsj0B3F/I88va8pMvM3XEpkYyEp72diXMe4W54/zsOGnLNN3i4Wo5dA9MKbVGShMA
	Ev50zHDlePuZSXmCRmCLoP31WyVtMvQH4pxgj1V2tg9v0J2oyVCeRDzNM5Dh2aeC6nXXVm1DCnz
	friulWNfHiGNpGTugVYopvSkUBjMuMf33xviJY+l8g==
X-Google-Smtp-Source: AGHT+IGd2rBcbdDnOO9mUn66I/dFLYCzyc1GlDdtB8pQVwoJ0TBIn1SVa4Lymy/rEO+PlXQ6q8GIig==
X-Received: by 2002:a05:6512:3d0b:b0:545:aaf:13fd with SMTP id 2adb3069b0e04-548392717d1mr11821826e87.51.1740631066310;
        Wed, 26 Feb 2025 20:37:46 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:45 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: display/msm/dsi-phy: Add header with exposed clock IDs
Date: Thu, 27 Feb 2025 06:37:25 +0200
Message-Id: <174063096233.3733075.8120055678466952428.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250127132105.107138-1-krzysztof.kozlowski@linaro.org>
References: <20250127132105.107138-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Jan 2025 14:21:04 +0100, Krzysztof Kozlowski wrote:
> DSI phys, from earliest (28 nm) up to newest (3 nm) generation, provide
> two clocks.  The respective clock ID is used by drivers and DTS, so it
> should be documented as explicit ABI.
> 
> 

Applied, thanks!

[1/2] dt-bindings: display/msm/dsi-phy: Add header with exposed clock IDs
      https://gitlab.freedesktop.org/lumag/msm/-/commit/d1f28e30a525
[2/2] drm/msm/dsi/phy: Use the header with clock IDs
      https://gitlab.freedesktop.org/lumag/msm/-/commit/5100ae76b5ab

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

