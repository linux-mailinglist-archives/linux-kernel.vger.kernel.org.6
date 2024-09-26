Return-Path: <linux-kernel+bounces-340729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515C987722
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C11C252E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D24158552;
	Thu, 26 Sep 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik7OxE0U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0A14AD25
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366349; cv=none; b=rJ8Vtj0gn4onRwPh5xkwl5g/6xaqHI/13Uhka//Gr0F2rzjXcUwgoH6etKpnnhN/idHRrp/8goHENmQHI5ecuHVoReQk/JYZhDqTpp5J0i/j/IL5TWkMePFGo/4F0PmUfPZhnEDoLOTGtVdfx7tb2DSCXtlOt7Y9NYK0e3Hb/SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366349; c=relaxed/simple;
	bh=2v2nI+JCWRDdjouZniI/NESZgicyvP+07ZPHhBMP+pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4/l+XYQri94ADnyN0tJx8BawhySvtUz7991kRHI07j4AgZpQGWeFmyal4uj9/An6LRQk9d204YrIHAMJWoFmZR4dYTfEY+RdQOudWyxNQ6c+wq2LdsYwyv2OolVT1ZwGCJMWozUjFybT8A1YM1zXg/K+lpgoy/+NXVxFSeVg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ik7OxE0U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727366346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFAsLAn7aoKzo71RR9rydtziNxEzX6MqXWWWxfPqW18=;
	b=Ik7OxE0UbaGS34gmSgmP/gkXBg6TBP0rJjQYFXHVS+8Um1ZVXewAPeTv2QCulVXrNSq0LP
	CkgpoNDVT87pKLHlEcaDdf6KOylDsB56rWDmg4ZXRFJx5IYBWfImbLLEVrXTyaxNXhRBL6
	HkeXe+mdiG8yZdBULOxlT5G0iMBnQGc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-K1UzhgOrNZG6e6r9Dx0AnA-1; Thu, 26 Sep 2024 11:59:05 -0400
X-MC-Unique: K1UzhgOrNZG6e6r9Dx0AnA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7acb118ba04so238856185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366344; x=1727971144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFAsLAn7aoKzo71RR9rydtziNxEzX6MqXWWWxfPqW18=;
        b=wJPXhFsuV004zYjQpqiJY9ilQ8mCV/iU4TM/eaWky5/YYlbI89M3jgNyW1pRTBpZPT
         XJU0m58aY+aFYZe10w0et7+I6Svx8ZxIv2593z5UUi8Co1LToi7yYvqGuZLz5CsbUOgG
         u/OHeSAA1+RMLhGf7B4shiKze+qnipnTPCehfL72j/xbEFLyODqk3NbIfwYVgoaCb7LQ
         xRkud1enrISfwEdEA9DOrSUPm6G2L8RYTOHBimIkxm6xdso8T992ojy7vv30+m8QHd+E
         tWPMdO7sbzbHVqBTpvJJDloS2lBcEzhklq+s+RjHUgSfeEb0dBFnkT+XRwYTiiY3b9uX
         qgpA==
X-Gm-Message-State: AOJu0YyjBFBttU5BIMzzKuJRbEoGB8avHvR95FtmE4F3CV5TchmQ2LIS
	XKgVwFMr+Q1oOvTrdEXM+xyLQjCXOgq8pB2i04KNCMNwqZNiYKHdy4qEvQyZk/L07gGnMduF5D7
	BU95CCIx//irJQHT68hrKVcN4MbbhZvaYclHnwPeZSPHjsei/iwK4B/R+ITdYniPkPpTkiyRk
X-Received: by 2002:a05:620a:3907:b0:7ac:c348:6a55 with SMTP id af79cd13be357-7ae3785aa4dmr7320785a.38.1727366344018;
        Thu, 26 Sep 2024 08:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRrdxCsCY8RTL63d/BLOR3iT34tGRFX8LGr+whBimlqLf5fLkvQQDVmOR5aqdwd7HjXAlecA==
X-Received: by 2002:a05:620a:3907:b0:7ac:c348:6a55 with SMTP id af79cd13be357-7ae3785aa4dmr7318385a.38.1727366343632;
        Thu, 26 Sep 2024 08:59:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377ecc96sm2434085a.68.2024.09.26.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:59:03 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:59:00 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] mm/huge_memory: check pmd_special() only after
 pmd_present()
Message-ID: <ZvWExCqCM7qzydP1@x1n>
References: <20240926154234.2247217-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240926154234.2247217-1-david@redhat.com>

On Thu, Sep 26, 2024 at 05:42:34PM +0200, David Hildenbrand wrote:
> We should only check for pmd_special() after we made sure that we
> have a present PMD. For example, if we have a migration PMD,
> pmd_special() might indicate that we have a special PMD although we
> really don't.
> 
> This fixes confusing migration entries as PFN mappings, and not
> doing what we are supposed to do in the "is_swap_pmd()" case further
> down in the function -- including messing up COW, page table handling
> and accounting.
> 
> Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/66f15c8d.050a0220.c23dd.000f.GAE@google.com/
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


