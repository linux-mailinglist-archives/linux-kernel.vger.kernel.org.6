Return-Path: <linux-kernel+bounces-260167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DAB93A40B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AC31C22BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35E15747F;
	Tue, 23 Jul 2024 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjmklzQ1"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3D153BF0;
	Tue, 23 Jul 2024 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750076; cv=none; b=jU4dccdV1g6FbrFGdd7U+lyHftbj7Xg91Q1+cj/z/sd6fcY+7a4YuaoRANnXzv1AydwQiE+XC30PpwOhjszdQNCoAUKuetdijnuYP74WXlfF230Cy4UXjrafoTQbr2H4YTm2n6K7Snw5hfpMB+DzrWtKlzkeuw36GQNEMzl7r9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750076; c=relaxed/simple;
	bh=FKFKtr/hJ7Um8vWOR5g2yMg7qzkrQwQ6jKd2dq5sfbk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIzf+iJ2oN7aZjVx1fqGEJL4ROQO3wxOEnt2soViu3kjP94FmKXeziFjM+WjBzlaVmKRq50f1eq9O80+Z5rTF7gq1QuWdqiw5jGB8IXnlMp1QFzRSt86V+SJDVjB8i+1U2dkd7BBWuKTsL9mF2mve9Q//fQH/AgKIW2FMzWkInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjmklzQ1; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so70651811fa.3;
        Tue, 23 Jul 2024 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721750073; x=1722354873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hN5MWX/60s+ZgUnHG8u9ko8tdnOJvIZCPJKPPu7gqQc=;
        b=ZjmklzQ1LHQJhWqILGIOCSbIVI5mMiuJRDjATQ9WjuYJrXDEA1DUyxn0+OaPJ7KvvW
         zC+5EneHQO4QIgh5XBAERq4ooCQ4U1TnMfpoFoG0UhADP4WQoQCZ9kRuxW9Rufq7sdNb
         VfS2FsQoHCqnwWyI1HrrD3zwkkM/Wm3D9/Lwr3mXMs90mAfN/LRsSCdXs/L+F2z1ZPVs
         VFfNC4/R6SCZJI8t7m3v+v126XwHNX8s6folnS/Dv8Z9PCCKodq/ceS55sUphwZUc97u
         4aC2yjqXhyvLnDmVSgx5Nu3PdQz9UUdzG+K4Te72ec5Coy87hiiQoJ11nRGsRvDOoEZ/
         qskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750073; x=1722354873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN5MWX/60s+ZgUnHG8u9ko8tdnOJvIZCPJKPPu7gqQc=;
        b=qYAwklAr6F4g2KaV1Fp3fYms0A4iTDA3hk86FmT2JsiyzFZ1o7F7ZxhhFBXxS2CHhO
         a2L0B29MPtkjo9fqdFMWsCVkEIgm+sLSFqjXBXRxchpVJMsS9tqbeWIl7EQc8pt2i8RS
         rUvV60hKB+K2upVRUCC9bo+nPqdGV4WIrqNwvNGK+SccEc1CGVFREwu2uAFcvMRcE5vN
         V1bbFcoqTpR9l/W7ArzdVSQ8x21i9/MrDLRNjm4LUAtHHaU8CqVPk8bD3KYUBw1czMv0
         3ynLSjuB11zGJh0Qfm1Y1+BLBVPSXI8AZZ4iemc7pYmXyQPZp1Xeqy6CRKOYZ2DzpQoS
         /1tg==
X-Forwarded-Encrypted: i=1; AJvYcCX252icoXP9uKx+fQfWR4pxK9bdInImleafdqvtsBTrq+N/zOMdriq7Lmi3nZ5lzzuE390vuoV+JGqrm4vwsL/iWmEee+VechieJCIkwKaPNZbl5wCwNFBuf7ei2Vtfr8e3/Mkz2aqg+84qqQQ=
X-Gm-Message-State: AOJu0Yw1MUjWAK5bJk7E1Tu3jPzWHhMJRISKjJdqJAGNPMTVk6y6hgeX
	mw8Gp0rRHzxZw1orSBuV5uhK8x2onBUEjsfRZwnbyHPvtddrk407Xl4CEbm/
X-Google-Smtp-Source: AGHT+IG1Ejxe4WLjGMg0aa+mr7riiCjVtx4+0iTNKzxSFLR8rPR6ORx4FmZpAVke8WypnQJxQr7A2w==
X-Received: by 2002:a2e:998d:0:b0:2ef:2e8b:1802 with SMTP id 38308e7fff4ca-2f02b98c5bdmr2037711fa.31.1721750072345;
        Tue, 23 Jul 2024 08:54:32 -0700 (PDT)
Received: from pc636 (host-90-233-213-186.mobileonline.telia.com. [90.233.213.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ef0fcfebc0sm15995001fa.102.2024.07.23.08.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 08:54:31 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 23 Jul 2024 17:54:28 +0200
To: Christoph Hellwig <hch@infradead.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
	cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, kees@kernel.org,
	ojeda@kernel.org, wedsonaf@gmail.com, mhocko@kernel.org,
	mpe@ellerman.id.au, chandan.babu@oracle.com,
	christian.koenig@amd.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmalloc: implement vrealloc()
Message-ID: <Zp_SNMaCBzonjpcO@pc636>
References: <20240717222427.2211-1-dakr@kernel.org>
 <20240717222427.2211-2-dakr@kernel.org>
 <Zp-T4F42tk_aKKc-@pc636>
 <Zp-z2IWwGtIH9O4p@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp-z2IWwGtIH9O4p@infradead.org>

On Tue, Jul 23, 2024 at 06:44:56AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 23, 2024 at 01:28:32PM +0200, Uladzislau Rezki wrote:
> > Concurrent vfree() will lead to use-after-free. Either add a comment
> > that a user is responsible for not using vrealloc()/vfree() on the same
> > pointer concurrently or use find_unlink_vmap_area() which might be more
> > complex when it comes to design of the vrealloc().
> 
> You can never use *free concurrently with *realloc.  I guess it doesn't
> hurt to clearly document that, but other than that we should not try
> to cater to that use pattern at all.
>
Agree, i mentioned that as a first option. I think, it is enough to document that.

Thanks!

--
Uladzislau Rezki

