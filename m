Return-Path: <linux-kernel+bounces-210688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA15904772
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CA81C2322C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8CB155A57;
	Tue, 11 Jun 2024 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1xfI8EO"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5C5BAFC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147080; cv=none; b=StwHh/D6RXq+pjMyBN7adEC1tI8zKm+bNcHqHWkUtWDrxnnyTwk0EmS3O8Uc1NtsP4WYDJfd7tjEGchB319IT019DPsvzb1gxT210dpjpuapcNaz/fUAlRqRy0mYo+fwWP+5X8JFEBTowg0/RvWU8ePb1GyuJf7b/Ylibqq9GVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147080; c=relaxed/simple;
	bh=T8OozrZR+1vkIaOz0Hl0kOkEndiy3BvvGmc+cmCPeVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1LuO0Ycj0AhBNm1l50QkH1Hmob6f2gXwIHGKl27CPX5ULc/dQqyaPmeywFwoMfsyqcyayOpnoYIfobx7SxWVg9AOEoFm5aLgblfqWaV9h4cJOTS1HvOE6f1OdQ7f3pOPvqFEXkwNFMnO3VkhoJMCHWvhxW6MY7EOhE66fOc5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1xfI8EO; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso7010a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718147077; x=1718751877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtbvaoMsCJ9k1mz6SgmK+4gae6eOunhj2wDuCSNJ/mk=;
        b=X1xfI8EOfeGhBs02hzzC/mvZhmC3X2sHmvVhnuQ9nm7ZA5CFPkfzuDse7x/9/TA7UC
         rZUnvbxdprr/kKExu9m2gqwyBa2IT9sxDlkWw9Lsk0guRkjn3zaxgjp2l6RsRCVQ97SK
         3KWhIvrRvDW5jfbCccjjidi+u0X5um3Wqdtls1rOCNOEo6hgjAadPDgO1RiwFH5Wi36F
         bIdSikjwMczp770rK1Hv8N3/0ntZm7cBS6a9bBYPfwklOQ6918z2zUqkUrhVESATQRg5
         e3jJd5lUMwV2AhQIwDecd57iK94Nx6BJs4jzHHBpHUr9dcB9MHtjKH+5w4c2+W66U6V/
         cq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718147077; x=1718751877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtbvaoMsCJ9k1mz6SgmK+4gae6eOunhj2wDuCSNJ/mk=;
        b=Jq/K8qGKUB2wkcHCRRAvUF1BXH/Ux8WptJFasoh0FkLmmtBi2Wg32OE2kJNFlfZE9M
         /oWRZInVWka/tgSnYABX5VylMyAkIRaep513ak3BhqZC23ZjAXuwtsSJg2FTRSa1xs5L
         QEQAvCoKUWw0PtxwGqSRZk4a1daJmc7rxYpVbDUCYaM180AXtI7aEuHms/23LWe8oKyx
         AZ/HTypdltvDWQtJcoTAwrNeNPBKAQoLdOm9j/RJ2oky5izAINz8diiNuJyQsZWfonMD
         G4wdBZsBYzBnoeam4Dt6+NWnv658Dz2Uud6zscdFOhDxcD+TDBtCKCqhDFnASjktRdQ5
         cYvA==
X-Forwarded-Encrypted: i=1; AJvYcCVHARlSR/qYLP795IsGqzGMpMa9YQpjsMTDPsdEg/fhYoLrQZC52znnjUT9/kL8I9Rs/LI3Zrwlsjzx9XPVk4XKJCecAUMB+DyGfSgK
X-Gm-Message-State: AOJu0YzS+z5zU4G6qGu7u13vQJQq3kBIX8eIZXtXq3VUpdux7mZ0YDas
	VPDtSOomv3xlkwM+Z9b17Lacdm9DPAPhAoz6c7DdZ875obXy2F7JbbGdKCB2LsX3tj5Km1CxbGb
	WeBm0oQ9vIwWeCrbs1H6CGqfJCtHvgHgQMDwF
X-Google-Smtp-Source: AGHT+IGIJEs3b4nVQ+XCokKeptQYXIP66wVTDYCQxFkmqQBnlc+C3z0gcSGRO9hqtyBT+VZVapa4wwHBMpUt3Pry/L8=
X-Received: by 2002:a05:6402:38a:b0:57c:ab3f:d200 with SMTP id
 4fb4d7f45d1cf-57cab3fd29amr7343a12.0.1718147075504; Tue, 11 Jun 2024 16:04:35
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611034903.3456796-1-jeffxu@chromium.org> <20240611034903.3456796-2-jeffxu@chromium.org>
 <595b6353-6da6-432b-96b4-42c4e3ec1146@infradead.org>
In-Reply-To: <595b6353-6da6-432b-96b4-42c4e3ec1146@infradead.org>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 11 Jun 2024 16:03:56 -0700
Message-ID: <CALmYWFvxAvG1ZmbmZf=VedTdwEq8Yz36Xp8o9rhw=Wfae1ei8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
To: Randy Dunlap <rdunlap@infradead.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, cyphar@cyphar.com, 
	david@readahead.eu, dmitry.torokhov@gmail.com, dverkamp@chromium.org, 
	hughd@google.com, jorgelo@chromium.org, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pobrn@protonmail.com, skhan@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:41=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 6/10/24 8:49 PM, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add documentation for memfd_create flags: MFD_NOEXEC_SEAL
> > and MFD_EXEC
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> >
> > ---
> >  Documentation/userspace-api/index.rst      |  1 +
> >  Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
> >  2 files changed, 87 insertions(+)
> >  create mode 100644 Documentation/userspace-api/mfd_noexec.rst
> >
> > diff --git a/Documentation/userspace-api/index.rst b/Documentation/user=
space-api/index.rst
> > index 5926115ec0ed..8a251d71fa6e 100644
> > --- a/Documentation/userspace-api/index.rst
> > +++ b/Documentation/userspace-api/index.rst
> > @@ -32,6 +32,7 @@ Security-related interfaces
> >     seccomp_filter
> >     landlock
> >     lsm
> > +   mfd_noexec
> >     spec_ctrl
> >     tee
> >
> > diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation=
/userspace-api/mfd_noexec.rst
> > new file mode 100644
> > index 000000000000..ec6e3560fbff
> > --- /dev/null
> > +++ b/Documentation/userspace-api/mfd_noexec.rst
> > @@ -0,0 +1,86 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Introduction of non executable mfd
>
> Missed:
>                    non-executable
>
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +:Author:
> > +    Daniel Verkamp <dverkamp@chromium.org>
> > +    Jeff Xu <jeffxu@chromium.org>
> > +
> > +:Contributor:
> > +     Aleksa Sarai <cyphar@cyphar.com>
> > +
> > +Since Linux introduced the memfd feature, memfds have always had their
> > +execute bit set, and the memfd_create() syscall doesn't allow setting
> > +it differently.
> > +
> > +However, in a secure-by-default system, such as ChromeOS, (where all
> > +executables should come from the rootfs, which is protected by verifie=
d
> > +boot), this executable nature of memfd opens a door for NoExec bypass
> > +and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug=
 [1]: cros_vm
> > +process created a memfd to share the content with an external process,
> > +however the memfd is overwritten and used for executing arbitrary code
> > +and root escalation. [2] lists more VRP of this kind.
> > +
> > +On the other hand, executable memfd has its legit use: runc uses memfd=
=E2=80=99s
> > +seal and executable feature to copy the contents of the binary then
> > +execute them. For such a system, we need a solution to differentiate r=
unc's
> > +use of executable memfds and an attacker's [3].
> > +
> > +To address those above:
> > + - Let memfd_create() set X bit at creation time.
> > + - Let memfd be sealed for modifying X bit when NX is set.
> > + - Add a new pid namespace sysctl: vm.memfd_noexec to help application=
s to
>
>                                                          help application=
s in
>
> > +   migrating and enforcing non-executable MFD.
> > +
> > +User API
> > +=3D=3D=3D=3D=3D=3D=3D=3D
>
> The rest looks good. Thanks.
>
Thanks for your review!

> --
> ~Randy

