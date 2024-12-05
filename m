Return-Path: <linux-kernel+bounces-432549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B419A9E4CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4495518816B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3856191F89;
	Thu,  5 Dec 2024 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="vFTrMxUC"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23EDDCD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 03:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370382; cv=none; b=UXQAlA33WE2r1faHHHzp/QplcvTqE3ncnkW9N8PNMj3g9bFf1uuoCELdj0gadzBrnvIVbWkROfL0T7yvM6BNOsK2L9O1/nMY6H5g3AqRvTGIkD1InwUUdjfSUls47KF41nF8gPPyZ5GBMyT1Ifv9n3uJ7uKB9jaZ6TJOi7rnrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370382; c=relaxed/simple;
	bh=sM3nMzC7TAsFvCC8GdPgobx0dXQVeP/mcuTeiAUa+ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Om22qJUayR4VhlJAtgL4PQnGC3cvsnpHZVZ3vgGZOGI9FCDPZSebpTIbY4OJlw2xh5V3q0PsFfKu9HBjJnWhUGwng/dn/CUEQ+jKUw+Z5kn4Hdukkfahur/WYzsNlqVzWnedsi0yqbexpOl4nPPlF1q3jFIs2bIDOXmuKSbeJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=vFTrMxUC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e203d77a9so465236e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 19:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733370378; x=1733975178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/UWGflKJO/+P3D0XoMr9nLPY+D4nXktguor9vbxGSg=;
        b=vFTrMxUC96QB0LDIS6MksHLpcgU7PkW12Auc2sX2SqWJTeyNugl5aynZWR73jNjrUq
         cFqj3JjuetX80NcAPdYJ+Yxdk2P7a3Fpzyr6SlGLC1ng8wl7D78kb3+rJpqdX4rSnh2u
         q8ztEocVDPt0/56DBrzrqob7SsGjuTa6RryXYzD+raibV5EWDKCHyszzlv9LvaYDBmrw
         mruqYDnomYy0f1yPKj16Dq6zgI/KXpqJ7lRY6TkuGHaHw6PnjwNI/LcZGBqvfc9lZIlV
         nJ0Olp1F2tu96w4bs/+NfGr4Z76vf5HrPxizUDxNmAqad8qNE1pX6rU/Rf4XuTFUdys4
         6vvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733370378; x=1733975178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/UWGflKJO/+P3D0XoMr9nLPY+D4nXktguor9vbxGSg=;
        b=pf6BBhhcL3OXVIGIGlj0ZVyNK8hT93KwfiVqgf1/o9CJSD3zAY7eU51/nFXWuwlY0w
         o6fZwtjI2dEEJi+3zedRoqYufp22ejxd/l+BH3hJkvOX560hBNxw+4h1NRyruKu439VU
         oObpgUaIFBZM9LcRMdT0D3FTVRuBlKvnS7//moZkrei1ZlPSUe9Z61MggvKZ2uMlnxgg
         2snGKbvTWZkpbe3pD/+vwRewDd+MewVTXCJwEQXcoJ0/NF+EjFUouYTuRJ/KkpNBvDY4
         ZOs85x8oi9759v3jXQGctOhLMKt8ZpxfxDiqc7ZABaADfonuqF21OjDYRtq/0VjlsT0E
         EX0A==
X-Forwarded-Encrypted: i=1; AJvYcCUUCJ5FiEXRiEuRK+xK7X9zBwIx4cQQQzIsm1LCclNpNzfhQwjHqpSIM2hII5SpO8E25/5p0HjdRavSzaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV3cwwFNEO/FE9Idj7UJWITf5udjSn5CCT+VUq/82ocBSLUk8
	aolQxtDqEfCC2POJ7phOgqPL2lchiMrHUqPOCYqJwq4ete3oQsl66FqYWCJkKR0=
X-Gm-Gg: ASbGnct7q4J47EpkmiVsPuL0OLCTD1S43dNIvIkGUHUhqZjsOcWeNru/Y0R8ds6H+cL
	2MUJT2NzoJO7krKVS93T5iX8djDUHieYASsAHtGO2ZOsalZkq7bOV0WoNZ9oM+4X39ce6FzQN5O
	E/wfucrywKjAIq1ytDvgGXPV7R9z3O4GlypBQkm15VMKh62FkYwfWDoYgMQuRqwEzgG9S1MPySF
	ec1OklRa3iQkkWxo06iuxz0v6TTeNxDD/CBZlhJrnBSpbXjH+X/6eTH3PabWrOGDtXoWw==
X-Google-Smtp-Source: AGHT+IGVgzpGqperEh+QPwsCh0haYo/KcfW5l34sezpfLSZ8Qc+W3UcKvNf9XwxfmZTyOcNqdMUXhw==
X-Received: by 2002:a05:6512:3a8e:b0:53d:fa6b:94ae with SMTP id 2adb3069b0e04-53e218f94e6mr384227e87.21.1733370377733;
        Wed, 04 Dec 2024 19:46:17 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba6d0sm91875e87.139.2024.12.04.19.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:46:17 -0800 (PST)
Message-ID: <9b2607ac-a577-49ca-8106-b82b25723439@cogentembedded.com>
Date: Thu, 5 Dec 2024 08:46:15 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] net: renesas: rswitch: fix leaked pointer on error
 path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
 <20241202134904.3882317-3-nikita.yoush@cogentembedded.com>
 <20241204194019.43737f84@kernel.org>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20241204194019.43737f84@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> If error path is taken while filling descriptor for a frame, skb
>> pointer is left in the entry. Later, on the ring entry reuse, the
>> same entry could be used as a part of a multi-descriptor frame,
>> and skb for that new frame could be stored in a different entry.
>>
>> Then, the stale pointer will reach the completion routine, and passed
>> to the release operation.
>>
>> Fix that by clearing the saved skb pointer at the error path.
> 
> Why not move the assignment down, then? After we have successfully
> mapped all entries?

That is a different possible way to fix the same issue.  Either can be used.

> Coincidentally rswitch_ext_desc_set() calls
> rswitch_ext_desc_set_info1() for each desc, potentially timestamping
> the same frame multiple times? Isn't that an issue?

Somebody familiar with how timestamping works shall comment on this.

> I agree with Jake that patches 4 and 5 don't seem like obvious fixes,
> would be great if you could post them as separate series, they need to
> go to a different tree.

Ok, will repost.

Shall I use [PATCH net] for all?
Or [PATCH] for fixes and [PATCH net] for improvements?

Nikita

