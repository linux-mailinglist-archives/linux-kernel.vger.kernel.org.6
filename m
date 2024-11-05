Return-Path: <linux-kernel+bounces-397184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CC29BD7C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABDB1F23954
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69E92161F7;
	Tue,  5 Nov 2024 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1lEmYIU"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2092161EA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843075; cv=none; b=moSXjgfi6kGKnQWZo+tN8/bQP+Cwrv0R93REiGHc0Ur9RSd5sz17OqbCdTiXjLb/ZtYPG/P6IUEFhcGRCN75nQo1s7ze65THJsWDkDbBI84EfcV32gvVFjUvqoOsnGgt3w0XOlUCHu5Cc3tLF7xPtn8dHCGWfDeqM+Lldg5r6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843075; c=relaxed/simple;
	bh=ElQX0glc7lwKuheiluiLjGbwTJ2UEP8N2/BYkCsZqVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg1CJ5f4zA4loQna52GquCnkOFfu4WUrywTXpHSDcRvQ508OFnXY3mCPJgznzcSg8cYqY+197Q/rYX3BE6OOXIAWY66kiqG9PND5ldxiIJ/lBkDQyvem/hojrORw6jt1RT3UKVW6EAom4BSLOIeBFa6wegRH4cs8nfo5lhhdxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1lEmYIU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c8ac50b79so43975ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730843073; x=1731447873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oLbfgRypN4eAv8cBDEtiqEYRjRnpZt3Ekt+N4Q9DIQ=;
        b=x1lEmYIUl/lkw1ZrBM/Fb8lQYeZWJ2e2qsPyrqwigXmYK+s/KbmP6KWsG816d0uYKP
         J5xXbDTkvTfNIdJGlFTwWQYwVga504nDEZWVaYRpBCY73xbyFlx/EH34wfI4ygveznUN
         I6XtVOU9yMlI7oNEZ7txC2YKWn645rHHzoebRkClmcGKTMl59I9En7P5K4x4EVtCQ5Ys
         O8Ld4qrqSw/qRrWKmt0v0I5JZs3htU2XWBsDS/h0xoLhlpcCvPn6p8wmEraHw4JYWSzw
         OwZ3hEly+IE+bC9LarBJqrz51K0Hb54DFbvV00c86iIO0ZlflIduABuyR51BoOFBkBXz
         OkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730843073; x=1731447873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oLbfgRypN4eAv8cBDEtiqEYRjRnpZt3Ekt+N4Q9DIQ=;
        b=mh6EbB10VYkkXW8ibSeyrmh7sZarabrxb6MZybyRyLchghA98kpNKZn1x8jNIez4yQ
         PVlVf5YK3Haukj6PNGf+ZRP2XfeIdGEy6B3UlCO0htwE/VyIcxUtK4AVCQH2u1vtJRJY
         B09ENKD6Ps95k4ItrbKarybhxXwKgXPiVdALUL1xeBZQlJdCq2v/8hT2wQ2pv8QomaLX
         biBYpNRgMbk4hFMLfhBuVr8Y3bykNuYzyQq6vpftd221UJqpqjFd/Qlgr7gUgk/2k9Wr
         zdrBUDmSVIkErOOlPr5aPK/Et98g2sLhDtO1Xh8alSleWvkIffaCYvs7fGR0m/3F7kKo
         2eEQ==
X-Gm-Message-State: AOJu0YzBbJiG/Rw7LboFZPdCYk+l8MIn9qJZ9SXfMPge0JYJ7yd9n+bu
	VM7svFXJaJloEFULvsf7dI2+DtUbDRGwBwS56AkAk3BYWcZ+YkgdpvCzht5Jyg==
X-Gm-Gg: ASbGncugBh3xC4MgmzIksDO0G69lXoYCXt+Pm227kZ+pfxrf8za7NCVAGWNeVPBYLCP
	O4C+Fa+gj3LFWRO8VkXtFIowGe8GsWZ30TA47Rcuw2tAAXi8f1Z+2Ox/1jO/cA55rQBk8m9kUQt
	j7zEfTzcgCvMFl87ALHaLx3nFar7pSu0CIXXNq0Cy0SNzYyUUbNweFbqqbcQeTanyKa1HBdbR5Y
	8mg1P4QenWoPIXOmclb5qwDoEZlrU8KRTJz3qeI5qVWdbijaywS+97j09OP1Ic4iKKQ+isSMT9E
	WyPsWtVqdIw0A/w=
X-Google-Smtp-Source: AGHT+IHmYaZX8ECh+kJzuRakdAFkRIX0exuqqo3tWsqagvGR+bxKyyCL3NfS/zhhdtSLsvizT0WPAw==
X-Received: by 2002:a17:903:1103:b0:201:e2db:7be3 with SMTP id d9443c01a7336-2116cf79bc2mr32485ad.21.1730843073047;
        Tue, 05 Nov 2024 13:44:33 -0800 (PST)
Received: from google.com (180.145.227.35.bc.googleusercontent.com. [35.227.145.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c4bdfsm10092330b3a.130.2024.11.05.13.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:44:32 -0800 (PST)
Date: Tue, 5 Nov 2024 21:44:28 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH 8/8] binder: use per-vma lock in page installation
Message-ID: <ZyqRvLlPdvKknbWE@google.com>
References: <20241105200258.2380168-1-cmllamas@google.com>
 <20241105200258.2380168-9-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105200258.2380168-9-cmllamas@google.com>

On Tue, Nov 05, 2024 at 08:02:50PM +0000, Carlos Llamas wrote:
> +static struct page *binder_page_lookup(struct mm_struct *mm,
> +				       struct vm_area_struct *vma,
> +				       unsigned long addr,
> +				       bool mm_locked)
> +{
> +	struct folio_walk fw;
> +	struct page *page;
> +
> +	/* folio_walk_start() requires the mmap_lock */
> +	if (!mm_locked)
> +		mmap_read_lock(mm);
> +
> +	if (!folio_walk_start(&fw, vma, addr, 0))
> +		return NULL;

Just realized that mmap_lock need to be released if folio_walk_start()
fails and !mm_locked. I'll add the fix for v2.

