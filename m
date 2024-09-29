Return-Path: <linux-kernel+bounces-342976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6F989561
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 206E51F22C1E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127471779B1;
	Sun, 29 Sep 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1ZcAlm1"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611215E5A6
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727613441; cv=none; b=rpUCvaIC9uuu8OjAxg3gqWcfsPmVkDnJ92hb3m2Oq/q0PFjwmHDYscbmGreYVRve+anYJvKYS9A1UZu4IhMgeZdx18qc5tiVJu6tmgQzyhSyjPcD9Y1KUEAL8/AooTVS96bku1OvvZTsPqggFlyKXywqIB7tBQt7h3MUCAPiqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727613441; c=relaxed/simple;
	bh=ITQmOq7pkgWvkALy74DqmWYWUa2uLdab72AZBmYWiSU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VhKL2JBGawbcLHzs1ET/+MEyk2nwI+3bkH2bEai4NdRrtfefhXCcruGaZgfe9xl+VK+3CdKoJBMPbNxFYENXN5ADTNIPXkQfk+XrI+jM47pDIPOrNWoU8aNOJ9xENGJLQPAwNFthYO8Lz7h6cbfOEXSihiDA8I7Yz2HraJIb0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1ZcAlm1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42f56ad2afaso35476275e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727613438; x=1728218238; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJn80TxfYTlmmnqMwhBhjRaqFPnqFxat8PYaGTsCMD0=;
        b=G1ZcAlm1uLCyneqRyG6SVZjFSPCqLayDHzGhqFO5SuzfPQrDKDeqrKgQQRGq7HIzzf
         b28vM2tTeY2zfKHq4lvuGAMVY9hYADaN6jONB0/hQpT5pO5FfYIg/+ZG5GbCVIl4zQiG
         3E/xReEE3ezL96RuXHQlFGFO2y/15DnaOS+NU33wVRfZ/X97yNihoFIqk9dlCWfbGLfX
         k8QbUAbbKYfQcWlcpyT7E/6b7OAJs+Q2zaH9QIcxt5meBaa7/YOeEkkHhYXoYH36bp6d
         bSITNwptG/5ilV8s3qEc8bR5BrOhb/YQV0QYoYv6QqK/YLPB9ML6VX+uXA8euNZt4OFg
         BLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727613438; x=1728218238;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJn80TxfYTlmmnqMwhBhjRaqFPnqFxat8PYaGTsCMD0=;
        b=KXg06JQXpQPUes79Dm7QEjKwgUC8QqSB0G3K7kEJFE0n2EmeHFpuKJA0tJqo32J/y5
         nQiMfl2uluZy9ir8OiUfQKbo+XDly8U7T2rGSvABdTz5OwecqjVi3gNSAxyN+I2VK5gV
         ny0DXEnqinhdi5Dg+jCSn0bu22LwGL00kA+DcGtgYV+QEwAlkSHTO9WcRRFsBuhj45ph
         72rGe2spdeMZsC9QVu4Azi2CWJWEXjA82deWDhN5TRq9dmbi6C2PXr8guf8+dbyiwltC
         9UAQrgQJvPvtv6SttnPZaVqgiirIHOub5CLXDqlwKt0OLfjT4aLynoJY057M7Mf4JIFB
         qgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrXMdvX9QzMQpa+vTsppQayB6ostRB+N88/FjVeT4KleY35XVNQihmHPELFX8tpWu6+pyseaTChzFeY44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsrozijTAqHv4hNAuqE9sEYzliQVVUveanOD4GdeqjbQOKJvq
	4bh7RRkr4CmiPRjzRIvkoxHOqwtUJraZOryzkyq9wdsD1vQEl7DL
X-Google-Smtp-Source: AGHT+IGA6vxOQMNnYoiuQMJIUo7Foxlfojd8CKK7eJWbt6HadvBz5WZPws0VDXL5y0PmtMaWD3509Q==
X-Received: by 2002:a05:600c:4f14:b0:42c:b555:43dd with SMTP id 5b1f17b1804b1-42f5840e242mr88082765e9.3.1727613437966;
        Sun, 29 Sep 2024 05:37:17 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a54fdesm124666515e9.41.2024.09.29.05.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 05:37:17 -0700 (PDT)
Message-ID: <b7b646d2-6987-4557-94c1-5fcd8d3d5ebc@gmail.com>
Date: Sun, 29 Sep 2024 14:37:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Micky Ching <micky_ching@realsil.com.cn>, wwang
 <wei_wang@realsil.com.cn>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Justin Stitt <justinstitt@google.com>, Julia Lawall <julia.lawall@inria.fr>,
 Soumya Negi <soumya.negi97@gmail.com>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [RFC] staging: rts5208: Proposal to delete driver rts5208
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sirs,

Wei Wang from Realsil contributed this driver in 2011.

The following points let me propose to delete the driver:
- This driver generates maintenance workload
- Did not find minimal documentation on the web.
- No blog entries about anyone using the rts5208 and rts5288 during the 
last years.
- Did not find any device that may has it in and is still available on 
the market: Dell Latitude 2120, Lenovo ThinkPad Edge 130, Lenovo x121e

The staging subsystem needs to focus on drivers that support usable 
hardware that is available. Newbies can then get the hardware for some 
dollars and play around which is fun.

Please consider that support will remain for years in the longterm kernels.

Thanks for any response about your thoughts.

Bye Philipp

