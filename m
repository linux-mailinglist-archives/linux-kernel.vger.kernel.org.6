Return-Path: <linux-kernel+bounces-231426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3143919895
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B609282883
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BEA192B65;
	Wed, 26 Jun 2024 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IsRdtuvS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE4BE6C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431685; cv=none; b=fcKDAMj/YNnrQmqjxVPZ9s/NRIaeEgA96keHoRVB+IqYWOm8kAjPKyJWDXcbuwT230I37/RVJ4rS6cfIwEK/qHliRNLPF0ExDE4CuDQe73RNVYU8U5vm8BZ2bcs23ULtsPHTIZYTJt0cEmupHdLUUq7BFkGGXDV1yQ4XBJbLjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431685; c=relaxed/simple;
	bh=UdHTQOSX7Km3cZSiYgkk31AZTE6moQgEO9Q5MH3sEME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ss9g0FqrHNVu/vgeVLIWdKouJ/qZOFx+KLWoM1PEgpbMxBWeXptM0yYKkq8+cYvbBIKqMMWblSKcIf6135e9yK6PLSoxAF/Hzs37LqVOyBj7T6mNTDrcLhechF0ej1vIigVdmyCsaHs4Gh8XkDprdwyZKkIDyB4cB9izlfC8kvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IsRdtuvS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-643f57e2f0fso100424027b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719431683; x=1720036483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPUXoB4WicVXeQU5K1G3z57co6ZndiCkVz/lqTR/Pns=;
        b=IsRdtuvSCGz8T6AlYP+noyGipOf3xqk7l49nUuD4wp4J+VuWWWJfv2ok1Zyjk8+QYO
         A3iyoXUsO4eaz4z6XZ5UIo6aRQehzCsmkexhTAV7ldH0eKSqAtVjhYRT9IhiobdZ3v26
         SwJ0+DlwWvRboyfgK6O4s2obsNEL/zhtYRQKn2N8Y71v3OKpl/qfgD0gcBKOndbRxqOx
         kEbUxYbaMTPDjIUUHqXtbJl/xSfRl3JnxODhuugXAhVhaxgaZxn3wh5wXvSC8IiJ0pId
         N/s/zOlD3iQrSgcYwEtrKkgkBQofnWIDTyMV4D4T0EntXqUSPf+WAypq4U6HtfMIAe4R
         cEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431683; x=1720036483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPUXoB4WicVXeQU5K1G3z57co6ZndiCkVz/lqTR/Pns=;
        b=k06QdYfHGNV/A1mzFAHUB8cqPen/8GJPsnWU4KIDELYWrLzJJ2YLlGizIBDl0INMfb
         878SvoV8/WJEytEPwrRMgaf/zeXdruskZX8t9iPgKkq/kV2n9UdEtJbF9HWcu0WdpYbO
         9B9RTQh/gvyz6G/nS1ZYcJVP1pyUYeQK194SdiyYLYp/+ceeSHqkSd7oZRlDz+6wzbF5
         Qd7tLPsvl2pNnqrja+w/NgqTM76axuWniiDYAzaI3U1l1s7F916avVxNrNW+f7DvNVHQ
         fZ6utVP044+3qX/505vFEiV+uy0DzCMghNWw9F6Frovy9r7HzWdjJubPRVYHk0APVEiT
         ub8g==
X-Forwarded-Encrypted: i=1; AJvYcCVAHZoaaIqEQ4soOoqqZ8QYibYOwDwn1SI1FoNrG2NtIc4GD3lrb3V2/fe+FqScZeM/+7zsU9FY2evOUVuM5EaOTAQfhmTan8HrWXlf
X-Gm-Message-State: AOJu0YyWh1rxL0yWByvUTsHwRKjBOIdO4V9Rp9rvaaR5SlfDAw4GYU2w
	y2ZdLVaDhLsST7JQ/gEF167UL/7/kzs6mzP5EML6Zfp3xuZSn6CVpYQ0eE4wRJMKxgygW/WB/Do
	+pA==
X-Google-Smtp-Source: AGHT+IF/MuePa6kq1/3pH9PDPsT95qNUWlvGn8Hv4+YHMNEXsj8xRxB+BfP0mTgqgttvjciz4uFSvH9s1i8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4c89:0:b0:648:3f93:796e with SMTP id
 00721157ae682-6483fa2bc62mr57577b3.7.1719431683355; Wed, 26 Jun 2024 12:54:43
 -0700 (PDT)
Date: Wed, 26 Jun 2024 12:54:41 -0700
In-Reply-To: <fbzi5bals5rmva3efgdpnljsfzdbehg4akwli7b5io7kqs3ikw@qfpdpxfec7ks>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621134041.3170480-1-michael.roth@amd.com>
 <20240621134041.3170480-2-michael.roth@amd.com> <ZnwecZ5SZ8MrTRRT@google.com>
 <6sczq2nmoefcociyffssdtoav2zjtuenzmhybgdtqyyvk5zps6@nnkw2u74j7pu>
 <ZnxMSEVR_2NRKMRy@google.com> <fbzi5bals5rmva3efgdpnljsfzdbehg4akwli7b5io7kqs3ikw@qfpdpxfec7ks>
Message-ID: <ZnxyAWmKIu680R_5@google.com>
Subject: Re: [PATCH v1 1/5] KVM: SEV: Provide support for SNP_GUEST_REQUEST
 NAE event
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, pgonda@google.com, 
	ashish.kalra@amd.com, bp@alien8.de, pankaj.gupta@amd.com, 
	liam.merwick@oracle.com, Brijesh Singh <brijesh.singh@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 26, 2024, Michael Roth wrote:
> On Wed, Jun 26, 2024 at 10:13:44AM -0700, Sean Christopherson wrote:
> > On Wed, Jun 26, 2024, Michael Roth wrote:
> > > On Wed, Jun 26, 2024 at 06:58:09AM -0700, Sean Christopherson wrote:
> > > > [*] https://lore.kernel.org/all/20240229025759.1187910-1-stevensd@google.com
> > > > 
> > > > > +	if (is_error_noslot_pfn(req_pfn))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	resp_pfn = gfn_to_pfn(kvm, gpa_to_gfn(resp_gpa));
> > > > > +	if (is_error_noslot_pfn(resp_pfn)) {
> > > > > +		ret = EINVAL;
> > > > > +		goto release_req;
> > > > > +	}
> > > > > +
> > > > > +	if (rmp_make_private(resp_pfn, 0, PG_LEVEL_4K, 0, true)) {
> > > > > +		ret = -EINVAL;
> > > > > +		kvm_release_pfn_clean(resp_pfn);
> > > > > +		goto release_req;
> > > > > +	}
> > > > 
> > > > I don't see how this is safe.  KVM holds no locks, i.e. can't guarantee that the
> > > > resp_pfn stays private for the duration of the operation.  And on the opposite
> > > 
> > > When the page is set to private with asid=0,immutable=true arguments,
> > > this puts the page in a special 'firmware-owned' state that specifically
> > > to avoid any changes to the page state happening from under the ASPs feet.
> > > The only way to switch the page to any other state at this point is to
> > > issue the SEV_CMD_SNP_PAGE_RECLAIM request to the ASP via
> > > snp_page_reclaim().
> > >
> > > I could see the guest shooting itself in the foot by issuing 2 guest
> > > requests with the same req_pfn/resp_pfn, but on the KVM side whichever
> > > request issues rmp_make_private() first would succeed, and then the
> > > 2nd request would generate an EINVAL to userspace.
> > > 
> > > In that sense, rmp_make_private()/snp_page_reclaim() sort of pair to
> > > lock/unlock a page that's being handed to the ASP. But this should be
> > > better documented either way.
> > 
> > What about the host kernel though?  I don't see anything here that ensures resp_pfn
> > isn't "regular" memory, i.e. that ensure the page isn't being concurrently accessed
> > by the host kernel (or some other userspace process).
> > 
> > Or is the "private" memory still accessible by the host?
> 
> It's accessible, but it is immutable according to RMP table, so so it would
> require KVM to be elsewhere doing a write to the page,

I take it "immutable" means "read-only"?  If so, it would be super helpful to
document that in the APM.  I assumed "immutable" only meant that the RMP entry
itself is immutable, and that Assigned=AMD-SP is what prevented host accesses.

> but that seems possible if the guest is misbehaved. So I do think the RMP #PF
> concerns are warranted, and that looking at using KVM-allocated
> intermediary/"bounce" pages to pass to firmware is definitely worth looking
> into for v2 as that's just about the safest way to guarantee nothing else
> will be writing to the page after it gets set to immutable/firmware-owned.

