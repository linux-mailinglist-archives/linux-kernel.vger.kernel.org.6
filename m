Return-Path: <linux-kernel+bounces-199458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA538D876C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EB2283AF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC613699F;
	Mon,  3 Jun 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpRKLdSB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AA8060D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433087; cv=none; b=PW6p9K6PaFicX70dWrF0M7n89RdXJKyqHaeicgHTvL+lC99giTSr9m9GzafdXnXxw1GDzbfITbJ55OSFwTSosM2NlnByH/rAwrKTj0ioxcEzNlU8inCM9jbNSMqCTPAS/Tti3TpLcZ5lhqcvRCIpAy3N73nzeZ9Oj4r0XnnLFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433087; c=relaxed/simple;
	bh=t4eoPsxvhm/UX72ypmID6dj2keloK0/DxVJPrFRAldI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqJgL3XRz/3omtoje6ih3vDOQNgGb7ju/Mi8ROsXTGwxehaSgNR5c3Pq7t5WcX2qGRD80IPp8qZXLH/ao9TmY5Qcv4KsaA+dzPcTn0+QNqAyocpS0xUwiOdv52b3ABFGxqjwynNYpTj9CoyDSgeVf41ELZhKBZmrxDFBjtMAqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpRKLdSB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717433085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkJhM79a8R11avJivbxxdE1EejxLWPTC2S55x7A+4us=;
	b=VpRKLdSB3owQrmEgzvT6ABXi1wKxYr2MN2vSa0JBJuFqad+fvhNqq+kk9/mimWHSvTIbSz
	FhLhVS4QtR1iIcfx4AtUwt8jQbrjOBXf42uFqsZzisPCjCABefNiZmcljQeIKXcoRh3bQ3
	JLhQlakWgR5En/YDaEe5yhKmnaM5rK4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-errRmU8HPbWczMCWGdT3dw-1; Mon, 03 Jun 2024 12:44:43 -0400
X-MC-Unique: errRmU8HPbWczMCWGdT3dw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4213530af1aso12984375e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433081; x=1718037881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkJhM79a8R11avJivbxxdE1EejxLWPTC2S55x7A+4us=;
        b=X9tEhII0QCE46PQ1b77WR0hkKsmxvJOOkX7psEbZo6UiHChzFlefzc4FislKgNtLUG
         PBxtRBskl2rmKCsr+lu045yG3Z+sGFFrlfyO2756heiUENiJlRXBdpkoTyblMKIgq/Kq
         0ZlAZkS/8X38KgxyGVrblS8l3RnSOonruFe1KPgBdW1gEJOrtV/9gYVQ444SusYJRgRS
         D0qyvBjyStT2pg/BAKFwfHq0iT1pzwr+ZSN6mhpW9JO93O/imY6zehkzVrI7qcq4coUj
         kqAMEGbNQFnGKiM9gHgI/FzA4JVc+6XoooSiaw4nCGk/EtrLLKE2q6dv5dgDKVZjRHrW
         c69w==
X-Forwarded-Encrypted: i=1; AJvYcCVLNH+bSLoFLOjWXLmYC5y5XxN3xPdq3tTxueE1XgHc8uNde5V26sgBoLFBN3+00YgzvmBzFxDBkfrQg48KFM/hi8O5VhitQuL0Kr2k
X-Gm-Message-State: AOJu0YwvmInk5ibjW8OPVXT7mzzGphaKTd35vt+3wxK5juzNWUgY3PWc
	dZ6Cn1k5zpNIpJVY+XyqHjhQoei8/5H9lZRNP3nvkBNs+UzvrV6C8Dd5wHyLCsnzJmp3H+pMA3i
	xp7UvWggV4+sXNvdAwpFfiUdGjGz+r59vc28k7qOrxbtBZBC5JHyDouXrMEyenPqf/pPcl7SWbL
	5TRx+qNHYVHVkJla2+imddyoKbiQf3KaOub2xI
X-Received: by 2002:a05:600c:4744:b0:420:2983:2229 with SMTP id 5b1f17b1804b1-4212e07530emr82210715e9.22.1717433081463;
        Mon, 03 Jun 2024 09:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMCnI5M+sIjdtgeYl/SuU7qEpdctfImP4SJ6aepSaIJ9r0QcVVw+D6lCCYSXtw8KRc+Y06WU8alk5VEuqo8TA=
X-Received: by 2002:a05:600c:4744:b0:420:2983:2229 with SMTP id
 5b1f17b1804b1-4212e07530emr82210525e9.22.1717433081090; Mon, 03 Jun 2024
 09:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211024.556136-1-michael.roth@amd.com> <6nby33glecw46wrdws7vuokrqz4b72evrzdujcrsm6pujo62b6@xoxstkzsvwrj>
In-Reply-To: <6nby33glecw46wrdws7vuokrqz4b72evrzdujcrsm6pujo62b6@xoxstkzsvwrj>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Jun 2024 18:44:29 +0200
Message-ID: <CABgObfbT_v23LbP7Mp-PfbnakHYrZ7+g3KfUA_BOnsp+7ivMYQ@mail.gmail.com>
Subject: Re: [PULL 00/19] KVM: Add AMD Secure Nested Paging (SEV-SNP)
 Hypervisor Support
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, linux-coco@lists.linux.dev, jroedel@suse.de, 
	thomas.lendacky@amd.com, vkuznets@redhat.com, pgonda@google.com, 
	rientjes@google.com, tobin@ibm.com, bp@alien8.de, vbabka@suse.cz, 
	alpergun@google.com, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, papaluri@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 5:23=E2=80=AFAM Michael Roth <michael.roth@amd.com>=
 wrote:
> As discussed during the PUCK call, here is a branch with fixup patches
> that incorporate the additional review/testing that came in after these
> patches were merged into kvm/next:
>
>   https://github.com/mdroth/linux/commits/kvm-next-snp-fixes4/
>
> They are intended to be squashed in but can also be applied on top if
> that's preferable (but in that case the first 2 patches need to be
> squashed together to maintain build bisectability):

Yes, I'd rather not rebase kvm/next again so I applied them on top.
None of the issues are so egregiously bad.

Paolo


