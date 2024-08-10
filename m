Return-Path: <linux-kernel+bounces-281749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439CE94DAC6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 06:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB59B1F22349
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 04:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9913B79F;
	Sat, 10 Aug 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6D6+Rw4"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE987322A
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 04:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723265703; cv=none; b=tClIfJrlAsuXBRJiqsK/uOccq5cUmk0Ocir4o6kTi0LXQKyAre6ik6dLYOYButh4KzjG5W1CT2HXuTetITiJQ/OjR6SbrrV3hgPdbQmHSf87F6kDeEUYXbIrieoQa85u++4Wtjl2atgHxth/TjkAv1gEVtRvqEyzzRbhs+OVgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723265703; c=relaxed/simple;
	bh=fW/HAdQsyrG2RxEq/2rZsHLZNdxJVCTSnbhMLbyt75U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOfD08NeqNFrD+khzocxB9XxUOjEcpORN21JoD7ZuvnUBbKxLzg+6CbIQEnyIAL2QjukmFs0YyS2EHdyPpzcyG0/E5isTSP7VJn/BoPbnm5vXisLbtVBHu9vY3l53y/wctrdKgoVmbiZmKKtrlFZY0xe4GZE+rwBuHIKWcC0LWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6D6+Rw4; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db16a98d16so1763697b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 21:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723265701; x=1723870501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SZjRA7QvngAVvypNtraGj8iaKVFlhYAXT8CiOPJsiA=;
        b=H6D6+Rw4RaggRC0eoi6bhsWC+WEoI08hv4QewSItGayoFmJvY6Dd8JCGP3FB7xP0FZ
         o0YvfZVsqwxDVOvNnn8KsWhr8sdcIN1fME8oip8nWuCQW9l0V7XEMruBwjdX0pVgOsu7
         69aPGeQR4C9RtdOAaVlaiL5SZm7ST6NGVS86yBP6mD528sGuk926g7+QDvTG8oZcXJZQ
         dInHEztUZXBJAQXny7CP+AGMQdW738TyHNDjuwmUlUTA6tF8sFZoWR7qguPzwDxPHDhQ
         weh6UKnNQhv3RhcvTHFKuD95URdrEI7GEjbr9nESgA9PwGDe0gCEMfL0NNKbSTFCZBU4
         yo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723265701; x=1723870501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SZjRA7QvngAVvypNtraGj8iaKVFlhYAXT8CiOPJsiA=;
        b=Wa8k5U/c9WJ5CbwAKGQY5mpWrji7K+JUeTzT+xrgDfcI3meFytgPEll6w7gmE2G+Zr
         gaSgJuGbuWuypUqGzIKWzrQItlyJUQm30cJmmDuoPK0enety9hZCZoOgg10r3uVY/IhI
         1enII0WEBHIvcZqiEU2LzBxDLB3rieJNuTPORimD3RlBzr2cQfgVjOzbRm/np+iUefp2
         g2xOugKbJVes8iWPrJlqew8CCNloIGj2faeDoolz5Gmvt7a5iP3AUKIKyKXv9TBq8ejq
         yV9BDzjZb5LN8kxgZM5+orD3/mujzjR4hUw0QgBmy/pVo18figy/RBF8xlNDU5g9gb0O
         RiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmrHKYRK5WMZEyE5YGj1YAlFQWasvKqo0JiJLsndmhKGeWBpMKf4a1CtE9WM4p2z+IKefp/6U6kwi37/7QBHDB4dLVAeSqRzFxW5WU
X-Gm-Message-State: AOJu0YzAtJejdDHCbcTkAg9TVp9oI01+VbS8QOGVgxQuOmXvxnYksGUe
	iFDLGThmTZx4KHXLZtc70rEkUQksRq2+vaB8R6gCb9+WUQj3h8Nd
X-Google-Smtp-Source: AGHT+IFCpdECix9ySUNK/iLOdCLtYNnFJ9qFVXUZBFAfrUQMJf68JFWC2QWw0jFtauJ5lq+hwKLVXg==
X-Received: by 2002:a05:6808:2228:b0:3d9:3f51:f351 with SMTP id 5614622812f47-3dc4167b9d8mr4408461b6e.11.1723265700956;
        Fri, 09 Aug 2024 21:55:00 -0700 (PDT)
Received: from distilledx.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd82asm5227005ad.73.2024.08.09.21.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 21:55:00 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com
Cc: dianders@chromium.org,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH 0/2] add more multi functions for streamlined error handling
Date: Sat, 10 Aug 2024 10:24:02 +0530
Message-ID: <20240810045404.188146-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds mipi_dsi_dcs_set_tear_scanline_multi to the list of multi
functions and uses it with other multi functions in the jdi-fhd-r63452
panel.

Tejas Vipin (2):
  drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
  drm/panel: jdi-fhd-r63452: transition to mipi_dsi wrapped functions

 drivers/gpu/drm/drm_mipi_dsi.c               |  31 +++++
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 125 ++++++-------------
 include/drm/drm_mipi_dsi.h                   |   2 +
 3 files changed, 72 insertions(+), 86 deletions(-)

-- 
2.46.0


