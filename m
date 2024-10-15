Return-Path: <linux-kernel+bounces-366565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20D99F72C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411611C20D47
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20D11FAF16;
	Tue, 15 Oct 2024 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFKJ2D9P"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711F1FAEFE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019971; cv=none; b=qsRmtF5j8quURBdDDyP5ZbNSUC30ODa7JiB0YK3Ui49P5757QHMbBAZ7nB+NYvQF97K58YsrzNX4JWSUyCO960Y014zdmzCTHC/6HNe7qJbRCJOZNmeGByemVPMAb5r75+2Gv7rguyr7IOXUSr/U/zfmicep2WRjxyUcWPDrFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019971; c=relaxed/simple;
	bh=F4H3asjfD3zzqq/Ba/peDr/Tv8WbT65hIqSh3QI/+EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTjpb0kRXNI/NKkFesOiofN5RuFqcqoVQXD0uCwDzGk7IX1WuOwJzNNgnHnLhvgoghFqs3tL8apHkqwfCa5InyYBxiHHN5bTDPc3UA4BZw5/tg5vtTaKbldEhTPMHeraeYjORFXOSSdfGdS6Qq7ZNYQEVCELz9MOgt7LsZaojmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFKJ2D9P; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so6587584a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729019968; x=1729624768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBVljLM53JfPGRihYqkwAXqRX7+sk8Hf9PcEHrvrWw0=;
        b=QFKJ2D9PqwVLtmbUgKnTl3AZ1Sl8a9sSLZqLKs4aMBLKK/X08ys1tGUpgVWaVZrzNU
         R0c8BU1nVtcnog54vKAA1gDcCbonQHnk8wIeCmaV53VI59/vPCDU+1l5G3wS77V+NFlE
         giWroUSjNF0tykDvAPFQmD8XuJLEH/kCZCdO9j2zmBDhaUqN9Q2mWHW4ZA0LmcgKDObA
         7ACL8EI2Z2r5tIvBYUk+WE207BrGBN3WnDBDdi1SkvhTB2e3JbkXhuL/66iRMUOEn5S7
         Syq26JNbrG/CtGxXXl1OLgMH5uGcifooHvlYE23IbWMEK1uArXtTU2TdeohzAOAN5jyV
         pIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019968; x=1729624768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBVljLM53JfPGRihYqkwAXqRX7+sk8Hf9PcEHrvrWw0=;
        b=D44G75W4tXjy2S6eL3NkVpXmuoxxoO6MWwnSZ17oJIQ9GeGYPBSwNIpITwmaYNqXMw
         +10ZnRM3YC07JFH0pQDPjzOOdu8eDN3TkeIgoCP4vwbtK9/Eo95xxCf7NGCbx1MW5Kfl
         nvPtlvpz7cI2xLCIAYLGT0sSDm3rEzJo/gb2LUK+ee/SYppG+zyRyYo28rAoFVxOuODs
         YLrjUMkfwER0C6u2b44sD/L1YAsfIDwP/tk8yNRJN0Xi+44RA25Fn2mTQePVuIn5P/Xn
         Xwm2jf1Px9DMrbHfh6jGzywNkdZzFwW6NsRbrindmnRfiW7ZO9e7YhX83rLxxYIXzQoq
         MRtQ==
X-Gm-Message-State: AOJu0Yw/wYGXywkuzq1/FVkZc/+I+YgFt4dE44r/iwkmSFBCucj+tiyy
	vGxb5yCLsZodlfksyV8suVNVW02unmq28ngQZyxuIO1VKs+59plx
X-Google-Smtp-Source: AGHT+IHAjmrlYnHeeDWVeJAUwyg7yniKorbiL6KpuL+pdyYE7YaTO1VpAB90LCt6WTkIP4fthnDaww==
X-Received: by 2002:a05:6402:34c9:b0:5c9:76b6:d14e with SMTP id 4fb4d7f45d1cf-5c9950d361fmr963233a12.16.1729019967668;
        Tue, 15 Oct 2024 12:19:27 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9918c0978sm746343a12.33.2024.10.15.12.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 12:19:27 -0700 (PDT)
Message-ID: <0b009357-79a1-4af8-ac44-7b5ad3369899@gmail.com>
Date: Tue, 15 Oct 2024 21:19:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: gpib: Add TODO file
To: =?UTF-8?Q?Dominik_Karol_Pi=C4=85tkowski?=
 <dominik.karol.piatkowski@protonmail.com>, dpenkler@gmail.com,
 gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20241015191522.14713-1-dominik.karol.piatkowski@protonmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20241015191522.14713-1-dominik.karol.piatkowski@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.10.24 21:16, Dominik Karol Piątkowski wrote:
> Add a TODO file stub for the gpib driver.
> 
> Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> ---
>   drivers/staging/gpib/TODO | 5 +++++
>   1 file changed, 5 insertions(+)
>   create mode 100644 drivers/staging/gpib/TODO
> 
> diff --git a/drivers/staging/gpib/TODO b/drivers/staging/gpib/TODO
> new file mode 100644
> index 000000000000..734eab691924
> --- /dev/null
> +++ b/drivers/staging/gpib/TODO
> @@ -0,0 +1,5 @@
> +TODO:
> +- checkpatch.pl fixes
> +
> +Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> +and Dave Penkler <dpenkler@gmail.com>.

Hi Domenik,

Please do not add the last two lines as the maintainers are stored in 
the MAINTAINERS File. This information is redundant and leads to issues 
when the maintainers change.

Thanks for your support.

Bye Philipp


