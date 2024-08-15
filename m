Return-Path: <linux-kernel+bounces-288334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABFC9538F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E81F262BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869CD1BC088;
	Thu, 15 Aug 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v1qQUl4Q"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0962D1B9B4F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742542; cv=none; b=rCd/ju/b1tktXCgVF5CeWFPU9urJn45zTKeOe2f6tSFbtiCG6V5XHQb8a/2SuQv9hLFVomDrZHfkceqhLnZpAHuP7QpwUK0pOOehWNh9DrtvNwcnCBuoIrCGJjPEUTY/hm+pB8UU+vrZsny/VdLy2wkKWIRB+MnoZ+W6zrR1FAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742542; c=relaxed/simple;
	bh=lQl5PN38ewp8fP1d10oMgjM61q8VF9A8RDMBz1cBMrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjX01sjh56kCb5ud2HaT5eNIfWmQ2/cLwBHtCPE4Uu6mzoQJVttv+Fdj+Rs1Mqv2DQPNQPqm8BmPAWSBp3of48AA2USPgx9EQ3tRczUMjSMGiw99KLmPcKjFrAO0pXcGRzlgsLLclCHVu86aI82c+UN7LScwJeNGBvw+51yFF00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v1qQUl4Q; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-26827ec5235so854360fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723742540; x=1724347340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRorKE+dqmoV40ZY8LVTmZRhjf2w7HVyyAsDfTVj74s=;
        b=v1qQUl4Q+4nO7yjyt/2gs4BX6QsGdE3VqxKMQf+G1as6/R0M46STElifYqkrtM2uH6
         6cKuoCwWomGTu9HxCcx0QATP9zDfPmGwN+I5DyTkEtNrwo+TwtnTdxhquc2Psky9a4Wr
         ZJKJJ8WERcCPCzgi2kSMIYWIZB/UIbutNKFwEYYbHF/ANq7Ri2IvfII7sOrHU2dI8/xh
         6QflOp+Qd6qpcLKw+zQwRy7ztN3vCWHxHLPOgJ+/p3XhosPda/A2k5JJcjeO8L81TpZS
         u56rjxQ70ULxSANLgspUhtWp/YnVGtB8D63IhegssZOrg5tpSOq00leeF3s7u4ncsYkA
         VUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742540; x=1724347340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRorKE+dqmoV40ZY8LVTmZRhjf2w7HVyyAsDfTVj74s=;
        b=GYYsA91yASygfUmwr/Jl9Cn61yu5ZNQEGzL4dtVqcDIYzY0G+OwI+F1BGZFCmB/uiZ
         VyCyVLcxRP9J0u9kdZmoovxN/KGI0wf7cp5sevtyttsMM4F+ABUAD/2RDNA25dmYPFCg
         LmRQIqhi6pe3irO9clJlTTnd77o9KOlLmJUyVJ7UTEiebfx3kwM2M+GKAIBr+Sq1McTa
         QiH4EXpvbVKRZeh9OlfatGwIRnzPnB1ogAO/uc8Z35HWo/WXPnm3VEJd+kKX6m3sCWqX
         +SY2VTKq3RTbH5x4p1zU5CDJ9vowJuQC5t3eZlKh6V4wktRd1xziKmTRnlY+YIcG7ZLB
         RMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2WU/zH8kDUrJkfwsDYk8SbGlnoP1CJR0f6NRTBPEhxnKMZAIVZgvR8os8PwUgAQCbqVzRpIbHY5kRyPL1CTbZ37R78eG/up3LuBYK
X-Gm-Message-State: AOJu0Yw6dkndQqn1SMz7KYe8r+N5kbgfdGrTQ1BcxVeTPUrMIqPi4Lae
	vDCN3s2VmeuV8LaPA62EGPRlHXKw3TkAx/P/td9PccN66aFs546YS63cr0E8gWE=
X-Google-Smtp-Source: AGHT+IFP978w/cZSnGt6qU9S3P11ASgJOMMtA752yMQZk71k8mAgRCA60iGjdtUWn2ku0TUWqrn6Ag==
X-Received: by 2002:a05:6870:31c2:b0:25d:4f3c:c072 with SMTP id 586e51a60fabf-2701c380feemr213947fac.17.1723742540116;
        Thu, 15 Aug 2024 10:22:20 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca66297d0sm345327a34.68.2024.08.15.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:22:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] iio: ABI: add missing calibscale attributes
Date: Thu, 15 Aug 2024 12:22:12 -0500
Message-ID: <20240815-iio-abi-calib-audit-v1-3-536b2fea8620@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
References: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

This adds additional calibscale attributes to the ABI documentation for
instances found in drivers by searching the code for:

    BIT(IIO_CHAN_INFO_CALIBSCALE)

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 401e0a595aba..da8096b04e14 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -556,8 +556,15 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitance_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_both_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_ir_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
@@ -568,6 +575,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_calibscale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:

-- 
2.43.0


