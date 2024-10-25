Return-Path: <linux-kernel+bounces-382445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D5F9B0DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C306D1F24C23
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14AE1FB8AE;
	Fri, 25 Oct 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="I6joGSvX"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475ECB658
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882841; cv=none; b=AwiEz4yZzDAD7R2M0BVey/7TAcNKW9By2s6f/S0vP7DRAwid6gi8zpzqs/9ROKHPAOBn59hHmDZKYM6mTGYkff+ed/iZFFYO795pTgzeS4z8dKDziH5OxQhGBMJMa2MtbExBPAYJytR+yk9ymmrRS/RF5UtlyIvhZx3US9tlqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882841; c=relaxed/simple;
	bh=3cXnhH971xc+BJd3tbXTf1w1qTwHmDe/QquknJ+Ddps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0Q13k9tV/oZW714SCOwgb4U6n7erbxtVRYTsCqgi8ErSsCopQwfPfjFOuQpzVf3hGHSPi1onnGu72an+ltvpIZMRJTCO7mz3YfvYNjST7Rbx5yzXjhA/vuH/caJvRP9ITPHiRHPb/z3i2CJIiEOVCWluZ2V5wUNC65NDCB5FHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=I6joGSvX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso325059866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1729882819; x=1730487619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rkrlJI83WTD1bbkwbEC93+bvij0O1qrWlleVslcI4+I=;
        b=I6joGSvXWsUZHbgh2jspZ2eqek3oebRnlZHfgsICaVK6eljvFAkAEqyWRRD35Ocp5r
         yXTXHthyPbjCPxP+3iPAz0S4Se6sr+qeComA8fxWhbXSvtXwZ+jSyYr3sQxxWRcmIzXB
         2KsP5jV1JtwUwwr6ef6YIwic0VDfqQxE7gE0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729882819; x=1730487619;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkrlJI83WTD1bbkwbEC93+bvij0O1qrWlleVslcI4+I=;
        b=MWjv5dlLx+aebUy2rpHjm6Iue4ONRszcsZrlwarfOJRStiBOhy8QgS4gmO1M2qdA3i
         kQ/vCPKsGwq9mqHjQlx9cIwzz7wR1kIXBXA8DwrzMomejkByr7NfcZMF/yafQ9KYr0l6
         7/netNPNSyP9/edTmQ0F9WlV59RRjjSGk4SI/Lvp/GXRAEO+2RtKmBKt9ItqfsFn8WR6
         QvbUtwjDnr7fQDxoA5qdj4T2+McFGroQ4SaMDrOjk1b3v9bKcaBRDsBCO7YeF4qYW+Gx
         asCL8HM4zoexRii7UxEd4kYHQ/xh1NG4Ws+TGQVZye3WtczunoZZcgeaDZFmk79WKL2/
         KPZA==
X-Forwarded-Encrypted: i=1; AJvYcCVykF32umjo96S6fhnC4iVjRevXWdXUwb9LE11VmwxcfDxhZmSPpaM8bAPQXhtUvZVLNfSSSXYjNE8VMxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUZzNDSjt91+WUtZXW3OW1vSW7BUTZcqW0ffwdA777xfOjQPH
	tzxshLmFUtzeP8L8zt2SaQB45Bw4Waiw3qWjf+sUIH/9dkftfQs13U/5Ip4r8+s=
X-Google-Smtp-Source: AGHT+IEBdcMs9eBgtwFOorjOm0UQsaYtZXPWKo4MYyJ5HOwSQ99+9s13KA6niizAWAbADYKWqTj95A==
X-Received: by 2002:a17:906:c105:b0:a9a:684e:9a64 with SMTP id a640c23a62f3a-a9de619b1damr12450366b.61.1729882819589;
        Fri, 25 Oct 2024 12:00:19 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec802csm100247366b.13.2024.10.25.12.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 12:00:19 -0700 (PDT)
Message-ID: <fda92169-224d-45e5-8645-7f4b12fc5ba4@citrix.com>
Date: Fri, 25 Oct 2024 20:00:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: fix user address masking non-canonical speculation
 issue
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Borislav Petkov <bp@alien8.de>
References: <20241024013214.129639-1-torvalds@linux-foundation.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241024013214.129639-1-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/10/2024 2:31 am, Linus Torvalds wrote:
> It turns out that AMD has a "Meltdown Lite(tm)" issue with non-canonical
> accesses in kernel space.  And so using just the high bit to decide
> whether an access is in user space or kernel space ends up with the good
> old "leak speculative data" if you have the right gadget using the
> result:
>
>   CVE-2020-12965 “Transient Execution of Non-Canonical Accesses“
>
> Now, the kernel surrounds the access with a STAC/CLAC pair, and those
> instructions end up serializing execution on older Zen architectures,
> which closes the speculation window.
>
> But that was true only up until Zen 5, which renames the AC bit [1].
> That improves performance of STAC/CLAC a lot, but also means that the
> speculation window is now open.
>
> Note that this affects not just the new address masking, but also the
> regular valid_user_address() check used by access_ok(), and the asm
> version of the sign bit check in the get_user() helpers.
>
> It does not affect put_user() or clear_user() variants, since there's no
> speculative result to be used in a gadget for those operations.
>
> Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Link: https://lore.kernel.org/all/80d94591-1297-4afb-b510-c665efd37f10@citrix.com/
> Link: https://lore.kernel.org/all/20241023094448.GAZxjFkEOOF_DM83TQ@fat_crate.local/ [1]
> Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-1010.html
> Link: https://arxiv.org/pdf/2108.10771
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Fixes: 2865baf54077 ("x86: support user address masking instead of non-speculative conditional")
> Fixes: 6014bc27561f ("x86-64: make access_ok() independent of LAM")
> Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and put_user()")
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Thankyou.  This looks a whole lot safer than the prior options.

Tentatively Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>, but
it's probably worth trying to get AMD to rubber stamp it too.



