Return-Path: <linux-kernel+bounces-274834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F38947D62
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD58E281B8B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3F145327;
	Mon,  5 Aug 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lta4aXrR"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D5613C3F9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869961; cv=none; b=p0NHcS0GZdrVNxalUjr0XUrehF2YJPKcN9LhXrdjeiq1LY9y50/qhX6tYRo63y64w2T/9LCDpCEftjThRilfOcIVnVoxE3hhf90Tumyz6X/s2pw0MmRSLfI14nuKVv072U6qGJMI002z9btFD2vDpMxVHlUcSJO1+x/L06OQoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869961; c=relaxed/simple;
	bh=wdzEBtELt1LbJW8CuPK+Ow3szyQ10mNZDMOfOWB1YOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYyVR/+VhrClFOzFJddsiF3ncNFnssF/akAWlQ59wv5y+Z9san80z3WqcB3/dv+lhUk38NaNi0ej8Mn4+BpxKqA7W4se0kAsrzicSSr6fay6obpnnUllfvNYkMm83HyYidV+wWqI+N96le4A28MY5ZHU0RlclPQMk7wTv7ZQU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lta4aXrR; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a8e73b29cso883120166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 07:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722869957; x=1723474757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+VH+XoyJ8PTHRCZqf0rzi95ccngFYz+k1uHLYhQ86c=;
        b=Lta4aXrRGwn1VqqgciOEpanBlJtm8/zB0Y83DPNml0cu0KNhRSvhHcTsIzAaB/IlxO
         d4NkiTptyMqPznCODZBM5pfa6TLP4nw8EJllxIM/X+pQPnDprcrlpTNqMvQjcGIl8byE
         2hPXo8Z/W8fxCpVRE7oZp/khos8oYIuCPAB4fLjznUtYK202F7b8vln4LKlhSalipyzi
         oElCaosKyOjhP1Wkcu4cuRrZ6kILhZqACpQmImkNFF4cjlY0fdq1X2+yBTIdHsxwk7bM
         NKvXcK7Y26suGl/6h6dA5mM1iRFa6mvvnDd8tpcHqV2mQ53nNSHQDz0XUCXYaGfBTZ+B
         iehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722869957; x=1723474757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+VH+XoyJ8PTHRCZqf0rzi95ccngFYz+k1uHLYhQ86c=;
        b=UhW6AFEhELvnlTM158ImJKHd5zqmLdWGNk/dAHAFTyySyYDJhIusTfgKnfoGWFbmfP
         Jsw5q34PD43rCyeHQ/Wkrq8+ZMA+qFPNu4eQnIxVA6nt+Gh37J7bt5Gkiip9wR+rUbcO
         yAULqCQlKhDsl1g3HbFW+NCSHZkUXbQJbWovudCmWQApAiW+osG30jIzNqjXbqF6Q945
         3Ko5QI3WxxINoxuKiUNP+xGnNraU4HVufqZPoMGHOHqpjyGK/gYj/xQEQkZTueGP8ThK
         G44mqeySyt2FBD9yuSUlaOtC1KyyEdBoLRKTM8UsdKTDW4oY42TqgmayhEL0aquKXKp9
         j3aA==
X-Forwarded-Encrypted: i=1; AJvYcCVKuWwh9o9VaF6dt/7XJJcjXA6zRRo2fiYuYv+L7rL5rkGSyn66P3h8hBuqUKRDSZhW6EkgT+s51vDaXrhJ2cGhf5+nwjqMb0PlS35k
X-Gm-Message-State: AOJu0YxUruuf0MpeCVptXV3ZMlSKYE85XtYvwQq0rQSG6XknEWA+RHTy
	s+BahT7OWoyaXJq6+lGh9ivm9HBkxjjWKFrp63chf+y3uj2GBtd+yQfCYJ2gSnA=
X-Google-Smtp-Source: AGHT+IE+h3a34TOyzaVJBnifo28KHJ0yN7Dt3YXxIEgILFYmurOnYo1rowk+T9LSVePT1bMiPwKpoQ==
X-Received: by 2002:a17:907:25c3:b0:a77:cca9:b212 with SMTP id a640c23a62f3a-a7dc50a5765mr1077599666b.45.1722869957541;
        Mon, 05 Aug 2024 07:59:17 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c0d5sm461787966b.48.2024.08.05.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:59:17 -0700 (PDT)
Date: Mon, 5 Aug 2024 16:59:15 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v7 20/35] printk: nbcon: Provide function to flush
 using write_atomic()
Message-ID: <ZrDow4XVyFKm8vDf@pathway.suse.cz>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
 <20240804005138.3722656-21-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804005138.3722656-21-john.ogness@linutronix.de>

On Sun 2024-08-04 02:57:23, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide nbcon_atomic_flush_pending() to perform flushing of all
> registered nbcon consoles using their write_atomic() callback.
> 
> Unlike console_flush_all(), nbcon_atomic_flush_pending() will
> only flush up through the newest record at the time of the
> call. This prevents a CPU from printing unbounded when other
> CPUs are adding records. If new records are added while
> flushing, it is expected that the dedicated printer threads
> will print those records. If the printer thread is not
> available (which is always the case at this point in the
> rework), nbcon_atomic_flush_pending() _will_ flush all records
> in the ringbuffer.
> 
> Unlike console_flush_all(), nbcon_atomic_flush_pending() will
> fully flush one console before flushing the next. This helps to
> guarantee that a block of pending records (such as a stack
> trace in an emergency situation) can be printed atomically at
> once before releasing console ownership.
> 
> nbcon_atomic_flush_pending() is safe in any context because it
> uses write_atomic() and acquires with unsafe_takeover disabled.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

