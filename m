Return-Path: <linux-kernel+bounces-207903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B72D7901DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A79B24264
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408A824A3;
	Mon, 10 Jun 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsO458Bh"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406681ACB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009962; cv=none; b=HWkvL5jZ7jzI3vktwYB3fRFo+NTwt4/4O0tDnXIoHpBhR25Iq7javgmZhDVgPd5H3sSNlocrH1OrLsVd2r4flNJ35sSVY8Obsh6HNQL3TniM1e53aMbsJhqAkqejZzyYFRVIlPW3Ti4WmYEnQyrquvGJgAsLfurwDhmDICNISDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009962; c=relaxed/simple;
	bh=vHneDFUBNs0GqnfTI6Q7Qcn+foJQXhLeHMKZSlyD3T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J48lcHPydaOSrCwkQjo7qQV5/tlnXhgZQpuKAU1oP/peXluX2L1S0jFsS4y3dMnmOHkL4HQWFb6Uq+T2p4hm257isoI1aGChpp5K/Q/kWgD1HmXd2Z/opZTPzSlkPMLHLkPjDXwAd5IljTUdHYMjELZz4tJCfNRC6xntRa4ayl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsO458Bh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42165f6645fso22039065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718009959; x=1718614759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvSu55HWnwB5FrLzdsKEOL90pn7dtAat3/WOLZaHz4c=;
        b=QsO458BhIkRDEeNxOpbXcA/hsD4PLvekklndhhaGCcmfSH5pNZ0l7F1edVIYHcYi2/
         b5SKvI8+Td75JjUkC62tFgdbhPhukYnZyBs2YVtTftdMErC5mFvp4yT4bU/wlLK58bgf
         XGLPn00idANzRESNoWr/gyrzqr7n4Soy1RiDC5tZ+Aju22/bHSqlryHL2y/mAvnDcLsO
         hbaVU2j61i+amhv0QvDbNpX6QgynLm/gZiVTegOI7zQl6VCDL07De47d13oV8MpKxSSm
         eeUW0TbyEKZu1p7fh4iDK83dRF8xCSFTwqCzP0c84MFsmT6/g6VEiSjhi208kWg1LFiF
         uQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718009959; x=1718614759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvSu55HWnwB5FrLzdsKEOL90pn7dtAat3/WOLZaHz4c=;
        b=lYsUo1Y1/lQ1AryHu1iz8KhrmPoMI5TOXrKCbDjU6esN2C6dS0gbfKhy0Xz61X2q4a
         JjF7iZj9jqEg5A9sXbzX8waOScBwGbh4cIAbkfJarQpUDAwv2ACRHnWckdhouvrBoBJ7
         mqCGRc/2HNc+fiTDyqdX0DtNH5B9lOz4z4nFAU3BiaXlb7he6cXwiCSHMkFgJDHiGvtH
         nJFbDkhywl9ZdBIwQjQTnzaycEegWXK7ED4icPB/e0IvMnKV/eKulyeHeb7vGX7xLGzQ
         ++ATZ71u4V9cSQmAu/8vEmmynNdQxNzRz9jgbG4AwBH+x+7K6nBMEhjLAqp+zoHnmGhp
         GM1g==
X-Gm-Message-State: AOJu0YzlG7ynbjqgGHds9qr6Kc2kN6mEIUEsCNIMsvqHJMXSf2JgocAf
	L2rkGnd1z407j7263x14Hen/DCzA2+Y5P/iaZ3p3GtrMPU9hFQVlrr+CoGlRukQ=
X-Google-Smtp-Source: AGHT+IHgamB6ykVfBUAH6mSf0Uvt0ewso3ix2AMmR+6+4Uj9SJGPp1d1Wu+SEngslWbR4dwQwvPXNg==
X-Received: by 2002:a05:600c:a01:b0:421:6475:abee with SMTP id 5b1f17b1804b1-42164a038b6mr68198995e9.23.1718009958670;
        Mon, 10 Jun 2024 01:59:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd247sm138237425e9.40.2024.06.10.01.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:59:18 -0700 (PDT)
Message-ID: <ad4f1cfb-28f0-4d80-8c0b-dc42b01ecfa7@linaro.org>
Date: Mon, 10 Jun 2024 10:59:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] thermal/debugfs: Adjust check for trips without
 statistics in tze_seq_show()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <8389302.T7Z3S40VBb@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8389302.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Initialize the trip_temp field in struct trip_stats to
> THERMAL_TEMP_INVALID and adjust the check for trips without
> statistics in tze_seq_show() to look at that field instead of
> comparing min and max.
> 
> This will mostly be useful to simplify subsequent changes.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


