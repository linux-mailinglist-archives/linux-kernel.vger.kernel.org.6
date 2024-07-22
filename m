Return-Path: <linux-kernel+bounces-259401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B8B939554
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42DE282657
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0201228385;
	Mon, 22 Jul 2024 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD+6DxHd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E678F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683057; cv=none; b=U5WZvTt25+H4fQ7E0dcDaR2EYhj4lIULCkpUYrr0e4pkuRbD25RNQ3K5Wk7mph7Ydj3SGDkJObm63pBu5l6RIDz//hrK4CK1hmxeEJwjlhSx+gpGm/KYzWEVLv0hjOaPFk7fuUE31JrQNsPIDwXT32uVoS+Nbrpqd7eczU+TAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683057; c=relaxed/simple;
	bh=f+GZlPLYQK1BwAijalSIfEY2+o64H/h5CAW1zNAgRd8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phelkLMbKqo4zIv/GvPhNDOsg1+s/JxDBg/p5hRUChwxzb9/t79oFnuwptMjcibzLC67v9J/Thk3krOn0pH8ecOnNgAhoJ3c73Le8cN0gu2NrOF851inAN/EXT4mbrhfYr31x9ocN3iwrxK5hNQZyIWcdkKXuk5tWokZyByxdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dD+6DxHd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721683054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWGBIFbdnnVI4D9ZKXTMtZLIwvN1VM1v93fwIW+Mwm0=;
	b=dD+6DxHdKj4KRDdtt0VNcOfrEMGBw1x6raOQP/+bpdZNXQY7C2OcSYlnVNhT6lu2JfPhNl
	KUngxwxar0ZW2wC7Kg5WHqWq7x/Z4jDf5/pDMOFaokTNsIhehzxGOPe5maP78squcYA7gI
	GU/w35hMm19RIu6Wlfe+Bj2aCJmgfBE=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-4JXEFAhwMCazlQoCj9xS6Q-1; Mon, 22 Jul 2024 17:17:33 -0400
X-MC-Unique: 4JXEFAhwMCazlQoCj9xS6Q-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-26440d4a6f9so328284fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721683053; x=1722287853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWGBIFbdnnVI4D9ZKXTMtZLIwvN1VM1v93fwIW+Mwm0=;
        b=eD0R6wM17Kv5K10Cno/DrdHSpDo95gbVA7EY7NVc9tM0QeozeDuh6gBQxYenKulHOy
         quJmxKTMKYYmmHDgVPsMc7MYjyiI1bwcacxVb5/t8O04kPzrjopbRB1PNBm0LvZmU/gq
         bCHGd13BxG4p+IoymKPq5oelNpkeSrLoTrQVl9H74xaRjdNojJ9N8XXCD8th3l0Ru3K7
         Ue882SNppiVZ8lqrkmUysA2vV0U4qFYl3Zcd6w5HQp32PC4FyCxpb0QPXjiohXfYCqd3
         nrBqWpiBnbkICBzg9u47GTGyGNmPiJIyVF9hlRzZDEH5dw4EDMeILLdMcwS7mnXOS3mc
         OWag==
X-Forwarded-Encrypted: i=1; AJvYcCWYVpFYFSjbit3Cv+aSx1Xnw8FfapaHbXoeofgNbEQyPatc55Q7FwczwHe/Kq/4UJnLtlj9UDmbXA3613FLo2v5tTYHWvNYlkD+bnZN
X-Gm-Message-State: AOJu0YxSgZxfQXqTQ2iswDU11BOQep6XO3+jiHCxjvMVp6QYsvhUr1qU
	2zvfzBMsSnkjn6YWW7FmEuzfM1TwPvYrJ2a2RXOR6HLga+qVNaeCuCFSCK56aQ/9RWQIcfLWup6
	SaFFjZlsxAVa+2I4r8lEmLYdRmapmLBQViRwdC+46PH2B5lRN9GfJNPP+cKTbyg==
X-Received: by 2002:a05:687c:2c26:b0:260:e5e1:2411 with SMTP id 586e51a60fabf-2612162fb7dmr4634119fac.6.1721683052763;
        Mon, 22 Jul 2024 14:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI2JUYO/fwbkbrMVLCUCNwsRIuJdEHWZL/Ew57PyL8slkIUnWhVcsqxvSOgcx1uvEAQHqLKA==
X-Received: by 2002:a05:687c:2c26:b0:260:e5e1:2411 with SMTP id 586e51a60fabf-2612162fb7dmr4634101fac.6.1721683052407;
        Mon, 22 Jul 2024 14:17:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cda773csm36770541cf.77.2024.07.22.14.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:17:31 -0700 (PDT)
Date: Mon, 22 Jul 2024 17:17:28 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org,
	Yan Zhao <yan.y.zhao@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Pei Li <peili.dev@gmail.com>, David Hildenbrand <david@redhat.com>,
	David Wang <00107082@163.com>, Bert Karwatzki <spasswolf@web.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
Message-ID: <Zp7MaJ0eosfaZP_3@x1n>
References: <20240712144244.3090089-1-peterx@redhat.com>
 <t7q4s4rktcjkrtmr7l2zffpthxis5bmafhae7aaxxekyyp75ev@x4dshxdx3jpo>
 <Zp53fnlsJGOmWSRQ@x1n>
 <ox3rg6uyazlaeshxeub5hxv4z4bjai222mkitoduktmar5l3pd@qfxv4jdnj5xo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ox3rg6uyazlaeshxeub5hxv4z4bjai222mkitoduktmar5l3pd@qfxv4jdnj5xo>

On Mon, Jul 22, 2024 at 04:22:45PM -0400, Liam R. Howlett wrote:
> The problem report from [2] and [3] is that we are getting to a call
> path that includes unmap_single_vma() without the mmap lock.  This patch
> fails to address that issue, it only takes the caller with the assert
> out of the call path.
> 
> Removing the function with the lock check doesn't fix the locking issue.
> If there is no locking issue here, please state the case in the commit
> log as you feel it is safe to use a vma pointer without the mmap_lock
> held.

Could you please state why there's a locking issue, and why this patch (of
a x86 PAT specific issue...) would need any documentation on that?

I thought it was pretty common that file truncation (or anything similar)
does a file rmap walk over vmas that mapping this file, and vmas need to be
alive during the rmap walk, no?

Thanks,

-- 
Peter Xu


