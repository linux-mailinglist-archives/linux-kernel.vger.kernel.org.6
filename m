Return-Path: <linux-kernel+bounces-576939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4FFA71647
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA32D3B2B16
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565AE1E1DF9;
	Wed, 26 Mar 2025 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGAzs9Mq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C501DB933
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990979; cv=none; b=eLPAD9E9FdimCTqgzTyRrbVh6Kh2XwO2kzHXE1MsrqQPCgVIyKGxq3SimiFK79wW8Yel3nV4eM7kl7o3nL6qumqEPn+OgleQM+8DlK46MC+mvaEEPOBqmevt1rWP0rwgar4I4a85PNuz4Uneg5UHmoKiEttdjbOWZ3OPgnjOr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990979; c=relaxed/simple;
	bh=Rn7DZzluTD2+MZZoYt3D0u5sryYqeFHqvQWAx2OGmqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2n6W6LQ3ECEL2sjLdPF9dR4QdcYRv31n/36kwN71zjqnZkFqw0k+0rxecyQDrLpIGtVHuDF+T7mlGuHWhPB4R/XQ9Pl++7RTcPBUJQCXnJgTv9ADEk5GOa/ETClGolgL5GV7zLaLhUqG40tAjp4yy0v+1l2yacIz8lHM07IUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGAzs9Mq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742990976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nDjBICGKa43kYHEOCFvDUYcy1IhXoeMUQwDGcLiaSWE=;
	b=cGAzs9MqdHaNBxWQeJL0rKDam3ohrhknI/RrCigCFE6yiyFvLvfmcPKsU/+sw8YOVOeBlE
	HAJ/KXBrlP2gyA5Xgb3tUMTtGHGWK3KlgD4vAZeliPyVIAqceJ/bj0zxbw3HRtw3Qnxr2Z
	7gqMtv3fFnCs2pR0Q1lYZalV3CUgW2o=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-ttrQUBu9MESdf-Ob5eFoIQ-1; Wed, 26 Mar 2025 08:09:35 -0400
X-MC-Unique: ttrQUBu9MESdf-Ob5eFoIQ-1
X-Mimecast-MFC-AGG-ID: ttrQUBu9MESdf-Ob5eFoIQ_1742990975
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3827969dso676700539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990974; x=1743595774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDjBICGKa43kYHEOCFvDUYcy1IhXoeMUQwDGcLiaSWE=;
        b=PKsfNzovV3yj8gBRQsetA4+iJh4QUBbqmwAfFRXnvo1BurJKEcUzonqxneFv0qX1Dy
         5VKQNaDftFMbQRvC1EGZlUnOHq9khMbBavDcucuTn1SNQOf79SuCeggdeQem837rh8kV
         icwjijWcQbFCFu3SeL9JueAvRrCXdCnobjQo6paNb+UDF/koqQXJ3wp9ObvN8AGRVCG7
         yYF5xwSc9ozJ2DV5O00t7q2Szz5EWCs6l7uak5IMXe4k/sydIO0SbC+Qu22P8BPHmQ1D
         BGUevkVOJTjSW1j4UlubDlw1RCDrJLpVAWlkhLNZ+GQrBmYF2FaxdA3NKKe8VY8Mr+Uo
         G5/A==
X-Forwarded-Encrypted: i=1; AJvYcCXuupHuQ/g6xWN2bR4YxqsTIQF5JEnGa2LQyueQJyU6WYonG6uG1uaMIa8be9fCL5E6w8CWDKdQaZsSGIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3Rd6kYqNlbhnJSXxyyDuzqJXsxDcmibEnRCkxmeNNRlJ0AdF
	cM7PZKYtufifsB5biZQzkXShyH3IWEfPfvroq1oGazJ1/2cQ6jMZlyDpDP8Eg5RSGfeuf47HnCI
	UfYQR6WrTxRb0g1k0cfZL6wD+vvad2OvDp02fHG/oUTamP2XdGebZACwndz5EbOp+EIL/TcH2TB
	evg9QSfJs86+LlRg1PVXg6fasuEw6EODSuJU8a
X-Gm-Gg: ASbGncv6d/TzpR+nRbX4cvWCydjcQQVQo+FqO/y7JOXcIokLtYOTDt/kMEWzTOADf/s
	K0XvHM7qj7AxWRxFqs5ekE0B7nfWMj2xyRrybse7o1tcBDaGoW+Qf92rmdNXQ6JStCHGvNOifgg
	==
X-Received: by 2002:a05:6e02:3a0c:b0:3d4:6f37:372c with SMTP id e9e14a558f8ab-3d5960e2419mr225832565ab.7.1742990974558;
        Wed, 26 Mar 2025 05:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOuyfQGVOhYyFSi3hsb9kc2zJRzczpD7XPzwNdnwVuHyYQPBafKpH087OtVwDsIyzVWltmG166ADE4aJfipJU=
X-Received: by 2002:a05:6e02:3a0c:b0:3d4:6f37:372c with SMTP id
 e9e14a558f8ab-3d5960e2419mr225831915ab.7.1742990973998; Wed, 26 Mar 2025
 05:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv> <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
 <CALu+AoRdfjNcjweq_ipxCC6UGBzM-a5ma417RBr-C3EQ=Em9OQ@mail.gmail.com> <Z-Pk9Bnr0lDVopKj@kernel.org>
In-Reply-To: <Z-Pk9Bnr0lDVopKj@kernel.org>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 26 Mar 2025 20:09:55 +0800
X-Gm-Features: AQ5f1JrnxWyTc7ruwIDaX1fnmt0FdUmOV-OtIvcwHa3Skex-wO_kM_31tXed_lg
Message-ID: <CALu+AoS9=KttzqgR+xi11jur5eX7dBwUfOoueHoOss3eFn+Hkw@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, 
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	mark.rutland@arm.com, pbonzini@redhat.com, pasha.tatashin@soleen.com, 
	hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, 
	robh@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 19:34, Mike Rapoport <rppt@kernel.org> wrote:
>
> Hi Dave,
>
> On Wed, Mar 26, 2025 at 05:17:16PM +0800, Dave Young wrote:
> > On Tue, 25 Mar 2025 at 16:36, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > > >
> > > > > Have you tested kdump?  In my mind there are two issues,  one is with
> > > > > CMA enabled, it could cause kdump crashkernel memory reservation
> > > > > failures more often due to the fragmented low memory.  Secondly,  in
> > > >
> > > > kho scracth memorys are reserved much later than crashkernel, we may not
> > > > need to worry about it.
> > > > ====================
> > > > start_kernel()
> > > >   ......
> > > >   -->setup_arch(&command_line);
> > > >      -->arch_reserve_crashkernel();
> > > >   ......
> > > >   -->mm_core_init();
> > > >      -->kho_memory_init();
> > > >
> > > > > kdump kernel dump the crazy scratch memory in vmcore is not very
> > > > > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > > > > so please disable this option for kdump.
> > >
> > > Ok,  it is fine if this is the case, thanks Baoquan for clearing this worry.
> > >
> > > But the other concerns are still need to address, eg. KHO use cases
> > > are not good for kdump.
> > > There could be more to think about.
> > > eg. the issues talked in thread:
> > > https://lore.kernel.org/lkml/Z7dc9Cd8KX3b_brB@dwarf.suse.cz/T/
> >
> > Rethink about this,  other than previous concerns.  Transferring the
> > old kernel state to kdump kernel makes no sense since the old state is
> > not stable as the kernel has crashed.
>
> KHO won't be active for kdump case. The KHO segments are only added to
> kexec_image and never to kexec_crash_image.

Good to know, thanks!

>
> --
> Sincerely yours,
> Mike.
>


