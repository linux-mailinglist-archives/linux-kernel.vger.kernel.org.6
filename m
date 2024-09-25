Return-Path: <linux-kernel+bounces-338312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC988985647
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C1284826
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73615B966;
	Wed, 25 Sep 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BysP+5C0"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F7A15696E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256241; cv=none; b=APTTWloYAt8jtwJTOrEW9kyem4Z3hk/QB7/6bhNHRLxn3iDQi/Qls5ShAevbs0x1JNVwvJdVCvrtybRpHcrAg+iv5/Z8JZ2DWBaz5kpHJKeQs+T7JkfRiVcChyuiMloQZVXv7pFzTTtaawfG/bt/XoZDmxqZnDjWQ6apfPkzk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256241; c=relaxed/simple;
	bh=kAyo2JpNhI6tY45kDDMshUFlPiOjDfTZ/WxQQAzoks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5KimUiGt9dfBX/3OBdEI1rfYm/Zky0vgLV3hPx1xjppD8EGP+QD8f2h6xYuI282JRXm1E3pReJ+8dhS+YsKlBhKA68a21TN84FsxA1uMt5jmbdgBiT5kE0wCkFMjxUL3mHULZKL2+/GfIYyrdf0Aos3x504REXpe5VtcuU2e1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BysP+5C0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so61958735e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727256238; x=1727861038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5harUdMUkYHv3S3CeApCGPIZ01UQZtvlqOHYBc4mQY=;
        b=BysP+5C0Vvua2Ja570JIG8YkSkCuEt9wxj4kbN8nPCNTtNFTBfOqh6WnKb/PSleMzJ
         0DIHAJWt6dOe5FTXJhDxJ4F7KdXQZam9nZmxpM/9svbj8RdA+zEVWlbf9/yT0kNSA1wI
         NgCj05ZCmz//o8J4uhOwRofSqBw9JwjMaHcAFNEHUEb5YeU/2nBkQJwjB+7ZtZPaoSsK
         zzTJn9yMmotEar3cJVZPz/r0sjAJ/6i5qslMLchlEYAhVLqoAsA8CJ32IyqESYoWGvbZ
         W4yFROh4tV7UIMto0+zuzcCJuD5bkeGjN7vKoNInoAVFVsIoq92wj0QJGQdK0JbwFr1I
         BuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727256238; x=1727861038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5harUdMUkYHv3S3CeApCGPIZ01UQZtvlqOHYBc4mQY=;
        b=s2i9OZG0pRYlU5DrBo+7UNZE386KOz1gQXFNlVPM1wSmV2qyDpS2hqhG0LHP1ETi2q
         PhmBV+eJKrbAUY/+KljXJwkGyWozlu5vmespnU97l+rQCeDhKF5OdDVNeoRhYeKcOiy7
         w53M7tfYlq6w3uw1ic29M3tIvWE2LpcLInMnG/SY12gIJ4EWZvWHVY/gg0Xuh1nk8hv5
         fl0aOucQL3s2gWCdoRfOb8uzbWSQ5jyfdpBmuBIMPw6S6KHD9i6Vj6MEG+zYxvjkHemp
         +GXEC6Jl2CGbeyp6qTVnqfO5GiqsSUhODoUXjn84g5miu2N1dW2QyJIRdI+rYaGK7btq
         iAHA==
X-Forwarded-Encrypted: i=1; AJvYcCWQUo8JzSoJ4GRznna5qgV63PV/NWLG8eW2lh0sG2UtihEdJd9h4aX3xeNG70T1oOkKyK6beN1Ohc/kGNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzybQjy3xZ0D3ObCttBflBWtZzCUVXKXZxeqr0t0gSqCyN5Gv
	5a/qhDz8keKYDCJXvUdAISWJ40GAExhLk4g5z6QGWfAldKpa0Ucs77q9OvZio9g=
X-Google-Smtp-Source: AGHT+IH76Pa8fJCQoDjA+iSkOMmtEE9IAbNSBuTosKzgLhAPo+74/va/yq/CBvMkCkqWCNLwm1hnrg==
X-Received: by 2002:a05:600c:45d0:b0:42c:e0da:f155 with SMTP id 5b1f17b1804b1-42e96109f23mr16269685e9.11.1727256238210;
        Wed, 25 Sep 2024 02:23:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969f90absm12239255e9.12.2024.09.25.02.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 02:23:57 -0700 (PDT)
Date: Wed, 25 Sep 2024 12:23:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 0/3] staging: vchiq_core: Consolidate bulk xfer helper
Message-ID: <6661b2d5-b439-46e1-b240-9fe436db4e67@stanley.mountain>
References: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919142130.1331495-1-umang.jain@ideasonboard.com>

On Thu, Sep 19, 2024 at 07:51:27PM +0530, Umang Jain wrote:
> Few functions were identified were their declaration, definition
> and usage were spread (incorrectly) across vchiq_core and vchiq_arm.
> 
> These are being consolidated into vchiq_core in this series.
> Please look at individual patches for details.
> 
> 2/3 is in particular a big one. The code is just a move, but
> seems big - as it was diffcult to split it into smaller, compilable
> hunks of individual patches.
> 
> Umang Jain (3):
>   staging: vchiq_core: Move remote_event_signal() vchiq_core
>   staging: vchiq_core: Move bulk data functions in vchiq_core
>   staging: vchiq_core: Drop vchiq_pagelist.h
> 

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

But next time, if you're just moving code around, just ignore checkpatch.  Do
the white space changes as a separate patch.

regards,
dan carpenter

+-                      memcpy_to_page(pages[0],
+-                              pagelist->offset,
+-                              fragments,
+-                              head_bytes);
++                      memcpy_to_page(pages[0], pagelist->offset,
++                                     fragments, head_bytes);
 }
+               if ((actual >= 0) && (head_bytes < actual) &&
+                   (tail_bytes != 0))
+                       memcpy_to_page(pages[num_pages - 1],
+-                              (pagelist->offset + actual) &
+-                              (PAGE_SIZE - 1) & ~(drv_mgmt->info->cache_line_size - 1),
+-                              fragments + drv_mgmt->info->cache_line_size,
+-                              tail_bytes);
++                                     (pagelist->offset + actual) &
++                                     (PAGE_SIZE - 1) & ~(drv_mgmt->info->cache_line_size - 1),
++                                     fragments + drv_mgmt->info->cache_line_size,
++                                     tail_bytes);


