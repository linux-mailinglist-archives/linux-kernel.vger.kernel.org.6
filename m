Return-Path: <linux-kernel+bounces-569945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18DAA6A9FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED13189BEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59B1E834E;
	Thu, 20 Mar 2025 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eoo/aTds"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122D1E8320
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484476; cv=none; b=lRiTFTKam0+wdx7Pk9DmXCCZ204JgLKy1wwZ0B6sr07hcyHfWu+GCelsnF4MxO2SRkMXppum3h7sIIUtX/61OWNtjMHDEwQOZyrfEllvfDTVIRkFFlC+Qli1wIPbhenZv9BvSMNrF/fMUzr9vDWRl9p27prrLvVSbZlVDg0oe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484476; c=relaxed/simple;
	bh=M5l6r6X4USOpBWHWlUcOI2+l/cDjb0oLSQ07TjLPd2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHoFSUGN8M8nuGdbiZK0eSxeEA+VTqsxgnzmPdvQSlzwo10fewNx5MYlhtfuz9Hy8/eDbByHLfNa4NtQ1sbH6juSqNt0PzpINjntbzcTG2UVdKiQSeOek169Kmg2mgCWlwi8n43YjrP/Ntez+LthAbLTlLjcWKa3fk5w5ONxu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eoo/aTds; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39127512371so652158f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742484472; x=1743089272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CNn2qFI1YqcuvF2AaGCJJLcs9ceh8YGCmz2ofarimx0=;
        b=eoo/aTdsQ0wwAk8l7kWnzYNysuiEEkKOMxaWHA7kfcjsupds7Xo6/xU6ZfZZitKvx0
         e2LYvEK5tChFmX8Guvo78g+a80p5TDeUz5Fne6D+E88utWkQft5NF+N1mjQo17sP4LB3
         CZugb6JKPCIVQJIaASKxPPHDX0L4kCuHFcO/aei1VCuptRAqGbU77X+bdaVXW/oFgIDH
         0MrUP18DYvK386EJVgWmF93nFpUmWQBD9iI/eQ0Tcu9Qfj4qhPI0mqm0KMDhaiJ0nlWK
         QKCmSTHoZLzjU/DI36V64NJePjSkbLmQdxPXnxzdm4WQc2/7KWvBdMv+6kPvqkiCecSn
         fQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484472; x=1743089272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNn2qFI1YqcuvF2AaGCJJLcs9ceh8YGCmz2ofarimx0=;
        b=tIfXPHEjRv3vojrVtXzGCyjvIwjyuFaGynMBFaBCxNLHjeS0C+eZ5lVVETQ70XcbQt
         KfxgrP93dYw7okbGUEQGRApYERfGvkJPr5KWVqZej37QJ3xBcLLzUHzPkkxjBzvu7kgS
         DkCMxZNYj3nbfM1ohI8oT71Kt4mkMRYyOyC/1py3/A9G94Ynkcf8m/tHK8OKXt6Q+wxV
         FqRPOmlm2Lm2Wi9GrMu+CTM/KWKPiQM0tEIE6hX9qqLPgAvpbkNxMEzcwW7+QY9hYu63
         luTGpytei6cCYLupSZMLNExp2wwH3OXhUz13M+SHqHroShwHYZKizhTjt65NY2xSaO4k
         qhLA==
X-Forwarded-Encrypted: i=1; AJvYcCUmHcPJ6RyAg7qC3MBapgDgJKwhz6bWn8WDydk5q2mypgJqeBu3W6Zecc//7SNz9xVOQhNdg0Qck7JzUvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFME7eRvMIwUb1ilTMJMw75uuvCGXn/Z95E0YPvAe5Gh3XPKk
	2GeU9lmkIZahLtTSon3kcFOvB9N5dDL6LLJVqCLwqlg83vRHfSYpeaiXOH6nOnE=
X-Gm-Gg: ASbGncuid0t4w++QkeIHM0UPmPZE77IFum5hvyIIUWd1xJy2/aNgVXWwoUqMctWHAKI
	H1iI08DybUAXdMiFaYJZGmJkQS/HS0c3yLZwbD6hIlupZ6Kdi1mSN10MeSSXTv+BH61o+cdaKAy
	aMuHK2MHAeYDi4rlTGfZuhweGbbFCgKMajy+e8JAM8ooBxyGyDiPEIf0kzlBLgnS7BXzxGZLTp+
	UVIW4lwQgLgO3UbmDWldiLjvDHEquglAPGvx5kK8+x1cVJ4JFhkHLdbfWAsEOUlbGA33Rc4YyFH
	U20phPNZoifvBxfiG+Rwr1n/v0cqvhj5aKXZReuO8R7iunc=
X-Google-Smtp-Source: AGHT+IFl+0ynmfCGq2kRiStyfUhVvxGB1wd81PmlvOXCr8vEgUktpNdenNPZwFY7cDUGEYOF2HEu6Q==
X-Received: by 2002:a05:6000:2711:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39973b027e5mr5183207f8f.43.1742484472016;
        Thu, 20 Mar 2025 08:27:52 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df31f6sm24026766f8f.6.2025.03.20.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:27:51 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:27:49 +0100
From: Petr Mladek <pmladek@suse.com>
To: Donghyeok Choe <d7271.choe@samsung.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, takakura@valinux.co.jp,
	youngmin.nam@samsung.com, hajun.sung@samsung.com,
	seungh.jung@samsung.com, jh1012.choi@samsung.com
Subject: Re: [PATCH v2] printk/panic: Add option to allow non-panic CPUs to
 write to the ring buffer.
Message-ID: <Z9wz9Wk28lmvy4Dg@pathway.suse.cz>
References: <CGME20250318022458epcas2p31c3deaea27ceca3ecc405395d2cd10d4@epcas2p3.samsung.com>
 <20250318022320.2428155-1-d7271.choe@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318022320.2428155-1-d7271.choe@samsung.com>

On Tue 2025-03-18 11:23:20, Donghyeok Choe wrote:
> Commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
> aimed to isolate panic-related messages. However, when panic() itself
> malfunctions, messages from non-panic CPUs become crucial for debugging.
> 
> While commit bcc954c6caba ("printk/panic: Allow cpu backtraces to
> be written into ringbuffer during panic") enables non-panic CPU
> backtraces, it may not provide sufficient diagnostic information.
> 
> Introduce the "printk_debug_non_panic_cpus" command-line option,
> enabling non-panic CPU messages to be stored in the ring buffer during
> a panic. This also prevents discarding non-finalized messages from
> non-panic CPUs during console flushing, providing a more comprehensive
> view of system state during critical failures.
> 
> Link: https://lore.kernel.org/all/Z8cLEkqLL2IOyNIj@pathway/
> Signed-off-by: Donghyeok Choe <d7271.choe@samsung.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/all/20250305044046.1249972-1-d7271.choe@samsung.com/

I was about to push this patch but I have realized that we forgot
to update Documentation/admin-guide/kernel-parameters.txt

Also I found that the prefix "printk_" did not fit well with
the existing options. There were only module parameters
which started with "printk." prefix.

So, I decided to remove the "printk_" prefix and add also
the module_paramter, so that we have both:

early_param("debug_non_panic_cpus", debug_non_panic_cpus_setup);
module_param(debug_non_panic_cpus, bool, 0644);
MODULE_PARM_DESC(debug_non_panic_cpus,
		 "allow messages from non-panic CPUs in panic()");

It is similar to "ignore_loglevel".

I had a dilemma whether to send it for review or just push it.
I decided to push it because nobody did really care about
the name and the changes were straightforward. Also it did not
make much sense to miss the upcoming merge window just
because of these cosmetic issues.


Result:

The patch has been comitted into printk/linux.git,
branch for-6.15, see
https://web.git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-6.15&id=c1aa3daa517292303d98ff61f0440c354669f948

Feel free to ask me take it back. I am going to wait few days
before sending pull request for 6.15.

Best Regards,
Petr

