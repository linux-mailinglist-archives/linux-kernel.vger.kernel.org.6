Return-Path: <linux-kernel+bounces-369984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCF49A254B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE3C1F2781B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3931DE4C6;
	Thu, 17 Oct 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AzV2cZwP"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD71DE3AC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176022; cv=none; b=U3wtFIJNMGsZpPou5B1d0RU5/79J6b1oPC6rLfzPsdAEtcOTc7dsBgYuQr6iUY7V1o7o90JirVh7UqodF3XP96vG8MeGi2SVYd2AadP1BoOkKHbvX/JQk3jdof6Q6QhRe5LgDsmwFmpQi+kVhQp1IuMPl4sXs5/CWdwmsLMJY9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176022; c=relaxed/simple;
	bh=Ow7lMTiP6/qD6JhAKLFfdugsTWEDHyesPb0Umrt7cm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GGN80WRP3osHfmIWDmbB8KPTeQSsa/r90qIKMRwAJM/O0lhcUt6yj+0SoAI1d0Wsb7kc34vLuGhY48hiudCzz02bypUYYjeElyaujTJgypHrTEkXhX7voj7fyLthbviE9jAmraNhTmbbnzlsgN6lzhuSH6+XgLbcvsLMsJwPEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AzV2cZwP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e5a62031aso688308b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729176019; x=1729780819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7NPX/sN9QKmJNg/bLGonITnuw2jnMDPIt8a9yGDiPA=;
        b=AzV2cZwPfxrgNC9qzhJ+SVbvNjC6kV+yklbrUYzeu6oHINmg9D6fwdpRlvjLfrDzT3
         KdPZMhVSI9ddjmbckKwWDvgEZRgX48w2pQTva0+nFeTs2zG6m6YL4iusAWHyzXAlPQu4
         uYvC+DIoWJab4v4UD392J0UlHlT9WjF6ZhRxq6bOSuhBo8aHmZ+vn1rbuxIfEVUjFzI8
         Ar0y/yJ38E+yf1fIQmc4JcJRGcevpmCncvUYM+lh5sSUetq+eaHYj4+8g7aII1zhHjDS
         e5RpTl/RBKqp9B2cbwPocRq8EH1CHkvoP4HL5uhdUbzzvQL1j0uPBLg8IWYhYdvBV/4E
         1erQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176019; x=1729780819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7NPX/sN9QKmJNg/bLGonITnuw2jnMDPIt8a9yGDiPA=;
        b=W/Qm3w9LLVdSxxI1+rO4QQAy7kWRk3a2UzabgDVFRfrZsczxnCfGnWMCj2SmooM/U7
         texC8okKYulr6QUiRgVEUsVor/V9JcjQemsgrUlqifoQpoc76B+5/YjL7G0KHstS+qzX
         9yJLhv4vMpTNO6FPHF6EouBkrADgmr+8MWJXfttz3oP9ZWg40azHVsddfIyyX1xoxiyQ
         CxlWjTd6PSjr+40D0//4b7VcFg7VxZRXASgTGG/+FgFQnh/xy0yfxHjO4UR9XrbTCfQk
         gKNxS+x4QOUiggUJy7c3n5pbgz2fRegYE1IRGbD3AY/xYtLeA4bdOXqTJ5Bg3XCaIZsq
         zn9g==
X-Forwarded-Encrypted: i=1; AJvYcCXdHm8hxbUJBbx0tcTd7dJVhwPgk14EdNKHzSWkP5o5egLFOSvF/YcrupWj9AQw9J3Jk4/xgjyX9GDRRY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aEPv12FhvyxrVGuiuurwbvDNHjVrFx262LN3AEOdweC3BIGU
	K4WktXDbKLSx2HMs3xB7KeEJRF2Qo+5FZJ+59c/ELGXew+orC00kP+bfrkknlpA=
X-Google-Smtp-Source: AGHT+IEDqGTla0q7wLxKsCMh5LMNeOR3elOwCYlRT/VX2aEuOxOFH0r0wU5YyHRM1NAnWfQ3zzl+fw==
X-Received: by 2002:a05:6a00:198a:b0:71e:21c:bf1b with SMTP id d2e1a72fcca58-71e4c17c0aemr29243211b3a.14.1729176019486;
        Thu, 17 Oct 2024 07:40:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773eab96sm4951444b3a.94.2024.10.17.07.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 07:40:18 -0700 (PDT)
Message-ID: <a395a18b-3478-45dd-aabd-ccc9d0851318@kernel.dk>
Date: Thu, 17 Oct 2024 08:40:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
 <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
 <20241017141314.GDZxEbenNT6XF4jIaA@fat_crate.local>
 <4d4bf52a-dd91-48ad-8949-198b2ffbc9da@kernel.dk>
 <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241017142707.GEZxEeu3YHvnEMmd32@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 8:27 AM, Borislav Petkov wrote:
> On Thu, Oct 17, 2024 at 08:23:10AM -0600, Jens Axboe wrote:
>> Yep, it boots with that added on current -git WITH the microcode
>> package installed.
> 
> Ok, lemme go stare.
> 
> In the meantime, is it in some way possible to catch serial output from the
> box with my patch?
> 
> It should be dumping something to serial, a splat or so...

Maybe? There might be some way to do it through ilo. I'm not near the box
today, but I can take a look at that tomorrow most likely.

-- 
Jens Axboe


