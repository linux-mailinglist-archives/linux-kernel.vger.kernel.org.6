Return-Path: <linux-kernel+bounces-521784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DE6A3C248
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA0C160C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC551F1538;
	Wed, 19 Feb 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QmE2mOCO"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F061EFF9B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975763; cv=none; b=ODcDBvQo7/l+648jzn2tnJUr5h0dHrWxHehRfzalVfOrEbXJO8BVWEMbp0w9YRRGkNT3zpFxDIQ0JxGhBgeMEhGOIEiclBAbqHI5CPz05oSDPfU+YBUnPrOikc4T5miDBZslcqgdRpTzNLzTsGq19gYRrgrrkrKzuUJTYvfg184=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975763; c=relaxed/simple;
	bh=EH9pF0bmKJbUbYy6pLydxngVLwM8z/4zuVPHp1uETVk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETYlpxOLhtolMiJiVluYxH+/KtMHjtESYJm/1Q0eCOD3CwPNA8jialcEKkEKezYBIGwaEaDrW4aJkrAbEg/r27y0S01tDE+/zbX9Szr5OD6DTjzqg2SYpchfsr6uiNQzCOkUYHBrCpxmgaN2c7v+weh3+Ulm8cfbctE6et+abIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QmE2mOCO; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so36034041fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739975760; x=1740580560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBUcuHhcoaE8QYDwj9P7DHCnYF+LbVz/GFms3n5h0yI=;
        b=QmE2mOCOv2rxcrhKLIb+2RQSO/A6fpQguy8XV/uMwtixQ7KdyW+MXuHAdQbH1zxvgU
         Z/lonwS3MlFwqepCLSPjL1Y8SSaYTAAuaFkZY3j9Soar3M57339djQKyHwrQvCZHnHyE
         AQU4m+kH2Hg+7mz4+cjI6OuDz80YS36w6lSRu5G8pr5i0wlec00buu7eYnEl9Z4cfTJ7
         VJe+wAFbDcA0YJRABrF1KkjcpISNWbiEpGuykpmgCKSFHalmFLw0vZb0M947IRyBxSDm
         edWkyoX4Rh6dZNF4o1ekOsEUH7F+KAXeEgXbzluNorVD6ZmMtsQVh2ribkVgd1njVn68
         9a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975760; x=1740580560;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBUcuHhcoaE8QYDwj9P7DHCnYF+LbVz/GFms3n5h0yI=;
        b=fj2IBRk561pyamCVkWUizbt+C/WtK+U1IQqvxna05XEV2ct3d8DgLk+C3tIU3LGrYq
         +Lc7xLHiOpobBN9B+7EEGZMRIi3fxNVnnk5DEcTlAdwxCF6CrFZSrF0il9gOgGEmjOir
         rTuPdRlTv30cnifdAhnW/0OnJapFuOSIw/lwi3a6DVMIbFxbeblL3xqoK2pBSDV456le
         7jKHmZ1IQdYV07d61mO4w5DT7shsyimc7PugIbETPwqNgxxcPzNQ0Xl7NckEYgzBhskH
         SAnzviACsOpCtcr89fXpZjk09ebikvHCvtgMckElTZVEgJAFgYMOP2qGyILq4e/Trykm
         nalg==
X-Forwarded-Encrypted: i=1; AJvYcCXoVa7b1YhejA3X0pYbi4ubnedAaLFNAX4bHSn8eSKwScN1tYB193f6cmWS3YY6K+AMr/dRqo5FhkJJbu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcT86fptL0ag+hI1oTmMIRiWtWg0iWHnmSGiQkSkKbn+aCSsXh
	5OwJSN/ro4IPVFYIm+jlu7fmHeXLRek0vfUAaBEPULLrQp5jZQ90AMSsfWVbTRPMXTYPhlpG+6K
	DD4HiNPBrTIKX+Ei4pfo5sKKWfSE2snFjD/DCsQ==
X-Gm-Gg: ASbGncvKt1bwkkxGtPQ2wWLGEW+YH5pC28CGiI5HmWH6RD7KksYD6Jlu8a/m2jiR1nB
	AFPWNR8LO6rnlWRR9W95Qnag1ROJax7dS2+fIa94GgsdK5c4UmgByOBNZyLgU+3HZ9M6jgYeyoI
	n3EWuCi6k7hVwspXT7RPHyr/tybGY=
X-Google-Smtp-Source: AGHT+IGWf0KFGTQRiATMpVUQQe4aBiZSWkdJsR2tvlLkcSCO4pmtWlYPyfFpX+bXdzxU+JJPQ8UtLbjhTUd+ejUTMyg=
X-Received: by 2002:a2e:9cd1:0:b0:308:ffa1:8915 with SMTP id
 38308e7fff4ca-30927a62b9amr55470761fa.5.1739975759790; Wed, 19 Feb 2025
 06:35:59 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 06:35:59 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Feb 2025 06:35:59 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <Z7XPcYtaA4COHDYj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217103922.151047-1-brgl@bgdev.pl> <Z7XPcYtaA4COHDYj@smile.fi.intel.com>
Date: Wed, 19 Feb 2025 06:35:59 -0800
X-Gm-Features: AWEUYZlDfKC76FvJo02GQQdn2c3-Q0CRK_MYWCBSiSKiScyorPBTfditmsDbJu0
Message-ID: <CAMRc=Mf6HLoORvth1O=DLGXcSvq75-mbmPR0zXg6cm6VV-LVWA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpiolib: move all includes to the top of gpio/consumer.h
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Dipen Patel <dipenp@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	timestamp@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 13:32:49 +0100, Andy Shevchenko
<andriy.shevchenko@intel.com> said:
> On Mon, Feb 17, 2025 at 11:39:21AM +0100, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> We have several conditional includes depending on !CONFIG_GPIOLIB. This
>> is supposed to reduce compilation time with CONFIG_GPIOLIB=y but in
>> practice there's no difference on modern machines.
>
> It's not about modern machines. If every maintainer will think this way,
> we end up in the complete and utter dead end with the headers.
>
> I believe you at least had read the cover letter for the infamous Ingo's series
> about headers and how it speeds up the build (in some cases up to 70% on as you
> said "modern machines").
>
>> It makes adding new stubs that depend on more than just GPIOLIB harder so
>> move them all to the top, unduplicate them and replace asm/ with preferred
>> linux/ alternatives.
>
> NAK.
>
> This makes dependency hell things much worse and this is a step back on the
> untangling the current situation along with the slowing down the speed of the
> build. Please. consider to revert or discard this patch.
>
> ...
>
>>  #include <linux/bits.h>
>> +#include <linux/bug.h>
>
> Okay to replace, but not okay to move.
>
>>  #include <linux/err.h>
>> +#include <linux/errno.h>
>
> Please, double check that it uses error codes from it, otherwise err.h includes
> asm/errno.h with basic codes already.
>
>> +#include <linux/kernel.h>
>
> This is definitely no. Please, read what's written in the top of that file and
> here is just a proxy for should come in the future a kind of might_sleep.h.
> Do not move this one at all, please.
>
>>  #include <linux/types.h>
>

Fair enough. Does this look right to you?

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0b2b56199c36..38e313fd0e9a 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -3,10 +3,6 @@
 #define __LINUX_GPIO_CONSUMER_H

 #include <linux/bits.h>
-#include <linux/bug.h>
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
 #include <linux/types.h>

 struct acpi_device;
@@ -185,6 +181,10 @@ struct gpio_desc
*devm_fwnode_gpiod_get_index(struct device *dev,

 #else /* CONFIG_GPIOLIB */

+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+
 static inline int gpiod_count(struct device *dev, const char *con_id)
 {
	return 0;
@@ -549,6 +549,10 @@ struct gpio_desc
*devm_fwnode_gpiod_get_index(struct device *dev,
 int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags);
 #else
+
+#include <linux/bug.h>
+#include <linux/err.h>
+
 static inline int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc,
					       unsigned long flags)
 {
@@ -615,6 +619,8 @@ int devm_acpi_dev_add_driver_gpios(struct device *dev,

 #else  /* CONFIG_GPIOLIB && CONFIG_ACPI */

+#include <linux/err.h>
+
 static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
			      const struct acpi_gpio_mapping *gpios)
 {
@@ -640,6 +646,8 @@ void gpiod_unexport(struct gpio_desc *desc);

 #else  /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */

+#include <linux/err.h>
+
 static inline int gpiod_export(struct gpio_desc *desc,
			       bool direction_may_change)
 {

Bart

