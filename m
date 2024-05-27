Return-Path: <linux-kernel+bounces-190836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE0B8D0344
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED9429F91D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DC15EFC1;
	Mon, 27 May 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/3JO/Di"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DA15EFAE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819256; cv=none; b=tHkanhRusk278dviHfCkqI3A5rXZzNTJ3TRw+cJtBY5Bzo/BwB5ov3ugjBFBJCwCDhnK5KCxIDtN+RyWOLLK1igkPhPW3qF8z+oIfR2zP1QmR0ZDQj28lUzOhWPG5DVe2bJh6wZdt4/kssYhWWHfv1qrOOkAEezFrikpelbgXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819256; c=relaxed/simple;
	bh=wS1BFxKWoEkKiNdSApsvB8JRUm9MZJzCp1jj637qV3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MO6MLeRp2+NKesnZefvah7ovp1NgzXdVNcwJ2PaubWypaKaoHtJd1G7psoHS7tQ/svd3PbCIqgB9xhLEKH8WS7MCuYMU+NEw/coz/SebRkNWhPS7ri5YBsMDpeprRgm08uG9qfL8dZAlrbmj28GHUeeBL8OrYgvNDsUzz3154U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/3JO/Di; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716819253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFzMZWvRCDrb7WkYa5wLatMYu1+RpvoRMJMjVnqZvBU=;
	b=b/3JO/DiCWuqT7mrNRNL72nKwG9RuveCwsU+yoyUDiZAKGoc/GkD8pIvLn2YIEnEltj9Sd
	vnxtWmH2XJhdoOHPpgS1lDt7vPULej2/ppwSU7CU9D7+hdiDPp9O75WSe/O8qON/hP2KsU
	9PyY/NXoO8QMbzlqRttfbqpI+SVtfYw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-M7tzZXrKOn2r6CETXMdE5g-1; Mon, 27 May 2024 10:14:11 -0400
X-MC-Unique: M7tzZXrKOn2r6CETXMdE5g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ab960d4c84so28206d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819250; x=1717424050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFzMZWvRCDrb7WkYa5wLatMYu1+RpvoRMJMjVnqZvBU=;
        b=vbfffZ7bXWX1D5dx25YUE68YXT5xFnEiUlO0UtJ6akhD+sBDYULUprRi/L5fiNDfuP
         oO8rLoNrEul9PXRZmZNydat46x5kxKXh2kryaz0o4HLd5uIcBeXJNCV0iTYJLkslEdb1
         KcEAQVuN6HWO5A/5PpWSj2PkFmsKDGzbBepHl/YEVBbP+jbO82Ld7U2wKouympitTxuN
         puvhrT2JhR9ltbPjmCeefotze33SSTrvXWjW5s0Wg95/oq5dbSHI5VxYZSy30BCQ/yxF
         YPSCzGsDGexAFT4l23RyescSeEYhDhjKFbc5BmJVC+yoKxBeSwPq9WkqcOYI9GsBXZTU
         kxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+fn7NVp3IlH/jifgszAVXsZVsjUKx6yt8pMH8vKnjuJtZWng2XTIRm2zWo9nGJTKGW0H7nYLHW9tDAtti3ROg83BoQmDBvysoOLpz
X-Gm-Message-State: AOJu0Yy2RW3gCwm6hk3tQZCTjiNhcmZs49bIFsdIZ8UuGL+m4A2l1dgM
	lAogh6D6N+jESzVrfRcadhRq/ILCkn0ofKVEDRzTDggCSy+Es8qT4toFHybzDDr9Lczwe8ete10
	6jDCfeCCLP7SqKJUs4t4DQQ84VKvo2rPhewS5ZQEoOiv+Dsic06IE+5ouHveb9kHUXP0xOA==
X-Received: by 2002:a05:622a:1a08:b0:439:ecc6:cdff with SMTP id d75a77b69052e-43fb0e50bbdmr106246811cf.1.1716819249855;
        Mon, 27 May 2024 07:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd8th8Wg469CYBTawHV9rsQeFuB8nclhehcyxMjGfWytXD5S2gp1EDIKK4hPSKKRLENR5EfA==
X-Received: by 2002:a05:622a:1a08:b0:439:ecc6:cdff with SMTP id d75a77b69052e-43fb0e50bbdmr106246401cf.1.1716819249131;
        Mon, 27 May 2024 07:14:09 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b97b5sm33974641cf.18.2024.05.27.07.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:14:08 -0700 (PDT)
Date: Mon, 27 May 2024 10:14:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 00/20] Reimplement huge pages without hugepd on
 powerpc (8xx, e500, book3s/64)
Message-ID: <ZlSVLv2JlsZS4f3d@x1n>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <Zk-bpBZ_yjsj_B2z@x1n>
 <87jzjj4y0t.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzjj4y0t.fsf@mail.lhotse>

On Fri, May 24, 2024 at 02:46:58PM +1000, Michael Ellerman wrote:
> Christophe is a powerpc developer :)

Yes, definitely. :)

> 
> I'll help where I can, but I don't know the hugepd code that well, I've
> never really worked on it before. Nick will hopefully also be able to
> help, he at least knows mm better than me, but he also has other work.
> 
> Hopefully we can make this series work, and replace hugepd. But if we
> can't make that work then there is the possibility of just dropping
> support for 16M/16G pages with HPT/4K pages.

Great, thank you!

-- 
Peter Xu


