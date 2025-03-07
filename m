Return-Path: <linux-kernel+bounces-550250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1963DA55D28
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5279E17614D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78AE14EC62;
	Fri,  7 Mar 2025 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="CG7dZZvq"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DE18027
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311367; cv=none; b=AQjl54J7+6QNYav0ahDTw0yKp15Uq7BDeGSnPotfgoRXYlEFOgSHpd+r3jGe7LWzMnYs6tJiB5gTVppM7SeXGFthWh8vkYNVD35v88Cj0QvUoQEkQn7O26dPe5dkGWhu+41bjEK8NrQm4oXW6PV16zBm1zVQJv1sNAX5GfyoI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311367; c=relaxed/simple;
	bh=BVRY6tFruoswUnFPQ21OUmD/QgS6sdmyxv+4b7sgmVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0QwMBeA84eBAIkSdxGPxtYbiJzN93eSKCIz1TT03Fy/E5c8gQHtbHsuZ4M5ebipleQUv63d5JkHOWBJ9cJ/lZXGP4xURgp3Zrlf6oK0jf/G3bw1CLyjne8d9coNUNW934oJh1OBIOmAarFaMyFEWnPWHqGQeWUSUbNE6YFedwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=CG7dZZvq; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c3cb761402so255429585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 17:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741311361; x=1741916161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1axXD7Ty6zHgaHZGIlmJ4iSvajQDuxDvhtrMSh28go=;
        b=CG7dZZvqPxmIk8pZAQutd3HS11YO43PNx+EPSWKjjRztHhGg2GYYhJHYfNwGo3zGqu
         rbhyIRi1XMKvraAZ/jmmnNoA0ai91Owz9wcY9Dcx4xarcYKqMtDeaktDrstCF8pH7hQM
         +qSThfx1/dERpSZ/+D8G5JlnjVvvY3q6dK7boKkbqVrYSh4bA8FmWntcNGNCxcNu7QP1
         wxg9aixqpiMpTN9INo/bParKeqjgEy/xTPBddFJZtFsma79VOii7SAufLoWsp1jhqut8
         DWkBoPyXHg5lQtI/09nkLwrhjjMCQTT8kk5c7sRcOqKqNel0CLjdqyYalFCfk3xQkT+u
         JhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741311361; x=1741916161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1axXD7Ty6zHgaHZGIlmJ4iSvajQDuxDvhtrMSh28go=;
        b=jvH1OEf2GZMrzj8HrPd+BP0AdJ9G9O3AKlqn1cG5TFc5pO6aEoKB9GS0CPZoTf5huE
         vG+OtfN2tqb3GXHm6iIWjkGaeT3AOBpCnxp1Vsv/3eNHGR6Nt4IR4JHzkrj4rTUoYRSw
         lcl6l32uGv4BJNzsrfMPyjYaxh2OHSyVL52yiy5DLc6UzMRDCzAzUpDAZT7cnJTQ0zIN
         ew+hZAKhe21jPi5f+kESTbOk/0S+idjrg1SxuK3GBOI56dzLSywKOe/75isUDkOfzEwU
         CAIlqDMKZT21TlPrIXQeUcHD7M8M3VqLW7j/FAajVjDYiDls0RcAWtFUup4QzGxIji7z
         Q03w==
X-Forwarded-Encrypted: i=1; AJvYcCUE5PnSxPh5Nj3kAQTLl4rVi2SpnjxGIyqNdsTmSRLe3r1FrmDM/zO6Oo3wixE01E9Bahu5OqWRDLG/N4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YylzS9cCaTXOim8Fjzmc+LGde7IhfErtApyadjY9tfO0NF1pSjJ
	kSJKozvbjXe8Id2mOj1Y0kr3x2nm+1uAl4A3cVsWc+l9FxKFwz0NIJ2n9D8+kmA=
X-Gm-Gg: ASbGncvXuIs9Owls5Aayx7XIuV/IVmk6g4hCNsVNvN9HTZqYi7dfAU04rsplo6wkZJl
	7Mngi+hiSu1GYiok790or+k71b4BA7CNhPbssmb4gPsI4A8WmBvi+Yy86c80l4/zP1ig/cbOfKr
	mvfM0z6SP3wN+esPP1wIWo6Zvs+L2Ilnsbg5B1JqUFPPgiue6I7OOSqG7PlvLQq5ReoHE/KtWhn
	ZGickna4mpiCqB3QZYicAEwtVZnlCIfj06twFjzshjRb6jAPaLTYqdGzHW5y5PN7XsYFTycKa2s
	l4J6tmdfdW6V9KH78mFdoAbyu4JtQHAaBeW4s7TVYrI=
X-Google-Smtp-Source: AGHT+IE4fUtCg50WmjJd54wCtiMGccA2dFbqaij+Sd9VqfL03TwwvKXFnADFHg2JGi7aDAzHdcxQGA==
X-Received: by 2002:a05:620a:6a87:b0:7c3:dfc7:e8fd with SMTP id af79cd13be357-7c4e61121cfmr198986585a.30.1741311361230;
        Thu, 06 Mar 2025 17:36:01 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e533a0b1sm167758585a.10.2025.03.06.17.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:36:00 -0800 (PST)
Date: Thu, 6 Mar 2025 20:35:59 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, yosryahmed@google.com, yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] page_io: zswap: do not crash the kernel on
 decompression failure
Message-ID: <20250307013559.GA423735@cmpxchg.org>
References: <20250306205011.784787-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306205011.784787-1-nphamcs@gmail.com>

On Thu, Mar 06, 2025 at 12:50:10PM -0800, Nhat Pham wrote:
> Currently, we crash the kernel when a decompression failure occurs in
> zswap (either because of memory corruption, or a bug in the compression
> algorithm). This is overkill. We should only SIGBUS the unfortunate
> process asking for the zswap entry on zswap load, and skip the corrupted
> entry in zswap writeback.
> 
> See [1] for a recent upstream discussion about this.
> 
> The zswap writeback case is relatively straightforward to fix. For the
> zswap_load() case, we change the return behavior:
> 
> * Return 0 on success.
> * Return -ENOENT (with the folio locked) if zswap does not own the
>   swapped out content.
> * Return -EIO if zswap owns the swapped out content, but encounters a
>   decompression failure for some reasons. The folio will be unlocked,
>   but not be marked up-to-date, which will eventually cause the process
>   requesting the page to SIGBUS (see the handling of not-up-to-date
>   folio in do_swap_page() in mm/memory.c), without crashing the kernel.
> * Return -EINVAL if we encounter a large folio, as large folio should
>   not be swapped in while zswap is being used. Similar to the -EIO case,
>   we also unlock the folio but do not mark it as up-to-date to SIGBUS
>   the faulting process.
> 
> As a side effect, we require one extra zswap tree traversal in the load
> and writeback paths. Quick benchmarking on a kernel build test shows no
> performance difference:
> 
> With the new scheme:
> real: mean: 125.1s, stdev: 0.12s
> user: mean: 3265.23s, stdev: 9.62s
> sys: mean: 2156.41s, stdev: 13.98s
> 
> The old scheme:
> real: mean: 125.78s, stdev: 0.45s
> user: mean: 3287.18s, stdev: 5.95s
> sys: mean: 2177.08s, stdev: 26.52s
> 
> [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

