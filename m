Return-Path: <linux-kernel+bounces-373813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B09919A5D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA0EB21288
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B971DC07D;
	Mon, 21 Oct 2024 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bnbvAs6U"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399F1D318A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495928; cv=none; b=A+Chh1WEFXj2z0ykX4Z5EGTjCZJ/BS4g+/YdiTvbimcP2+O636wVNoYSBVEEmzEZbgEg3rqFMG8T4mipPaMR3CM2ud97X9vBUmOJyV2oWg4zM6b3NiVpu/U/vc8u8PV8XgaPR8Gzkh6zwxkJO4jL+Y8sDauGqnOsWxoBiviRFn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495928; c=relaxed/simple;
	bh=jsFFDqK9j4osMzG9Hf/Jl4FKrfH26gMir5LU2zRCC2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTl8PAuNS0dwa4fPLKD2O9mkWTT/wsLVsqsw7dAG7DUHQkWystNy8PI5TWMjEO1lgqEEwtZkdOnsS8rj1Y346OiFNkFWIPH7HK0+6bOLxTOhq1DyQUrKZov58AoyEVZO4428nymul84UfpXt7jMmKuS2+yi5qSG+wObDoUdGMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bnbvAs6U; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1298940E0184;
	Mon, 21 Oct 2024 07:31:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DqzfQdhGwoHO; Mon, 21 Oct 2024 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729495913; bh=8SmcL6UZK8KZbZ3fnpWgyhFG2IJfwd0RD8+4bVI03e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnbvAs6Uc/1eJRySZ+Zs/AgbsdS+/d5tVc/4fl/Aai2a2Mx7tFzpQlrZnxQJPZnHT
	 5XpN9KRgVhmBk0mTJWIW3H82wUD3V54QlwzbakzpSCsC0gEDWYWYCNIXssA11kVMBb
	 lmwBgRmioAzDdCZ40rzSLfXKRAK+vbFVXbrGz0W/uW20TBAt8RC9mdleIp0x2hIuz0
	 IeXqkM6gpkg8A/6xUro8YpDiO2Qj6nIeVdP6mImBw9nFoveKUBr8TJws7u1lpgO1PV
	 kSCKhgEG4WZw6ShP8hfCc0QRu7cs3WVv2OqRxkV0o+VZ1X8bMJCKkMKAqxi/OH/Va4
	 TBAckZQrz4MXoyEJU1SwCBQFtzB73tkKDlYCw9DCOnzHciMt2U3knea72XXHj/7Fnm
	 9W3lVVjY/a5wlz6gDuDthuFnrr8+vEipu32sQ/JYs1V/+3Grl4S57MPjBHACKURf+C
	 YYeto8n5m7B4NVBLqLyfnDNP4Od7jbI8r5hLpQe8LjYDz8sDm0Lhw5LZbO1PCGGN/k
	 ZpKoSZFNLxVESQd5UFsWdz10PUYtay1QXiWOn0hRB6b0NgIau37/JnYQYY8bIj9jIF
	 bLzisDTfYiPPkxrADK6gYK9fx9vPQ/EiPz5uuB+X9SJHBg41S+doCic6OeHiKlOAcD
	 XrpfDWN53H3xAl34yqqVKMik=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BF9140E0194;
	Mon, 21 Oct 2024 07:31:48 +0000 (UTC)
Date: Mon, 21 Oct 2024 09:31:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241021073140.GAZxYDXCk02lSrG3-T@fat_crate.local>
References: <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
 <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
 <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
 <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
 <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
 <436b4fc7-6369-40d9-8e88-556cbf5a5687@kernel.dk>
 <20241019232138.GDZxQ_AtkqA9iAR2td@fat_crate.local>
 <b2fd70bb-9414-49e0-bdb8-5c538f247dea@kernel.dk>
 <20241020121819.GAZxT1CyR_5vLLZ5e6@fat_crate.local>
 <df217737-6e2c-41fe-b558-3e2ab6dc0d9e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df217737-6e2c-41fe-b558-3e2ab6dc0d9e@kernel.dk>

On Sun, Oct 20, 2024 at 06:47:25PM -0600, Jens Axboe wrote:
> Works, outside of waiting 3 min for the serial console spewage from the
> patch! But it boots and it's happy after that. Attached here gzip'ed as
> it's 1.3M otherwise.

Thanks for testing.

Lemme write proper patches, run them everywhere here and give them to you for
one final testing.

> I get:
> 
> root@r7625 ~# echo 1 > /sys/devices/system/cpu/microcode/reload
> warning: An error occurred while redirecting file '/sys/devices/system/cpu/microcode/reload'
> open: Permission denied
> 
> and no output in dmesg.

Right, you need

CONFIG_MICROCODE_LATE_LOADING=y

for that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

