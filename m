Return-Path: <linux-kernel+bounces-540662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D51A4B375
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A876016CB71
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3801EB188;
	Sun,  2 Mar 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh/NnD4q"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2F1ADC6D;
	Sun,  2 Mar 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740933559; cv=none; b=YZqIOcdvSXs4yXsJk2CaQYYh9WXlwnTueuEam0Dy8b54EVLjWeLzffpmDQeUg0LxrRJzj2cmyF2Gt75tpwkpL5EYhMyPAP7gDZhOLGyn9wWYhMdTKFXAHwsOXv5Q88DRBvXZSbHBHPZGz6EHJSluwuGSTnG22bUJe7DIETNz1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740933559; c=relaxed/simple;
	bh=+2FYCPMtxQ7BDEqKW01Qron26a/AfyYwOEH/vO0a9Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sp8X68VsnVJrTL3+wn1jvqeHaiPqbzX/Ahse4Gwsmi4lP8bHOverGVroOuvFoyAFahV9f2n/m7nn943V6OCBtBAGSC9Lg3L9GssZjmd3uyhgdfeCGtg3xo6c1j8fGF7ZOXbHq4cF++3jzPhbIfLIjvgrGM7jnQTHVSm6IhbV9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh/NnD4q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2234bec7192so42621555ad.2;
        Sun, 02 Mar 2025 08:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740933556; x=1741538356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEZnpj+r4uawVOJAqyskn+cZpljNo4FSfIPc4elSCog=;
        b=Vh/NnD4qMgbiNYDgVfEI01ZZkeb4a3k8HSiHkicakJX9Xx7Oj+PrtP7pYONFqgJlTk
         s/5CK9LsQjM4yFH6QdIm94bmneoTHIL6NrrVTAQb0e6M9rSXmGaJkmHaFlQBV8OXtaWG
         cuaUhuGLxqehrb3cYuVPd1fIsaPRiQl9TF2hRbpnGu8kbXjqZfqfPhNKtEHjSGQ06OHS
         Sxk+coniAxCG/HPd+J9NwaNM5gHxyA96B8aOz1TNBYijPM5EMH/81YvzmUOB/Vx0djdv
         fjeDXbrytXKlEDZbsYhbfdob5fhnezOetPWnoLXyghTJs+XXf3l5S9vBGMWks+wvhNkN
         I2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740933556; x=1741538356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEZnpj+r4uawVOJAqyskn+cZpljNo4FSfIPc4elSCog=;
        b=V0gSUMR/VRCNT16LPOPUMpbNQcRBXM/D6QjaoqRfwzI3O2QgLiFUgqbwLnYDuen8NN
         apPFatqgFF46DpcorkxFDiQCpuQQpTj/8jo81bdOl4Q0Ny7vXMSsDVRAr9Ga3XMohffv
         0BNG0r70QUCe+G659irZJwIxz1p87Oh0W0Z2XzoH/hhqPwqyTqg9kjoo4Rv3A+dApPNm
         5wY4B4qZd7HtHlU4tDwjTKIQC2vMLsbIRdZaf30nOf5Bzais8+feMry8AoiduMcOmT2K
         +hOO5I39QrS2NyP1RtI+TDOP6BrUNsXCCPpsm0EOs9lMTj2UTZ3lXR7qZx0yAuGLm6Mr
         0LZg==
X-Forwarded-Encrypted: i=1; AJvYcCUH4dR6k2zyYRszSFLC4RDVaFDLFjhn9haIo/cqY8Ts2DeaRX/O3qL3CMZnijf6OHydk4c/j8uKVjI=@vger.kernel.org, AJvYcCVY6g976o0XaWba4opM0pY5VcrfMEvjrw0QU2BvtTzBrimbJHOa3GJHxxg/BqXfZkFty9Erzrnq1+8sKQ9s@vger.kernel.org, AJvYcCVfwruwme91HCW1cYQopnpPZ5+y6ub/zTALqDAWH8U6EdvkTR8JcPeFxhTcIC/ICpqUSms4ojvj9GdLw6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf11FtEAvTN8ynnPsFQhIvZiu78jiaAlsKCLZQX/mO0GhJJjDZ
	hFOWhKUkd3LQtO/z4AtpKkCxco3Y/dCup/MMOsOvospjGyM2zRVx
X-Gm-Gg: ASbGncviXmsXkllgfWGhf+PLftdLCt1QzOclUGJ/fNlVnq0UY5El9GTGUCyyNBjgRx4
	O8XGFTDZb2dlI5o+Q48Q8HRqen3hqYaoHmTm6aHg9hx9DpLgV0CqznTSz03bVoxFHYv4ml1GIBt
	0l9ZX/COa8mMnOsrCjyCKiU60DCcgn5IkDKxPiBl+FoEqU6hf6ZQfmzPL5nqXaiaXa2R5oNGb1s
	lzrihstzjMiVPJmjZw5vOfUBYIV5LbMffT5QI0v82rgBGTiyuACfcgEsLpFVjiKRE8vFZzrt8ms
	82GLx2741LrRODchlTImoMwzrXNsqaSUr84n5d/XqZukGBwqmiVSRbu2nA==
X-Google-Smtp-Source: AGHT+IEklBC+O9FjYqjgNzUjwRT3qP6ALRqg6gym3l/86PR0xxy3LZqOXkWBOt1IbIoscjnoqqdwig==
X-Received: by 2002:a17:902:cec1:b0:221:183:5bea with SMTP id d9443c01a7336-2236921ebc0mr132802815ad.50.1740933556478;
        Sun, 02 Mar 2025 08:39:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505293ddsm62129375ad.229.2025.03.02.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:39:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:39:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: jdelvare@suse.com, corbet@lwn.net, eugene.shalygin@gmail.com,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hwmon: (asus-ec-sensors) add PRIME X670E-PRO WIFI
Message-ID: <b7d7c4a1-58be-4cd0-9f9a-da7b05ba0744@roeck-us.net>
References: <TYCPR01MB84377BEADF97E8E7554EF0CF98C32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB84377BEADF97E8E7554EF0CF98C32@TYCPR01MB8437.jpnprd01.prod.outlook.com>

On Tue, Feb 25, 2025 at 12:25:06PM +0800, Shengyu Qu wrote:
> Add support for PRIME X670E-PRO WIFI.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>

Applied.

Thanks,
Guenter

