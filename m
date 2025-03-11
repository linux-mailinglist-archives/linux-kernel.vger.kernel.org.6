Return-Path: <linux-kernel+bounces-556313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BB2A5C3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A162A176FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F46425C71C;
	Tue, 11 Mar 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wlxoky82"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAEB25BACD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703777; cv=none; b=uaZEvGltlvqfGa1/VAIFvLZ82Jjcab8UFzKDJv2eMOceba9gHj3mitXKtVtrwOesoyLhr6qCafdv+xPTIBJhKSAbdAyBl6wB6vZpl2/fmylvpXiP8bvl6Fbj/7Nl1bZnphJLgflpK13Jc0wJ2wKE5YAhN2pY4KdundHhtUxWVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703777; c=relaxed/simple;
	bh=6LVHLF6PwX8YsonPvmbJwU0JO6y743wuUzDiLPWIImE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeIzrVoyUDg8RmRyqdRLuSbMOJ6OTj8qdH+AloaFf5WdBoASQ0oUi8zKVYOgUIq53a4AGpSlRk42FDMNxUf8K+iAOMNqKy6XS88Qn36+qDT3a0aVZ5AnJaxCmUyjZs9ouLJCIPAODykpfv6oFC4884WNdeaI/alkFOcP8aZKQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wlxoky82; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso4325167f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741703774; x=1742308574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVGY1YdKpatvu9ORUu7u/Y2xJ4feOuJRGzkvoJubghM=;
        b=Wlxoky821Hdf1+HDRFQI8GSJ+xfITZnxWkrT8O8QeqG3ei/oJBc4cHDaUYBGVON96a
         uar/T/KwZh73HwHRHToJloBV8o3YON8SeC1ab+BsqH1ujIK8rtBPjE0m23ktlGtMix9y
         BaNdnAxqgzuiJ2rAp++0s3xAcVGsBT6Zagy0XD9gQ46MHCp7rXe3Q33K4YAhZE2/QtWg
         jxmZaF5k8YnWO1t4nZ1xvzNIJmh/UdU7mE/TSDb1O/3rw+ZSK7NiASx5wSnQFSbw//0h
         H47AaCZhLYe3kUV2iAz+WdshLfx/RySlwsI52QXfZsJ7nGjStV+r8YnDg4E7QkoUPNh4
         9bOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703774; x=1742308574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVGY1YdKpatvu9ORUu7u/Y2xJ4feOuJRGzkvoJubghM=;
        b=dklqcLJa4jp701Sgf85lzpnW7JfNJ9AW9AaNKsX958cr6XfhkJ/54lH0SbsaNKAuNp
         uWetpoNLdZ+hFq/fgR2fJs00mzbwE4ygKsV9P2mLw0uxGqT1q3xOvXu9jVAWZM3/kg8Y
         yrK4eu8xGhVnmu6cDE7qoaICQ6wjdFxaAYfWL20EjHmsQkoXbeI5TFBPAdKoffYf6yLn
         5bMEFk/FH3+XrIdxEgINmpstQaLl1rihw0IMs1E2pi+MRxh/PSq6lKyqr+ptL1zzmUGs
         PFgENSYN0KFeQ2KU92bVWGq7poRGWn9s2UlBAOQK5LFwqs2sH0aqe8UhgiTxNO+tr407
         r0xA==
X-Forwarded-Encrypted: i=1; AJvYcCXYxFiA0EkJn5635e+f6Y57OhB4KdySC9PsteJc0Oqn1bW583UHT7f+QYsILu4NIApMvJvsOs1XTzkRj+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQnavRsTQfGumxyWJCS9PVXrS08rLhOEzInT+OIof6DPPi9zr
	/HbRz4te/aVQ2WMgiRM+iLQsVw65K3mFDyYEejyntYdZXghBU3Ebzxf+T71Xrrk=
X-Gm-Gg: ASbGncvwhC89qfyLljNqWtq5I48xBqUwwpnvOStLiA8uUwtiWhZzhPJieQjH8T6k4Lo
	5scLZzmFUt1y8lP0XlhP6SQ1rDUQdEHDAyEEs40Nee7wTGP/dt0D6CJB/ijDe9QYUf2kgpikCaV
	IAiwu7LSMoeR6Snty3WZG9uSgJA0ik0waWpCOHfhAVJAIRuKVGpQjSlIFQ7lE9FipDv4G1Cmfrq
	C0sPC5q9m9HyRoPfNRIidB34gb+3lIFamCrSTgdPOhBBNlYIRE8Qxi7DSISfBYUpHBMqwCEYqau
	OyOeBwtdQ6uHGFcpqChqNHJWE2hF7F8HQRdt5sK+T9+/j5Ch7TGEVtGifQ==
X-Google-Smtp-Source: AGHT+IErzBNORRKa85qMLnrTIo9THTPP0FLW0fdPXNcjP60zrb0rXKoRA/K5g0/ZRtEM4ho9Q+BqZA==
X-Received: by 2002:a05:6000:1fa6:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-3926cb664eamr5073516f8f.16.1741703773763;
        Tue, 11 Mar 2025 07:36:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba888sm18559270f8f.16.2025.03.11.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:36:13 -0700 (PDT)
Date: Tue, 11 Mar 2025 15:36:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Liu Ying <victor.liu@nxp.com>, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vsprintf: remove redundant and unused %pCn format
 specifier
Message-ID: <Z9BKW_06nLAOzYfY@pathway.suse.cz>
References: <20250311-vsprintf-pcn-v2-0-0af40fc7dee4@bootlin.com>
 <20250311-vsprintf-pcn-v2-2-0af40fc7dee4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-vsprintf-pcn-v2-2-0af40fc7dee4@bootlin.com>

On Tue 2025-03-11 10:21:23, Luca Ceresoli wrote:
> %pC and %pCn print the same string, and commit 900cca294425 ("lib/vsprintf:
> add %pC{,n,r} format specifiers for clocks") introducing them does not
> clarify any intended difference. It can be assumed %pC is a default for
> %pCn as some other specifiers do, but not all are consistent with this
> policy. Moreover there is now no other suffix other than 'n', which makes a
> default not really useful.
> 
> All users in the kernel were using %pC except for one which has been
> converted. So now remove %pCn and all the unnecessary extra code and
> documentation.
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Makes sense. Looks and works well, so:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

Daniel, if I get it correctly, you have already taken the 1st patch.
Would you mind to take also this patch using the same tree, please?
Otherwise, we would need to coordinate pull requests in the upcoming
merge window ;-)

Best Regards,
Petr

