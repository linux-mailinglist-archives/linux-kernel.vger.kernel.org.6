Return-Path: <linux-kernel+bounces-575624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A96A704F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437521884FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759B925B683;
	Tue, 25 Mar 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyqwfU7c"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976A1DED46
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916207; cv=none; b=HDTgSVa7X0T85jEgFyqe+hAOiWOm+PJ2HnOfzHuMIrE2xnbBGb8MR7G5zfSjr2bOj+XXedqYqpKEPSZCw5cFJjQzJLI0XumyDQrfBvVIyhHjSJ6gF+BlkwXtMQ0MPdNCCZn6gwF2grXgRyjq25lOu2GHtwf2xq21cz6qavln7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916207; c=relaxed/simple;
	bh=9JW6FJsTncczqcLVQiHmCXymUTVxTiXL/G5JrqR5tRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSmlN1/IPNYKp1ALfuSn+8Nq/DLlhXIEVYxt0Rq2v6hT/8FEx6k1pXC7fR27CsAGhKBJLtKG1XzN6X/xBoN4CuTeBYBqAH1puYYKMRE3Uak9zFZ3m0EwnZO8yQv8Xjj+cYhjFZiwYuVi4pnXnG99FUpjWoTmJmP82dsIaIB90Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyqwfU7c; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224019ad9edso43521075ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742916205; x=1743521005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDEUa/8k11B8sf0KeIB05SHGhO3FNf6wOS/GzrTKGyA=;
        b=fyqwfU7cnMYHf1bIJYJH2MkYqlMGUDrSA55fo2Ctk9cFoDCN7cMXQp8+0OwX4qrIXv
         fbr+F4I/L+cl3e9OTDe6cJNKDALYUO5nuJmNLbr1rWEM6FN8tJR5KB8Tv3CiMr4cTQvr
         KT+G3JO3MKiKcekwKOCRQbZuxP3a6upnQ3Awx4tHzcke0N7wGXDQwgZpKQo+yTiMD5UL
         LFEzZvFq6y+ixeBOCV/zFEb/v/c2kEvnTGoVXcKnTdvqvtYbb0hcnHO+ujJvGZg8VhIX
         WPB0FFoRA6KDy1+wLkNZRIyqvglsFneVrD9ZsmcWR7d2di2UxlLFgW1djCDaJMdni30/
         dtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916205; x=1743521005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDEUa/8k11B8sf0KeIB05SHGhO3FNf6wOS/GzrTKGyA=;
        b=fw8lXeN3LYX68gnvvwVu5qVX+PjvdSsgEdJ2lX+TR/GAabhrHyZO/UFgj6W3Ye1+ss
         qcF2LjH0gfiOjzvC2+H86xhzTBBAlyc6TnqUMKeAZo7jGW6JIL4qWvkXCFT+7x0+wbLB
         frKENnMk45eKQ2ucVpszLs88FSoYWppyK/W5ZMxAyuQ5SlIOoR2s7zCyign0/24ouwbB
         5UQIo73SGzs7eK+L1m0kX9Ik4G3CQdCJ0SFZOlm2v0YxvImwudOCHDYfHWfWWFSXrU60
         zmlCo/dfR8BQDeoDnBRH4Fl9FRQsLZysQUJ318yNrtHd1sRMtIbuQlzYkxAAKmFsVCWr
         ixeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAB1vIEkZe/0T2i9ntFQC133NMK+TwGRtvIP77ZweAwsma6hE0AKnCPnwyXHydhsXiowPi+VbJGuj/YDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEf4yiGVHA8Ve0HVIMicq5UN5gwkzMFcrUyO0+2NXRmAdWNCyx
	DZLLpuvmt5LhyH7AgkHGkLL3zU6J5RbtkyAJMIIlaBLX9GPyck65
X-Gm-Gg: ASbGncshf4BPlZpicC/2iVp5eghzZ1Uv/QMjVcw57R456gidXoztSrl5J90l7oblXDM
	MmYzD86NMsZr6n6SP14KBvlK1gpBlMpN8bz1xdnWgZfmVfUfY6NeWV4XfBRyIyTA0x0dyhNhCK4
	7TNBea+BDXTguqj3a5kUVikYNAm3M+68x9SJT+/WI6Wt2JKG9/jNoZ3xLw+UOUEvIrG/7M0aEVi
	nR7c87KyhxS83o4IaDCzc5aKckIdEMwrZyrq1jl46Eo+svClEG/blHpjZyI5CQ79z22Sl8JlDtx
	axZNg83Jt77fsqdPAdW7cMtmTKqNAz9E+Y7Y6sircHTjlk0kPv1Li3Q=
X-Google-Smtp-Source: AGHT+IERqjQ8v4TPmvjqLe2ZRM0h9caz3DbZCtwwWbViglyqvjOgOKurUBCP/tbe3Wa31BZwvLBCcg==
X-Received: by 2002:a17:903:183:b0:227:e74a:a057 with SMTP id d9443c01a7336-227e74aa5demr23766335ad.44.1742916205178;
        Tue, 25 Mar 2025 08:23:25 -0700 (PDT)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm91417135ad.27.2025.03.25.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:23:24 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:23:22 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v7 0/5] bits: Fixed-type GENMASK_U*() and BIT_U*()
Message-ID: <Z-LKapMBpMfJwcL7@thinkpad>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
 <Z-FsJPA1aq7KyTlm@thinkpad>
 <7e114fdb-0340-4a3c-956f-b26c9373041d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e114fdb-0340-4a3c-956f-b26c9373041d@wanadoo.fr>

On Tue, Mar 25, 2025 at 01:23:22AM +0900, Vincent Mailhol wrote:
> On 24/03/2025 at 23:28, Yury Norov wrote:
> > On Sat, Mar 22, 2025 at 06:23:11PM +0900, Vincent Mailhol via B4 Relay wrote:
> >> Introduce some fixed width variant of the GENMASK() and the BIT()
> >> macros in bits.h. Note that the main goal is not to get the correct
> >> type, but rather to enforce more checks at compile time. For example:
> > 
> > You say this, and then typecast both BIT and GENMASK. This may confuse
> > readers. Maybe add few words about promotion rules in C standard, or
> > just drop this note entirely? Doesn't require new submission, of
> > course.
> 
> I do not want to into this level of details in the cover letter, so I
> will remove. Instead, I can add below paragraph to the "bits: introduce
> fixed-type GENMASK_U*()" patch:
> 
>   The result is casted to the corresponding fixed width type. For
>   example, GENMASK_U8() returns an u8. Note that because of the C
>   promotion rules, GENMASK_U8() and GENMASK_U16() will immediately be
>   promoted to int if used in an expression. Regardless, the main goal is
>   not to get the correct type, but rather to enforce more checks at
>   compile time.
> 
> I staged this change in the v8 together with the other nitpicks from
> Andy. If you want that v8, let me know, it is ready. If you are happy
> enough with the v7 (and if it doesn't receive more comments), then go
> with it!

This series doesn't apply on 6.15-rc1 because test_bits.c has moved to
lib/tests. Can you please rebase your v8 and submit? I see no other
issues to merge it in bitmap-for-next.

Thanks,
Yury

