Return-Path: <linux-kernel+bounces-311264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 649A39686E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212AD2855AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585AA1DAC46;
	Mon,  2 Sep 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="M/bSZdK7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA971D6C6C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278391; cv=none; b=YK2EorRLoKDY3F2qXQRQUtm8zg0Hxn928Pps4WmseQ4VcBzcOsdRz0+BVCYGJlTHp1aIwvZiTofpI55SysTNYOJ6V5WrfVrXg7Nim1T401zRtKFrk+aNuvgaVxysU9cKA5/xz3wyjTR3Sa+RZDPfHKgr6zR4PGfs6prL5gsK5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278391; c=relaxed/simple;
	bh=lVCscaTXSEHSqr95AdLNdttjTqtkhn3BT5Tljc5pLfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2Kj7kZdNah0dnK95DmNYcge9rz4QVra0Al4Lw/TqP3WAm0puiwq/n9mv6oqRO0cd7rFVwIKxmsfOA/w2DvtFosgBUMD23mxz0CUl7AjERlH9lpPmTTEZTjEPQwQRlOsp0+efIyAHXenGUn2/4+peGJWGZmEES1H3u29MOeJsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=M/bSZdK7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c84dcc64so855303f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725278389; x=1725883189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyoVr8BB/oOd23z+sFTfjVLmisWnkSIUHhoyRM8oVTg=;
        b=M/bSZdK7gj6WX39ee02WZzvkZDmMrr+GUfy8IC4bZ9uNJ1LMWk++tOv9AbsRyDqaVL
         Cuu5fYBYmvKr2Sa04V6I90YnnyOgdHs2eHvP5AsZmwI3ixND+r1tXzeHzr+V2juykRkI
         rfCo1ng7FBTr1Vg5LH9QHe1wTUrxs1cdGKBVDZ/dQn0EmvsFeQE1ZBDNwIfPEZnK9J3G
         2Pj6Gd1v92jA+bRwXwEFDGw642DwoZVms5SX1chZ4Cet47qIULNqkivdHOYptmGBvTIn
         mVuzdMth/+G3oC9aS5nyNmUoVJKjyeyRXJHXBg0McmO1hbHsKQhpA+k3icmSUoLZ7U7m
         DaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278389; x=1725883189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyoVr8BB/oOd23z+sFTfjVLmisWnkSIUHhoyRM8oVTg=;
        b=un+KNwUDuk3xZd0zqygJ54n/PueQVx02eegGvbtn3h5wtjDQKR6OntzlpHwczRQX6E
         2aQsa3kud9iNGqam4AIRgHh3DL6+k3lIs6bqKzcLAmoJKHLrt1vGE/HeRxNQIxQqNwS1
         zSpkUR26AIOwaXDhBvqRmNI8x4kxNkfSm1EwV/trqQKo/cT4UGvoJKbDW+3ZWYF1V0S1
         GJArKGvCKewvRoBgxr65t7YjSHoQZfv6MnbaSql+7f5TxQROiUqEp1NDj7iORJVlCMlH
         UaZYbxBhFqbwvrldO5njq73JMcOhBjnsY45BjYbSnL10pDtMtBBNTAjH8nkw2sLej3e3
         1QRg==
X-Forwarded-Encrypted: i=1; AJvYcCVrWVGqXvsStEQVxxmkLw5kJv+qrjv8vvWq/Fcz2OnmG470lsEqeLx6QM277+1v2kEhCqPODlFZ2/DQvsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLx2YGdIbglpypkzBsRQYxWrEKA9I0NAxreTtmawfh49+8ipY3
	fhpWz6SBgND46zPvRnTez+yNdSI57NghLP33iuLnL6NgL3VQc6t8WXoSmN6Eq/w=
X-Google-Smtp-Source: AGHT+IFNXzfdptxamW5No+061oF+yQdKkFxAv/cK1FRmel8f0gd8phtl+Rg8+FXjcf0mHXbIJNvmXA==
X-Received: by 2002:adf:e791:0:b0:374:bec7:8f with SMTP id ffacd0b85a97d-374bec700f2mr5403545f8f.28.1725278388074;
        Mon, 02 Sep 2024 04:59:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f243sm551304666b.69.2024.09.02.04.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:59:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rong Qianfeng <rongqianfeng@vivo.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1 2/2] gpio: zynq: Simplify using devm_clk_get_enabled()
Date: Mon,  2 Sep 2024 13:59:45 +0200
Message-ID: <172527838295.28083.11548950582839595377.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820121651.29706-3-rongqianfeng@vivo.com>
References: <20240820121651.29706-1-rongqianfeng@vivo.com> <20240820121651.29706-3-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 20 Aug 2024 20:16:51 +0800, Rong Qianfeng wrote:
> Use devm_clk_get_enabled() simplify zynq_gpio_probe() and zynq_gpio_remove().
> 
> 

Applied, thanks!

[2/2] gpio: zynq: Simplify using devm_clk_get_enabled()
      commit: 8d2aaf4382b7c2ae4eae17c3eb71474eddbb5c4b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

