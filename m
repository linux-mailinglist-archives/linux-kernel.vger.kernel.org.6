Return-Path: <linux-kernel+bounces-340752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78960987769
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014AFB2853B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF422B9AA;
	Thu, 26 Sep 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX7poXu9"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B9D20323
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367421; cv=none; b=p7AnC2NZDjDo0C47dA/x/q88m9dXo5PWevG49yKUiYPwrgO3RZFzOIfLXD/Is9ZTCXJXAEjvsxXLwydU+SAcS5mT92URcWEXqoae79oTFZwMg0Eu0shnhSD8FF5N71FylhR1KYK0JDkQZQG8xx6QcUUouTYDo/LnBHnLtN8f5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367421; c=relaxed/simple;
	bh=YlAF3jjd+pwhFFXWo3UdbiJiIPCsho+DZaX00IyxJuo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cqcay7DE6kUQwVqrI4H6KBt14guVGS2zyEX2M9oYgtlkuXpNpLlqVd3UymqY1tJmLlXq1nJskbpVvrKHrA03Agc8bQip6CXMdv4I8pV8hMXgsA8+uIYpUwdsqhhQMkrP6q1UIbqIcWFfyV2ozRgE4tEgkeMIgq1gnJturkmRzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX7poXu9; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-535be093a43so1504398e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367417; x=1727972217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFxdlhcT77M863PodHeuS0sWay6s4jC4n9D3lU8otZM=;
        b=mX7poXu9+djLcdSJGknS8vrMQP0g02PCwKbmi9X+BUxElIc+3MLtu7Lr6c90luoSyC
         M7FmaymgW86yQFix4CMSn8+Y+5YQZHyxiphlL0QWgKMxB27tXDgGdumbMxPbRnD/CdJ2
         1rr49ZV5cCQzmNY60JttUhCERRSok8ZCllp51+yHfY4XYHjQfmCIqTIiaZP1CS7DeII4
         39UNbe1RBjxUX82qITzrJHXZxZFh/NiM49vJgffEa5MIEBnfnO9L3mAjnG/uoS+ggh4Q
         +J8ORiXqrzFyM6nC60IqwIFQGMECHRXUMg9sb+CLByGV82EMDPy6kOCAZSUcarvrobdp
         ZyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367417; x=1727972217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFxdlhcT77M863PodHeuS0sWay6s4jC4n9D3lU8otZM=;
        b=dyUSIu3V5jh772wY8tmTzQRlxf8yH8cZLphBgI0Hh+HNxihn1iklpYhrmA5XOTG6LN
         d2fAWkkCBkclowEYqbui8fHQtG7BGPgKGk0Ihnu0QpPKno3rY9IPtsvQzub/OarIeq/5
         JCQg3y/nQjpZ4JdwUqnUOfUKyQVlFG4cpEVby4m1XLPQGtM+lM/lL8V5hzoOn5Q8FnWf
         0teB9nv53NpIU1QoKir+xfKZjn7L3EygoReUexsNXgTukUs6sahVl9UkdRWkBRCOBRRd
         7UlWAvruYv4PBuME+lH7YLnTHYeE8TrfciGbIMORK2HX50w6imghKwsG1UcmLOssNceI
         A0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZQjCez2exgGov/v7+R65V25AHVxDg8/7iTQyMYMFCW0Jlh29lTI4Z6LDkMH/6WH811D+sNzLE5oODTeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8OLPzt42ohvVxUmzUsOLKeFpbisbWbnsttGGBZjsxoHF9tN4n
	hv0us9aMmQwZEAQXhsD7iK+im/IvLJR3DRxt7lUVS4IIFEqKXS0c
X-Google-Smtp-Source: AGHT+IFJG+LUX4LyeIlwSMzb9cU5f4G7jXtWZ+RF3CQ2HkNVECY8KRkjL2vmR7o6zCLds5s8uWP3Yg==
X-Received: by 2002:a05:6512:10c4:b0:52e:a699:2c8c with SMTP id 2adb3069b0e04-5389fc64385mr118423e87.45.1727367416312;
        Thu, 26 Sep 2024 09:16:56 -0700 (PDT)
Received: from pc636 (host-90-233-216-205.mobileonline.telia.com. [90.233.216.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a0441777sm1359e87.274.2024.09.26.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:16:55 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 26 Sep 2024 18:16:53 +0200
To: Huang Adrian <adrianhuang0701@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Uladzislau Rezki <urezki@gmail.com>, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] kasan, vmalloc: avoid lock contention when
 depopulating vmalloc
Message-ID: <ZvWI9bnTgxrxw0Dk@pc636>
References: <20240925134732.24431-1-ahuang12@lenovo.com>
 <20240925134706.2a0c2717a41a338d938581ff@linux-foundation.org>
 <CAHKZfL0D6UXvhuiq_GQgCwdKZAQ7CEkajJPpZJ40_e+ZfvHvcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHKZfL0D6UXvhuiq_GQgCwdKZAQ7CEkajJPpZJ40_e+ZfvHvcw@mail.gmail.com>

Hello, Adrian!

> > >
> > > From: Adrian Huang <ahuang12@lenovo.com>
> > > After re-visiting code path about setting the kasan ptep (pte pointer),
> > > it's unlikely that a kasan ptep is set and cleared simultaneously by
> > > different CPUs. So, use ptep_get_and_clear() to get rid of the spinlock
> > > operation.
> >
> > "unlikely" isn't particularly comforting.  We'd prefer to never corrupt
> > pte's!
> >
> > I'm suspecting we need a more thorough solution here.
> >
> > btw, for a lame fix, did you try moving the spin_lock() into
> > kasan_release_vmalloc(), around the apply_to_existing_page_range()
> > call?  That would at least reduce locking frequency a lot.  Some
> > mitigation might be needed to avoid excessive hold times.
> 
> I did try it before. That didn't help. In this case, each iteration in
> kasan_release_vmalloc_node() only needs to clear one pte. However,
> vn->purge_list is the long list under the heavy load: 128 cores (128
> vmap_nodes) execute kasan_release_vmalloc_node() to clear the corresponding
> pte(s) while other cores allocate vmalloc space (populate the page table
> of the vmalloc address) and populate vmalloc shadow page table. Lots of
> cores contend init_mm.page_table_lock.
> 
> For a lame fix, adding cond_resched() in the loop of
> kasan_release_vmalloc_node() is an option.
> 
> Any suggestions and comments about this issue?
> 
One question. Do you think that running a KASAN kernel and stressing
the vmalloc allocator is an issue here? It is a debug kernel, which
implies it is slow. Also, please note, the synthetic stress test is
not a real workload, it is tighten in a hard loop to stress it as much
as we can.

Can you trigger such splat using a real workload. For example running
stress-ng --fork XXX or any different workload?

Thanks!

--
Uladzislau Rezki

