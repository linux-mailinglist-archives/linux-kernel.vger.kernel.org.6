Return-Path: <linux-kernel+bounces-423997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB949DAF26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF0B282460
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9844D2036F7;
	Wed, 27 Nov 2024 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rhcPvC+T"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5371202F7B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732744761; cv=none; b=aeIzOJNKestM8TsBHuWM5bw+Z6XAKtvxahPQRnNzZ/wsUJgiVtmFKhrFnzkJ9oveUBbFX+K4kv0gpvCtC5U6q4NfMJZtBC/ikUqD7uabE2xRu+Tq3ioblIDiyjkrP6Hhw04BJi/V0UJxy7NN7mbLYWCg1kPuqPNgI78ojxz6wyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732744761; c=relaxed/simple;
	bh=EpyCOs+Z6zkty7izlchz1P6j2Gr7jr27psSLsCj9icE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4pIYHU9cXCiUN8kzKBdBtEHp6yB/FCQy/l/0DCtaAiGtAdxGr/0M8jLQCA3141CpYcyIaIVmxz+lDAR6n+bU8KDkvzeV4igwVkHHzd3F5PEs5wa9Ds5CBG117ugczt2hnQFMoBob1QI3wLiR8Ask4f00rYHJaWzzbKb8mBAWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rhcPvC+T; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-29678315c06so167770fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732744759; x=1733349559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12XoOV+ch7FCQfE6NT5kyo9s5lIlHBLbYoEQq9a6XfA=;
        b=rhcPvC+TBOFBCsI8SzBGFRmLT5HbxCN4237pKjoaN98bV0dF46hdVm0VKAxvgwX0kE
         QjtBUwyy0dWU+dsSbLKqbIjkCZCMPmEL7MATJxuBj0ODITDEgFLAVd182zBmuiSzxwTs
         nqwi4PehfHfTzAR8fOD1ARX7XEyvkD/jSFFIn9uqOYAvqOLK6mK9kBrEOOr4dUaWiVqs
         u8SEAtjOIBVgmh6xv/e/OIP0F17nl6s8+wLgV56c3GkYsdv5u0EBXAiDCpY2bNiUnRjp
         hs/ueh0xNU+n0ikmHlKYxBfB8dIaC7ptIRXVw8O3apCe/xmPkR5RnqVR+xjfOXBt5yOK
         AL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732744759; x=1733349559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12XoOV+ch7FCQfE6NT5kyo9s5lIlHBLbYoEQq9a6XfA=;
        b=baLvmvmpktYOfpKWBDcEn0FromycRpUMLI9j2El3w1Smvsa0lQTKEDNZ9e6lUUzvdD
         NJsT6zmyVzrMyfiwg4pydxZlKKwrEb3ufzv5tysCVJWdLI1kNBD+JN3/P2GfQnUt/vzC
         FjznGz2ajS5nmB3niyxFElxst2BuKAG5Ytv8VNJh43BW+N4o9MVNv/D2/4hAykbHohq6
         oAFdXtM+4Cvc3nD4sj0SCd0FCGOPFMM4rcvgn2vFUYFNx9hmPhh6Bc919JMm7CPgdlWL
         bj2qQ0lQZcL1U0+B+eKiBDz3UuQiTec00STwuVAph1RCm9PpsoRwXmTV2xIFkU2139+J
         ZSYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhCsPKysf7mDDWCAumC2+vD6ZLR/aYsg8b9YNF2w0Xt01NZquo0qilTpxUL63cwUJEd72Sl/G3V03oCAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLg46U7wVzu6OZjKo6ogGEfxMfwctOrFIcQf95HlebudCAPuTF
	EAOYpu/+2dWZnbwOLd6niz67FMT+pYOk/IPoVdA+/QCH9iXolf5EXRGJx6rQB7E=
X-Gm-Gg: ASbGncuo6xcvOnCVTjRWdZ/1oEsuyrhsUCu/KDSzPGEWQg2pYpwHQZsWpFDgueBYcY8
	y1stltvGb5jn+GGEjCqMWEmILt+XYS4SL0kNwFBK+oG4fQ5ETN2ulfBnMt6XHFvuVr0FEEBTyrR
	mEPaDQCI7qo77/Wlh/bnVfaSxidR1bSeMh4+VL1KWv+Dzm27k4FhKrK203eMfa1Jqb4/xBNMWVS
	k31bmjJlUbkL2zD0hwed4ZAtIUmzvCm/wBNAKDEcNH35w==
X-Google-Smtp-Source: AGHT+IGYQ3xEulXjbu30BXlZ0Yu1r2OXM2Ccr9z7cb2HBdSqRoErM0v/jPNzqRHD5gtEaEL9CcuTTA==
X-Received: by 2002:a05:6870:4688:b0:296:a768:9ef9 with SMTP id 586e51a60fabf-29dc4386588mr4340872fac.42.1732744758803;
        Wed, 27 Nov 2024 13:59:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de902d0a3sm48093fac.20.2024.11.27.13.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 13:59:18 -0800 (PST)
Message-ID: <97465113-ea1a-4cee-9235-d6900158aa74@kernel.dk>
Date: Wed, 27 Nov 2024 14:59:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bcachefs: suspicious mm pointer in struct dio_write
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jann Horn <jannh@google.com>, linux-bcachefs@vger.kernel.org,
 kernel list <linux-kernel@vger.kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring <io-uring@vger.kernel.org>
References: <CAG48ez21ZtMJ6gcUND6bLV6XD6b--CXmKSRjKq+D33jhRh1LPw@mail.gmail.com>
 <69510752-d6f9-4cf1-b93d-dcd249d911ef@kernel.dk>
 <3ajlmjyqz6aregccuysq3juhxrxy5zzgdrufrfwjfab55cv2aa@oneydwsnucnj>
 <CAG48ez2y+6dJq2ghiMesKjZ38Rm7aHc7hShWJDbBL0Baup-HyQ@mail.gmail.com>
 <k7nnmegjogf4h5ubos7a6c4cveszrvu25g5zunoownil3klpok@jnotdc7q6ic2>
 <4f7e45b6-c237-404a-a4c0-4929fa3f1c4b@kernel.dk>
 <tt4mrwkwh74tc26nkkeaypci74pcmvupqcdljavlimefeitntc@6tit5kojq5ha>
 <3c24016e-a24c-4b7f-beca-990ef0d91bfe@kernel.dk>
 <hrx6kaqeyqdchmv24xivrooyimackqx5mxm6vlvj3y5gusxgno@gjsbtm76unrs>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <hrx6kaqeyqdchmv24xivrooyimackqx5mxm6vlvj3y5gusxgno@gjsbtm76unrs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 2:58 PM, Kent Overstreet wrote:
>>> By the way, did the lifetime issue that was causing umount/remount to
>>> fail ever get resolved? I've currently got no test coverage for
>>> io_uring, would be nice to flip that back on.
>>
>> Nope, I do have an updated branch since then, but it's still sitting
>> waiting on getting a bit more love. I suspect it'll be done for 6.14.
> 
> Alright - if you want to ping me when that's ready, along with any other
> knobs I should flip on for io_uring support, I'll flip io_uring back on
> in my test infrastructure at that time.

Will do, thanks.

-- 
Jens Axboe

