Return-Path: <linux-kernel+bounces-333274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6879097C639
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8977B21208
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C9F1991C1;
	Thu, 19 Sep 2024 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQAuY8fW"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E43FC0E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735842; cv=none; b=VvNayyr2fFR7wLt+MejLXE/PAIPj9ePzij35NLPwHG+4VFLfeG/8OjZ0gM96GDO6NXTq4wX49FJYyqdkq+6SLxympbxBdrIdaoWtBaxsNxzuKHWYHhhq6cx+mqRlJJXYJYsjf46VhAXceaKie4NXOgm7eUp/lSiwXEhAYXfeGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735842; c=relaxed/simple;
	bh=LrJw1AhJz7sTYbKD7COLqvtv/WahjF0UZSPF3n8L1AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=do4ObDV2ejUZNdYFsNdgi/NnKJqoE4IGtXO9TAVo89fj4trORtNnUCHJ7jhFRFV7G2gG0upVmbBq86yn2U/BDa75MGX5Nmb8l1g6itDgLySbTzQYEGmQwY1cxrK0PVp004JY6D3t6YrGQNlb/UhQ/00tc8RlIWPjTPOyGRS+xZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQAuY8fW; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365928acd0so639172e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726735837; x=1727340637; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aXfImNByrHCJYvhykUtqf/Cf9grdz1yZdroYSEnzd0=;
        b=LQAuY8fW4NCyS1obfBddcWXm5q8x9UBkqWcTcNuq39VQ8DvPzDRgXGepireJAxFcZb
         v1HbwpN7ruzLIsRW09u3lo2knxxJ7PRZ5kMdC/FH/GOJMv3MGnBYY+eQ7jf1TpXbBqcJ
         T9AS8XOPIQnk2LVF37fDiEjldh+c/oBO27fvXVynZPIYx8CWceuIFQfHQTuWMyaNTPUB
         UlFQ7y8Z/WD/qtJYvQSV7VeBKUn84c7W6aKdp6hDLi6ig3u+yrMYkq262AfSVj3mrVqn
         NuIiAC5zxUHg3WRXc6nY4kc3gago+0/XPPNZKBWcsnGYFTbHCm0Wlf+eqVN6QSRAnOWW
         oLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735837; x=1727340637;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aXfImNByrHCJYvhykUtqf/Cf9grdz1yZdroYSEnzd0=;
        b=SK5ZA/Zb92cFzfoTjK+dZZEh85AwKH2Mo9klQXSmepvSatvKrzKpep+SxO6HRiEqtQ
         8HECSQ3QpNRtTEcU14/UYerV/ikBog4frCWsoWaffWpgoEdp/f65OeC2ApAP+gmI9iSk
         INQ+YkwVyjtxWfLGuDAICEEmaUVmzTSU3AVcKUXhxBVHZsMIgHTCeYAUOSqf2lreDeAC
         fRTLy4cSJ3DuCKjbBlFNtgpRfSJiFAdXO6zvdJiOzbrqTleObThXhNUWM/rbnTNGHXCv
         0T2nSp4mvBq1yVwBvh9U+a9qn8vq+hreB+3XrKYViVCkKmX+ia2MtfCmmT81h86jAEeU
         xYTA==
X-Forwarded-Encrypted: i=1; AJvYcCXAHrPHMbGcVgvKIvf+Hvy3ufSwjVvUWjCYLjKAg/S9XkDV4Oaqw1WRzdZoJ6rkBV00aL7x5EEBg3AFStQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfVOzetxZN6QcZgR4uF/2m8Beri+pksNXog3494Bi7MpzFCdo
	yJbRZhxSPV+ve+8AUD/FMMaHyAeaJ+6cKI/P1tZ/UwD8jrHTXFPNtpSbaPcZeHc=
X-Google-Smtp-Source: AGHT+IHSchKP46mdULrhq3wm2RZ+wk7t1utwjuIcumCt9aQiICck+yHRyOAOwRnLE0p5ES06sz5eOQ==
X-Received: by 2002:a05:6512:1194:b0:530:dab8:7dd6 with SMTP id 2adb3069b0e04-53678ff48d5mr12195614e87.50.1726735837431;
        Thu, 19 Sep 2024 01:50:37 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb533besm5833278a12.26.2024.09.19.01.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:50:36 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:50:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, Benny Halevy <bhalevy@panasas.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix integer overflow in decode_rc_list()
Message-ID: <a13af2ba-5f33-4e9c-905c-0e0369daea6c@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The math in "rc_list->rcl_nrefcalls * 2 * sizeof(uint32_t)" could have an
integer overflow.  Add bounds checking on rc_list->rcl_nrefcalls to fix
that.

Fixes: 4aece6a19cf7 ("nfs41: cb_sequence xdr implementation")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.

 fs/nfs/callback_xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 6df77f008d3f..fdeb0b34a3d3 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -375,6 +375,8 @@ static __be32 decode_rc_list(struct xdr_stream *xdr,
 
 	rc_list->rcl_nrefcalls = ntohl(*p++);
 	if (rc_list->rcl_nrefcalls) {
+		if (unlikely(rc_list->rcl_nrefcalls > xdr->buf->len))
+			goto out;
 		p = xdr_inline_decode(xdr,
 			     rc_list->rcl_nrefcalls * 2 * sizeof(uint32_t));
 		if (unlikely(p == NULL))
-- 
2.34.1


