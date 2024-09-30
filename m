Return-Path: <linux-kernel+bounces-343565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84568989CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F65280FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF79F17BEC6;
	Mon, 30 Sep 2024 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uZ722uia"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937C17B50B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684564; cv=none; b=jfxhXaqaDyPWCnB3ajkBXhiqwN6UX3wHZgpdMTPrTabLd/D+/vQ8o5KVz6Vnej/ojMlcBwh2bhvtPIQSef41vIh5ChAVnnR+ER0pXP1dTjUzPzOeuNnk9j0IpITi3r3/YWuBI7t2zDTxmVl7ATURe37M1imYGgs7avsBGjD9gUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684564; c=relaxed/simple;
	bh=kInzHu+DZMjySF5HgJl3aVLaJWgqnDiy6OGoBldmmtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmk1jJIBoAtya0CEeDvaqiSnrvr8wLldoOwI57zz88Lx3jE5ORetgvsCcZYdmug31SuG+m88l0Bi2vsKF5wSoCT0LANi9MruLo1Gsp2paisv/0aw4yG3FYWOOyiBQHqdtHfTEFVF+7He5AchLD6rBJFmBUWLpTej7N9O8a4N6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uZ722uia; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccfada422so2078368f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727684560; x=1728289360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXLuuCMARrDSkoYE10IWmIDKxlbdBGWD5/DEfplZmu0=;
        b=uZ722uiaxFCMW2Wb3wS49lGPJxrHwb3PAS8NzmtpMvdcgzZAibHzmwX9dioSeI4b5d
         7by1gOGs4eCFLRBAsf5BThDrIY6n+v6tp334JcyygtomcLCLlhXoyoujX1xfEhbjskp8
         f5vhdzIxUBFYjX9YzLZSX14g1Sx8XISF7OZxzoqyvp2ZY2lyhBrxAdEB2+cQJ4ycHCe2
         oFM3TIMDMIxnZBKIwCxswEgulob+NmQQdF/nDfR8k7kz1gWx4+xRSCqNn9qlNUB/qWeH
         bH3j3dnpqHsclVGfB6iLJ6WMdZkxBig87lKvIvHgSXZZF/MY/tbaPyHHDqFnZUHcp7MB
         TItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727684560; x=1728289360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXLuuCMARrDSkoYE10IWmIDKxlbdBGWD5/DEfplZmu0=;
        b=MmS6H47TzE2Yk9QwOu3/TO245BSO3nNpa3N3IdySJ8EPCg6vEKaWHS7F/B4KayXI2h
         hbR6J2X8fmnYEhjl6gg6IyEG6mQywaw5Osu/1poblPU3Tn3RHN0xKHtioD4kaTZNiN/F
         S1iLcFWCcPBKXbBNyIl3R0Tm+bb/EekuhcTxjMBpQoykBnTs2cdtwvzs2Ae/YWazg22M
         H69WrFiBsaQwpTRRMuuabS0cFd3R7i4a4oqHq30NBNPbIQvdxCdDm5NubOTBguGNdmtk
         oAOWovotaOWwDMFbOEDiYNMTGRoOtu7CgQLyN9pLrSbVgjxgJv3UFkrymONY+RcCZJu1
         j5+g==
X-Gm-Message-State: AOJu0YyWKHj8xsvgnzhD4xLh+vxwN4g/MthgsXnvNgRBIi2P/vj6uyOj
	ay4Zwieq5rNIwCKcCKMz07smCmcMujzQwTZRXhZS7UE0N3Y75QzbQj1qvZzza5X/edLWHca+iMN
	U
X-Google-Smtp-Source: AGHT+IEtSCEZEaoTjTbTuLSoNZbqIclxjd8L29K4RDx2V5kMcHLRnI5c7hDIQrELSjeStwElv3JSLQ==
X-Received: by 2002:adf:eac9:0:b0:374:c8e5:d568 with SMTP id ffacd0b85a97d-37cd5aa9974mr6999793f8f.29.1727684560337;
        Mon, 30 Sep 2024 01:22:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d01esm8522655f8f.3.2024.09.30.01.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:22:38 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: Fix reference to linereq_set_config_unlocked()
Date: Mon, 30 Sep 2024 10:22:32 +0200
Message-ID: <172768450502.13259.13167820347388112878.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240924155624.230130-1-warthog618@gmail.com>
References: <20240924155624.230130-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 24 Sep 2024 23:56:24 +0800, Kent Gibson wrote:
> With the change to cleanup.h guards, linereq_set_config_unlocked() was
> collapsed into linereq_set_config(), but documentation referencing it
> was not updated to reflect that change.
> 
> Update the reference to linereq_set_config().
> 
> 
> [...]

Applied, thanks!

[1/1] gpiolib: cdev: Fix reference to linereq_set_config_unlocked()
      commit: f522f396ab801ecaec132948b3766fea3a41359f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

