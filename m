Return-Path: <linux-kernel+bounces-378300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1F69ACE09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10EDB2245C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7AC1CACDF;
	Wed, 23 Oct 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e4uPbHcb"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB431C9EAF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695316; cv=none; b=gM8FA5+bfiXYiz4O5cn1B3WSdxFETVkuNL8c2zwHAB5EMFUo41Ugjt/dG9ZRGIDqMIwNrTPujR/iRSNdDxAWV2Ms9Ox8di/R4oTOjf/f4evtgzlRvaokhwHfXr2AM+kD4pB1SaqNQuKCgPHCP3a5P+1sKmJk6Cesjt/48aVbQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695316; c=relaxed/simple;
	bh=ryoYcQggY/kP3u+FVq17nFJ4+xrseLriosS64MBSjiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnI8U19umyW7kE7r/FVLl/+zBxAPnvKtzuEkQa0AbblhA065YJMMEw+STtk4No5hNEcnvP8PuzVe3I1dMwet+RWM5QrbFpWmCQkp6E2JwTW+KLoxIqae9Lv9BvHGWS9qy+env+WLVSi8X9vM0LG/pdtltH2Rci2PvAri66qqRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e4uPbHcb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso592031166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729695311; x=1730300111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gxca2+tKQUchr19uflxCnLEeCJ07Xy8uJKlCwApgGuc=;
        b=e4uPbHcb6f9d+eMF168nzKA9pBtIm0r0/3s5Dk55Q51B/BkwA2UObV3mHVvz9d1m34
         6pgsFKmoWu01QV0VgD9UrPbZdrztpsSvM6bylIvy3Gmm2uEmFJCOHo76soLnRhyN5Prp
         /JhPf7G+sRo89/pTxdcC1yXKVqXChkpt0sbjTa/7LbDVbIQigin0DFOlvffk4wwaTT24
         dHiEdm3firyi1p1FKdwt9R7ssyUlLGQqWEXPOjs0OMP0cbbMlKjdpOWIFNpc7SeJe6g4
         HKDn14rIPgB4r1nxBZ6g0ebPUu40aZT2Id8zUnY0LIuVZbHMHvdERpVzVcLNEJyVOh0G
         YZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695311; x=1730300111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gxca2+tKQUchr19uflxCnLEeCJ07Xy8uJKlCwApgGuc=;
        b=PIWBhx+CdV1Ub5NpefOp+ph6G71/Y5/DCZP1J3I0IiT0YL8RqRWVYaDVQYZvahH/Fx
         n9SDzuQAI7Ob2L10Q8tWx78ipd1DkRdxm/i0TIvFXKyZSeRkB2+Dv4cpWZR4Zy6EnWAo
         V2BFB+vBZuz5WpweYqjDqvufw2fUv7YXgwTednhOFU9ErZnjLKFK8QhbvbjsiR4w3hzu
         +XmH+DCQROne+bjXC/VFGkLZLH9pGJCGxMUauCEEEW9tNLGJdSwNRedESeLf6Gi9efI/
         TpDWYHjCra4IGO7xbGbYy2TexxJKro5GeQ7WasETaVhSOvDGLg3TpsENq7ZH5nKptThy
         TxGw==
X-Forwarded-Encrypted: i=1; AJvYcCXxTeuXyFmhWGQmikHX3rSzWx6JMN3zwONifz8D0Bqn4zP1HxEwWQBb1nLX7KoZDdexka0FKpvk3Kdzr4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8SBTpAvl5Okv9sVu5N+Vhtwi3cU213GWaq1pgoujpKiAnOxK
	knREriECfWUGK5e8gLBT0dQ8/GlPpQx5M6+w8QCK6gQUecOYLmk94IxyHJpt46s=
X-Google-Smtp-Source: AGHT+IFF5GkyZ/SIiWUhNMG76ItfLSNQ1wsWrDDpfsA7r7xDzkAJuk4mXSah2g/qB/JAMfOt/g1vYQ==
X-Received: by 2002:a17:906:dace:b0:a9a:684e:9a64 with SMTP id a640c23a62f3a-a9abf96bd4dmr274083666b.61.1729695311081;
        Wed, 23 Oct 2024 07:55:11 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157170esm494220166b.144.2024.10.23.07.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:55:10 -0700 (PDT)
Message-ID: <ba3199bd-e891-46af-832a-9194b64a3d39@suse.com>
Date: Wed, 23 Oct 2024 16:55:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] gendwarfksyms: Add support for symbol type
 pointers
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-37-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241008183823.36676-37-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 20:38, Sami Tolvanen wrote:
> The compiler may choose not to emit type information in DWARF for
> external symbols. Clang, for example, does this for symbols not
> defined in the current TU.
> 
> To provide a way to work around this issue, add support for
> __gendwarfksyms_ptr_<symbol> pointers that force the compiler to emit
> the necessary type information in DWARF also for the missing symbols.
> 
> Example usage:
> 
>   #define GENDWARFKSYMS_PTR(sym) \
>       static typeof(sym) *__gendwarfksyms_ptr_##sym __used  \
>           __section(".discard.gendwarfksyms") = &sym;
> 
>   extern int external_symbol(void);
>   GENDWARFKSYMS_PTR(external_symbol);
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Acked-by: Neal Gompa <neal@gompa.dev>

Looks ok to me, feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr

