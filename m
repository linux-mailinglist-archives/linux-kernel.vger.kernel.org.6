Return-Path: <linux-kernel+bounces-259284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D59939385
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229931C215BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951A16F0C2;
	Mon, 22 Jul 2024 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEZuOZ8J"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65616E88D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672144; cv=none; b=ajwPY0C9ckuht6ypUU8Sr4EAi746JBSVT9IbxqkqpWBhwP4eROcQj6LNlI3ko19dMtrn5iTSV+kYQCaiBoDWmpByRQFlJAZfee3OT7uno8g0b+jLanQpzzpOxtp/GzSytQWUuTrCeYzRoJYYgZy6OMrbxoh/DWA4sqxPtWuJT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672144; c=relaxed/simple;
	bh=jav95XNnmKmffO2quaMHjVzZ8ifo10whe7Uz1+kTy1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoMHEVnuBgmhOYv59rpm4SZUNOolXtWJK8WcLsAM0GuRfG0I7G9w3DXnOKMf73EVPfsVOToWPi8NISJMKTUgBHUZsGGY9BpLeI+BsAbAz3yYDsiAm4a+/lU3a2EQDWihIqHcdApUcZZTgDAjALHfez5sjKakPzoeT+uZbxsDHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEZuOZ8J; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2485310a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721672142; x=1722276942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2ccprAgCrF5Nw+4sYBOwRItdPUCn9FZWwH6R8A6Krw=;
        b=FEZuOZ8J0xiBXrmvBIvu/GTkhG8QZumSZ1N7aYhMzDmbl67C5Jzwtpvk5LGlPizOew
         koInZGSNe6ZcxafZvOqCcwanbmpb/4lsajFQTF6azKwL9sj+HY/CuMKlVHSZnQVooZaa
         srvmkXv6NzEuR7C4/dNNPCyJtR6JDfagXaSUS2J0IqtE1VKN6LnUwsfX3k/ergkI8FBz
         wcopcHUmqdcAwozv5QlKbGErhlhojC/o9304Axca3XXNF4TIOw5dsG8rGMZH+XYuCPcx
         7aJQWKGGoO3POoVhF05W11ZnifLDBaWfWeyYQ3+tVkLZn9P7ON2KRvmcvoh0p9p1ho98
         7poQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672142; x=1722276942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2ccprAgCrF5Nw+4sYBOwRItdPUCn9FZWwH6R8A6Krw=;
        b=sZUyqssNHsaVn8ztKVR8T6ra8hj8DRvnPPx3Lq40Mx4M6gLx95CIptiWqCvvApcTks
         PKfl9zdDkSZN4DeYjPti7oalXijK+bLAV0dTkGlHjZwsOu1XsEeoYYcrPLkxDeifkXYK
         PsSQP/n6/Zdij3gqcbthD0Q2iNV9NJil0uQjYRhcI9BXM151aNvcMzc4kUbHHloFxYYY
         Bxj1B/zFYUc3lFdV5CUoHo9B1BqjxRGyzaD6fTfJo2Rh9Bo49mA+iZSHOaKogI1dH2lf
         fq53mHFZmpbkFADIBmqjP2UG2rs87HToCVYOa7fpekeZ7zb6yNGMMuUIlBVbzuhXe037
         E4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEmMRKtMV2qkc0lunjSTaPAI3XXAIpIChmxs88lY0BbkYHZC8TTpkUNLz2wBq8kO50ClcqyBoH9qOeXrAHNzryoe4ndM5miWik5rqZ
X-Gm-Message-State: AOJu0Yz65d9MxUZsnoFTd73zrkAGPCO5sRRqDu0dM3TrDzLY8qIovQOn
	Uou7rZm3YZBpjbAhe6RqnNaWkHY3UPzNoNw5m0tujroFHtHo4dKl
X-Google-Smtp-Source: AGHT+IH+O5dRqhifq5FCrHGRke2OnkO93BjMMqZPL8+7xkKr3+Z/b2vHKp1sy/in751R1wn0qbQOqA==
X-Received: by 2002:a05:6a20:6a0c:b0:1c0:f17d:d81f with SMTP id adf61e73a8af0-1c4285d4cb9mr6302396637.21.1721672142242;
        Mon, 22 Jul 2024 11:15:42 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2c5edsm7366670a91.3.2024.07.22.11.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:15:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Jul 2024 08:15:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	Suren Baghdasaryan <surenb@google.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Christoph Lameter <cl@linux.com>, Dennis Zhou <dennis@kernel.org>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: Re: [linus:master] [mm]  24e44cc22a:
 BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_alloc
Message-ID: <Zp6hzP7g_3nLOLfv@slm.duckdns.org>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp6e1PWZbz4pkh9Z@boqun-archlinux>

Hello,

On Mon, Jul 22, 2024 at 11:03:00AM -0700, Boqun Feng wrote:
...
> For READ/WRITE_ONCE(), we will need to replace all write accesses and
> all out-of-lock read accesses to pcpu_nr_empty_pop_pages, like below.
> It's better in the sense that it doesn't rely on compiler behaviors on
> data races, not sure about the performance impact though.

The patch looks great and I doubt this would impact performance in any
noticeable way.

Thanks.

-- 
tejun

