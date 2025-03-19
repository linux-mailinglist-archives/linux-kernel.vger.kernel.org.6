Return-Path: <linux-kernel+bounces-568282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7F2A692CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C317A27A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6821C5D53;
	Wed, 19 Mar 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kUYTqpav"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA7B16F841
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397341; cv=none; b=KR8hBRXRSLuBqE/6nsbd3oh1+2XHZqn+tHHH337CQmvQ9PN9zEjrZcVIlPgWMU0SjEwIua1VSEVgRir8i+s6dXDiSUbJLCZ3jRI6sQLU8nAF8RZWtQGh7PNbOvITiiBq9xeoUfjA/H00FbVoItJPX/6L87QMc+0t1VbpUlG50Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397341; c=relaxed/simple;
	bh=qgsA9dpPP3nktpy+wDsF8tYTvdd2TWPWR1XgE6sNtu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt9r6oFMJp5pXLX6xeqcUDd2CZ9OHwimrgqMrhnKIx8y4JmxzcZLmiX2zdr1aFnqXJr9FN17DCBe9RaQE07XZDovHnLQRIrGC0DH2ZkX1rtevMjHQX/dDXBV3icfSBNaxL0jU8qqhF0uHX9lESvHGR/XQv+IPXd9CmalYJqiVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kUYTqpav; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 996473FCD4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742397336;
	bh=qgsA9dpPP3nktpy+wDsF8tYTvdd2TWPWR1XgE6sNtu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=kUYTqpavung5IUy+/BLlGVKJhiW/MKr00Vw0cMy8Woq6AqseGXmo+sb997k7XdC5B
	 aEwL4HF0sNgEUMaVki5gYnvoxUXyLqn/KMuxrS8NUZpSrDFnZL+zNlSshe19kfbSa0
	 eCVvhwbp6B4CsNDWDRZEjyw80hAbpxWx5ODQeFNtG3Q0EPgnRlTQHBPXsS3u0MkRSv
	 UoFXVNVzNcLLzcmd9uudrH4YNV1Wtod82cbfIaEGYBsY0z83Mii8tB2kgtJZKHrVg5
	 MOw8Qw2gcwfKntj/1oXWkJm77i5PPXtc9PmMm7r5Ud6ZKaBgFK7lyrNjXSHuv8C1ej
	 XI2L1F/PVg9cg==
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-523ef27785aso1802018e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397335; x=1743002135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgsA9dpPP3nktpy+wDsF8tYTvdd2TWPWR1XgE6sNtu4=;
        b=wNQo7lEx7/42VR0gdfrvZ+/A52ordlkdi7b7ANlxvjrHZbxcFl9kpzMAmgAEbof0K7
         PwlH9mTZTXMws1860asydssxYxvPScyljXq6QLg1Yjid8o4+RKllWRv95QanurUF17Ce
         crrxwGx20YCyyY00s4A9z5GoX0AogJO9du9o2t4qvG6iKXaO59KKUhax+q8gUGa7Td5X
         zkoOfhENntN3PqAQa7zZ4wEnK1fDWSO2MHDzTmAxjDE0CFSNe3dw48tDB7BOoA76vqpw
         eYmD6L/zMJ6udBYuHJArL0rz/GcS934YT3tRUseRi09EZmf6XUDPmtWotiuwvQT1F0D0
         rabA==
X-Forwarded-Encrypted: i=1; AJvYcCWlHcArtv/Yvawl2NphypW97QAPgNRmoWMFXF/qUkedIM6griRUtEpLAGPjKuIMpeDL6DflCjXk/mi2ZMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFtNsqLQsktFX+CvZOeuuLyl4xhLzWzSH31kTWnqrtGMwsxr+
	2Q63pVB6nsEvLSj/XAvCvi/3cD89lPj9rqx7kzNg9RbBoquiSYOtdVpz3rrmI2O6UzBe3tHyhEm
	2ILepFNyrrDGiIsUJDmsLzICUKyeIw37lTEr08SZhy3ByKKmeOLH0ocZQRS5wb3h17epOgoGtnf
	GEPqHrpmXLbzGvYZy+dwjiXAweXDtkcXC2pSy6MjFVoanivAM/1uuN
X-Gm-Gg: ASbGnctJjHD6PTvJApIwf6Gj6D0Se0GxdfRj7r82SosjRh6xzaREenEf71iQI69rOhD
	R2STNOmu7VxRqLRHbvBUGxz4e8semOB3+STpiZFHf38Z5J8ERmYbtohVBt2FANub6JJffwMBB5w
	==
X-Received: by 2002:a05:6122:8d5:b0:520:51a4:b81c with SMTP id 71dfb90a1353d-525891bfc08mr2198601e0c.6.1742397333498;
        Wed, 19 Mar 2025 08:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw7muwol2OI7wSYL9a9iCyn+ZyN/NbRnjdL4AIqfECKKb7LsSD6rIVvzulorR8ijKfurSGNQLANVDULXCR0Sg=
X-Received: by 2002:a05:6122:8d5:b0:520:51a4:b81c with SMTP id
 71dfb90a1353d-525891bfc08mr2198425e0c.6.1742397332338; Wed, 19 Mar 2025
 08:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
 <zihwmp67m2lpuxbfktmztvjdyap7suzd75dowlw4eamu6bhjf3@6euydiqowc7h>
 <278393de-2729-4ed0-822c-87f33c7ce27e@redhat.com> <23000b6a-8a58-4c38-a032-ad62637d3fa4@lucifer.local>
In-Reply-To: <23000b6a-8a58-4c38-a032-ad62637d3fa4@lucifer.local>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Wed, 19 Mar 2025 16:15:21 +0100
X-Gm-Features: AQ5f1JqxdWeNnEOv-kQ64TqNajnS4hkxmZIQ-2f_7rOqGOdfJG9iC0RXfJ9SbYY
Message-ID: <CAEivzxeSupJXyCZthc=vGbocJ-AWCq_=q2f_hMKe7pe_83Q86Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] implement lightweight guard pages
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, James.Bottomley@hansenpartnership.com, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, arnd@kernel.org, 
	brauner@kernel.org, chris@zankel.net, deller@gmx.de, hch@infradead.org, 
	jannh@google.com, jcmvbkbc@gmail.com, jeffxu@chromium.org, 
	jhubbard@nvidia.com, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mattst88@gmail.com, muchun.song@linux.dev, 
	paulmck@kernel.org, richard.henderson@linaro.org, shuah@kernel.org, 
	sidhartha.kumar@oracle.com, surenb@google.com, tsbogend@alpha.franken.de, 
	vbabka@suse.cz, willy@infradead.org, criu@lists.linux.dev, 
	Andrei Vagin <avagin@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 4:02=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Mar 19, 2025 at 03:52:56PM +0100, David Hildenbrand wrote:
> > On 19.03.25 15:50, Alexander Mikhalitsyn wrote:
> > > On Mon, Oct 28, 2024 at 02:13:26PM +0000, Lorenzo Stoakes wrote:
>
> [snip]
>
>
> > >
> > > Dear Lorenzo,
> > > Dear colleagues,
> > >
> > > sorry about raising an old thread.
> > >
>
> No worries!
>
> > > It looks like this feature is now used in glibc [1]. And we noticed f=
ailures in CRIU [2]
> > > CI on Fedora Rawhide userspace. Now a question is how we can properly=
 detect such
> > > "guarded" pages from user space. As I can see from MADV_GUARD_INSTALL=
 implementation,
> > > it does not modify VMA flags anyhow, but only page tables. It means t=
hat /proc/<pid>/maps
> > > and /proc/<pid>/smaps interfaces are useless in this case. (Please, c=
orrect me if I'm missing
> > > anything here.)
>
> Sorry to hear that.

No problem at all ;)

>
> > >
> > > I wonder if you have any ideas / suggestions regarding Checkpoint/Res=
tore here. We (CRIU devs) are happy
> > > to develop some patches to bring some uAPI to expose MADV_GUARDs, but=
 before going into this we decided
> > > to raise this question in LKML.
>
> There's no need.
>
> >
> >
> > See [1] and [2]
> >
> > [1]
> > https://lkml.kernel.org/r/cover.1740139449.git.lorenzo.stoakes@oracle.c=
om
> > [2] https://lwn.net/Articles/1011366/
>
> As per David, there is already a feature heading for 6.15 which will allo=
w
> this to be exposed by /proc/$pid/pagemap.

Yeah, that's indeed very helpful!

>
> In addition, I plan to add a 'maybe has guard regions' flag that can be
> observed in smaps to assist narrowing down which VMAs to check.
>
> However unfortunately due to the nature of the feature there is no gettin=
g
> around the need to traverse page tables.
>
> That thread (and LWN article :) go into extensive detail as to why. In
> essence - it's the basis of its design to express this information at the
> page table level only, and any attempt to encode this at the VMA level
> (other than a 'maybe' flag) would eliminate the purpose of the feature.

Thank you very much for these explanations!
I'll read the LWN article too.

>
> Let me know if there's any way I can help!

Keep in contact! ;)

Kind regards,
Alex

>
> Cheers, Lorenzo
>
> >
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

