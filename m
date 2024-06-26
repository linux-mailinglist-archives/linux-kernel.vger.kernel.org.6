Return-Path: <linux-kernel+bounces-230995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EC91850E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 618ABB2B544
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4F187540;
	Wed, 26 Jun 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="LL/Vw+Hy"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC018732E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413003; cv=none; b=uEphJOPF5PPKcbYDRWqVQ4r3m+NbvBotf9hlCAHnLpbysIV6QOVRtVrfqYrgVP0u/HPB0QoURsMaaBKyhvrfP85QV9DLQh+Ja7ZQ/R1UHkYEWLP5jzsgpNO6XHmWc60POSJXkwhS+TeJ1Jvf6dcarMYTUB8MeO9vBMOZjnBZmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413003; c=relaxed/simple;
	bh=4Jt+AexbXjvRQMS0JAeCAbbjUW8QFJXSk1h+JyEJMvQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=V04+heaB9S13XrZc+KPDi0jn0TiNGdAt4in/tTWD/XggLR1/mFqFd9P+niq9Qgsdj8WY6zn0SzbAxMP2e1zNNEW4Wb7d83ocEOs+PU46FewUvTWP+rQA62tPyR9av7gzprYRjWwQ3O+VzLDZ+rCWtqri48JQc/YNO0SSLhM6VDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=LL/Vw+Hy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70675977d0eso3327429b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1719413000; x=1720017800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qqVGSiK52qpEYkBFYQqtg/MLmm7mG/Sdz2MT9nXZJE=;
        b=LL/Vw+HyQFcqElkaZVbTOLvEMU2zA7AD0w6XKKZHaumVjItvva7k4LWs12rNwWZAou
         JWQmBRQfehdtudIEMl6MWCDQ0U2b2cuTQ1xl92U15PvHlqGhILtCBKpqysE7yd2S0YZ1
         1Jyi+m6r7S9B00VRv9Fg8Bb5raW0NqYxAph6Vws4dccwypk75iLnyAx9m5qa3m3Xs/i9
         uOGSpPI13TfRq7MULVqbwxniRbaOh2N9XlKtwsHbX0eM50rSrYCXFxvaRFVck2WWtbfV
         G2K27CFr/+43EgL//19ChVG9tKnOQxi3dv/jTsNTwsaebrirL2sluDqxP8lKMfaOQ/cf
         5AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413000; x=1720017800;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qqVGSiK52qpEYkBFYQqtg/MLmm7mG/Sdz2MT9nXZJE=;
        b=xVNBME9QcQDZ6AWMZ+3bR/NYRTrnGfIN07JIz/PkdXd5KJAvtvC0u2gZcWUsK0Vevg
         ijszFVexy6+W6av7AL1mEhzijwMNWljSvP8xmgRkcaiZhl9lIolNr5hUSvh5xZGvPerG
         JwXEQI3BkgExL7qrNotIPmsyf4hh3RMasepRmeZ12vbxEeaf7GwK8SlTmFr1acPhDcEu
         NlzO63ZSaj14Zi0fS85T4XaSnTdAnbn7e2sLVkqvHxFavxrdVztBB8nTW1c3HLBG5AIq
         qhlj7FhMJmK2cnhMuQyzBfG7z/rri5eLQWbJWJbNFV58fvOpoJGWoANkdiUeLEB1rH14
         eZvA==
X-Forwarded-Encrypted: i=1; AJvYcCWjpbbZcWKMY80/dnO4dhVf1xLSpsXG7uN2IEy6yR9qj2vwavDhAgkXWh/0U3BUzYaQEYuJ5Yb0Rp/89AeZc+rdNlVHy1Tj5UaKnMs1
X-Gm-Message-State: AOJu0YwS6IUW6xXf+6PvQDQQIzmGmJgWROBfYmCE5VhB5eJ90hi0z0nY
	z8SL+foxoIywD61K9cZ2jI/F7LK1b0Xp2LR84zGFy5TdAt6uctHhbh36sTIdDcc=
X-Google-Smtp-Source: AGHT+IH2/0OvXTCfvNRbeybdAi6Y6rc880H+FiHzFEwDjrLLdcNGpDiCXi7MY3ygYaSDhgJ3SraPqA==
X-Received: by 2002:a05:6a20:1203:b0:1bd:28cf:7645 with SMTP id adf61e73a8af0-1bd28cf76cfmr3000669637.42.1719413000436;
        Wed, 26 Jun 2024 07:43:20 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5576sm100665315ad.201.2024.06.26.07.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:43:19 -0700 (PDT)
Date: Wed, 26 Jun 2024 07:43:19 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Jun 2024 07:43:18 PDT (-0700)
Subject:     Re: [PATCH v2 3/3] RISC-V: hwprobe: not treat KEY_CPUPERF_0 as bitmask
In-Reply-To: <CALs-Hst_TpjuQw0t-p9GbcCY4FAwXSjWziHJJuToi3rWXo7mJw@mail.gmail.com>
CC: cyy@cyyself.name, linux-riscv@lists.infradead.org, enh@google.com,
  Charlie Jenkins <charlie@rivosinc.com>, corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>, cleger@rivosinc.com,
  Conor Dooley <conor.dooley@microchip.com>, ajones@ventanamicro.com, linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Evan Green <evan@rivosinc.com>
Message-ID: <mhng-7da30215-9cfb-4670-a33d-17d9464d60d0@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 29 May 2024 11:33:42 PDT (-0700), Evan Green wrote:
> On Thu, May 23, 2024 at 8:36 PM Yangyu Chen <cyy@cyyself.name> wrote:
>>
>> Since the value in KEY_CPUPERF_0 is not bitmask, remove the wrong code
>> in hwprobe.h.
>>
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>
> I'd expect a Fixes tag, and ideally some discussion on the reasoning
> and ramifications of this change.
>
> I posted the other possible fix, declaring a new key, at [1], mostly
> so we could see the two options and discuss. I'm okay with either
> patch.

Just to close the loop here as the discussions are on other threads: 
after a bunch of discussions we're going with the new key version.  
Maybe it's a bit pedantic, but since hwprobe is such a fundamental 
compatibility interface we're just going to be super careful.

> -Evan
>
> [1] https://lore.kernel.org/lkml/20240529182649.2635123-1-evan@rivosinc.com/T/#u
>
>> ---
>>  arch/riscv/include/asm/hwprobe.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>> index 630507dff5ea..f24cad22bbe1 100644
>> --- a/arch/riscv/include/asm/hwprobe.h
>> +++ b/arch/riscv/include/asm/hwprobe.h
>> @@ -20,7 +20,6 @@ static inline bool hwprobe_key_is_bitmask(__s64 key)
>>         switch (key) {
>>         case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
>>         case RISCV_HWPROBE_KEY_IMA_EXT_0:
>> -       case RISCV_HWPROBE_KEY_CPUPERF_0:
>>                 return true;
>>         }
>>
>> --
>> 2.45.1
>>

