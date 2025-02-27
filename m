Return-Path: <linux-kernel+bounces-535575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8FCA474B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640B1164473
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975BA21CC73;
	Thu, 27 Feb 2025 04:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bk1eQrND"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6B21B9FA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631064; cv=none; b=hTbsGRbNmf9QDmPycTcAWrGcxVS07IGLg2KVv9TepR2Tai+FE98OzFb+4lk6mU75OZ9Mi1+UEQdKVmZueY7O/MnS+7Ux+QUoS9fT7j8qryuB9Hteu8l6ASOGDkav3GX7y6H5C+xNUQVesZoDUFAo8gv8d7snMaqHxdEiewaonnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631064; c=relaxed/simple;
	bh=mzPhRSU1K0z6zdHezeX9nAkdqjhhiEvRvVnPJfmgA5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aE4nEAgVz2pvjlBAiq/BRGxiXoejOJ03wYKRxAfAxXWnsl6IH0F3ItahMEpOELeoEO1T54VvFQjmBdpuUfiRDq5sPXweaP/THFmP5DnEDewQqLAP+oRl5ohCBLKKJ3fNt9OBiZ4RIBL706ygUP5YxBLGYWuKKNYwgX8EF2FvlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bk1eQrND; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54622e97753so555542e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740631059; x=1741235859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYSgKUYrO2YlmDkolp8bEhCgpgQOBl0qveOjHBhwpts=;
        b=Bk1eQrND8qWbGuY4bBriEYXWm8dr2Wlkd5k2MqegmeEpvKXmFZLw8CSaMDyub2i4pc
         gnLIZXdir+YzxldiX3km2iaqOIbkae/AosvO1h3MTv5wTnWR0GJ0L9CCJNqQUrYi6/26
         owpZMooJDRqRlj6IiAZLZP0+rYFQeOeAdevu+95jUS+cASFCrCWk7mFMZ/S6klEwvzHJ
         DPuXyEXHaUz2QhT5yEtUHRKxaxkO2XRWAFU3mssNSFHCpiCk2mHCQq1wv8b4P3WsYvsv
         UIg177qxygZY7txGw4uv1CSwBzCct+0oIGSuJUYspVve2JuQFR3qP34K9blDQCFLo8rv
         LBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631059; x=1741235859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYSgKUYrO2YlmDkolp8bEhCgpgQOBl0qveOjHBhwpts=;
        b=nqTe5BoZe3rAgAEVxjfWoMwIz8EtEM5cYXE4d3TVZIwGoqFTlnHgFjnm7qHGqKiVSo
         1Rk5DpWDTqIinc5MSNLolwQul+zXcTb9rNIlsYZpuXaCJqNkrxWep+Ips+X15ExH7c3p
         HoJH+COSV/5G6M5Y5ohnz7hL54zimJYp49vZRDjwQ1nL5k5jC5RIGhGCwzGLXO3wbVCi
         jhkwGczihQQo5AZk71T0ATU34GQJJR5Gvf77tQsNvUao9Ed/I365vV6xsmYCiH+URFmk
         xGyBoEr+qxS9X8Nyto2bOrrk9r0TDw7SFAq6UwoQtHqBVRIynXtJhLoIKVUkIDDlNOn+
         xZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfy+4gJayHcvxJucwNCJEgaDzN9eC8Jlkd1QIC1KbKOy2ZuKspAoLCd9K2FNbF+tVSGiK5y0Oj6f7UjHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqJ5VCVXfWlkkHJbC9Pn5SdtNAxvETAhg+HaUr0GMi/wrHLtX
	MwVXgkGEWq41hBOk0WsM753O1IF1SgaZ87dCe73Idx6SwoeQnHNxS9Zk7WIXwcM=
X-Gm-Gg: ASbGnctW8Ij1q1POIvAKM18ThyDayvPOKUa4IioxatZUQXUKbVUn3EsVq4x7gHGH4Bk
	na+FYUZncq5XXL9cZD6vl43lAKFapboB9Ey5iZGC8D396AWcblRzgNUfqtDTCzsNCVscStMWACX
	emwQPBEQUmpovyaQwCuAElSnx5ELEJQa+zVhJ96XWFohnyS12hPMSBhj9kPdAXsEi9HrRHVsRN+
	aaqNEg30m6iFUAY0ayFPOIpF3MB6AOoUwMonsDyU6BkAjMPeymch8rrdwMucOu7Hst9Bwegf3AF
	yU1HYiecTjrem9P1+rLK9qjLpnVJ99g1TDUDsA9MGA==
X-Google-Smtp-Source: AGHT+IFJTbOhodvzE89VyWlm98mXeqCjUzL4IWC2ENgI8KAMI2IbCSRQGTMlBENkiboZNnQ5ghsFCA==
X-Received: by 2002:a05:6512:3b9b:b0:546:1ca7:81a1 with SMTP id 2adb3069b0e04-549432ccb18mr616846e87.3.1740631058787;
        Wed, 26 Feb 2025 20:37:38 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443ccf45sm63485e87.229.2025.02.26.20.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 20:37:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	jonathan@marek.ca,
	fekz115@gmail.com,
	Danila Tikhonov <danila@jiaxyga.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux@mainlining.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/4] Add and enable the panel
Date: Thu, 27 Feb 2025 06:37:22 +0200
Message-Id: <174063096229.3733075.14794380891862567011.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250217222431.82522-1-danila@jiaxyga.com>
References: <20250217222431.82522-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 18 Feb 2025 01:24:27 +0300, Danila Tikhonov wrote:
> This patch series adds support for the Visionox RM692E5 panel, which is
> used on the Nothing Phone (1) and then adds it to the DTS.
> 
> Before integrating the panel into the DTS, we update the DSI code to
> allow bits-per-component (bpc) values of 10 and 12, since the Visionox
> RM692E5 panel operates at 10 bpc.
> 
> [...]

Applied, thanks!

[3/4] drm/msm/dsi: Allow values of 10 and 12 for bits per component
      https://gitlab.freedesktop.org/lumag/msm/-/commit/b0e71c2637d1

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

