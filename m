Return-Path: <linux-kernel+bounces-356870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA4E9967F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B41F23BDA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CA9156242;
	Wed,  9 Oct 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="srkuA4h6"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFC918BBBC
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471867; cv=none; b=Mo4SjiU9bN6sy2p3ceH2A8Cchza2jmPriqLmkoKZxDmXUVQn4w8yA5SreqgI277JKlV+rNh2kyhdekBFo/BsWVR+QMVE0wotULQSQay/djXkHkRYwRFjjIcrgqR2I0fzcEM0jDbbS5uWJ31EUDdmLz7WkUPRea5WLLq+p1LP510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471867; c=relaxed/simple;
	bh=akw4z7RCBxzqygAyivLS/uFj6Zz7BOFnEaigEkTnitE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OO+YTouemOpKyxsGFhVjSRt/K/8TxJuhqyT4uEZr4Uu2EMsrxggr2dt8WHHB5+HNW2RA7oX61HzNfp4o1+RxnHyQ7hbIxnNa8xu5kmdjiZ23ZqEkq1eO6tu8jsczk2P93xUu1ShfNKEZQWPP6EpJ/VR9dbPW0FpRQ1p2kcphVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=srkuA4h6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dec1cf48fso4232117b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728471865; x=1729076665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmXF2Q49luswGg/2y86q1ZQ3ULzUFXxuhYjCSrdRAvw=;
        b=srkuA4h6J/HM8ZNFCNzz7k7gexCTfMd0jaTPQpQUdY+rbqhwUycZ1G7F5Xa/GVmjl1
         I0suq/qNmOmmSQiKLGSaXlx8X/vYeb/csZWrmeajG5kVa1BYC+51z2E5YHxqTYy7pDt3
         +8lSUGrLrZ01HF44pLTc3d3OYlbKqYdAHLLI+fVsWytV7TQhwhtnoRLjvO7sbdGYYYr0
         BJ7YU0RGQpWyFy6+k0OitYH7o85TKT49TcYKQ4wnIcgdnbPOkfhdVoGc3BMazq3r+3UB
         +v95rKYS79euz9gO6UF8ly0H1qdISLQhAn11X+vA3oSK3moFDXCV3p/fP62p3+HOCVy1
         2yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471865; x=1729076665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmXF2Q49luswGg/2y86q1ZQ3ULzUFXxuhYjCSrdRAvw=;
        b=BuQriG8ytLOZ6SeTZLf08WZIuam561XbfcY6hAz2dXv/HWSi0XUMyQfJeZY3SH7ayi
         vKz0mDmcC61iEo6h6ohkymDE67YLqxaII5ORV+jwdaa0tFBVg/edLdn5oWOTnSkvIiOe
         7SMZgWfFyBhtgVqyMoDp+gdh+B6QH+E4Or9kIExHVjcP/aRM/UaQaIoD/0LdTFzMD97j
         3zMujxe0nXlCHtsBYf3mAXJUlaC3e2k1sl31TtlJVe3VvID4GgJk70chB3lEa4HFVWFI
         DihabIQH1LJThYZxOe3IcFS1ZzMoHvvRw4ZlMmrYR4yeqYLVq18zhDWoLs1YphieKgq8
         ++Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU+jgAuG9zgiQ/Pv8jXQruVKWCnwP3V24z9+yYxQF+X0XreCwnYP6TSGIj/wNeente+X50h04unVZm/5rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjlZMIQm/gQc/EH9ySRa40DkdsvvsiqnzpWBT2DXICu0sDc6D
	braMUH5/AAkn4hppDSd2wKG04Qp/tttCIEut8a/bNe2c9iB+9luIz+tSfUg4Spg=
X-Google-Smtp-Source: AGHT+IEEMjmiRET2kOs0GeInwrz52Oue3vtvkRG73mTQZZRLoPcG6hCze0/6KFkEbxi8zZg9lyGnbg==
X-Received: by 2002:a05:6a00:1312:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-71e1db85861mr3024260b3a.13.1728471865013;
        Wed, 09 Oct 2024 04:04:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccd156sm7550277b3a.57.2024.10.09.04.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 04:04:24 -0700 (PDT)
Message-ID: <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
Date: Wed, 9 Oct 2024 05:04:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
 <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
 <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 3:12 AM, Borislav Petkov wrote:
> On Mon, Sep 30, 2024 at 10:25:21AM -0600, Jens Axboe wrote:
>> Hmm, seems like a pretty standard cpu and updated microcode fw, no? But
>> if it's just me, we can just defer until it gets fixed, at least for
>> some more rcs. I just pruned the microcode for now to work around it, as
>> it's pretty annoying to forget about doing the reverts and then booting
>> a broken kernel. The box takes minutes to post+boot.
> 
> With the microcode blob removed so that no loading happens, what microcode
> does this box have?
> 
> Still 0x0aa00215?

Yep, 0xaa00215

-- 
Jens Axboe


