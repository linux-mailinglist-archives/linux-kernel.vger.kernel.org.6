Return-Path: <linux-kernel+bounces-576713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDCA71372
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD513B6FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C091A707A;
	Wed, 26 Mar 2025 09:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXXGggez"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772A1ACEA6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980620; cv=none; b=b9pDI6vYiP31bHWTMZb0RFB89rRUnObQWmSFZcpdBrAunyvzEwfkWyJ8Yy/1TnwR98hDOfErX8k//lOJBZiL9OgCRUZE6jm1WlRlK7qssFRMR2LhC2QD1kqVehjs/iS8Axi8+MjvUUAeZWzLNUV3BFhCJAUrK0FMps4yhXvPNJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980620; c=relaxed/simple;
	bh=5HoRoEOrj2yp+61wfsJnWJYBURxzB61wh6+kCAkmOo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvOEZLYEy0mNGyWQYpz1PPDIS5/i3bcTI2PxATsL7byXrU/zuiUZECx8nuqonS+Iz6M46KD9a/ydj2hYPN0PO8HdaJQtwhgeV0jNmQn8SqIiLmIgcpmdTqdvMaIdaEAVskjC2m6/GCWF3E8/sHHeRI+4K3W1R8GobnYOhAEch40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXXGggez; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742980617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ow6AGnrr84AMQ0ah/Xi6PJkaHmTpZO5eKBmQQUtOVkg=;
	b=aXXGggezF1ezh1XJYmGlQHRi6ALyjONB/kYJclvM0jGnTfYcGc8hvzkxYVZrTCyBsIVYd8
	/waOH0SPjr0KnaRz9Sc10rQrXWsrx+VLu3Xp4JjrT4dq58x6MMsQKJB0uYJ6lC+dbnagOf
	tWBc9XFIK/E3SRQxwU6+1JmiglbSbDo=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-TY5NWBYIM_O48ahw_knOew-1; Wed, 26 Mar 2025 05:16:56 -0400
X-MC-Unique: TY5NWBYIM_O48ahw_knOew-1
X-Mimecast-MFC-AGG-ID: TY5NWBYIM_O48ahw_knOew_1742980615
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85dcaf42b61so1353818839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742980615; x=1743585415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ow6AGnrr84AMQ0ah/Xi6PJkaHmTpZO5eKBmQQUtOVkg=;
        b=KaIc8jtU/Jo2TT/2LoNj1/kloLaEijdB9SkGiQ3jl0rNBiNmrEfYZKYbJqgPVgkpU9
         UCLqMyT4IdI4JIcBM2osGh4aQjT5+bYWqo2cB67YKOdkSRODTOir/m2zhY0oSWdWRWbC
         sBObMmfroA1vhp67/yJ15Kb/jytYrfJJpZ3i3C5Uu6/f+JgndD82oaAbXyAMAC7BJc6K
         8m9QaRe3vFMDDPfHJrMqT3BNSDAIdjQRI7r3w2Uj3kf4ZRRtta0RPpH1bN0tqHkeoM34
         ykA2EV7Osislq2cB3aUs+htbuBwlPQEbnz5rkvFDvruAcSQlwZa09aDp7DUkslDjhbC4
         vFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdkT8BmX3YXABh+/QQycEtgleG02664w+q9bdnuM+UtnWZNuAl88IVflU7e/Smoe8DP6tItg/ZOfvYhp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPTyamTCivqarccFW7D9pjG6Mgu7q+on61DjV8eQIT5+8ReAE
	ei1OU8YV/lx9BRAngk9rn+pYfYQ/r3bpu7oxmyz1F1sHO0CfZcXgL39YcrKhJ4FtcEj0DAf52Ul
	Qp8492+7h3ZWYmZw5Da2LWvoQIFSu47eE6ZQpHIbRY7l4uBefKhvrQdn/g2WV384Jxn3oxYzE4S
	mc0fK4OGWUSSVI4cFJ8oH/gQ0XKCG/fvIWBlr8
X-Gm-Gg: ASbGncs+YRjkvhRhQT7VvHrcc9Ch6wd2vr49fEWw3mz+M8epowzjOU2Vk7qXWM9w71S
	S6v8diNHIt07BvebWWC/cFqtnBheZslCExzNeiLzlnQ411FxBQgQjb3aZuswIdwNR5RqBsfUuDw
	==
X-Received: by 2002:a05:6e02:3e03:b0:3d4:2409:ce6 with SMTP id e9e14a558f8ab-3d59612bc91mr234170365ab.5.1742980615164;
        Wed, 26 Mar 2025 02:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ1vGph9A3VJepHAKEDwhyEi3HEUoYZg9GSD20aZ5PWU5QdCBZemC86Ee43E1W8Lw5ALFAPfq+RTfo03e4kyA=
X-Received: by 2002:a05:6e02:3e03:b0:3d4:2409:ce6 with SMTP id
 e9e14a558f8ab-3d59612bc91mr234169465ab.5.1742980614659; Wed, 26 Mar 2025
 02:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv> <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
In-Reply-To: <CALu+AoQj+mHECTvbuK8CpUTmOYgx6n2oMFm5kQXtSigL+5Ks2w@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 26 Mar 2025 17:17:16 +0800
X-Gm-Features: AQ5f1Jpq9GZncvPHkaxZJh8I7FiGahHb1rvcGNvIVWbnRM_2M_RRWQiPj2LtDHg
Message-ID: <CALu+AoRdfjNcjweq_ipxCC6UGBzM-a5ma417RBr-C3EQ=Em9OQ@mail.gmail.com>
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

On Tue, 25 Mar 2025 at 16:36, Dave Young <dyoung@redhat.com> wrote:
>
> > >
> > > Have you tested kdump?  In my mind there are two issues,  one is with
> > > CMA enabled, it could cause kdump crashkernel memory reservation
> > > failures more often due to the fragmented low memory.  Secondly,  in
> >
> > kho scracth memorys are reserved much later than crashkernel, we may not
> > need to worry about it.
> > ====================
> > start_kernel()
> >   ......
> >   -->setup_arch(&command_line);
> >      -->arch_reserve_crashkernel();
> >   ......
> >   -->mm_core_init();
> >      -->kho_memory_init();
> >
> > > kdump kernel dump the crazy scratch memory in vmcore is not very
> > > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > > so please disable this option for kdump.
>
> Ok,  it is fine if this is the case, thanks Baoquan for clearing this worry.
>
> But the other concerns are still need to address, eg. KHO use cases
> are not good for kdump.
> There could be more to think about.
> eg. the issues talked in thread:
> https://lore.kernel.org/lkml/Z7dc9Cd8KX3b_brB@dwarf.suse.cz/T/

Rethink about this,  other than previous concerns.  Transferring the
old kernel state to kdump kernel makes no sense since the old state is
not stable as the kernel has crashed.


