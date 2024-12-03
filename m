Return-Path: <linux-kernel+bounces-430218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DCB9E2DFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2B9281655
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C020B819;
	Tue,  3 Dec 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EHUBukod"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2920B800
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260830; cv=none; b=StaYHhZi+OpGGuSWfq/KaWAZHWVxZqYOQWQsP8lidinI2o2c0Y5zpSlulgInj5ntwIvbhHr6I3TuWOHmkXbm81JAcjwXnYJLdwv31FAmQmzWOft6oVIFWxReco4RZjz3A+zwHT1n8td8FOzPpN679bexEYrI31bAUrpn+Z9pSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260830; c=relaxed/simple;
	bh=9X5eIMvV46W8qWA8ZhdVfchZUxJMWj63sIIb96EFcB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4o1QZT8QiOlyxCWDWIW6jTWZWdzluF2xICk1wphbOPB2bt1/KYp3vjlN5fzWII4FKJezjSIDnERNokTx+VOmWjkMjzy5nBHlJq1OcGGptxqXCNmMdwGvvDsPCYUkz0+8rYVRV3k7KabeZlLSFsY/kG8hQr4sBPG6TiIMeuZiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EHUBukod; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4aef56c5cf9so1491604137.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 13:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733260828; x=1733865628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uy+WksCKY0gvDpLPtmZnEMUkklb+4A0f37uyRA+CFY=;
        b=EHUBukodyLCUlXFgla1ljTvMtqfT0HDw6Pqn1Ma+XA0lgBvEOPgeV+itcdpTDLE3YD
         ja81cqalQCJJmOYm17L6Z05FtLHpk+FdjQwv1XJqsGWRAqIQC3U4l4FdYXaGFjE0Ftgb
         dTETW7f1RH0f89JDYP/abGa66MrTx2UfDocoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260828; x=1733865628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uy+WksCKY0gvDpLPtmZnEMUkklb+4A0f37uyRA+CFY=;
        b=Z4gXpvmJq2B5lw61OZKrDXb3pLLGsWdFSK/4Ho+MgNCs0q+DP/64wfV0uuDxy2WhqT
         rG4wed0uJDSyqgaX9X4sghbkVrRPOhZvobg8hE38h9CVB2BJWLw8FCBghk3J1QOxEVv2
         xbnTEmO6ODa/enZoSaXP4z80SU4CY1EydEwU6aOGoeGzPc/KybOLWdcDi9033Tlp6kEs
         8IL+NFhxyAOErT/LsBD31UQkNx4D1r9O6xtkWGpbRerZ4gErIMKZf94tQ336pdUIT6BQ
         LDdxIaQ/6HtjRob9h1ZprsIiY7GlifxJg+W8eW7TOjyxv5HrSSyLFIFGRpqhcejpsz2w
         Z/YA==
X-Forwarded-Encrypted: i=1; AJvYcCV+G1sgkweFAshidjsC4URp0MpFelL7G43dWfc6LVHPTCx+6ag7dku7MkBWWCiEZCzbfxa89s7dJ0oiswA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8zMOY+BTChTBJwRfKE9qnekI8VVU/ZFOQFu4cGiRSlBzAI5K
	R+/qDDzNB7otWpLrtPovAN9croPAPnOBWxxjif0/B9VXa32GTo6HQiMi83Ka/Q==
X-Gm-Gg: ASbGncubzo/fOPGqpKCcvLcP1D1HHNFsNqWhsW8aauT4/gFSta+LegwJu5hhtbhjAxP
	GPPKNwH7YdWDHCQL00pMKjTYN8mmP1a2QiTCORPI6CyK6HYlObD0nIw7F3lXiKRsvaDxIt1CQgI
	SxoTMs8iVo/VG/5IHnnsg1nEjKNwFvrj2w+rFaFV8X7IZin0C2QC7L313aHC1Y20MuvQwclxv87
	d4u7Gvy2BMXSHIhKVHMWYwyJCpd141OY94HE7voy+6fG+zG2VF3jTCu14JLgYKh5fw9da+K+ya0
	c+JnVt5Nq8ZSYj8B+9i+LXgJ
X-Google-Smtp-Source: AGHT+IHRabdBjEHecDYvRcDdxhxnXbNb23cpwrgd+owBsDEQqOzvydhJ6thhewZyJGu/Nbu+3cfgmg==
X-Received: by 2002:a05:6102:9c4:b0:4af:5f6a:e73f with SMTP id ada2fe7eead31-4af973111b4mr5826942137.24.1733260826831;
        Tue, 03 Dec 2024 13:20:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a89d5csm2140364241.8.2024.12.03.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:20:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 03 Dec 2024 21:20:11 +0000
Subject: [PATCH v6 4/5] media: uvcvideo: Annotate lock requirements for
 uvc_ctrl_set
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-uvc-fix-async-v6-4-26c867231118@chromium.org>
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
In-Reply-To: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Make it explicit that the function is always called with ctrl_mutex
being held.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index def502195528..3dc9b7a49f64 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1981,6 +1981,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	s32 max;
 	int ret;
 
+	lockdep_assert_held(&chain->ctrl_mutex);
+
 	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
 		return -EACCES;
 

-- 
2.47.0.338.g60cca15819-goog


