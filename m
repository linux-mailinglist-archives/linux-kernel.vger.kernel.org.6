Return-Path: <linux-kernel+bounces-252408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A469312B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61A81F22A54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A923A1891C3;
	Mon, 15 Jul 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SFkJT8lh"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5FC1662F7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041192; cv=none; b=m1QNcEur5g/ooCmY2WxL3BoOEmiViBUR04DZhVemMKQeunOXLVtXQB3urxaqGjykNJV7TWJCibBPYVFELc8DdOMEFKNfInv5ksTMg/xoNab06ZkYk48iGNiUGZSs6GMbpQnZgO3o8LCMfcRaGS4effCOlm44EY7mrDU3Xo9SpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041192; c=relaxed/simple;
	bh=TGvaJd9WyaOil5oDlMjA/Puyx5M+Vj53+Vr2/OxGVEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0hJxHiLBkMK78YGEQdSErk7kKMJu5D23hyT+3WA5uzbunoO7R7Gm6USnJmy97rUZy9Ty+Sdfd4WYLCbP8gK1Kb8IxHJm1YCzA5Z2xUTsm7+pCMAkN5r10EjCtMDFXbmzyKtWIZQPnaPlh8jrRztvBo5DFVEgOIl9kG2tRIjiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SFkJT8lh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5956cbde531so596436a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721041187; x=1721645987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDqeqb8+3xFLDAZH/IuJmseCLMJFmvqH6g6Q9Vg9+y4=;
        b=SFkJT8lhKdX+XYwqJDZ2JzNEGgCFYmkHZSpICW1g7MmRn21I6cvaOb4fegsmhusEDv
         12i+ne7ya0zHCRmEHYFEk8z5XVDCynB4rnvObYrOX4qac1Slo2v/Jw4HepEMiPU87oAU
         86gguBixteIa4DuNhz/L5uu/TxsnEurTuKcVOGHef2BapTCU5oCcVa6/opRdzM2k/t9z
         8W3deEn7K9N/ZtE0ARaIHyJC49Q/E+V6N7gZCg5ZUpl3c4band4urBaMZhR/IKkTmfdd
         RcAbr6k0fd8EplYpnYVXQYgKMuAC0EBcUnkIEKJN3jNtpQ0jmdUGpjsR23KUiuEmXQ9H
         xJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721041187; x=1721645987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDqeqb8+3xFLDAZH/IuJmseCLMJFmvqH6g6Q9Vg9+y4=;
        b=fdSkNHoNMLyuOUV+NAw9QX93q1iFcAeHVXJ2Czmk8LrbOc3B6Wvky8kIpTqF1qHl/a
         8Ad5mHGs8NBLxmaz9WK9wjeWUfaIXMddi8XRNhtIDYcocp6JqGrUqhV4twoPohzixNCW
         YGveUtzaQCOFCCDxBlXDDAT2+N/AHMWLS7mZD/9cMpbdH6cwwIvfYLY90IYs/nfy/awX
         JqtWup9m17K1EkL65Y2TPzKiIkyXxwrGlg6b553zZokV5xOpnjmnW3CtNoCog77qz6Uc
         jF3rVEB4ZHlOgpFtcvm4uFnko4XehoW1Be/zJzaa/Wl2xlod89tGo3RnqHBI8sIv+OlL
         +eiw==
X-Forwarded-Encrypted: i=1; AJvYcCWgu3poY+wVy4ksfzdthm7vr1Y0ZrAEs1Kn56XYI5qidtQDmrt8iftGa3ajUcS85CJjDCMOW0p2hRHFFYQXcPPIK85/nD60lOh1iEEG
X-Gm-Message-State: AOJu0Yxn66HgzNHoEvgg5V93uXCBAO+civlF6yAtFYTMRYJbN02kzmVz
	2nVXp7UslkbRxa9veulDmj13ImfliIbbUJudhgJZXnmjW0lsIHz+B5WbaV2454k=
X-Google-Smtp-Source: AGHT+IHw8mPSy2Du1t8p/m0WGzNi83QMPBpCH/cSl35fk77jmrXNLqKLl47AT+G/foq42WzUhk93lg==
X-Received: by 2002:a17:906:5a52:b0:a77:af07:b97e with SMTP id a640c23a62f3a-a780b683d00mr989663466b.2.1721041186562;
        Mon, 15 Jul 2024 03:59:46 -0700 (PDT)
Received: from [192.168.1.123] ([80.208.65.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc800d6bsm200032266b.182.2024.07.15.03.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 03:59:45 -0700 (PDT)
Message-ID: <7aba7c09-9c21-46cc-95fc-d2b9b5bbcd3b@kernel.dk>
Date: Mon, 15 Jul 2024 04:59:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring: Avoid polling configuration errors
To: hexue <xue01.he@samsung.com>
Cc: asml.silence@gmail.com, hch@infradead.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <db1816bc-c3f4-41c0-8946-f8d4a260216a@kernel.dk>
 <CGME20240715023908epcas5p1e16b2ac82c7f61edf44bfd874c920f04@epcas5p1.samsung.com>
 <20240715023902.1105124-1-xue01.he@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240715023902.1105124-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/24 8:39 PM, hexue wrote:
>> My stance is still the same - why add all of this junk just to detect a
>> misuse of polled IO? It doesn't make sense to me, it's the very
>> definition of "doctor it hurts when I do this" - don't do it.
> 
>> So unless this has _zero_ overhead or extra code, which obviously isn't
>> possible, or extraordinary arguments exists for why this should be
>> added, I don't see this going anywhere.
> 
> Actually, I just want users to know why they got wrong data, just a
> warning of an error, like doctor tell you why you do this will hurt. I
> think it's helpful for users to use tools accurately. and yes, this
> should be as simple as possible, I'll working on it. I'm not sure if I
> made myself clear and make sense to you?

Certainly agree that that is an issue and a much more worthy reason for
the addition. It's the main reason why -EOPNOTSUPP return would be more
useful, and I'd probably argue the better way then to do it. It may
indeed break existing use cases, but probably only because they are
misconfigured.

That then means that it'd be saner to do this on the block layer side,
imho, as that's when the queue is resolved anyway, rather than attempt
to hack around this on the issuing side.

-- 
Jens Axboe


