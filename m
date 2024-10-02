Return-Path: <linux-kernel+bounces-346745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9D98C83F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78141282851
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0BF1CF2A6;
	Tue,  1 Oct 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xe2Obsh9"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD261CEEB9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821848; cv=none; b=Lbd5Ff0+Eeh3IU/YKVg6gxHLbIY34wx/kcIwyx13lv5iHf9FC7QraGmC/MQN4zoTXfYZbR+f2Aa3sUHA9/N7YRBT1PPPRqm+hmP1G5kK/HRL8hwzDavd4dhvnDElREwjpIjGdsNBqh/otVqaYerkF2BOt768Ik9AOuIJyORyTTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821848; c=relaxed/simple;
	bh=mcc+fe8SJ3QUY0+cjliOhv7q7Th/H4pfsWta+0VVpsc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iEz0dxvPv4X6ryW0WC0tiIdbRId/1vmQmBs2Bu2U7Vp+e8VxUzeP6ZftcCiJ/a9JRtehlwoWHJ7i+RwyoSM8KK1Ed5QcscnZuJykg3dU7ae4tG1zIi72OHZrNTmaWi/1GPPLb8E15teY8eyvXD9BRH4qXlkF6GRbjAGRMxcw1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xe2Obsh9; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e04b7b3c6dso3197229b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727821845; x=1728426645; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owqHur9R3AioO9eXK4C2peEdb1DGSE2FMPfyPnNLhbk=;
        b=Xe2Obsh9a6nDpY3l1uesXeWMLwY8b+arNhWeHwkjsKpayGwgtaY+/nMvwKTQFTpJrM
         rOhe6P+591uB2ZNgsX78Im1/YE0VGuUSoYS0jq/x8ZF4otUewWvrcEyOM0AgAKCqQ5Yh
         wRlxt2otJJp86EDiAoVS9dKKSKl5Scsjtaz+rabnMlzPnXUModiSKMX7WQmU8gdJQf8X
         oIE27oodKaUJo+3x+Z5g9qTeBz4aQ80QIX5T2Prq1h5seW8nrGn/3jI8vw6LwW5DOf/N
         /pojIvh8XugdxFacIWeoWs2pCpM/CFdlIIncNEleGXQdKCrKy45pvWdn57XO0Tzuq7Jy
         AA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821845; x=1728426645;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owqHur9R3AioO9eXK4C2peEdb1DGSE2FMPfyPnNLhbk=;
        b=jLzpsLm6xAJHEVk9MXafaGetTkXKCMxiwcsXvrUIuzpSSO/6LEQKLt6JlVxLTFw4Pk
         KWBZJJGrVK1fdQT6HxUSguYdMCWZzaRqRfoS+ebA1apgV+gtYgzQ/0WmouMIBmYbJEsk
         JpsX6AmoGc5yEasch7Qj55mIKTP7KPDAT/0gUuuGGRGBzRwWcpRZQ0u+iLbcFmJBOGom
         BOWriQL/YWQLcsS/LH15KYNad1E82bIJlSIETvHa5jDyJF0xVyhBzvAU9PGKVfEGMt50
         sHOD5CwcHOPyeYJwE3U5US6bX+vtV6wCwOpAVlVmMwgB3Y8YHpLHbntIe62ayZcNW1Li
         QOKw==
X-Forwarded-Encrypted: i=1; AJvYcCX3fxkJsa8szxSMeHYKZQq2xyupCUNcLyVBNUPRBFl7eVKSSaJOIb6ed3pjRtrFsBU5BL33mpzD1yWRE9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0D+fMtei6VFc6DSOkdk5/uuMElgM2SRb6nxvAafWp2YlwRsH
	OteQWCyvzWAwSAZwgOanRL3zEl3AepDAmGO71LpJLqROL+izGdRD13Wk+aMW4OY=
X-Google-Smtp-Source: AGHT+IHEfGd9MgkwJ2aGMZyA8kp2C58BUo9oeEYOwXX4Dw0L7rm4Oulnt4uKTL5ljuIbIRobknD8zQ==
X-Received: by 2002:a05:6808:f09:b0:3e0:3984:31b5 with SMTP id 5614622812f47-3e3b40f40ebmr1198476b6e.12.1727821844714;
        Tue, 01 Oct 2024 15:30:44 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e770eaa056sm3002097eaf.31.2024.10.01.15.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:30:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] cleanup: add if_not_cond_guard macro
Date: Tue, 01 Oct 2024 17:30:17 -0500
Message-Id: <20241001-cleanup-if_not_cond_guard-v1-0-7753810b0f7a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPl3/GYC/x3MQQrDIBBA0auEWUdQKa3JVUoQccZ0oIyiTSiE3
 D2S5Vv8f0CjytRgHg6otHPjLB1mHCB+gqykGLvBavswWhsVvxRkK4qTl/zzMQv6dQsVlZ6cQfd
 8ISYHvS+VEv/v93s5zwvO3noEawAAAA==
To: Peter Zijlstra <peterz@infradead.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-cxl@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
X-Mailer: b4 0.14.1

So far, I have not found scoped_cond_guard() to be nice to work with.
We have been using it quite a bit in the IIO subsystem via the
iio_device_claim_direct_scoped() macro.

The main thing I don't like is that scoped_cond_guard() uses a for loop
internally. In the IIO subsystem, we usually try to return as early as
possible, so often we are returning from all paths from withing this
hidden for loop. However, since it is a for loop, the compiler thinks
that it possible to exit the for loop and so we end up having to use
unreachable() after the end of the scope to avoid a compiler warning.
This is illustrated in the ad7380 patch in this series and there are 36
more instance of unreachable() already introduced in the IIO subsystem
because of this.

Also, scoped_cond_guard() is they only macro for conditional guards in
cleanup.h currently. This means that so far, patches adopting this are
generally converting something that wasn't scoped to be scoped. This
results in changing the indentation of a lot of lines of code, which is
just noise in the patches.

To avoid these issues, the natural thing to do would be to have a
non-scoped version of the scoped_cond_guard() macro. There was was a
rejected attempt to do this in [1], where one of the complaints was:

> > -       rc = down_read_interruptible(&cxl_region_rwsem);
> > -       if (rc)
> > -               return rc;
> > +       cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
>
> Yeah, this is an example of how NOT to do things.
>
> If you can't make the syntax be something clean and sane like
>
>         if (!cond_guard(rwsem_read_intr, &cxl_region_rwsem))
>                 return -EINTR;
>
> then this code should simply not be converted to guards AT ALL.

[1]: https://lore.kernel.org/all/170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com/

I couldn't find a way to make a cond_guard() macro that would work like
exactly as suggested (the problem is that you can't declare a variable
in the condition expression of an if statement in C). So I am proposing
a macro that reads basically the same as the above so it still reads
almost like normal C code even though it hides the if statement a bit.

        if_not_cond_guard(rwsem_read_intr, &cxl_region_rwsem)
                return -EINTR;

The "not" is baked into the macro because in most cases, failing to
obtain the lock is the abnormal condition and generally we want to have
the abnormal path be the indented one.

As example users, I've include a modified version of [2] from the
rejected series and an ADC patch that shows how this avoids the
unreachable() and too much indentation issues in the IIO subsystem.

[2]: https://lore.kernel.org/all/170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com/

---
David Lechner (3):
      cleanup: add conditional guard helper
      iio: adc: ad7380: use if_not_cond_guard for claim direct
      cxl/region: Use cond_guard() in show_targetN()

 drivers/cxl/core/region.c | 18 ++++--------
 drivers/iio/adc/ad7380.c  | 70 +++++++++++++++++++++++------------------------
 include/linux/cleanup.h   | 11 ++++++++
 3 files changed, 51 insertions(+), 48 deletions(-)
---
base-commit: 431c39f6d3edbab14f48dbf37a58ccdc0ac3be1e
change-id: 20241001-cleanup-if_not_cond_guard-0981d867ddf8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


