Return-Path: <linux-kernel+bounces-420247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8299D7782
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7332162F11
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11D13C918;
	Sun, 24 Nov 2024 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XmTqu7PY"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6F2500A6
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732474379; cv=none; b=DTpH/2ZS0N3nbYVdzVNpQqUzC4SSBC23+uHyav6ciTDSv3P7WmfFa5Id3Y9iieL/aRPiXkKP5BoEjfnIYy+KZk4hGXI0v20OWFeeCsVI3/MrY/wnbEFifY06+o9USo1MerCux0Snb+3CInDmxi5HV+60XoOXNlxR1W+69Dq5Fg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732474379; c=relaxed/simple;
	bh=X9XIGumusi5Y9nR5mRJXM5P3L7Kpn1I18m37qaGI/4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1JH5G7uLzjpNDvGobg8MX3LBC3JSUVnvoSdvmWeBwroCMyMCJRn70ukxbodsRciesqQydbHMCzMe4AaVNEQP5ZqJHXKwrN9YDhrQg5LtcEfonUdNFO4WnBCy49ggX5hg6xNIS+YE+PTuAKDRczm8CsY14if1LJ35y1KA4E0Pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XmTqu7PY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53da209492cso4771711e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732474375; x=1733079175; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q3/5ab8VpuYIe8g6ZZDBo+PcR3CYmTU/81l/Jt+VtY=;
        b=XmTqu7PY4hydTijm2Sas0pi3gx0mC8D8d8fpiS98WdYuukSiiIvayt1Q693DSERgRE
         v/YpY+zFJNKd/aEE2nIj9g6REsVtyT0QpPuIOBf/rCdwxfex5A1mHrWNxUWunbKiw97W
         QfViHjfXyhPMZrRov9pfREMmzKNIaeXQ5ARnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732474375; x=1733079175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Q3/5ab8VpuYIe8g6ZZDBo+PcR3CYmTU/81l/Jt+VtY=;
        b=JVpCFriuTGT6340H3ULy/IXzHWbFS5EOk0BfAvqf5ioOsv+GVxt8NzRWkJaHpQmo97
         +nY1CjHia5rk2CJfDseomD+xcSvrATbm95Vb72yvt3plkOUVFvm3cl0umZGx5vcbDRtq
         Nyo6TjBvV0FWSUP5KO7Vy2z3nMs+x+S4ikOc5cv7LXEIrVSgyYorkjP9+Ue9XixCxMxh
         ONJRhBpLFmef+ikueDBt6KVdMGBb2jvp4D4dbCcCFlTbkzpjVoGRGw+SZL4VO2+DK3+G
         0gbb6S+75Z95gQ8hrOl1gelZuwWCobq+hHEHOmMFmDitNLeyNIoMMn+9ftpdfBUUcZi9
         5vAg==
X-Forwarded-Encrypted: i=1; AJvYcCXN0n0tmhwxuuZr4SkRpSmX6kYiNVN21K6PUbAipWBg9smVqUCWHyaZwlpwzBFc8ARnV2cPIkoNcLYwm+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQYCib5nR8bymE0hs8k+93HvWnblczSZ0yQpS1y4s7hitegP14
	wOTEBjH5YxUaMXNP7uS0LJ4DiLH3l7P1jxDr+TxJ3WCQtfl/Ten+0TJiolc7Qp7TXHSD6+iLlU7
	DnR2Z8A==
X-Gm-Gg: ASbGnctxgfRcpud6pOktKNKjRJgU9yTRfroy1eXkMA9OMmtEWBkew+x1kRkp7HaQwR1
	mjcSMgF4wcw5dMjJGO+VftX6/d3nt9gf4OoSMHFFEIDtMXU9jgfwriVCTu8BjyqoD+j6Kq2s9wY
	UfEC4adgZNwx0tkvn5TQW+ox7GUlJELLf5n5ouas0qLI0pz7976+TxtW1jP8HnTLE71bieqaJfa
	J39/PcxFilQxO5mW3PyD3vqPw9T58mmJ41lEOqf9zTmbuBwALZkwDYHtZ2ArR26Z+dEYTLsiIG7
	flcaR2RGk6zry/777JYKdFsS
X-Google-Smtp-Source: AGHT+IGJ3P7pyz6bgSRng/V5CLm1bjrOmdUuBQpS+gAD4xLpitdj0l/ADLvXa2tcZtVk37N/bw/gbw==
X-Received: by 2002:a05:6512:4017:b0:53d:dd7b:a133 with SMTP id 2adb3069b0e04-53ddd7bbb9cmr1523599e87.44.1732474375494;
        Sun, 24 Nov 2024 10:52:55 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5464f16b3sm118132266b.133.2024.11.24.10.52.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 10:52:54 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5325af6a0so187419366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:52:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWADSl0oZFizfOisStQMDHWz/ZwadqjBnth2QQS2QdaYKFlWZIm29Zg9FUYnGoG/oFFcYnZ2b4US/gEsTw=@vger.kernel.org
X-Received: by 2002:a17:907:7713:b0:aa5:274b:60e1 with SMTP id
 a640c23a62f3a-aa5274b69d4mr665593766b.32.1732474373747; Sun, 24 Nov 2024
 10:52:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
In-Reply-To: <0edca3e5d2194cdf9812a8ccb42216e9@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 10:52:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wik4GHHXNXgzK-4S=yK=7BsNnrvEnSX3Funu6BFr=Pryw@mail.gmail.com>
Message-ID: <CAHk-=wik4GHHXNXgzK-4S=yK=7BsNnrvEnSX3Funu6BFr=Pryw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Allow user accesses to the base of the guard page
To: David Laight <David.Laight@aculab.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Mikel Rychliski <mikel@mikelr.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 07:39, David Laight <David.Laight@aculab.com> wrote:
>
> v2: Rewritten commit message.

Grr. Now I remember why I did it this way - I started looking around
for the bigger context and history.

I wanted that "valid_user_address()" to really be "is this a valid
user address", because it's also used by the fault handling code (for
that reason).

And that means that I wanted valid_user_address() to be the actual
"this address is accessible".

But then it also gets used by that nasty

                unsigned long sum = size + (__force unsigned long)ptr;

                return valid_user_address(sum) && sum >= (__force
unsigned long)ptr;

case in __access_ok(), and there "sum" is indeed that "possibly one
past the last valid user address".

I really would want to just remove that size-based horror as per the
comment above it all:

 * In fact, we could probably remove the size check entirely, since
 * any kernel accesses will be in increasing address order starting
 * at 'ptr'.

and that would make this all go away, and that was why I was
(incorrectly) fixating on the zero-sized access at the end of the
address space, because I wasn't even thinking about this part of
__access_ok().

IOW, my *preferred* fix for this all would actually look like this:

  --- a/arch/x86/include/asm/uaccess_64.h
  +++ b/arch/x86/include/asm/uaccess_64.h
  @@ -86,24 +86,12 @@ static inline void __user
*mask_user_address(const void __user *ptr)
    *
    * Note that we always have at least one guard page between the
    * max user address and the non-canonical gap, allowing us to
  - * ignore small sizes entirely.
  - *
  - * In fact, we could probably remove the size check entirely, since
  - * any kernel accesses will be in increasing address order starting
  - * at 'ptr'.
  - *
  - * That's a separate optimization, for now just handle the small
  - * constant case.
  + * ignore the size entirely, since any kernel accesses will be in
  + * increasing address order starting at 'ptr'.
    */
   static inline bool __access_ok(const void __user *ptr, unsigned long size)
   {
  -     if (__builtin_constant_p(size <= PAGE_SIZE) && size <= PAGE_SIZE) {
  -             return valid_user_address(ptr);
  -     } else {
  -             unsigned long sum = size + (__force unsigned long)ptr;
  -
  -             return valid_user_address(sum) && sum >= (__force
unsigned long)ptr;
  -     }
  +     return valid_user_address(ptr);
   }
   #define __access_ok __access_ok

but I suspect that I'm too chicken to actually do that.

Please somebody convince me.

                 Linus "Bawk bawk bawk" Torvalds

