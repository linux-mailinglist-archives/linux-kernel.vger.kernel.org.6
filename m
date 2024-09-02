Return-Path: <linux-kernel+bounces-311185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2939685BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C271F212DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E6E1D2794;
	Mon,  2 Sep 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okewg5D6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F827185606
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275152; cv=none; b=Aqr90gSMEc5BQC8O59GpFJprZFbwvsstK6eob1YVs0fe/YyU/UE2BEpG/HXj4DH1JcE7LVf1Gx1N5CTWBTqXqTT7RpfuUSWLxqp4kUwKfY+peKlv6rqF5aI/deLSsVafL8irZ/sKgrAw3yKOYAVnJi0UdYDOkAyE+N1ce3fwKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275152; c=relaxed/simple;
	bh=VxuVaSn/smyBi/sHfBmDsHhzLLLx4Bn2FztZEj7UcD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHyKbceQAi2l0R+Qq++sZpn6ELNqfjAXOcC5M2RTPY8HOUs3Rav0ut2lEJD5jh3kCAzh1/76LjgrwVdz2l6TE12jQZaYDHMBfdGy8nZOXDIrdr2omt23j0IlN4iR74AbkVTU71OCpyXAjHbR6u3v7erOeeYuQOulKopQ+MLcJ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okewg5D6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42bbc70cc19so23620265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725275149; x=1725879949; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0MbDosZfxJo/aZ3i5uv8U4qMY9umFFTn/RczrTPOoH0=;
        b=Okewg5D65yTc+ci4Q9r9a7de3caUrTaLqkE6x0mIzXONiETjzWPqzhyQMw9DHuq3nq
         2jPjbGgLbM4Rdyfpk9tG4pdkej53lS3qXGSYn/UXG+Ef2j64XMo91yzxSa/9PphylzF5
         rzcBCTTfKclHP/RjunpjnxHVsqaYVK3kLW+t8WtSlykrGFwT2vPQyLRqUaMmS4sa4Kx8
         qx6naScKFBAtiMQPi5rUjm9TxGdVf9ju9XmZ5uEI4TqbKe4H51eQVPQ5wfq7YoZcjLf1
         H2+BQ1yBySweJXhKU6IDT2TlAN3pNldAynDYjawC0mKSKxR0RKziIxveEC4A5dz8p99A
         vGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275149; x=1725879949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MbDosZfxJo/aZ3i5uv8U4qMY9umFFTn/RczrTPOoH0=;
        b=HLRlG0GNPh9fTISj+g9ztGoFFZbh3MJDGlnYpDBVprz/G1o3HHwhIn9aNHeGzZI+Sp
         NChNShXWil4uqUF2AabFZF+5o8/jvU8SJwLh//e2uKAIIhYPmtsHi2kZ6WQv9l449OuR
         ZCOvbepcNtnXzaH9BQkHyIeP4OynFwqMrllKtmwDyZMHCiEB9MMDstaVJgYCgQaivsqj
         TVKdZDQM9zoixO+luLR8wf2Zz1QeuI1KwD12oteyA2JP6C0mKRr+UIaeR5wY6gLiblJX
         rCYtBTBh7GcpF+SrVRakge2EzN9S8hY3+GWTbLmC41C+tYlDCv1K8qy//3sWgnNH/iyT
         Y0PA==
X-Forwarded-Encrypted: i=1; AJvYcCVxf5WrIf4O55bJBO5OdNVTyL12SUMdPP92hNch4vQwdsBLBqzYS098FIYiB2Bw2V+g0M3OFHTdKe/cpDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfTtpuK25cgRod20asTTjycSgsCW6HAX4IB06sgxSz4144raBS
	Jj9ngI71z8S9m+GPImyqErmZ/egdYVVDnF0iKqcj/oHmlmWqsYX9
X-Google-Smtp-Source: AGHT+IFFvPqy/K9IaGXdZE7unN870y208ZCBIaOopV8deE+8afqsjNIUrlfSXYKrzyO9FR7H5AnxYA==
X-Received: by 2002:a05:600c:4e90:b0:42b:aecb:d280 with SMTP id 5b1f17b1804b1-42c7b5d8f4bmr43546835e9.27.1725275148025;
        Mon, 02 Sep 2024 04:05:48 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba639671dsm169799185e9.5.2024.09.02.04.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:05:47 -0700 (PDT)
Date: Mon, 2 Sep 2024 12:05:45 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Petr =?utf-8?B?xaBwYcSNZWs=?= <pspacek@isc.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
Message-ID: <53f4ixl6heo5yvhp7j2c7j4q7ftai6nztmpc22jtaj2u3og5go@4kmzjef43hky>
References: <20240830095636.572947-1-pspacek@isc.org>
 <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
 <82960a7e-9013-475e-9b80-7b29a5667482@lucifer.local>
 <5dca8600-0352-4b5b-acb0-0cd4f84733f4@isc.org>
 <mftebk5inxamd52k46frhq2llopoiiewsgdkrjbamg4yukyhqw@vf4jzz6lmgcu>
 <b8436b35-0c39-4471-baf7-ec9a07537f9f@isc.org>
 <2ff8d9c9-febc-4049-b79b-945efe8dcc78@isc.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ff8d9c9-febc-4049-b79b-945efe8dcc78@isc.org>

On Mon, Sep 02, 2024 at 12:37:48PM GMT, Petr Špaček wrote:
> On 30. 08. 24 19:00, Petr Špaček wrote:
> > On 30. 08. 24 17:04, Pedro Falcato wrote:
> > > On Fri, Aug 30, 2024 at 04:28:33PM GMT, Petr Špaček wrote:
> > > 
> > > Can you get us a dump of the /proc/<pid>/maps? It'd be interesting
> > > to see how
> > > exactly you're hitting this.
> 
> https://users.isc.org/~pspacek/sf1717/bind-9.18.28-jemalloc-maps.xz
> 
> RSS was about 8.9 GB when the snapshot was taken.
> 
> I'm curious about your conclusions from this data. Thank you for your time!

I'm not a jemalloc expert (maybe they could chime in) but a quick look suggests
jemalloc is poking _a lot_ of holes into your memory map (with munmap).
There were theories regarding jemalloc guard pages, but these don't even seem
to be it. E.g:

7fa95d392000-7fa95d4ab000 rw-p 00000000 00:00 0
7fa95d4ac000-7fa95d4b7000 rw-p 00000000 00:00 0
7fa95d4b8000-7fa95d4dd000 rw-p 00000000 00:00 0
7fa95d4de000-7fa95d4f2000 rw-p 00000000 00:00 0
7fa95d4f3000-7fa95d4f9000 rw-p 00000000 00:00 0
7fa95d4fa000-7fa95d512000 rw-p 00000000 00:00 0
7fa95d513000-7fa95d53d000 rw-p 00000000 00:00 0
7fa95d53e000-7fa95d555000 rw-p 00000000 00:00 0
7fa95d556000-7fa95d5ab000 rw-p 00000000 00:00 0
7fa95d5ac000-7fa95d5b4000 rw-p 00000000 00:00 0

Where we have about a one page gap between every vma. Either jemalloc is a big fan
of munmap on free(), or this is some novel guard page technique I've never seen before :)
MADV_DONTNEED should work just fine on systems with overcommit on.

-- 
Pedro

