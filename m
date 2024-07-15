Return-Path: <linux-kernel+bounces-253019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18A931B58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBEAB21B2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26E74409;
	Mon, 15 Jul 2024 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRlV3xtQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EC133C5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073644; cv=none; b=BBJCdGq+ssfavWYBGB/vu7BDUxc9C3QsQHOjMI0xRmoYGqc9t0Sojfueax5S7YeHBQxOl4NT5U3U0W/krI6bIS5RtOjoGODyWuulhyGMBq7X1+4id049duCguzCsNDVIylDAThHGfG6W351dmgjBrumshwbvi7vO3rDtPip4FG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073644; c=relaxed/simple;
	bh=h8QSQK/35OzHtaaR5yWbSpM2Gzr0HTUIpkUo4ZPVw0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDG7K2yHacB1sevOsctjsrgRGfNxYXQ4gdmwumP2EpIY6v20g7PhOMbwquatS7OIfBRgo5qndpCf9X7yElIL2GcC/PIuyYp4i3j/aJ0XaDJX0+ltzh9gbrxDHuD8P0ssug/64c7BjzumtpkqRnL9FnPmwKn3bmY88zZvl6VvIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRlV3xtQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721073640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15Dmclh4kIckOnCQwprcdxOX/buxG2q7LphezAtYVv8=;
	b=QRlV3xtQexjn8woHW4g/x+2UCzIj3HAtcsL6wCiJWb3z703Ha1AT93PhAem2UskadX5SZ9
	rnRyBLYX8jxIHqpvqQFhIJqmZHp+lYKKTBslfxuVNZWX3RgXiI6wcf62tcYGKYJFNx8vlL
	bHZNTlS8Z8s56mzgyiXrG39eOXP0Xk4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-IuTVSJNeMZmNwWNgb18FHA-1; Mon, 15 Jul 2024 16:00:38 -0400
X-MC-Unique: IuTVSJNeMZmNwWNgb18FHA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b5e99c06efso9844046d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721073638; x=1721678438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15Dmclh4kIckOnCQwprcdxOX/buxG2q7LphezAtYVv8=;
        b=s1+4btBpKEl9nEv7L68waBKmIX7nYJmILIPWOtR8TcGIRBN3jVSPK6dVJgKWtfkQ2/
         0jH6zqLSFRxqMVz+6C0zBkdqLEl/pa9iC/LWilLiVaB+CfnFCujXEH21xhbf+R0Yw0aB
         Als7CtasxE95/2rr2ofKfqvD+w7PA67yGYewufLAYVOFWecT1E/OscbVPe5n17jy2Di5
         90UtPa8ceKvBPqT5VYnmzqlyIlUgRN2qk/I3uBsaTQEouBVKTZfcGA/KvwkXzncjhxIE
         DlE38OAzG7vy2ikWXBMF/WEoHzhCrVsy/Yyk7QPkrGSM8CWwROBZQcQbOhQBKMFcnDfX
         xJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPv3KSO8Dy7/0ePeCEnzAoCqSukP8Xc0iABHp8C50zYDMkCkr1zElar6HEUJ7fWXdIlMBAw5IycXOpjv93k5WX+lo8MP+4Ra/rUc4O
X-Gm-Message-State: AOJu0YwSGuHj/LnA7ui2ucECsarI1BMVqwpegvyQMP1h6qrE+6loUR8A
	gNucfAN2E7HlFIreh52JtZiN4vjPk4sKHtJaRCNqZbmr+KiOm6eSzfcf6jZL3PwU+BaglL3XIZh
	N9LFU7Pus5Vf/rtk+PUcNxVJZVKmWcrRdHTNEuEmIFJA8UDD0191D0qxqzFyVYw==
X-Received: by 2002:a05:6214:31a0:b0:6b7:586c:6d9 with SMTP id 6a1803df08f44-6b77df58959mr5345446d6.7.1721073637962;
        Mon, 15 Jul 2024 13:00:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6GZr9wMOYCEvghsINr3u6w1OSLohUo6zAjbcvIW8QTcL9i2DqhQXaU6Y+D7OVjwAgKHeENQ==
X-Received: by 2002:a05:6214:31a0:b0:6b7:586c:6d9 with SMTP id 6a1803df08f44-6b77df58959mr5345176d6.7.1721073637602;
        Mon, 15 Jul 2024 13:00:37 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76199d5a2sm24091186d6.60.2024.07.15.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:00:37 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:00:34 -0400
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>, x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 0/8] mm/mprotect: Fix dax puds
Message-ID: <ZpV_4ms0X5SQj0xx@x1n>
References: <20240715192142.3241557-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>

On Mon, Jul 15, 2024 at 03:21:34PM -0400, Peter Xu wrote:
> [Based on mm-unstable, commit 31334cf98dbd, July 2nd]

I forgot to update here in the cover letter; it's actually based on the
lastest..  Which is 79ae458094ff, as of today (July 15th).

-- 
Peter Xu


