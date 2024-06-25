Return-Path: <linux-kernel+bounces-229045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 212EE916A29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C713E1F215D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78816B3B9;
	Tue, 25 Jun 2024 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIswairP"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EADF155336;
	Tue, 25 Jun 2024 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325348; cv=none; b=ASZsWSXoUOrN8XjlbzuHO3vIVgd1rRWqY2h1qc+TzjUf+tmIwbPGv0t2cCH52ArT4gF0A8wYv4csXu4ffC38a8rLTvOzYpxs/8LmhjfR5dpGOXiY754C2BvTB7HNpugA3sU/p8mRWNlsm3IuavYNjT0aE92kv5gkde6/RoAe+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325348; c=relaxed/simple;
	bh=wnPvsC8e0yOKqSzsqPFIBHLz+FOAW4Icxiaj/GUeQaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIRwP3tpYE4QeP9Ui9XzokpDc7xubNdrUtg5mzP95P88b0aw4CsYekVIzPGkDpJATHYPXlWEGR60VI+Omj4BN2P8mP8x41SO3r18trYbWSxOmQZfRJR6irLjCaqY8if50emsJPpH6iDt8c5YbpOt7RW5yJYiJMGgPrD51gAw24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIswairP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c80637ee79so3835327a91.0;
        Tue, 25 Jun 2024 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719325347; x=1719930147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDGsqPcbEpd2LyCxfncGiISuzeJxwCMrz9xRntGBtZ8=;
        b=YIswairPb8gqQUn9PE3o0xC4dx6XAuKptA05jNbxDSfEtYpRcNELtI0mC38tHcZoqU
         cw+aSUqzSq4M22kmDA25rVmfXy7TcZrkJJUZvI3Jl0ujQ9KB6VVxo22A9AN5rZlu1y97
         FlShAmuNNVCZ3MJ/nreben/66AlDypDMMp1x2JY/ODxNHJDwMZegCmoxqaDWYDi3lfCX
         xOZg5bDFmUpaZSvqusFzv9ZbkyW0ffFxdOoS7grx/4h4rAJ1P8q/O0zWyYU1VZTuj4oG
         yP3KO4OBVrSpK0D1hGELyT6XTINuCgXd6AmU2H1k/4td7GeLG+TcYZxp81cmYrOEnvuw
         6w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325347; x=1719930147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDGsqPcbEpd2LyCxfncGiISuzeJxwCMrz9xRntGBtZ8=;
        b=A70nJlUhzTmSgpzG1xzOuuwAq7X8k/H3ufzGL+hUxZ/VQg5miDB06y4gdea9o4tEfE
         WnHmtg4WzTeJS3+iJibNXyL52VH1F9XhgamiIihDBPMTAda8PN2eSQYvsJjSYK8W2IoE
         v3dfPj5w1qj/WTIrqKNjxNYOKInl1Y/5yQguf8+izkul1td4Xmbfxw1GJdIormrKlUhN
         KSQtis8oX2xwk29lQpBykRJG3duT4MJh1O81YnYsmRRHcJfAo9eAhy1mVaxhbKVIdmOy
         Pnhafmn1QG4pGQIk9G6LQWsffEt4p290HBsCP3GNojTsgaeOJ9+N96sDyGOuk+Jjf4ip
         VhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzIKxWxsQrl4CznjWLS97GCUaMitb0CRtWyBpx2M2vHngVw8JpornQauRqHkTSzv5DmrKxZBgbewHzzLfwmwDWFj9Um2hIYzBvGvbk
X-Gm-Message-State: AOJu0Yyh/SFNQFKAv6Er/Qneh6HoEEeI4VIR7xQG5ZNa4Y+Cf4HLvd6D
	45YCKHfGlP6L+OpNQgP1L6fAN+NAoi4JvUEJTjEUFQS8Ex/xeGbuXm7XcQ9G
X-Google-Smtp-Source: AGHT+IFNRdXhvs1wwkcBrpk4hY9tumdf4HK02pblsvKehBcseIhhxW0iGifDQSzGb7umbqOni++Usg==
X-Received: by 2002:a17:90a:d490:b0:2c6:fabe:b2e0 with SMTP id 98e67ed59e1d1-2c8613db148mr6292425a91.26.1719325346698;
        Tue, 25 Jun 2024 07:22:26 -0700 (PDT)
Received: from [192.168.1.7] ([159.192.83.206])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2c819dd0cf7sm8740279a91.48.2024.06.25.07.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 07:22:26 -0700 (PDT)
Message-ID: <bb98f8f0-0326-4fc1-8b24-dd35ed0b80fb@gmail.com>
Date: Tue, 25 Jun 2024 21:22:20 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drv/usb: Fix the issue with Realtek USB wireless adapter
 AC650
To: tuhaowen <tuhaowen@uniontech.com>, stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 linux-kernel@vger.kernel.org, wangyuli@uniontech.com
References: <20240625070724.22044-1-tuhaowen@uniontech.com>
Content-Language: en-US
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <20240625070724.22044-1-tuhaowen@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-25 14:07, tuhaowen wrote:
> Due to the dual-mode functionality of the Realtek USB wireless
> adapter AC650, it initially presents itself as a flash drive
> before the driver is installed.
> 
> In Linux, multi-state devices are recognized as storage devices
> on startup because the driver has not yet been loaded.
> 
> As a result, the AC650 is identified as a DISK device at boot,
> preventing the use of its WLAN mode. The issue can only be
> resolved by unplugging and replugging the adapter.
> 

It can be resolved by manually ejecting the created cdrom drive or by 
using usb_modeswitch which will eject the drive as soon as it is 
detected. No need for unplugging/replugging.

thanks
Lars


