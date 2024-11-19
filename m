Return-Path: <linux-kernel+bounces-414525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9599D2969
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37BD1F23056
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEED11D0F50;
	Tue, 19 Nov 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="DTWcVmP3"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549721D079F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029293; cv=none; b=jfS852AQtbf9vQACeFXSi4SDgQOGDSA3mT14NT3cKHQMnPeN19lTVOu9OPkCMQ1WaZDT7CwkMb8VidKasjNil5YZn57g4AuTl8ynZkKVqg4uPDj9NmgpwR7iTlveSzL4CBeWoHNMjXM40AZLhr3VJ9y40xlk4BTykvwOpqkg1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029293; c=relaxed/simple;
	bh=RHwDnKru70pWnl/9WBuQ20Iik4fo0kZl81qP2ypGaJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6x7/Rt7a57bCHdF337VcBlg+kDun6B4MGYWnLxXpjApFs4mFhuye8Xm44uayOg0AIrXV9vi6rCsc1OISYaNSUdgENFtvqjy8BTFTpZjffGCcnyZp7m7rydCrqsX8+khPYa5+iAVnrm1uf66TRAU/1FfAPvm6reUUaFlDeqsX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=DTWcVmP3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4635760725cso51731801cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732029290; x=1732634090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHwDnKru70pWnl/9WBuQ20Iik4fo0kZl81qP2ypGaJI=;
        b=DTWcVmP35d2MfNGkG/F0tTzrF5ppMkhzpZfeGa1Esf8qHysk1JSwK5speXHBpjPkRr
         jBOYm9NhFj3be1oVJ0Qy6Fql/D5sBT6O9X4QNapE6ii3q1OEOz3j6UDZhgiNA+sYElx2
         8kiycjPi2Gw5zhQFvAEeJLY5vCtw22OHYWmWMN7Q1CW2mBHDYorHjaE7JgzPALgqHztR
         kpx8ASR6CyxEA1/4rmiRVfRf/EgpvqQU8RubVUJUzTtXG6xxWK/QwlSFNMrKOzbT9R43
         d2VQQuVPJd0vMSPx9/ZOiVF4AAml1XvnmDYFtyU3IpEKBCHvzfBeVk0c3sWUWJqcZ+s2
         vLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029290; x=1732634090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHwDnKru70pWnl/9WBuQ20Iik4fo0kZl81qP2ypGaJI=;
        b=jmWNvIPECTz6HqGhqTdn5V/WuZPIbzXI4OrYARp3j88yaqA21w1iUX+J4o6x0BIwA8
         YJnq/JbYQSLUeF2o8RzL5BbTBA6kpLVDRx2hfcMyVdcXW9Js4TkLUTbgYGw70NOdZxz7
         00XnEFrHMqjQaV5NnDXjN+qcyj00sUxUjUyBBVQKwgpsoSRZ1vMe8vkKKGMWZ/9vcEbm
         UXfrQ00pU/L7cSZbmhmMRbUUHAIzM9tfzC2jJFeyODktpSEoJbsGe7UdmkXfEPWg9KL1
         glIxzWfM339ik8OjzA3jlTP/owxMmRjdmo0LiNReXwccDWK18OHDtjYRDLrcbrZrYXWu
         /gvA==
X-Forwarded-Encrypted: i=1; AJvYcCU9oA7VziX5DjPC0oMyYWR53zYVgm6yU7gzw8i0RMGcQQ7w07swVnmSCseN324Z5jRN7cd4AOLwv0TwCm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iGMRFLbDHMfx7s2dhqjg83V8KgSiUiBtlxMifdy8wye6s5D7
	KaFhe3NHkO+IIa7dOszKNvRMCQiYxhLQSa/CATIxzYRW0x1UidIvX/6lEl8VfqAn0DKMx5KjXxb
	qMnXsJv8kV7uanWH+jEm6XgKzGwDewNTJipcFKw==
X-Google-Smtp-Source: AGHT+IEJwBZlUovcinMC2W5fFA797qZwYwLBmxYXTBNzEM0XjyLH7M5le4TEh6FQXiXxZ5fybascQvNQ8dVlyHK3oWk=
X-Received: by 2002:a05:622a:1b06:b0:462:b856:c8fe with SMTP id
 d75a77b69052e-46392d511bcmr58315681cf.1.1732029290306; Tue, 19 Nov 2024
 07:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local> <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
 <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com>
 <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com>
 <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com> <CAG48ez0NzMbwnbvMO7KbUROZq5ne7fhiau49v7oyxwPrYL=P6Q@mail.gmail.com>
In-Reply-To: <CAG48ez0NzMbwnbvMO7KbUROZq5ne7fhiau49v7oyxwPrYL=P6Q@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 19 Nov 2024 10:14:12 -0500
Message-ID: <CA+CK2bByXtm8sLyFzDDzm5xC6xb=DEutaRUeujGJdwf-kmK1gA@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Jann Horn <jannh@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:52=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Nov 19, 2024 at 2:30=E2=80=AFAM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> > > Can you point me to where a refcounted reference to the page comes
> > > from when page_detective_metadata() calls dump_page_lvl()?
> >
> > I am sorry, I remembered incorrectly, we are getting reference right
> > after dump_page_lvl() in page_detective_memcg() -> folio_try_get(); I
> > will move the folio_try_get() to before dump_page_lvl().
> >
> > > > > So I think dump_page() in its current form is not something we sh=
ould
> > > > > expose to a userspace-reachable API.
> > > >
> > > > We use dump_page() all over WARN_ONs in MM code where pages might n=
ot
> > > > be locked, but this is a good point, that while even the existing
> > > > usage might be racy, providing a user-reachable API potentially mak=
es
> > > > it worse. I will see if I could add some locking before dump_page()=
,
> > > > or make a dump_page variant that does not do dump_mapping().
> > >
> > > To be clear, I am not that strongly opposed to racily reading data
> > > such that the data may not be internally consistent or such; but this
> > > is a case of racy use-after-free reads that might end up dumping
> > > entirely unrelated memory contents into dmesg. I think we should
> > > properly protect against that in an API that userspace can invoke.
> > > Otherwise, if we race, we might end up writing random memory contents
> > > into dmesg; and if we are particularly unlucky, those random memory
> > > contents could be PII or authentication tokens or such.
> > >
> > > I'm not entirely sure what the right approach is here; I guess it
> > > makes sense that when the kernel internally detects corruption,
> > > dump_page doesn't take references on pages it accesses to avoid
> > > corrupting things further. If you are looking at a page based on a
> > > userspace request, I guess you could access the page with the
> > > necessary locking to access its properties under the normal locking
> > > rules?
> >
> > I will take reference, as we already do that for memcg purpose, but
> > have not included dump_page().
>
> Note that taking a reference on the page does not make all of
> dump_page() fine; in particular, my understanding is that
> folio_mapping() requires that the page is locked in order to return a
> stable pointer, and some of the code in dump_mapping() would probably
> also require some other locks - probably at least on the inode and
> maybe also on the dentry, I think? Otherwise the inode's dentry list
> can probably change concurrently, and the dentry's name pointer can
> change too.

Agreed, once reference is taken, the page identity cannot change (i.e.
if it is a named page it will stay a named page), but dentry can be
renamed. I will look into what can be done to guarantee consistency in
the next version. There is also a fallback if locking cannot be
reliably resolved (i.e. for performance reasons) where we can make
dump_mapping() optionally disabled from dump_page_lvl() with a new
argument flag.

Thank you,
Pasha

