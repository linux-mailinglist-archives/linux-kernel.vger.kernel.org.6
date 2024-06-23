Return-Path: <linux-kernel+bounces-226289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6678E913C7C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1931F22A3C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D351822D0;
	Sun, 23 Jun 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlSa/JJ5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C063D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719157352; cv=none; b=Ab+ap2+l1FME93/G1JLMnx1RVmjLhbbKcsuRQchWel0RrccUrOfOOAFg+VCmVGrhvGRoXEtv9YSkTHlE3uV3MQDyQ4QAkY6/QLeu64g/Y6lZMq9lOWEiyGqERn7XufHtos3nP2vTIPM2a9ZKsBSw562f+IR76ZdYS4T5J3bBAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719157352; c=relaxed/simple;
	bh=szEc0tqJVtjWqDbOjt4KFM1shWe5d4q3q4B1/GMck8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWXgtcvRa9VG9jpU1jErn6IXtcu+8QQoyHnkAsQifudgiselS4yFL2CDvputVtc7ZBUzXeaxJcNP0Q3iCkLdj7O+YPQBP7LwyS0twiAy7NJbojMSAALO/+HfiG8lvH0ts2bubklphGxpMSqzvEHgMQeXOjXXuQ2Wd/dXHQdwOuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlSa/JJ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719157350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=49HpQTD2yqwpDIdZGHTzCNAJyeZfRMkM4BNUXs9LRBk=;
	b=OlSa/JJ5GntW/VAR+/jSOd6BVR/9bTNZODiTrU2cDhovMaqO0Irae+CaU8HWfeQV/VE7QU
	gaEe7EMQBPae1xqlAfqJ5bFIfO+8PzUFuHRk8+6CPKXFtSg/Nw9a73/dqrEHHyh6y7bYfy
	YKxnmxk+aEzy5e/lOnMfGPneH2+9PY8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-daE82Z2zMrC-wTWbRxk5pw-1; Sun, 23 Jun 2024 11:42:28 -0400
X-MC-Unique: daE82Z2zMrC-wTWbRxk5pw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b4fc5c2ee5so8927756d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719157347; x=1719762147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49HpQTD2yqwpDIdZGHTzCNAJyeZfRMkM4BNUXs9LRBk=;
        b=t9fouLJf3SpmEydu2+Q9Rs8dXe/hcF0MsoM7E7Nee6EoUEV66Fb0NjvUfmJ7toAEEI
         JohSgWkkpTIImWhFTaVYJMOz7laeELe4I5q0LFgdbd+85LtooeOzDsQVO5dwL+xw068/
         bHjJWV49Ke43/dkqMf83s2B1hNX8F4a7c1XbgsPM++Wm2sq7LDd7dhDO3JVqGaIXP6ts
         4i7mE2aWapi6biQi/g2I49mXQxvNBUxzD+Dj/j48Hdqy6yOhm9go9/B13pVxez0qnZ8T
         qy4dYb/TYLdkFPTXjh/vacyuWLSiN10JW0Bidk0L78I9y3BQM2GiuqF859TfKdL1rjyy
         8YQQ==
X-Gm-Message-State: AOJu0YxRVv1+ezrTAqa+r8pypiaF5OM9wKXItFZgDsfWaqUwLFsvMalQ
	ghHg9Jai7zWkAnBTa94nYwPnfKeZ30LFRfZKjEL2cMWDlZEzoozI0UfzuE3EnIpHHvOvfJU0G3k
	OVQTH5et80S459m69LKvMU1LYUdHcFWDPSXJL4NFaY8UxfRWbXyJrKQ1RXJrGRA==
X-Received: by 2002:ac8:5748:0:b0:440:565a:920a with SMTP id d75a77b69052e-444cf710e9dmr46703381cf.2.1719157347317;
        Sun, 23 Jun 2024 08:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDWtNbBGBpmQxIF+5cLIUwj0ebBIF6aR+2q9TF+Eqc5ywm7H5/7hWNuQ8dMyVTY79V+vfiyQ==
X-Received: by 2002:ac8:5748:0:b0:440:565a:920a with SMTP id d75a77b69052e-444cf710e9dmr46703081cf.2.1719157346867;
        Sun, 23 Jun 2024 08:42:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c3b4b42asm31681401cf.91.2024.06.23.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 08:42:26 -0700 (PDT)
Date: Sun, 23 Jun 2024 11:42:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>, Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>, Oscar Salvador <osalvador@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 6/7] mm/x86: Add missing pud helpers
Message-ID: <ZnhCX-GMRn_uYDF8@x1n>
References: <20240621142504.1940209-1-peterx@redhat.com>
 <20240621142504.1940209-7-peterx@redhat.com>
 <4fb4b087-cae2-4516-a34e-cb4c72be13eb@intel.com>
 <ZnWgG7WmZWS-xWJU@x1n>
 <5daa82f5-b5ea-42d7-a074-122734ad99db@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5daa82f5-b5ea-42d7-a074-122734ad99db@intel.com>

On Fri, Jun 21, 2024 at 09:11:56AM -0700, Dave Hansen wrote:
> It's in the "Determination of Access Rights" section.
> 
> 	A linear address is a shadow-stack address if the following are
> 	true of the translation of the linear address: (1) the R/W flag
> 	(bit 1) is 0 and the dirty flag (bit 6) is 1 in the paging-
> 	structure entry that maps the page containing the linear
> 	address; and (2) the R/W flag is 1 in every other paging-
> 	structure entry controlling the translation of the linear
> 	address.

Thanks.  It'll be nice if this can be referenced in the pgtable definitions
too in some way.

[...]

> One big thing I did in this review was make sure that the PMD and PUD
> helpers were doing the same thing.  Would you mind circling back and
> double-checking the same before you repost this?

Sure, I'll make sure I'll at least add a comment if it doesn't match and
explain why.  I actually did it already e.g. in the _modify path for shadow
stack, but I failed this spot.

The page table check thing is really rare that I overlooked, could be
relevant to what I used to hit a bug but fixed around this area, so I
forgot to add it back, but I really can't remember. I'll keep an extra eye
on that.

Thanks,

-- 
Peter Xu


