Return-Path: <linux-kernel+bounces-203112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FFC8FD69B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F945B26F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B8B1514C3;
	Wed,  5 Jun 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8PYSGhF"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBBB13AD3A;
	Wed,  5 Jun 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717616130; cv=none; b=mysxtploqR1GV3TuJlsRLkt1Pl+ICuYgAc+IKHnBIPWn/VnkhxUt5VrqO0FgV5ggkB8XfAZ4pqZv9QX5isDHZC+jnuwqJWKrN7eluhHYd3tYiCL5CuZPJVwb5VFen6NW6Px2CiI20X+Lkl7O6AbrH0J5+UQZUAFXXbJ3/jqEvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717616130; c=relaxed/simple;
	bh=xMW27uLyiggFZyQj0ua1+x+6CiSgEJa/oN4WUn8i5+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhysOeMMILbnpgaD7/69ibrLbxC5annhe9ZuHh6trbD9AXIJF+RvhJd3AC5jrhpV/ZIN95VanAwQPv4gUt7Bi5LbR8tx2upGb1hfU7tmZnCX4uEJOTRN7CNPoWiyFiX6Az091YKNPkYnNQN0ivFqRRzh4ahQt5B3ghXFJCNFgMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8PYSGhF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4213870aafdso2396905e9.2;
        Wed, 05 Jun 2024 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717616127; x=1718220927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMW27uLyiggFZyQj0ua1+x+6CiSgEJa/oN4WUn8i5+M=;
        b=Y8PYSGhFdYFQL+LJE19co5YpqikXnJaX+p/oK+y9+DpQcfLo1r9j2Kj0sOW+l0eRv9
         VBnhkkFqzv6F7Uk91PVEgkKjSTI3fCDujp1nFpero+9n4u1apSwzImMHyKs1t14Fz2PE
         MFnrj8tru1Ue6rZGx1RfxWupU6CtayCb0bp0L8ZQZR/h89PRVrBgja814EVuYbmR+kaC
         D569obcanO9M32StJ3ET74+Nh4d8jYk4Rfk0gUyPqIAHaBM3vPNsB4n7C2JZ0DmsjRwb
         evPhE3e6sZDmldmqTbKTeKuzT6FsyYe4vJCD5bZpcrgmGUwzGP1b1V+H6G+q+TzXp6P/
         eXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717616127; x=1718220927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMW27uLyiggFZyQj0ua1+x+6CiSgEJa/oN4WUn8i5+M=;
        b=gq6Uq1UN68g++Zgaq6bPGfYj7RVWwoOFUhcBtBan7U0M3lI7yHmxj8yYIw4q9E7ao6
         ZAHpm7PqLRePpljqWRhgSFUlTuZny0Ye78tceaLDZCQ4CQ5MzYnfFXbt21vLNJh+lV7f
         C2zLTfA2Yuyr4eNsbxl3nKV+CqMak3qYBTJnZYAPfMjWz2YHnrfIh3zXBfYa1kdfcJux
         0alBQgCyxGPgzX/WIaxZ01ltyCX8J9Uv3RQZzz4b3WTeT9M4Oqtybqu+zTo/Alynxs3q
         rRvo7uxmoZ7przFtVPvBc+UhbDOX/3Ycjb/EPXS6LOP2zR5tCH9x3PFLXbeFCP3mFvms
         l+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU7tQcvPqZj+u7ikyh4OKIkSCEJVAoOmkkKyy6Y24Pn9FUe9KNxU1d4xMdtNWm7uCSMz3TNw+S0AsDL5aZrsheG+F4NA849yM9+6RrXCAIC8YVMPNSrkaStDiZXCnXA3jQK1mJELCZUIYwaHWgWhw0A9iuaw67c+fjqGoTsKansC5Pv6w==
X-Gm-Message-State: AOJu0Yx7Wxkb8oRpz4Unax/qX5a1kY7CojefUwyra6p8hLNgjKl6YqDY
	xT7HsX6OGEHkDjGwadgx19ko9guZjWHTqOWS5iwdneh4hOmNkyQ=
X-Google-Smtp-Source: AGHT+IGilZT5e7h6ib58a/iB6k4o2o0Eiurb7wcJkYAHI6upyPaEKRprxFJyQN2qytx58DiQCBg9YA==
X-Received: by 2002:a05:600c:4e8a:b0:420:fcd:10e0 with SMTP id 5b1f17b1804b1-421562e4000mr28528355e9.15.1717616127301;
        Wed, 05 Jun 2024 12:35:27 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:5211:58fe:dfef:c48c? ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68b8eb3387sm666988366b.155.2024.06.05.12.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 12:35:26 -0700 (PDT)
Message-ID: <7ee2d114-f8a8-4f67-9b50-aa7ad5b46c7f@gmail.com>
Date: Wed, 5 Jun 2024 21:35:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: rk3128: Add HCLK_SFC
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240605172154.193047-1-knaerzche@gmail.com>
 <20240605172154.193047-2-knaerzche@gmail.com>
 <20240605-crummy-racoon-fadc5a6f5d25@spud>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240605-crummy-racoon-fadc5a6f5d25@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 05.06.24 um 19:58 schrieb Conor Dooley:
> On Wed, Jun 05, 2024 at 07:21:52PM +0200, Alex Bee wrote:
>> Add a clock id for SFC's AHB clock.
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>> NB: I've added the new id at the top of existing HCLK's, since adding it at
>> the bottom would change CLK_NR_CLKS and therefore the ABI and there is
>> plenty of "free" ids between PCLK_MIPIPHY and HCLK_SPDIF.
> We've removed a bunch of things like "CLK_NR_CLKS" from bindings before
> and advocate against adding them. Patches like this being the reason
> why..

Yeah, sure ... I thought removing it would be little out of scope for this
series. But as we are already having a helper for finding the "max id"  for
Rockchip clocks, I'll resend and remove that annoying macro and add the new
id at the bottom of the existing (where it belongs).

Alex


