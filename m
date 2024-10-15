Return-Path: <linux-kernel+bounces-366304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAAA99F374
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1495428425B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CCD1F76B4;
	Tue, 15 Oct 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1FkBHPKO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D51CBA1C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011332; cv=none; b=aD65pLTiId7VfoFqIJkf0xW6MzhWdYoXYDprbBoH9Bw4/5K0aZVLWNYGVTDJ5v5SBfC2XxkfZYkmVAgY71FJXyrZG3wgWfuqQeBQqwVgy874dllDqapmhhs0j9y+FsSTZPbFhZEL+mW60N5DOfdJl6Ak3CCcHPszT6PV2N8AQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011332; c=relaxed/simple;
	bh=4W4bI7uebF/sEaVVeZOoyGw2rNdCSdxuqXpsYj8WkvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tznycGebc2ZEE835vAnPFQyQrmv8rLpNN8wvf1EJg652PIK4IdPcjUwO0srOebeLJ3eLMmkn3ieaWLEa7Z+rdF/QmleBqZriAueI8R0uXaRWlHCrlla7VIkhNW1v+9rlYgRcb8vqfR4NuN6l3z5w74j9ML2qmwjrXCyANQPg9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1FkBHPKO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e13375d3so4504812e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729011329; x=1729616129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4W4bI7uebF/sEaVVeZOoyGw2rNdCSdxuqXpsYj8WkvY=;
        b=1FkBHPKOUhdGT79looVNd7mg4JpzDHG8UrrcfqO79W4HyLh6P/JlBu5rGNIpLsyviK
         0sTxfDmb0vqoFemeA7FCfMSdr7urHcklyBDehj6gOMAnbcswlidIE0PauXGqOnh2mskG
         f7Mk+IuNVthPQzWOoIjvCfpCtwZyWq7eRhCHZ2wDL8wOCIgsbIxfCzVCTylNWrNeeFOx
         /Wle1M3rdE6otzadmbaOHfP5VI5BAHRuoDU8d1T5O1SGFfI/ryXlNROaSDnoLkn0VPY6
         gx2hruVNCqHSqVSZHU+BwT7LBEv8RqprJw4sf2vnbIo3VJYSKmtRSzxL4olHYOxth7f1
         0IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011329; x=1729616129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W4bI7uebF/sEaVVeZOoyGw2rNdCSdxuqXpsYj8WkvY=;
        b=jyaPrN8xMiaiqPmBgI9f9psX2XioGm+yJOQg9sqrHUp5UPTcFN7teHWodvul5VFjbB
         dF0/5H5eUB9mExFy7YPupGszOngnchpW5TkqJHid/rlckaeAfbqe4tAm+MfCTdY2Y9so
         1S6Vf0JJPUIW1YPEU75nAJ4MYmR9yud+qQCPIBMk5lCOfHcMTWMxfRq1S0NYzpGtF/hf
         yVerEviGiRHn/+uVfTlBHA3GuRvVeZ9h87Gpce8eRMvn+/y30l4s5WcbVjI+bEnDsDrk
         pUGYvRBBj4YPakVCkTWRs9X5+qHKvRTdamneAEoaQRgdGKxFNyJFJBF61X2Z+FZkxl7w
         7+ow==
X-Forwarded-Encrypted: i=1; AJvYcCV48jS3/Jn/lyF/LT64zn2gOntLJV20TEOhGTpGxL301xuI4qVI4x9eGYT7pzgObE/RwK4gKpS+E+1/gSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeO4HQaGowzQuiO7yY4t60qGdcKy0PBwU53hyzdgEr6uBHN9b
	R54G19wYnZOtRWYe8V6wmXv8DRA5xm1+TeFYCi/zMMtSinxMQuHJ8oW1PwWssA==
X-Google-Smtp-Source: AGHT+IF3AWzGgTg4Qvkr9yrpW5bAHI/Y5xkCPKoE4F1EumLHWDdTfzw5TEEu47mTMpVX9kE0u9CLEA==
X-Received: by 2002:a05:6512:e88:b0:539:f37f:bef2 with SMTP id 2adb3069b0e04-539f37fc3ccmr4140384e87.17.1729011328523;
        Tue, 15 Oct 2024 09:55:28 -0700 (PDT)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a1a3sm2007771f8f.12.2024.10.15.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:55:28 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:55:23 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Message-ID: <Zw6ee6PAz-kZzRAG@google.com>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
 <ZwRA9SOcOjjLJcpi@google.com>
 <20241008005136.GA241099@thelio-3990X>
 <ZwevGZHiXOBqoslA@google.com>
 <a2e8a76a-9fad-4e3e-bce1-bf8a9d180464@app.fastmail.com>
 <20241015084714.GA1546610@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015084714.GA1546610@thelio-3990X>

On Tue, Oct 15, 2024 at 01:47:14AM -0700, Nathan Chancellor wrote:
> We should be able to disable -Wenum-enum-conversion without impacting
> the ability to catch the cases that you mentioned above. It also helps
> that GCC supports -Wenum-conversion, but it does not seem like they have
> an equivalent for -Wenum-enum-conversion.

Could you please create and send a patch to disable
-Wenum-enum-conversion?

