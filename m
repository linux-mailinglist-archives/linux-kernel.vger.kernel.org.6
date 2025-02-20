Return-Path: <linux-kernel+bounces-524255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B472FA3E138
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E4F3A1523
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD88D212D68;
	Thu, 20 Feb 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Pvci0Of5"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167520B211
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069719; cv=none; b=Y9X09gjooNh/DfSUOAioYAUd70ZGfYSF/3UPso7hrBERtUKwkVzw6PJi+Fm25zh8z6LgE5KyqQ05NekgTwVIq1l7sx8xGokG97vlhGu9PspUKyczaNfGCBbByotQuaq0j3PZOZtH/PbGqieU25LP9+jZ6PVnROe0kvS/dByRscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069719; c=relaxed/simple;
	bh=hd00ma4pTGcrV8uOUJcNNlxDYUowsX9K//uXWoKKs6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcokcXWpu6E62eJCNiIsut5u11J5JzGyEOGaATo9zK7Utz4+VZztnYvVomwYS/Q+yCZUGZeFMwNVq6lHe4qFdOJ1799cETT8w/dLqsNOXhol/ZfKF/BqycK6vLgo2qFy3p/Zrl24eXgmwaGm5WCY7/rmjwFh825lOvUuR9R58Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Pvci0Of5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so689591f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740069714; x=1740674514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdrq9JfSs7AdIS3P3Dy/vFSMWNEesz5Pa+4AW9E1gwY=;
        b=Pvci0Of5ibypY8nHC5Xch7WuSuV+J0zlqvBAU0KLJAdQ9fNDCbtBLDTqViq2wPWPPN
         hvTVog7QrLuqqQiX7C4PjnbE/e4w3f8LdCkYaGQlpv7RblSyOa/IeHb/k+MaPAWQzEyJ
         PQIDXJZhVR9KaPKR7Z4kGgyQvFUnrx7PsTJoDS2J1qokqIyYen49LXxxPkfHYpoEtb1M
         ShoT6ejPw4GDTQD+tFrV0Uuu+2Fu9SEOoxy3wb6ZvRHKmB6sArFrbAYL87o03ShcidQQ
         E5Pdki+a/GVV7F3/BL8G1NNp/FItf5BNqFE/21ffcyM3DGsKQodgPYruA3qUYa9dch1M
         xVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069714; x=1740674514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdrq9JfSs7AdIS3P3Dy/vFSMWNEesz5Pa+4AW9E1gwY=;
        b=dixjC/msJqMlgcwjJAPVWVEiBtPYyKAe6BH1v7n6y9KTOqfh9+fir07JGCyX6agyqg
         r8Pza3TPIsLVMJxVdPTdZXRKfLjdH0LtVceunX0kz+ZAS8Ls9MLDG1thq6dcAIyGp+J1
         cTHQDMuXxy2+gu63y8PN9V7d66NxpNNRrD74jcof5GbKJ96k+3mlOR9JjAuC1SezFzmE
         RAPDi1gHcdho5NxrlIYLyTnOrIDmDT/0UKO+Uug3L/Hg0m1NEsVvbpH6GU4lpvXl5qt2
         h2Hc+maDoOF3M1ULPD4wThO1wii/d9Ms6bXEauinOujn5tEA8eF8BTSvwYXdKIDZ8EeZ
         7xHg==
X-Forwarded-Encrypted: i=1; AJvYcCWBixdPF+s6yzf9vs246fU0yrXViCU36MMiGVHjaODeruCfkljE772QPmv3wIZ2iwe+2aCz7XXpy/7cBYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PuuKmoQLCOGavieBExlh4E91VuLlBZDrTwTskyL24KYjOmev
	h3A+dk/LG675/CvbhTBr/LZ+a7HYuEwPG0V4hYsf6Woh6wUs0+fjtqH2j6Q4+k8=
X-Gm-Gg: ASbGncvqq/fn0wxuX0Y6od6dJdpbZ2ag0CTLyfORzAJCv+TfBNtJFH3KMiOYpwz8yYR
	wk43yMyLglSlVpRhWjRFTL/lkffPP9THkNVU6vRKuPSjAuoAccKWNL6eLCZtPYSbuDsuBW/wjvB
	DWzHHs1jsxRf3qIgkQ7anrs2AbpkUhPRygoF5NeO9n+TnIiYiB3uNWBb8zToTzuVoriNOCtsw26
	sduK3VWaiKCJF/F9B/mKx+dqFDyXEueLtoPMmYfOWPiFALidOxvC/R5FO52zOKi+i4UhX9xgShu
	8JfP1EgfY+AgD7GUn5n3MwUkpe6r7K0vsO/A6HIZ1OIsL0WB4iO9t8qKPoAZ9yRFgO7ihmw=
X-Google-Smtp-Source: AGHT+IHHPbIgLzsY9HofrGkO4DPp/RmzIGelc/5vMOj27bC0JuqiZhNs4PGwRa5UJ9lkSCt0p2Ofow==
X-Received: by 2002:a05:6000:156c:b0:38f:3009:61c1 with SMTP id ffacd0b85a97d-38f33f50a65mr17685085f8f.26.1740069714054;
        Thu, 20 Feb 2025 08:41:54 -0800 (PST)
Received: from ?IPV6:2a02:2f04:6203:2100:5146:3c6d:da37:b887? ([2a02:2f04:6203:2100:5146:3c6d:da37:b887])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b432asm20668988f8f.6.2025.02.20.08.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:41:53 -0800 (PST)
Message-ID: <f979f814-cf9b-43b2-a928-5faa3996724c@tuxon.dev>
Date: Thu, 20 Feb 2025 18:41:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: renesas: rz-sysc: Suppress binding attributes
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: magnus.damm@gmail.com, john.madieu.xa@bp.renesas.com,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250215131843.228905-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdW4sN6x5C7iQgiZD=Vmzg=BA1v+WjS7aapXmuM2_y8JvQ@mail.gmail.com>
Content-Language: en-US
From: "claudiu beznea (tuxon)" <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdW4sN6x5C7iQgiZD=Vmzg=BA1v+WjS7aapXmuM2_y8JvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Geert,

On 2/20/25 18:00, Geert Uytterhoeven wrote:
> On Sat, 15 Feb 2025 at 14:18, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The matching data for the rz-sysc driver is marked with __initconst, which
>> means it is discarded after initialization. Because of this, attempting to
>> unbind/bind the driver through sysfs after system boot can lead to "Unable
>> to handle kernel paging request at virtual address" errors due to accessing
>> freed memory.
>>
>> Since the System Controller (SYSC) is an essential block for Renesas SoCs,
>> suppress binding attributes to prevent them being exposed in sysfs,
>> avoiding potential issues.
>>
>> Fixes: 1660e5ea6a3e ("soc: renesas: Add SYSC driver for Renesas RZ family")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.15.
>
>>   drivers/soc/renesas/rz-sysc.c | 1 +
> Looks like there are more opportunities for similar changes?

For the other Renesas drivers I wasn't sure if this is the desired way.

Thank you,
Claudiu

>
> Gr{oetje,eeting}s,
>
>                          Geert
>


