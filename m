Return-Path: <linux-kernel+bounces-266538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE7940155
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB2A1F231A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835B818EFDF;
	Mon, 29 Jul 2024 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgc8Vi6Y"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2416F278
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292984; cv=none; b=h4kHy9RLN7AsNgKtjT4mgJajbxmxvCjGQyJUpGPBHN3eh8a3WKceoF02OQCIyN1a+YYOTIuJgkb0Spz50XFYmGoQFxvWqL4c+Z7XXFuTqHLvw9BbkF+EYibep4efKFnzqDYP9jYpLWdDyLPSuhGWed5AXehd1cU/O9S2ykI1l/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292984; c=relaxed/simple;
	bh=Aj2AIVesAG+d2/9e7x2hRMbNkueEHWxEaKjXXzGcwbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8d6cIpr8KH94rTZmkP30BdqlnW+gRthXrvZN4PkcU/322GSsTorA8ZUleX5I6rhQfSnJh4Y+07BFKPeaySUgSj6g/I6sVpzXNUuzAPf20ROfAYSsw8OPUO1JwyG4ybXu3l01JE934248B6CiKEQFfv5Gc2X2PgPSCCachezSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgc8Vi6Y; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so6733014a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722292982; x=1722897782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fGU2swIqhkzmFxwf58v8I5LDvCPe9Gak0+C/hrp2AA=;
        b=fgc8Vi6YwAmnWx+ZmkYXtpMH6UmXK6SfTGr791aNpRs+GSllO9w8yWE+e+3rdig4cw
         E8dDz5k6Bijecr7aGyCroUYZGtrqRCFWjH/MhQ7B0cBBbvz5S4dm2vikp13eZkMxDlFY
         MUNhO4ooHD9tECEIha5zrD0ein27EzersSvoxTCTC72s6p8IDYGpDE5fGteaE56v4O/z
         9Jt0cgaBYgvHE4R4Kh6id57I6Mr6Lzx4ER5ga18LK0Q8fegarHAPRjcWF/6pzHapCJMv
         hyeJG3db4ZdM+dd4D3wHiVeVKxyq5BK7j8/B6QkW7/A13gE/6mZW4IqmlKsJELM/xqbV
         ys+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722292982; x=1722897782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fGU2swIqhkzmFxwf58v8I5LDvCPe9Gak0+C/hrp2AA=;
        b=GA58g4X+3jH6a+5L5FOUb58czc9x2H0/zb3gPjaoy+kcIes2h2dd3EgtAC4G+UDYTJ
         jZa1pwu9ufA++Q8vTxlUxh6UFxtiltt4cGgpKPe1CFFEdpMMXq53OvH40JD9VdqO1ICr
         Rx6al8VoF0F2/PBFKdiJm/YX4JB/wl73rdkwbgbLukh3sScOg36aTG3H/Iju6x2jK4Xj
         HzfB6UFjkSf7YwgkwK9sgcryZeBZ4UmZpzqkp2GpnsCfyfkgHz2k/TTvsXIGVDyWpf0u
         brCzQXGM606CoYj08n/pmvcKufniKi178tttN8m58vgzB1HqSObj9RgXSSPCKFhllrnQ
         3m2w==
X-Forwarded-Encrypted: i=1; AJvYcCUnSsvUj+4qVCmtUTkAwm3fR2YRLEiU5iOyCpfVOgdr1rUgltGmUXlTz5Im9GSAad+EzXsTysnbMtC2E4tdF9MzO8liTiJAAM88l66Q
X-Gm-Message-State: AOJu0YxkJeias0RctAsl9tLwVtA72jLFVn1jdEtG4zrOd/zB6KbAYyi9
	pI6gszvoe0XvHkbQ6eL7eBHOgxJj3MhLQtPFBiakv2zx6+s9cYx1
X-Google-Smtp-Source: AGHT+IGLX2TWK5psswgDXB60T97s/05VR8H5qJKBNon3tRM4nB6q0AYBnPBjzubWjdyyucSDgkJYhw==
X-Received: by 2002:a05:6402:5207:b0:5a3:64dc:33a5 with SMTP id 4fb4d7f45d1cf-5b020ba5706mr6479546a12.17.1722292981301;
        Mon, 29 Jul 2024 15:43:01 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b0395sm6384148a12.20.2024.07.29.15.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 15:43:00 -0700 (PDT)
Message-ID: <65faaf53-ad53-4b1c-9ccf-2ed9886d4f7a@gmail.com>
Date: Tue, 30 Jul 2024 00:42:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clang-format: Update with v6.11-rc1's `for_each` macro
 list
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240729-clang-format-for-each-macro-update-v1-1-9c554ecfec3e@gmail.com>
 <CANiq72kFpS5BE7Ea8=Z6SUi_Y2RAt5wsssHyqL3ocgR1UOHJMg@mail.gmail.com>
 <17e81b06-7778-44f4-94cd-6a2b1fe5c7e0@gmail.com>
 <CANiq72mByZfV62bXkd366GNX1ReF92=rUf9Dyh165Ce+Wc3F2Q@mail.gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <CANiq72mByZfV62bXkd366GNX1ReF92=rUf9Dyh165Ce+Wc3F2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/07/2024 23:55, Miguel Ojeda wrote:
> On Mon, Jul 29, 2024 at 11:39 PM Javier Carrasco
> <javier.carrasco.cruz@gmail.com> wrote:
>>
>> A quick test threw 326 extra macros that are defined in internal headers
>> under drivers/ and arch/. Including internal headers would remove the
>> need to update the list if a macro is moved from inlcude/ to an internal
>> header, but the list will need to be updated much more often.
> 
> There would be more changes in each iteration (which is why we avoided
> scanning everything in the beginning), but currently it is
> best-effort. If nowadays there are subsystems that want to start
> considering soft-enforcing `clang-format` and that is why they need
> them updated as soon as possible, then we should discuss other
> alternatives (please let me know if that is the case!).
> 
> For instance, we could try to somehow divide the list into individual
> subsystems, so that they control it and can perform the updates at the
> same time in their commits as needed.
> 
> Anyway, for the time being, we should avoid editing the list "manually".
> 
> Cheers,
> Miguel

That is not my particular case, I just wanted to add some macros that
reside under include/ (in particular, the _scoped macros).

Given that no one came with a need for macros defined in internal
headers, I will just drop `displayid_iter_for_each` for v2.

Best regards,
Javier Carrasco

