Return-Path: <linux-kernel+bounces-337504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1201984AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B178B22E52
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8D71AC896;
	Tue, 24 Sep 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T72CeNn6"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA602E419
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203024; cv=none; b=JbjYFmbQZ3MBuNhpnJm6DY1WvBZTJ1MEcCoFBxgbXwphXklncQjThKPDFx7UCI6MhGt+N8WOHmlE0Q5Lc33tPLCOLZrkOhO8e7RukE9h1k2L+T2W6Toy3PPLatptPlcmkswNjhv/E1zTp838XGWIim8CZkGIsUO/8DwPNix/wSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203024; c=relaxed/simple;
	bh=/G3umoy56yNrFR1GXH3xQAtby9UFyp5aXDqB4VLVtzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIiyjh8our2oPN9lGCgGYG1EczC8WDPIqAH5wjyN3Kw3bdE+GY6wW7DoRFhoj2DZ3SrBNr6R/0+DZioj9E7HDu+R2bXm/5mTivLRyWopfwRIsA03RiFHwPwiaST7ud76t9q5NwpWblLhzd6K7E2mzxNYgEOsRAblF2e5deSOS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T72CeNn6; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82cec47242eso6261939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727203021; x=1727807821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwEeUkqNdXsH/r3E8ugcVO9XW2yFBZ93inSIHmXbaRk=;
        b=T72CeNn63Hp13lYbOMKZGL9LrQ/X1YzTeN6G1CDHpMTUtCoc8uOvMuNToRDbPPFU8Q
         QwdSTM3QWAGNzZmMG4v3QAYbX1SIMXmPEGmwBW/1G6eM/QkRH/JcTptAQbjvqYjOt8CR
         bhiZGThgUGoz8UmB4ORKV10VpJBCHqUSgXQc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203021; x=1727807821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwEeUkqNdXsH/r3E8ugcVO9XW2yFBZ93inSIHmXbaRk=;
        b=jiTfKMUTulFuVU15Ze0NMx4brj+IE99g6AHpJJ0NnSYEpMta9R0UtneImSSalP/9zI
         VS+dYxDf+Ab0xZDjfqJN+NbnYGxnT5LX3rR2k7hqOMLHDSsfLquTQo/kURNbKVNdTdPf
         5C49e6sk8cRtau2VCq3sdymauamAoLya+cnLfz3ipVkC0JX/M3/4EbK7m1Evjynb50a1
         SOxCYEA8bwi7lIwsuKLLq+BRvOLeDhKVfsvrMhsJtLpZ74NaXUM2zHFEmiFrIckVJrSl
         pU2T0KRWCGaQz33+Z3wms0p+ZN4hQnClAuxBXAQE8Wz8+B3qcHlD8pVEC94aI/oXD0UF
         2l/w==
X-Forwarded-Encrypted: i=1; AJvYcCWKcHtd83oj8v2tS29D+VPXKdMKlrhEpErxfYFxN3msc8ZoWz//8LLvQW+23aiZ4os/Q6OQ5Dx2Q4UCbJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRuJtb9QMRuS0Tj9I7JKCUEGi4RVqhotKkDjNOgMKmZKdXDfI
	sD7jUGh4ERhR0aLm91KBGxnOyfB7ie68N4Yjy4b1Z+y4KThQHsKbhUH15PohAbw=
X-Google-Smtp-Source: AGHT+IEkYsamIodKjKtyWhebV89cW3T/O3IchT1i1x1O8h/x1+l17iMrMt62s8X+x0iR1ZKIGn2BSQ==
X-Received: by 2002:a05:6e02:1a64:b0:3a0:ca91:2b4e with SMTP id e9e14a558f8ab-3a1a2fd73ffmr30136755ab.3.1727203020946;
        Tue, 24 Sep 2024 11:37:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f1bd1c4sm554294173.102.2024.09.24.11.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 11:36:28 -0700 (PDT)
Message-ID: <ba84bf50-67fa-44b2-b73c-f219c277e38f@linuxfoundation.org>
Date: Tue, 24 Sep 2024 12:36:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/power/cpupower: Add documentation for some recently
 introduced options
To: Tor Vic <torvic9@mailbox.org>, trenn@suse.com, shuah@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924141747.6428-1-torvic9@mailbox.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240924141747.6428-1-torvic9@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 08:17, Tor Vic wrote:
> The 'cpupower-set' tool has learned new options with commits:
> 
>    f2ab5557119a "cpupower: Add EPP value change support"
>    df8776b03689 "cpupower: Add support for amd_pstate mode change"
>    eb426fc6bdd6 "cpupower: Add turbo-boost support in cpupower"


Thank you for finding and fixing this.

Checkpatch complains about commit description format. I fixed them
for now.

This patch will be applied once the merge window closes.

> 
> However, the corresponding manpage was never updated.

Thank you for finding and fixing this.

This patch will be applied once the merge window closes.
> 
> Add a basic description of these new options to the existing manpage.
> 
> Signed-off-by: Tor Vic <torvic9@mailbox.org>
> ---

thanks,
-- Shuah


