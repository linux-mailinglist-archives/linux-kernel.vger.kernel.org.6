Return-Path: <linux-kernel+bounces-400094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D29C08E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EA52844EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594B621263C;
	Thu,  7 Nov 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJ8LmmHL"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B51F8EFF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989825; cv=none; b=WXvYFLETutmZV+ap5dG9HvL9JW/9Ne4IJzidlT8PM1/lmkfCfyWgtiw/KNVU0rKUkmssEj/I/tmFvTJiSNRo+VtrZAnxhfqR/l/RRG22bRJSq+NrVM2rktWAN+QvSPik4/4xghE6Wm8CX0o4976+8d2YR7dWqz7pAqDIoOSnOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989825; c=relaxed/simple;
	bh=TAEzMu+Gin5KjCOvmsrL+Snzm+CtcbZNBbO/cyWIm0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRxWCm0ZgdSC2AKJMkQzX7DBsw/qxx7F+UmeuCsnvfg8s/xyypo4dLSDrPxSQNmuKJ/tZ+Fmef/RfhuK4W7H+CAPryzNAUIQgD2NiQmSd16U0dhghpE5dJbvmIVDPK5sGfl7tSbjxD9p5BOKJpqsAG0N+JTcRKLiWWVOzgNHfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJ8LmmHL; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso243115ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730989823; x=1731594623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g4jj7NaM8ebNsLZnLFGel4o8JmTgydoOO7gZabyYqYI=;
        b=VJ8LmmHL3PejCAdGiAcgagzk+AFbFfu3IJYMhre5IBWVBSTbjb9YadEjjR2Wv8ZpkD
         1oR84Yf9HwLVxAfd6Sm1ZWXVaQVZcDBbdkGq2pGzkxn0xDbtIjCJEdDtk/JFjOT3c3IZ
         rncHX5rLZHU4kVh0RlGuUEeT7V1L0Z5MaAdOIN7hbv30i+MFI2JMdE/SkHdoOAyEbnjR
         mlbFujhfxvKuxsG9omdwqze80GE9Ac2PMo/8qJ8eGZ00FC8eDBTZmOOdkRKIvy1o2wHd
         kt74qQemEejoYv9KwsWW3Bui28tYv0ktli+uBjjfmv3p9utlHD45KFTolsy9o0c1y5mJ
         QoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730989823; x=1731594623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4jj7NaM8ebNsLZnLFGel4o8JmTgydoOO7gZabyYqYI=;
        b=WeR8lmzbtOroj28hytvGCLYQHBgRzQs6KzBHXtQkQq7+CA85TCasep83menaHbvIvq
         zhq38peXH1qLUFeZjoXYOCtg7DZqxgyII4isU8ZInvJFZ3Uz2HBOdKjUu/jTT+PM+I1T
         chRbi6p5p3aN0MK5Y3gvAjLokGiUS0gKopoc6idD2A9zrm08mmDkUdvUrrQvUhzz33IW
         GX4ubHtnmZTiTsefMKWDanjufPIXgwUS23+yPqo3JanQoIL/yaTK/+GYG+ykAM4A2iM6
         A1TRnFI+2sa9gtNLPFXzJxPxvA3V/CjJzN6kwh4jPekNgXD9eaYt8wDUq2Ey2FCrmgzN
         t8nw==
X-Forwarded-Encrypted: i=1; AJvYcCUsUZJXazZtTaO/Z+G0zD4xewyVb96gf5H34sC5fcShIShuLHv6HFxol8FQr0ikVUPm3886LyzuTu0rH2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyff/eAZPYfoF7Kz8W/8yXwWmQ7n5elBJjQs5OKbWNP9We1rzAq
	JVhVh5AqDLJ/YagnkDhCCZTeWHqCqQkYbG1UXj1SHmE1ZnR9OjIq6pcq9GFX+Q==
X-Gm-Gg: ASbGncvxYH0EO1Z3bRq/iV/sqfAI/nQfKVt7Xv2g+KRPn9ZzIibZfr4wa+d/QN00N4y
	jX7hkeKwoRWMhzWrilyP31Lj/RzuSICMbWACRtISCa4YpgwuwfcX+ETOIXl8YIKgl1gY5svziqp
	k6OtvPv3F3YmzqzvrNf450hZHHn0urcz61gZTehIwbZbRFCZHKGEXb2L8rZli90+eAT00slyAiE
	BlveLl3XTq5cWPC/ap4udD45aiG9kgOCb3depH2D/jtmPD+t2v76I9jyczwMA4rIAJO4Bv6rJnp
	ev+Kotcgqm1jyqM=
X-Google-Smtp-Source: AGHT+IE5xkk5xcfZQG6k2w7Yp5qHTNWB+BlI4rkftFRMvcg4wn1XqKUDUPxuKa8K+2RkiUayjPDnoQ==
X-Received: by 2002:a05:6e02:b46:b0:3a6:b8f5:7166 with SMTP id e9e14a558f8ab-3a6e7a31954mr4512975ab.12.1730989823089;
        Thu, 07 Nov 2024 06:30:23 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5ed9eesm1485806a12.48.2024.11.07.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:30:22 -0800 (PST)
Date: Thu, 7 Nov 2024 14:30:18 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v2 1/8] Revert "binder: switch alloc->mutex to spinlock_t"
Message-ID: <ZyzO-vbufELmBlvf@google.com>
References: <20241107040239.2847143-1-cmllamas@google.com>
 <20241107040239.2847143-2-cmllamas@google.com>
 <2024110742-setup-clothing-44b8@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024110742-setup-clothing-44b8@gregkh>

On Thu, Nov 07, 2024 at 09:56:16AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 07, 2024 at 04:02:23AM +0000, Carlos Llamas wrote:
> > This reverts commit 7710e2cca32e7f3958480e8bd44f50e29d0c2509.
> > 
> > In preparation for concurrent page installations, restore the original
> > alloc->mutex which will serialize zap_page_range_single() against page
> > installations in subsequent patches (instead of the mmap_sem).
> > 
> > Cc: Mukesh Ojha <quic_mojha@quicinc.com>
> > [cmllamas: fix trivial conflict due to 2c10a20f5e84a]
> 
> Nit, commits have the full name in them as well, not just the sha1 one,
> i.e.:
> 	2c10a20f5e84 ("binder_alloc: Fix sleeping function called from invalid context")
>

Sounds good, done for v3.

Cheers,
Carlos Llamas

