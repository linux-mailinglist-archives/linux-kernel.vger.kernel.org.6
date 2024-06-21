Return-Path: <linux-kernel+bounces-225278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71C912E78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B656DB252F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755ED16DED0;
	Fri, 21 Jun 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SATzZSo4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96F15F30F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001673; cv=none; b=i1ZPAsV37aaZ7NCRq51v2np+zLJrkfwcNm+Y2CdZq10T3WZGmKYmujlUVXYkGobPPIIVBO88WotPXNQo3SBid0VpRhAFgBbtK1NExNUFndXRgWhJLUEXcvrFQleTcbwFD6UQ1gxu/zvXzz1Q0/HoqkgGQ5WUBrbNnd8Ujd8U8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001673; c=relaxed/simple;
	bh=+y0YSjkn3mxAbSpReIOPljowg5houdzhfnzpEyF7ep0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P117TfjXbKglPq+GH9zZOIcjHXPnXtftXGwCoAIbGAe5lSwjumvjvisy+O0Z0I29k2kzWCtkqhWxbSFXiCA7JR/FGtiap/9mAGjINCYvX1k3yn0HVrgqUNNmp64MbuzVpfH8o6VBaFVHmJplAfSxDIQ94sk15HpiVPwbzs9ANDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SATzZSo4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719001671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22pIrWQAypdIZ5Rg6Bb3sV1iFixhfYe7whIUT2M8qwY=;
	b=SATzZSo4Ulx43WLhJTtW7D+xLIpdNQgJSpcNzlwEwTelE8m30T9mRP1/KoIMWDn6LaDlsj
	hMmtlF5ngc6vdBgq5+h8dVwIcM7tS9vgmsuYW/Pc2bpGdCsB9FWyxwhOsqS3DEH/LWTmXK
	mZtvIDLNsxaU/jaokIQ6BTOVqyt5o98=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-ciVhnetAMymJVa1Z3vUPPA-1; Fri, 21 Jun 2024 16:27:49 -0400
X-MC-Unique: ciVhnetAMymJVa1Z3vUPPA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5ba819595deso302000eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719001669; x=1719606469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22pIrWQAypdIZ5Rg6Bb3sV1iFixhfYe7whIUT2M8qwY=;
        b=VP+KLiMe6Hn55rDy6xZcVfH0JgngP3YObdDF2co6PEnKXX/oabRD+KXLsY9w7YzvZD
         tJaxLuvGlxsNwPop5oNNGUm93505Ce176FKLbUCMTaL2eP2bnQiAfWr7JfZWewYrDTvO
         GRNAPh4zF2sDch9cdyTMePJBV0kZ5BG1oLQgSp6ebZNxhknVsVac/97TmJ22RQV9/rDu
         RwscrCAuEmeN9vfZes+bKC1qBJ1CXRb+/v8obBbqh+73haNNYUD3smElU/EOV7iRajXf
         7lAdjDxmHdA7DtDkYxOlCDmClu4sOYzN/2P9BrCd0aHeJTRDE2H4yBSTjXjCZwJj6bKI
         RzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzlGV97x4JEEE7FkE/QwHVB/BO/c+IHXPX3cFkqh4KzjkuEgK4stuxg5merWF3IN+eHJmQRShRk7KUy6Q6qcpimegZwEl+bUoaY4CN
X-Gm-Message-State: AOJu0YxRcCTj+BwrnDZN7TGUG4Obp+7iycC7pdsfPCnCjWWkk0DRSeeN
	WJPddOXrpa/5Rjgy2Hcw/0S3yNdna1GfJRWoVGwtJkS70kx4H/ShoeMOLUzPX8sZfoz/B69BaqP
	vSv6IKX33AEm02qDPMupU6Za+33VbOHKZgQsDK5YoUjRYmgl81kQR2FZ0Y5Octg==
X-Received: by 2002:a05:6358:5905:b0:1a1:fdee:fb5d with SMTP id e5c5f4694b2df-1a2310ec6f4mr36970255d.1.1719001668840;
        Fri, 21 Jun 2024 13:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnQONlRBQfB2WimAlD7suCOv/AMwePZpfZM1R4sEwSWsu+GFC5PQy+iV7t7DTH9Ud/XUjInA==
X-Received: by 2002:a05:6358:5905:b0:1a1:fdee:fb5d with SMTP id e5c5f4694b2df-1a2310ec6f4mr36967655d.1.1719001668167;
        Fri, 21 Jun 2024 13:27:48 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce92e6b4sm113770785a.100.2024.06.21.13.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:27:47 -0700 (PDT)
Date: Fri, 21 Jun 2024 16:27:44 -0400
From: Peter Xu <peterx@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hughd@google.com" <hughd@google.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"kirill@shutemov.name" <kirill@shutemov.name>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"riel@surriel.com" <riel@surriel.com>,
	"npiggin@gmail.com" <npiggin@gmail.com>,
	"osalvador@suse.de" <osalvador@suse.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"mgorman@techsingularity.net" <mgorman@techsingularity.net>,
	"Huang, Ying" <ying.huang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH 6/7] mm/x86: Add missing pud helpers
Message-ID: <ZnXiQAJsKPBAKa6b@x1n>
References: <20240621142504.1940209-1-peterx@redhat.com>
 <20240621142504.1940209-7-peterx@redhat.com>
 <4fb4b087-cae2-4516-a34e-cb4c72be13eb@intel.com>
 <db95c7abea9cd252a791d15359a4d940d91524e3.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db95c7abea9cd252a791d15359a4d940d91524e3.camel@intel.com>

On Fri, Jun 21, 2024 at 07:36:30PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-06-21 at 07:51 -0700, Dave Hansen wrote:
> > 
> > But, still, what if you take a Dirty=1,Write=1 pud and pud_modify() it
> > to make it Dirty=1,Write=0?  What prevents that from being
> > misinterpreted by the hardware as being a valid 1G shadow stack mapping?
> 
> Hmm, it looks like we could use an arch_check_zapped_pud() that does a warning
> like arch_check_zapped_pte/pmd() too. Not that we had no use for one before
> this.

I can definitely look into that, but this check only happens when zapping,
and IIUC it means there can still be outliers floating around.  I wonder
whether it should rely on page_table_check_pxx_set() from that regard.

Thanks,

-- 
Peter Xu


