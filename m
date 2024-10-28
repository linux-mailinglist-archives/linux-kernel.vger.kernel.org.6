Return-Path: <linux-kernel+bounces-385214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A89B3416
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FCC1C2164A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6671DE2DB;
	Mon, 28 Oct 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQrqzgQ0"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085D1DE2AB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127294; cv=none; b=A7g3p52OwneltwEGsPO6CWMFMWoal9g1ZvCqf5EyK7ZwzhCPZEmtOJkw4AQErgb/e8v+l2gL1eZFOzHdPyGQku34PvoEidZM/BCKLfsm8dL2MR5Jo/z4TP2hy+FDzIRnhC9KkuUhUs/flMEclJV8Vb39IINHKOlaWYqF48RFeAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127294; c=relaxed/simple;
	bh=P+RPiYVMQAjgiet8wUhfzY3W3TLnv93kjg+sCRryPzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TahQZB1kNN6aE5IV/9xnZtHbxRKhMiFaxlg0GEvR0n4mbBPtMCHnNgByu4DiqJyJgFb3iQ4YtLABjxJW2a6gz4RreduFxDgkE51XbitrfTCmrA08oBg4Vm1dr997FwzodJx7EIiR13OhyQQY+YUpaEhlBkLvr3I/M95U5NcVclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WQrqzgQ0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so5606988a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730127290; x=1730732090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OLalaU+pDWpkR9VWoqnEPl8mBpze/VLXLSyV5dFLDjM=;
        b=WQrqzgQ0DbybroXHOz3788QAOHVF2w+BOQ2iLK3oQ/fmjUJis2songpKBXaRRap0I8
         3nCSPz3ubYSWFUVHvTt6jsRMaYwPTe7I+b2X19I4rOsP3Y2YI/Mnny0dPbD6v7hiVi2t
         VEaBbNV5hbApXc7J6M5kFX/IDwQgN3pbPi/yirsTXUJV72ctNaIileLnuML+khBOx5Mj
         LZeqp24OFh0EjNSmPJz/+dvWHMAWXasCMiE6mSaP4PX4U1zLuwrwXRh/7XX5e21iwLTN
         bH+TV0QV4qDY+zMHz8jC8ssadjG2o6s8hTj8kdQekVDD7CacZmAgxrnSb0YSk9g8Tmk2
         z5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730127290; x=1730732090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLalaU+pDWpkR9VWoqnEPl8mBpze/VLXLSyV5dFLDjM=;
        b=nM7lILfSC6ZnGNu/AdcAq0plBzsM0sMrZ3tdzedwYx4DH/EJmq9CPiLFEAjImfWIrY
         +NT5C1WvZqTQnt3v1g9U5OjOrUCyVvJo45qqWM8x/6XzB9G7GkkwRv6FMoycgITtDCZC
         S9ZfrKM2VCQJT3MKRZm6GJgbKdY0tp41WJWUJda8nloExSoYm6LC5ZiSies9IlU2GMpy
         u1SiOqUF07cDnNeGEDXD9/eKVN/KnZ8rVBZ2iBGmMmPMdkNV1NlVxMFPkWtiaE9NMZIz
         G+i44ANVk+MYo0dFXv5/clYRq4mdld86Bvfi4huPhIPIOKKbRUelDPCAqZ0kLzQGOHoz
         nAIw==
X-Forwarded-Encrypted: i=1; AJvYcCXKK/ZYX5ykz9Dvi6p7Mflec3bXG4MCba7gMWbjU+crGpTmIaOy4wvwQlL82SdpLc5FVpgPNeSRtsBXi/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOjKtu3+BmyeMIsr5b79S8huaIXpx77ch7Bh/wOnz60KRR4r6K
	Tyy9vVNiHJqvU/hTego37lzKrwB+JWN5mm+15QBMBCq4MSnz5IGSycKmjf9fLnU=
X-Google-Smtp-Source: AGHT+IHL2tHrXgXIRtrn1fjS04I9Ql86JWK+yGWnKN4DOApfgrKS77khFTPZj/Bs221FkbgmW7XqPg==
X-Received: by 2002:a05:6402:440a:b0:5c9:87a0:4fcc with SMTP id 4fb4d7f45d1cf-5cbbf8c30a9mr6455301a12.16.1730127289924;
        Mon, 28 Oct 2024 07:54:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb625526csm3441005a12.6.2024.10.28.07.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 07:54:49 -0700 (PDT)
Message-ID: <3c98775b-b61b-478f-838e-59f8e1cf8aed@linaro.org>
Date: Mon, 28 Oct 2024 15:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/12] clocksource: mips-gic-timer: Always use cluster
 0 counter as clocksource
To: Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Chao-ying Fu <cfu@wavecomp.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@kernel.org>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Serge Semin <fancer.lancer@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Gregory CLEMENT <gregory.clement@bootlin.com>
References: <20241019071037.145314-1-arikalo@gmail.com>
 <20241019071037.145314-6-arikalo@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241019071037.145314-6-arikalo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/10/2024 09:10, Aleksandar Rikalo wrote:
> From: Paul Burton <paulburton@kernel.org>
> 
> In a multi-cluster MIPS system, there are multiple GICs - one in each
> cluster - each of which has its independent counter. The counters in
> each GIC are not synchronized in any way, so they can drift relative
> to one another through the lifetime of the system. This is problematic
> for a clock source which ought to be global.
> 
> Avoid problems by always accessing cluster 0's counter, using
> cross-cluster register access. This adds overhead so it is applied only
> on multi-cluster systems.
> 
> Signed-off-by: Paul Burton <paulburton@kernel.org>
> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
> Signed-off-by: Aleksandar Rikalo <arikalo@gmail.com>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> ---

May I take this patch through the clocksource tree ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

