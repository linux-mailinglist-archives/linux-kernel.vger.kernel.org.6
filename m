Return-Path: <linux-kernel+bounces-199535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9A8D8839
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A2EB22FC5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28053137C33;
	Mon,  3 Jun 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EHj+wR8m"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D113792A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437241; cv=none; b=RR6ha+PwIm4dqLN+LRDswLwXqyeSYQTN+Gm/ver5Q12K0kks5FlKwZIDMIVKyorwbkzwiwomgRqB//sF322IcFJ7aD2ggdl2joOJ6Y7oM+rv4rkfx2r3oM6Kv8XsLfIm5jSD17CXVuVIz3oc5GrSQu0sDjhcAsKJ27m2zDBCB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437241; c=relaxed/simple;
	bh=Jf4x2RR6woZIPEDJyKOfH9RQUVPwndCWhJSAfyG5+lU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwIDFac3A96zjIqwMEWoAUEu2IXVlQyYUSdALEOcwEMCsZ/6XHtTHJKILGcfuyKfbPZv1OS/pmXFaxuhcBEHO/TixCkQsFsUzV7zizmE7jzl0Yh8v3WonMbSd/1JBr6TcOQGQfWiyI2QlVE1ZJGiwGtV5xfYjB5UKVwURyjL9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EHj+wR8m; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so1300215e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717437237; x=1718042037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft7tNHscoXl71RZTa7m0RTk6n8v1oKLgnbYLQ9YMW9I=;
        b=EHj+wR8mzzgyoJj3Xb4ylBFbSX4uRWObN1PLUBCUVbsPj+2bx4dAMYNbtClpwyADXk
         ++iIQzKs8bwR/z1V+FBwYrik9I+oFl0x6CPy1Mfhyzvx4hf5Yznjbz0K2EcuiJJf4hFl
         1J82TIPDeuzXuqbtKU2hFsgps6CSEBQSd+xn7QT6SxSiUZ2Gj926rW5F5Zs/zShjRqkJ
         zAZ+BI8/y54Av246epbowU3Sl6ioj7SXKjFPSacP5FMPdX6kroh0w6BKsZR8cd5u0iol
         vH1mdF1WTam5qA4LIgbEogjV1H2VMWlkinIQYDbSoKmc8x8oYtNW4llxuDFd0W42VE8x
         2IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437237; x=1718042037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft7tNHscoXl71RZTa7m0RTk6n8v1oKLgnbYLQ9YMW9I=;
        b=f7uDeA4nqcKrfMYf7Y1tbYx0KirhBVcFCtqRvHu8jKC5zPtboQ1eoW5NhXuU5sGrkr
         wUWIlwDwo6BuOYW6xQcdWVF5A8AbgBIg0Wr/daq35k/NstUMPlMX8E9NMPkiE+vu6rXU
         KQ32DWw7aJW+AOTmCNaD1qspmDKrv/OIf9Ny6Cu/xy3KI76D1pB4p/0n0i+VPeCHiAnD
         S1k68YtwJVPChgtIDVb2HdTCY9uuQWmqxiTqL/u0IepZYdD/43q8BNf2Wj6fVqf91z83
         V4VhbfkjDdZPZSrQI1D3PoNlYYgRGkaMsYVSwvb9Qk0lzxD4GWyNKRu/j9yhA3b6rUUG
         rwdw==
X-Forwarded-Encrypted: i=1; AJvYcCWofYTWQMNrrOeiy/c5rvieAGtPpQJ1VTO8IPsra1v4HjLkC71/TxQW7LqrYwxyg7SpIKG/w1BRNGTEEa+CksYHkqdSWZaN3bAWK+nX
X-Gm-Message-State: AOJu0YydKGkbAWzLQMaQjdc38NIUjGJCQf3iJJAGb5qKCkNGi9LItjLZ
	OQuvPWxQeYITZDM5d//Z5yMBMIaBJrwEKd0Ytq++gBtSnXEcaAPOb7yNRY4DhGs=
X-Google-Smtp-Source: AGHT+IG/H9Qs/IQSRYkfHhZIy7FRz5dfSL/NilC/N/VMOrexy95bJJ1qqyY3QrxSqfHBmEWupdHOGw==
X-Received: by 2002:a05:600c:1c82:b0:41c:1434:f571 with SMTP id 5b1f17b1804b1-4212e0b092dmr74491145e9.37.1717437237527;
        Mon, 03 Jun 2024 10:53:57 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133e66ce0sm103144095e9.23.2024.06.03.10.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:53:57 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Mon, 3 Jun 2024 19:53:55 +0200
To: David Hildenbrand <david@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mm/memory_hotplug: prevent accessing by index=-1
Message-ID: <Zl4DM_4ll3gFnYLw@localhost.localdomain>
References: <20240603112830.7432-1-abelova@astralinux.ru>
 <3c2b1b1e-c9b3-442e-8f7b-5c7518d3fbdb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c2b1b1e-c9b3-442e-8f7b-5c7518d3fbdb@redhat.com>

On Mon, Jun 03, 2024 at 06:07:39PM +0200, David Hildenbrand wrote:
> pgdat is never dereferenced when "nid == NUMA_NO_NODE".

Right.

> NODE_DATA is defined as
> 
> arch/arm64/include/asm/mmzone.h:#define NODE_DATA(nid)          (node_data[(nid)])
> arch/loongarch/include/asm/mmzone.h:#define NODE_DATA(nid)      (node_data[(nid)])
> arch/mips/include/asm/mach-ip27/mmzone.h:#define NODE_DATA(n)           (&__node_data[(n)]->pglist)

All look fine, but mips.

Is it not dangerous to try to derefence &__node_data[-1]->pglist?


-- 
Oscar Salvador
SUSE Labs

