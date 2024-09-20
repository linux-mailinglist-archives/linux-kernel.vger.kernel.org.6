Return-Path: <linux-kernel+bounces-334650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958CB97D9F2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0481F2211C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 20:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB68D184542;
	Fri, 20 Sep 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXBayyYf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0B17DE16
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726862775; cv=none; b=r5/eMWprrJ1VfU1BBhKgyoRpethB+pMKjQIUreHSWiF7UEFL1dQe+R92AwbKmr0MjcLmNDG/b25nv1K/uJgdN0iSyBM6r97CWwlYpKMyjBUazDUDVm8iUPeYabs16i+06yY3IwqnjlaObhzyUaT51sQvxq9oiXzrtuRovGUfQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726862775; c=relaxed/simple;
	bh=CBzB9DegP9xT4r54u9lCf8GGxVgSTyGf0f4wQB/TSB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRtHMuy59cyQLMu65hKk58elFVZCaNVrY1QbEzmb14PpwbHcbVTD2MeJHCr6gedxIbXXIHjr0m+gCMcsHt8ZHdBhrVrRSKa+NTnb4jM8dSMAC15gGKmDovmbg+A70/n9/nEotzSVDk1I3PFKypr7Jk9uw/HOiprVsIEe5OeyJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXBayyYf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726862771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B12ZD5DrYH7h8WzDfAk/iI3QEtMDIKemU/ORBWuCezM=;
	b=IXBayyYfXmWAcbBYbukD+Q8ANXEPmGEQMnh20OsDgAIPL4JL3i42GMo1MEjqIz+dbI1yJK
	aodb1+M/Gt9hgbzJuHHylGSHB1C9mi4TbZNMWB/5ooixP5ZfEO390kjk/TfMqp79mqKxJP
	ljQ1Vf+Vmfdj6mRfHdNw6lVw8TOhXdI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-yS2OVpO3NoS0WpsJk2DOvQ-1; Fri, 20 Sep 2024 16:06:10 -0400
X-MC-Unique: yS2OVpO3NoS0WpsJk2DOvQ-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-27808f6bfefso2581722fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 13:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726862770; x=1727467570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B12ZD5DrYH7h8WzDfAk/iI3QEtMDIKemU/ORBWuCezM=;
        b=ha5XDZZGIzh496F02+BJsTomu4N9/5uEZE0W7nBKoi2QQiKc0usYGGgzOhYWSvPhye
         iIR/D9iTnAJZz3ui8y0VUWL/K/+DBuQWsME7M+Bddo2AIrkaLW7b5LnwqW3ZPY2dIGlz
         dTadFuFSK4D0ylIsmeEG7nBhKsjYtm0QVMyWljsr7HyxeumKuHZ4KIriKZxFgtNT2X8n
         7N1GEU3eMhxcY11GhvY5XUSU5FFKvTy2dAV0iiWEY8sQh4xC3QC5KYuJ0v9dc5phy8P7
         G1mbJcqP0KMEreNn37j+WOfi+N1YL6PTD+u7u6vyXzs8F+puSFrAWbxUyWMSytXA1knF
         VZIw==
X-Forwarded-Encrypted: i=1; AJvYcCXSXIbd5hilrEHO9PXjfxitRAda3zMN2XTbULoa67frdI8t1hsJXmTdhiBhfTh2s9VxBuKLs5WCnw5ZkJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+nT/xTGFBcanBKg3VBn9mFayBYSUEsd6oHnRfPWBphONMNNk
	Pajtv5p5yuN2cYthLfa13NWpzPESkbaizHB3t6OpEgDdgj7xFRUHR6C/x3E5l6cRmQ6GyOfCgMs
	HWK5mtIiO8+VNf5MmhpQQdbJBIfZRkbXqU2qKP8gPdkQ9TDj6wfeoRG2b0LGJvKFB1OWB9+lzLZ
	ngfHCV1bkZiSqV2QT7MhAROVye7knzVCehpYY1
X-Received: by 2002:a05:6871:3386:b0:261:16da:decb with SMTP id 586e51a60fabf-2803cf16e10mr2878964fac.11.1726862769929;
        Fri, 20 Sep 2024 13:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzLMErzxKrlp5+s01Bs/w34iga0hgVQrzjiKIRpy3VgDl8ZH9K2nNWMJDRDpc/rwlHypFpOm8CN4+mcEVsWpU=
X-Received: by 2002:a05:6871:3386:b0:261:16da:decb with SMTP id
 586e51a60fabf-2803cf16e10mr2878942fac.11.1726862769636; Fri, 20 Sep 2024
 13:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720728319.git.jstancek@redhat.com> <27899413.1r3eYUQgxm@skuld-framework>
 <CAEg-Je_MXyP_PNj_QOu66SW_XYHy0zv0PnTTxX2qWELRG+xM_w@mail.gmail.com> <D4B7ZCR4XWCT.3TWNN24TA8PSF@iki.fi>
In-Reply-To: <D4B7ZCR4XWCT.3TWNN24TA8PSF@iki.fi>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 20 Sep 2024 22:05:51 +0200
Message-ID: <CAASaF6zhiDdbfYkgg7wENih2Lp309eUgeu=FHZm0yYaEBt2gRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] sign-file,extract-cert: switch to PROVIDER API for
 OpenSSL >= 3.0
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Neal Gompa <neal@gompa.dev>, David Howells <dhowells@redhat.com>, dwmw2@infradead.org, 
	zxu@redhat.com, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Asahi Linux <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 5:34=E2=80=AFPM Jarkko Sakkinen <jarkko.sakkinen@ik=
i.fi> wrote:
>
> On Fri Sep 20, 2024 at 2:42 PM EEST, Neal Gompa wrote:
> > On Tue, Aug 6, 2024 at 4:27=E2=80=AFPM Neal Gompa <neal@gompa.dev> wrot=
e:
> > >
> > > On Friday, July 12, 2024 3:11:13=E2=80=AFAM EDT Jan Stancek wrote:
> > > > The ENGINE interface has its limitations and it has been superseded
> > > > by the PROVIDER API, it is deprecated in OpenSSL version 3.0.
> > > > Some distros have started removing it from header files.
> > > >
> > > > Update sign-file and extract-cert to use PROVIDER API for OpenSSL M=
ajor >=3D
> > > > 3.
> > > >
> > > > Tested on F39 with openssl-3.1.1, pkcs11-provider-0.5-2,
> > > > openssl-pkcs11-0.4.12-4 and softhsm-2.6.1-5 by using same key/cert =
as PEM
> > > > and PKCS11 and comparing that the result is identical.
> > > >
> > > > Jan Stancek (3):
> > > >   sign-file,extract-cert: move common SSL helper functions to a hea=
der
> > > >   sign-file,extract-cert: avoid using deprecated ERR_get_error_line=
()
> > > >   sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >=
=3D 3
> > > >
> > > >  MAINTAINERS          |   1 +
> > > >  certs/Makefile       |   2 +-
> > > >  certs/extract-cert.c | 138 +++++++++++++++++++++++----------------=
----
> > > >  scripts/sign-file.c  | 134 +++++++++++++++++++++------------------=
--
> > > >  scripts/ssl-common.h |  32 ++++++++++
> > > >  5 files changed, 178 insertions(+), 129 deletions(-)
> > > >  create mode 100644 scripts/ssl-common.h
> > >
> > > The code looks fairly reasonable to me and behaves as expected.
> > >
> > > I have been actively using this patch set for several weeks now acros=
s
> > > linux-6.9.y and now linux-6.10.y with good success.
> > >
> > > It is in use in production for Fedora Asahi Linux kernels with good s=
uccess.
> > > Thanks for the fixes. :)
> > >
> > > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > >
> >
> > Jarkko, could you please consider submitting this for inclusion into
> > 6.12? I've been carrying this for three Linux kernel rebases now
> > (6.9.y, 6.10.y, and now 6.11.y) and it seems to be just fine, and
> > without it, I cannot build kernels anymore with the OpenSSL engine API
> > disabled in Fedora and CentOS/RHEL. I also expect that the engine API
> > will disappear on other platforms in the near future given its
> > deprecated status and recently accelerated conversion of engine
> > backends to the newer provider API.
> >
> > Thanks in advance! :)
>
> Yes, I think I can. And I've yet to do 6.12 PR because I've been
> busy sorting out perf regression in the TPM driver.
>
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #66: FILE: certs/extract-cert.c:69:
> +       OSSL_STORE_CTX *store;
>                       ^
>
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #93: FILE: certs/extract-cert.c:96:
> +               ENGINE *e;
>                       ^
>
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #199: FILE: scripts/sign-file.c:114:
> +       OSSL_STORE_CTX *store;
>                       ^
>
> ERROR: need consistent spacing around '*' (ctx:WxV)
> #229: FILE: scripts/sign-file.c:141:
> +       ENGINE *e;
>               ^
> Any ideas of these? My guess is that they are unfixable and related
> to non-kernel-standard code.

This looks like false-positive. Following will produce same error:
+#if TEST
+       ENGINE *e;
+#endif
+
$ git diff > 1.patch; ./scripts/checkpatch.pl 1.patch
ERROR: need consistent spacing around '*' (ctx:WxV)
#10: FILE: scripts/sign-file.c:217:
+       ENGINE *e;
               ^

total: 1 errors, 0 warnings, 10 lines checked

but if first type in #if block is something checkpatch recognizes,
then it reports no issues:
+#if TEST
+       int i;
+       ENGINE *e;
+#endif
+

$ git diff > 1.patch; ./scripts/checkpatch.pl 1.patch
total: 0 errors, 0 warnings, 11 lines checked

Regards,
Jan


