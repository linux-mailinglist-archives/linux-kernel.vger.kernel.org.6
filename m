Return-Path: <linux-kernel+bounces-186334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278AC8CC2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AFD285A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246F3140E40;
	Wed, 22 May 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XeRZYuNU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F4513E032
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387084; cv=none; b=ZVj8R9hD4Tr5jHmz9UGgTDYkaZZcxkw4PQcHC/zYB5MzXDCojEzVcCoGFI7W2wGwOXyQfRW6eDMviG2zP0TtLeRy+4FftjvV2YpBzI3JQI4PYXapCQuWCBL3XDIFGVNP1F0RruX5ChbNj6zl1501hl6wqAVrC8eE2BP8pPAloEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387084; c=relaxed/simple;
	bh=mB+z1WJTnDOP5umMPhoDS2Hqz2swaB21VPGIyfjdkYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFzFWueOr0RE0yofEdO0K1PUkX6AVUYrRYHfw8dfkl9hUq+2xzh5VpcAj0sPJvAtP8oA6/mRdKFNSqO7oeIuIVzabm/ao3EIOC6F/aPmmc/fA+xeZm8rISslbFHTbVUqT7OPNkORfRjeglKiTfrrtolJ+V3RxsIgrZfgs6PrSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XeRZYuNU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42012c85e61so69205e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716387081; x=1716991881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QM+xcKa0epHmHEloutgnT4H/ozOswfIIuchelOYu74w=;
        b=XeRZYuNUjCewlPaBVkGagf3uWj4CtvfxBPJxsLQJgB6x44GJXNA+50oQzPpWi7inIq
         6qXgE5QoukoCpqifOGMsX5CtQgdCGtOLWJcQkQXXAhSVMM4Kk6eITRvAN08KB4gcYbiO
         GXUHfT+MLDI/4CtEI5RqjkUohxTdlsuqfEbdpi6mMTzoEHv2xU/N5IGVv7EvcKwICNy1
         k3gS11sYoKv993oNktYvEI9GMrJDAi+Tssqs6LCeQuAg9ulbymshszmGBPR5lsuh73SU
         nlayXy+mnjc5K1zLgeOPge4ajwaCt2xz/LSElUzixrrWUQ02T2eY6J7X18sXe59P+JPg
         zg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716387081; x=1716991881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM+xcKa0epHmHEloutgnT4H/ozOswfIIuchelOYu74w=;
        b=YeceHecHpf56xzM6B/qS5TGgaCDLkDJLMdO/8JeR0QoRb0uqjvRcAWiuyX76pZCpcZ
         qhpFWpCzPIRhtd7RJ/gUdNgdgHY8AzxVwnX3y2S/KDR70k9nuYUn8kjsBnTMpMza77k8
         JuJ7fk0DZKn5aZ8WCdGRDjia2SnNZ+fXwryNcgr25lDaqHbR6vhptfCjThg8Cm+QkroY
         s48GbwHF79I3z3aQ+A0wEqp0Dr3Nw3quTJ1SR+HogmOEaADxT7nRza5zsdX/OXXXtH/2
         d6XxqLqVFJ4F8D7OqcttvdnIcJ0TXXqZqs9A5R1sP/gofPPw1zJguafOKfLf94b5zPUK
         2LDw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Av9fvXqCxgIomR5QDcCNmFgEm/uzaYAYvSNssMH7YwUWhfoMJxZs7O1iMZ5t0FrhHPWrMUWG09zYhUno51I0KqsTVsICuuGzw1uE
X-Gm-Message-State: AOJu0YzzyGebLI38Rw1420Zr97w7LFxarPxqxJK6rw8Iu3bRqwjDMfMq
	8LKAWe+k1d8DgWlURqheKgg7FM5ewyPZS4fPkNUA1BbZMDeUlXONNPJQ5vWitw==
X-Google-Smtp-Source: AGHT+IEJ3MhUQcTeh130i9WzgPZysqUdwC1FQQtsNs5WxRtT4pVNSGX3TbtXm1lxCv6uk6PzFEy6rA==
X-Received: by 2002:a05:600c:1e84:b0:41f:a15d:2228 with SMTP id 5b1f17b1804b1-420fc411ee8mr2068775e9.0.1716387081018;
        Wed, 22 May 2024 07:11:21 -0700 (PDT)
Received: from google.com (49.240.189.35.bc.googleusercontent.com. [35.189.240.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a78e8sm34775615f8f.61.2024.05.22.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 07:11:20 -0700 (PDT)
Date: Wed, 22 May 2024 14:11:16 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm,memory_hotplug: {READ,WRITE}_ONCE unsynchronized
 zone data
Message-ID: <Zk39BD7NPbP7WJOz@google.com>
References: <20240521-mm-hotplug-sync-v1-0-6d53706c1ba8@google.com>
 <20240521-mm-hotplug-sync-v1-2-6d53706c1ba8@google.com>
 <9c23d824-f2c7-4f9a-ade2-e8dd3a0d30af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c23d824-f2c7-4f9a-ade2-e8dd3a0d30af@redhat.com>

On Wed, May 22, 2024 at 04:05:12PM +0200, David Hildenbrand wrote:
> On 21.05.24 14:57, Brendan Jackman wrote:
> > +	return zone->zone_start_pfn + READ_ONCE(zone->spanned_pages);
> 
> It's weird to apply that logic only to spanned_pages, whereby zone_start_pfn
> can (and will) similarly change when onlining/offlining memory.
> 
Oh, yep. For some reason I had decided that zone_start_pfn was fixed
but that is (actually very obviously) not true!

Will take a closer look and extend v2 to cover that too, unless
someone finds a reason this whole patch is nonsense.

Thanks for the review.

