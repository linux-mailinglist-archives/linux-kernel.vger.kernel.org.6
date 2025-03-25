Return-Path: <linux-kernel+bounces-574943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4FA6EBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175B7188FD46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207725290C;
	Tue, 25 Mar 2025 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx+AREvM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0DB2343C2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891767; cv=none; b=Y6GuAn7SItx8SeerBPlmvW/HXKWRfzy/q+KrMtl1L7jEotjOLI6Y5O/UStd4KMzTbOwtiugOJNMzKBfODSGc4lgIWOAk3RS4OEVSq6HkN8W5z3+b9akjNu+8WRzHkYl3jn6BXR+L7cRFPUIlfikMmrKQ8wOdzBJa5yQ7uV2Fmf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891767; c=relaxed/simple;
	bh=OCleXFn9NZkH1PChKdrM+O63KYl9A/+phnDxXBrrIoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSGrop8AYzgZBQm7rbG4eWp3AboceVG/q4F0SCo0Lgq9K2vQT4uG2PwYlrnBsLp4a9VkYxCCpbsWcV2q2+9g/7mr3khGIlBia1yzzU68gnosyYJlZv6ioad95nnpTOET3xHXqnZYWoBZoCHlHmaiqjT8lHTUmpIeoG0gK+OqcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx+AREvM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742891764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXwOjnHMzxUdXRa1xbPJFsVQQAIPiDayu2d6sm6acno=;
	b=Gx+AREvMNMpPmCLNsovxbQ7+ulC12B+04YTwAGpVAwSa5xc2l9FfqSWs0DbEFSCeh2PsNI
	GB316KxKSeO1hGIs1Mv5j6lkK3l85TZSNAyK/ld+FXA0zYZWmheknfuXqmf9smhwQfiJpE
	krAf/WAlZzFibEA7SZC2YKkDHizML/w=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-PZBYLr9nNn2TGhyWiTYGxw-1; Tue, 25 Mar 2025 04:36:02 -0400
X-MC-Unique: PZBYLr9nNn2TGhyWiTYGxw-1
X-Mimecast-MFC-AGG-ID: PZBYLr9nNn2TGhyWiTYGxw_1742891761
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-851a991cf8bso536514539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742891761; x=1743496561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXwOjnHMzxUdXRa1xbPJFsVQQAIPiDayu2d6sm6acno=;
        b=fGQW6Y28H0bMD9cNG7CDfOVDCMhzViyOk12JWbUulTEmTLQcy+8ONviVwEnnm5qUQT
         RIV5OvwcUmG+aXfWWkb1p3ifFMSY4O7qoIvgnZGTzKp6Yp184VtgUR79r02bE+c04G3D
         ZjrC8Dt6MBetHmtMG768PQvxAaRjGgF5L7+6Z4uAbjA3H12q1HPItMaZuIJcz3i0fPrq
         qYG4IHQhfkMw846WAvpDuWvJmAz/IBjEbu1OFXMF4qquMLzvpzmZUYez6eLIV76Fb8YQ
         vIJdEhhZctpCBUO/14COfvnxUI8Y2fjtmN8QiCNGpIS6oTcKZ7oS6QtC0lMPRMIRrn2T
         1DCg==
X-Forwarded-Encrypted: i=1; AJvYcCUTQjs5LX9JoK5g+dI9ctHdl4XOsr92kDzMQauqf/vfGSTk8ZPTWbB+yeuGiw6wLdHK+5vXEry3V+gEvHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPHMitXd4ey4M2AfopEFAobvTjb8e/H9sO9dxJXjayHZVF8kWt
	rgNIQT4JS/bXXaC7jAFQFxdwgfCQQT6FCaj3aAjQ2Esvt1sWvcj0f9Q+peh+MbaoD/SyYwI6ass
	xhciiROxs6w5ZPN45qPFittj7dosMI/fuZ9poQm5LJADS+z70JHlo/x7h0PZBwQxZBxK0AFqNBq
	aInwzENJGd0tq9HVtHBLcwnOMtwD4EEV349Dow
X-Gm-Gg: ASbGncvmfGvc5p+TBtf/hWdV+tKDzJkyqQfvGoTi53x+8TdOZU3t+pzk322JfF6ejNu
	WkOFBvdSqf+rWLOddD1Ms2OXitOAxdN07c/YM7ltEEbOwPNBQ8iF4uWb9pXC0ApC7LLks4mcDZA
	==
X-Received: by 2002:a05:6e02:12c9:b0:3d1:4a69:e58f with SMTP id e9e14a558f8ab-3d58e81374emr209274375ab.2.1742891761225;
        Tue, 25 Mar 2025 01:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9E4/EucEBc/+iE2lWu+YyJiDtrud2DOWwH9Ttz3ALKtbFpsWVzZCuYuuSTYSC3OfYElupM2e2tE7hTWgAmd4=
X-Received: by 2002:a05:6e02:12c9:b0:3d1:4a69:e58f with SMTP id
 e9e14a558f8ab-3d58e81374emr209274145ab.2.1742891760802; Tue, 25 Mar 2025
 01:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
In-Reply-To: <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 25 Mar 2025 16:36:22 +0800
X-Gm-Features: AQ5f1JqjFlzQ1M_D50CQArcQW8YwNNz0vfJYofXBEYquREvaq-g04uQRlGUrUgs
Message-ID: <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Baoquan He <bhe@redhat.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, graf@amazon.com, 
	akpm@linux-foundation.org, luto@kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

> >
> > Have you tested kdump?  In my mind there are two issues,  one is with
> > CMA enabled, it could cause kdump crashkernel memory reservation
> > failures more often due to the fragmented low memory.  Secondly,  in
>
> kho scracth memorys are reserved much later than crashkernel, we may not
> need to worry about it.
> ====================
> start_kernel()
>   ......
>   -->setup_arch(&command_line);
>      -->arch_reserve_crashkernel();
>   ......
>   -->mm_core_init();
>      -->kho_memory_init();
>
> > kdump kernel dump the crazy scratch memory in vmcore is not very
> > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > so please disable this option for kdump.

Ok,  it is fine if this is the case, thanks Baoquan for clearing this worry.

But the other concerns are still need to address, eg. KHO use cases
are not good for kdump.
There could be more to think about.
eg. the issues talked in thread:
https://lore.kernel.org/lkml/Z7dc9Cd8KX3b_brB@dwarf.suse.cz/T/


