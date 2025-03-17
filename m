Return-Path: <linux-kernel+bounces-563706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A44A646EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D72188BD5E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BAC221F3F;
	Mon, 17 Mar 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Beq8D6/C"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAD1758B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203174; cv=none; b=dGTPhMF7DRpLS16WAlAHL8232T+b3O05bxRRdMF6D+vuf4wem8rMxlm8IhqQCYREPQYkJhhGaOFY3PPoR+MyFKUeKi8j/FmUlsjNpcf7u++i1HmnxpWROpAmHMPWdvkUIu+LiSEsEPrwFuSl6Xji1GO+CWOc0WThPp08hh14Qik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203174; c=relaxed/simple;
	bh=Cb2+kg40QVXAjLDWqKR5kaW0T12Jxx7UynnCof1J9C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYgwej9IsvX1VtwiXXsBaO/76uMM0e0ULesHWbDDu3K+o3TlPpg/OEMYjYgAjEO3/tcN1oTUQOOHxB5LzsPxvuZjOt1Y5NGCzuWmYXDKDLNvyD7VQ+XA+Zd+PqCq6Kp0bOLqYJPQ6jWRn3Vb9QmFsaEf2wJLBkjGSqBq7IU9/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Beq8D6/C; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so72795e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742203170; x=1742807970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wE6VYZ4uCoxY7gdQeJispFvvHIE65N+4N0fmOWliK0=;
        b=Beq8D6/Cm2UZ7/7CpXyXSqBhYBjXplPAh4f7ajZ/2UJQBGa0frTXSbogpBcVmqYi2d
         xy2HK9ub+r61fW3FxF7c8ETg1o8BN26VqOjSN9e5zlmh2pAi3e/T0YgeaqkRoCJ4STHZ
         GScwKcByRjsB7w3k6HLEZdnuCtRCs6XGzQjtpB/T9xoKGqq7M5u5b4IHsYBZtQAAXvgI
         8lpUQNR8xvEHXZSBz3ssxpSqlBd7sXyqJ3h8/K8VaXsK2+Gzo5xjcfllfgMdCzRYR0Xd
         82DVu/K7RpOlYSxquEKhoSfltU3R5pCkDM2mTu3s8o0ow5UZkoGtWkj785/YQXwMEy/R
         IeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203170; x=1742807970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wE6VYZ4uCoxY7gdQeJispFvvHIE65N+4N0fmOWliK0=;
        b=bvLpo0cjI8I8ZN/GC5gSd9dhfHDKEaSJpOKV3BrorvlDY7MBuLLpI95/voq7udk1f1
         C+hLiMdr1/4MerisDS81Hx8ZoyW11OGCGmg7rGSoqNnYJFE4eUGFwCG1EdDehzRb9PGJ
         JZ6LympyMJF/4UqDgoG2uqxH0Lb3O2DxvNr9n/KUN+J4Bq4WIMU56NQuf0R1QuFk+oSS
         xceZEatewgke6dOd5QTiDsk+SFgGeOQVYzacItvz1xq5Lu/yYozxUQKwosFP5SUC/wKp
         xM4kNwRSccpDoB1AZpOPc70kOiPS/LmvTZ0A16bG+oAtoZ3uGIm0mvjGvNjqAob9JR8d
         5eaw==
X-Forwarded-Encrypted: i=1; AJvYcCXdhSJqmwrKiadcIYsOaATflqsUwZUBShgyA8wCB8pUPtkMDGNhZ4gTRsCth7wXzfU6JLWnTgW+8rNngqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqa+QqzEGRc4yjwYRx+iu5F5jspsiyGi22v/5wLoucHL+w701h
	9Ysk9ihi0LfvJrfr8leHCCR1sPy4LWe55slrx2ndQUZ0shN9YqUB+g+/6pvdsQ==
X-Gm-Gg: ASbGncsJfhO6mKpdGD85qwHYPCt58n+z20C/ABJebpCsM+2EXbIklgGfvTLkC3e+EmA
	QSmg3YAAqhEjlZL40WhhhiMsiTgxwrpuaiH4ZKfBuPUWyLEp4Lqd5wH1wpP0mXQg9q+hEaWsLwX
	mmqbICfTk9JG5t6rLdZsJGQ4Z6MrTH7Wfs4D2h2XgeUaypjHlDbcTWKcDioRRNo6y84H0eOviRd
	rfz2wsKCg0dkvoVf3P1sY9tHTm7mR8nvMse/0XMtEumRcMWVzW3mhOHgpoQNvL0jQSD9YS3aiA7
	qYdYhjg886IEGqfRxPr/RS2PFXM8GcYbN+DIfreiiC7LeAnF0XEORKC8w7jlieMvHxLXwwJe+C9
	oQ/K1Sd0=
X-Google-Smtp-Source: AGHT+IEBwOPCMi8TGJvcCeAoXUMl+HG4zPfMEdGDmBluiMz46MeTloFXdTsHRwP6XhL/g250fhF07A==
X-Received: by 2002:a05:600c:5cb:b0:439:961d:fc7d with SMTP id 5b1f17b1804b1-43d251f35edmr2694805e9.6.1742203169557;
        Mon, 17 Mar 2025 02:19:29 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb626esm99000515e9.8.2025.03.17.02.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:19:29 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:19:24 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 07/13] objtool: Consolidate option validation
Message-ID: <Z9fpHG0mIBcVzRku@google.com>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <8f886502fda1d15f39d7351b70d4ebe5903da627.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f886502fda1d15f39d7351b70d4ebe5903da627.1741975349.git.jpoimboe@kernel.org>

On Fri, Mar 14, 2025 at 12:29:05PM -0700, Josh Poimboeuf wrote:
> The option validations are a bit scattered, consolidate them.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Brendan Jackman <jackmanb@google.com>

