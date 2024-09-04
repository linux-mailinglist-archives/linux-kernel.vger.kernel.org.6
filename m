Return-Path: <linux-kernel+bounces-314730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB2096B7BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6BD282A36
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF61CEEBE;
	Wed,  4 Sep 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cLYI7HyO"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB021547E0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444292; cv=none; b=JVYpk2oHTabTIO9mAz8x7GK4JQek0t4wDSmWVDKGri7P1AWo50jV3Lm2zkNoRsU0zdLM0KBg4gqo7uRkWX8Dvikqv6+F1CD0kEccm0uAs6wKsvIepGsgjvHW+9516QwReUt6esMD3eLhxyeePzwn8Av7vYDur+MRWXvcZC3tHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444292; c=relaxed/simple;
	bh=CLNkCPXSrmbm7CtWqVHTUdhz61g9zh8FHrAfFT5F2AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsCEPSQSjgyoeqoey0pJU0KVe1peoE2na5gOUA/emPTSHKSj3kU+zosCZDoaBpYvEpf1cjmcbVLCM9hXwM7QVETvZ6098ba5UOCYEG3oEirUwWFh4hfWqPll/nW7jrcg64whkJ4HC340VSGL3ASLCD9Ampxc+5i1ib27hGsR3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cLYI7HyO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so4098206a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725444289; x=1726049089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OjCfTzZBVDRV3mzIA3YSqJ89rOjOD2gBYPgcFgJ9ENE=;
        b=cLYI7HyOR5vGrqBQ9olWY7hwxZpgZFWo8jbmIYlNn4YlwyogurKLnDp30J8QQEHmJt
         Aj5z6KeJDKbW1soVxI+fl6N63upnH8riR9Pwr66qpuaLLzN6kVISaO0Tst9eFRaorMOZ
         F7GLaT9BRqkuZ2PcWxYrX/UA8ecO9VA+GVWPvsF4iR76yzHC+YpPkHT+Plhs4YWgHKyT
         1mAIeb1QttXUMllsiotuprUxtNNeSSVWx4f54lqEz+wP+C3NrC8gaVoHGPNVuNpyzeyf
         BWOfwzrhMQ4Z9iPeTPldZQJx7tdp6yavUOWcEQNSztnLqbocKpIgKf+iMWmto2yZ8KuG
         r9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725444289; x=1726049089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjCfTzZBVDRV3mzIA3YSqJ89rOjOD2gBYPgcFgJ9ENE=;
        b=OjPgIV9p1jCk1KG+Y1Xdm/CyKVgf3KrixipuqWKl4SNyAfkLFCS3zQYMnShqFgV2+h
         nU7ann1OcHQGDaqATl5ghkALqJJ28YPXKOoPIeYkaEz7Tx7kh2wzPN3vePFhCCk71/KV
         8XtU4nFidgtZqBP1ZhnNP+w9plhshj+8vmD4+fXA53wVL8CBsL3qk7RP32Gv/nd30iJV
         dNq7rQEJuQnd4YgMCDI3+ZLtsM1qmGthBo8tZ49SQnEsnovOBgalFxBCLiGRrca+H91Y
         LQmyIePLUTH1DfkWeOp4jQsieaYvTuX8kWKV8riiVGrjundani/EUnafkmcP7WTP2NlJ
         dUbw==
X-Forwarded-Encrypted: i=1; AJvYcCUENsjo/1rmCprqreQM5dlYCpb5/PnQxjszjEs37Bh4NlTS2pMqQmkneciacYbCuRvxDcnGi6pMmovGmqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZs0mMs2eWnsRqomULw1hqHBTQAlyPz2VPXgSQA0/2RckR6a0a
	VlN84d0OM28gCa42+whmTftGosDHhm/US1OGcRc0F87sEd/BPLpoSj/qOGUvtrE=
X-Google-Smtp-Source: AGHT+IFtr+hYdONq5xLd8nFJW8KqEKj1EK6KuV7UnJK9IfIV44OQPH2nBEnGdXNIHmfHrLI0how85Q==
X-Received: by 2002:a50:8d8c:0:b0:5c2:5d34:a481 with SMTP id 4fb4d7f45d1cf-5c2757d6db0mr2164476a12.11.1725444288811;
        Wed, 04 Sep 2024 03:04:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c25c8b0f3dsm3728479a12.58.2024.09.04.03.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:04:48 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:04:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: rostedt@goodmis.org, john.ogness@linutronix.de,
	senozhatsky@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 RESEND] printk: Use the BITS_PER_LONG macro
Message-ID: <Ztgwv2NMZw03kLjw@pathway.suse.cz>
References: <20240903035358.308482-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903035358.308482-1-ruanjinjie@huawei.com>

On Tue 2024-09-03 11:53:58, Jinjie Ruan wrote:
> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
> variable, replace it with BITS_PER_LONG macro to make it simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

JFYI, the patch has been committed into printk/linux.git,
branch rework/write_atomic. It is intended for 6.12 merge window.

I have chosen this branch because it modified the list of included
files in kernel/printk/printk_ringbuffer.h as well. It allowed to apply
the patch without conflicts.

Best Regards,
Petr

