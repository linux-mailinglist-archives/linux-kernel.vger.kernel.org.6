Return-Path: <linux-kernel+bounces-561967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EB5A6196F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B8819C69A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728420485B;
	Fri, 14 Mar 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYh2TXlx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A116155747
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741977134; cv=none; b=lIeIOP0ukXJNKFnzHKmBTiXNLx7H4AGkar3J9XS0XTFZ1Vq9rtsG2BGvzv0mGJzsRKMFs9flXYL+9MKkO1/UjJo1a2MeTqOvzU86FlsP37regNkqA/+X80B+SgPuW0amZXmRvX9PMBvidEnR4poCvmnJw+H7Z6XHm+F1YFw13Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741977134; c=relaxed/simple;
	bh=ZAlDB8f3z/UtpU4Kr17RyxB+EhhNFrQC+QXpc8vm7rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw9og99VJ09W10cVthvLvMlU0VO/Q6JB1nhbrJ/uC7EE83immsm4DbRzr8U9Y2+VJ7owe7UhEg4hS3oyx4ZOPrkYMdO120CO31DgrCKteXgWN+aGNkhTgDLWvdD8O4qWHs5njvqkrkD1jcS420f/jROSw1GcsWAo5yVaL9KCe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYh2TXlx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741977132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMyLUb8LhPfp38YWXS83SjE2dBcmOEXzjF8frO+TYyk=;
	b=JYh2TXlxNz37zVjmlu8Fn4heKQB73AHBypNicBPR5Xt5n0YYTa10JMrlXmw4M5G5SuA5Ug
	Vpx9cb40exLP3VLZphUnLbGjkCmWQsPaXwI9M2SMGDWh8Siz+37sfmVNBAfC3PVI3xA9T0
	RpuAHawm84dKmsFHjk1dw6Ncdp7Ihzg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-B5H1SHJfNiCwS75H9DbAHg-1; Fri, 14 Mar 2025 14:32:10 -0400
X-MC-Unique: B5H1SHJfNiCwS75H9DbAHg-1
X-Mimecast-MFC-AGG-ID: B5H1SHJfNiCwS75H9DbAHg_1741977130
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e9083404b7so50706496d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741977130; x=1742581930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMyLUb8LhPfp38YWXS83SjE2dBcmOEXzjF8frO+TYyk=;
        b=oJuCLJZIb42Rbxh6M/4RamYg6QlvuikfSQW+9UyWxNvGDQT3nYDIxP9XpAuZmuDoot
         WcgSf0rAXXV/Th26NoAkEED6B4BBo81nWfKIXnP7LyBGJConLoKTwNCgiYDvVSx9xx9b
         qGpK1kWOrF9bfzfUUvXHD5gCgGyCPXtDKaBj/5yfPOEWiX0jt7OjYmbRDJt6pKmEFDrO
         UxV2Fi7DN5EmeqQ2CqNKC+7eta1564wVstPFnEip69WInMUg0AttG3G02mB96yZdIaZs
         QYW6s/vmiLI17cb3HCe6yZlL7kyyXhAhLvRtzheITiWXuy3BJzSOkKoNzCd5uYIcO3Xc
         tCOw==
X-Forwarded-Encrypted: i=1; AJvYcCWDQNehiD8E2Ya1vKKohElUuDjge106XA57R/1KBh4V0xQBg0n1pK6wr2iNJ9kDb63iqgFEA0VaM17Nz3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcntxYPdUXfe7yzkTdnsd70qDdHPIF7NxwfFNyrQnrnADyDcXN
	g2LAfdPDPpbluRMBNSoMRu2Sl4BD5cuHZ24INnAI3G+Q1tGN5GRqxgnTFwhscC5/Mi42n9wHPmv
	8qe1XWN5ov2lWPrIGIzWs0GwLkldZW55ACxtQ3rNNjOi5Wi5wLWvzOy9O10eUmA==
X-Gm-Gg: ASbGnct9ORPeTyXaWhvVUvtwZ9nEkq2KGvn0dITRtHk2Q+FifSWMslqGeQaU96spSUn
	eUPqwF+et4/DlHoEUOuUT4Hrtv7kvPM7zQKWD/MC8ucuo3a8so7zURkI6AwmAOHYMeD3gEV0ytn
	J6BuoVOUxYa53OnmKX3phn08+GJFiB9hLxeLcY6ODZR/wXFxe+xAeFmb3Xp0QXsO4JGXhnlV/fv
	BheRvu0siXRJHxFSMykoDNUPpDqYkPfsaoJyMlNptXwKYWIk/xqHf6feHROC/Mbk8o12Lf2HZ8z
	76ZKGc8=
X-Received: by 2002:a05:6214:29ed:b0:6e8:feb2:bad9 with SMTP id 6a1803df08f44-6eaeaaac26fmr45881486d6.30.1741977130144;
        Fri, 14 Mar 2025 11:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHscSVLDkbW24B9zbK0LGwRDEEXA7mFC28oFGsGZvhR+c2wtyNhUM9wN90pI1MPGQwzkAu4dQ==
X-Received: by 2002:a05:6214:29ed:b0:6e8:feb2:bad9 with SMTP id 6a1803df08f44-6eaeaaac26fmr45881066d6.30.1741977129812;
        Fri, 14 Mar 2025 11:32:09 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade231261sm26870036d6.30.2025.03.14.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 11:32:08 -0700 (PDT)
Date: Fri, 14 Mar 2025 14:32:05 -0400
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
Message-ID: <Z9R2JapHdhR2Xhp_@x1.local>
References: <Z89EFbT_DKqyJUxr@x1.local>
 <9e7536cc-211d-40ca-b458-66d3d8b94b4d@amazon.com>
 <Z9GsIDVYWoV8d8-C@x1.local>
 <7c304c72-1f9c-4a5a-910b-02d0f1514b01@amazon.com>
 <Z9HhTjEWtM58Zfxf@x1.local>
 <69dc324f-99fb-44ec-8501-086fe7af9d0d@amazon.com>
 <Z9MuC5NCFUpCZ9l8@x1.local>
 <507e6ad7-2e28-4199-948a-4001e0d6f421@amazon.com>
 <Z9NeTQsn4xwTtU06@x1.local>
 <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24528be7-8f7a-4928-8bca-5869cf14eace@amazon.com>

On Fri, Mar 14, 2025 at 05:12:35PM +0000, Nikita Kalyazin wrote:
> Yes, I was thinking about MADV_POPULATE_WRITE as well, but AFAIK it isn't
> available in guest_memfd, at least with direct map removed due to [1] being
> updated in [2]:

I see, so GUP is no-go.  IIUC the userapp can also prefault by writing
zeros in a loop after mmap().

Thanks,

-- 
Peter Xu


