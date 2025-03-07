Return-Path: <linux-kernel+bounces-551510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749DA56D6A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1B1188B4F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A217C23A9BC;
	Fri,  7 Mar 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YCg3Uw0r"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3823A9AC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364317; cv=none; b=kU2ZtVYestAXl504GRhIWJOJ4DuW8S008VniHmudBu/3b4MEF9u8AurC1onY2mxTLPitBcbxa6BFXHbfZaoLiDbj/ZcAcssjf2hjHUpnEGp1dly1W1hH3W/uOnYCmwShRhRmWjtt34raIhKdp6Eg+vTDuxpqsVnN8B/WWMcl+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364317; c=relaxed/simple;
	bh=Q7P4hSefpkC1UbSfbt+doLOOOpwGC3N9h0F6ojYSWWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThwWwFQVPn3xmehOqcqrPW7770KtvlHg9DEnhW34cHSApeCFokeMkQAnm/tUTzj3cIJUL2pJ77AZeQQfethrU9zPz3LLjJZpyINBjC2tJH/Tp10yLMHNIf2BFy9PLhrffnARVTeqcRanmRO+0z4YwRsa0YuKPKx2CL3jDyhv7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YCg3Uw0r; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so4818225ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741364314; x=1741969114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=In9PPY40Mgr5yyZmxf6kZQr/QlJ7nuj8M0fwjZ4i/fs=;
        b=YCg3Uw0rWDiMXhs+4gxJ3CqU7x3VRb7hkgp2qae0pBtq+uEomJJNb/jkA270xjZ+aj
         5iMtwRJrkV6j3UwwVZA+xLSQ0UL2LcKyCA/Mg1QXXaLf96jTtj8EJI6Hoz+X33vcSuh8
         3C30N694aKe5AuQ1KeNdfW2Swuo/565rcvfuL6yg+wm8Ey3hbbUYxcazmXpMepsAYgsO
         wSKR3UNgCbKNKFMaeD33MS4pFwOCaYnbEqyabsG3tnWAllX7M97zaRH8FllLahhIyp9O
         VeBEHU+f4X4XumMkPD9CDn4R0EEhPop0Wv0S4B/docHIUOW6vPFevSmthMmU9GXaQ/Yf
         U8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364314; x=1741969114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=In9PPY40Mgr5yyZmxf6kZQr/QlJ7nuj8M0fwjZ4i/fs=;
        b=wodIlNVdCTZPiq8f4AmkMtsiQ6FrDS6JmOH/u1+gQhZgeBBiWY10lvDWqBNI9Q5PoH
         LhQ2lo5EDYWcO128nAuAmF2BIexBlTufAWZuasvp0H4IDjbaSwFL3sp0lFVcMIFOhu+5
         rxYn5I79+ipmM16aS7gZJ4FX4Idgw0x1XbP/pG0UoMJxwZHy+yeUblbK6im2kAvPJCqg
         OT5zcRZlUd+xLZnwvSY9G1xeZHg3I1bZhp1cU6yyFcLxixJLcFq8lTmBg2K6fkRSdCjX
         ClLbUCX4NAq4wI9vftctxiI/I9hvUydptEXXOT2dhr/u5H+hsibENx8uFmwYY7wAiNN4
         GPGw==
X-Forwarded-Encrypted: i=1; AJvYcCUa2+sXA9sbc4VtJy8US02gZE2zBhsM27MrJ4zq5q2Yfz4qrm4GeEZTrNRxqAGN+ld1OLxNS9tMjLfp7k0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71ngaDI5GF9KLYizfssduKlx3l7m6SXb2LLnDUxB/FBLJAvnG
	xb6lrPMMNEqw0PG3MXpM9ZtBKSfnXLgD/TsZWDQUx/La395iUpNkTLsCUPh7AiY=
X-Gm-Gg: ASbGnctNyxzCKM+07zoBiUdsyTR7W1ZY5EbDidupk2jetcAxXg3yTmB89qkPZmBzhms
	9ecdMgldvE2nnKg8mmc7kIWqDjQ9gqnA1qz37KZOA08qBOQpp3kXE2RpybNaoicHHZGE8wZhAsG
	t+105oZtSdGmscS6VjumcjSU+BO5v/EbFYC/0t+JfVmAKGYYVH+sED3BVdd7ybP1SdW6D0zefvV
	ol3Xi82Tyf+9+BZnlfezJAAFrgkNft+Ktd4jZrT+Jt7AqN6xVPiuSle7rFV5G00LB+ss+t53EO3
	40nxkcXW6Qq7OFiE+sA1T53slc4HJ4jyqF9wtp59
X-Google-Smtp-Source: AGHT+IEZIL6kjCDQac+J10FL30HMzY4rLD57DIbTTax5qwBe0pYmXJaCKIsBu5zSRoGSQEaVsikMCQ==
X-Received: by 2002:a05:6e02:1a05:b0:3d4:3ab3:daf5 with SMTP id e9e14a558f8ab-3d4418dcc7amr47772725ab.6.1741364313935;
        Fri, 07 Mar 2025 08:18:33 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f20a06b059sm1005242173.136.2025.03.07.08.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:18:33 -0800 (PST)
Message-ID: <fa3bbf2c-8079-4bdf-b106-a0641069080b@kernel.dk>
Date: Fri, 7 Mar 2025 09:18:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: support filename refcount without atomics
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 audit@vger.kernel.org
References: <20250307161155.760949-1-mjguzik@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250307161155.760949-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> +static inline void makeatomicname(struct filename *name)
> +{
> +	VFS_BUG_ON(IS_ERR_OR_NULL(name));
> +	/*
> +	 * The name can legitimately already be atomic if it was cached by audit.
> +	 * If switching the refcount to atomic, we need not to know we are the
> +	 * only non-atomic user.
> +	 */
> +	VFS_BUG_ON(name->owner != current && !name->is_atomic);
> +	/*
> +	 * Don't bother branching, this is a store to an already dirtied cacheline.
> +	 */
> +	name->is_atomic = true;
> +}

Should this not depend on audit being enabled? io_uring without audit is
fine.

-- 
Jens Axboe

