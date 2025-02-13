Return-Path: <linux-kernel+bounces-512181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4B2A33551
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8DD167E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B1146588;
	Thu, 13 Feb 2025 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwA62Gmo"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5CBA2D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412676; cv=none; b=jwwQT8wPQ6Nl1HiJEEW3wHbTPlOf9hqKctaL0Wci2ufDfUrHS/AKmEukhrnLiSIOIMAavqdxuDJBtTLgoutNrPnAlG0xla55jn4IpHsbbG7G0FZRhg9sAlhtkjl5J2SMdrHP6WnjTVQ7xu9wFMoh1TW2hpz3l6icmSWwY4aVmFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412676; c=relaxed/simple;
	bh=LOIkOe858jFawlVEuxwzG/mVmWRJ1KKtzW2F/cZ4MCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHKvVRLhPTzcqhWI+h7l2jv3/xT24MecP8Eu7MxWZDs+c+bzN2UN7/1/2GJCSHZGJ9V0ckv/wYjbamSZGuQpH3IG19m7VNNEJ2ABprZ6rMQxIJSaa7CGcrkQ3EHp4MdsBpiVKZ4TPoLgaH7NjsyFwM2P53fYZPVkrv53Vi3K++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hwA62Gmo; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-545064389d3so337787e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739412672; x=1740017472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uETtlEXGg3xvcgX20Aitn/IHvXITMfEocH7m+5/CDRc=;
        b=hwA62GmoA8Z3A+pc2hIpbco3nFjK3gGCSqBc+37galSQ8iXH7rGfPIs7Xjorw40J3r
         M7hCJ+vKc+hMSqyHg6zb1WZ0TVoDAW4azOImR1Dumwrtn+/8RdA6raeV65QYZxzOWAEx
         is3BigSeNcTbB0c+tUpNj02gd7wLKwL0ElylDA/X9/LHXPc4zIlrWEvEatfIF6nut0WR
         aZooHq4TiJ61IPJqfvPfU5j3ovpNhU7vFuRC0Q8nytV4G6c/vVR0YJ7cxCEbfg5AXuo9
         g5/QY++7orDFRTZrNwH7DBQnDSswxzANQIb8wJHISiTNl6yXlxwigR8MF2T6wjUL8OJs
         F6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412672; x=1740017472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uETtlEXGg3xvcgX20Aitn/IHvXITMfEocH7m+5/CDRc=;
        b=YjZVSVMzn4h8rbgwfjduAt9wQcAvhoBYwjmVjsCGWxY03ltDq3nhK3t6yppagbfRF4
         Oz7+2vrP0NCKYaJKYzpGz6E723+WkBvznq9MGnAKethf7gwGe22WH68Yo8NRw2zRwy3u
         LhFiZ0r9uTXULedDSy6TZKR3/I0tWv4ppMJdNCJscz4vPJG0gviYmxxnHzaFjbgQD0VF
         BAjOQN+UHPT55H5HdFtbgs+wRaZ5S+klGyg4uJx18cF5/3HLKRXoM5rFWy/VofdYnQfn
         HEDCgcarUi0C5qAzZcFN19O/7NcLxFYYBMot2oE3mV2PQqqnLBC/mErssbFkIFQU+Fcm
         6H1A==
X-Forwarded-Encrypted: i=1; AJvYcCVrni3Cwyu8u6q3NXSZEtVqMxMxISS6IZvDIKoZT38YnrbO4uPXBz+jGCSHExTc/W+MpITO98T/JmJEAQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTXmRKjcueRuWinrKN52/g8yKlkU8vf0eM6DDQA3v1fBW3/szJ
	NiglxM1D0LJv5z8P7caJze6wMhjj+dboukIG0GD4DliIqesQQ8Y9JEBYw0qt0Ms=
X-Gm-Gg: ASbGncv/NmLhXqq/ipX0A8oUfI5eqQarNS2JHp4GHW/EwkIWq246pQRB8/zlapClugx
	cch8Uq+EiJOxCeV4yefDT3ynWCG+JRAM9P1Y5BfzpZj1EI/A3rgmQHH3d0QZn4Y/IyK+Y3lg5n/
	3yQw+fhjwua4n7XZaxI0tE302VpoJlj8qCY+zduzaxDHmLq1v/h/tyHeC6o0PKzTtW1KDBatBoW
	RKiruNZUS/vBnKT5zQKX/mwbi76tJt9982lnnQ3Gu8O93OFd1EB2gu0RyLyHyI9NGp0wlPnKqD6
	AkZx07G1YVSRFTPuKVGY+CzLdLcp3DJn2onFVQeKZyZOpKKSzAm9wRL8Opo=
X-Google-Smtp-Source: AGHT+IHCQB6RMFGTUdTRgyNEU298nfvRKm1DnMj3OhLiPjx5ynnKK0R/puRmL0YjByCysEp5/mqPLA==
X-Received: by 2002:a05:6512:1248:b0:545:9e4:ca91 with SMTP id 2adb3069b0e04-5451ddcaf22mr407917e87.39.1739412671798;
        Wed, 12 Feb 2025 18:11:11 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105d2dsm32063e87.128.2025.02.12.18.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:11:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm: drop i2c subdir from Makefile
Date: Thu, 13 Feb 2025 04:11:08 +0200
Message-ID: <173941266332.601413.7867289561015884943.b4-ty@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213-fix-tda-v1-1-d3d34b2dc907@linaro.org>
References: <20250213-fix-tda-v1-1-d3d34b2dc907@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 02:49:41 +0200, Dmitry Baryshkov wrote:
> The commit 325ba852d148 ("drm/i2c: move TDA998x driver under
> drivers/gpu/drm/bridge") deleted the drivers/gpu/drm/i2c/ subdir, but
> didn't update upper level Makefile. Drop corresponding line to fix build
> issues.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm: drop i2c subdir from Makefile
      commit: efc84f661e0a1b73449d678a89ad86d61bbf6bf4

Best regards,
-- 
With best wishes
Dmitry


