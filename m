Return-Path: <linux-kernel+bounces-560456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD38EA6047B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DFFB19C3272
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81681F78E0;
	Thu, 13 Mar 2025 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA98R1Sl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBD22612
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905495; cv=none; b=KTs2vyJ0MhYaxh7KvHLI7cBN7cKLKAOBu2a4G3QdxVVf//sJwqSgfkFcFURNT5l2Gkxt5h+vPz1qNxLdNnc9MO1Dbx77F2KWI1dIVrkDcIWT8hRr/nKb5EZ+fdeU0i753FPdmGoCWhAkFsf6y9cftQw9STPdbFC3tKxfgk51GRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905495; c=relaxed/simple;
	bh=DSWQgIJ7FXheJ8gYzjYJfYWpUIUUzmSGNhkDx6tGNEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTMKhbP1r8ePdUqe0rnmtZ3SqfJWsKtcHEvTH+HeplPgEi7/0akJp5mG4/Fv08z4YYJGe7a4Sgww0B0PeOWvd74L7J0EJQqQhIE6ciBItFA7Ny1RJdfGayX6iMxygB2R3sB3H1kE0tO7USq9p850T5Ee505MuXqfQhUBZw+IcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JA98R1Sl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741905492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aFzr4WLi5EWJd9Q1lyDlYMS58+KhEJhXt4VWqBCulsA=;
	b=JA98R1SlWlV5Tg2+6aQ3PLxtAUHBhEcsJzfxNQOk+BllZXsShBDiCm3ZKzkys13Aw58upT
	2bga0eRAqoeXgzxwokxIj5i+rFBoEy7jHLmek6Z4Y0NXa51oK2RXmE/Fa3QP/AvTATedJ5
	P9WFIW/5yXQTudpDSsvOTpKH237WgzM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-6DQxyzBrP0mA6iQF-qlHfA-1; Thu, 13 Mar 2025 18:38:11 -0400
X-MC-Unique: 6DQxyzBrP0mA6iQF-qlHfA-1
X-Mimecast-MFC-AGG-ID: 6DQxyzBrP0mA6iQF-qlHfA_1741905491
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-47699e92ab0so30030521cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741905491; x=1742510291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFzr4WLi5EWJd9Q1lyDlYMS58+KhEJhXt4VWqBCulsA=;
        b=lFDZjCmmZmhTO/qoHLghPz67cz1gb0QAtmHwDG7SKVE+29Za73HxMsgYUBnbE2Ac/1
         2MYS2qXemVcDM8OF9dm1noepYF5QhG1bRmbtK3NS5qd8kQ/wbjNzK7M3hxDR+wl6jeCM
         g6dgWwbBQ1xHQbKTKT88JJqyhPfhd9Vb1/4ZFja7Udsq6KIE5TnjWRNAgD5QJZMyS0EN
         rLPQShJxOCpJ7AJJDaR+/ZbC6JOLzesy3XyZG+ZnItDHAJ0zrnzy17dq9LTwpr8bTp9c
         XpAY97tefAy2xDXUBLOawgtsxoBfTyoI7DOd1lQOkKScCstJUkk1voqFtMUmO/UyikD+
         2HTw==
X-Forwarded-Encrypted: i=1; AJvYcCVncyvggQonFvnNYeGRv+zfZHemV4+G6VDCiqSDmy8aqeaNJNO3FLjfQf9MIisNW9qlrOPKEriSde0YDcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVlBQvTO/lFcAtd0L6UhCK9tvDTm0MttVt6MKJCUtpS8Eo95Zd
	TRFoCamznTUc1PlqFXoN0mPJMu2ijlnzeqSULGgf4umxEjg9dFfq+U1FbP+7UwbQeKWjEoVhgY/
	PN0j0ZYk3qzEY6JQmA4fNXZcT+h9rtzfnWUXgWVX39psQ5FTYrLFtuc3FjHiEbg==
X-Gm-Gg: ASbGnctlvB06cq4Cgzt8YoZlAjBhKMoFAzQ2qnh8ro9QQnRu8MXXL+VISrwRZZ4u4GY
	yFxEdmzStIZ9UU2+Q62vniyLz/FieZ2G6x5YBFB6VE3tABpHGEVZeyf+Bvxl2u+imDdCLJiI3Uv
	Zm7yJYccSmLJUOgso+pT6TQi3wmtz10RwcfSyfMUkiU1h2N0z8jsj2UzT4kGjZYImVKxa2fXDD6
	S34p842crwdWRuglxP4uMq7sXYOIlY7X2FYeMHO2uBkl+hq3xG73v+IdAZ4TxWoiiN5vBfHglIW
	3ZEIQoI=
X-Received: by 2002:ad4:5d65:0:b0:6e8:e8dd:30d1 with SMTP id 6a1803df08f44-6eaeaa5fa9amr2466886d6.22.1741905490923;
        Thu, 13 Mar 2025 15:38:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBXIseFJxXyT7V3i4JYoBiq0nyGeT0Insspj8UcFpuo+ZEN+6NwuINfQg0ot8cSpabuM7JsA==
X-Received: by 2002:ad4:5d65:0:b0:6e8:e8dd:30d1 with SMTP id 6a1803df08f44-6eaeaa5fa9amr2466586d6.22.1741905490665;
        Thu, 13 Mar 2025 15:38:10 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade208b20sm14700356d6.9.2025.03.13.15.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 15:38:09 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:38:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: James Houghton <jthoughton@google.com>, akpm@linux-foundation.org,
	pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, david@redhat.com,
	ryan.roberts@arm.com, quic_eberman@quicinc.com, graf@amazon.de,
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com,
	nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Message-ID: <Z9NeTQsn4xwTtU06@x1.local>
References: <Z8i0HXen8gzVdgnh@x1.local>
 <fdae95e3-962b-4eaf-9ae7-c6bd1062c518@amazon.com>
 <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
 <Z9MuC5NCFUpCZ9l8@x1.local>
 <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>

On Thu, Mar 13, 2025 at 10:13:23PM +0000, Nikita Kalyazin wrote:
> Yes, that's right, mmap() + memcpy() is functionally sufficient. write() is
> an optimisation.  Most of the pages in guest_memfd are only ever accessed by
> the vCPU (not userspace) via TDP (stage-2 pagetables) so they don't need
> userspace pagetables set up.  By using write() we can avoid VMA faults,
> installing corresponding PTEs and double page initialisation we discussed
> earlier.  The optimised path only contains pagecache population via write().
> Even TDP faults can be avoided if using KVM prefaulting API [1].
> 
> [1] https://docs.kernel.org/virt/kvm/api.html#kvm-pre-fault-memory

Could you elaborate why VMA faults matters in perf?

If we're talking about postcopy-like migrations on top of KVM guest-memfd,
IIUC the VMAs can be pre-faulted too just like the TDP pgtables, e.g. with
MADV_POPULATE_WRITE.

Normally, AFAIU userapp optimizes IOs the other way round.. to change
write()s into mmap()s, which at least avoids one round of copy.

For postcopy using minor traps (and since guest-memfd is always shared and
non-private..), it's also possible to feed the mmap()ed VAs to NIC as
buffers (e.g. in recvmsg(), for example, as part of iovec[]), and as long
as the mmap()ed ranges are not registered by KVM memslots, there's no
concern on non-atomic copy.

Thanks,

-- 
Peter Xu


