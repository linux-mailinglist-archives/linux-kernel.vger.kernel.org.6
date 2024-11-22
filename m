Return-Path: <linux-kernel+bounces-418612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA39D6373
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11B1287A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92611DFDAD;
	Fri, 22 Nov 2024 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ib3eqHXi"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD21607AB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297374; cv=none; b=Sdx+H4BpdVsTOphJk/qESErrQBJ4ZobBkdmNbufZ00WoeS20xBTav9gmNzCLvo8QKDKwFKpIQCNVJDTiFbadl1SL8gJ37QOwmFSb08wDeI6jho1cdjqNGiMBVVSWvJO366XhijHkPzFwkweiRrEjzYIzCSSXY18MvGQr2Vk+00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297374; c=relaxed/simple;
	bh=eKyvRR8qmIXJGqCoV3OEYHsTxVk2cZZJeAxKAchNSTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oyU/nJF/N7v71e5GRVSyF388NegRc9VbugUSqpoDhAkGxIi/eRPvFyBP2KuMEkgKIaZonUjLjf3lHAUfx9YyNzZJFSQoVi1XTE+n36UWxV11GOaumidHZL3dOxsWbyTt6LVc7H6sc8lYUCnFWghgFWB/GuEQQ1zO3VsZj1+zm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ib3eqHXi; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e612437c09so1452158b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732297371; x=1732902171; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Um2hT3kFq+soHaE5X1XflsUeLzBKxyA/p1C27ZLrq0=;
        b=Ib3eqHXik6b1jBbYnZAHPMfqaAFNjTDnf3LvwPJ1PWWzaYB5GKmbtEPQSJQ/EYtDaD
         odzSgzn8I7u5sMGCWHXpCGKIuwI7LQRgmN33zbmeTM6OBqjMlLJuZOZt1UhIKSvjB+MD
         Z3azWLybrhN048z3KW69kZsLPMKiup3Gia+JvhAEFODQNAnpgf7nqykyU8B/VYUlkuDH
         r/SE+XPU/YNkoKzq7hBnPCvSrpWc+Auj3NItWGVRM6BhY3ttBt/pt0vVfXLCgvY6lYui
         uh6WAySU4DUF0LjdC9u4s5DFNtPSm6O4RoTJtNs2k2mh8V36xDyzeM64PJ0cDDk0/amP
         mCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297371; x=1732902171;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Um2hT3kFq+soHaE5X1XflsUeLzBKxyA/p1C27ZLrq0=;
        b=hQwYi5z3xF8tpkwFA9MOxV7Sd0YxOAU+i3oXVmn95vT1opf1Arg2RwsDX1LfLUk/NF
         4mDsQls4+W4bOpsCrG7wlP5hUZ25tdDLmY1+M1svWHT3kcLjKmreaexH6NHGa1UKAHQx
         IaOVD9uZBsLk4IJidGEiAQByqN4qeb9k/qv5+Xh1MqKGFmu5qO7NQDyTOJWeCYjp3XY6
         ZfLhGMR/WgIyZALFs6JTE663y/wU56TdatqEH5KE04e5TAB+Qk5RRk3y0l17gfRfg1vB
         1PPocHsxOVwiIqTvLh3ENGVtdY1DGtkAheem/G3XOdvBUBsnT43dbQfaSh9gM7eibQAO
         5qjw==
X-Forwarded-Encrypted: i=1; AJvYcCVvxQHaN/PVUcZEcPSCrjhXi/Bhsp77LD7Ang5dZpibYBGAkBxWxkcrPoqreGGMS+EpQlc69aXno/yHbak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhQ39o0S2+5hBq/0EhFxTPQNTkFesczR617lJL/Wl3nX3Poqb
	fewa6nc3OWWqi+ZUatcoyuLO4cdN7tbFyvP9MMABxXPkkj0sQ9aCFQN6yv5BvbaiY3m4xZoY/+K
	Z
X-Gm-Gg: ASbGncslMsyYusJo330EJzdpbhOynO70kGg8xqTy6Oyj3yZw39LPzgvrJgucHFCveOc
	48GuyiF6fzOnu7tOLuIFlfAcqgzrQsxWHiz+Tf9cVSMXxQ+TvHBwUV6lXqAtU9KLzLEXM+S0+k3
	raeAxlfMf5Mp4JHw9u7otHUaRuO5yG9VIKWpzRQ6nA63HN6yCvXZ8QWUj8YD3gdAh9q5pMp4s38
	lN8lV44vw3X7Cvd1t7g1QDPL/baJcZFrCM3L28iFJdWFWC2vaJz41ZsgKKaReHGidpp2WOVFJX8
	5Eftig==
X-Google-Smtp-Source: AGHT+IF4XKHXIAUncfA5T8WPmI6EvAz8ghg0mf7E8F45FWNwiH6q4kjk7athXN/kygbcQaeReyAz2Q==
X-Received: by 2002:a05:6808:e8c:b0:3e6:773:c99e with SMTP id 5614622812f47-3e915878247mr3786611b6e.21.1732297371333;
        Fri, 22 Nov 2024 09:42:51 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e914e5ab31sm487450b6e.9.2024.11.22.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:42:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 22 Nov 2024 11:42:48 -0600
Subject: [PATCH] iio: adc: ad_sigma_delta: add tab to align irq_line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-iio-adc-ad_signal_delta-fix-align-v1-1-d0a071d2dc83@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJfCQGcC/x2NwQqDQAxEf0VyNuBGKbS/UkTSTWoDyyq7IgXx3
 w0e5vDmwcwBVYtphVdzQNHdqi3ZIbQNxB/nWdHEGaijIQQiNFuQJXqmanPmNImmjfFrf+TkDZI
 SPeURu14+4DtrUZf3x3s8zwsWAkg5cwAAAA==
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Align the irq_line field in struct ad_sigma_delta with the other fields.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/adc/ad_sigma_delta.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index f8c1d2505940..1851f8fed3a4 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -96,7 +96,7 @@ struct ad_sigma_delta {
 	unsigned int		active_slots;
 	unsigned int		current_slot;
 	unsigned int		num_slots;
-	int		irq_line;
+	int			irq_line;
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
 	unsigned int		*slots;

---
base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
change-id: 20241122-iio-adc-ad_signal_delta-fix-align-2e229d6c03db

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


