Return-Path: <linux-kernel+bounces-212056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89639905A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F643283AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208238FB6;
	Wed, 12 Jun 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIuEIwte"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C281E39850
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216258; cv=none; b=swDeifl9JHmdN17ozDz0pVDpKQ9jq/j1HFULaJIeZKdrp030mh6b+YfiDXRhBgzFL1Z6JNvKeNyzdz+Ya8drsYHzihpKCiInhiAJkQmliM+RDfWMlFKHPTqJm8ETuvQ0RwF3oKNbB1SEesdhsAdJSWiKc7TTMIHEyGm1juB6LV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216258; c=relaxed/simple;
	bh=xL3+DxHueVxNcGjS9DoJdMlypFu+8gEr+DYPDIImfvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hhn95sgd1vCDg/qaimpMHfr0a195IgcpH2R8gudvxDrLoILN0NHRW13DvUlv1srb1Nl6qZ/vAX7X55PgQ/C/qowYeN17tijdoq4aViED0qOUi+Bu8ST32vWkKI6PouoehUcGqnuBwx8SV/blPZGuMB1tNSoKbZl+g5KQ2NTLxL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIuEIwte; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718216255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GqA13ytTLcnfwlSXiRjUjwQTSf4tPyM9TDOKZsA+jRc=;
	b=dIuEIwteqhuipb8CAYm7ShOetSFDurP3hoyyRo+cyMbU8sjvCUBuvhQ0Q8rL0mIsXBwOz+
	m0/cUm3mfew3yKWEWEo4HlRCz90N3PuGqfYM7Ka9xsDnIVYHZJ2mD97rGe+m3XnBdCEQ81
	bs1k149qmmCQ1aJyqNR3NyOAJ2wfSNU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-BQ5yYc4wMs6I4LuG9cKx4w-1; Wed, 12 Jun 2024 14:17:30 -0400
X-MC-Unique: BQ5yYc4wMs6I4LuG9cKx4w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b07a472e83so128256d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216250; x=1718821050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqA13ytTLcnfwlSXiRjUjwQTSf4tPyM9TDOKZsA+jRc=;
        b=dJneahTQ2Erb6R6MGusNEUCpbUf9M7wXd1tFZpqNKFLboBbHaxecG8md1pyvDj9o8L
         wGLmExFMQdkKYjXRXQDCau3617qZDB6MlKxpzLu5mDNiCDkIvjDwE3h1b4zWpbd5Rw+o
         VJJSRyownSMbA/X0qAb7JKPYDj94DiHgJ+35YiyqyAgrhruLXj/Vph+cThi9uQye6Vif
         D3jea8Q7KiRXyEeMGeqkZN9dYaIIf6wfqjO4lRSn+ICJCpNX6rbjz9K4K/5Z+NkSS/wA
         1wZZh0OZ3f1GafMSVjudFrSAtph6LQoA2RFI1GJf24WwLr0N1VCaF7MrIIm6cVQAJt1l
         vevg==
X-Forwarded-Encrypted: i=1; AJvYcCU1ftMkhPNjQHdV3p9Iuca1kxpduO5cJQycZQL9HdWzYjq6IGfhEbM2wK5ZRR068Lc92YDRbBISqbo12cBBrhQMzP7iUVcBAsGbkKxh
X-Gm-Message-State: AOJu0YxEQ3FLQthYUObu5HhrMCK9/mOqrpMCaE7UVgke8JlgOlvU2Fkd
	iotkVEbpnklzw4ejCVHM2wxDUoHsNr0zEF3fQ6Nh/o8TVSTptGuICjz8lunkQ2LfR4J8+PRnucf
	lpQ7F9iJIdqiTaVrx6UlUfa0jGB41CIS1DyflfxpaYeAO90Kav7udYGq7v5ElXg==
X-Received: by 2002:a05:6214:4113:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b181fc80e6mr27323186d6.0.1718216249734;
        Wed, 12 Jun 2024 11:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcepddSBq9ALMMQ1l2XGESLpYVN1dQ8vlxOzhMMc5HHfQ+STDhJxpYJxtBLqSFjBzHrkgzEA==
X-Received: by 2002:a05:6214:4113:b0:6b0:6a38:e01d with SMTP id 6a1803df08f44-6b181fc80e6mr27322846d6.0.1718216249210;
        Wed, 12 Jun 2024 11:17:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b08fe54d5dsm16847276d6.34.2024.06.12.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 11:17:28 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:17:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set (2)
Message-ID: <ZmnmNkexK5CGacN9@x1n>
References: <000000000000b7b11a061ab49122@google.com>
 <20240612104735.ee6405d2096236bf18c51a41@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240612104735.ee6405d2096236bf18c51a41@linux-foundation.org>

Hi, Andrew,

On Wed, Jun 12, 2024 at 10:47:35AM -0700, Andrew Morton wrote:
> On Wed, 12 Jun 2024 10:18:21 -0700 syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=146b3d96980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0b56d6ed0d0c0c9a79dc
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > ...
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 1 at mm/page_table_check.c:198 page_table_check_pte_flags mm/page_table_check.c:198 [inline]
> > WARNING: CPU: 1 PID: 1 at mm/page_table_check.c:198 __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
> 
> 	if (pte_present(pte) && pte_uffd_wp(pte))
> 		WARN_ON_ONCE(pte_write(pte));
> 
> Let me optimistically cc Peter ;)

Looks like this is the same issue that the other patch wanted to fix:

[PATCH] mm/debug_vm_pgtable: Drop RANDOM_ORVALUE trick
https://lore.kernel.org/r/20240523132139.289719-1-peterx@redhat.com

I had a look, and indeed that patch hasn't reached arm64/for-kernelci
branch.

Thanks,

-- 
Peter Xu


