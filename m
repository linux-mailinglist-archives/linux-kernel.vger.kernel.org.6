Return-Path: <linux-kernel+bounces-191016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA1D8D0608
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2FCEB2E92E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B33E169AFE;
	Mon, 27 May 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VkIE78g4"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01815FA84
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821585; cv=none; b=LmjW6q2hJMAEpQPTT9iHBPjX6dJujDb1sUpPh4zH7HpCdnVmm93KvSLzT7QBZfMBT9RZnSZ01tu+A9CQsSb/K/NPp9fvKb2GFrQbQ9ecB1eCf8wszvD212yCdjMPhdIufrHv3TRT7rq7Y7S+nmtcaSvy8jXqrJqMY7Y3mJOtJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821585; c=relaxed/simple;
	bh=5yxMdZmBSUT9i4hEAT9V16nLKOilp+kaLXgIrbnM1aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLeJAX0pxDi3GlG+YOfpHbgNVptBPA1mrZGD1fabV1UW6Iqi839vVOlvDpmMK6oF8z/QAgmLLPBGwMlarMO9a7QfQpfxXD6fVuWzqdatxw/d5kicrBotDxYV6U+jL8wxh8DWHJvXp+9OdMBG6ZGUtFNafyRGl2apcfmhl9RX+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VkIE78g4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-356c4e926a3so2002768f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716821583; x=1717426383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bb5vQx53FslUz3l0ynJWCQH6eTzzby8erMqydeQ0x6I=;
        b=VkIE78g49AuSLsa4iNHPDvXt9sue/Ra5dxLKOXR/nuLPIuIJGxtDndQtks59sX7Hrd
         2tR5xTY80F2qeAEb5EOk54dJ8JUVi7rUvUnnZOdn556G5dj+PbvNt47IjEK3fTe0ezNW
         fHEpXUPIQO+OGL9f2qE8j2FWQineHtvDEkTvQMDLWmppOsHXxKzoqkUKoNIO4KE58hB4
         s9Ti7uyrqbg8LIOes4lVTLVKNsGsdRjRDNy6Hzr50ctuauimw6x/iQ9rL2SoFZA6K5T0
         0rGOa0nCySYtJhHUBvNhdZwEkKHZWE8OSod7AYZqmSjnpgVTEvk/uBNxzJcMnAFwF8VJ
         e8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821583; x=1717426383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bb5vQx53FslUz3l0ynJWCQH6eTzzby8erMqydeQ0x6I=;
        b=kS9unQjvxEdSTh68Os5Qhv2yI3T069y90iz75FZ1lYw869N3Ek3Wt5eHEcaKZdUW1O
         SPtH9jcekxRvPKgPoFUW1pcTfolieKXxyXiKQsuBEy7FXEM4tYH6sw/cgLB1DI0nJX4V
         oomu5tbTmsZFkiMjE9Jqqa7J5q0peAFqhGLAGbb1qNGPdhemUmkn2ieflwaGd8LwPAbp
         yAR6pjP/LHhcyVcy+/n6CGD51mHxPxDYxEBClf257Pf49cBCc2My0+AdPZbBOUWI16Gh
         jrBm8fBOkUJ1iMnGjrigIQsQwwWyUw7FZ8+W9ZVU+0/FXSDGSX6CIP6hEBOg1VnrI5hT
         9A8A==
X-Forwarded-Encrypted: i=1; AJvYcCVC20ltB5ld9NgS1QYnUAtryyUldYMqwRpRNHShkL+yz8FPCFpSwK2oCao/dU6IJKIoyd9hVLuDEOfb/2LfSHszLgfj4DHXLZxYOsg0
X-Gm-Message-State: AOJu0Ywbnl6ftRjwTuYK/ES193J1TL66nbHsNEMctBTbfGmZhF61TT91
	57NG9AMM4AKvPS9JUe6h/FwhV7L6h2XAwgAV/NwhZg7Jxlk0q5iHfh8lnD32Vpw=
X-Google-Smtp-Source: AGHT+IE4hTuQ5jI9JkweFBuhQJ7UMzHYA0vfP3Bts3fRVrSkRh9DgFZPy8mdCi2aO4S9wd9kF92NgA==
X-Received: by 2002:adf:a3dc:0:b0:354:fcfb:c4aa with SMTP id ffacd0b85a97d-3552fdfd3e2mr6706418f8f.60.1716821582684;
        Mon, 27 May 2024 07:53:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:c322:131e:ff9d:ef41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3564b762ca8sm8474214f8f.112.2024.05.27.07.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:53:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Pratik Farkase <pratikfarkase94@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Pratik Farkase <pratik.farkase@wsisweden.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: gpio: lsi,zevio-gpio: convert to dtschema
Date: Mon, 27 May 2024 16:53:00 +0200
Message-ID: <171682157627.156531.2134241472358951863.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240522151616.27397-1-pratik.farkase@wsisweden.com>
References: <20240522151616.27397-1-pratik.farkase@wsisweden.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 22 May 2024 17:16:13 +0200, Pratik Farkase wrote:
> Convert Zevio GPIO Controller from text to dtschema.
> Adding `interrupts` property fixes the following warning:
> linux/out/arch/arm/boot/dts/nspire/nspire-tp.dtb: gpio@90000000:
> 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'`
> while executing `make dtbs_check` on Texas Instruments
> nspire boards.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: gpio: lsi,zevio-gpio: convert to dtschema
      commit: e4608bbccf2b9331a4a43385ab15d06eab7761ac

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

