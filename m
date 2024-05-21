Return-Path: <linux-kernel+bounces-185240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BEC8CB28A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FEA1F22A15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF4147C73;
	Tue, 21 May 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb46SCg4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0B3B1A1
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310545; cv=none; b=qmFizRN3mU3nN1bK0a5hdQQy3D5/Y3qGlab1PRWv7dUfzAYS06B3abXMt/F5i7rQG93X28epzf6bHud4VJalbKQmXfegwhbQY6M2SKCG6g26vwkcE3ezEWrvn1BKUajWU9eNkzjfs2u6RyeFkfMNDaYx0EsweCqw/+9GGRMHf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310545; c=relaxed/simple;
	bh=/wuAJC1w5yftMI0o8cg7kslpgnu8UCvser+y8SmYrCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq3MtWNJ1Ee4A/YgnhUplx1u8lxWQJA/I73lIJ753fmc9jspiOKHO5IAazmn8yBLJnVqSiikkYMb8y263RlM2Ow5t7m11qHk5zg33dl3HwHxzkYedMS06yx4rs1XUDYliseLHhqajL/vhkC3mucr2Sq/s+Tk8UyyqQR1AvIflZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tb46SCg4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716310541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+WOIyoRkBFayEEwR1EeFv+13Px+tyGmBKyKL4lnBng=;
	b=Tb46SCg4N3nbE1eqA6l5Elku4KTd077O5Pk3QlKuba6a2ulJ/k4xUfqCPE7PxHUHd4rYcR
	riSmem2MVC8cQiRXNVP04FtHzdD8JdHI7tSoVSwkmu1Lx2cCzfTPq2fvvHlhOEEfVcolfO
	n5h9YXaNj+rgpROh8yqkQBFzC+/pEnM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-2481PuhxPEynbk4nNELqHQ-1; Tue, 21 May 2024 12:55:39 -0400
X-MC-Unique: 2481PuhxPEynbk4nNELqHQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-351bf7f7f73so5498024f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310538; x=1716915338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+WOIyoRkBFayEEwR1EeFv+13Px+tyGmBKyKL4lnBng=;
        b=YocSpxvJKOv7avTupVypZrElvb06fNcNkgVIr6JztQu7rcDimmTn8ul8UQe3v5z54l
         blIoj0IDhfAgoix6dddf6u8qhYX9uIkSsoSqbST59OUFb5FAGs+nCxjfbrSGiyLbvbKD
         imRlIUOevo6a+3TwGXSvmLsHiz5rP2tKrXo1aKVLw769T68g+SeGD2EmXYQKP9GBsvgE
         2YlXHu9465SrKwIY2EjaLkoTiuHZJb8Q0ULjy4eKN7dLcEnKZXzOidtrmYPs66apnosC
         x3ryxONIIiDEv2g2gQMHBwv8Dxk/sVyZiIs7+47ENibMylH9ZqUomIyyB/iNYzPnyA0Y
         aHxg==
X-Forwarded-Encrypted: i=1; AJvYcCV1h/CYQ/DHR0Xx6NGXlL3qY+PV4nb+JuQbIRzrqsJLhed6Y9Q8IPAMV6loYY6IyiOez0Uq4lHUtENuvgLHCemjgoL4rQCXZtHpTW0E
X-Gm-Message-State: AOJu0YxyNY3wdHfWOZOjBvLnWojbBWtZYRLqtPvJI8+J4Bb0ZbewATx1
	3FNPXyXnA5C0+OvyfycqRd0BKqgauy+nbcLXGxGgYrM2XfuibbxxoAhPO/EPiGJ9++cBI3kwWx/
	6lNWp5VOvOYN/Gh8jgTt9wjh3+pfZzF7YQj4UD/13P+/TjzEmVSUp0IL+c2XekkT8TBkn5WVKKW
	gvS5RES34lBUu9JjbdwMADoXezqN+ym5kzx0fS
X-Received: by 2002:adf:f508:0:b0:351:c960:b5af with SMTP id ffacd0b85a97d-351c960b862mr22459233f8f.17.1716310538541;
        Tue, 21 May 2024 09:55:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGqOdd7EWG1bVC7EJzEy0rTU/G02HAaexFKAULe3IexA29zh4Kwm16mv5leNGvtmmzZXrBGU7o+wcQgtPgx14=
X-Received: by 2002:adf:f508:0:b0:351:c960:b5af with SMTP id
 ffacd0b85a97d-351c960b862mr22459212f8f.17.1716310538132; Tue, 21 May 2024
 09:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211024.556136-1-michael.roth@amd.com> <20240510211024.556136-14-michael.roth@amd.com>
 <ZkU3_y0UoPk5yAeK@google.com> <20240516031155.meola5hmlk24qv52@amd.com>
In-Reply-To: <20240516031155.meola5hmlk24qv52@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 May 2024 18:55:25 +0200
Message-ID: <CABgObfbxz9aWNg0G8xjjBQ-aXLvMeS7WO+zJghKmbZSx2XOUpw@mail.gmail.com>
Subject: Re: [PULL 13/19] KVM: SEV: Implement gmem hook for invalidating
 private pages
To: Michael Roth <michael.roth@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:12=E2=80=AFAM Michael Roth <michael.roth@amd.com>=
 wrote:
> Longer term if we need something more robust would be to modify the
> .free_folio callback path to pass along folio->mapping, or switch to
> something else that provides similar functionality. Another approach
> might be to set .free_folio dynamically based on the vm_type of the
> gmem user when creating the gmem instance.

You need to not warn. Testing CC_ATTR_HOST_SEV_SNP is just an optimization.

Paolo

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index dc00b89404a2..1c57b4535f15 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4676,8 +4676,7 @@ void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t e=
nd)
         bool assigned;

         rc =3D snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
-        if (WARN_ONCE(rc, "SEV: Failed to retrieve RMP entry for PFN
0x%llx error %d\n",
-                  pfn, rc))
+        if (rc)
             goto next_pfn;

         if (!assigned)

Paolo


