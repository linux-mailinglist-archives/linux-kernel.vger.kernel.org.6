Return-Path: <linux-kernel+bounces-543007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8CA4D074
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996F5188EDE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6335966;
	Tue,  4 Mar 2025 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdVZwKDT"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D3BE5E;
	Tue,  4 Mar 2025 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741050041; cv=none; b=nGtwl3rjq92TV6MsIw5CWmPItlpHcWoB+HYA/Tmu5R2/4VWLPoUL8BIgl60T1yyIIfx8foHsQxAhRKVy4yRETyfV1ON4MJUcj7zM0iucrTXePot97uQquNz1BfxmTZy5kb42Wjz3AcgGHc2aHbAz4HlARxtyCNED5nHQdz4PVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741050041; c=relaxed/simple;
	bh=U6SJvB2PfUBTckttCxJQcsnQHiDDC2aAWfYCuAZpk2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnGeu2iH+ip6VNLfnlghRhVSFMN12GNdt45Yek6IhS60hlj8TG4FnnJn9Ub70x/+gVsveRC8LXV69hQcRT3GF8JjGBRPKaK5iFnuUv42LyFcDTKXo48NUp4q6BJqNWYw5dujj2LlgM5iTK8XvseLkfpiACXdAVPIu3ByJstoAiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdVZwKDT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c3c4ff7d31so157038185a.1;
        Mon, 03 Mar 2025 17:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741050039; x=1741654839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ff2JH5f/lHUY528vvAVt0cMf2fGH3mjXbg9TcHWUD+s=;
        b=GdVZwKDT8C6eO2krQ0NuDIpI+uPgm+AsLrbQFTb5JU/BlZ5LLjpy+ebKHlcIJCrXi6
         s1iKCUahtpMlkXtWmTM9zqAbU3al46DMSP6H32m/CnUmWSq2ZaaG4VJeob27Z5CFgkXG
         iULaLt+Y+G3TmaikWpr+crPfyRzEx/NFzIlsYE/KGALYJ2H9r6nnmYMLZAWCmmsXl0Q+
         ayxCQKxEk347F8v92l+nqpOYnZQlZLhUgsSeFmjTzQHefsPEQ/+GzgYAUL+QogOBM6zg
         fn17tjohr7F0PY+LEFw77KLE3r3HrgAJ7GE6CwXcG4sWyGMAGWYv9s2ns9ogB7go2Bdf
         JR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741050039; x=1741654839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff2JH5f/lHUY528vvAVt0cMf2fGH3mjXbg9TcHWUD+s=;
        b=s69rvWJZtMJyqwkjd48zYgJrM2RjmR3GiWSHwKeejyBDrr/rDsVYxJpDkhvcycvzLG
         nMjtNV7YOFi7T3cF6AS4e4q2TDP2CsSILwayZJa2DF806FLGiWJk8TE7Qr7EO8/y2A38
         4bSZGTI5yy/q7PsJk9f9rS+N/kzZUN5Xqh2TB1uHUTjui6iwr6Rak6dyMAqUIJRIOpti
         ZorRBmWzbcqdDNf21JbQ7uLg/cupvCp4nxBCv3TZ9fqwoxnZGMFGCgKcczxvdp5jRc3g
         ifq6GuDVWl3gn6d3iYvV9NvueAV9V1aK+6WY4yc6MCZsx7BVodoNCxTvPRRjaOOr64Ug
         m52A==
X-Forwarded-Encrypted: i=1; AJvYcCUOnNc30mIwik2nBYNtKNaECxUiNvua+e9GnysIZYgRlrKVNzLC+GS9yIvLHZ9duOOF5QqGpDSrd6hV@vger.kernel.org, AJvYcCX5jdU6J4NM3NrO3lHw56JrAmI8Zx558/ZQP0mnDY2R6GXKW3bD6uRnYEXr6zq8z7WR594BIbPTw5ASRl0f@vger.kernel.org
X-Gm-Message-State: AOJu0YxIA9LRd0qGpPkxpaRTMtOXnB3dVGxw0oDNdgbC64G/surT1TUI
	djhAnyLY/y7BmSefvMqa9xdZ5uQOj7WqhO7xQZPqbwAC90t4RSjJ
X-Gm-Gg: ASbGncuEn9bTMMBYH4lEMQm/ct66GU4JDk5MPB3/CZauj4gAmRHdIgF08DmSFPHPZ9H
	1mFjXCafZVqmqJrIuzwSsC2BA1N9kRf9NK7opYFmsaM6xTCRje18Xf1iymRoKGT8PjMwW91gYtY
	/a1UwCcMFUhs3gojBFl+Dt1xtmqI0xRBTpHyic7kqQ0XTfPLMIOiV8KkZX1tOlGgA7KvtV+Pxh4
	R3WMtLWPQZeYH06D1w6SDqhfgAaZBKGl9zqqxU2EAMlYvhtfd3Jwx0tk0DH101RNuL53qMY8sni
	nq0OHCMc+rfXrZsSS8G3
X-Google-Smtp-Source: AGHT+IGDdtA40aeEMvGeshE3g5aY0snIpnWT6tZZj/78dDHagcxQsvhw5VDTx9i7ZjrhEMZ0h51lXg==
X-Received: by 2002:a05:620a:8088:b0:7c3:bc90:a46f with SMTP id af79cd13be357-7c3bc90a9bdmr779389785a.24.1741050039185;
        Mon, 03 Mar 2025 17:00:39 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3c0d34fadsm166821085a.12.2025.03.03.17.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 17:00:38 -0800 (PST)
Date: Tue, 4 Mar 2025 09:00:12 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: Add Sophgo SG2044
 MSI controller
Message-ID: <ihojf2rvfg3nqebovaf7vsc57uwolxnyodkutva64zxptukgv7@wqu3nnbi3yzt>
References: <20250303111648.1337543-1-inochiama@gmail.com>
 <20250303111648.1337543-2-inochiama@gmail.com>
 <20250303-woozy-pluck-c04b13342401@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-woozy-pluck-c04b13342401@spud>

On Mon, Mar 03, 2025 at 04:29:53PM +0000, Conor Dooley wrote:
> On Mon, Mar 03, 2025 at 07:16:46PM +0800, Inochi Amaoto wrote:
> > Like SG2042, SG2044 uses a similar msi controller to provide MSI
> > interrupt for PCIe controllers.
> 
> In the future, could you mention the way in which they differ?
> "similar" could mean 99% the same but incompatible, or 90% the same but
> capable of using a fallback?
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 

It is OK for me. The difference between these two controller
are the number of MSI interrupts supports, and the way to
mask/map MSI message.

I will update the comment message for it.

Regards,
Inochi


