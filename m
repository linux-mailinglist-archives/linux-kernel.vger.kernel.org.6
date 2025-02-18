Return-Path: <linux-kernel+bounces-520624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB11A3AC71
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9EC7A556B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4571DDC22;
	Tue, 18 Feb 2025 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c+vgxgop"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6331A8F6D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920675; cv=none; b=uEFspeVRLArELq3F0lWIgjrGlvzeMl+W6lyeVBkypZwMnk3ShgZYqlJvdnhi4s8T2XFv5j4whjy7ZZX//Ofl1QfR8ELOCd5f1bwcl4fVRiZ1kI3teKQX+u787lxE1apAc9Bm2zHyVs570q2S6N0c7xnTiFhdA8LffXTlVaRTWdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920675; c=relaxed/simple;
	bh=YtP9jMp1zsEuMGXw+pRfgayF/lnTYJWTTdsWP3y71BU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UO6oH0cww1xW506xj9IavyMnOixWA6FjajYjVf1mjrdp6DQvWk9FitdoYLH7eHWXopXLVh49kIuToyVUSvyQnoNhnMk+XtKt+m9dNSZKBG3dflppf1auO3Qx/fRg8TIMVrJGnM9HIqNNlZM2WV9rbFCEA5ao/QxPNN5Q28U2i7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c+vgxgop; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-727250dbf60so180076a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739920672; x=1740525472; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1kVy79PjjwS9vT6eqX/jn2fuQOg4ncGF32yCLYKYdc=;
        b=c+vgxgopCtJw1KDe23QVBN3XYKS+rIVz7XSU4XDgZt/qJpTeGYWdnKmHJbF0YiNSV9
         XaYRGHvrfvj107DsldUEmTME0vK95PJWOl6XP2E2+W4+zG+WQcyH7x8q83Gcuo02Qckw
         2PCuvQTgFq90HJIp3m+H2mN4NWqsQokk18CcvVuFiGBSRb5rRtn8FgPKX+9OwMqEwR4J
         b8GbOKmZtjrtYaeFWbjLljwa4L0S94tH66vTZySzeTe0+j61b9KSJQROzbP4NhJFnB8L
         P6Kau9UYc+dWOo7EDKniSqATiBVmsEcEOk+sOl8UaBVnsnZ/WoNcGYRXRv3SCSAKLfmE
         MnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739920672; x=1740525472;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1kVy79PjjwS9vT6eqX/jn2fuQOg4ncGF32yCLYKYdc=;
        b=lUXKxvq/VUe87k5c02gno1m7R4s78iA4aqNA/6sFlcwgdclC2+FaVK132/UWO3THLf
         J9q0dETwW82hluu/etGSEps5YTTooe97boq95/nCuXJt1NUPy3WS3BRR6x7tuRmRFDF/
         Gspbg0gVcizeBuMwHXuBjtXDujPiTUcQuD8v0YW1mODvNx5JmDXOxlHYzRGYeTixYpTb
         7t73ssdUfotqzakLHzACfhK1M8jpJiyLX5N4w9OabRpXS4+dT6TVFQlIH0npf2nZY+RH
         fnn4O4Xxzqcxhnxlhx9T4zC0vFAiz7N7vVdwx5C+FNAyDVX3KcCBbjze/ycVcf4pO3+E
         mcdA==
X-Forwarded-Encrypted: i=1; AJvYcCVKwgaVCkUYHQmcIQWgR1FmRIzwKQ5o4GDQtE3GhHTd4jbl6TEI6gQlSsYmFgD5PvtRCPAAHyKbjwrn27g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDF6iC57MTOfl0TFvmQ4yy2IaY5JVlunfnrU5cmkX/bh3/cY/Z
	9lYxh2To2YF73Yh5XIAt0LCuzUHiFcSwBmJoA0b9LjHAPdCDEEieFz7USS/mljU=
X-Gm-Gg: ASbGncvW9BgwijWN1EfoHESAb8im1WoaI214I5tX7qkTslCIlhuM7kynHA2Q5suKE7C
	e/ZyudghnyRmfX7VKDqHDZzE2Do9tB3CJUVK7IRMwSdhntCQ6dOZy7AsJee4u8FRKfuJzDLI4Pu
	QzClQppWabgWazGbnOccvISfxioByhdj1dCK9FrINhkd/Sq9IHR7gMyw7tb5srR8SHG5KvZTZms
	EUHZphiOtkkyWZ1zz3Sumy1a1vtnr6GNNCk8PSiptNslXoiAnXwj9WTiYjHPMQo5YbEuF7bIZR+
	mdimgFv6ZmIK9xEkKjJzde/U/8A2TMypEIEH2/V+MWWQ+Rg=
X-Google-Smtp-Source: AGHT+IF2i0XRfyPdA91wJLKRW1188YEW171fIRsR6f4XJDZE0cMHbi74c3siOXWTxamWwIe6ApxsEg==
X-Received: by 2002:a9d:7482:0:b0:727:2731:d5e5 with SMTP id 46e09a7af769-7273711f98bmr1287196a34.12.1739920672122;
        Tue, 18 Feb 2025 15:17:52 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7271f7c5ba8sm1803129a34.32.2025.02.18.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 15:17:51 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ad4695: fix out of bounds array access
Date: Tue, 18 Feb 2025 17:17:44 -0600
Message-Id: <20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-v1-0-57fef8c7a3fd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABgVtWcC/x2NSw7CMAwFr1J5jaUmtOVzFdRF4jjgTYLiFhVVv
 TsWi1nMYt7bQbkJK9y7HRp/RKUWE3fqgF6hPBklmYPv/dh7d0WRiiGRMUy3EbNsWNcFa8ZY15I
 UQ2vhi4GIVfGS3cSRzpHdALb5bmzF/+8xH8cPtGI/WH8AAAA=
X-Change-ID: 20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-7f16ebc3be14
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Trevor Gamblin <tgamblin@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

I was doing some more testing and found a bug with the
in_temp_sampling_frequency attribute being corrupted. This is a patch
to fix that, plus a bonus patch that cleans up some related code (it
wasn't strictly part of the fix, hence the separate patch).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (2):
      iio: adc: ad4695: fix out of bounds array access
      iio: adc: ad4695: simplify getting oversampling_ratio

 drivers/iio/adc/ad4695.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)
---
base-commit: ac856912f210bcff6a1cf8cf9cb2f6a1dfe85798
change-id: 20250218-iio-adc-ad4695-fix-out-of-bounds-array-access-7f16ebc3be14

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


