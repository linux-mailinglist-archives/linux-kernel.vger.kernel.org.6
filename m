Return-Path: <linux-kernel+bounces-337774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25919984EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBAA52831E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C84B1865F0;
	Tue, 24 Sep 2024 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUtoxRov"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA11862BD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219489; cv=none; b=UVAOONE27e1UvyDS1j8vzKlK/4efVzKc8tfhAn3R+e6Qycg5xET7jPeSk4vz2e6kp9QvZkshPkyGcwTEBRdI1+iYOabUvsPFI/bH/TNnFjVwC+hBkmhR8BDnqtCJZv+sz4JQg6TZH/VHWzqO8PzpO5sQjPLr0MCTk1HISPZblwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219489; c=relaxed/simple;
	bh=X4YxdapzFsUU6pJkx2qk0xWXAV0G6R5KU5lOJSZjDJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmFXZg9YQkjapzJMXI5enz2vVcyhqdI9TFXIfL7/115w+hxnzcm6WJSXblaW9SwQco+nwk9KVeM9Qh9nA6d139Iy+8cF4Euxoq2Zz8kY1m+bmjjDKBPjRqhhlwB6uLwHXflH5r2mfUAVsRV3rYm2GpQlO6r6d6NFwBs4FiwBX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUtoxRov; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c34c2a7dc7so40451506d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727219486; x=1727824286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rZRTN22GVeTXjjYCrCBFgvO2TrIVhxxPF4nOlAMLMU=;
        b=BUtoxRovs+kXNreDtKTlR+slFEnHdSlbvqN0Wc6N+JtJRQHdM5ZRDaDYcLXINZG9fb
         LEOg2M9Ymn6NNb4l5pPwRCviI2cGbcyPFcsqlv9yFdiKyVJRbVKVXJPDZNUkV2Bp0vUw
         O9WlTKDbR1Q9cIukLvDhqViN2mGVWtmyjGU3tQF0KRPcBp/mtiMbmTCU0xtIA/IeUDWh
         Op/YnOegd5L4wUUDpHUsjGa9lCyWF3Qh9HqrJOXP39HqL5iwnJz+nNhn1hZv8Vj637MS
         XG5OwOt3tcSYRJLO4lfOxUCZYu2CONxUOKwvqADfQJdyjBaGOaf6Jg9QbOcySX5bUCp1
         fWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727219486; x=1727824286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rZRTN22GVeTXjjYCrCBFgvO2TrIVhxxPF4nOlAMLMU=;
        b=WLeo1DmpHvZeESOdP0RyRPTTk/1E1dLnzJqyvfYBQgcVRKWywi9wuEJQeWcrNF+72w
         V3iZS8pkzFXXmVFe/R3AsQrhAbeg7kIKT//XXiKap4x62fug7ZMKM1ThmndKDoBlXIA4
         x9NFeaC/y/JaCQbPwEwuUTllOGDHy28TZFglTz4puuZk9AgMbBThfTaCq6NKm7TRMzSF
         41GImZWZrCai53S4vkdEQxkgwdZnxnINxRJ3iCryEA4u8Dv98BN/qsibhhJKyxkHtKx5
         GSSVUzvbOd99oFxs2tCI6I+FP1OhA6H7L2vv3x5NrcNTJgpAcJBmtOjvCfKjgBUN5yyx
         Zoog==
X-Forwarded-Encrypted: i=1; AJvYcCVkK/XETmoFqia12S6sFWNDWp3Y0TXQCYRYahHT8vD/OWYa2eewIus7EErSnbJlDUeDplFCklTEaMwiyGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYlvr1JQAYCfNOd05NcA9drTF6ii4SPLm3r/95UcsBy++OBkq
	OLYR6h4sH/TFEwfdPCEKpkny4h2Vz4jc2BaehdqRNm1P0s9lzEyf4EhHWW6XjugB7XtuZ3Ry/Lb
	EXBjLDcK8uz0nyZ2eCicqwlfxcHE=
X-Google-Smtp-Source: AGHT+IG7su5eKcB2yug1KYtbxnX4YH3diGnU98W5SlFjFSNwN7XxF2mk3bDfxfvs7a1XD4o9ZwCRnz1dDKQm5dYUDJ0=
X-Received: by 2002:a05:6214:2f0b:b0:6c3:69be:a3e with SMTP id
 6a1803df08f44-6cb1de9a6a7mr9112386d6.43.1727219486252; Tue, 24 Sep 2024
 16:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <CAKEwX=O4PJmLRLog3NGzy+r6+1XTXs_r9Nxs73CJeFeN0pcr+Q@mail.gmail.com> <CAJD7tkYCXexrP_2xjXqFDpJALCgi84aA7wGOo=6mfuUSpMO-ng@mail.gmail.com>
In-Reply-To: <CAJD7tkYCXexrP_2xjXqFDpJALCgi84aA7wGOo=6mfuUSpMO-ng@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 16:11:15 -0700
Message-ID: <CAKEwX=OsL10kywer+FkhBSQ3FK_-bkrQLqErZy-hGMWsRjmZrg@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com, 
	joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 2:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
>
> We can also do what we discussed before about double charging. The
> pages that are being reclaimed are already charged, so technically we
> don't need to charge them again. We can uncharge the difference
> between compressed and uncompressed sizes after compression and call
> it a day. This fixes the limit checking and the double charging in one
> go.
> I am a little bit nervous though about zswap uncharing the pages from
> under reclaim, there are likely further accesses of the page memcg
> after zswap. Maybe we can plumb the info back to reclaim or set a flag
> on the page to avoid uncharging it when it's freed.

Hmm this is just for memory usage charging, no? The problem here is
the zswap usage (zswap.current), and its relation to the limit.

One thing we can do is check the zswap usage against the limit for
every subpage, but that's likely expensive...?

With the new atomic counters Joshua is working on, we can
check-and-charge at the same time, after we have compressed the whole
large folio, like this:

for (memcg =3D original_memcg; !mem_cgroup_is_root(memcg);
     memcg =3D parent_mem_cgroup(memcg));
     old_usage =3D atomic_read(&memcg->zswap);

     do {
        new_usage =3D old_usage + size;
        if (new_usage > limit) {
           /* undo charging of descendants, then return false */
        }
      } while (!atomic_try_cmpxchg(&memcg->zswap, old_usage, new_usage))
}

But I don't know what we can do in the current design. I gave it some
more thought, and even if we only check after we know the size, we can
still potentially overshoot the limit :(

