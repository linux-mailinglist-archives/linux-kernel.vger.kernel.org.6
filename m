Return-Path: <linux-kernel+bounces-522329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F702A3C8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DB63B1333
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99412231A37;
	Wed, 19 Feb 2025 19:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KE1J4CEX"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E2F22DF94
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993390; cv=none; b=m8lwtXjFK31eHXQpODbCni2javzZjzRx6cVwQBQZTwH+A+j88yfhu+Cwb9PPESU0RzOViLNwMfNGzCaxIXUu3uyilmT8XfmHhtp6cnGI+J7p8owvji5h+S8FDn522BtxeAaUxwoEh4RemxCYCOJxKk9Y9RI7rBqgXcjiheP2+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993390; c=relaxed/simple;
	bh=vPJR1E+0nKkRmD9t4ibyCr5vD5vQJz9FfqZBVLMHJH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVN0o5bQW6xKVBZDaMbJIzjIWHsR3O+4VT5UoYkRXint7NHuwJ4IK1yeXnproXnLu4RAe3g0IGc5mVvpejT5+BLFw7KsstmBn04B3Qxuegs2mW50jHGfpkzFS35kjh5+sgsGR1+4r8zgKii8vuznwKSE+On3DPSEqxyYI6BxAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KE1J4CEX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso1073325e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739993386; x=1740598186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRgBw/9+DjIn2dUaxLVe1aJruEsrC0b6BMldTb9aem4=;
        b=KE1J4CEXhtkyOgkhPSESfBNhpQ1seNsT1y7FosjTqiXMD/Lgkc8Fqm0XlUFC6dVtFp
         5CzwbKZXeV8c7xt9SLuzv0WnTcAA+7hA+ZBkZyJe0CyRkt7fqc9Dz65uvS2RiCFggjNZ
         ehpmyMO8M+XBC2XKKGQFkLPM7a5+oJaY5/OP5IOiX+6KCgesM0biUofAx9VjMJ318sKN
         OHcq8F6gCe8fTp4P6kZjOYQ/8yf8RhGWshWCMEbjhcnp5pNGejq8cSzSTFzOxwuaSUTq
         2e4oBy+Eh9FWzAwzak76WdnfT2lfTvVpJjMYUSSMZBkPn/pPjDP1tkanC/7ieVZNNj+y
         2LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993386; x=1740598186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRgBw/9+DjIn2dUaxLVe1aJruEsrC0b6BMldTb9aem4=;
        b=kv5aJxhIFzIH+jy9yj+2TTy6b2jUgoi9rNv5sXvMPeO/c9wU1uwtEZ21oP9bXREv7l
         JEtsR1NGD6T7wmSCcuGtY1ZgKrvVq50qMsOdistegvTreyIslNHxiPLKoi6gLqj+gRL5
         lPcjwUkmzI8Nqm87SxO5tdsBVJEiSBskfwZDndJ4WL6JHbXbZi0NkD8lH6Hb/OuEReAf
         4/KhORRKSfk+ngSTlUVeaMZSkO2lmFNucbMGJPlXE8A6R0lM6qyWH5J/78OqR8hEhA6x
         khp2il3rWGlmDj/HpqoKN97flJEr2c3eKpXmXEqDdExcZcsjuNVqnnu/QFxIZCANPRKF
         t84w==
X-Gm-Message-State: AOJu0Ywzd+P8IkBdC01AWLDF5+Bb94B0+NFrKvjCK7S84RtGBymDImn5
	oCsiGIKP7SHYh5tM3oXr/8DZGNyf/g9muacvFZVDEvbztVyIIB9/
X-Gm-Gg: ASbGncu9AwVR7jmYiVyvBHwwBtWGhWnwvv+imBddEB0rIvb1I5mRSl2uvN7biPXObkD
	iJSYmUrkKJRSvT/Hz5W+Or7sooxuGHtdbz8aOKdCyu/tLkBuNv4WE9T1AYhSEEWuH0641iMb2k2
	ha1+0dQNlUcwUeegPrnMwdl1uuE71VhEUYrddM0kLX/jM9kQLeHZIe40j/4ZtVwd4kpIRov0A2i
	//zTdZzMX3rRfrSY7/eK1cPavx6XqipMCmdsIh6t/Hc5NTZuy/S8MEquKlgVVlZhPFo/73gDa4w
	hWy7e3jLG/U8yle3TXA2v4cGKtuN3IJGeu9sIFD8mOrZ8DDdT731Ew==
X-Google-Smtp-Source: AGHT+IEldZw97RgBCR+et5tlq+vptn7zbAMzZt83K7+cVKArImxu5UkAG9iKOkq02jxtsUrMMEkBnQ==
X-Received: by 2002:a05:600c:510f:b0:439:3d5c:8c19 with SMTP id 5b1f17b1804b1-439a3d07b0bmr955405e9.24.1739993386247;
        Wed, 19 Feb 2025 11:29:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398a44264csm82960165e9.25.2025.02.19.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 11:29:45 -0800 (PST)
Date: Wed, 19 Feb 2025 19:29:42 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH next 1/1] lib: Optimise hex_dump_to_buffer()
Message-ID: <20250219192942.1b579f74@pumpkin>
In-Reply-To: <Z7UPNhW_bXSOzACk@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
References: <20250216201901.161781-1-david.laight.linux@gmail.com>
	<Z7UPNhW_bXSOzACk@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 16:52:38 -0600
Nick Child <nnac123@linux.ibm.com> wrote:

> On Sun, Feb 16, 2025 at 08:19:01PM +0000, David Laight wrote:
> > Fastpath the normal case of single byte output that fits in the buffer.
> > Output byte groups (byteswapped on little-endian) without calling snprintf().
> > Remove the restriction that rowsize must be 16 or 32.

That lets dump_hex_to_buffer(buf, len, len, 1, output, size, true) be used
to format hex+ascii without a gap between the hex and ascii.

> > Remove the restriction that groupsize must be 8 or less.
> > If groupsize isn't a power of 2 or doesn't divide into both len and
> >   rowsize it is set to 1 (otherwise byteswapping is hard).
> > Change the types of the rowsize and groupsize parameters to be unsigned types.
> >  
> 
> Thank you!
> 
....
> > +	out_len += pad_len + len;
> > +	if (dst + pad_len >= dst_end)
> > +		pad_len = dst_end - dst - 1;  
> 
> Why not jump to hex_truncate here? This feels like an error case and
> if I am understanding correctly, this will pad the rest of the buffer
> leaving no room for ascii.

I've had a look at the code again.
The truncating error path would be: dst[0] = 0; return out_len;
But that would be confusing because it would be a truncated output that
doesn't fill the buffer.
This is different from snprintf(), so I think it is best to pad to the
end of the buffer.

	David


