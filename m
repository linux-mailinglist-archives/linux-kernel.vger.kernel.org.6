Return-Path: <linux-kernel+bounces-572528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 750DCA6CB1F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A083B03BD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FBE22FF32;
	Sat, 22 Mar 2025 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0G362cx+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551222DFBB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742655972; cv=none; b=aQ17MeJ9HN9A12aGjiVhKFfU7RdmnTKAqd6r1Uc3bxjv+BF8F+didmaC/f9+A/448FdYVrxrR8lZbVb1rjPEpAVoc/YNDbzXXe+1juT9Cp3SWnr73S2lxe/3PvsPF814faQ6okvzdw/8k03disapeusME2kY1FGzC2uuXRolv0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742655972; c=relaxed/simple;
	bh=UxAAKsTXSxEcucr2XMnx+8tgzADRK3EMQCS59gspQgw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sjQh7WX+AyYCnaPo33zCQ8lXjPUzj5pxWwsUXwQu8+U5BlyLkycp4iVQva06IfKTa/AKxAvkoLUPi3gE1k1oje6qDaZwzubDAQ6vs4mXHiZ+cH1/W15SsfKwkQIHIbQdAXi3I1hXA05zc+peRV0m+nc/WDpwdPvhZtPoznmzMas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0G362cx+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so24493665e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742655969; x=1743260769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmdhaeiU8DO1XvtGX03FzurHPZXlou0bXSnHIt4W5tk=;
        b=0G362cx+iZdd6FzQ9U7ODQUl8lVbVMVce7v+ZsJDisuWx56EkLMLaehQyg7+Fh2PJS
         i+2g1m917Vus0AvOrafyJAyvv3BoRQjNrSoKduVgg8j5n4L0SkVBU9968A12FI137HDa
         z4bHcmsmT60XzRYljI4tcb9eyH5Fws/xjlnZ2Rq9WwI4RGuGJbGdiJv90g1bKZBFwlq3
         ntAVZ5OhjxSk0zg8Nuowu8ZacjSsuZMSjDwXudTRPBgtJoyrPK9mhlIf+2V8seA4d3dk
         DCcHNCX22upxGguwilzZN7MiHxgKQ09r/sketnsEJ4zPB6alF0xkD0HrzBhvDTkBMBK/
         q0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742655969; x=1743260769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmdhaeiU8DO1XvtGX03FzurHPZXlou0bXSnHIt4W5tk=;
        b=iBJ9wX0h+/dzOQLgRxsRFIERNIl9wyhJMM7joc0o1t2iNaRbRsV6RWfDe97EMHk+NM
         pCSyWsEIFGrjTKguo+b2VieKAWpdIepItA4b+/I+VbjTze3QmlNt86kEe3ZRHVZziV5Y
         O3orO3j/bdOSpq6lHuPaQnfAyGFIigPEcJrAEoACpH1Wm21fN8T793a83WxaQ2IRtu+g
         gO5RTZV+M95qCH9pCffZSvnxrkusyIwFv/N1K22iDkicgEF2XtMZTjQsdd7QbkqS6HQ+
         UUsAVjmDdyojAzotxidSohy+8iAeyQrNm38ZdmtV5Io4FeLT9zbQUExc2vaBbsX75byx
         bkow==
X-Forwarded-Encrypted: i=1; AJvYcCWshzc7LtgYMD9BYLLiFy8lqm0y6Tlo4fj7JMMVaYgdQiskSI8k7okioU8GVXZDTnO+HYY6V0MB4QV6yuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xTjnBPYao+rmmwcngBuqn3fH5ljoJuREPaGyIB3vvsdMb7yl
	7+wkntUSQTuQGXqKAh6vcqIu5jVtkECuqr32JeeFg94O7sSjDmpHqY5Uu2+XSXouHWiWf2RPxE9
	gW4Aw90Tifw==
X-Google-Smtp-Source: AGHT+IGYGAFhtCNj0YU2wWFdCY843FZd72YTV1czqL1fRfxBOIHzg+7aZyjjifKcFVoLbmpP+n7L81gyeqEt9g==
X-Received: from wmgg15.prod.google.com ([2002:a05:600d:f:b0:43b:c450:ea70])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1fa4:b0:391:952:c758 with SMTP id ffacd0b85a97d-3997f8f78a9mr5879907f8f.6.1742655968953;
 Sat, 22 Mar 2025 08:06:08 -0700 (PDT)
Date: Sat, 22 Mar 2025 16:05:52 +0100
In-Reply-To: <20250313210647.1314586-4-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313210647.1314586-1-hannes@cmpxchg.org> <20250313210647.1314586-4-hannes@cmpxchg.org>
X-Mailer: aerc 0.18.2
Message-ID: <D8MVZ8L12HJN.1LN4G4H0ESLY6@google.com>
Subject: Re: [PATCH 3/5] mm: page_alloc: defrag_mode
From: Brendan Jackman <jackmanb@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu Mar 13, 2025 at 10:05 PM CET, Johannes Weiner wrote:
> +	/* Reclaim/compaction failed to prevent the fallback */
> +	if (defrag_mode) {
> +		alloc_flags &= ALLOC_NOFRAGMENT;
> +		goto retry;
> +	}

I can't see where ALLOC_NOFRAGMENT gets cleared, is it supposed to be
here (i.e. should this be ~ALLOC_NOFRAGMENT)?

