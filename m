Return-Path: <linux-kernel+bounces-429390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5DD9E1B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4E167617
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38A1E47C7;
	Tue,  3 Dec 2024 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C1+/yZjI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303791DA0F5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226852; cv=none; b=bXwabqM5en6MqPwEx+qo0vF/sUV5bf22MUP9h+r+2L5o/y+YXmRZC9RDmPaFFsgjh7LemtP2ItGFAiup4xxIu08m/3NsRxnFzy77XOqhWOZIHsWooklkbBTwRuD5l9nWsrFRxgc1BoHi+GuMiyz3o7tP6RTyCot6w9hAPXhk3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226852; c=relaxed/simple;
	bh=iZ6iZsYDGgn6+nosV/i7U3c9sBZT+1+wu183Z3mPfA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmARPqkc54ElvJiJDNiqllzp2y87Y29mFTIW1KiAnEEjQYmfxN90Ducuk6WlO2IdV6XT3Ds1dBZ3nKq32Jp0ubmy5hOXPnDoB4vMnZ2f43tzIejpxT4Ag4TZYkORvrSG2uUVbq+VpNESiogSPu1x2trEzePIAV1ZdKYoDMBpzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C1+/yZjI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385eed29d7fso1607560f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733226848; x=1733831648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZR6c9RoUjrM3dk40cs7PLYguaqe6xp835zylMe9vPV0=;
        b=C1+/yZjIPX22lJxVL5/59K8t2UzOxMgAMsfcH7jg7yWyPNbsHsdhExoI8UqKrCzj1D
         GYnWn2J1/IwyGF9bUNQOJRKG+ChCpUfdZno9hxSl7tfeIau8TMi206ETwDV7y7/n8Pp3
         KwzqWMkVebo2qOEgODlPjYMW99OEMCyIFwW3JUn5BM6lXh0p/t1oJWKCEmkdJOHqES9e
         QMfhKZ/heaYvjqad3m5S55UqsQmj1FwBcnmrrgoYIlrTMrOHgbdDKrYj2lvuQ/Py7ZU0
         C1BgnUljwa9mdnCWBb+1L6GHQR7Y8E1KmTi+yR95Wz4Hp7ScaJPPu+J9m+INB9zj1efY
         yuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733226848; x=1733831648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR6c9RoUjrM3dk40cs7PLYguaqe6xp835zylMe9vPV0=;
        b=Ve33uSbGeK22RyqVjWhPzCEz7P+mRCKi9peGbuM8/sjyy9vaqnj80P9fdBJo/1MgvQ
         RtcKR2lLqJK0xe/TafDYBHDs/muIje48ACiOlpYM6M52FY0E4DRL4k3UzTjBfWddmBVE
         ZvTBrnTmZOYs3zqlYroOpZ/WupPNOHxFsksSyAbN6pmK70uwsFXCYdeBf0/i7a1LrT/a
         +sFXOwiTaXWHvAAjGHXQE9Jc95JZTHAFyWgSyGjmdrAuF7tUi5jTur0FIqnZEKMArFx9
         dOdZz+v9+841BMyQc/dqZlM8pGdrEp5G1F4eNyAqLjuvPCj+5YytuC15Lhw9OlRLXlyu
         MhFw==
X-Forwarded-Encrypted: i=1; AJvYcCVGAeAJiHzoOj2bO8ybDmOaJSvUf2+9OmQmIq0U2cUE5n7sraso0nTUVfaaXucd5EFjfrOhc7f5kaP+ffc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaQYC+3R4ySj+I0EVOadNKm6y51RgcX0fU4+qakOyDoOcRPNy
	5r3ojp5S+TzzU8aSGWlPhiWrLX0vUwNcagjW2G/78pzfdAKELDq46xmGEayB5CQ=
X-Gm-Gg: ASbGncvlw8atZSFbosiqXx3FeWiDcqxgikdt1+agz1cq0R8sGdLo62a7NlC+e8S4zDR
	7siq/T8um+z9+HlX2VWCi0zUgVk+T89tECbWpb86r6qamnxoWmR/bBuXXlH/zXkfOj2rUQxENnj
	/UJJcChUyWQUa5XNOHw4GKLfHBwlCQc8+GFe4mqVY2xdgqCGnRifipWHjfQq+5JwYI3SkzDhN9Y
	RDgIP6VUD3vT4bdnZWA/UHowbVU8Gz2EIa1mCIZZzqn7sSikVk+gw==
X-Google-Smtp-Source: AGHT+IF3C+gAe9enWE6coDrJOE0PJBinw+OtrvrTgQQOl+8HAIq0aTYlzIw7cnuVNYgk8Zd7vO+IRQ==
X-Received: by 2002:a05:6000:2c2:b0:385:e8e7:d09a with SMTP id ffacd0b85a97d-385fd969071mr2152487f8f.2.1733226848550;
        Tue, 03 Dec 2024 03:54:08 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fa330ca0sm3064430f8f.11.2024.12.03.03.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:54:08 -0800 (PST)
Message-ID: <32fdbc0a-ba70-4d99-93c8-15ec8ebe6f70@suse.com>
Date: Tue, 3 Dec 2024 12:54:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/18] gendwarfksyms: Add symtypes output
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
References: <20241121204220.2378181-20-samitolvanen@google.com>
 <20241121204220.2378181-31-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20241121204220.2378181-31-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 21:42, Sami Tolvanen wrote:
> Add support for producing genksyms-style symtypes files. Process
> die_map to find the longest expansions for each type, and use symtypes
> references in type definitions. The basic file format is similar to
> genksyms, with two notable exceptions:
> 
>   1. Type names with spaces (common with Rust) in references are
>      wrapped in single quotes. E.g.:
> 
>      s#'core::result::Result<u8, core::num::error::ParseIntError>'
> 
>   2. The actual type definition is the simple parsed DWARF format we
>      output with --dump-dies, not the preprocessed C-style format
>      genksyms produces.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

