Return-Path: <linux-kernel+bounces-278779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6589994B4BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3AEAB21CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F8BB672;
	Thu,  8 Aug 2024 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2O1ZF6Q"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FB65228
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723081386; cv=none; b=oS4HFZ6mQkDhbQHMe6675tfF8h0Gjechs3PfNMocEvef0HUPpux0gsFVC0jiTyTSYknGJrEzi09p11R6N1kY8AfgKQi+zGw9sSkBxn+fn8TQ018wkm0+Q1dLPIT75z2dHFOF55oxGcSS5aApEynrpzy0YN9jhjFRv1WnW43cSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723081386; c=relaxed/simple;
	bh=ajeMim90UvalacYDca1a9fc0jeI9eLG6wQ634RMEP5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=nNVWeKmbGmotCrNoo6Z68Gvd8HLJyCdKXk31XLBdVZbdWRwVJ71jsVZbZsSGj6Czy/o9Bwr+VySDJswW+4fWdOkIuAT/9xI21CvZe6sGnfBL45athpscAgLGbJX0hFYl/kW3PhQorhNsEJYghzR2RbKtQP6xGEvajYJoIlc+EhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2O1ZF6Q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d316f0060so1061908b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 18:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723081384; x=1723686184; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sgrFpyqpMIIoSCjw4gHzwzuWC7LSft9+V2d21z+sLXw=;
        b=E2O1ZF6QCdu6t2aTSKiwfCxUXsmsPF6ydqk7e4MmRCF9098cqZJTZdfdX1wCUHj4dY
         Yw4vp6QwAPY/zr7iUZHf/2L9T46LbvDGnHv46EunzXrFkWZ9bEIxzx+7Fi9nqPIQXnQY
         Y/4sd+nH/UJrg9ZjaoaL4wEUtl1WUDj+sTgJcwVfi8ZEotoa59vaqJY0d9XxnmJch+58
         VTAxVhX4vGYv0UyGq+5uItjK7cAY5J5v4c/XzuVxTzP5Jp5/XCW3hvQkDKMWolwUwsb1
         tfylSreDmVwjR6TDhvdiQPB5Vt3NXTpePcnbXxr+FwF5FWcxxToHcFyofjvKREx6R/DJ
         znUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723081384; x=1723686184;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgrFpyqpMIIoSCjw4gHzwzuWC7LSft9+V2d21z+sLXw=;
        b=hkZ4UJT0C7395NLe+0bZacM4O3Td1EL9jACH0SQDqMDOtkQMRKbhCdAcBcxaEFgR7d
         sl6AIACZFlZk733wTxfFmgeT2MPTbYH0cacLT+6YnoH1Yvs+HSzVEC5/BrbmyOv7qgVV
         gfePfdsvjiglsTkxLxltl4/7E214JqD0QFXs19+VcNqoVX6e1Tn45eXQSkX0uo5Aa4em
         /w9RWxI3EWb/te8v1iEHcUuPqCofjJddGGIM6x31jTaGBvyHCps+0IZjF+vQwIa0Ryvi
         myLJ5o48xkh6iUeuF+5jhmOhawkzBlnhXGsBwp0d4O5bIbsaoMqhkWgc1g2riH3RJ+Xq
         vt6g==
X-Forwarded-Encrypted: i=1; AJvYcCUmp1sdDcsY9ImNJUEfWlcfHBH1TSYRmiimlHYlyK7oRuVfjF2mOGgxge+4pJSRvVwVb61yKXj9T33FZCzFVW5jCvzDtQSYSGJ3XVvn
X-Gm-Message-State: AOJu0YxbCZ1ygq0wt+vDmlxAzp4FxCdx6me+IQMWQpI7QJnoy8NLYOz+
	6fVwtqY026ADrydqoNkLjlwjKCxf1vJxQ6yuLh8srtD2Jsmudm8l
X-Google-Smtp-Source: AGHT+IFwntgNgth7jOki/KcXIRenDMbVPss4dXcdmadIUyh3N/lagah0vqAUaHIYcVKERh3jOb5Jcw==
X-Received: by 2002:aa7:8d53:0:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-710cc90db8cmr310374b3a.12.1723081384495;
        Wed, 07 Aug 2024 18:43:04 -0700 (PDT)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2301b6sm146267b3a.85.2024.08.07.18.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:43:04 -0700 (PDT)
Received: from jro by jrotkm2 id 1sbrpq-0000OH-0q ;
	Thu, 08 Aug 2024 10:20:58 +0900
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH v2 1/3] lockdep: fix upper limit for LOCKDEP_*_BITS configs
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
    linux-kernel@vger.kernel.org, kernel-team@android.com,
    Peter Zijlstra <peterz@infradead.org>,
    Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
    Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
In-Reply-To: <20240807143922.919604-2-cmllamas@google.com>
References: <20240807143922.919604-1-cmllamas@google.com> <20240807143922.919604-2-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1502.1723080058.1@jrotkm2>
Date: Thu, 08 Aug 2024 10:20:58 +0900
Message-ID: <1503.1723080058@jrotkm2>

Carlos Llamas:
> Adjust the upper limits to the maximum values that avoid these issues.
> The need for anything more, likely points to a problem elsewhere. Note
> that LOCKDEP_CHAINS_BITS was intentionally left out as its upper limit
> had a different symptom and has already been fixed [1].

I tried setting all these configs to maximum, but still I got the error.
	ld: kernel image bigger than KERNEL_IMAGE_SIZE

For me, these are the maximum.
They are compilable, but could not boot due to "out of memory".
Also I am not sure whether these values are meaningful.

CONFIG_LOCKDEP_BITS=23
(CONFIG_LOCKDEP_CHAINS_BITS=21)
CONFIG_LOCKDEP_STACK_TRACE_BITS=25
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=24
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=22


J. R. Okajima

