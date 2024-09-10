Return-Path: <linux-kernel+bounces-322710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53428972CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A4F1C2143A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE002187859;
	Tue, 10 Sep 2024 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghPKJkmK"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8C17C9B9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958630; cv=none; b=QU1gEK07KYrrPm8Ny+OStzSwOoEIgo6uhhrcNbiLBMADX8Z3XZmyWh+bl8Vw4QluOHueuy0i5EWn1qOMf3narZf1GMqwapqpwElXBTijKLm2g+O4VLR8XhUpdu31hOxgtv5Q+JYVjCXiTx6ZCXnwB/c1BUOEgKxvlwPjE5s2Vzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958630; c=relaxed/simple;
	bh=e7O3GLax/XVAzocolL8EgfeWkjtN2OSWt42m8GCQlPg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiswljtSXV3CG0IAM2HAjMczwD8H8TNPN7bZAe6s+uwqyeFCvFp6tZrO4PNGTngrrVrgSmmHVqaRyenrV9/FpCkIQ5r684JyqJoLpKdsJyo8gqgjERRTTGqd2NVbKqjP5+tYTjaryEpkRJxpE/Yf72KXj3ZdN6LMN+Tt2u9mEjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghPKJkmK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f74e468baeso63759231fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725958627; x=1726563427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClddBKTpFhc9CnFInwAIwrp55e49LC20yixgnWvdO2I=;
        b=ghPKJkmKHdzwxkC+JlrxhydlGTffvcpPsHzuu4ZOFk/aYjNlG9HO9YXuYFVgfnzO+M
         QwCR6eflwG9d0ZDqfVMiS9/8HBDR4q/j1/wxtBEV+sIoOSxUaaK3cP0FkxdRxzxHboXR
         eI474eRj5vHWkTYUAygcrnG6UHnqNtuPGkECje1gMevw0AV6GSkJYxIVy7B1R7033o46
         uxK/fqvby0yWj+6vHfvRtp8hlOs7Wdp4aE+rK15xR5A+RXTuAWHdvRNL6hzVWWFcCiZf
         62O9OPLWjcJkI092EeAQAp2InFn8c6+qYRaF2nRfX0OxvKi/pC2b5rtYb19eIW1qLwFA
         7QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958627; x=1726563427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClddBKTpFhc9CnFInwAIwrp55e49LC20yixgnWvdO2I=;
        b=OasQ5C0Uc6R7YUOnNanYwPwj+UjyQb87xGW7ouBtC3mC1PL0w+kBWj85NcOATKVg+s
         bk+8pv8m3snIzrZry7rFe56A0X55a/fL85zzYQpidbh1ZW2Z5Y55bvdh0siZ/uLQXsQ0
         RixI7cBxrMmfuw1T32HO5W9G3ZZqMugS00Ys6+9gfguoLTTke/CM8hL+rQjb63TDDkbB
         b8PdoE1XICa2yH3QKvU5pbAaaEuvabABmkIQtFo2b1ZioVYy0jmXQ+QJf5PmCtKDGzLE
         FcQHACvDSaSunXdNT9g/GyH5GHGLxvhsf0gNaDyQxH4EgjkcA9QQuPjU+GLAixFwpGMx
         xrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV6yjTsAAseYLLg6rWnl3XNBIXJ3BI2+8b7I1c3ZyqByWNiCuZusJQLyLImmhcdQcAtIZmdExIMrXsYSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkMGWvVyIQvWMeJwno7GquR3Zg+SL+9b9vqXFLU/33+tk6maCz
	q9XoRRVF2gDu2xMXISRt0EmsFRQNZXe5Vl0jiv1055ncB7odU6oM
X-Google-Smtp-Source: AGHT+IGVMfPHMIIQj4j2shaIpBXWAYWn/aZbnyeKQoRcePoJuQDHvX+fcf4Lww69xHzmqkLALK/gsQ==
X-Received: by 2002:a2e:bc1b:0:b0:2f7:5a83:a90b with SMTP id 38308e7fff4ca-2f75b87eba0mr77099661fa.8.1725958625672;
        Tue, 10 Sep 2024 01:57:05 -0700 (PDT)
Received: from pc636 (host-90-235-20-248.mobileonline.telia.com. [90.235.20.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75bfe6ae1sm10930141fa.18.2024.09.10.01.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 01:57:05 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 10 Sep 2024 10:57:02 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm/vmalloc.c: Use "high-order" in description non
 0-order pages
Message-ID: <ZuAJ3lHh7XCC4M3w@pc636>
References: <20240906095049.3486-1-urezki@gmail.com>
 <Zt5j+c/SUNvCMY/+@MiWiFi-R3L-srv>
 <Zt815f8dHOKdAeiY@pc636>
 <Zt+ViveH9q1F+ShB@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt+ViveH9q1F+ShB@MiWiFi-R3L-srv>

On Tue, Sep 10, 2024 at 08:40:42AM +0800, Baoquan He wrote:
> On 09/09/24 at 07:52pm, Uladzislau Rezki wrote:
> > On Mon, Sep 09, 2024 at 10:56:57AM +0800, Baoquan He wrote:
> > > On 09/06/24 at 11:50am, Uladzislau Rezki (Sony) wrote:
> > > > In many places, in the comments, we use both "higher-order" and
> > > > "high-order" to describe the non 0-order pages. That is confusing,
> > > > because a "higher-order" statement does not reflect what it is
> > > > compared with.
> > > > 
> > > > Suggested-by: Baoquan He <bhe@redhat.com>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  mm/vmalloc.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > This looks good to me, thanks.
> > > 
> > > Reviewed-by: Baoquan He <bhe@redhat.com>
> > > 
> > > By the way, do you plan to clean up the rest of them in other places?
> > > 
> > urezki@pc638:~/data/raid0/coding/linux-next.git$ grep -rni higher include/linux/vmalloc.h 
> > urezki@pc638:~/data/raid0/coding/linux-next.git$ grep -rni higher mm/vmalloc.c
> > 493:     * nr is a running index into the array which helps higher level
> > urezki@pc638:~/data/raid0/coding/linux-next.git$
> > 
> > What am i missing? Didn't i do it?
> 
> Sorry, I didn't make it clear. I meant those places other than vmalloc
> related files, e.g mm/page_alloc.c, there are a lot of [Hhigh]er-order
> mixed with high-order. I can continue the cleaning sometime if it's not
> in your TO-DO list.
> 
> mm/page_alloc.c:551: * Higher-order pages are called "compound pages".  They are structured thusly:
> mm/page_alloc.c:716: * of the next-higher order is free. If it is, it's possible
> mm/page_alloc.c:720: * as a 2-level higher order page
> mm/page_alloc.c:735:    return find_buddy_page_pfn(higher_page, higher_page_pfn, order + 1,
> mm/page_alloc.c:2750: * split_page takes a non-compound higher-order page, and splits it into
> mm/page_alloc.c:3587:   /* The OOM killer will not help higher order allocs */
> mm/page_alloc.c:4811: *  within a 0 or higher order page.  Multiple fragments within that page
> mm/page_alloc.c:6516:    * page allocator holds, ie. they can be part of higher order
> mm/page_alloc.c:6790: * Break down a higher-order page in sub-pages, and keep our target out of
> 
I see. I appreciate if you go ahead and improve it further.

--
Uladzislau Rezki

