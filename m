Return-Path: <linux-kernel+bounces-199577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6468D88D8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3808728338C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56022139568;
	Mon,  3 Jun 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iyLPyq/K"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505D2BB0D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440371; cv=none; b=egzDv6E3euxA8f/IVAAosxKiIA2bgZWakW6WbTVMhbrG0+zN7S1Pp3Jg4DMOG1Yjoz5LH29xQ4NT1c4gSmfPRgucKvs8H7xAbeHj5AASKtp6qD5ES/on8J1BupAJJDtJPxqPb7N2LbnFBSzv+mVBPmjOtke13KMQI6TsRiE2GgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440371; c=relaxed/simple;
	bh=zJUvO9qZ8ra4YCfqKYCYV6jebwpDoo5wIxkD2zPoXPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xm1brm8cZCp1X297brVabWUT18/CgosLYJ+ujOdsPU8+TNqNNDnH3bunybO0xUhzvWRjoI+nIvHM4zAT7kiUxRhWH/ikuh8Imfsd/eEyK/JHRCEgwBguOpBi4yTlPBHDNTdYtpOsPvaozXWIB8CtyhJHEKkccM4jHsTAL/kM4s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iyLPyq/K; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8da5e4850so2535023a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717440367; x=1718045167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fbbg11gxYAzEz2wKYpT4nltvS1xcJseRvXkIglIExg=;
        b=iyLPyq/Kjfjrcj4IAgVqcMXNYBgKC9QOQ9IpdWRNWJvcz70eNM3AfX0JvPf0HBGBlu
         NmGCjJEjAKymFlkiqiz4zhxihuikAdU5V5gxw3AsCMmKFl13QcJLFZ1RDhy1K1udgxCY
         p7has3ZsdKcZqqzDnu9A5oeTseCQPkTGrEH0dJ2RxLUV38JLls8ndvxm5X9ptmVWXisY
         pN5VAjPzdiUuVx8PXJen/lasxQXhFmaYKY8o/AkinvRPmO8CG6CyQ+DFntJxLOXKosJy
         Yj2i1HTKc41OYV7jj+Y1Xp/1D4lOSImoh+w7DCBBFmJfpZHE9Bkc/0MSge+BSPDLJ8ij
         SXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717440367; x=1718045167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fbbg11gxYAzEz2wKYpT4nltvS1xcJseRvXkIglIExg=;
        b=Gu/Ea6y+DsYiPqQJAnzUw8rMjE+d2pwe1NmyWWYlibx/A4mIEGLvlXa7mt8UlgeRax
         vtfA/UXAKs152hVt1zG59StpeFI4MkZUKFzyqkFK3pYV3+CCrPN9eAPXf4KGgBjd8Msp
         97mDhq9f36gsw1ClYZOc+L7Lyd38XoqSOZ92MPemFxeKz6VqF9lm7IxzAjtf52VOIRGq
         /hEflDSUie8H0NZqI9085AC/JGfc0Rl4SKcEXTxbj9EGO1ITJhi7EqAcVAJs795XIYza
         gJkqEc6kT/GM99Z0h3PEUD3rfcrsoA46H+z2YCKidy6+h8TSI7gebOIEjz9I7/EFm49v
         Wgpw==
X-Forwarded-Encrypted: i=1; AJvYcCWcUoICWhorjRpQ5FmU3AEaRXGda1UoCa6CjQY6hY+SwszXUCK9d5NGTxvdTWlxr1Dv8luIJRd0JxeXdtfkSucx4l6hJz6tYUbM2ivc
X-Gm-Message-State: AOJu0YyhHYhhE3ygsPGcUmvn99wT6+o+Yyr7wRkpuZjXis7pmR1cdZ2J
	yUnyzFU+u9yuc5fhY9y8pwM6K+IYXPS/0+zmh5O0zRzAkeEv4awMTcYCW7z95uI=
X-Google-Smtp-Source: AGHT+IGqr4CqoJEu+Q5SFykaDA/vtBhgorglavgKOTyHlAuobIO2Ssw5kWxTsjyonoeH+DyK3EyiQA==
X-Received: by 2002:a05:6830:4103:b0:6f9:3717:5870 with SMTP id 46e09a7af769-6f937175a1dmr587435a34.11.1717440367364;
        Mon, 03 Jun 2024 11:46:07 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054e9acsm1554532a34.35.2024.06.03.11.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 11:46:06 -0700 (PDT)
Message-ID: <cd14f81f-0f09-4b0e-9765-aea4398c6448@baylibre.com>
Date: Mon, 3 Jun 2024 13:46:06 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: ABI: add DAC 42kohm_to_gnd powerdown mode
To: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
 <20240523031909.19427-3-kimseer.paller@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240523031909.19427-3-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/24 10:19 PM, Kim Seer Paller wrote:

It is always helpful to have a commit message that explains why we need
this change.

> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 7cee78ad4108..6ee58f59065b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -708,6 +708,7 @@ Description:
>  		2.5kohm_to_gnd: connected to ground via a 2.5kOhm resistor,
>  		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
>  		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
> +		42kohm_to_gnd: connected to ground via a 42kOhm resistor,
>  		90kohm_to_gnd: connected to ground via a 90kOhm resistor,
>  		100kohm_to_gnd: connected to ground via an 100kOhm resistor,
>  		125kohm_to_gnd: connected to ground via an 125kOhm resistor,


