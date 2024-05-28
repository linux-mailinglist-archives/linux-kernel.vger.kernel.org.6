Return-Path: <linux-kernel+bounces-192788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3BB8D2218
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B31C2299D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BAD173339;
	Tue, 28 May 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNGhh00L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8F172BCE
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915590; cv=none; b=feoJwZ4Ib92e7itjNsscGpvKhXeJlIoGWKaYMhgfNeV8WImKW6IJ4yn++g0S39ON/jnAwtaein3IV2gAYRtkDElM/pXgEAKmrwUXCr6/TlxoBsKT+qTu8ZxH9rRkOQcGprvO+D6rCf9mppyAtupmCN2Q+hQm8vCu8iYou/29z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915590; c=relaxed/simple;
	bh=aKqxiLnJn6Gis+JFsRxwOmnGd7SWBjOA7+Tkb7ACtA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iqxt0nmRHe2F5a/Oqb6dXOlKKM0OOC+ACj5pgOxFiNrb5GWJqrgP6z1cgy+xSbNAkanideIk6xNW1Tx0eRmV8euN8e45RB/Ip46RTf8So10/kJmR7rIdZccG87m5mnwlxpy2/yaZCjPlUfzgXq/9aTUCkIDqMSsE1LHGKGN7C48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNGhh00L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716915587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJwNJ7Iz4hN26y4XjDoNm7RTYYMRCtwNho8/txcFc8s=;
	b=jNGhh00LTCj5/vSzYAeH2gu6IUr8iWdi1sJGF04GJ4zdE442VCkrESrcOzuRhzYBZH92Mp
	Y+/5vcTd3l914vk/v2irhcpc9JUzlSb4Fz0UmCraulbeMLfq5quE6BRa4hiSlDIZK/XvPR
	Qy+pgG1hW0Xwp8am1qLkwobRxk1cUJQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-s1nYL9B9NsGSJN2xBEdo-Q-1; Tue, 28 May 2024 12:59:46 -0400
X-MC-Unique: s1nYL9B9NsGSJN2xBEdo-Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42111702b3bso7158155e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716915584; x=1717520384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJwNJ7Iz4hN26y4XjDoNm7RTYYMRCtwNho8/txcFc8s=;
        b=PCLqXQt0mGRzvzjoUkF69LhC3G8T7WmgUZirBvPJlrz0UzABRXZX6YKNx1oXfpFUh1
         Pk8d55OCHIwDaheVqv1Uch5T+rNuBB5ed5s9P4W9NzqyCTXCl/nBOLTKW7d53MFWHemg
         oJQUSiatpsiZL4FIXoqsWBNvDn2Q5eLTJxit0u/V2KVOyZlbFUbYXo3HpZ3Y8/UTl1o1
         VX8YEkQ6OyL//dptJZktReTRjyEQHqNalsUHKO0+pFS8IE2XsqzhYcQbVjhBcncht/E/
         +zOhaS+YxRoz3P5YteqLHyBi+s4cWyZIR4ER7Y1yURMhkvgxLNYKBINMmO03lNve6qzC
         N84w==
X-Forwarded-Encrypted: i=1; AJvYcCWPCgOQZeSDTTtBC2qNNEzCp6axO25et/j03a2PWvdL8Z7XT1xTdceCaYvOu2V1zb0qN5s9IGbptkEpw6J02B2+3yBFYQNReqWCNCZz
X-Gm-Message-State: AOJu0Yyqlppw+el5iZ3QsUj3n6d1mFZyfVTvraqTmuw4c2lvQpX1rjKR
	9Vx96rNNoo2sG7SCMxKf3mPSlXsdgtfyV8nr/3nsoKEWVb5lgqGEsFSax2IvrdDHsqv7QpvfvmQ
	XW1PKRB6UlLH7Bz0HqYN901KExgFSBTMrXoXKnrc9sE6YyRFRZOq0O1msmCwFgJ+nQnmMYakXDe
	lqgRvULlcPJcC8yxT/9116OqgTb8f8BVOZ2+Q6
X-Received: by 2002:a05:600c:56d6:b0:41f:f144:5623 with SMTP id 5b1f17b1804b1-421089cd2a7mr87129105e9.14.1716915584499;
        Tue, 28 May 2024 09:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENDkUt7a9n5FDj0leqZ1a4dve3iLZ9ui1mbXwQB/hi6rgdH3IEVR3zfNxFeYH9jdtjpkKEg2SNdQe6F4yTyQE=
X-Received: by 2002:a05:600c:56d6:b0:41f:f144:5623 with SMTP id
 5b1f17b1804b1-421089cd2a7mr87128885e9.14.1716915584113; Tue, 28 May 2024
 09:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515005952.3410568-1-rick.p.edgecombe@intel.com>
 <20240515005952.3410568-11-rick.p.edgecombe@intel.com> <12afae41-906c-4bb7-956a-d73734c68010@intel.com>
 <20240516014803.GI168153@ls.amr.corp.intel.com> <c8fe14f6c3b4a7330c3dc26f82c679334cf70994.camel@intel.com>
 <b6e8f705-e4ab-4709-bf18-c8767f63f92e@intel.com>
In-Reply-To: <b6e8f705-e4ab-4709-bf18-c8767f63f92e@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 May 2024 18:59:32 +0200
Message-ID: <CABgObfacywzF45FMM+ei=ei36CJDmfFvhWR-bzpqtqjjPWeF+Q@mail.gmail.com>
Subject: Re: [PATCH 10/16] KVM: x86/tdp_mmu: Support TDX private mapping for
 TDP MMU
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"Yamahata, Isaku" <isaku.yamahata@intel.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"seanjc@google.com" <seanjc@google.com>, "sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"Aktas, Erdem" <erdemaktas@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 4:11=E2=80=AFAM Huang, Kai <kai.huang@intel.com> wr=
ote:
>
>
> >>>> +       gfn_t raw_gfn;
> >>>> +       bool is_private =3D fault->is_private && kvm_gfn_shared_mask=
(kvm);
> >>>
> >>> Ditto.  I wish we can have 'has_mirrored_private_pt'.
> >>
> >> Which name do you prefer? has_mirrored_pt or has_mirrored_private_pt?
> >
> > Why not helpers that wrap vm_type like:
> > https://lore.kernel.org/kvm/d4c96caffd2633a70a140861d91794cdb54c7655.ca=
mel@intel.com/
>
> I am fine with any of them -- boolean (with either name) or helper.

Helpers are fine.

Paolo


