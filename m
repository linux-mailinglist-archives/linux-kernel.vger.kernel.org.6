Return-Path: <linux-kernel+bounces-242793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567BD928D38
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D961F24FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8316D4E1;
	Fri,  5 Jul 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ehjT2Y/e"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0C135417
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202331; cv=none; b=JNgf3LLCU/vMR/KuhEEUbUGesYeQ3MjUIPHfWdfbhXw/Jm7aT1m1S4alQ/M7vrd1hCDhUNeG2ERs3WEAcpl0BzFVkgVJRvTR+EyKkCgpPbAM5pmgux0ROh1WtCIe3kRLOMSOnIf/0ABaUnBZeb9hlbzJX9nLPT5iGDQGH0L3plM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202331; c=relaxed/simple;
	bh=U4Q9iUsIHozn979/PFNpyG7JLQXeBFWhmeQepI8slGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQ3Y2uvfXNpXBhLvBMmAbAmb5E73Zg6iJbFIUJpgo3zDGniWOeoG+uPXJXL41SUqoYGzO+nAZN+qKIba//qAU/WM7BCV4OPNHhtQGRK4//M8pVfu4R23ko78TKCt3dQx5PmTgvPRXIBHzoMyc8dWbE2WssdjqZUq2zxOKiI9KsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ehjT2Y/e; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f2ffa18bf2so483732e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720202329; x=1720807129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6rchAFSlYahM896I1I/OZo7qd5XWpA7Aq79k25WOCCE=;
        b=ehjT2Y/ey4QwDboYrd6i+NJ4lndvDltZri4s8bngIhT7jPWS44CpFMCWHVmph94jep
         JkMXXiVbChyCUhZEcy8fdpDH6sJ9pA5DmGNotF2kS443sZNGSnoPEBQfkJzZmTUUfuIU
         3p9nE39uqLYfr4BwgT8yLsRy0Kc1BtI/oWbrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720202329; x=1720807129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rchAFSlYahM896I1I/OZo7qd5XWpA7Aq79k25WOCCE=;
        b=Vf8MtCuWW9L+LZLcPqMYSaebOscEvWt/SuhXcvI0CItGlbE7IYIKx5flGYfURxENZd
         5k4UKGkbEn86rzbzNHBFr1ldysMStP5dLhMpuLeWVgg4jtoCWJRub/dVRzl8rkjAo0mK
         EvOUvPkWyKQEj5JrO2cLi/E7hBZeqBkmBVq8eUAsRJuZXVt3T6d+PTsG9rzjL3dHLnYK
         4fvpVEZNitxT2tjYYgGZrnhQe7IIwkFEKOql7jvS21pnfd2FxgWIavioU1BeWT9nNGem
         q7/N0GO1aWEjEFav8DTb/ah7DlYQTtobW9oLNYz2eFPx1GpkVCuOhy+IF9kAKI34Pj4L
         mH9A==
X-Forwarded-Encrypted: i=1; AJvYcCXVea4GfWOexV5MsSE3XXKiF93bqn5zqkQQhyNTFXYMA6RJwMYTgh3cigCCt5Ur74mqcPHn0FUskqKsfzmFm4B4/LLaCTPe3PSdKZ5Z
X-Gm-Message-State: AOJu0YwolBrIhdo3Kpn1pVX9rblo3bagu89TpFMfItnaZViTDuTVFav6
	pJ5f9iUOM8pwMqEJmbQTaL/Qmq+S131wcv6oQ/CUQNUk6vEPF7YIunnwfgQ4q2qMZ9RvBT/heN2
	55yjpQg==
X-Google-Smtp-Source: AGHT+IGWwWQ+qDCvX954R1WS6rUZ6U8XTwn53fCi1IfgNwc7tbniWCtoCdozzJOWnVYV5ZqO0+G1HA==
X-Received: by 2002:a05:6122:3546:b0:4d3:cff6:79f0 with SMTP id 71dfb90a1353d-4f2f3e5f626mr6902879e0c.4.1720202328633;
        Fri, 05 Jul 2024 10:58:48 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f29b4e1ff4sm1995814e0c.21.2024.07.05.10.58.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 10:58:48 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8100df48323so517853241.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 10:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4h6wefherbVTgdkry9QXB79MrczXJ4c3D6+891GtvCXwpj8sLjx+KOKFakdtOp9Yl+VJE+UKCvoPntzpVqUHEnz5e+OJg25MZ/psr
X-Received: by 2002:a67:b902:0:b0:48f:b577:e02d with SMTP id
 ada2fe7eead31-48fee7dbfaemr5668127137.25.1720202327405; Fri, 05 Jul 2024
 10:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625040500.1788-1-jszhang@kernel.org> <4d8e0883-6a8c-4eb5-bf61-604e2b98356a@app.fastmail.com>
 <CAHk-=wjDrx1XW1oEuUap=MN+Ku_FqFXQAwDJhyC5Q1CJkgBbFA@mail.gmail.com>
 <CAHk-=wiv=9zGSwsu+=tKNgDg8oBUJn_25OEy_0wqO+rvz7p8wg@mail.gmail.com> <20240705112502.GC9231@willie-the-truck>
In-Reply-To: <20240705112502.GC9231@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jul 2024 10:58:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>
Message-ID: <CAHk-=wgRgDy8_=uZPZr4LRyF7BiN1nDNzUx7iRzrD0g8O+bh3A@mail.gmail.com>
Subject: Re: [PATCH 0/4] riscv: uaccess: optimizations
To: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 04:25, Will Deacon <will@kernel.org> wrote:
>
> we'd probably want to use an address that lives between the two TTBRs
> (i.e. in the "guard region" you mentioned above), just in case somebody
> has fscked around with /proc/sys/vm/mmap_min_addr.

Yes, I don't want to use a NULL pointer and rely on mmap_min_addr.

For x86-64, we have two "guard regions" that can be used to generate
an address that is guaranteed to fault:

 - the kernel always lives in the "top bit set" part of the address
space (and any address tagging bits don't touch that part), and does
not map the highest virtual address because that's used for error
pointers, so the "all bits set" address always faults

 - the region between valid user addresses and kernel addresses is
also always going to fault, and we don't have them adjacent to each
other (unlike, for example, 32-bit i386, where the kernel address
space is directly adjacent to the top of user addresses)

So on x86-64, the simple solution is to just say "we know if the top
bit is clear, it cannot ever touch kernel code, and if the top bit is
set we have to make the address fault". So just duplicating the top
bit (with an arithmetic shift) and or'ing it with the low bits, we get
exactly what we want.

But my knowledge of arm64 is weak enough that while I am reading
assembly language and I know that instead of the top bit, it's bit55,
I don't know what the actual rules for the translation table registers
are.

If the all-bits-set address is guaranteed to always trap, then arm64
could just use the same thing x86 does (just duplicating bit 55
instead of the sign bit)?

               Linus

