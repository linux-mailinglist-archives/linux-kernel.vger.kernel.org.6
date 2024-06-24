Return-Path: <linux-kernel+bounces-226667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B031B9141EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13221C22940
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2D717BCC;
	Mon, 24 Jun 2024 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQdFP/Sk"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463017BA7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206943; cv=none; b=iWsOWu/HLcE+Bpwe4E3i19qjIt9O3co+tGpLHCwB8OT4Kn4iTkH0+gTHzKAJL/f+2SKcfa5ZWfJadLYgrv8VclIIaa4uYfdoODDunvEUAzoMyHtyp5knnxf1uR5CFOELnmORBgXiPhJ+jJet2loKdgiKQAjOfM7/MPvvLZlBzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206943; c=relaxed/simple;
	bh=0+fyQK71jkBlGLbSI/zi67aQXYcSRdX3nV9zuMy/sn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPtmnMtPa+h66rNWm88Gpn4oMtKC/e9hOW0mIjpWx1wIMq1tS0hGgw6MuP6jJFTwkY+DLqZ6FhD2WxyqVXRDbjpxGFdsr6vHLULbPoOkvO338AQZaFjHdfygZODVozPAkPvfrFnAQIT0869Qjm0kcXd4hgZpRI40VRWvo7YRn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQdFP/Sk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-630be5053caso55869637b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719206941; x=1719811741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4tc+MA3MrEgfJuTL6XyEK1sgKVL7uhnnRi/knhicvs=;
        b=TQdFP/SkPrXkpWdcN5zUpDEGealyOwB0xYjD1dGTS/4AlAP3znZrz8SSKcudIzqeax
         4AHaoMPHBupytvTmcowXDPipw8CqiKiN2BmBmvGdmXNeD1mWILoSzBhVyd/Jbg73Sj9T
         5+CfSYeTYQBbAPX3exF7R4boC3iCr2NCjvrHAMKs4YZsKLdXF5wqQQVyktd/b9lw7Yvr
         GPOA9HSk0DR47HErpDkhjebdAWBH4LaOOAwlIcl6seYmHbqCgqP5VolrZtGRgRAIYGpb
         5Y21oN7GzbJUlhoba5rd9lUUI3bWn1u3GjdEuTlPkD+uCr2ieE//tRom2O7g3kn7LP7m
         g0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719206941; x=1719811741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4tc+MA3MrEgfJuTL6XyEK1sgKVL7uhnnRi/knhicvs=;
        b=OnH0L75vTgHNBrMW9o68v7UzLwM5s7MyJac2DeO2hjF0wEfBhOYsyFY0EAgECkjuca
         BzDsEKpAF8vpZfnTilrlW97zmZST8pcvrf9hURgWVCP/XcFClEETjhL0MDA1v1m2EQjX
         OvXWL0UKZ6bNqEyXW1dBVF0zsOZsnxzbMUN6bjjBcRqIshkG6o4/jo1WgqLGmCtas4jP
         HgaXSkAJeYX+OPbw3XeCj2k8JiY2xTuUzABnf3WdBnpSx5LSaEFc/2Gn0obppNZkMY26
         j0eItuCneHwIJoFmwT+VGMumghUCkOXBACpufDB+vj6lGrHhqmTFw6kL3ye1DcJxDdyt
         jj/A==
X-Forwarded-Encrypted: i=1; AJvYcCUuHk/qAawunx/xR/JeMY+fHjO2yWCvjyjlDIuZO77otUYWjHZVDZB1P8f4FUCvHSHpotNCSgOLwqxdDchsthYaixUbaLk30msXxQ2E
X-Gm-Message-State: AOJu0YxHjVCt/pW+ww1ZJ++7BAIyxgxYS3pstv0i0MO4aL3wnzJih2n5
	3P3Xo1lAlOyhc0DjmZ28n+nEom4zxrS2K4kif+ruHpbDV9Q1XAgvKWlHd1qIr3dE3SJ2cJthluh
	h0sCTL2gIpqQ3xOAVcl2X5sC/tQ==
X-Google-Smtp-Source: AGHT+IGUgV5rE7AVWD7sfm4jkV4ITjzyYp8qAWL+Hn5XiyhVcilJx1WZCNrB1TylF/AIQIHyiuXzZGueB4wXgIgApaY=
X-Received: from aniketm.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3387])
 (user=aniketmaurya job=sendgmr) by 2002:a05:6902:2d03:b0:dfd:da3f:ad1c with
 SMTP id 3f1490d57ef6-e02fa3aa814mr386252276.4.1719206941209; Sun, 23 Jun 2024
 22:29:01 -0700 (PDT)
Date: Mon, 24 Jun 2024 05:28:48 +0000
In-Reply-To: <20240611171600.1105124-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611171600.1105124-1-aniketmaurya@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624052851.1030799-1-aniketmaurya@google.com>
Subject: [PATCH v2 0/3] i3c: dw: Add apb clk
From: Aniket <aniketmaurya@google.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

These patches add APB clk aka pclk to the dw i3c driver
and the binding doc. Also move to _enabled clk_get APIs.

Aniket (3):
  dt-bindings: i3c: dw: Add apb clock binding
  i3c: dw: Add optional apb clock
  i3c: dw: Use new *_enabled clk APIs

 .../bindings/i3c/snps,dw-i3c-master.yaml          | 11 ++++++++++-
 drivers/i3c/master/dw-i3c-master.c                | 15 +++++----------
 drivers/i3c/master/dw-i3c-master.h                |  1 +
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog


