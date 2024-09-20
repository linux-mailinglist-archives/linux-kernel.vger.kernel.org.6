Return-Path: <linux-kernel+bounces-334108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FE197D2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B92CB2364D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A413A244;
	Fri, 20 Sep 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="b1RHTMVg"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AD137932
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820683; cv=none; b=bAUjWIrxFd1G6FMgF4OtrIn1ofvt3I7n4BPiIg+dpxUi0mxDRYz4deC39cIrULX5aSw8ufeQmK8DlAKjpqAofzExqQOWcM4EA1KZ3vvzgQ6RTikroJ6KFO29i7HlVohzIL4Wgr552NZdbIcfTOKCP8leq48iy2aw0y0jN/vQhhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820683; c=relaxed/simple;
	bh=LZ0S9KTwGYU9nXfsJU/kvnMaq8Zh65FI0uhO7otglZE=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=UNy9w5RZqLOUwc4vSJSiFEHC3EfkvMkGzDJjUbM8LJSyO4VZKTLMYea48ovc7ZVwfBGzItIQroEVKBo20BpMJDFe6kZ8yiPF0uRA/8p7EkUBkQxUEItwoDLyPm29OFdk5XTO9SCvo4YygNciagvlN6CJ0XKnY79rrgW1ca4FYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=b1RHTMVg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7db4f323b12so963448a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726820681; x=1727425481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18bFlmoHAy/k1n0ja9d6oNofVKOr2ShiamuID3ftTZo=;
        b=b1RHTMVgHde9JxQ8aIG2gx4mSnfp1y4TabYIbddr+3DPwgoxP1q07D+uB0Vyo86/DY
         Y3wN0pGd0BswQiwaYb0X16KQQWDafBQnRr3/m7v+anAnVuWBP7qWnhqjUERrSFWwLV4o
         eT6ig/ao0lsIjo3IEAYTQrJOt3FLqUOvlv8pj7uM0yQC8rAJTrInL5gneOMqomO/rp3V
         X3/nbrCNQdHJcqAF6H4CJBFmsJw1pjn5moQEaqbLjyvfAqyQFvMAb/pqSbXz9ojdrYmi
         l2IKCt9s5pYm1OEQZbt+E5WMNxxV/MFydAwvyl++mivZ8rV/6zH3de6XY/mfoXRWbKgy
         B6lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820681; x=1727425481;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18bFlmoHAy/k1n0ja9d6oNofVKOr2ShiamuID3ftTZo=;
        b=n063uJQERmiJTKvY2QDyAlZL6yd/97K54JKhmrcXHhEkwd/GkJ4ahJs+1qjRjaO3qf
         TBBKvee3IbPp41vkO6UBT503ypsUqkcAziTI8S8yJ1vQ/pEIhQi2ofkxd0hWaVI5X+7A
         nK6sjBtGrgS9U/9Kg1r3CO8PN9zp/1ZvPDxtnbVeX5kgy5BbU3U8o2q4OwkKLf14jUWb
         DVMQEGYJLxkXu2MCLWmL8Q6V3NYbo0YSUscQgLF4AFP6mEF/ayhEbUtoaZZmGpotbf6V
         BA24qbmTeFk0jGLqdVJkrtAj5eW2zxktZJf+O/zt0UCD/5NSeTIH0KEax2vN5nu2M8s/
         eFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuT6CfzFhGjF2qoCnzaLPG98gChsoLXLDJoQ5uhqPSJTJ9qyhqc+db4l9qfQr/LtXUMuakEUJL5p1WGPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSBQZNO7N3g9BaC7ebmTbmri96pjI9J4aDuu7nWAXUTwk0uMX
	sR/ti3QSZ1/SLuLPfoUahqwO7cTxeh/VliYlhDo0EO/t3X8wxtGvfMQOO57c0CU=
X-Google-Smtp-Source: AGHT+IFSZtKOOZ0ZGtfJy8TSl2mYrPI9rQ+0czpD45eDZJ1l4epVAz6I6h9Cl8Y9/3UZm+rxKYdIXw==
X-Received: by 2002:a05:6a20:cd0e:b0:1d2:e4dd:dba1 with SMTP id adf61e73a8af0-1d30ca2006dmr2657696637.25.1726820680549;
        Fri, 20 Sep 2024 01:24:40 -0700 (PDT)
Received: from localhost ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd7f874fe7sm1252593a91.30.2024.09.20.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:24:40 -0700 (PDT)
Date: Fri, 20 Sep 2024 01:24:40 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2024 01:24:32 PDT (-0700)
Subject:     Re: [PATCH v2 0/2] riscv: dts: sophgo: Add i2c device support for sg2042
In-Reply-To: <IA1PR20MB4953DB82FB7D75BF8409FFF4BBB72@IA1PR20MB4953.namprd20.prod.outlook.com>
CC: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, unicorn_wang@outlook.com, inochiama@outlook.com,
  guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>, chao.wei@sophgo.com, devicetree@vger.kernel.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: inochiama@outlook.com
Message-ID: <mhng-3dc6780d-2176-4f40-80af-ecd595f5f361@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sun, 28 Jul 2024 19:12:51 PDT (-0700), inochiama@outlook.com wrote:
> Add i2c dt node for sg2042
>
> Changed from v1:
> 1. split the "interrupt-parent" change as a separated patch
>
> Inochi Amaoto (2):
>   riscv: dts: sophgo: Use common "interrupt-parent" for all peripherals
>     for sg2042
>   riscv: dts: sophgo: Add i2c device support for sg2042
>
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 54 +++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

