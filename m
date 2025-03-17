Return-Path: <linux-kernel+bounces-563614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEE9A64557
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A6C18851F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76021D3F6;
	Mon, 17 Mar 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAx2EU8U"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7D21CA1F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200008; cv=none; b=hgIhpwUYXNSNZMqGDsjeJMnT6k3naDAFPoHPl+hBGCd+v3vJadrg6wT9e7qo2U209s4/7leF6pXMlU5RxePeq7qSeo5qJ3eAYOdsfZVf/Z+6D4QYOdeUJh4eVmwaF76YCugz9j6tewOYgKwn9AJHOWO1lzGSgr9dNX5R1st7g5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200008; c=relaxed/simple;
	bh=YOzWSJaHmBWKqUmdv6Hq9enHhL4KVF8pWWISNRi2zVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bn07dlNamYX+TUtz3Qs1aasGAGyi4Ept/7Yr6P8hY46dDpWbfEoKVE3puUEUynOQexTrYBP/0oaeyPXNVBm8eB+RKq1SYsaaV38arTszbe3S7NIFr0U/p2XP575G2mjEkQalQjxcceFKauSv1B+gBuHNrTOYRnVUbika7w/qHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAx2EU8U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfe808908so68545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742200002; x=1742804802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZAFE1/JttZFaxLhWRXfULWMZ1wsK+JB3VhnHWuwmO0=;
        b=CAx2EU8UW0Ezujmg/l97lYABMIAns3h4D1kS7ybNgf5pFda916eZfK9yPSi6+bV2Y6
         EhpXC5hZPLJnVtQZb5gOUIB27ayhpbd4zpZ7/xZz+cs6lB6rwv/HgNv08FSqXMBHmu3C
         oFeZHJE/isoOaL4hC/iznlZ/j9m32SrE5BxOXvSjbk/fdv3O9+BDVMVPNpxAiPp0cug9
         mBiRQwbBscGfpKOzfQmV15VH1Y4ymGbHcOAU15ymwcNsS1lSOPwqgXr1xKqTCRypVCfb
         WgZ39PVQu594EcDyJPl5W1ka55Q2bpIs2woIbTRjTCuBzj8hQvlw1CiVwAxB+5tREKiY
         EdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742200002; x=1742804802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZAFE1/JttZFaxLhWRXfULWMZ1wsK+JB3VhnHWuwmO0=;
        b=ZtsYzI7LcQxvod3QG6vXejivrtExvh4BzBL4TPjmczwbw+5fvFxAZPl+R1q2cfR38M
         FYHucTKhh3OtjCEnR7XViK0p6M9xe1wnAQYlnhqoDNTdgy4v2KfBQJmX80Xt0P2jvqRU
         6UuZGnSvTJKEgM67MJzteXhMF7tL9WzVMHgY088P2+ZOCAFkHcMrD1i6Zk7DKgH2B0vH
         eb06ZpNhrTmHXMpmOB6Kh1ewBR5lDVAJalCT7xv5oSCZHgzuISSgdIFOyvDTBgxy2Qtb
         YYBBxgVtGNLbyxoOM9bGMtSDrGHW2OpY3zF0oFG/mx9ke8p0cpFp0E4kh78BZ8J6lu1O
         /E5g==
X-Forwarded-Encrypted: i=1; AJvYcCW1kxSBLsAbR7AySh5iJcPyyqWemUcBexEckYbgpZ3XWJ1GRCFHLAvB/Zn93mwdEw1cMp89DZEYLsU6F9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBoPLuJWxeyw9jWTLCGxggjBm/YDfe86TboGj4P+JwNKPg7vI
	8plmx0Qi/4H8aekIixmpkWoLFVl/ZLTJIeV3oxaEoaBA9Q0PzZm/Ay7LGQy12A==
X-Gm-Gg: ASbGnctoodtCmD7ndMhc9S8rNK0i4rIso/JzfyhjuH9vOeO7wHpL91sXydMYhelXhPd
	FshktW6LXGL69ME99gpijINgOzFBzxe8weY8l41wipb69b8p4aq8bsrJc/wB8j2LRfbqyiyZ1i8
	lpGmr8rIhfEKOO/cLXsS6j5ldtEOMU4767vT3D34i+mb+5UnFn0ZKO23aoMz+V2D28QO1TgwWP7
	HsKCOTA3gfG8hsUOxP0zhv+xL+Wl6H77Qlg/pWG9x4gfPtF+YDBEXwRu7kny7SSKaPi8DYdNK2d
	KceBzo1eMI8X8yKpR0RL+mOC6gAknMf4Qld96OQjeni0MjjQjP2mhJSAmSVT0NR+SJMeS9BROI5
	0zQJnN0k7AEhXvnLwBQ==
X-Google-Smtp-Source: AGHT+IFJ44cqiUJ+hGXupf0z7NfS3TBrnLzb6Nat1Z7qWDozDLeiN1knysEcD2iKrl+WLgb7iKp1qg==
X-Received: by 2002:a05:600d:14:b0:43b:df25:8c4 with SMTP id 5b1f17b1804b1-43d251f360emr2364435e9.4.1742200001953;
        Mon, 17 Mar 2025 01:26:41 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b69eesm14374809f8f.34.2025.03.17.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 01:26:41 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:26:37 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 01/13] x86/traps: Make exc_double_fault() consistently
 noreturn
Message-ID: <Z9fcvcjhxPxTSZ23@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <d1f4026f8dc35d0de6cc61f2684e0cb6484009d1.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f4026f8dc35d0de6cc61f2684e0cb6484009d1.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:28:59PM -0700, Josh Poimboeuf wrote:
> The CONFIG_X86_ESPFIX64 version of exc_double_fault() can return to its
> caller, but the !CONFIG_X86_ESPFIX64 version never does.  In the latter
> case the compiler and/or objtool may consider it to be implicitly
> noreturn.
> 
> However, due to the currently inflexible way objtool detects noreturns,
> a function's noreturn status needs to be consistent across configs.
> 
> The current workaround for this issue is to suppress unreachable
> warnings for exc_double_fault()'s callers.  Unfortunately that can
> result in ORC coverage gaps and potentially worse issues like inert
> static calls and silently disabled CPU mitigations.
> 
> Instead, prevent exc_double_fault() from ever being implicitly marked
> noreturn by forcing a return behind a never-taken conditional.
> 
> Until a more integrated noreturn detection method exists, this is likely
> the least objectionable workaround.

Yeah it's pretty nasty, but I don't have a better idea. And we do
really want objtool to work on this code. (I am taking your word for
it on the objtool side issues, I have not researched that).

Reviewed-by: Brendan Jackman <jackmanb@google.com>

