Return-Path: <linux-kernel+bounces-526212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F919A3FBA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7B118877A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E711F3FC3;
	Fri, 21 Feb 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv6UPsjc"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4821F1506
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155695; cv=none; b=jio6NkKlpgEVw+10Np5sNJSzgvAJg4sL0qkKTfLmUWyngbtOq72Qkqr2+QRzoWSFI57a8O0dRbm6o1YWDaSQiWr72u3WA8DweI+PsQZOYoSvUu+j2eaLaZoqhnQ+9mW6O8ikuYOagm/ZjMsJG72Bnqbpn82YTI/NSqBOw+EKPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155695; c=relaxed/simple;
	bh=2nMzOHiGYJvxCYd3jkO6i+jsdS0V2XLFGx4uJLonVOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dAOE9BrvIISWSwCpAiWR2/a5tWuCdfS7RxLuJFo1Olfp6shNHTxqHR0WDcsfouU0vsbAXMb5I9wUpGKtRssgQVCbAeKCDMHbM3AU0ChBQfeTjfrhBnAw1DcgPXAPrAdS8SRuE5j5JZ0qacT8pBy4VZNF8UnGFLggH0nlldao028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jv6UPsjc; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-220c665ef4cso40100345ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740155694; x=1740760494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+IWac3BTppITgPA6stiUSJpAZ3uIjnk1xho+BbeLNeo=;
        b=Jv6UPsjcV0+puKhbUEqUoobPUsfIPjGZQa1Vkziy4HwIK2lVeVb29xD2B4SYJgLD33
         GZ02re9Bo8Of9BThR+SgnVKm5cH2VmFipj2GY39MYjUVEIIrglQRfnZdxyRe12vt700k
         Gr+A8Vklf7NUKy0ck/iZ4lFny7eu8U2dlC6oQu1SS3c1tPhRce2OX8psZh9SN7Mfvqii
         C+HKnku8Hz8v0H0CsE+mv59mq9OcBqZMjcoi0oovUJ2N9pbUp/AvMDTBJYKl++gY6Cdx
         GPr60XfszBRdGgQLXCX9E581SNG9b2hCVTmIe8TMPJyuVhuXDQz4Awl2QA3PyJXp4LcJ
         PCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155694; x=1740760494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IWac3BTppITgPA6stiUSJpAZ3uIjnk1xho+BbeLNeo=;
        b=BGmpptxLXPJ4c4fX3QCPa1n2BF0SR1vOYlITdES4EXpNxrHO4YDSjWXg7I+hKMx+HR
         t1zZp8IjrTXUEMM/dBs3lAUadVMjHAHV2iasv0dH4spoR7vxc6UTl4a0hhRqCqZ1lQ7u
         RDDdNisVqiSblD8Ek7sknvMXFcp0eUKZkVfmt41olyESafcwJ+qWDSGl8c1JuesQqfKg
         23Q8+pQW8xeqRMyYuDHHZxtsA+WgzqawRMVXJBWHKkKmJYwOz8XxCYPASNLNKtNUGURQ
         K9oeOhh7XJQaq9OKs/V3gRFoAldRjcQk5zpAy6dehdATRo0pzz9fA2U0lyhyXskt5G+U
         YEHg==
X-Forwarded-Encrypted: i=1; AJvYcCUxjVP1vmtytVJK0i0xO74pGRuWc6skhyWlpTYZamybkWr+3F8rTrlSQGTBDD2Gv0FX67byUYpl6IPXviE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOw5BknLMY3yi2rPpxtzZnf2/rmdCfUEd5VyD4VJkVCg1ViGGx
	cFMsX2bKBryfSX+Mfedw1uOqIZTttrefTze0so66ImH/efBXfhACyKiO2H75sy8=
X-Gm-Gg: ASbGncvininX/9Vq2VZbSfRqRgj6uAfFZgaiFpSFljan/CShGyii9RkUcgr8XpxijA9
	MXBC37OjL3LEO81OwgSRHqjbCVgcdtqQH+VQie9VT/hq2DmEff7YiRL7wEyvRglL1tPsV73/UZ8
	mdaeQ5p/P3ZvfDuYOhBCDKyWRFMoHOvB1OzhjerLRTBlgU012gM0L/VOTTITtScusJ+xnzAXF7q
	MkPG09gdAPV9rQZfMGou0AF+HzP7ItB8tmDj1EYolJIqAx8sXRvJVBZFkF1a+Qt78MQziiY8gdT
	0D2cMrPDlc9NFtfvj1NCq+YgKkUq/phSq7kY
X-Google-Smtp-Source: AGHT+IGzfe1lVC9rnbfye8PAwJBsN4j0xVxqxOUe/shv2D9rTTcs75+Qv990i8d3bFc0eM1snFDcQQ==
X-Received: by 2002:a17:902:f546:b0:215:8847:435c with SMTP id d9443c01a7336-2219ff9d73cmr63668255ad.12.1740155693511;
        Fri, 21 Feb 2025 08:34:53 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556d6d2sm137213215ad.177.2025.02.21.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:34:53 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH] Cleanup of most_video_dev structure
Date: Fri, 21 Feb 2025 22:04:24 +0530
Message-ID: <20250221163444.57492-1-kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

This patch series removes unused synchronization primitives from
struct most_video_dev.

Ravi Kumar Kairi (2):
  staging: most: Remove unused mutex from most_video_dev
  staging: most: Remove unused spinlock from most_video_dev

 drivers/staging/most/video/video.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
2.48.1


