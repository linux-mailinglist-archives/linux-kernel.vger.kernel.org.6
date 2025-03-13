Return-Path: <linux-kernel+bounces-558728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B5A5EA13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9763B5502
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C13136658;
	Thu, 13 Mar 2025 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iz13WBx2"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4127468
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741835368; cv=none; b=HmOv5v1zia/+XOYHIhldVnjMVNJr7DFv92I2nelZx2EJ2dwIhfguAszqUU+po85dKYFMvOHgBpk35lxqc+x6hU6TmtLWh2Gx4jNAvwSCAkx92KWSYNPW6F8GbIm5f+OWoftkbKoIJ3NqNRdmeVST1kX31okEiRirI+BIAQG1hno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741835368; c=relaxed/simple;
	bh=+WFlGMAcg1dSYyKmxTCSAfJCHc1g1MepJvAxDiPw50g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm6086oHt4Ap31yGEEDZ3IbZfN59ciPzkSO67ihc5GP16pT1OfxS+GewYUeBGeyVQoPTxBMrUZEimShs0EbYVQ9GQkootLbr28YsRqccazKrc9EczjzLI/e6DxgEltjD+i4Ug5kVEvRNsCDSPATAWsx9TiGCWQBmWQoUa9cM4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iz13WBx2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so950594a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741835367; x=1742440167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2w2NNoyeUMTe+WJP3vOV4lxBW7OxevPqpMtYOQZ7KSQ=;
        b=Iz13WBx20soGyVCdjJoO4Hw/0zhDlnCSEx1nQ8vWgQInJ1ZdmnaUB0yKxYWbzTxqvS
         k73sHBNXqv87XktOLNuH53xsaUvvrdFhmuT4u6lkXgtvtfeoVbEfpmgH8z9BEaTgxBNg
         y46EuVtGH4SgrLQh7x3STtlYPY+URROwP0yRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741835367; x=1742440167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w2NNoyeUMTe+WJP3vOV4lxBW7OxevPqpMtYOQZ7KSQ=;
        b=LWThc+GEAP1G+lH6FR3oZMzTnZQqsQUQ28sZL4NrLbzVh8+y6m/5XhsduH6M5WrIi7
         CLxW6qVZkJBuIwYLFPadFdVVp4vPhmm4VIFtWeU7y+t1lqqWO8gxAghhD10ThDpaHini
         y7bBGipgETDc5pj6E4Fm4hRLDoHHCwezNHrqZL3IADWK8xW8hvCSYsz+jIniA7tPFZ8r
         XVSsXyiXYpZDgGg5fjIWJm0A8L3o6Fi++dgC/MsYtLdB/rv98AY+dA/UxfjY6OptjhRQ
         Gf5fsjpkJvSEaBlxEA7xD17zpeOG8bjcNd1qw00DYCwMIyA6tPe7HqEKTGK2kFqdbtuE
         hdCg==
X-Forwarded-Encrypted: i=1; AJvYcCU06f6PBfSKk0M4cnJJY7qYYZGUuNgo6K/jN/Bvq0BNoArNgeQE8e4OHys74IX0TptFS2O3Kbx70YUGauc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwItornW35Mmh48y1v3kiZcb+5VsOK9DhKmKmOq+dx1QLRhBW
	WeeaekFX4wJZMoRSxFBvEbTp5tw9hTOPXPll4Uqn0hUrH8Ymad1YCQ86Jk/ggg==
X-Gm-Gg: ASbGncudgR6tSfEzl5WU+vgKu08CtiqaO3q4ibygJA2j98u3+/ZBRS7aU49VtugUQoE
	gArpM1QUqXGgdPZscQOIuWMY5flAEieHfZ+cGJIZwNnJoc3weDZd8MF0r0LDNsULykR6VyVOdyt
	FjyUmWRZ20Wr5PRKUITekOw+ibFJFGUPuEcSmlMlI1xfQV6k59f0TLWcePHAoKlM8AKz9XK++hk
	mt4IR1TKJLKswH/zwHzxZqQl+3WISfas6btHo3KO36AttO/JW2FBPnbig/h3/dr1RzqGON+3c7e
	S7uGNRTFH235JL4hXOugv80kvRsgkD+E2zcaFJjMtqG938w=
X-Google-Smtp-Source: AGHT+IGFWO2nTLQPYrZdNHWAUjr4TV9jgOKxZGHY6bU9yRm/owksjVUBeXx/Vr3GQFVpil54DqonnA==
X-Received: by 2002:a17:90b:2f4c:b0:2f9:bcd8:da33 with SMTP id 98e67ed59e1d1-300ff10d6d1mr11929540a91.21.1741835366628;
        Wed, 12 Mar 2025 20:09:26 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ef7a:848f:3b9:98dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301302a8995sm848639a91.1.2025.03.12.20.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 20:09:26 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:09:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>, Jens Axboe <axboe@kernel.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Barry Song <baohua@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Subject: Re: [PATCH 0/2] Improve Zram by separating compression context from
 kswapd
Message-ID: <5gqqbq67th4xiufiw6j3ewih6htdepa4u5lfirdeffrui7hcdn@ly3re3vgez2g>
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <Z9HOavSkFf01K9xh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9HOavSkFf01K9xh@google.com>

On (25/03/12 11:11), Minchan Kim wrote:
> On Fri, Mar 07, 2025 at 08:01:02PM +0800, Qun-Wei Lin wrote:
> > This patch series introduces a new mechanism called kcompressd to
> > improve the efficiency of memory reclaiming in the operating system. The
> > main goal is to separate the tasks of page scanning and page compression
> > into distinct processes or threads, thereby reducing the load on the
> > kswapd thread and enhancing overall system performance under high memory
> > pressure conditions.
> > 
> > Problem:
> >  In the current system, the kswapd thread is responsible for both
> >  scanning the LRU pages and compressing pages into the ZRAM. This
> >  combined responsibility can lead to significant performance bottlenecks,
> >  especially under high memory pressure. The kswapd thread becomes a
> >  single point of contention, causing delays in memory reclaiming and
> >  overall system performance degradation.
> 
> Isn't it general problem if backend for swap is slow(but synchronous)?
> I think zram need to support asynchrnous IO(can do introduce multiple
> threads to compress batched pages) and doesn't declare it's
> synchrnous device for the case.

The current conclusion is that kcompressd will sit above zram,
because zram is not the only compressing swap backend we have.

