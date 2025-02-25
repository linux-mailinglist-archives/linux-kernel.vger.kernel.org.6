Return-Path: <linux-kernel+bounces-531963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1261FA4472D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC24867CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24177195B1A;
	Tue, 25 Feb 2025 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8KRm3E8"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674B192B75
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502181; cv=none; b=uHohsl8whY+9UABp96y2x5D8CYiOb0nuncGbOAyI1SKXNJ+wMYCcnL0doXwauf0IaPL1WM9hT5z87Vy4zH8JRoBObVRolhk5aNOm+LzwUkDUC7fyF4kF8OBZ836P1YB4mAafFGASzg95c024YaAoGoFa9gbuwszlsUzobqUgE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502181; c=relaxed/simple;
	bh=cSZ9ztT4mLDjdEXFNeLmYtzxxkPEck5tI6MIaJ3bziU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7JKf1rQbPJOtrGRDzNU/on+n4V3caCLPp2ZiGpxgecS94uThSQ2/4AcU1dg2LfuuFmwqcRtMYCyBUFTDR1OMzo0CBvZPvI5qSnJn8xFfBt3PLSmNIXajCyFAxuO84X/WFWzmQfSLF7zB7a7Ngw3NfP6jjwoU1wdIXXq1Onbap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8KRm3E8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54527a7270eso5852456e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740502178; x=1741106978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mgWZibQMuHj44S/S8PoDTRgBr00ghmQvGRAk6+vKs4=;
        b=R8KRm3E8/OF+6VPT+4EdtupMDi/G+HBtGPP5JXaRFd5AQCzNdzTG0L6GV75HAl3PLQ
         b0SXmqtZNaNSFA+mfeuaAzFNK9qy8fpM0SSphKz9DyseCXpR96eGp63mG1qHMN64Am2b
         L+ih8xwibZoxRYkwqx2UOHKez/BNFhmhoK3o3B+T9M3RkBfzQ4hRznTqNtOJ+lV7ECcZ
         IX9SuB77oCqrP4B0t/8Ux4PBayUDOf5N8e5CPi68+vmrkGC/qg/7l7KFLmT6GfD1G9g/
         nYpUeC5FvYN5MbhzNilw+524h6Ek/R9PdXOy4JiDumXAn6bSdgKUXODvVmq2nIhiaZwg
         mQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502178; x=1741106978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mgWZibQMuHj44S/S8PoDTRgBr00ghmQvGRAk6+vKs4=;
        b=qxOOigsam3BAPQyOURndMojDzgVZWQq1QxWi2+h2BzcIERHF4boHD0kz2IZMZIrZkz
         SwbdjsaD+OhoAHKeqgS8mFeYKPL6w8xMqA0QTzSR3h8s3Cmpr1VqbQBrh0u1taYs/tPq
         JhPJVuia4WlXgqbyUSWrL+aZpQV9CirTHp2EgSJ0dFSzd2vi3G3vojNphEcMJXGmLEK+
         JX5nVoTiHlgR5l/ZiAFJmNItdXgYDdQX9q/v/xERWwmq+c2oe02np4iA8NJjQp0OFNKw
         caoVHdzWDWBAjWrxmqhXnzSUIM3BViWxkXXkQkCBHl9Gkh0hqQRkIQim/ruWUeXF1fn5
         Swpg==
X-Forwarded-Encrypted: i=1; AJvYcCUzfpPtUKqg/O8rRVnVkrt3a4sYjsYvI1ecKNcrPfG7kU1t6wj7z5LBf3rLIwyDJM2nWDNDTBQlRaKmIBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/1mSkJMbq/2McaqYNCIr73oEonTup3GRt3JZ7EGxqK7YqHTn
	PvDRc5TeQ3iZo/1VxB27tMa9Bv8cVatudROmuWGdJMUTR7sFUdkFWnW6j/H1GXo=
X-Gm-Gg: ASbGncuG0m1PJMBuGBe/C5yZs+MUPShswYFLVMC4RahV+kPtg65yUxWzZRa0PpFfFEB
	B1CUAYq+mhoIU7kgj9WarNTb1DtJFVip17h8Yna00ZiMrN7erC+5slNuKnN22JXq14StJTA89b9
	6B+hxVFy+3i8F3HW4/fqdSn6NFk03RU8FL9wMaDXQz7EJ8GMhcacrGhjxQ/Zm054rQKDZIueT+b
	tgP4T76x9Zr7d2qCOY0CqDL9srHAOd8PMfU7sbFTN9WA9MKpY9gsfJpKvePt79Pl7u5KebRUvP4
	ZLMkb0zs2UkVsHHRCmVo7Ex9t4HP2/J8GmJLybT0RCwQrJw/zwiZ7L80faujZlLLuUdNyw==
X-Google-Smtp-Source: AGHT+IFORbfzYSemq6WfOCUglMYdhzTg71XD6K2L6XeaH8kQIvUGNHFObPzSD2MUJfic2yxCajAruA==
X-Received: by 2002:a05:6512:b0a:b0:545:1d96:d701 with SMTP id 2adb3069b0e04-548392598eamr7478215e87.36.1740502177754;
        Tue, 25 Feb 2025 08:49:37 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b25e6sm220407e87.7.2025.02.25.08.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:49:37 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Imre Deak <imre.deak@intel.com>
Subject: Re: [PATCH v5 0/4] drm/dp: Rework LTTPR transparent mode handling and add support to msm driver
Date: Tue, 25 Feb 2025 18:49:35 +0200
Message-ID: <174050217098.2377948.2211237197268827323.b4-ty@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203-drm-dp-msm-add-lttpr-transparent-mode-set-v5-0-c865d0e56d6e@linaro.org>
References: <20250203-drm-dp-msm-add-lttpr-transparent-mode-set-v5-0-c865d0e56d6e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Feb 2025 12:57:55 +0200, Abel Vesa wrote:
> Looking at both i915 and nouveau DP drivers, both are setting the first
> LTTPR (if found) in transparent mode first and then in non-transparent
> mode, just like the DP v2.0 specification mentions in section 3.6.6.1.
> 
> Being part of the standard, setting the LTTPR in a specific operation mode
> can be easily moved in the generic framework. So do that by adding a new
> helper.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/4] drm/dp: Add helper to set LTTPRs in transparent mode
      commit: 5e7715478c273e5b17b08942182bc0350b7ef3a6
[2/4] drm/nouveau/dp: Use the generic helper to control LTTPR transparent mode
      commit: 226a0baf9098841ceb92ab7804a07426540663c7
[3/4] drm/i915/dp: Use the generic helper to control LTTPR transparent mode
      commit: 6dcc3c5121b72c3633592db761e76083cf7623a3
[4/4] drm/msm/dp: Add support for LTTPR handling
      commit: 72d0af4accd965dc32f504440d74d0a4d18bf781

Best regards,
-- 
With best wishes
Dmitry


