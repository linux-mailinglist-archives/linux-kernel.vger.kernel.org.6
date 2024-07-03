Return-Path: <linux-kernel+bounces-239427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E1925FB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099F6287165
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF2173328;
	Wed,  3 Jul 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XY9uydeU"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7A142630
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008457; cv=none; b=gL0Qc8gniLlvg26s0+p8SuxJYwgEZsUlUHS+Wo5VHkUjfhGYcEeHE4OCdIv5O25mo1bXGoMT0scKT0npSbF+HFTY8DXUzx+JWF2joDSKYlI1Bq3HCEbfOTnbMZ1RnH+9/NMJgSTtfbqMUVXC85sTsCKb0TyHwi/JJ7JnojR8hKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008457; c=relaxed/simple;
	bh=UzhSJLrAAaVzhix69nz6ze4N4/Ma1caSC2pokEUAa84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUtwQ047oHRjujJSG1J0LXqZhPhOmIBS69xv6DJnNNDaD5ayNn9mmcuHsKQAg8fVL2DexbWqATcR78oXs6CgjnUGWA2FB+VwGtQskmOjUZUsWziHJsYfs1CAqQxduBGu3gt9goRd+g0IzGMkp0MONAWLvPrCDCsS8qxXmOJpFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XY9uydeU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-71d125f2d96so452569a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720008453; x=1720613253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6TNvOhfIc2yfdvb4PHPTjUfHyhfdjos3tRQlobticP4=;
        b=XY9uydeUjx4FnT13ntAui15wfTsD2cINmPW5Io6/ILi0RgOdlwNgKSAnSTmuciwp6m
         JmQdChH76FnGSkqVhXA3c2K9sLGql49WBD9coj0BvFlQ8A7Os4oeyt+g5J9vNg2X9uZD
         mnStpNRsTmp476SwPcoByel4GbP6y0uBNnznJ+KfJcTBCRFqBSl6hcUWGI7PcKCptAGf
         JwG7sxoHOceNP+wJRmT6byg/9YLeQmkuBaZzQQ1Tt7ppfD5fBCYAGVQARMnEUAfnB+x+
         NG65v2LsTws6M1NqtU+qEDjfaiqAI0l0CkBtm3rdfEELPIqaoEgARyWYKlsM2bAQ19fN
         /ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008453; x=1720613253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TNvOhfIc2yfdvb4PHPTjUfHyhfdjos3tRQlobticP4=;
        b=vag7pXjw464h94UQF2iNhxZSau/ILqQQr9+vNZpp2CfrQp8B678FLrwqWUT/E1kLml
         vU8y1tB4e5NAE3ZFufX24RuH2AsbbsB2NVPm/RrxxR9IVweN4glMB1JifSRa5fH7XBnR
         zjuBJ6WpKa1wSK5JnN/ChHUouw6A8DAMz2Crky0EW8bSbznOjdJvz0gl33WXJ1Ck6uEH
         P3foiE/vffxguN0FUfBm1+Nr0eu6vyhJgPjLT58ra5oh7cnZXk32JKp1WWzcqZvMTI79
         pYQz1HvNyS+Qf5aA80PLPzJogxgNGOMvPcWFzsanTCbIc6eoXf2Cq7sM3/Kqw5/lUPTC
         dBrw==
X-Forwarded-Encrypted: i=1; AJvYcCUf0S2HLo/Qy5iVS8WpKHNShi0TukrQnTNAmNVF8QFfftGj1sy4fkrBhWrDDS/aAKW/zS8qoH/cqmO3vZVVnIQ2feKJ3NQMHD8wY5Yp
X-Gm-Message-State: AOJu0YwX+W33cctyWdHLTaaTEs1tTonSSnEb6vEXthcI6eX2O4FpvwZb
	x1oOFj+1Bu6GKIFbdi6SAqD/v/FOPpJKOQeTp573lTcqgrOHXQb5HCQCV8BjeMM=
X-Google-Smtp-Source: AGHT+IEonQEEjHC/MKtuahfaFi24H6Y994t8PTFisf88hKWdWgp+qN0nMVSFEoJhiJZ9MIiZbihGfg==
X-Received: by 2002:a05:6a20:da92:b0:1bd:a048:7fd4 with SMTP id adf61e73a8af0-1bef6296969mr14833140637.6.1720008453437;
        Wed, 03 Jul 2024 05:07:33 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70838a9a188sm10069043b3a.131.2024.07.03.05.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:07:32 -0700 (PDT)
Message-ID: <25b3b412-5b9c-4b53-b084-4b4cc8b60f90@kernel.dk>
Date: Wed, 3 Jul 2024 06:07:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: Fix WARNING in io_cqring_event_overflow
To: Pei Li <peili.dev@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+f7f9c893345c5c615d34@syzkaller.appspotmail.com
References: <20240702-bug9-v1-1-475cb52d3ee6@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240702-bug9-v1-1-475cb52d3ee6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/24 6:48 PM, Pei Li wrote:
> Acquire ctx->completion_lock in io_add_aux_cqe().
> 
> syzbot reports a warning message in io_cqring_event_overflow(). We were
> supposed to hold ctx->completion_lock before entering this function, but
> instead we did not.
> 
> This patch acquires and releases ctx->completion_lock when entering and
> exiting io_add_aux_cqe().

Thanks for sending a patch, but Pavel already fixed it:

https://git.kernel.dk/cgit/linux/commit/?h=for-6.11/io_uring&id=3b7c16be30e35ec035b2efcc0f7d7b368789c443

-- 
Jens Axboe



