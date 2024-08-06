Return-Path: <linux-kernel+bounces-276494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3094948E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955241F25B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7576D29422;
	Tue,  6 Aug 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOENyDJQ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2517BD9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958199; cv=none; b=obdH9ogdpD28eZjPW2gYMNwGOIDzbEbXFuS2EjKsMipditpcwLaaOu6X6rAY4wTAeoUPn8BulYESSXmNyRgJMZ5Djkem6SfHECTsnVjlZp39w6Ia545ry6fY7gYWj4TRMV31eTWMPBZsxe5feOj+uf8LDYT9Xs+2Myf2ceCEuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958199; c=relaxed/simple;
	bh=fv3k8stKYzTS9UIEU0lpQcQQUZi9Zykq6iQUOmCKotg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q33457f3dpFlulniMoyCrJ/DLv3Uc4KRafYstrfL57gKva9Z2nLfFY1r/14ckmHAEaCNLVRXZVjaHk0yiBfWHU9cJl1N1A26Ic+nRMO6SvPb8+rxVrAEk9x60jV9bwPB5XoQyxjXuGuAuJDPODOZJ7S0m4gs1+jM22k82kPaGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOENyDJQ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso12908391fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722958196; x=1723562996; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tprBLK1iiveUCYg/AarvtiLLOVA4FPbpWQNyejze9a8=;
        b=AOENyDJQT9RsnmqkYhSmNjqbmoIPl2GreifPvxDRVZqWItvYwuvAFg5azGunEwqyva
         FozNoYBlhoQYmPVKOq/eVmqP0fzqbmV++lcjBCu6kbU14P5yFNK1jwfF+w8AGJ8QG6DW
         cKkbJjbe4WNrFFps3peFbI8L3B2zfGlN5kKfTB7Q8Z0WLvDo0m0AEasN5Nkl3DgooB+4
         m9sOolWq21P/FeT61GBme75ZmvQ58+w5hRGSvPrZUrlbVavVecO88uYujGZTeJJCJPzJ
         sF1fj9a3PRaUVmOQRMJxU0ji08IKvpOMbMP9mEhvqjLpJd9RW4EeRJmw0GKZeI7vbj1f
         vXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958196; x=1723562996;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tprBLK1iiveUCYg/AarvtiLLOVA4FPbpWQNyejze9a8=;
        b=xO+yVD9UW51fa7KvzIJrRy0CX7LWYqhOxC04CjtXiyanGp+FgxsolteICZQGAIHckV
         sUnHpZ5yi6SriZvp0ajHeZ8GOLUUtD5L5pqS6Cu5uYD8zDNzDkgFjxCm1i2oqgwWGkXN
         x3Q0j0eOsIbPhEzJJy3d1ArR276Wae7l6OQFRN4wI9KxjUA9F9PtZvevYPFKnOPN2lTg
         O4TzdKQSECS6wkuTRHXkVKu0JXbp4ybuayR9bISjzRR0N+ME6xI8JjbIUMPcH3bk+e4z
         TQa9zbSooKqWAaiw55y+enpQQRhQB4uXM+QGgTD5C6gvqGQYTdarvaOHN9qvRENnoGU7
         syCA==
X-Forwarded-Encrypted: i=1; AJvYcCWvHfWgPRpcgOQr9U39MP4y5xqW682B23QR9KDyp0AQ6HwVrlBhcfmDGHlRN38Re2DtG03cb6294UP1ioAAEzHsHNJyr9X41+euNTjc
X-Gm-Message-State: AOJu0Yz8OtKsUsVyyw+biPtOnBjfxtgzIGjj0r0CbuITukR+s6E5lDiF
	EIhHmmT94/w/2lUssDs4/pborkyyCwOUMg2HTUJMGAD2z8p4e8tOqks58GItgTY=
X-Google-Smtp-Source: AGHT+IHRZmLaStmO8UYKkVKFqiPyc0B8sPefyyWX408Vg/RWnhXs/VBIaM9S0t9/2UoAAbzROa8OcA==
X-Received: by 2002:a2e:9cc9:0:b0:2ef:1c0f:a0f3 with SMTP id 38308e7fff4ca-2f15aa88b76mr125008231fa.6.1722958195923;
        Tue, 06 Aug 2024 08:29:55 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4294fsm555274266b.103.2024.08.06.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:29:55 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/2] tty: serial: samsung_tty: simple cleanups
Date: Tue, 06 Aug 2024 16:29:44 +0100
Message-Id: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGlBsmYC/x3MwQpAQBCA4VfRnE3tbkheRQ4Ts0yxtINI3t3m+
 B3+/wHlKKzQZA9EPkVlDQk2z6CfKIyMMiSDM64wtalQadEjjLjvN/YzUzg29J7YlrYkVxeQyi2
 yl+u/tt37fnhqy7ZlAAAA
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

While looking through the samsung tty driver, I've spotted a few things that
can be simplified by removing unused function arguments and by avoiding some
duplicated variables and casting.

There are no functional changes here.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (2):
      tty: serial: samsung_tty: drop unused argument to irq handlers
      tty: serial: samsung_tty: cast the interrupt's void *id just once

 drivers/tty/serial/samsung_tty.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)
---
base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
change-id: 20240806-samsung-tty-cleanup-ffae1515a284

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


