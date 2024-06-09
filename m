Return-Path: <linux-kernel+bounces-207499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94086901815
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2090E280CA4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 20:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF24D8DB;
	Sun,  9 Jun 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1a6zNhyc"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BEE1DDCE
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717963587; cv=none; b=Q5lxK65w0by7VaykfUipYqvzvgGX+ooNrt6qPEySMoSBseSlmw713akO6ybXHuX5Pn/6uxDWCa0zMDhqxQKBXi3rjtwX3E0jYgjKTdVJ6K4EuWizTAD1lukYjO3LzuyXUA/sB/s8wopITq+1ZfEqIYp5LOQUfxd2JVImbOWfWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717963587; c=relaxed/simple;
	bh=dV0HafcF6PMMuqh10cvuAZ5X5KeoDQVswsNpvA2TdBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FVTOlVb48bjw3wirpEttR9DU5BtHb4afKhytBhfNcIHcI5c2W4LI7zm6fOSEeY/gdXfyS7QvMPzTjJe5WjNO7pqzOwbsVtVYfYLmr7CI/HPz39RcT3qmGI/F/DmsnTrIk4o/Z67QGD4RVr1xREjc5DLMnhNfQQWrsSKnXe8tKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1a6zNhyc; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ba70a0ed75so2188625eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717963583; x=1718568383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bCgjLGIvHnJpxhOHdQz2TYeCVliZVrQ6mIgWxXIdyLs=;
        b=1a6zNhycUCk4Pm+crqSjzPj6QkekJqLEAe8Y0hZyr+uSVtw7bozT22Ki5S5Oh5bDtr
         0vsHEczt6RqNFysHDTtMVT61xVIEtuiJYwpwwPxl6/ZdCVUE32kDY9ffo1gN1WHcVwOv
         r3JHfvAkU6TNghhEkytO6L7dib93Saw3eiSnBeAA7OBjhEo6P0FhcDcWPmY97Xp8Abpb
         I0uPQi7VP+oNBzsqttsGoFJROOrDdpCSgAc0n2mJwhBS0ub27g6w5NWP59+Il/zXLoRj
         gnOxBaTYw+npvRP+ZvgfpyeCn120hJxzva7SBd0yblpnT/M3O6y0f4kzGp5hivUCQ0Um
         fZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717963583; x=1718568383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCgjLGIvHnJpxhOHdQz2TYeCVliZVrQ6mIgWxXIdyLs=;
        b=lHMVQ9wBrDjYtnnmA/jwUpaMlKN7yiqL4yC4FhG7ht4nZZmqbG+d8IbiMYFMSlpyZ1
         ypHBAOBULOvR6o+skaRQkgG7Rw/nf8ngq9UrbtRllRzpQEgFPcZy2/zKKF+5S1yktp3D
         FyYVJhH/aFCwW/Ap5ZziLvVFYRopgKEJt803IAEmsexyJPg+2Prqi0UFSS/ML9gdA9gI
         TeDTZqUBF8Gc8wSBicqSrditkbwM/18IlszfDUAjNEaV4mzMqtExnc7Gp9xhhwMlAZrm
         twvLcJmvql30cfagR6q16kHA580RxEfIjiOW71iXHkb66MlfKscvodFyldedi8zmGxYg
         Aq+A==
X-Forwarded-Encrypted: i=1; AJvYcCWLPA3vN0Kz7vNseM1Vy1Utw/jOmnVnnxuP9dkZjoYy7Rdi9x9yh/RJyNeITrM/lCqfG8Xc5VJ6AE2xWWlLB0N9bBi6R5XuWdlFn0ZA
X-Gm-Message-State: AOJu0YxP2MKaI7/92qbM0XAMdaVKFzBZ4iHGW2hOSEAUAAunr707J3C6
	eETDw9gS2Oyv3Vm/XXOOOGHe0yZPtz7SO3Xxe5W1Eughg9l9ydGS6/k1dJk2pW0=
X-Google-Smtp-Source: AGHT+IGUcR9xqr3+AxBdyVQ8ar8tP10gwQFPrDJQGF+erJK+HZxWPREAfdHRAmFKf7QcyMjOjK3RfA==
X-Received: by 2002:a4a:dc95:0:b0:5ba:bb77:bf51 with SMTP id 006d021491bc7-5babb77c5dfmr6153154eaf.2.1717963582922;
        Sun, 09 Jun 2024 13:06:22 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba977e121bsm1413278eaf.28.2024.06.09.13.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:06:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] counter: ti-eqep: small cleanups
Date: Sun,  9 Jun 2024 15:06:14 -0500
Message-ID: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Judith got me looking at this driver again, so I noticed a few small
things that could be cleaned up.

---
David Lechner (2):
      counter: ti-eqep: remove unused struct member
      counter: ti-eqep: remove counter_priv() wrapper

 drivers/counter/ti-eqep.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)
---
base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
change-id: 20240609-ti-eqep-cleanup-254e6ba1e386

