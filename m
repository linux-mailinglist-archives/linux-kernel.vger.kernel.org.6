Return-Path: <linux-kernel+bounces-523050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D3A3D16A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D2F17942E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9328F7D;
	Thu, 20 Feb 2025 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1N197hb"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8F25760;
	Thu, 20 Feb 2025 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033141; cv=none; b=OsV4+SWv/fYQ9Zp94DmeaaX9sVAv6XL/MN1mqEgQ+mHBmLnj2GrQhDoPtwoWiIDqDR1T5EdQ8r93zVm26OWlSJtgMjdbnQVPjyIJhpmvDGJFJcnTol5aIMOL3S+evjYULmvHkU9pFHGn+LHv/efGr1zrOuG8rwJS7niQdJiJ1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033141; c=relaxed/simple;
	bh=xmAD4u6j6OS5zIIwffDsWNIF57ClSi1xWQ0nmzyLKzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDx5MGb0+elvE+PTp9uh+nChRvMYFKoIn3vueU5wQx5DEocwHP0BgQbACR17bbYbAcKG4YiOcvpw/y5sSkic5Lf6PH/6Gorg7z5tyH4Y/qaMqxJaZr1xZDo/PwWPZCfgPFKMHPztouwwCSZDhYIfHcgyi6Mt3oxbaEVbUUlYqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1N197hb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so709640a12.0;
        Wed, 19 Feb 2025 22:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740033138; x=1740637938; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=psF+r8fE563D6h4ZNSHAj2zKZZA4InS9LAIyTg/Ev/w=;
        b=R1N197hbAa07FBNMc8SWlWl0Vg27SBALs3OlXxwgo+0KdD5bX0d+HWHnp/KsdF4zlc
         9AYNCgcCBmWdZrafEylJwrR8oixhpqEKnGEytadJJFEXrARTid6yvjY49iAf+Xs6A7nK
         Ey6UkozUGXaoqp3OwU+WzVCo5EMBycXFOuxs5aE+MXgBiP8LvZZ2Fcg9hkIJN2Hkomjj
         TsG8R9+oyk0bZcCveYA72FOaFSE0ASZTBPKAXOpsiTD0X7o3MBVYqhQ5qugsp46EF9nn
         AA8LtkRlhXmpCK4+D/9R5+Fp0EQ1ncQ1i2HFYqm+4GVMfNhO9/xrgHW8sRix5vC2E/E4
         b5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740033138; x=1740637938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psF+r8fE563D6h4ZNSHAj2zKZZA4InS9LAIyTg/Ev/w=;
        b=LgTcwB9rmICPASXfYN3FDXHUqy0+XwX1jkDB+2TDkYaoVDTXhG/XCDvb2Ujsh+0YBA
         r10u3VdJA+eAjF01CiksbJz3QmkAdkSegKcq5oFMKgEcm9+FPJzK5e5qM2aIoJHJdPhT
         e6Uw5MN9Av1FivA2jxhtf56qjU6EKz8VpMsncbynLc9AwwW9eujvuc0EMdMWE6tHvNEI
         Tnyl3RgvaOh/2HljELfLpzM+BYIXZDCziBcHPPPqpm+niMqdmdrmdSNIaKPfmCauHxwa
         pdstRZE9mUntbwPEa8ukVmttd72HKlPvfb2/h+Hi3Dyi8MH3raVJz/WgssJJoLrjm6mL
         YU0g==
X-Forwarded-Encrypted: i=1; AJvYcCU8GDVF4Qm8wG5mV7RWKhlNQN6Kq3o2/wh4nJwVzgo/RaJQIIgF+KWhUOj5qtotAMrZynJcLavk1aZBQbo=@vger.kernel.org, AJvYcCXmB4UZ3B9ciYB7bzwzYDA5uJ7g/iXnU2iJdn2GH+OJmuO9xILlRGcJvWteNGvidIxhTC1kGqGefYaaYsYejhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gwHo1j5mqD2AObIvktf82Ro+Tw7ngrRgPAq5vdWb3m4NpY3j
	NIoIly28q7qWm/zE9gzqWRfi8VjI+hP245khKA0FaBV2qqstvPI=
X-Gm-Gg: ASbGncvJXvRdD1OAd8YnfQDlfYC/J2w6REyPqDGfnkUfFYrYnaFwjE7QF/UpoADpBO5
	dtB1vgqzutLu2SIndicFIAf+0JZcBZbXl0wPXShmAoAFm4mzsK6iVlghxPQeiqP8TIijUxi8MEL
	HCRBVbIurPpa9SiIj3NNUUgxrNx5ycpuGXEXtJtZw+aOeI4woqlaftKjukOHWp2IYrZP/4ubefv
	HTq6eFpFgiLQfilVm4qVPjtEq5w56x8wwIZAkb3ZYLikgDSG+/yCEeNv4Cbsuw9NW4OquKb/KZV
	6taeiQ==
X-Google-Smtp-Source: AGHT+IHkTyohRQl8pq+ou4BMJ351iOfL/U1YoZ72qwAGSKVj+4Rqfvr4zd4x2I5z/J9nLw0RM5D7xg==
X-Received: by 2002:a17:907:3da9:b0:aba:620a:acf8 with SMTP id a640c23a62f3a-abbccebc6dfmr566419566b.24.1740033137657;
        Wed, 19 Feb 2025 22:32:17 -0800 (PST)
Received: from p183 ([178.172.146.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb836ee14dsm906966366b.47.2025.02.19.22.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:32:17 -0800 (PST)
Date: Thu, 20 Feb 2025 09:32:15 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <kees@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <f77d549c-b776-4182-b170-571d1e5bb288@p183>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>

On Wed, Feb 19, 2025 at 11:33:56AM -0800, H. Peter Anvin wrote:
> b. Can we use existing mature tools, such as C++, to *immediately* improve the quality (not just memory safety!) of our 37-year-old, 35-million line code base and allow for further centralized improvements without the major lag required for compiler extensions to be requested and implemented in gcc (and clang) *and* dealing with the maturity issue?

We can't and for technical reasons:

* g++ requires C99 initializers to be in declaration order,
  even in cases where there is no reason to do so.

* g++ doesn't support __seg_gs at all:

	$ echo -n -e 'int __seg_gs gs;' | g++ -xc++ - -S -o /dev/null
	<stdin>:1:14: error: expected initializer before ‘gs’

  x86 added this to improve codegen quality so this would be step backwards.

