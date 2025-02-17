Return-Path: <linux-kernel+bounces-517251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79903A37E39
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413B8188A28C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D51FDA8D;
	Mon, 17 Feb 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZBei38fj"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7D1DDC2D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783820; cv=none; b=MXEHkBQhSLM3t35pXlK2olwXjJe5/YbJoC0oVYa/GbEBJ102CydZ7sE/1HzAEj+8tKSomfq1VrhT3IX2WISzihXNIJ1jq5WOE/tQ3TwysrM3k+Bbl/PgxsDcYHJd940Marv5BUiI46PbJGi4DYNYLAOo8rmtV6RmlL1mAMP2/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783820; c=relaxed/simple;
	bh=5NcSdPwaDSxy0K8jFrQO2g/aDkdPMceJFH81spqBAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9awtdcgnpKZZpN966mjeP2maKX6cgaBAuBkvo+5JaJdp4hwWQIXvLu/pvjEJSgBfBS3I1iVfNjvYvti7qwETunOFTCsCfWFVdgQbo96kZ0nXu2pCnI7OuWynzgSWaioqwTHbARLexf344+kGKH24VsxpxjRzzJacP8M++w7Dsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZBei38fj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so2252915f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739783817; x=1740388617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOb13QLKsCH74JEJtceuqnc8qt+tTrisvJShPAz0XFE=;
        b=ZBei38fj6OJuEdCJVmKC/JWpKeaIknhbCReHU5rhCKDczniY4XQBE3yllaXSqVH0RR
         vIjDFLRbGrEV5FATzhz1XoCk+WhpQw+bY9l9l5EWbDUfXcs+KE36XStCZSnBDliI4iwo
         t7JalYk2zubzvPimnQbWPvYVi+CYQTasMd4Wtlh94xyAV5YcqF4JOLoSXkX3YD9S3f2a
         DetS8ykABx9fh6d2msr/LIDYCOHN7gcvkCZFzhmxYoU8OOKJMxBcf3PiwL+N4DBUeJu2
         GDznsbmW+e1aadoGBHYVNfzc7AGtTrbc6AbLlekm0INaNLHlm8DP0sDHACIGF1xhnBPi
         GSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783817; x=1740388617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOb13QLKsCH74JEJtceuqnc8qt+tTrisvJShPAz0XFE=;
        b=HU6adeVHlvqg33MxsEPFDjLL2p7KqCWThITVEeqvL/xWH5DPybhMCc5hgWsHoGeOZO
         3Q9AlzOGt1mwByv1bc7CwYL2EVr764fagehN1HXWflagA9wuhcL8oc9N8xoRgZz9a1Sb
         Mgp+/G6zuXlK9XaU89z/GmIbsPfSfn0rvDiLFvWcjSYZU+UjWQ5S/OAXTzScvWu31Qy/
         T5U8ENa5ijtiHG0kDvpadhmWXp2mWVi+qxO0jglON1KqBaopqPnIUfO6NkEwcTmslMhR
         upQoqIyoOGyAARA5TxcCg8DhLP6npP7t/ypRSjyXVEdcVMSR22cgFnLYV20OYPbTWWHA
         zPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzX9mNhwd0R3CMdjKiSGAKQJ0EC4EOeZ8mH70vllOoJD02OfsLnWniLuhVfaOj0fTICFJhNKhjZtqSHK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJf875KCQM5NxZcoW4P1SwOdXpyhvSqN41Cj/WNWr/13TQb4q
	A/NxRCA9pvnbP0lSiLKRAWwtaDmJ4jPqrYLPeBy7p+cxtvTRtz8R3LjLlIJaWiw=
X-Gm-Gg: ASbGnctdsT7nI555E/aF/cdoEWoKn9GjpliJwGKbpoC92aov7YUrYdZFzdOueE0C3Yt
	99JQYYUqb2uQQHGQKj1PMjioRSBg1n07Z0pE3WOZr5QDMwiYuJeWumsmJHooobQvVwicFowO6L0
	VmX3FDcQlK49KODYpEmaNpdM7vRIhYQC7S53gobpSj6nkrXL8oMFBTyOkqueJlf6qwCa+OpyLwy
	BVUdHjp7LqduOAnXcXLUj329Zxcpvx74JnpYCB8Y3pQwuovH9qX3y/w/OKo8KgWw9rlxVMfYDQ4
	HTmGasH8fysZ
X-Google-Smtp-Source: AGHT+IEnCyx+LHbjy0ZMEYdprGHbUfwDTXID5I94Zw3Rny+hdaPa/0DMENe+bVWLpWRhrB4s8kotBA==
X-Received: by 2002:a5d:6d8c:0:b0:38f:394f:d8c with SMTP id ffacd0b85a97d-38f394f9cc5mr5620153f8f.33.1739783817274;
        Mon, 17 Feb 2025 01:16:57 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8707:ccd:3679:187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b410dsm11689734f8f.5.2025.02.17.01.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:16:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: loongson-64bit: Remove unneeded ngpio assignment
Date: Mon, 17 Feb 2025 10:16:55 +0100
Message-ID: <173978381388.133007.7573157992934929740.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213184833.3109038-1-andriy.shevchenko@linux.intel.com>
References: <20250213184833.3109038-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 13 Feb 2025 20:48:33 +0200, Andy Shevchenko wrote:
> The GPIO library will parse the respective property to fill ngpio.
> No need to repeat it in the driver.
> 
> While at it, drop unused fwnode field.
> 
> 

Applied, thanks!

[1/1] gpio: loongson-64bit: Remove unneeded ngpio assignment
      commit: bf1b5ae5db4d817ed976784e5317acc38f037d32

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

