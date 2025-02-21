Return-Path: <linux-kernel+bounces-526340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F394FA3FD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAD718931F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D542500CC;
	Fri, 21 Feb 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEwIncFf"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E724E4CF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158730; cv=none; b=MVZ8owm5v/CXOZmw28tfgYrCW8Bk2ugf8/mYe49+T+Gg3snTC6l9np8kSn4kpBE0X+UWzBCWuyl/1dar2k2Nhd3eN2T826rofcl8iBAZh2cdIvhZxhl1mAPeK3U/Xcaf3FscZqLF+UQgmYdgrMwRWATlulKSHisolRhoY1/rk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158730; c=relaxed/simple;
	bh=ntUXBo2b3H0paCbSKwPknuJWM8aaKRhVFmcNUSVObYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNm17tXHchyOh9j6wWgxgZHXMEcJC54m9nyuDfI7PG5dP8ANwSdpCPp45os5gJkzNa+0QiBNU7EZUc3kDC7ozHGL2geimWbSc8RKXjZcd/uNEyYzkUuEDWB4C5XBudvZb5/v9rea2SJiDX2GMdAiSDe2qx3sIb6w1wfJROZEvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEwIncFf; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-472098e6e75so335891cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740158728; x=1740763528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FsVp5f9QmMJgL4jmaqMNGzqbAZ3+5cticPKqK4ryEMQ=;
        b=HEwIncFfvvViWx/CytN1LWJq+Bxjizi960b/I2oFLl5ohtR+h+o2YP7uAx56IcO4mP
         7IS+rLxR5ccp6hd38JfCH7fkMT/YNRPsEWRx3InXlmtADgFsIB1RyVBvnWq3950UOOuc
         fvNTDDb3dS8rzAFoAhuR9ZpZS2CcJVQROEJvjEs7HpQaWzLoj8f29HcooekzWxWouKmT
         xncH4PPJnkZ8Mn7CHVuL8B0NFqq9riraHxoLG0TGhIxwag1hKOItPWYdlkeuKX1qJBCF
         9rgyx1Jlprs4LeFys2jt1Bs5BJ1U926EWq7K/JTawzdxpNotcUSVJT8/LFBbNfeHYZCa
         4KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158728; x=1740763528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsVp5f9QmMJgL4jmaqMNGzqbAZ3+5cticPKqK4ryEMQ=;
        b=pWCzmChrkVcpFe+zRsrF2anOQA06LaaplUSCCMnwqgrxrJbZAM7aw/zHu9RSeqENUG
         K4LFAxplP89iAj/RN5hnxeXLPeQOCyJW6YZab+Nvvq9gufoxdz/0kunMkxFdpTYEUKau
         RxAKLFoZGJPMewga5fOI823U70sUUxtmrRRASibnV3Ynlyl+qR7lc3bgw5rdQ1bxvcKS
         sND2Xf7ZzSP06v9mInv+aP4Jj2oWyG0vfThnKe/xEu+hzF5m8aR6FvtInyzzz7nODQ+6
         a1kyYondP3gZZNilfmaTnTkZSaXH3jchkEmtUr4wx4NaAYDleKkYGkISeLoQI7LFBU3T
         CmVg==
X-Forwarded-Encrypted: i=1; AJvYcCXOuwudKu/uwgrcF1xFuncldcRZQlcyblJEQYqyh4BtgpBc3aJwaQuy661LnhiRamqon4KRtOKiLnI3syI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTl52TZcmgENKLqJPWN70QNPf0+3wJ0GYmLfh2c69cNl5pwWZA
	qHvR2aInHBDi1xW4ka0PIuir9stb5PMjDNU/XtPlh0sknX7SyuTL7lQzyW+l+hvgQDgPiN+8AMa
	WPw3DJd5kUVtCHKGZDB0xa74QkV1z+j+N2XNk
X-Gm-Gg: ASbGncvi/9wjPwIYKc54eyswZ7XFQMprI2ErOyiEhDE1ZkI/h05o+FnMq6Ujl4aAtmw
	htvpcaUx63LuFRJB3NZqjJqGibGKbmILenWLYKezUTM7ove52imB0D6qBUH8+K5nZ2kFlbfR/tW
	Mqs2Z8fpIQIdiHB7Br83UbpFi9FaBXtL0Hoqfhsw==
X-Google-Smtp-Source: AGHT+IE2qeflKK1byqANPdOKXQ1RSe6wIkCdfZGB0CJf4rEU5YiO5tu3Xv/YSA7beG14Zmm+g0o3Q5I9nTDuvPzCikw=
X-Received: by 2002:a05:622a:1b05:b0:466:8c7c:3663 with SMTP id
 d75a77b69052e-47225044a12mr3732951cf.5.1740158727844; Fri, 21 Feb 2025
 09:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-clarify-steal-v1-1-79dc5adf1b79@google.com>
 <20250214212647.GB233399@cmpxchg.org> <CA+i-1C3e_JUBBhMDYwrehvLZzLtb9pfgEy8=wQa=9uTBr1-b5g@mail.gmail.com>
 <764394d9-592c-4d68-8910-67362dd8810a@suse.cz> <20250218203830.GA1264207@cmpxchg.org>
In-Reply-To: <20250218203830.GA1264207@cmpxchg.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 21 Feb 2025 18:24:45 +0100
X-Gm-Features: AWEUYZmxRJng6dHgj-kLMXDQ1ghZUjfHWOkUm0eaqSXZt5jGmzay5c_NqxDW3NM
Message-ID: <CA+i-1C1m-p0GkYE8QTd39qEG3Pb_QMsEs=dLH1_87giDVhVH2A@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: Clarify some migratetype fallback code
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 21:38, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> @@ -1930,7 +1929,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
/*
 * This can happen due to races and we want to prevent broken
 * highatomic accounting.
 */
>         if (is_migrate_highatomic(block_type))
> -               goto single_page;
> +               return NULL;

Side question: when does this happen? Might have a spooky gap in my
understanding here as I thought the only reason the pageblock typed
was changed without the zone lock held was during memory hotplug.

