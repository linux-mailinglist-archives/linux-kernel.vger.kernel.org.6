Return-Path: <linux-kernel+bounces-415203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 639789D32E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7111F23806
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9B8615A;
	Wed, 20 Nov 2024 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="dNqzc2t/"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F212E5B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732076278; cv=none; b=kT5hZikPp7MxgLEWPDlrN6k9tNYzL8wF7ZDCDKgJ6Lxe0QpAvafR2LROF6VGpTUI93rQCOaTammmO72NadMpWcp/755gj+PYYRmMZlUeEKsZ0bLKPxYxfuFk8uxvObv/YGLcEi3FYm25lY7poUYKBtQDIZldnoci/MUHy/fFTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732076278; c=relaxed/simple;
	bh=40djG9fo0UnGkIaL6uuL1XR8Zl/me2VRH6flJqmd560=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9VB5PYv0LD0JAx61UGMZu0JtyJ69zyyB+zxavrVk4oCF9mQ76xeogp6mOFy+Fq9p3SSyEwhYIqT4hMyEBECURQoaOzx201yhCLgNo24z2R3xdZae3GLeEx99omJeVDhlgMm+Mql9a1T+oH8SsobuxpqQ6E2VFR8un6mc+n1mIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=dNqzc2t/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so52599815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1732076275; x=1732681075; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCkGsudYwp8HdF8aRbKFEFLGOXv/hDtK88Xh9ypLWBM=;
        b=dNqzc2t/IjiMXyUNWHEkBPAgawbBixNEs4DG2EngYzseCYHCaRd89vRt5JaSnXapWO
         Q6WRHGMRec/4gnKixOw5/SbiXG4D4X4sWzHSHHbFhrY32IVW1wM2fMT/oQVWrCL1pjcf
         WTsocCq8cnhVKDLxW52eQOHKvPKCBh6AyhSco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732076275; x=1732681075;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCkGsudYwp8HdF8aRbKFEFLGOXv/hDtK88Xh9ypLWBM=;
        b=YwJkOAINBClkzyu5nkYX9njkX+lQcZH/2NYSysmdQzrpWHfNoMG+YfEwpyEFIaPekb
         i4vpMNlRFZX8PT27jVMfbKEXgYV/nLHSccQwkv5DkQjTiZkBErURGv6J1npjh790EJ/J
         8jzacynLkBzOqJUhC3UVif+waIxo36xFukoZ1MZfQSTYCDf+VcorTD0K0TE272uI12YY
         JmrAgpfjzRfrMXIEn2udVtEWEJG7Ecr0Uv/SpaOw9PJDKqgafqWJ//GehACulMd38qem
         gBtjAz/+vf8i9uN/TiOzO4G/FvgQhg7ac7sNO2Jswag1e88xdk3hbJ7na0dbgqbGPrnz
         32qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtZ78HRN6icCvlZj8ZPftrm+AnDeBs5gdgxvZv9FKD2bkWnmOBHODcT1ery9liVh8SOKXnSJwcJnWvl2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVK7Uz8GhE0TFd4uTS4wi/Jl0/ImHn4nM9JkIQVxQPSRyA/Zd2
	sny+du5QTGUdNey68/289vq6iF8nCgDDTgWmeNjvutp1RlRDB097tWQzuDtYGjs=
X-Google-Smtp-Source: AGHT+IHsjKCzrokNkuVMMLpYGqzaThguR0JMWMxm7qnxu+bDc7yQ1ygdcTeF1T5nDVoO93Gm8zOg2A==
X-Received: by 2002:a05:6000:144d:b0:382:4721:2391 with SMTP id ffacd0b85a97d-38254b212f2mr827952f8f.57.1732076274943;
        Tue, 19 Nov 2024 20:17:54 -0800 (PST)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490c2easm911646f8f.29.2024.11.19.20.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 20:17:53 -0800 (PST)
Date: Wed, 20 Nov 2024 04:17:51 +0000
From: Chris Down <chris@chrisdown.name>
To: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: [PATCH v6 02/11] printk: Use struct console for suppression and
 extended console state
Message-ID: <Zz1i78qGL02oF8Zl@chrisdown.name>
References: <cover.1730133890.git.chris@chrisdown.name>
 <ba47efbe432cf33cb358a027a2266296e2cfe89e.1730133890.git.chris@chrisdown.name>
 <84plmw527r.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <84plmw527r.fsf@jogness.linutronix.de>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

John Ogness writes:
>On 2024-10-28, Chris Down <chris@chrisdown.name> wrote:
>> In preparation for supporting per-console loglevels, modify
>> printk_get_next_message() to accept the console itself instead of
>> individual arguments that mimic its fields.
>
>Sorry, this is not allowed. printk_get_next_message() was created
>specifically to locklessly retrieve and format arbitrary records. It
>must never be tied to a console because it has nothing to do with
>consoles (as can bee seen with the devkmsg_read() hack you added in the
>function).
>
>I recommend adding an extra argument specifying the level.
>
>The extra argument would be redundant if may_suppress=false. So perhaps
>as an alternative change "bool may_suppress" to "u32 supress_level". The
>loglevels are only 3 bits. So you could easily define a special value
>NO_SUPPRESS to represent the may_suppress=false case.
>
>#define NO_SUPPRESS BIT(31)
>
>bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>                             bool is_extended, u32 suppress_level);
>
>Then in devkmsg_read():
>
>printk_get_next_message(&pmsg, atomic64_read(&user->seq), true, NO_SUPRRESS)

Petr, what do you think about this? I remember when we discussed this before we 
talked about either determining state via `struct console` (which seems to turn 
out not to be feasible) or passing another argument.

Do you prefer to have another argument or do the bit dance?

Personally I prefer the simpler solution with more arguments instead of bit 
stuffing if we have to go this way, but I'm up for whichever sounds good to 
you.

