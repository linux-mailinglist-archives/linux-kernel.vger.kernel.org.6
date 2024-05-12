Return-Path: <linux-kernel+bounces-176823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8568C3578
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 10:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2649328185B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E31757E;
	Sun, 12 May 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUTkl5V+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98E1C683
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715501844; cv=none; b=Xd0Wqbg6aaeeJSDrrcx7wGomLcmkdy7N4tWltfyeL8SSkiFv5tMR3Y6n54pTOZLAQtNMIUto0VeRej7u2HEI9nYUKvxFWjkP0QWxEXwkxbGnvW5CXxNYnXVOrh8skau86HJEYL3K1Xm/4hAVkejRZJCXzkvcdVvIZGCLfI47oYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715501844; c=relaxed/simple;
	bh=gy1fqqrNliFvIEA/4j3QrSKFmukTGVMtOxoq+znsGwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cz2LbwSI6/9KXo+tPIPtlH0LiAqRaT+pWqM5dkKcVUNrcv3K3bLXy2XUB30fzbmrdzju8AMyrh+yoTOyyzn8U9GYD5qAVxMjGFb94V+qGngflItY84mBcDewkmXQhfOcMXj3QMit2ud3nwWQh0dJeb1ZRwcU0rHOAvXkA93nm2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUTkl5V+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715501842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUSDVa+t4AWwqTmRuepudvFoykXU2aaVqb2V4N5FOvo=;
	b=FUTkl5V+jie1bCvRqx2dUQwMOvkUIOfFvj0Amc+yuchwABgTBYKR/fqLQptVX7kNLe0uUM
	yolVWZ2j845xeemeSAkzUqCG6Y7ODMOC+xtJOOc6uj7xkXiGpTDij04q7Z8DOU1h9sS8i8
	9rvuP6vdeDdTw5kV70NBb+GTy3SHuko=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-e35_CeI_PtKk1J3Uwom6nw-1; Sun, 12 May 2024 04:17:20 -0400
X-MC-Unique: e35_CeI_PtKk1J3Uwom6nw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34eb54c888cso2692275f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 01:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715501839; x=1716106639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUSDVa+t4AWwqTmRuepudvFoykXU2aaVqb2V4N5FOvo=;
        b=vYS3kha+5VEKvSuxdTEhC2XN2INB0zLcO47/MLkYILyCP2deLbbLB6PQPmcpWIYbv7
         OwJx+048kQt6y9XszV600nQY+rlt3vGM4r1VuWn1GHSRQGSmdU60bEMAtYBGP3wbklEC
         oZ0fv63QtIHsoXFTq+ANju6U+fZuF7JDpQ0XuVZhA5+shfg/TC08uOcXuGPK5Pse4/Nf
         LTLWZhDuEAOEK5+x5oUVvUjaBk3o5rjI4szycr1FzqiM6VrVVhPkzV3bx/wOGXI+xNgM
         oGTT/++zfGgxAkFQnNwnw0Qey8PSymkBlCppUG+Ij3wT6jD7MfCQTLxVydcKCt2E8aPb
         fXYw==
X-Forwarded-Encrypted: i=1; AJvYcCV35CmEvqArFQMVEB0Kxp7dPh04LucLMim6b7HOt5GBad5/qhX7H3NWVmkx5d9T3ZGX4C1WndO1vD/3Aofk4y2SxeVu9vBXvytgFLRv
X-Gm-Message-State: AOJu0YzO8nHO2v9wTyqNwVW5ak0Yb0+hc5SKhQr4HmRcgn21EtcCVFXt
	LEM4V7wiB8QcFddCL/eXmuTO/Tx9LdedEKp7leNi0ZA2lBzkabVxxhGcfNPZ5yjMeA86ilqbCwi
	f55kAgP+HGFgVXMFwIH5blewVQ8aZ+z72Z89cMN/LzZ83vnAn+cX/E2mrCkstmpNWZ1xX6Er0dW
	7fBIueJQ1ptIyj0L5remyEDHhReJtOjA6wTfB8
X-Received: by 2002:a05:6000:a88:b0:34c:e62a:db70 with SMTP id ffacd0b85a97d-3504aa63447mr6802446f8f.67.1715501839315;
        Sun, 12 May 2024 01:17:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKCS7P8m0E2FzwUMTNi7Ql+HIEI6NbkihSJrrDNgDeVBjsAxZChtVoPCY2m8yJvJpjjb/lbmUnz6gptq1HRKA=
X-Received: by 2002:a05:6000:a88:b0:34c:e62a:db70 with SMTP id
 ffacd0b85a97d-3504aa63447mr6802413f8f.67.1715501838935; Sun, 12 May 2024
 01:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211024.556136-1-michael.roth@amd.com> <CABgObfZxeqfNB4tETpH4PqPTnTi0C4pGmCST73a5cTdRWLO9Yw@mail.gmail.com>
In-Reply-To: <CABgObfZxeqfNB4tETpH4PqPTnTi0C4pGmCST73a5cTdRWLO9Yw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 12 May 2024 10:17:06 +0200
Message-ID: <CABgObfZ=FcDdX=2kT-JZTq=5aYeEAkRQaS4A8Wew44ytQPCS7Q@mail.gmail.com>
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

On Sun, May 12, 2024 at 9:14=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On Fri, May 10, 2024 at 11:17=E2=80=AFPM Michael Roth <michael.roth@amd.c=
om> wrote:
> >
> > Hi Paolo,
> >
> > This pull request contains v15 of the KVM SNP support patchset[1] along
> > with fixes and feedback from you and Sean regarding PSC request process=
ing,
> > fast_page_fault() handling for SNP/TDX, and avoiding uncessary
> > PSMASH/zapping for KVM_EXIT_MEMORY_FAULT events. It's also been rebased
> > on top of kvm/queue (commit 1451476151e0), and re-tested with/without
> > 2MB gmem pages enabled.
>
> Pulled into kvm-coco-queue, thanks (and sorry for the sev_complete_psc
> mess up - it seemed too good to be true that the PSC changes were all
> fine...).

.. and there was a missing signoff in "KVM: SVM: Add module parameter
to enable SEV-SNP" so I ended up not using the pull request. But it
was still good to have it because it made it simpler to double check
what you tested vs. what I applied.

Also I have already received the full set of pull requests for
submaintainers, so I put it in kvm/next.  It's not impossible that it
ends up in the 6.10 merge window, so I might as well give it a week or
two in linux-next.

Paolo


Paolo


