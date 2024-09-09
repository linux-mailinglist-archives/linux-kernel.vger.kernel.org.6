Return-Path: <linux-kernel+bounces-321400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E81971A00
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54853285ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC06D1B86D0;
	Mon,  9 Sep 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ia1aQ56v"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EC1B81D6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886382; cv=none; b=fBCtugLB6QdNn6sB6O1HtPOV5cLe29XF0DkdBL3tVb/f+UHErz4XIildqsIuGAZ27+LMVYZ8uBRokpElmBpDHMPdd9tsUgqG6dNBrE4whys33cavMu7RvSh/AXB3VLEqTer8frkaaSr/X5sDIt3iDFOitN7OohBMEot391ZvUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886382; c=relaxed/simple;
	bh=t9DDmx6aUWGI8kEMrZaWF3DeW23cI5h0m94dxJe8fic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puUUxw8BiONnz/CJ49pTQ/y7XqoPO6jL6iQJZ6DUpDASj85lqHnn93/2PIR7Lz5j3dMFpez6jZXHCohCWe/8gm5VwcCKnpBm/0tI/y3ihV3b78hNSgXypRQsB2YW/YCOylZX2MBrba9qxpD1pZufpDCR+fzqlIkaAamKpFZQl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ia1aQ56v; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae102702so19904555e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725886379; x=1726491179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=763rg3ZUl+6DZJOJy5DwsZvQOJ60xrN183DDZfMyDrU=;
        b=Ia1aQ56vurqFLJyEgoCn1/9aX3lJPGe70U/Ww+LS2NJ1BRYCyJ3nfyjQVR2lk2/n97
         lfJOEv8k1WijQbPl39Pme6OhTwN6FcgQAmVbQQYPdfBFtid0xlLkD8175h8bTrTjrpRd
         H3urRjfH0xiYFvaZI3IT3+NMtmvGO4wTqgzV33TkwymzLli6VdmwQ99yy2C6OdWu/afZ
         PydHlL4iffZGmXOrEw9w+tsMKmWHVR77izEZjpUmCcSPYaCHTmiPlMqOpGWA6tzCHJ4k
         kqC9J0wvcfEpHluml7jFiY2tdPKqnXfE2ljHKNb7PA7cp4ZprVSSUlmoV+0Se6LMu2zS
         3RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886379; x=1726491179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=763rg3ZUl+6DZJOJy5DwsZvQOJ60xrN183DDZfMyDrU=;
        b=P94+wdbrQ9C+wTjINSHrUo4vnUqy2va5WrzDMjm+BHCVnvRq/qJvrK6cOjl0oop0x1
         e+IF7dYMNMAdplsK0YWqyMhhiYvdx3mO2Nw2A1gJcPpuUk1DLpY7TRCxEMdardimCo8B
         eKBXtiplUDzRIgET8mokhrik76frOIRapfYztNPbfQ/1CFgcriGRQOnjOt1unVNfkz1a
         tCrn2aCo0Or+m+n1k7zR/W/Ha6JOoXTe1FnongmufQnJDXUO3LhsHd6AfP0B0RQ4fMxZ
         9Vi7XwHlUYhP/BxwPycibDAwBio/ToTS/ym9nJtfjjBEWH5M8hWzcDCLxMTRFTIPXj6R
         jFWw==
X-Forwarded-Encrypted: i=1; AJvYcCWYtK0QYg/3wOORC9UDOqJ3aHzvmgQ/w5nDdSHDVHq8nbvIJrXOmKPTeflljqT0t+zC6256v7JxRlICJx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrsrs1A74EpMS62MjwlHrKCyXXhybUFttiZaTfqnJj+HHB9L6
	lOLtc5ZuzjXQOLP8Hqz6DsT+9dAE0ZdK06+H9ShHHXUbtu6IDDInacqH/U9Vpsc=
X-Google-Smtp-Source: AGHT+IHpDUAYZ6M9I2utE7B65i3OcZBvlzvw4You9gctJaalUrdtM/PYSMSxk8LHlM5pPU+PhOzRpw==
X-Received: by 2002:a05:600c:1ca6:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-42cae76cf3bmr53395615e9.25.1725886378512;
        Mon, 09 Sep 2024 05:52:58 -0700 (PDT)
Received: from [192.168.0.172] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8700sm5957292f8f.116.2024.09.09.05.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 05:52:58 -0700 (PDT)
Message-ID: <e461d366-ddeb-4d87-813d-9d8cb7e30238@baylibre.com>
Date: Mon, 9 Sep 2024 14:52:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] ASoC: mt8365: Remove unused variables
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240907-asoc-fix-mt8365-build-v1-0-7ad0bac20161@kernel.org>
 <20240907-asoc-fix-mt8365-build-v1-5-7ad0bac20161@kernel.org>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240907-asoc-fix-mt8365-build-v1-5-7ad0bac20161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 07/09/2024 02:53, Mark Brown wrote:
> Silence compiler warnings by removing unused variables.

-- 
Regards,
Alexandre

