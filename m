Return-Path: <linux-kernel+bounces-191089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3A8D0673
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FB128E1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963761FC4;
	Mon, 27 May 2024 15:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="He1fKpCW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3D1E868
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824643; cv=none; b=qgLsj28RQYHu0taLtjquTxQjucLxts3EVvK/uu+mQExpRxe38sr6CleppeKefEY0VxWS55g3Fnepaqqda/J5/6kggYLTctvSgCR4IfcgpYYyymYVb3YpHO4UjZ3WCyapP4dPYio2cNHsW6KZOj3Q9IQGJU62rVNmMgP9WRScq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824643; c=relaxed/simple;
	bh=iFiJRTERvUUOzw9z/0q2wi+diCNAv1X6Y3kSP+r2fa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0o2rWLcrAAgOnk46rSNLLl8p+BQ8W/q/h1YZHkjPzs/Kjw4eJb/SljbbW/VKSD0RByCr+EBBjhUB327wBuJSb1vOsqiu6wsOXguZbMlzIwWhS1E0+ci05QlxAYbZfBtWscaT0l2PS+7M5H0PkpiF0UInke9xlLOwOfNd+n6Rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=He1fKpCW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716824641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYZGz7F2HkN4H4qp3H29TFAfu9PHGhaYKuv4XtGKt7g=;
	b=He1fKpCWjfww1QGs5CGaQDL9+4X2Egrg+FtGzncu+IRpyJ88CSxpLPH0oxFNe/j+g/YLp2
	6fq7D8IUhpvhw97jmrizlMgQFqbNs+9N5ml2UO9xVyR4l43fa+WFvCTVfYxvbR8bZb/N+J
	IDms2FG8NBUfycJDn9ljJD5GLkUjhGY=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-iR73HncPO8Gt8rFiqAwdow-1; Mon, 27 May 2024 11:43:59 -0400
X-MC-Unique: iR73HncPO8Gt8rFiqAwdow-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-24cac33e215so27995fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824638; x=1717429438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYZGz7F2HkN4H4qp3H29TFAfu9PHGhaYKuv4XtGKt7g=;
        b=OM0jctf54vSDHOCAusM6zb0vG0EGdcF+ihHQmrhw4dXFPh1WifyTy6r/hJkToibOv+
         pgutG6mY+sqAD348k1sPbkDZralg6bMbDu8zJoGk4HMDRFtsldWylJslpmPJu64cgPo4
         IrUIDL3j2yx1rFAqkGy8PWlP3NI7e0Dd2NeJuCQtS0y+WhrdddNrdiR5vMO5DpKYt17Q
         1ymkXl7AJK+nkM9dVY1J+mFoWnmVkS+Myjnl0ywcUUvuD4J0fv1poOP+A74sLDZu4bDE
         9j4CbRAWKEGlmj2OAAi9rkfG1+0rIRui7m1Ow8ikEFNXyZX+RnNpy191Gx0dyObmTt6q
         WRZw==
X-Gm-Message-State: AOJu0YxTk65cT/tzwS5sTI8s/IA1n+bNY32cF95FvUQEQgBKyRdys1mS
	bumKsJSUWlL4RLi/Ei3IP3/I05VWUPrOVnS2rXsIO7VpRdmiUChdTlf8iUTP5t5abOiIsVeO191
	Zcl0IclCH+BmA7lSRyrcLCPakLs7zLnY40PMEGQ1tyKelts2ggW1Js75KSkBF6Q==
X-Received: by 2002:a05:6358:716:b0:192:47fd:8be3 with SMTP id e5c5f4694b2df-197e5671b94mr1114625255d.3.1716824638232;
        Mon, 27 May 2024 08:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqu64yXCSH6zIgkGZqg9gyTi88XsJqX1EQqATRLKBAyQwdGY9SZpdiRPG6qy2xlzfZr724FA==
X-Received: by 2002:a05:6358:716:b0:192:47fd:8be3 with SMTP id e5c5f4694b2df-197e5671b94mr1114603355d.3.1716824636813;
        Mon, 27 May 2024 08:43:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070c2eeasm35518706d6.19.2024.05.27.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:43:56 -0700 (PDT)
Date: Mon, 27 May 2024 11:43:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 12/14] mm/treewide: Remove pXd_huge()
Message-ID: <ZlSqOmvS9jkDwZub@x1n>
References: <20240318200404.448346-1-peterx@redhat.com>
 <20240318200404.448346-13-peterx@redhat.com>
 <60ea6d69-a5f8-4e7b-8c4c-e54488adfadb@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60ea6d69-a5f8-4e7b-8c4c-e54488adfadb@csgroup.eu>

On Mon, May 27, 2024 at 06:03:30AM +0000, Christophe Leroy wrote:
> 
> 
> Le 18/03/2024 à 21:04, peterx@redhat.com a écrit :
> > From: Peter Xu <peterx@redhat.com>
> > 
> > This API is not used anymore, drop it for the whole tree.
> 
> Some documentation remain in v6.10-rc1:
> 
> $ git grep -w p.d_huge
> Documentation/mm/arch_pgtable_helpers.rst:| pmd_huge                  | 
> Tests a HugeTLB mapped PMD                       |
> Documentation/mm/arch_pgtable_helpers.rst:| pud_huge                  | 
> Tests a HugeTLB mapped PUD                       |
> arch/x86/mm/pat/set_memory.c:            * otherwise 
> pmd_present/pmd_huge will return true

True, I'll send a patch, thanks.

-- 
Peter Xu


