Return-Path: <linux-kernel+bounces-524298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBC5A3E191
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43A119C2A62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EBC212B15;
	Thu, 20 Feb 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r63gGWT/"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2F211A2B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070329; cv=none; b=dz6vE6ZP8fefhPbuAdItG4Fd4+eNkoG8K/HcbHWXa6XcI/6CAZ7sLCWUq+gApQKMnA+CoHRF2swBW7Fadqs2mJ2/GAEn3wCRb5PSCtmTC/LnfEjoZh2puVgVlHqstt2QgTQdQgpzQmKzLA+RcWfNJakzDXenGBizzpU+iGQsXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070329; c=relaxed/simple;
	bh=tYdheaOLJdJc0aJkjKr0mWLYAbDjup5u9/8ud0zYRzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJpQseEWKN16LMUMiNDcgZKnOQmERBRI69SEos7xJAOuQh8pyNK3SEsLbQBf42rFE3kWgy+Xxwlw3gRhbLXrPMZZ8kP9PfbHW3fZh+L4nBaXuLYhd07hEMscn8+YraZIG3yW3pIKAK6O2GAqQRWEVNs8vcVaj5DtYDs8VoG2KqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r63gGWT/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be49f6b331so116752585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740070327; x=1740675127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wkopH+knUrz+qRGQu25YwgeMxQonV40WdBmq0oHoa/M=;
        b=r63gGWT/SFOpTCY0gppD4s1+CTNUf/uM5IWZvstpJewST70YQ/L3ezSpWUo9GudEQV
         noT8vNyG+m8GrqPRRAANIPATBcclm3U6NY1L7P3N1ruLhELfPzVdo/aNhJxjOQbhto+4
         ecGw5nhE/ExC1jcOVeSIhqaJ6s24r3n3rrFcHFGnnpMMlslVuO1h65tBPcrRWtmh7tXQ
         zwJLtsX3QsafJlJbxJVux1NtBoIT83q8sP23U4VDTgjk3sr4qr3wA8J+WrosPJXxFzKi
         yI/yPdmGl36jbjOMZGBAG33OW85U/HQ6BjMmI6htiLwvrPdWRI+vIFm0s3Ff0gHL5aK8
         GWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070327; x=1740675127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkopH+knUrz+qRGQu25YwgeMxQonV40WdBmq0oHoa/M=;
        b=nNAPtB7rjoPXqUgwxl3a/ehgLaOXx4usf6KAGVSdVPXcvSgyPSMO7eSYhaqcBxnIYW
         Im/FsyViseYLRwDuS5GHIU28vL8nP2xIwswX7VbHTLoKpxKrdzGkqyyIvyYAIuidR9t8
         3m5qRvO+ZB3i2FnF5tGzXpkvr2EPe3RHA+n2kUVQwVgyXh6M11/EbYhe0wg0FHNq0O/Z
         nNvKZEw3LJY6g+mYxz2FU5fyREWMkp1rNRtDjZSBeZ9fDE6p56U8oCkAybGS4iQrSYrU
         dkmtZkht5MJD4RlwHug8iv9OMRfjrP/amHbjrmT3F1Kmf9vNMVH67gWGwbEv9xylrsMw
         AwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWDbUADPXevdPlIwB2KbaPSNhpZ1o99gROENj8Xz62MU4t6DIU+H9Fu51j9qG3ZwJqa0o8kpkNff9URGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDQ6bXQ5wTzXN27quJTRmJPCOmPhu6NMn+3QW616eiXSilEWr
	r2usjhG1XNYb7aJSsS51qPwWQP9ELdMEklNSKPQm17oUDZoJ0iQkDO9pzGyEp28PL4453uscMNF
	7
X-Gm-Gg: ASbGncsGbvoseAd/5E0JEJhtznmanf2eDDy4q7JlvdwEOXQJSG3+6KpzZ9zSDb8ETIC
	10AVYrJAsoiAba0SB0aP0UcdDYDrpc4zWSBzocKJVQjQvanePfrxUMdXry1r5Bn6UUi15yiRhIP
	7bbIGqCNwuDL/fvM4yClnJ+EHjmjwYLhXvlBGw+7MvttscOZScj+Ghcemwf/T+5pPvKSJtNnjX2
	s6OJS2cwXMayYXTGnS/3/OUL66t7i8IZNpu+sajx/MRoHBQ6akMIOLazU6+t3Y5NKvwNt49D8+Z
	rXjqmQQPVqoH1uHkOzh1k7MDPtUcsT4bueeOFsQUW2Of/ExxhK8a1yZVzbmTIB4TdPkOm6y5dQ=
	=
X-Google-Smtp-Source: AGHT+IGrbP+VpZmpnhWBu0RWPNsSrk995l/NeBFAzZWBe3mWGjHaZI5IiPF3bd9fa2T2Eki2fBv33Q==
X-Received: by 2002:a05:620a:4054:b0:7c0:b220:34f9 with SMTP id af79cd13be357-7c0b2203898mr1475385785a.36.1740070327005;
        Thu, 20 Feb 2025 08:52:07 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09619fbfesm542181485a.18.2025.02.20.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:52:06 -0800 (PST)
Date: Thu, 20 Feb 2025 11:52:05 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z7ddtZBHx28_HIPR@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
 <20250220163043.000000cd@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220163043.000000cd@huawei.com>

On Thu, Feb 20, 2025 at 04:30:43PM +0000, Jonathan Cameron wrote:
> 
> > 
> > Example CEDT Entries (truncated) 
> >          Subtable Type : 00 [CXL Host Bridge Structure]
> >               Reserved : 00
> >                 Length : 0020
> > Associated host bridge : 00000005
> > 
> >          Subtable Type : 01 [CXL Fixed Memory Window Structure]
> >               Reserved : 00
> >                 Length : 002C
> >               Reserved : 00000000
> >    Window base address : 000000C050000000
> >            Window size : 0000003CA0000000
> > 
> > If this memory is NOT marked "Special Purpose" by BIOS (next section),
> 
> Specific purpose.  You don't want to know how long that term took to
> agree on...
>

Oh man how'd i muck that up.  Thanks for the correction.

I suppose I can/should re-issue all of these with corrections
accordingly.  Maybe even convert this into a documentation somewhere

:sweat:

> > you should find a matching entry EFI Memory Map and /proc/iomem
> > 
> > BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] usable
> 
> Trivial but that's not the EFI memory map, that's the e820.
> On some architectures this really will be coming from the EFI memory map.
> 

You're right, though on my system they're equivalent, just plucked the
wrong thing out of dmesg.  Will correct.

~Gregory

