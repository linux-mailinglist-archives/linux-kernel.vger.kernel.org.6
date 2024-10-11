Return-Path: <linux-kernel+bounces-361788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4FE99AD05
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCE028B843
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB001D0E19;
	Fri, 11 Oct 2024 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwmg2FJj"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C01E130E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675838; cv=none; b=BxWVodQs6HXlGt+24wEEqoFwEoigYYQCKXxvW15z9Q3fnbQamRNq4t3xkKuj6lFSs9ubZ2XgRP+jRngdFMS514S5yP+WTHxee2LNTXVG5idsPxG6m8svFexxof2447A+x5eHegdtHdbXvRhJE+yIPe5t9EUvjBzbYr+rw4k6x7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675838; c=relaxed/simple;
	bh=EyQBti8iRGrfy5Kq8qTYI9BU1x64Ao0+x6jgz0KJsPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tdc4nEDXnJqHkwR4YuTh7MGDuwjagEWJBEuoLv/k65WrwDmeoqVf9FotmFDMHxBkqhjSyrKkJz/q9V2xtDHce3uW2RZr4C9S5VpLBt9717wO0y+HxFfcCCPplthoyO26AtZQwo1em/V3hDDX8GBtd182hzIGwWxmvibJdkwv4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gwmg2FJj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso25239091fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675835; x=1729280635; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSBzE7LOUj+VcQ2h3x7qcMaBBc1aP+9+KQqW/9SwLIk=;
        b=gwmg2FJjPGh7PD0tIdhQpqt0/j/L+W04DVP+1bvH1VMH96m2BpBY97Rb7/IojwB+le
         aFq0CKhwCc2S6FOFi1JDWkhZneQZYWFSE1tlA3Ni89X2tB/G+TRqWHyVXk9BvHZ4B86A
         KrKRIUmY5sMfyhx2t4yZcG6ldOWeu0BCIquaMR16FXGGcasFdExtxp5/i5TrfQKiK1PV
         3Iy0xIAdKNHMGpLFZuAv4vyN0v1vwUu2fGiuEGfpWONg3rD9l/umMBHIb7Bwv/A7ba9O
         iYXF2D0BAKDQU8tTYVjObw4p87I/SDGwbfiQbSJ0996fIfJr9TMk5bS0Oz0pAOtKfesV
         GKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675835; x=1729280635;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSBzE7LOUj+VcQ2h3x7qcMaBBc1aP+9+KQqW/9SwLIk=;
        b=seUWAwVFYOza8FnRDJuUJQWpKqRSMMrjQ3Vt6PCVolYAEjBhnnlE27JL+J9C9CIt3z
         TVLwF/MomE8gHjtWnIaErydEZXhMIM68su9Z+9Bn/jbgIs9MkgqESkuG3NQj6OHa7A3H
         gyirxP+7KCWNvqtaoWppSvfwrDlWC3NgUz3MalvDOtq/ip7AgTV4OfTVQtb0DQu/tpo0
         sQS/ZeEtyaeK4oC1cFsI73/EpzBzdYRfBX0SG+2WzQo8XzID/hUUK2pOMvbE4S/jkGqj
         5GJnXYYSvb/6BkYGNini82dYBwLmPMJStheqNixSpFTakmD8IR+hlvcrPI9JUfUdd8Ut
         2yvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkbG0cDiBSg8FquFIWqRD6+6vewpMK2/fnGIWvxHu8VxNfJJL1fX9lMAV/Dc5QgL+0+E72RUqPHqFYOt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA93Vy4Yr88aMDLeteCZgfmDVhOWsFqr5JTntSLTYaUaQTsysU
	a+cMQUGESKz//ROrGjG3WEPLWrWQlhZdxZcYHvcS7HJmXYS4o1mDBkfTQlF/6J+LVJkSDGn3xZ/
	K
X-Google-Smtp-Source: AGHT+IEu1mhLVmze0TtnRFPpPlvy+z4vxQGWp3cGFcMGePx9vX4WB7qzF6iBduA1lrvZ+FXR5JVQyg==
X-Received: by 2002:a2e:712:0:b0:2f5:11f6:1b24 with SMTP id 38308e7fff4ca-2fb327423bdmr16197361fa.18.1728675834921;
        Fri, 11 Oct 2024 12:43:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182ffd7esm50175075e9.19.2024.10.11.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:43:54 -0700 (PDT)
Date: Fri, 11 Oct 2024 22:43:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Keith Packard <keithp@keithp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] USB: chaoskey: fix deadlock in release
Message-ID: <8c34cb8d-faaf-4134-851d-78db678d535f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This lock should was intended to be an unlock.  It will lead to a hang.

Fixes: 422dc0a4d12d ("USB: chaoskey: fail open after removal")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 drivers/usb/misc/chaoskey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index e8b63df5f975..4025f386ba6b 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -319,7 +319,7 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 bail:
 	mutex_unlock(&dev->lock);
 destruction:
-	mutex_lock(&chaoskey_list_lock);
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "release success");
 	return rv;
 }
-- 
2.45.2


