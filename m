Return-Path: <linux-kernel+bounces-234143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04591C2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F14B20F86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416DC1C6889;
	Fri, 28 Jun 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6yDOwHA"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E9156C67
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589118; cv=none; b=TVOG72BTY4xbLkuCTHewfJDDp038spPPe8gN9ooMcHD+ZtSRtnouT4EQfWH8oq7nmTW+Ix9iF2jTMeqD9BhQN1oGjiC3n/EaM8VNbiXWEhvIltbB2XwFcLHlJFeFtnOUcTFcQJ/kgIu3f0cAG8oBP2WIi9JCyT3Ej+h/2Yria9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589118; c=relaxed/simple;
	bh=uacLHRN5rszX6vIJLri5UjMtNUEcG0qEZrXzdSa1lp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HEyFG16/p5ej50dZW95wUae5vWfnX1PO7QFjQDwKzyir+Ym4zO6LvFdKl5L6DIe4NiABIzsuj0ztpLI5vbGoCidoPVR9ctTgR54QtWYtPApTcgnKaFArJ7Yevsp/livjmvRab4CWeB8p9cN68EJjpYESAget7/tFVRaHU7ONzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6yDOwHA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so1368284276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719589115; x=1720193915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9E6CDkEl8WVKZKqnxjSvSO7qQyb+0+zva6cbAiVPuvs=;
        b=C6yDOwHAgEJvZB3VxEFZoowEhi0mAt0y24HjMN5Ie0db8c/gjrQ8/dTU7T/XCRauO5
         xiMjYuX2316j5Gg92R/w8aS6QroUJkUG1r/csJldlZLz6MjiDnEYSbiIbH4wrgWL1Utt
         uf8MFzac/1da+mkyPFHJDOBwgbtV9DseaglKndYQkAQ26d6o+glkyw4KRmzg0MWq8uQn
         vO7Gohzdpq7c9bRJ2uYiStf+cqHPXC+Cus8hqYeYXqu4IjVHofZbnBlyvlplszUSbJue
         8dUwV58YhVNTd+7Gf8ydjjMU3orvxOWmLEaw409YgA7WPEFXIMi4CJCprI3FdGBK2XPs
         D3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719589115; x=1720193915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9E6CDkEl8WVKZKqnxjSvSO7qQyb+0+zva6cbAiVPuvs=;
        b=EmPc+aT6jx/GAy+dW4MVwH01F3QOczMR79GUvI90CJElzzbJGzpMHYpb2jVXMiW3GW
         JiVBM8oTMcgCaEovzh5qW0hns2D/v0WJlNcLcwWKB/MpVX+wAZvn0xaD991236so3Ytr
         OSOCFKvtKlWdzOkQ+jAXvx5BBk2I4eicC5GV/DA5yGBSUz43J9YDpb6UTjaQidlIOHXo
         pbSjdXDW0hMv5NPFiEYT0/j2zQ6welQUjUfQS0O+0nQYs66jTy6vpWw0HPNgdvuWMwtV
         09R9rFrQOlznCL6+ApnwXbYZQF5NbYFVqVlEF0XOubBgH13rgJUia/efT7f1sX/frK6T
         9ukw==
X-Forwarded-Encrypted: i=1; AJvYcCWNLcsi4f8lpktCh8knLIr+Yn2oFm6LRy1QFgzcgZcONUNnCLK5uNjOwt7YQ5BDj2cV76uKZnBO0TMRTT64a1qJFTxlhvW9xr7a9/7o
X-Gm-Message-State: AOJu0Yx0uKXT/ehd5jjDj8QWBVnzp7CgbE0cOaWSHya3FbQOYfIVaSd4
	lVRgG+0JajLlFxwajMeiCfyc4GVy9IW+z+GXZsm89bQrZQLQAYqxRAXLwPtgnyVlipY0GuodsrE
	26PbuEkabxZQ5dTjWqgN1TQOwzA==
X-Google-Smtp-Source: AGHT+IFbAOblu3KJevq7sqlPwSTEqrm84WW13aJYNyxIrhWTYRRVG7+VxoRMM+Ura64VKD/rC6vfzOSr6fhwJ1JiTyY=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:20c1:b0:de5:3003:4b64 with
 SMTP id 3f1490d57ef6-e0300ee84cbmr86403276.1.1719589115375; Fri, 28 Jun 2024
 08:38:35 -0700 (PDT)
Date: Fri, 28 Jun 2024 15:38:26 +0000
In-Reply-To: <20240624052851.1030799-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624052851.1030799-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628153829.303719-1-aniketmaurya@google.com>
Subject: [PATCH v3 0/3] i3c: dw: Add apb clk
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

These patches add APB clk aka pclk to the dw i3c driver
and the binding doc. Also move to _enabled clk_get APIs.

Changes from v2 to v3
  - moved to _enabled API first and then added apb clk.

Changes from v1 to v2
 - extra example removed from yaml file, minor renaming.
 - 3rd patch added to migrate to *_enabled clk_get APIs. 

Aniket (3):
  dt-bindings: i3c: dw: Add apb clock binding
  i3c: dw: Use new *_enabled clk API
  i3c: dw: Add optional apb clock

 .../bindings/i3c/snps,dw-i3c-master.yaml          | 11 ++++++++++-
 drivers/i3c/master/dw-i3c-master.c                | 15 +++++----------
 drivers/i3c/master/dw-i3c-master.h                |  1 +
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


