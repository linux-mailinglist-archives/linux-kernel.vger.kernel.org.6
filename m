Return-Path: <linux-kernel+bounces-447965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362E9F3953
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A73037A2460
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD9207A16;
	Mon, 16 Dec 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Ce5JH7n"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23583207658
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375202; cv=none; b=j5WPd/gKwePc+lXSj0IqQbC/AIxafKCzYMS4Gbhyi4Tyxu7T76wNQTWyjE3ffIOVz9GSalxrTIzUY7fJ4od8aq0flUX5KSGBapr09nBUXwZJvORyzpTdYAieDSpCMcXmlQblDUaISObRRWNHIhOoyL6EUh/guAayoi6ii3/lbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375202; c=relaxed/simple;
	bh=QksVs/Fxv+cbTfWNhYVGoeCzkAB7AdKcWXZuz26F64A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BECF2gR01lQ2ojLRFPWy0w9BGnfLPvaG6NvBS7PeHtESe5lmbIzHhoKprWhg5LI44Wqt4FcImBgpeaIkjXQ2d+HAVw4jZ2ATsb2WwuNf2MStuROqevxJOdowZ5xnvt1Kt4lABJxp1X9kn7NutVg433m89ByUFZUF3FBCvtUKvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2Ce5JH7n; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728e81257bfso3514317b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734375197; x=1734979997; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LtCDUPpXP7mZ+NtBMUfwJXGAbOMvjyVT6yZDJ43guI=;
        b=2Ce5JH7nlAQiKQgSJNQp9hOiMBlUa0ogI1g9soqcTageJolocav3FMJclMjYo80/Xy
         50Vdt282wcQ/vqneHQ2eEtwUKddVZJINPmQSCHnhf5tVXw8EnwvVyOCSXWUACVoSgKfT
         wSkDXWIb7EbLV7YMbMZIok9pbMWPB/zwoCFZCjqsOGWa2A8xeyCINdk26B+iRdglhvq1
         efhAJdnqoZlj8mFqA8oDoTEBujTbMrSlf9zz7Eov/hvAkV60HFxIyzg5FmAbPT5xpxgf
         83TmlXKBsXnorJBeG/ySZZsbbXqggP6OU+fNKGc9hGVmB5Z9NVzrXsHXORa5X9P0My4O
         09ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375197; x=1734979997;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LtCDUPpXP7mZ+NtBMUfwJXGAbOMvjyVT6yZDJ43guI=;
        b=aR9tIJ1/UbZoE/0cavc8YPrwGkByvKSSy01mB4Iew1ob/+jRE3yqqUfQh5s7mCJpAx
         rUcyA51hgrDpL+WCnV8H+kxhsfZPFwbLxmYs5fjNXk32wgHdZupp15OxRXJ4dNWDGQoq
         TuRKLHLQkG5qm1JfCpEQU/7GPFTRgbLnL4mht+ygmml4z4J7VxMoFmXYegUf9MfmD4Fx
         v8Eh3xYpS5OlGT6aE47jrUrnNHmI8f+KcUrryFgAFpGEM53pGyXmI+VuSUMdjn/+LCdB
         82yu05xxaW5+tLcQzUSiSCQIoPX2q1bZnkgAo5FooDIn2SkmdMlG+uB7FexwiBBxUQBF
         cqxQ==
X-Gm-Message-State: AOJu0YwtEdorf8L+fbemQ07RW1nhR2WP9jZQDFA5pdHuFG17oCGOYhPR
	yLJGPU9pL8s0H61RCuzOafVrtzW4wtZzQrxw1ismtZRyMcslNcXfwLXYhCB1nPU=
X-Gm-Gg: ASbGncuYfbM2Euzo4Z3XPKpGMwJO2wFj1athYpy812bsCBNAbDUYARo8HJgMXX+qrrS
	9NmFQXNGwOkkS9XgQctwGvqsejTT1/KP7RkBWUxxbLDSQJC7FEbLKbH/Jx/QFHyWYgsVLMU+31o
	+1M3U1i0XB8f0hT/zKpyhk21MEurZiC7eXTalaf7A3Zl2f5TyjGvUfyGfLAGxNuaTLUMUbMLD0Q
	4Lc45zUxeH9QqbABspv13Lo1OYxTAWF+piShs2UmXEaHrYZvcRWMmo=
X-Google-Smtp-Source: AGHT+IG7ou0OLntrolix78mJXcOLuespNWbeAilFeGSN0T/emum0szk7WfV9OyOyRpYPPEVP2Vk4Lw==
X-Received: by 2002:a05:6a20:918b:b0:1e1:9fef:e969 with SMTP id adf61e73a8af0-1e45ab18122mr1137519637.4.1734375197464;
        Mon, 16 Dec 2024 10:53:17 -0800 (PST)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c0ef86sm4435890a12.56.2024.12.16.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:53:17 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the omap tree
In-Reply-To: <20241216113416.3e78369f@canb.auug.org.au>
References: <20241216113416.3e78369f@canb.auug.org.au>
Date: Mon, 16 Dec 2024 10:53:16 -0800
Message-ID: <7ha5cvcvdv.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> The following commit is also in the drivers-memory tree as a different
> commit (but the same patch):
>
>   56d96fc55390 ("memory: omap-gpmc: deadcode a pair of functions")
>
> This is commit
>
>   5119e6b44f8a ("memory: omap-gpmc: deadcode a pair of functions")
>
> in the drivers-memory tree.

Yes, this one was my fault.  It's now dropped from the omap tree.

Kevin

