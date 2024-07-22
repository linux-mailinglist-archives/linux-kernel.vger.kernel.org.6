Return-Path: <linux-kernel+bounces-259274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8DD939351
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8731C21550
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3248416F0D9;
	Mon, 22 Jul 2024 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXpngcBG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB616D318
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721670746; cv=none; b=NRqVFX6HDN8H/JezIStGB/PGR98DvrEJRUfqC1UmGq0TPMsTT4rk8hmSdVuns3HgVD6nq/R2eIH7lfHTLhNrdILnUiT9GhaDE+s35d3BvHPNGblqjfaVRPg0crDxnDRse2E/wdcJguwThkd3eIaUu2pxTOcs3gaXfid1zB4UMqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721670746; c=relaxed/simple;
	bh=je3BOS5JKkQ+J6ZBvGqL0EaE2MrQXHfiO6bf0lLAQXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/HBz1iO7g4V0Ms5OmxydmgvkqW2B3jdZBBqLz4DgB2tPWNSHu80ip8e+dAU97u+qIWWa3uUZPpqNYb57emEKalktR7SKVsdSJ3J2AZTkdkOLgaTNczi/oD4rmHB5AZ1fSjpMyYuSthCr3FJiY+piA5Eq5k7e3VPUPgJRQpo64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXpngcBG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso27392995ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721670744; x=1722275544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8H1pDCmGySCGRl1gIUJ/4C+Z1BCsXQ3ICifUIskDw4=;
        b=RXpngcBG0oQObdd1kvivcLnKc1HGVBKZv0RLZVI31A5Y8FB1o6SLqBy9kvZfdzCEQr
         8gs8DSDsLca1167+v+fdTacyXjG+9/h8j7QGOtaHhc/8cdrYh8RgrtLfR1pfEwJ0NvqY
         3EIzuYIea8mWsodel9iA0zTjPsfgWeCIczwaZhzAkWU0dc3Qd/2KyB4f9VbFPQcdzdL4
         V1htojWE3rBgpB/1kmKaI40EN911fTZC8EOWh0WAouNu5GC/dpUiezCXJUNRELdwk3x4
         Me3+KuydllZiRjb8g3fthVFspO2rj+NkmrLKxUsTuQ4eJfOuWUzOlfucKtI0L54XYsuy
         Pmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721670744; x=1722275544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8H1pDCmGySCGRl1gIUJ/4C+Z1BCsXQ3ICifUIskDw4=;
        b=AWcqyJk/i0dBOLyoRVaI7SlxobRQxZcFqdns1dlWsqxOqyEsfuXW1bzyym2JQbuacI
         RaTDNp/iy77YWKmvmxcS9xhHNV1LnNMVrjTaExRRWnkqZI1EG2XzSKCgy1vfdZL6YLlq
         ABAj7ahrV9D49VTosAA0/EpcyPWqiXOiLXhBaNd42TpT8mlDwSUf+RWcNv4LsKbhEgnO
         KXB3gQ1MiIdBgAEosZBFeNAvIbHkbLkytVNtddT+WpRneNxn45mtcyL7agJ/pm+KyAxP
         xJB9fYKcLW8F/WDgVwpNwCE11hH4wHacwdU4CNvkYJq43zvHNarMTpzjSnlyNVaUL1cd
         6iRA==
X-Forwarded-Encrypted: i=1; AJvYcCUEJN/Y5GrgXE9LGRA5FnKtWJJ18ykZnBZDINGPiojcC9vRGqCsp2O/yPMJRhRMxc5IukKpDjolG2LueBje1Jo5Q50TTZhd/Qyk2QCf
X-Gm-Message-State: AOJu0YxB4XPGmypij/Tu8k8suGAu/8TQkDGulcATKYMrpZZyCa9RCvHN
	EE6rYRt05EGH7y78N6h+/qvSFuOetOWyWAGiXwqB14pJY9k2BU1O
X-Google-Smtp-Source: AGHT+IFvaw5S9BVXgTqGeEVg+R+dGHoF2WCukfAlPmBJGv5XsrOt33aHMZ4o5pvjoGjnzEfmXGKPhA==
X-Received: by 2002:a17:903:41cb:b0:1fd:95ac:506b with SMTP id d9443c01a7336-1fd95ac51f0mr26766915ad.64.1721670744351;
        Mon, 22 Jul 2024 10:52:24 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f316d0fsm57840575ad.165.2024.07.22.10.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 10:52:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Jul 2024 07:52:22 -1000
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
Message-ID: <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp6bMoDnUMxNrKos@boqun-archlinux>

On Mon, Jul 22, 2024 at 10:47:30AM -0700, Boqun Feng wrote:
> This looks like a data race because we read pcpu_nr_empty_pop_pages out
> of the lock for a best effort checking, @Tejun, maybe you could confirm
> on this?

That does sound plausible.

> -       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> +       /*
> +        * Checks pcpu_nr_empty_pop_pages out of the pcpu_lock, data races may
> +        * occur but this is just a best-effort checking, everything is synced
> +        * in pcpu_balance_work.
> +        */
> +       if (data_race(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
>                 pcpu_schedule_balance_work();

Would it be better to use READ/WRITE_ONCE() for the variable?

Thanks.

-- 
tejun

