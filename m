Return-Path: <linux-kernel+bounces-282415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7694E3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF581F221B8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20A15C150;
	Sun, 11 Aug 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2YRREAa5"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B1157467
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723415488; cv=none; b=O/O3HJQfMtTDJ714xURBaL32vVxMEQ1+W1v/hJ9ic6X5FLzS97RfngUyGu1JPUpJx1MkcOzQFnBhL7ME7PWpHPhNE3/wLxE4XZY3CY3Yd/UVQL9oorbiVBqZXz4E5NcE+NIl3fSZIzHB3zGsDAlxCVHlIpz5nqU1mR1oANJBs7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723415488; c=relaxed/simple;
	bh=+OfdfTWrZamD35pL9yYktI+Dt5/eUQ9Fm82jA9qASaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYeH7UPgCfuCiE9D7+B0mOtXKdjF5SSU90Yp/62oNY/Tn/dk9jLjXsFcuV8jHifwEIH8qaaScv3jl3CKBrW/sWXscukvWwJ7iTrRIHsyLN73gUoYrSYf7nPWYq21fcAub2mhGsTbgwyzpGv3F9Kc9XZDjibM2XuHT7+BgvPrYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2YRREAa5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cb5a947b7dso775634a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723415485; x=1724020285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7af1Z8J1ZYV7CqYMAIhhKthQdQLBBbwUtlUS/K7Ttwk=;
        b=2YRREAa5RtGY4ZgkcUy8zXfROXC1nordwhFC6XNUqFrn6cB8ZHtKx+DIYr0UWD/9St
         FjyajqA2pdPuJXmtMXAY75hAvYvl3yIIVuYEw5QPnteONTTInTWQvM6lPI6DqfiM6vFu
         7szgxMfnKXaXbU+wO32NPU/lywW966HjMEZbR+nucKB85IulWOc5tGi4eySWAB09lHbs
         uMtJqsDFWImTKldvxP2Vhfj20OH5yQBJCdNeDefBjkqXV5LahLMkygLwO1Z6Ua6fl/Bb
         qUYRkDKS+b95dTb0sM0X0I7qp+XNtdOIIqOu8oZ4N0iYQ3saarZ8trw62RTNJw4ED764
         GfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723415485; x=1724020285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7af1Z8J1ZYV7CqYMAIhhKthQdQLBBbwUtlUS/K7Ttwk=;
        b=c0f4ARd0lI4kpsMdmdks+PFW7uizqdzFZk2a2/FlGoPkEpm0Z/EmTgMywzidY3ycU/
         9of/JIz27rLvOq030GfnKsxXBJTzu1legPGJ+hwOJJHi//oM5IhDUDRjdwKFTFqRgPFq
         539KDwb0Q7X38dUkEr3mF54TUbSSxZvqBqtLH6nEDpeUZxp1HnnE0HzQDxZuEN/2oJMs
         XCLwACE5k8Re1gu1BdpoHElLnD9pmR4kKS+NU8XlcaCFk+p/uCbV7aMNaM38aQrRjp3Y
         ni5+pUdwQpAC7uPAeD5FgcIDKoTplUy2vAXB6VB5ETcu+snAuKOfVanmnhiRJHkOrQZU
         DHtw==
X-Forwarded-Encrypted: i=1; AJvYcCU6LS0hAKVXngTJ9uviNYNhgaQMEUpVEMGvRSPy1ylNAl+11t0YdiXzrP8tSI0gD6+LdjmVTLXov82h7LjFF7NATKj1DBBE94BDp5WM
X-Gm-Message-State: AOJu0YyqT+cEHkChQbfQT0lvDhn0L6HHpTj9CSZmpl1+7iOISCh2iscg
	lEW8LWfViWA3cP44E1y3fYoln1QvISsBiWclr0mwlVed0fbjzFL1l80dzavj9LY=
X-Google-Smtp-Source: AGHT+IF1MMidK6QQRpKC6RqrJWEuJ46WY0ivcHc1VEvrmSGeMYZFhKc5OEo5DEy4elsAcIrheg1QfQ==
X-Received: by 2002:a17:902:e884:b0:1fd:d740:b1c4 with SMTP id d9443c01a7336-200ae50e1a4mr62708625ad.2.1723415485466;
        Sun, 11 Aug 2024 15:31:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9feaa4sm26429095ad.213.2024.08.11.15.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 15:31:24 -0700 (PDT)
Message-ID: <1207e17b-7a32-42b1-8047-b01e221ab3a9@kernel.dk>
Date: Sun, 11 Aug 2024 16:31:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/net: Remove unneeded if check in
 io_net_vec_assign()
To: Thorsten Blum <thorsten.blum@toblux.com>, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240811222638.24464-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240811222638.24464-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/24 4:26 PM, Thorsten Blum wrote:
> kfree() already checks if its argument is NULL. Remove the unneeded if
> check and fix the following Coccinelle/coccicheck warning reported by
> ifnullfree.cocci:
> 
>   WARNING: NULL check before some freeing functions is not needed

Yes it's not needed, but the NULL check is done after a function call.
For the hot path, it's FASTER to check if it's NULL or not.

I can put a comment on these, but honestly I wish the ifnullfree
thing would just go away as it's hardly useful for anything. It's
not like it's a bug to check for NULL first, or that it would find
something useful.

-- 
Jens Axboe



