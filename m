Return-Path: <linux-kernel+bounces-433112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB769E53FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614B01689D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8561F03E4;
	Thu,  5 Dec 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOkiD28f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE81DA0E3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398309; cv=none; b=qYp/tAHH47FHY7nQ7bJHJcEmE9Csno1wPZgNkYi2If4gDuJIV2tL8Io/HhcbpIeRUc6YjohdccLXITKZZfGip/RoeCztNtPe02SiShyTbYlru40aHoReKQceAb2OvamTgTN90N7fxoR3kUonr0bHwsehuGznmiEmzzLg2nhRQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398309; c=relaxed/simple;
	bh=WD+D3zjDdpr2nzObyZNKUJOpZi+JvTk/rmjXWt+DS7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MU40QhAmRnuvPRRlwHaBW8QvpLzxsaHhzuk/lxMY5My+2HR8MBNA+EfzW1a3Biwn5x2WBxE7kgMrvs2T8Nr0/UcYagjpKzoKzmQXypE0pQ4R2LoOswTmHbO1iMzkJKDvxN1cCGMSnbsBF+pqgwN5HS+M8Qpt+cPbSgqfWX3nuBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOkiD28f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733398306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrHIoxf1wwvsV961nNc3s6ncxxeirMR14NyYYwxPNxY=;
	b=NOkiD28fPtcH5f/ArNZW8CMtlbAB+K8Pmj2HW/q27qOEJI9xiVSM6BmW/f1oeUSX22cH9Z
	5DMGG2qKZQjcJXwh8EvM5W50csOPYWc2f6+x+H3ks/0jOiG9I1jXnGLdaVnqR4UPUeV1RS
	ziNk4aQ78bZBOb5zDr7+HEtqLAHhTS4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-pIgZhz2jPpie7gi6u1H-jQ-1; Thu, 05 Dec 2024 06:31:45 -0500
X-MC-Unique: pIgZhz2jPpie7gi6u1H-jQ-1
X-Mimecast-MFC-AGG-ID: pIgZhz2jPpie7gi6u1H-jQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa62a0a2f72so42193366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398304; x=1734003104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrHIoxf1wwvsV961nNc3s6ncxxeirMR14NyYYwxPNxY=;
        b=qR3l3lhVIMdWWvR3SGOhkijFgKF2a0dctN9DLLZKPZGzMgATSBZRTJ3LtWZN8cVrYK
         LWQKf2s/JklTVP+0+c1JL62qPKbY2r7F72qP7lNng5pJjFirpxTJR3t/Ov9FwN4d6Ukt
         /lE5+abjY6Aj2NSNgtaG6uV2disbxiCyo3bVSHpKFyjwUy817iv2tSEuFKBV/F+w9wVI
         5194M7YXCzjR48Op1IIf3McKgkXJcOQU+R0Al5hyvK9aorPmR+VDk+aT1xF6kYCmy0V4
         hAj7w5plTo5blWLkK0viAYTuSQDS+WIJpAmSEqnJrI8LQEZ2H/DPHgp+9jPZOijLNDT/
         Ky2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUD/KWJcZ0a9K8HNJeWkPjkprvPwZYm+DWoRPN/tpcigZMa68O/LwJLrQuUbyT+XclOD83t6zwENVx1zcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6CHCbzYyAYzr4YHVWRZmEHlWMY7H8Py41D6TLiTqSoF+r4ML
	QsKUtqhw1Ih6w1hijFqh5yPp3DTtbBVqtsC5MstzXQXZDWTK+vuUzG+hJBRsnRhwJhuUt3uI90P
	iYCBaq1D+tnR4gAdSCEwjRjZvIto1J3J2PgwSyeUSXxtG5zorLRrNzuVJdh1K3TuV0+TrKjg1+B
	z3Er1e5VfiMy5rmR9ZysafZOF9YgIrak1hokm7CMIh4nA3gn5JBw==
X-Gm-Gg: ASbGncvGHvv4u2giA/FCgCS13bK+ULwYBCkxZGn7ZmZ4WbcRRW3Y0m/KTp0EAMgVW/R
	cF46HH0MVKyUArLb5M9gsM7XK3acGbrgJJRJMBBsECinHKbPfHA==
X-Received: by 2002:a05:6402:34d4:b0:5cf:f361:1c11 with SMTP id 4fb4d7f45d1cf-5d10cb5c7c7mr15008319a12.20.1733398303585;
        Thu, 05 Dec 2024 03:31:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/LNwZyYb5cNNb233xpazpDtAY3FmHy3Im/NdeY7v4mcL81NmkDVKHroBDsI4MKXESH4Ayo+yHw6mZbxUuGSY=
X-Received: by 2002:a05:6402:34d4:b0:5cf:f361:1c11 with SMTP id
 4fb4d7f45d1cf-5d10cb5c7c7mr15008280a12.20.1733398303265; Thu, 05 Dec 2024
 03:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127212027.2704515-1-max.kellermann@ionos.com>
 <CAO8a2SiS16QFJ0mDtAW0ieuy9Nh6RjnP7-39q0oZKsVwNL=kRQ@mail.gmail.com>
 <CAKPOu+8qjHsPFFkVGu+V-ew7jQFNVz8G83Vj-11iB_Q9Z+YB5Q@mail.gmail.com>
 <CAKPOu+-rrmGWGzTKZ9i671tHuu0GgaCQTJjP5WPc7LOFhDSNZg@mail.gmail.com> <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
In-Reply-To: <CAOi1vP-SSyTtLJ1_YVCxQeesY35TPxud8T=Wiw8Fk7QWEpu7jw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 5 Dec 2024 13:31:32 +0200
Message-ID: <CAO8a2SiTOJkNs2y5C7fEkkGyYRmqjzUKMcnTEYXGU350U2fPzQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/file: fix memory leaks in __ceph_sync_read()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, xiubli@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a bad patch, I don't appreciate partial fixes that introduce
unnecessary complications to the code, and it conflicts with the
complete fix in the other thread.
Please coordinate with me in the future.

On Thu, Dec 5, 2024 at 1:25=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> wr=
ote:
>
> On Thu, Dec 5, 2024 at 9:32=E2=80=AFAM Max Kellermann <max.kellermann@ion=
os.com> wrote:
> >
> > On Fri, Nov 29, 2024 at 9:06=E2=80=AFAM Max Kellermann <max.kellermann@=
ionos.com> wrote:
> > >
> > > On Thu, Nov 28, 2024 at 1:18=E2=80=AFPM Alex Markuze <amarkuze@redhat=
.com> wrote:
> > > > Pages are freed in `ceph_osdc_put_request`, trying to release them
> > > > this way will end badly.
> > >
> > > Is there anybody else who can explain this to me?
> > > I believe Alex is wrong and my patch is correct, but maybe I'm missin=
g
> > > something.
> >
> > It's been a week. Is there really nobody who understands this piece of
> > code? I believe I do understand it, but my understanding conflicts
> > with Alex's, and he's the expert (and I'm not).
>
> Hi Max,
>
> Your understanding is correct.  Pages would be freed automatically
> together with the request only if the ownership is transferred by
> passing true for own_pages to osd_req_op_extent_osd_data_pages(), which
> __ceph_sync_read() doesn't do.
>
> These error path leaks were introduced in commits 03bc06c7b0bd ("ceph:
> add new mount option to enable sparse reads") and f0fe1e54cfcf ("ceph:
> plumb in decryption during reads") with support for fscrypt.  Looking
> at the former commit, it looks like a similar leak was introduced in
> ceph_direct_read_write() too -- on bvecs instead of pages.
>
> I have applied this patch and will take care of the leak on bvecs
> myself because I think I see other issues there.
>
> Thanks,
>
>                 Ilya
>


