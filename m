Return-Path: <linux-kernel+bounces-175337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EE48C1E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27331C21FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA772940D;
	Fri, 10 May 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LC12agVH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B290B1DFEA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322958; cv=none; b=aaQ0cYxV1j1XpNu+fkOx5vJOID/yqpqATCymadpIDMZP5rBflBMoQS23R7xrzuxtCG7xCI+MHxnE3a6A7JQUP281q8EFzEP7FpFmyuWeV0fK1Opwadh/ToU+Nj+4Lj7uFEyqZEpQk9liKiuQrodYFuha7i2YsKPnI9iiz9ICHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322958; c=relaxed/simple;
	bh=h/dEw/G6rCTzqqNAx1Si7JgrM/cVez80bHxIpJ6/fHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aa25eb8FpMaBkfBalyGuSo802mQm3/tkVk80Tqk7wbZ/2pVXwvA6X+XjO/gfWfO3FXxfs8DPTO0oG3h1qP9o221gYY3kgWBr4m6qshwC+cIr184RT3kh95TpmdWXOhTyRbSJv93vDqjCkW+j6lcqbWxXOTYxuszCuENhdCJGVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LC12agVH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cf8140d0so395417166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 23:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715322954; x=1715927754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxCNtcupovxNdLpa4liNmJ+Aj9ToML7xaMOdcpDzR+Y=;
        b=LC12agVH1seiubp8yrlAJ82NAF1caecYqMBYLDebdpGoriZXCBksDZ3VaUo4BvF4l7
         Od4OZ4DQEi+f7RXUHInCXnSa+78dbrmr3J5ZvQIUuNP06GZaR17rsjbrNlgGJuT27bHY
         NKowY+3GYmjK3OfT1x1G0EIyNYAKOhvkMMgI0WHyfxQQJgIHRzJzublBcqXnPVYdXXIt
         OSZ7JY4Lvqfv0ydlFgb3FLOvRItPfzoBNC1P1cLNcAsQz4VE7ILHkoI+j+TcRDEAZey3
         5HBKUuMpvrbkcCA02ASpcv/R7gbJOP4jPFMYFD9zHlbz7tf0fdBzhqj10QvcuFEQGHn0
         iq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715322954; x=1715927754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxCNtcupovxNdLpa4liNmJ+Aj9ToML7xaMOdcpDzR+Y=;
        b=B+CrPkNFEkCdgtn3FnBs6FRqoDzIrCoIpSnE5Y85Z1/tiPuXtFgtnL+ioXh5IjBdTy
         gye16iG6Emsg4b9RdrPE8a9qpvHYcHaHh+PONfC/nsTS/q2L1/4FdNpcafLlL/KxXlHI
         ILHmRtHHtokiQosax4vfQkxLaCu9ShLsENZOXgF9riNelB/wlYhsWOVcdb65PwXOX1ZU
         odHNYQY26RBfwUytQYLyMVF+O4NLrYYMSIl9mUle3D2QvNcWkEe0dqvJYO5czNxYahm0
         tCM/vnsG0WuwU0MZY0Hq23Ds3TzPpqqAHlBMfTBvtkLnlLS3zbP6DXqYeXZQXgSVd27R
         lj3g==
X-Forwarded-Encrypted: i=1; AJvYcCWvmsJCa4X/YCtYpMuKw5cjPCKdXBeFICjU1XOcAffWHwayZ001AkCW5rGCJLLjbc47sCMV29DwUpYQMq6wpU6mTOm9QyCd0dr1lT7w
X-Gm-Message-State: AOJu0YxOeeFcOKmcgiyQVC3T/qekSVBVEvMpbPN8ezFFt20f4ck34bHf
	7k10Y2MoxRaVi5jstkr8DD2ULRWdIdd+lGsajZH7JjdAiNtxattdGzGgMiORuGw=
X-Google-Smtp-Source: AGHT+IEsYqtRcknYkEI9dadmuP1mmqjZ/X8PJ/ypoow+HFuD3UV69F9PwuJeDUZtGN2n3mzgj3MI8A==
X-Received: by 2002:a17:906:e297:b0:a59:afdd:590d with SMTP id a640c23a62f3a-a5a2d66a335mr85754966b.51.1715322953917;
        Thu, 09 May 2024 23:35:53 -0700 (PDT)
Received: from ?IPV6:2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c? (p200300e5873ca5006aafb7a77c29ae5c.dip0.t-ipconnect.de. [2003:e5:873c:a500:6aaf:b7a7:7c29:ae5c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17fb4sm150003366b.222.2024.05.09.23.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 23:35:53 -0700 (PDT)
Message-ID: <7bc9a67e-a73a-4c12-9e35-01cb8db27fe1@suse.com>
Date: Fri, 10 May 2024 08:35:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/x86: add extra pages to unpopulated-alloc if
 available
To: Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20240429155053.72509-1-roger.pau@citrix.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240429155053.72509-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.04.24 17:50, Roger Pau Monne wrote:
> Commit 262fc47ac174 ('xen/balloon: don't use PV mode extra memory for zone
> device allocations') removed the addition of the extra memory ranges to the
> unpopulated range allocator, using those only for the balloon driver.
> 
> This forces the unpopulated allocator to attach hotplug ranges even when spare
> memory (as part of the extra memory ranges) is available.  Furthermore, on PVH
> domains it defeats the purpose of commit 38620fc4e893 ('x86/xen: attempt to
> inflate the memory balloon on PVH'), as extra memory ranges would only be
> used to map foreign memory if the kernel is built without XEN_UNPOPULATED_ALLOC
> support.
> 
> Fix this by adding a helpers that adds the extra memory ranges to the list of
> unpopulated pages, and zeroes the ranges so they are not also consumed by the
> balloon driver.
> 
> This should have been part of 38620fc4e893, hence the fixes tag.
> 
> Note the current logic relies on unpopulated_init() (and hence
> arch_xen_unpopulated_init()) always being called ahead of balloon_init(), so
> that the extra memory regions are consumed by arch_xen_unpopulated_init().
> 
> Fixes: 38620fc4e893 ('x86/xen: attempt to inflate the memory balloon on PVH')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen


