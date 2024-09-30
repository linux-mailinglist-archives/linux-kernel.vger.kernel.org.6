Return-Path: <linux-kernel+bounces-344626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97498AC05
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4007DB232D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B611991D4;
	Mon, 30 Sep 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ff6xXL05"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5C18EAB
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720593; cv=none; b=ASFFjtqKs/DXDWnfit/FUhoYQoLOn6YNK0GY11glGzlUZDqnc4kxlmQa0mtqRIfwTfvKyT2M+6XIVQDfLTyITpd0r6+JB5YvP8fJdSvsLyqbsLmF0xbX2EZhP8nqb0rfumwCfOjz19dQLMRbE7oykGXTNdJEhiqsv5aPXTRWzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720593; c=relaxed/simple;
	bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7y1gBP86aOJB6ah178ux3enONA/fHlQ8m2LeDTgQlVCX+yl8I/9gxKUIcLgw14Ol3PMumJH4mwkOK2bPMVsHCFimdSt6vYoc4QRYev8rZZ39OGY79bnIfvZzxyDW4VOyHpFVGnnZhJNBRxeWTkZ2qCdX2SDyrD4/q7fRMs6hgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ff6xXL05; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2780827dbafso2281807fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727720591; x=1728325391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
        b=ff6xXL05YKP68Mi8hk/py+xcxwrB5Fe7dVtLwDCOv9vcMpRTMV7IfDoyz4JlA8t8+Z
         7k8/5ii7jcvWN89aJYIOdOk/ksCMp35WJ9TIgTIujb7ryyjkcyst0SEmplcwXzRNc1cR
         5V8ag+YduiIwgXp/NWUC2dtd0UkyQ19DaZPiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720591; x=1728325391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWzDaD4gnfuZZ55OyRg88I+Uq/fwGy15VXJDyUQsijs=;
        b=DWea7XTHYww1RPQn95Wk+nR+acJL9Ig86iZNmrvS0Ce56ghRWVe80PO/ScbXzQBivf
         CwFfMhcdpAN4ChFsT8wec1kfvXdu2wnzGiyvsDF7PYa4F6SYMrCFd72hu+opsi+w9Xvu
         flf2QGn4Crlx7kLi3Ab7/N90GwoHNsBG33Rczrgx9IhgpDmYwCDTGGvSaU/sgz3cEX3h
         1XhWeWj/mTRF/kxl0kr5ArZZysMx0w8siCgge/j0mvYa4dVlDXg8MwSuppQG2tRFGO6b
         Yh7P2C72euyOsuaU0Nbpi9JyE4qvHUFTCKgVrtMJOfcJAd8rq8mAIMwapyNeiK5FYfcO
         aFkA==
X-Forwarded-Encrypted: i=1; AJvYcCV6XPjxZ1pb+jQfX5uFuzbaPoxB+8ZT3I8oTYzAyZEaOSx/zbd/9bW7DehkC+oGkJYfGKtKCL0qnT9iBxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97abd8RsAtMf/CPaLbwLcWjBpGBtXaJFpVfJZoP9HJoUoA6wG
	+fyVxeXC7Lb9Jl1mCaoQdnJR7hs6dcgUFPsCy/rwkk+x2dpWauyVyv70+WgjRh1uPEhwHZDUip4
	JvVO0HXYoK0TtcMxkWd8NSTr8xaH3gbXFZ59R
X-Google-Smtp-Source: AGHT+IEa7PyDDTTEYOgSvCL8wcTYdFJzQ6xeqQh0FfcrTyWPVWg/k95QEjmZ5s68+65kdVi38bWTLm8OVVjNPcrmKeY=
X-Received: by 2002:a05:6871:546:b0:277:cb9f:8246 with SMTP id
 586e51a60fabf-28710bb0f11mr8656866fac.38.1727720591656; Mon, 30 Sep 2024
 11:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824042635.GM1532424@black.fi.intel.com> <20240824162042.GA411509@bhelgaas>
 <CA+Y6NJEm8UH5H1zE1Kgz9sKcv2xKKUzR5n=xNdOqyBYocyyCgg@mail.gmail.com>
In-Reply-To: <CA+Y6NJEm8UH5H1zE1Kgz9sKcv2xKKUzR5n=xNdOqyBYocyyCgg@mail.gmail.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 30 Sep 2024 14:23:00 -0400
Message-ID: <CA+Y6NJG7aJszmMG_N3HfnmeMFaAsz9g+XvuQyvzgquah3Jr4NQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rajat Jain <rajatja@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello!

Just a friendly ping! I see that this may have gotten lost in the mix.

Have we addressed your main concerns? How would you want me to reword things?

This is the latest patch in this series:
https://lore.kernel.org/all/20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org/
Thank you!
Esther

