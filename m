Return-Path: <linux-kernel+bounces-188272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7938CDFEA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3715B1C221DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA3381B8;
	Fri, 24 May 2024 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLdv3F8i"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091728399
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522190; cv=none; b=QRjeRP7hjkvDbV08Q7W3HcvHr3RD17VVUBEfHhjgzvJqYi1HglTgtkzB766Ecddj4xzPOpFnkti4oPoX3DakjOY+eLuHYW8JpZndguaJUpj4uLxD/26D3i6tS1jIFKvV5ENR1OCoE099gZSq3oIgD5m1+3DDy/+l7+uJ0M4YDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522190; c=relaxed/simple;
	bh=nSEA/1vFW7rijht1ByiXZxWX/1rbgwYmbzpD+gGfsD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8zthLNo9Jtt4ip1W0GQPJL+l8bx4CifkZpH+1LNFZ3930Jn9fZPUhs3oa8Hq48HU0iW9k1h33AJsFx25IXQwJa+uqIkgQRMeB+7vqTsmh9EG1IEw7eQdzLitvWdDkP1mephnT5hLiRIsGD2XgLrqSSwkq1aVQUK4mihTboSRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLdv3F8i; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso9666a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716522187; x=1717126987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36fhNvXOea7b3Tf4Od7riH5C3b7gBf7G4V+Hf3bEH/U=;
        b=iLdv3F8iTSMtzA5TjS3f7o6c8rrd952Qv9hP1EA9OCK+4095tEdQh0nK2tMznmVZod
         QGaGqqFjI529iRyOIYtL/EGvfBegENVHNjkXIezAhIBJzHdoWnGBtWH1pxFBqKIxQpG6
         o4UI3vWZ0kPvue6PWcHKlzW4qn2G71hpKMPvClQDnH6trmvt29C5cD7AU+EarZZKF9cO
         wcodhs0hcR4tEP+kBBaw3uaAz/OyWGfHas1zslcfC64MBuHQhlClMAQfLX6u13Nf3qgG
         SFlCB5wKxxEHcfLSGktex4CQGMJvh5cvY+Trd5HRB8JcXCjC0MSzMtsJv/rJX1RDOEft
         zNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716522187; x=1717126987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36fhNvXOea7b3Tf4Od7riH5C3b7gBf7G4V+Hf3bEH/U=;
        b=UR9azDKu8GacaIpL9+R4j+pT08JQEoTGzf64/s2e4ovj3wobJC2I/iapBOWEsurb1M
         zz7yhyX6fGgCnNb4oGEoR//JjAgOd2ej4SeqGv841trGzMUpNtzsjJ0FmY05jhbQ8ve9
         ZSb/4XNMj7AYZKY8YnMsgI6ZF0DM1d9lFOzthtpoMfEToNTJUFc3HwMe9WKKfCpimynD
         yJAI1Luvjd9GIUfXvddtBz5oh9SzzijmijqalCPAl1JqG9S6rtdDS9t+CK+J6dmEaDp8
         pcrW7NzGz9FowkweM88GDAXB8jCjb+XvXfhTdPVWZrT10bfD+8uujEG3o90HMMFinzLw
         Wp3g==
X-Forwarded-Encrypted: i=1; AJvYcCXk3LN+7AgQXYc85tP0VJGpfqdApaFc3I/SuIluh4WnbRdoSPxw3r2hEji0Vt2g8N7USiAGZaBIRyd165HMqdZuyTK1rBiIAt9IA9DB
X-Gm-Message-State: AOJu0Yw8K/fpaeMeQVv2xg7SqBraxt8CXdZugT8xsMCNOCemhw1tsuH4
	UNlzZPnY5c23Lz7VZ3FCfuATLwIa/BNfNrnyqunbyD2mObbYBd+K85bZbhkBYsjJarLHhybkECW
	q6Iq8GfScNHGTLghayDkUzBFG3sFanp5Zrt37
X-Google-Smtp-Source: AGHT+IEjJM7nXR383Y7RuODv6qPfDIg6HoQrAoxEtox77JWxz+8VbOtWYdPEiSvkEhf2h7OpL2GpIhnsI+AShbXul7g=
X-Received: by 2002:aa7:d547:0:b0:574:ea5c:fa24 with SMTP id
 4fb4d7f45d1cf-578551d9a15mr51779a12.3.1716522186873; Thu, 23 May 2024
 20:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524033933.135049-1-jeffxu@google.com> <20240524033933.135049-3-jeffxu@google.com>
In-Reply-To: <20240524033933.135049-3-jeffxu@google.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 23 May 2024 20:42:27 -0700
Message-ID: <CALmYWFs8e4r390v5pepxZ4H6E=x_21jG1vjVYici5pgt5rTGxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memfd:add MEMFD_NOEXEC_SEAL documentation
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, cyphar@cyphar.com, dmitry.torokhov@gmail.com, 
	dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, 
	keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pobrn@protonmail.com, 
	skhan@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aleksa

On Thu, May 23, 2024 at 8:39=E2=80=AFPM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> Add documentation for MFD_NOEXEC_SEAL and MFD_EXEC
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>  Documentation/userspace-api/index.rst      |  1 +
>  Documentation/userspace-api/mfd_noexec.rst | 90 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/userspace-api/mfd_noexec.rst
>
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/usersp=
ace-api/index.rst
> index 5926115ec0ed..8a251d71fa6e 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -32,6 +32,7 @@ Security-related interfaces
>     seccomp_filter
>     landlock
>     lsm
> +   mfd_noexec
>     spec_ctrl
>     tee
>
> diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation/u=
serspace-api/mfd_noexec.rst
> new file mode 100644
> index 000000000000..6f11ad86b076
> --- /dev/null
> +++ b/Documentation/userspace-api/mfd_noexec.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Introduction of non executable mfd
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +:Author:
> +    Daniel Verkamp <dverkamp@chromium.org>
> +    Jeff Xu <jeffxu@google.com>
> +
> +:Contributor:
> +       Aleksa Sarai <cyphar@cyphar.com>
> +       Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
> +       David Rheinsberg <david@readahead.eu>
> +
> +Since Linux introduced the memfd feature, memfd have always had their
> +execute bit set, and the memfd_create() syscall doesn't allow setting
> +it differently.
> +
> +However, in a secure by default system, such as ChromeOS, (where all
> +executables should come from the rootfs, which is protected by Verified
> +boot), this executable nature of memfd opens a door for NoExec bypass
> +and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP bug [=
1]: cros_vm
> +process created a memfd to share the content with an external process,
> +however the memfd is overwritten and used for executing arbitrary code
> +and root escalation. [2] lists more VRP in this kind.
> +
> +On the other hand, executable memfd has its legit use, runc uses memfd=
=E2=80=99s
> +seal and executable feature to copy the contents of the binary then
> +execute them, for such system, we need a solution to differentiate runc'=
s
> +use of  executable memfds and an attacker's [3].
> +
> +To address those above.
> + - Let memfd_create() set X bit at creation time.
> + - Let memfd be sealed for modifying X bit when NX is set.
> + - A new pid namespace sysctl: vm.memfd_noexec to help applications to
> +   migrating and enforcing non-executable MFD.
> +
> +User API
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +``int memfd_create(const char *name, unsigned int flags)``
> +
> +``MFD_NOEXEC_SEAL``
> +       When MFD_NOEXEC_SEAL bit is set in the ``flags``, memfd is create=
d
> +       with NX. F_SEAL_EXEC is set and the memfd can't be modified to
> +       add X later.
> +       This is the most common case for the application to use memfd.
> +
> +``MFD_EXEC``
> +       When MFD_EXEC bit is set in the ``flags``, memfd is created with =
X.
> +
> +Note:
> +       ``MFD_NOEXEC_SEAL`` and ``MFD_EXEC`` doesn't change the sealable
> +       characteristic of memfd, which is controlled by ``MFD_ALLOW_SEALI=
NG``.
> +
> +
> +Sysctl:
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +``pid namespaced sysctl vm.memfd_noexec``
> +
> +The new pid namespaced sysctl vm.memfd_noexec has 3 values:
> +
> + - 0: MEMFD_NOEXEC_SCOPE_EXEC
> +       memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +       MFD_EXEC was set.
> +
> + - 1: MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
> +       memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
> +       MFD_NOEXEC_SEAL was set.
> +
> + - 2: MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
> +       memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> +
> +The sysctl allows finer control of memfd_create for old-software that
> +doesn't set the executable bit, for example, a container with
> +vm.memfd_noexec=3D1 means the old-software will create non-executable me=
mfd
> +by default while new-software can create executable memfd by setting
> +MFD_EXEC.
> +
> +The value of memfd_noexec is passed to child namespace at creation time,
> +in addition, the setting is hierarchical, i.e. during memfd_create,
> +we will search from current ns to root ns and use the most restrictive
> +setting.
> +

Can you please help to review the sysctl part to check if  I captured
your change correctly ?

Thanks
-Jeff


> +Reference:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +[1] https://crbug.com/1305267
> +
> +[2] https://bugs.chromium.org/p/chromium/issues/list?q=3Dtype%3Dbug-secu=
rity%20memfd%20escalation&can=3D1
> +
> +[3] https://lwn.net/Articles/781013/
> --
> 2.45.1.288.g0e0cd299f1-goog
>

