Return-Path: <linux-kernel+bounces-354136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42BF993838
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B62851CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6941DE881;
	Mon,  7 Oct 2024 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+diFQvM"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FFB1DE4DC;
	Mon,  7 Oct 2024 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332939; cv=none; b=RBPbAGRStJ4qlSmOW+FEi8X+cIHoEmABx8KD4ySpAmpuBoWIUBP8iJgkG7RY7CuLQo7as1D2STO5Aqu0p8uZ9Ekq2Bh5YNBR8KyM81fA8Cagpf5ZwN9WPx4QD5a2W4oP23hVwL43FH2ySDdbJCUOpxnEwEVVbgRz4EfTBB7e53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332939; c=relaxed/simple;
	bh=zGp82aDdBTl8nQ0hxOKwRGktCJBiwmIH54yrEdNiXrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lI+52XCUWS7NY8YXjYRh4f4/h7y87Ue4OjudzZpKIGOSUYpbPbRFNh4tIxOtOn0HVMg2LTaOtP7o6mM3VcYsXHw0Cc0EeOqerz7l1smMgmJHtNAMoURRvbSrp20XvLhd+2xlMXWH5AzCu5gjQXGvsDLwe95FB079jq093Qp6PGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+diFQvM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so5512725e87.1;
        Mon, 07 Oct 2024 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728332936; x=1728937736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/swLSWTF4iJWamyLw6elDpleC9X1KXIhrQrOEtkG/YM=;
        b=Z+diFQvMm8E8JpQoKvnGKuJWz6fRGZgBuuqd8pEa0orJq0emJZzOHiAQb1I6/AuYJj
         mwJBN7PLe5bdzmKa3sqqvMjQaguHV5oijqr6+TovaRZXJvN5kx0Dpg7tuhTofNP16ik7
         iSHqyFvi/EuD/HY5Tkk1xojQO9APB/6HocWnJgyLXiEJhTaIfBXYINHNNe+F26pl3WfA
         rZundFQBiOJuojL33MNJ03qOYwu4CNzH32zj6n9fPyDzNLKxcCV0+VkJoiaybiH6enFD
         k5aPBfPyOzFNVeC69bt5HAdprOBVPceX7FuG1DeS2fsJoeEOw/Ci1zhrWILHWA+xMqwT
         z9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332936; x=1728937736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/swLSWTF4iJWamyLw6elDpleC9X1KXIhrQrOEtkG/YM=;
        b=uxLOcfsaccN1VTcMKSJ4ZtgOiFi829fi1i0RH87VVKb28FPXR5jlQQGyTiY42Hd5oh
         yisWOeNqMbziSVTdf4Z5bJdbG4f4DEFzYPFHlqF6EQfFKk5VfRgx6S09g4xP32TkIb1w
         xF/prJ8bpFPpE5Saq+AdWSx8uoal9QeI9+Boydcqz/RDJ3kxhDT6x1ax6m/hVixErpTM
         IdZta23taeKXuaWuRcJCwVYUyeArCp50u2onGMXu7rME3dbry2bCJdka2yOhL6miRGEg
         xfqW8897Abc3Bk3C6eZE2E+7By9rQUZHPjswv29zopSy4WyCs9Sg848qVFCQy7VxPcNf
         6srg==
X-Forwarded-Encrypted: i=1; AJvYcCXwZp6GDInEY1XjMAAWZK4KyS2mZnPvgh7ACzCjGP0O33XDv8eoQkY/8ZAMS2/WVkKjwQHpjiff3/Pwh+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2DyUNnfx+9TgiwifdmgvJtVIUgZ1KP7gkqZgE5hKfzyms2gv
	GTbraRasZqisBLa0gMK533CynM5v29WCAd8fNyr0B0SsNmrPuoNypmZwTUvW
X-Google-Smtp-Source: AGHT+IFyKhhIP1f621UlqO7qIWH4iUb5LTXEIT7+xAeQkaVkv3y/7wfDgMXAGOor343/qGv7JI4Q5w==
X-Received: by 2002:a05:6512:3b90:b0:52c:e17c:3741 with SMTP id 2adb3069b0e04-539ab84a281mr6788898e87.5.1728332935414;
        Mon, 07 Oct 2024 13:28:55 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23307sm926237e87.197.2024.10.07.13.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:28:54 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com
Subject: rust: page: Add support for vmalloc_to_page
Date: Mon,  7 Oct 2024 23:27:49 +0300
Message-Id: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series aims to add support for pages that are not allocated by an instance of the Page
abstraction, specifically those returned by vmalloc_to_page().

This patch series is sent in the context of developing a Nova driver WIP feature where we
load the the GSP firmware into an sg table [1].

[1] https://gitlab.freedesktop.org/abj/nova-drm

Abdiel Janulgue (3):
  rust: page: replace the page pointer wrapper with Opaque
  rust: page: Extend support to vmalloc_to_page
  rust: page: Add page_slice_to_page

 rust/kernel/page.rs | 111 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 9 deletions(-)


base-commit: 673d1648244c3840043e09a784164b38c2e2efb9
-- 
2.34.1



