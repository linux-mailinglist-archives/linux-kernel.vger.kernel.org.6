Return-Path: <linux-kernel+bounces-403336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E002A9C344E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C3E1F201A1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 19:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2FE38FA3;
	Sun, 10 Nov 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="O0JbF+R9"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A2224FD
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731265836; cv=none; b=diOUJDpdZm6W3POXDS9rjjQu9g8W2S2V7SgzbTd/BbdTCM4gSmErxGVFwdnBva6RoGVCPP4tuhmg9y69g5DDWFmDpga7mlr0AjpCXUapyFSREG7UeBSPzfwmUob1prrGvYiV/yPMM9Kte2YeJAaCzP7sX1GJpJdv0rSCfPBPGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731265836; c=relaxed/simple;
	bh=+9e2TAcGFkV9+2rn6sPyqSM9Vp7l8NsDqVQCehIue80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pxqom01X/GU+dx6QLG/W4e/EYh46onPC+3P5damYjU4l3nj4SSGPqMivh0ZXtsbKQ5cpuzGXm7ReBbOO0/eymYlLqK+dQqO+3xeyoiDWOLijUUbfnXVhJQjJJEFvvwL+KSSQ0vL1m1/Lsp4no7uA6qeWZaIKsjO+kK7tA1uakpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=O0JbF+R9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so2819849f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731265833; x=1731870633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vKwVTATCTNi06oENnBdqAb/G8uwaK/lqY0JtJHeTkI=;
        b=O0JbF+R9Eq7eDrjm8lzWYXDK6IL+YAThczw9ztDlVxTO1QHcae3Wesi2EoHCrOGQAs
         RTsynWyGgSFDWxrrmNYPx2H+ouGOuD9jkEbToYpHO0u9Qk5qKbmvnC6/YibbF1WkQby0
         TYlDa8hWHrI+WP2sUEvwSY8LbdH2YG0SNRI3g9LBi6BJZ+Jb4qNEJP2gxmGWGaItCSUt
         1RBnsVmoF6mKNDKfHNktOEGfnidYhJx1NImtY9PPTEm5sw5nh8zzRTlWdthH6EyadEbA
         PT5YIP1O/Acg9VPMS+Ip2fIu/cxIcqVzYlGZrwvDsXLgSHHWkkoEDiQW4elyC1GAscT+
         gdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731265833; x=1731870633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vKwVTATCTNi06oENnBdqAb/G8uwaK/lqY0JtJHeTkI=;
        b=HhllRMLj/70ul8IaMRwNP2CLPz4QtlUY1HQeEG9FCwwsAxBSCn/WEHAVwvSO7Yt/pe
         vN1FNY5HBw17j7G9OMUpPbrktWcrR1feU79n4kwjjxdi3i6pzJ4bNtDu6IBkcnZUoIM5
         LbKlfP/parSb8eq/nTUxbAXU1OZ+/NtWY4P1c+BHOmcqzgUQpU2frzCBdVBjZLXEwULJ
         vIHa7OQh5W7zAcBBRnD5cA1okCbjaWAa+YyNO+k5jYG7Kzg0rgNGy/rAGvdiDXNaOA5O
         wFjymLL/h+D+boxTE+NtcK4CUMItmL3ABVG2cvy3RqRCyM3cm08W+kgGvW59XajvN2VM
         4HIw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Tesyg6gOlQ2aLKacTKk/mS6iD7Mu8Wwb02XTzWO/bytVal/+QXECue24JvHFhY1PN6Lgp2m0AqnidZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyqIByIijk+2j/MT/O5aEBw09hh1vzBPPxg8nFkiXxlzmnnCX
	CdPP6c7g6bcaM+iKXKru6aUbPFqS1HbQKR7Ogq9JQEu59vGoAs3L9ngegtrSxXg=
X-Google-Smtp-Source: AGHT+IF5TaKIb9+eBUsbMVPlYRIt5u1MA/Ff2OICC1Avlws7zYC+F1G5MwyaD3b6auknThQkdxUBmA==
X-Received: by 2002:a05:6000:2cf:b0:37d:3742:a5a7 with SMTP id ffacd0b85a97d-381f172562fmr8154936f8f.33.1731265833162;
        Sun, 10 Nov 2024 11:10:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6872:d279:2c56:22ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c037bsm182526075e9.22.2024.11.10.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 11:10:32 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/2] polarfire gpio driver follow-ups
Date: Sun, 10 Nov 2024 20:10:31 +0100
Message-ID: <173126574727.7785.4094963648273280544.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107-avatar-clapper-93eb34ad0e0c@spud>
References: <20241107-avatar-clapper-93eb34ad0e0c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 07 Nov 2024 10:33:39 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Yo,
> 
> I realised last week, while rebasing the interrupt portion of the
> driver, that coregpio a compatible in the kernel as well as a dts user.
> Given how long the driver has taken to even get partially accepted, I
> waited to get it to gpio/for-next rather than showing up with last
> minute additions to it.
> 
> [...]

Applied, thanks!

I must admit I like your b4 topic names. :)

[2/2] MAINTAINERS: add gpio driver to PolarFire entry
      commit: 10287f0f9ee91f75a60ec1b19d962f459b18f589

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

