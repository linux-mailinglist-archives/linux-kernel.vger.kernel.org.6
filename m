Return-Path: <linux-kernel+bounces-322158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFEA97251B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0190F1F24C04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48318DF65;
	Mon,  9 Sep 2024 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KbhyiewZ"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164418CBF7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919949; cv=none; b=Sd8/sEfauL6eYbytsYs26N60iaXq4Vd6nBLy3pNCSaXjw4NHu2m97tz/9Q/jNOavhR03Ufj+dandu/ZP/GDrl4yT6Gxft00Rz/Y+o3WIDa99rOjZs546H60ZtHnErYdKcCA4nKSFoLjxyid357jOFlQJzhInHEBFcWrNoFLENys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919949; c=relaxed/simple;
	bh=YVJXBVjLH/qjPhsAuB8GO1opHaSjlvv+AH5wT9m58oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=POL5Pqiug6//rUNHe30tiQw/L6qOKHQKeq2nCmsbVetrnNB6qCtjBFb5db4gM+2gTIAU8vXGZjlip7QLKB39tZNMQFNftc5mX6GXEZq0VfKRKqW9L1zI36RLnQx8md0AtzUr238/shLoy+VXKXek94SXBD7OLyC5Psa6vOYCMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KbhyiewZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso3988453a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725919947; x=1726524747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwoXTj/wQk0KjSjlfQVQbj+IGyz2p6trsMliz69Li6o=;
        b=KbhyiewZbYKNZZvYoHPt7NCEg41o8anGjdcDljfG2u7+QJ4QtJm4YfKgE4a+WqhmK2
         Yxe0OnGMyXExzOZhcGzfo7o3HX1v9wQPwy2cJhjPPjV+oNEC6xijfM0/gzGgObcdD1W1
         8uDHtwZN6sYin+0pwu17FngEjjGs+uFzKkK4SsyQ0UcKupuwGcCan0Hn4ui6fNjYsQA3
         WbHWR0Ukhg55vSsR0DR8HdnF2TU4YshSB7RLFAf8zeeKO84AFaX6qHUmOGymodR9mv84
         1F59drCCFqYLM5da1hdc3bYerNBG4gJ5kLB3gTj0zpwwypHp582v06K8t/MquT9WS8+e
         yoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725919947; x=1726524747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwoXTj/wQk0KjSjlfQVQbj+IGyz2p6trsMliz69Li6o=;
        b=wsNe1cXgyJ3wwXir44OcQ9LR1lK4vJf+lf3Elvz8EbaEJZSZLP47ap/6Xw0yTLrhzM
         ZVEfiwCJn2vie6Lj7H3WbrWoEhdj9Uier6vGmyIWiTJijRvpWfOS1Myjdj4+6HvSEdFY
         Ac8DHPHFcggJjuu50dezpRUs7+U9MFhHm6UknmpxLEtHs1x1Y89td8T1BUP+aabv52bW
         qF0fM5o3d/lKwXMd1TPo1WjkyZsyttQcleygScChWJR5bJ8bWR4/1WleD4xYUGifQqFO
         b/ymxG/H0cSYlFbZFhtp6XyNDLrw0mrrM8Q3QK5sp2RGYbtntGmhGm0XFxQErL+aAN2a
         Lz0w==
X-Gm-Message-State: AOJu0YyebBxg7ytuc8WDiLHlNH9mvpP32KOlbjvOrpFhtNzD//sB11ms
	EuNpWxgzfsVkmx7m9raeFkZR/2gZEIpIxamAPzmOFzStbl9ksyGOFBn5+71Gs8Q=
X-Google-Smtp-Source: AGHT+IFLiey0cO/PHvsLMRuqy0XiPSW0/LdXMLWa/ZTgLGEvQW9z1zvyXQbhxY8f8ZrXGV7H3o29wQ==
X-Received: by 2002:a17:902:ea01:b0:206:cfb3:7232 with SMTP id d9443c01a7336-206f05e7eafmr207950315ad.48.1725919946511;
        Mon, 09 Sep 2024 15:12:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e324c9sm38203915ad.70.2024.09.09.15.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 15:12:25 -0700 (PDT)
Message-ID: <fec13c00-52c6-423d-a106-1d3be74352f7@kernel.dk>
Date: Mon, 9 Sep 2024 16:12:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Signed-off-by missing for commit in the block tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240910080605.4f26649d@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910080605.4f26649d@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/24 4:06 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   da22f537db72 ("block: introduce blk_validate_byte_range()")
> 
> is missing a Signed-off-by from its committer.

Ah that's my fault, I can still fix that up.

-- 
Jens Axboe


