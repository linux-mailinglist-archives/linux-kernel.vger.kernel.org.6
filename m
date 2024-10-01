Return-Path: <linux-kernel+bounces-346258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C139298C1F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899BA284686
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EDB1CB33B;
	Tue,  1 Oct 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CXLhXHle"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85D1CB317
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797597; cv=none; b=gZmcQnKabEI9Y4/N+lLwQH2Y3pvLuwkxqhVd0Aneky5OKM+ok2a6n642qmwh1NvIQLxSKot072Mou/5myvSYwI0XOrQLWpMLpyzgx26kVjCxLEfT0HfXxlahu2qItKLMSvZEoL0BuOFJbiXGagExj2uInRHFsOUItov53fac6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797597; c=relaxed/simple;
	bh=9br6g9n0uSGXmpsIpc6yUjeWkmpYeg6RvzHhvnvWLyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTIsy62RcOtNcnh9LvrGlt7yLyywwoL2sZWURjvx/hn5f4YxlzKUNg8FpPwIFSGkAEg6leWwV2r1NlG7d/PvSng06p7jnnSTF7BU7DRgTkKAXodh2jPCjSCfGfw3+Mv0VPJi9rfsmlXUrcxz0/2+kN8/32ZWk0kC0BZa6D87IM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CXLhXHle; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d4093722bso851118766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727797593; x=1728402393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3xQRz9fQo+hLhoOQDLLZ1i/4385nTVL2uvqeDMTUaY=;
        b=CXLhXHle1wYkdWBNp+4e2qaSwZ7lTFXvNA+SLtP099oooDZYnK64DqfccdmfD3bxEM
         lSGKqgLAwrUhEkKJg52iQHyRC1BVOu2QQJygw35nSQA+JN6Y3f86hfGXWNe/ZqTDBf+Y
         VO9S5rQa06WclYZ5XVPpu/oGXJnXv5VjG8pKrlZHzPAVjLssnUnvd9kRg3IWICWmn5/g
         2LfjDe6Exj5burGcqOil/OlqdGoWk5q5AvGCuynSEUrn0Z2p6u86MLsyPMDLYKP7v0dP
         2P/lc7jUyUY1AVYGh+MYXdoU6H8EU32JjrjlY7MCrgkycOFKTanHApz678UATiLhB7IA
         6aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797593; x=1728402393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3xQRz9fQo+hLhoOQDLLZ1i/4385nTVL2uvqeDMTUaY=;
        b=HHV/Y+h6oo1KzO0Ih6cQf5+yIG94/U72AhabkWxqDZ62FFX1YM42amqi5gBYc7bFCs
         l72toOiR289nqyNElzwxjg1x7fIARqvrpc4s3EkhlexPO59Y/DrkQMr8xO0L7OPyhs+I
         tIQ9jeFYju90B7EDlfPmfKYRbQ1hAAh6SNIwgOrmXI5uEWZD5mlofdmwtmg2kBOBC9dv
         vmoWEHwbwY0bSEEAZJjK3JBEA+/2piN40Mxn/dcgJG/X+wCPe4P9UcDOwThIm2oZWdFd
         ltw0zeULC8Kp6SuS24dtTZPyZZ5MYGNutsMTgTQw3P2rmZXCj07GJOnGVuk/MmwqBL+k
         Hxxg==
X-Forwarded-Encrypted: i=1; AJvYcCX2BGaowqTFURKdd5beoujZZn8QRg03QAP6/qJwXSHfvJzhLJqWbanP92tOehQeLFAbrj0euSZKksqUI0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ONWwmzhRci1dz4YQKwtPEEV37jfnXb85Ak/6YUeC19a4KcFL
	out1HbPWgKdCMkF9E8uiOFBrsMyWpodMWGZvcrv47wtt6KvHtGOnddJhwOYhgRA=
X-Google-Smtp-Source: AGHT+IG0r+u1aTxCSHVZGxG+i8Davdn7hI0azQ0k+YHNMHBw5KMSaE+h9+Nzyp8vMsZRGP7e+C05FQ==
X-Received: by 2002:a17:906:f5a3:b0:a80:d913:be07 with SMTP id a640c23a62f3a-a98f8261dc5mr2879166b.36.1727797593263;
        Tue, 01 Oct 2024 08:46:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2776878sm729304266b.28.2024.10.01.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 08:46:33 -0700 (PDT)
Date: Tue, 1 Oct 2024 17:46:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>, surenb@google.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: Improve memory usage logging during boot
Message-ID: <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
References: <20240930184826.3595221-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930184826.3595221-1-isaacmanjarres@google.com>

On Mon 2024-09-30 11:48:24, Isaac J. Manjarres wrote:
> When the initial printk ring buffer size is updated, setup_log_buf()
> allocates a new ring buffer, as well as a set of meta-data structures
> for the new ring buffer. The function also emits the new size of the
> ring buffer, but not the size of the meta-data structures.
> 
> This makes it difficult to assess how changing the log buffer size
> impacts memory usage during boot.
> 
> For instance, increasing the ring buffer size from 512 KB to 1 MB
> through the command line yields an increase of 2304 KB in reserved
> memory at boot, while the only obvious change is the 512 KB
> difference in the ring buffer sizes:
> 
> log_buf_len=512K:
> 
> printk: log_buf_len: 524288 bytes
> Memory: ... (... 733252K reserved ...)
> 
> log_buf_len=1M:
> 
> printk: log_buf_len: 1048576 bytes
> Memory: ... (... 735556K reserved ...)
> 
> This is because of how the size of the meta-data structures scale with
> the size of the ring buffer.
> 
> Even when there aren't changes to the printk ring buffer size (i.e. the
> initial size ==  1 << CONFIG_LOG_BUF_SHIFT), it is impossible to tell
> how much memory is consumed by the printk ring buffer during boot.
> 
> Therefore, unconditionally log the sizes of the printk ring buffer
> and its meta-data structures, so that it's easier to understand
> how changing the log buffer size (either through the command line or
> by changing CONFIG_LOG_BUF_SHIFT) affects boot time memory usage.
> 
> With the new logs, it is much easier to see exactly why the memory
> increased by 2304 KB:
> 
> log_buf_len=512K:
> 
> printk: log_buf_len: 524288 bytes
> printk: prb_descs size: 393216 bytes
> printk: printk_infos size: 1441792 bytes

This should get updated to the new format.
If I count correctly then it should be:

printk: log buffer data + meta data: 524288 + 1835008 = 2359296 bytes

> Memory: ... (... 733252K reserved ...)
> 
> log_buf_len=1M:
> 
> printk: log_buf_len: 1048576 bytes
> printk: prb_descs size: 786432 bytes
> printk: printk_infos size: 2883584 bytes

and here:

printk: log buffer data + meta data: 1048576 + 3670016 = 4718592 bytes

> Memory: ... (... 735556K reserved ...)
>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Otherwise, it looks good. With the updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>


Note need to send v3. I could update the commit message when committing
the patch.

I am going to wait few days for a potential another review
before pushing.

Best Regards,
Petr

