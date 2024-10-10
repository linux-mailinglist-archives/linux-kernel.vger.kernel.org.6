Return-Path: <linux-kernel+bounces-360018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674299938A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7ABB23F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237D1E6DFE;
	Thu, 10 Oct 2024 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qo5+v33D"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0D19C553
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591213; cv=none; b=UsTx+vMIMMnwL1RUH2Ko5rM69gFKng0qdwzgXqh/b3s++koSzbKIFAt2m2hstMyVzussn5XqvTt31YqSWXlu1iBxCyrV4m40Ix/4BN+razWIukKq2J3rL8BFtAJKp37chK6ScCKwe7xBGxWH2If165N9sjONA2EAyUailaZ5tp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591213; c=relaxed/simple;
	bh=0lZIgquyle7fwU0Lucs//hTyP5RHDSTScFN7WgLvCrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIQpm+rxORryK8m3tu3on+S4qnafdk+8Ue30f0t/HEKJXc0COlqQdFEGQuRrNyGGDQA7136R8n1JNRw8DQC6V7a0fg+8ol0W73mwa2pxGSJa4pEClkVqrjebk1NRJyZi9rX6RlNb8m8DEu9X9AX9KwGIynABBCqgeLwCW7EIZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qo5+v33D; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ead80d9c1aso409326eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728591208; x=1729196008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=846stNI2iGlXdHnVNxjtThkOcz8faJ6vEUWxERkxXQ0=;
        b=qo5+v33DajWFb1/HHFlfKFz1sLjCTyLCiU0yL9p0fSB6NZ5SFg7qelY174l+zRzun3
         PO+7XCRs4cvMdrwjjcFNzCiQDGM4noa5nK1Sg7imYGmEGZvFiMM/eVBlHS4m/RH873Fd
         GMgsIystPFgLs3dJvxsdq/03hXc0ydLLmD/k1i8TM9mXsMoCkFfz095DYBTcGjAKVA30
         X5EAXa0OkSnarBMFQewHGDNDedC8tFKUawJLtBm0TqfL/GW95dDkl2exB/GjXGOKlf2R
         Xy693MIqCAtJHUjZPWYqTEKlbnX1IxgOYy9ZxmvHcXQsBTc3OIY7/sN5g0sT8rm7hoz1
         aOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728591208; x=1729196008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=846stNI2iGlXdHnVNxjtThkOcz8faJ6vEUWxERkxXQ0=;
        b=SzV1sDfB9FEavEVCCjdr+xd+AkNRp/znAWSVIsdOVKu2Aug4hAQXMTwYyTrtCaOs8k
         bhHiEma+nWJ7yJfJyykBNMzT0mjWSXDHXhs0Ug+dNl1AXZvMMTUmxD/lCdjXjAfZO80B
         FR1copw7k5bc/SmMaBnQUyCpaPQkI5Z8GcKpZaLuKk02/mzzsnATQxi7961IpeK6Td1h
         KpVCIVTIWqB22o+hgqgoDdoUbrz93NOWG8yYyiwmE7A5+HVm0rWBJI/6yDbIl2eARe3g
         nwQ3+UkDEfSgAh1CSni0479s+8H/pTAVnhVTjKnI2OkcVFBg3OmFe+IUZR6IPfDZ5tVE
         0OmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbNrZueZqosOgHqEMjG2ngCzQlQ2/DOj1H5hKZxVRQAxaupGoc0BI38NQLA0t/kZYidLK7MTnEv2BPE8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxky4wDSBRcwDG+L4WR2Z3wyIuOnqK3Ht7PjZxJUhEucLlTpzZw
	j8mpORu/gb9qL6sJJlx6NIyg9U9TfW03l+dsAoD/hOk20D5K1/9ffPj5/m+yGpM=
X-Google-Smtp-Source: AGHT+IFQuL6oXl0zfaQl7DeN+D+AU9z/iBVtBYOJbjGnwWzlbfCsbHda7ODwq0Y0YBZ5gJeLhBLAVw==
X-Received: by 2002:a05:6820:1627:b0:5e7:cb2e:dfec with SMTP id 006d021491bc7-5eb1a31324emr34869eaf.8.1728591208394;
        Thu, 10 Oct 2024 13:13:28 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eb11600024sm231939eaf.0.2024.10.10.13.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 13:13:26 -0700 (PDT)
Message-ID: <0f4786e9-d738-435d-afb9-8c0c4a028ddb@baylibre.com>
Date: Thu, 10 Oct 2024 15:13:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cleanup: adjust scoped_guard() to avoid potential
 warning
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc: amadeuszx.slawinski@linux.intel.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 Markus Elfring <Markus.Elfring@web.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20241009114446.14873-1-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241009114446.14873-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/9/24 6:44 AM, Przemek Kitszel wrote:
> Change scoped_guard() to make reasoning about it easier for static
> analysis tools (smatch, compiler diagnostics), especially to enable them
> to tell if the given scoped_guard() is conditional (interruptible-locks,
> try-locks) or not (like simple mutex_lock()).
> 
> Add compile-time error if scoped_cond_guard() is used for non-conditional
> lock class.
> 
> Beyond easier tooling and a little shrink reported by bloat-o-meter:
> add/remove: 3/2 grow/shrink: 45/55 up/down: 1573/-2069 (-496)
> this patch enables developer to write code like:
> 
> int foo(struct my_drv *adapter)
> {
> 	scoped_guard(spinlock, &adapter->some_spinlock)
> 		return adapter->spinlock_protected_var;
> }
> > 
> Current scoped_guard() implementation does not support that,
> due to compiler complaining:
> error: control reaches end of non-void function [-Werror=return-type]

I was hoping that this would allow us to do the same with
scoped_cond_guard() so that we could remove a bunch of
unreachable(); that we had to add in the IIO subsystem. But
with this patch we still get compile errors if we remove them.

Is it possible to apply the same if/goto magic to scoped_cond_guard()
to make it better too?

---

Here is a test case if that helps...

For example, I made this change:

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index e8bddfb0d07d..f1c85690af1e 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -577,7 +577,6 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 		else
 			return regmap_write(st->regmap, reg, writeval);
 	}
-	unreachable();
 }
 
 /*
@@ -824,7 +823,6 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 			return ad7380_read_direct(st, chan->scan_index,
 						  scan_type, val);
 		}
-		unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		/*
 		 * According to the datasheet, the LSB size is:
@@ -933,7 +931,6 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 					FIELD_PREP(AD7380_CONFIG2_RESET,
 						   AD7380_CONFIG2_RESET_SOFT));
 		}
-		unreachable();
 	default:
 		return -EINVAL;
 	}

And then I get the following compiler errors/warnings:

/home/david/work/linux/drivers/iio/adc/ad7380.c: In function ‘ad7380_debugfs_reg_access’:
/home/david/work/linux/drivers/iio/adc/ad7380.c:580:1: error: control reaches end of non-void function [-Werror=return-type]
  580 | }
      | ^
In file included from /home/david/work/linux/include/linux/irqflags.h:17,
                 from /home/david/work/linux/arch/arm/include/asm/bitops.h:28,
                 from /home/david/work/linux/include/linux/bitops.h:68,
                 from /home/david/work/linux/drivers/iio/adc/ad7380.c:20:
/home/david/work/linux/drivers/iio/adc/ad7380.c: In function ‘ad7380_write_raw’:
/home/david/work/linux/include/linux/cleanup.h:337:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
  337 |         for (CLASS(_name, scope)(args), \
      |         ^~~
/home/david/work/linux/include/linux/iio/iio.h:689:9: note: in expansion of macro ‘scoped_cond_guard’
  689 |         scoped_cond_guard(iio_claim_direct_try, fail, iio_dev)
      |         ^~~~~~~~~~~~~~~~~
/home/david/work/linux/drivers/iio/adc/ad7380.c:910:17: note: in expansion of macro ‘iio_device_claim_direct_scoped’
  910 |                 iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/david/work/linux/drivers/iio/adc/ad7380.c:934:9: note: here
  934 |         default:
      |         ^~~~~~~
/home/david/work/linux/drivers/iio/adc/ad7380.c: In function ‘ad7380_read_raw’:
/home/david/work/linux/include/linux/cleanup.h:337:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
  337 |         for (CLASS(_name, scope)(args), \
      |         ^~~
/home/david/work/linux/include/linux/iio/iio.h:689:9: note: in expansion of macro ‘scoped_cond_guard’
  689 |         scoped_cond_guard(iio_claim_direct_try, fail, iio_dev)
      |         ^~~~~~~~~~~~~~~~~
/home/david/work/linux/drivers/iio/adc/ad7380.c:822:17: note: in expansion of macro ‘iio_device_claim_direct_scoped’
  822 |                 iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/david/work/linux/drivers/iio/adc/ad7380.c:826:9: note: here
  826 |         case IIO_CHAN_INFO_SCALE:
      |         ^~~~

Using compiler:

$ arm-linux-gnueabi-gcc --version
arm-linux-gnueabi-gcc (Ubuntu 13.2.0-23ubuntu4) 13.2.0



