Return-Path: <linux-kernel+bounces-568444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACBCA69589
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C434174F25
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA83B1E5205;
	Wed, 19 Mar 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISiJ+Uoq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF41E1A2D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403203; cv=none; b=N+WUGOQZZszSOzMMRmmZzAyj3ETY2WSkD5Ac8i++pDMHAr5vvOHD6BPTC8HhbGsUbmjyD9Yc+ILHtmomIop2TgpZ2xKBcMg1MjXadgPvH8CxnBAhGN4QNqStFv++LZMSEblk7DO+VYrEQDXxxShxUG2zhRhh2PfolQaqgJWSP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403203; c=relaxed/simple;
	bh=gZ91fGn4VM1jhjIigc/roNld//H+y2pnwO3JvtN5t1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjOq3MtXTGgrUgmZPdK83EagY2xj9D/wwcr63M3hSFdDt19jFOnlxF9HJKTyiThujLIFk+SsB3qBfMlW8jCnfV5A3X3aYmrIZ95PrFx59BhkSKGJOxphYb3+6Zdw8NkEtBxp3kxvFNtdCTRpGwWNpBsC9F03JqNw9QS1850g0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISiJ+Uoq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742403200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMYidfuF22qqOjt7R1FtIa+eC5SY/DINipfXYLFNQ3c=;
	b=ISiJ+UoqPwtVq6m+dNCWnEsPb6Bycwb1bF++P7WWKUmby24d8vz2aMG4LtmrCvTGmyPQA7
	HiX3U9bsk5gIpvZIga0MHEbN0OMrIb7JEcFOhimn1cqngQaJuaBZzF7mPMM3wnv/n4EjMV
	4J0xSXSeaYEl1WOy0sILhFPAHq7r6oo=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-1_wF92rZPmiHCoGqUGt9PA-1; Wed, 19 Mar 2025 12:53:19 -0400
X-MC-Unique: 1_wF92rZPmiHCoGqUGt9PA-1
X-Mimecast-MFC-AGG-ID: 1_wF92rZPmiHCoGqUGt9PA_1742403198
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-86de09a23c8so496625241.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403197; x=1743007997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMYidfuF22qqOjt7R1FtIa+eC5SY/DINipfXYLFNQ3c=;
        b=hQpI267apEFQ5Kqzb5U7We3GpZmo75e51EmW612jH8z6PZ8kMRH7hT1u5WWXRWJUfi
         t41x+Qe7NQMvavfYSPCIEoQX+8WvHHdERA3v9mO4jf8S7zKVDHB5FhuiXIM0ua5qLHJ7
         2z9pkTV7HAX5SmlIBWv2QiZOsoFkVQYAtSePDLsE4gyGxG+FOQ9Yp0pPxoI0d5wj0ZK7
         r+3RNabYxyXBTEpW0sB8G4FtsiTSJfvStWumgjxGiq7vU8RmY4g5Dt35gigVhk0x1GU7
         yGFPxOfycFjQdrvkYxD4fncx5/aoXfIWmZd86RVi5mceFhTwbSN9tBEqWxUE2Q5wBxj0
         rNnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7wu/yEHQdqTYInpQ9jg17gbjqC1/ZwDlRw2QHOD8FMYSNqo+Gq1htRL3jJR9fORBxf/M9sS/BILKW0ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZC/n7tPPQA3/J6XRbazw0t7IUPpVfUDCyn5H7+Iypw8FIMr7
	AYuwMH2nZVns0nC6+fckBR7BC5BpEjbuvMOJYkzcem333Pztds2SuCMZBfLADOlK70VaaU/37Wm
	kX3cXhJmaGUNnyWcBxk9WEitfvtflZIsz17BYH48wRuyjNN7FJJwQsdFqLuT1WS7399Kb24Que2
	cKCUYgR6L3qqMGuW2T7r64Xcd8t89tJsoWo6u9
X-Gm-Gg: ASbGncsS7fTqnNCQhgS7ABoXwu8hwBj8cZomcIN0YtKpimqoihX0F0EnRXmfsahf75X
	iWgmIpNvR9BUj/3ZyWk9dd49fpcF++mL91nSFhVE2gDF6cQpG2d128+8imSQV/pbDiKs8wTEC
X-Received: by 2002:a05:6102:c04:b0:4bb:d062:455 with SMTP id ada2fe7eead31-4c4ec2f2e0cmr3397549137.0.1742403197619;
        Wed, 19 Mar 2025 09:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBaHItzcn4FKUvbMcp1OcW2oWpcGSy2J17LaT6TvPL1Qm1q4Ep4ILwSlmKbFP+qP7MGksmGbNbt7PDdKxGz40=
X-Received: by 2002:a05:6102:c04:b0:4bb:d062:455 with SMTP id
 ada2fe7eead31-4c4ec2f2e0cmr3397539137.0.1742403197256; Wed, 19 Mar 2025
 09:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064031.2971073-1-chenhuacai@loongson.cn>
 <20250319064031.2971073-4-chenhuacai@loongson.cn> <2025031943-disparity-dash-cfa3@gregkh>
 <Z9rYQy3l5V5cvW7W@t14s> <2025031942-portside-finite-34a9@gregkh>
In-Reply-To: <2025031942-portside-finite-34a9@gregkh>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 19 Mar 2025 17:53:02 +0100
X-Gm-Features: AQ5f1Jq9puc3zDkRAXP8CifSCOyuo9iakTiG2zcMin5No34Rk7G5vb8HVg7uT8A
Message-ID: <CAASaF6zNsiwUOcSD177aORwfBu4kaq8EKh1XdZkO13kgedcOPA@mail.gmail.com>
Subject: Re: [PATCH 6.1&6.6 V3 3/3] sign-file,extract-cert: use pkcs11
 provider for OPENSSL MAJOR >= 3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, R Nageswara Sastry <rnsastry@linux.ibm.com>, 
	Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 19, 2025 at 03:44:19PM +0100, Jan Stancek wrote:
> > On Wed, Mar 19, 2025 at 07:13:13AM -0700, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 19, 2025 at 02:40:31PM +0800, Huacai Chen wrote:
> > > > From: Jan Stancek <jstancek@redhat.com>
> > > >
> > > > commit 558bdc45dfb2669e1741384a0c80be9c82fa052c upstream.
> > > >
> > > > ENGINE API has been deprecated since OpenSSL version 3.0 [1].
> > > > Distros have started dropping support from headers and in future
> > > > it will likely disappear also from library.
> > > >
> > > > It has been superseded by the PROVIDER API, so use it instead
> > > > for OPENSSL MAJOR >=3D 3.
> > > >
> > > > [1] https://github.com/openssl/openssl/blob/master/README-ENGINES.m=
d
> > > >
> > > > [jarkko: fixed up alignment issues reported by checkpatch.pl --stri=
ct]
> > > >
> > > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
> > > > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  certs/extract-cert.c | 103 ++++++++++++++++++++++++++++++---------=
----
> > > >  scripts/sign-file.c  |  93 ++++++++++++++++++++++++++------------
> > > >  2 files changed, 138 insertions(+), 58 deletions(-)
> > >
> > > This seems to differ from what is upstream by a lot, please document
> > > what you changed from it and why when you resend this series again.
> >
> > Hunks are arranged differently, but code appears to be identical.
> > When I apply the series to v6.6.83 and compare with upstream I get:
>
> If so, why is the diffstat different?  Also why are the hunks arranged
> differently,

He appears to be using "--diff-algorithm=3Dminimal", while you probably
patience or histogram.

$ git format-patch -1 --stdout --diff-algorithm=3Dminimal 558bdc45dfb2 |
grep -A3 -m1 -- "---"
---
 certs/extract-cert.c | 103 ++++++++++++++++++++++++++++++-------------
 scripts/sign-file.c  |  93 ++++++++++++++++++++++++++------------
 2 files changed, 138 insertions(+), 58 deletions(-)

Should be easy to regenerate with different diff-alg for v4.

Regards,
Jan

> that's a hint to me that something went wrong and I can't
> trust the patch at all.
>
> thanks,
>
> greg k-h
>


