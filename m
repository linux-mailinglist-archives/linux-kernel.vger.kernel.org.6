Return-Path: <linux-kernel+bounces-440308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC609EBB89
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4E3188A14B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D880D23099A;
	Tue, 10 Dec 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak7KXr5q"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954CD153BF6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864931; cv=none; b=X9nBbLZRRbdUymqzjt/Zb/jL+/B8gRQTG4XkVQk+mo+GLPpuiXhnsk5BOm7x4YqvafwiJ2Hyp1nyHgHqkAf5Q1sw8a2yAY/XEGMOH10Pk9Q/NVSk3uWyXjVzLHunmsFApPt3KWJAHrT2EVLHwJj+plD+xMQD4h068GJEC84nwgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864931; c=relaxed/simple;
	bh=r89WJ71V3YTzslMYQlYpIpb6dA1qoy1/H27X2LElRSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzhVKN6WMN74cOZtw/SynTeVA97QFKOwGvax5BXXenNW03BVCEQI8rCFuf/+q1kIxq+t9qTxtaWWne4Bp8Qgmvu36LeJNAjfrymCOcRKygTmOXJ5B7w0KicsJweaX0PenewIT7KvSJWc9Bt//SdENXEoDLrlYWfDBHzSqg0UIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak7KXr5q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so3328373e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733864928; x=1734469728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r89WJ71V3YTzslMYQlYpIpb6dA1qoy1/H27X2LElRSk=;
        b=Ak7KXr5q+lul8JRqX2ReOIIbKVRzZiOue8d5JmjO8hTSr0+YIRDZghAksaYoCHQs9y
         TCaeDyf9tmmx4NQW6yHszrJQpg+ogcFLzHXyi0blTdfqX0KBQN2bJjqDOkYgW+d7jYpc
         c4Yj8q3FO4BhuJYsH6FBSs0BN15XAgae/iuK4ORh1XxHF2Dd6lq2fxC9ccm/DAEFGDw/
         k/KUwtefKqKhICvhH+aG7R69aX0M1Zynq75PxiNyREP0OB7TkQjRKmc20HrwEtFurDNC
         5+YA2CWb6QQrd3RvXh4CmkUHPw5drP2klf4gA99X3UISUXDWFQ/EfY77N+rYgflqW8vJ
         KYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733864928; x=1734469728;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r89WJ71V3YTzslMYQlYpIpb6dA1qoy1/H27X2LElRSk=;
        b=EO9xfPTxvKr+bhr/HdFrcnW/uzVmgG4qSTK9+XFeewOkxm5m5rArJAGjdQMCKJBATt
         9jWD2WXelpV6WoQ839mfVRFeQae3TMFiGJWsuM/1agpLrtEKFYDaYIEJ/+Sz68DSBWYx
         C/OlXue9jCazsD+LzQnJ9+eG/92PNjhiZ3s6HztG0J5wLd/pQZBhFxNeZXeM6ua2x8cq
         ORyvyRwJgumG+DWiGtuOMo4V5DeeXP17PtDWUHVQz5hStfLrYnacBqgeBC6nE5xD9/aG
         YgykUfXpKhG0Pv5s79eXyEaOSPm4mX1b6+bcgn1ymVA+NL2nJ3uIBhu/grZNAC3VYZ3S
         a4EA==
X-Forwarded-Encrypted: i=1; AJvYcCWIY3so4nRksAyD5M+9quUSHeKc5zLNFN9lBnvN0zqLZl678k7VKOKTfaHSbHlHz52Qd2Bts1GlbrNgoEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUnvOm+pgxWnwttam0EaSHsUWcma2IBq17lRob1EVX96fArF4
	TXxiZ3yQD1Zpg48yBnIec1/O1GTDY9UrqzqvR5FHtl04rhbB8U1A
X-Gm-Gg: ASbGnctbGhp5WeAVSMYZdaSMLRVGv5EnQ4od7jytFMiLzikBv63Gr2NQypXjXMxdHVY
	C7ck/VixK/Uc/GTh6QbhooiDzvnfPleJwrbyohAiFP3EpoBgHeangZIUZU9x4ycLJMoYIjf5675
	+NFLAAZfjaOH+V31xGPY37ayHxMlhWXyBdubMN+jggD7Kkw6Pu7nl8LNOHjvzoPlieXel4raK7g
	zVyqI5kMWOIOQDE/F4Zcx6nDgRSaU4PmmAyuFzYX8LjBczNjA==
X-Google-Smtp-Source: AGHT+IEuuGiowqm9t0T6GZ3ohEyU+Y5PIDGwKZLRHFNn2OW3cItqbVra0DyYQJLFJFv3jhJaL6thxA==
X-Received: by 2002:a05:6512:1051:b0:540:1fd6:4e4f with SMTP id 2adb3069b0e04-5402a5db878mr85563e87.22.1733864927341;
        Tue, 10 Dec 2024 13:08:47 -0800 (PST)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e2297501fsm1817564e87.105.2024.12.10.13.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 13:08:45 -0800 (PST)
Message-ID: <7ea06c6c-d1dd-4607-b0d8-fb60a9ce6f65@gmail.com>
Date: Wed, 11 Dec 2024 02:08:44 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 05/11] x86: add CONFIG_X86_64_NATIVE option
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20241210144945.2325330-1-arnd@kernel.org>
 <20241210144945.2325330-6-arnd@kernel.org>
 <fdf8b753-f4ff-47ea-aec7-508ad72ce5b9@gmail.com>
 <ea07afe0-c6c7-4641-9121-2dd591797852@app.fastmail.com>
From: irecca.kun@gmail.com
In-Reply-To: <ea07afe0-c6c7-4641-9121-2dd591797852@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/24 01:56, Arnd Bergmann wrote:
> -ftree-vectorize is only enabled by default at -O3 level

You maybe missed it, but vectorization is enabled at -O2 level since GCC 12. https://www.phoronix.com/news/GCC-12-Auto-Vec-O2
Same goes for clang, it pretty much always had vectorized on -O2, iirc.

> avx2 is already turned off because of -mno-avx,

Hmm, I'm not sure. But if we look at existing KBUILD_RUSTFLAGS below, it has both -avx and -avx2.


