Return-Path: <linux-kernel+bounces-242978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC97F928FCF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 02:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735AE1F22287
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 00:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4335C99;
	Sat,  6 Jul 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrNwZ9ef"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD21758F;
	Sat,  6 Jul 2024 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227037; cv=none; b=acuXqRfdImQJudOUenYfR8KBA+BC12HpG9bNflZKBnYnT3l3LPe+UhC6UGi4c6fORnMLoUl6vi2WARYKhAGNx1uo4AK8HIPSkkeLa1PBgg+jgboTGSVPIRZcwgWrqOy3E00C5NWfLN28WmdY6Ieav7mLUqios1m7pvMGwTu+74A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227037; c=relaxed/simple;
	bh=hjcatJzrKY+zgPSsW0kQGkVslVDge9AGFKuusDrivWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3e2rC9q2niZYpQ6CCxzyloxf5JFtqrcGARVr0wrBhERWFx1Rl1YIlUnHLwoA7U0AbiBZS74rMbuP+ePWaLOYbML0xSD2IyXKQs3YSBQEDCXz2r1+Esd3CIpk/YrEKPNXKBvq91OohUS3s7hCK4v916emkfcZtltPrhzQwwiJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrNwZ9ef; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424acf3226fso15308505e9.1;
        Fri, 05 Jul 2024 17:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720227034; x=1720831834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjcatJzrKY+zgPSsW0kQGkVslVDge9AGFKuusDrivWY=;
        b=lrNwZ9efSI8dEcFAyooSL0o1XqhNVnuJ7v+mps3HHQJ6mL1cjihTe13L9DvZAyB2Us
         +YO7t1c+YNGmcOyYug1X/1JSsIviHZNAzCpNKEswq5hP5fpeNKJgqTrmrbUpIbQq1c/O
         TA4eczJTicGZYHWwM8Xhg5U5iO1y3RexfnnqketR9tNxc25zk41PV07HzLek3WXdJvbZ
         7EluKqmOkMhUYtfaqcC4OnoyYzOxsftHu7BQb7sbanO9PvOIGwopcmbR689OokaT51dW
         SYk1cHZKPCVWV91H0TeFMbLiy5LIyOnu6kOvNmfh8pouxnnP8+E9+QLhdF31tHGlIVer
         IvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720227034; x=1720831834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjcatJzrKY+zgPSsW0kQGkVslVDge9AGFKuusDrivWY=;
        b=pZD9+5c6CHqlMUq6/MTA8tZ/zLFPG3VW+6G0NPDhhD509w5IXazlNUnxkao51v6pb6
         0Zv+Cg+5tByzj1/3wlR0B71uQ+iknd9x5GxiSwEHs6NTdV3p3wNQUinR8jPvB5KQh8mm
         kAoqtVUqBAHD42hvUTqjq8qBBZj02fUOoIv7PY1kCFJj3mCBwchV9jmNMU8tBy9bc8xC
         ckGrLQhjPz+UmGbaDmt+8vBVoA63R8rm3i3y7w5JpHyOcrEe5jGCulMPyvSyIG7cGNVQ
         UAmwqnPu5DsJGg+9TCmqyJPWaEywiO1BMXRamSQbGYhOdUoF82OU2vkX0QwA1g6LAL/C
         5V9w==
X-Forwarded-Encrypted: i=1; AJvYcCWMF7BAbkrd7dZVP6xSmoL2lFwOCdaciQSAEJ1Ic9nOBefWxB8NqMz+/mBbmRqqDjtZS2MbJEDEZSMiydr7DuCT3+4OK/YUXdcEVvJuIXRWK9EkStW0Kw7/O1BKFGa14MO29EQnwe4hoF8=
X-Gm-Message-State: AOJu0YxLain/vye+E0WLEvVDhaHYtj6UHu7o8XPodV/IitWwhhrKXkfr
	99mA8SXqWUQTwAQuuA0C4FeG9SpfJEOmWsKHi7ejHBq4g0b7XDZ/
X-Google-Smtp-Source: AGHT+IGjYxkTgAFMYrAOqGcyo3iB+xYZ4rGSdz+l/S/21bkE/VIF1e54TQdkswJKtFRzX8Rafy6TwQ==
X-Received: by 2002:a05:600c:4c15:b0:426:59ec:17a2 with SMTP id 5b1f17b1804b1-42659ec1a4cmr13105125e9.33.1720227033989;
        Fri, 05 Jul 2024 17:50:33 -0700 (PDT)
Received: from localhost.localdomain ([188.74.74.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a54f237bsm3382369f8f.16.2024.07.05.17.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 17:50:33 -0700 (PDT)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: shenghao-ding@ti.com
Cc: 13916275206@139.com,
	baojun.xu@ti.com,
	kevin-lu@ti.com,
	linux-firmware@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	navada@ti.com,
	peeyush@ti.com,
	soyer@irl.hu,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Add dsp firmware for different laptops
Date: Sat,  6 Jul 2024 01:49:43 +0100
Message-ID: <20240706004942.39403-2-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <23e85f35969447ab9161068f2c159845@ti.com>
References: <23e85f35969447ab9161068f2c159845@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up on this again, is the licence correct here? "Allegedly GPLv2+ but no source visible" doesn't sound right for something straight from TI, and it can't be distributed in Debian either (see https://salsa.debian.org/kernel-team/linux/-/merge_requests/1033#note_471478 and https://salsa.debian.org/kernel-team/firmware-nonfree/-/merge_requests/96#note_504454).

Is it supposed to have a binary redistribution licence, such as the licence in LICENCE.ti-tspa (https://gitlab.com/kernel-firmware/linux-firmware/-/blob/main/LICENCE.ti-tspa?ref_type=heads)?

Thanks,
Stuart

