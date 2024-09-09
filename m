Return-Path: <linux-kernel+bounces-321918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE63972117
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE9E285388
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B0188CDC;
	Mon,  9 Sep 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q4gJ2hDZ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A2188CC5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903070; cv=none; b=jBGtzhsNm96pbgJ+b9jVEDP6lZKcYF+AQrL/8PWfKzY1xFYzOcCMzkZOCws0VyInE0oZR4IgJS8UzYy5aoLCrSiUZdrSsGoQpzlCBihZbYBDY9lYk75eTKkA5jiHLHukmEgHa0LeFGzIiFpA3vHbBiyl5IiRm0Urgq+0CTzn7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903070; c=relaxed/simple;
	bh=Z6mJvcZe2MesBZofy1uPkQhd+aKfwut11jWDOz6Jc3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=agwvonlQTXp0AkVcng4TF+1rPhXwWPc0zlAYduB8iDzgaNQdywcorelZU2kRyDkS9Dj1XWaEEpIUZKeKJfXZNG0rdeKtOv0OwzK42dBa5sll+B95IO/3DLugqVOr8QmKIK+OFPj+kQtefDiHHqTwADPqb+JbN+Ylvf6gAMPHQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q4gJ2hDZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c326c638so3464275f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725903066; x=1726507866; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PiS3BCPtpO9F22HA9pONA15SeMVWRie+tAa6W5csc4=;
        b=Q4gJ2hDZm4QV5jruPcIYGowIuPA5zqvXQD77QazYDXBemlx34qMjgKyFuS+LLLscfS
         hjqzm3rR7DQYYSqxpRkv/MBN9857V7BBnU3f5SmBagpSBhXq6+LQuY23KPnLv/L4kSRH
         ENzHh+XFAUnCeBEQeWVIfQf2plmUnDy/sJZIzoTHVrsYjEHU754FVUkC6JMLXhTIA8p7
         29hGvz1l63NoldD0jIJaWCQGuUR/tx0ApLGUuyeqAZ9ryvScWAUNs9OBNhDbPpkoJ+J3
         +lAkSk6F3VHPthh1zuKoUCp/kFwon384tjLC5TeC0OPzRRAVwrG0fX/yqMmIoTaEvW6Y
         rhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725903066; x=1726507866;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PiS3BCPtpO9F22HA9pONA15SeMVWRie+tAa6W5csc4=;
        b=fkClGWaFLgHhowLEHwS08762AJmc0CXZ3ec6+jGfNIQIJ736ZxWlRIC89/GZNfddLe
         s0d7e5Y5krAgnFFM/oj/xrpylGg+hU9ymRL0oqI1iyEeUydVYqIRu0F0iODDuzpR0xZK
         2so27RTtys5E+Idqdt7yE3PdGIsvYlAqf3DVDxKerPWwHAonn4y4lhRDjwl7hfF/uNpA
         iWrhZ7U8jhZBDiNMS75TO/54ZyDLsdpwv8Wi/HwWOZo/58Fjb8A03kX8slw6U8wXJgRZ
         kyBb8WeMBDWOuUrs3dYhGvGtSjt5po69df6i4cJ94eGalikTUCZRZpGYrO5z77c+e2MZ
         OAHA==
X-Forwarded-Encrypted: i=1; AJvYcCVryco6K4yX8lmPTOYfGcP9VqG3hAzgaXaZcSPLiNg/3ZOWfP+nyoIIveRAe2F3iG/2GNH3v9vGzqZUNrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPpXEu9Sikmi8wcYcxh5jW+QK70BsdhgOylUttIBs0e+SR4n5Z
	qDMPzsxPFYTQI1+Bk5H/FqRAFSB1QeZCFrOUyBpbIwvEtBWhKgVRiLfO8lBK/Q0=
X-Google-Smtp-Source: AGHT+IG8YCZKd3Jy5v0Ys8OrH5RGLNJOThDfAM6nb3KaRMGZlBu7kgyv93neGwHauSgA7m/I2pKL9w==
X-Received: by 2002:a5d:5e12:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-37889d88432mr6208872f8f.26.1725903065445;
        Mon, 09 Sep 2024 10:31:05 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:788a:4542:ae86:67f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a340sm6544029f8f.24.2024.09.09.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:31:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: kernel test robot <lkp@intel.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,  Stephen Boyd
 <sboyd@kernel.org>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Jiucheng Xu
 <jiucheng.xu@amlogic.com>,  oe-kbuild-all@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  linux-amlogic@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 9/9] reset: amlogic: add auxiliary reset driver support
In-Reply-To: <202409100033.EPfBtwfK-lkp@intel.com> (kernel test robot's
	message of "Tue, 10 Sep 2024 00:42:47 +0800")
References: <20240906-meson-rst-aux-v4-9-08824c3d108b@baylibre.com>
	<202409100033.EPfBtwfK-lkp@intel.com>
Date: Mon, 09 Sep 2024 19:31:04 +0200
Message-ID: <1jcylcu42v.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 10 Sep 2024 at 00:42, kernel test robot <lkp@intel.com> wrote:

> Hi Jerome,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 487b1b32e317b85c2948eb4013f3e089a0433d49]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jerome-Brunet/reset-amlogic-convert-driver-to-regmap/20240906-213857
> base:   487b1b32e317b85c2948eb4013f3e089a0433d49
> patch link:    https://lore.kernel.org/r/20240906-meson-rst-aux-v4-9-08824c3d108b%40baylibre.com
> patch subject: [PATCH v4 9/9] reset: amlogic: add auxiliary reset driver support
> config: parisc-randconfig-r123-20240909 (https://download.01.org/0day-ci/archive/20240910/202409100033.EPfBtwfK-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.1.0
> reproduce: (https://download.01.org/0day-ci/archive/20240910/202409100033.EPfBtwfK-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409100033.EPfBtwfK-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    hppa-linux-ld: drivers/reset/amlogic/reset-meson-aux.o: in function `meson_reset_aux_probe':
>>> (.text+0xc): undefined reference to `meson_reset_controller_register'
>>> hppa-linux-ld: drivers/reset/amlogic/reset-meson-aux.o:(.rodata+0x88): undefined reference to `meson_reset_toggle_ops'
>    hppa-linux-ld: drivers/reset/amlogic/reset-meson-aux.o:(.rodata+0x9c): undefined reference to `meson_reset_toggle_ops'

In the config the COMMON part is built as module while the AUX part is
built-in. Of course, this should not be allowed. The error was
introduced in the last patchset version due to another renaming.
Will be fixed this next one.

-- 
Jerome

