Return-Path: <linux-kernel+bounces-394354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DE39BADD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1C41C2149C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296AB18E050;
	Mon,  4 Nov 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ojCDsTPG"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF8171E43
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708156; cv=none; b=DgXz5SJnabVGovirfpeHm+kda3RhGnk8ch0AVjYMN50hbFQ+dK6Xqy6iXB2mZNCr9S9BmFwAtmc+W/6+pvdkWrgAAOoNBThhHNmC2dY/xo5XBdzpzkQpBbw0UTvNfR3I/NClUV962MkkjSBcAE+VrbqA86BF9wEpWG6vxfPNkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708156; c=relaxed/simple;
	bh=a4EMiUXgoVenzw1GK5Ky6jQqTFcXg2iRCJqQwmCryPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlEgYZnDRYvop5q4gr+7JU+owTPF4PVK0/+S7qb0V33Y3dGrIc9zm3JPfe4UUvXtbo6EofO65Cbj1tglsyvF/W/ilVGc7edmCZra7I7Grc7Ay8uKx8flMVCxdFuU299HaChKmOkm/gqv4Bh6Qgdx8RRqA1zz3SE8UFNwIQ9VV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ojCDsTPG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so2479178f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730708153; x=1731312953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIeuAM5GJsoytHloglyBSVaHbZX6KID4/un87zATwOc=;
        b=ojCDsTPG02IOQCwEJV15LB/mTlymOxrfu1FXwyMQZHhJE/SLSlvXblYDfs8EKUGZyo
         KfhuJl9WCP6jtV7BF22Ae4qcpXl4QF63d62uJq3fMa9rhgNJjHD7fD31BxmAureUU2mm
         5RZlzVCK6HV0742MXX8FqdDBsM2Pcvcb0P3CMzn6zSLyQvzsXyHXtSUThKhPnem55hqe
         o3pu2N9JjXMOyyzdiHt334YIxlBLjiwYiReKFgk0MBpeV9aeW4RDggG3GT1bgOz4/79g
         fpq4plYlE2jXGwuGGFEFQWvN5KtL/gw/rf5ugmUQnDRM/kYR2KtbghgrMv+A9gv8fMum
         4HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730708153; x=1731312953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIeuAM5GJsoytHloglyBSVaHbZX6KID4/un87zATwOc=;
        b=oJJ4eHt49D+4SPria4OI2gfxxZ2PuTNV2l6fYnzED1TBlXs5wcv6eTAEbFEkICcnoS
         NBzDIyrcys+nL89URxgb54TbyoOoKB9q9waROL/OnqMkZO0ZPHHnbXkG3PmdQ11T0aNj
         cns+T8EfC6PujjcBP0tiZhulvOuRHkkNDuIhiMRJ4whzBq8nbTIry4INelmI4haMQSbP
         VQRubwnOajwfOtVMTsTwhOL49gaM3PYxGEJGwNxTI7R8xnqnhSLxwxu44nEEsrjk22Uy
         eUOoGQZ4DvcpYRmosKzDE+VUGsuYdxVYxxOuzusTSsgMTXLdAbSbFuYWhXlQ0fOnwely
         cyAw==
X-Forwarded-Encrypted: i=1; AJvYcCURwprXxCXVPPyBW9MNzjQ/3RA1RlIjTwTs+j6Vm3BInelfulAd7vycZchxJQ9DAyDIFSPSZEXGUAe3iZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/WU5q1R24BzOVbUE/+tDJDev81f2jR71Q6BszXlzat45C6g1h
	AWY49oGKk7G2AT24OYOTjlB4CsH5lMR/sxRzA41riOO+QLN8coqZgc/tUG5F+GI=
X-Google-Smtp-Source: AGHT+IEajS/InjMYYE7jd+ThlpM+g6VJvVw3N8PDF6JP88z4/XY+6wRBdCeIrZMVCeki4dDBp5Hdqw==
X-Received: by 2002:adf:fc8b:0:b0:37d:5026:f787 with SMTP id ffacd0b85a97d-380611e10f1mr20694357f8f.38.1730708153494;
        Mon, 04 Nov 2024 00:15:53 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2603:7936:7734:a187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c13sm12674140f8f.13.2024.11.04.00.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:15:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	William Breathitt Gray <wbg@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gpio: Replace deprecated PCI functions in ACCES drivers
Date: Mon,  4 Nov 2024 09:15:51 +0100
Message-ID: <173070814804.11535.16592270962077876800.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101-pci_iomap_region_gpio_acces-v1-0-26eb1dc93e45@kernel.org>
References: <20241101-pci_iomap_region_gpio_acces-v1-0-26eb1dc93e45@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 01 Nov 2024 16:15:07 +0900, William Breathitt Gray wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region() for the pci-idio-16 and
> pcie-idio-24 drivers.
> 
> [...]

Applied, thanks!

[1/2] gpio: pci-idio-16: Replace deprecated PCI functions
      commit: aeca17561dc32fcf8c105e2d6207fdf3356c7c94
[2/2] gpio: pcie-idio-24: Replace deprecated PCI functions
      commit: 09db69a84eca80374045063bdc8db6a21fddd7fe

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

