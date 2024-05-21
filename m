Return-Path: <linux-kernel+bounces-185358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DA28CB3F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E381C21D86
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD3F149016;
	Tue, 21 May 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ht+jIFBk"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648420DD2
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318103; cv=none; b=QXTvxvembWzqt55LvQq8YMrUpQQO3p5K85d3/L5Szx1d135WgQIs78ws7z2uO3pQGyE5U3rnxB/PYK2Rmes/eHlmhCZpMdMqL3HrN+aoo4y4eX1cdZzpb4dQzd1GNrkIFxlv/4TueuZKngnV0wqiTsV57pm6AOyLcel2CP+Eqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318103; c=relaxed/simple;
	bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuJcKrTeUyXbJNkazKuqnBJNOPuGn3i/YQSuEQQ4UyPMM7ZeDNCMMhZLPiNh+xIdedO1livBsnzLWRolcxON4JmLZQRz3M1QwzDt3MF9JO3KYb2mnl2X6dgYI+rqf7EHiGnEEs+2CFN2tCtDL/82xwsnT0cOA9GcioS2kwAoEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ht+jIFBk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso2460a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716318100; x=1716922900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
        b=Ht+jIFBk3cNQ4LouwQ98RYvh7hB2eYM2ZbgCefBqRQRo0b01KQfg+wFBUHu50gKV5g
         wF41rDN07fNTqVHWvgbrAm7X3Y1gxjlW6PEbfBvkn7sytcQCC4zifIaBpcZYwXE+BfXC
         03cGODrOk5d3Xp5xy9vrhkZ9JO5ZDto0cs5LjTZvX/sIjssCHFEefC5xFH4/tXLb1eS0
         RnnVFHyYbrDpsoI43e2NPliiwFhSvW+LDdV6/Otk5AygJ2YOD6P7E4ZdhziJcQOV75Sa
         FOMD7a3jLAvoGNte0WvnFr3I95fA2vo8spEeNxI7LuZXmBlly1j0Jr//v4cYm7K5m6kb
         PICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318100; x=1716922900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ix/SXPQG+wpfYFllBOv3clmJtpOeRZmoQkniDsFhak=;
        b=el6tleCyFpEgrwpIfmx4copMgLGamZm9TjLNzmkJx0NicjxlyQ11Bh0cfEBwYAJmyL
         X7fMYi8ZU4T+XRPPjBW0R0NzgklanmwUllu19anLpEGmK+viSR3xtrcGVdJmmwgbPRWC
         Su+wWuU9ch6wvK7Xb9pVU1wnAc5Gw9Kyz/K96CCb31jNhO6yJCqOVUmNyo295Janupfk
         t24sFwxpHJ7onQdRnqO+4jBAQtq1CQ9s6wed6dzzzVxqXxEaz5n5qhTw+Och22AHuS+q
         5mkbwvIynrUbVekdhLdtUMUb2xrhwrqIcEJRq0d7W37IAvydhOgfNF/VHCDlYklFx90X
         sPkQ==
X-Gm-Message-State: AOJu0Yx7Me0Q8pMJIgg0eIXw27ILGdiKi8lYA5oqqZjN0J/PxlenGbOf
	iGeIvj5Wj7+Zxka5KB05tdaYnNKrZb6yx47xb3aCIPi7dyHWofVtJXDi1CieWuEB8A3uEwLRSd2
	aKTS+YuUHD16dzITYXXpgRO/2dwvjlae22nHuO9pX8G81VLqpEXB1OBg=
X-Google-Smtp-Source: AGHT+IGsZHMYwB17/rHm2GPw8sDf3nKxTSkcIsaApOp5bux/QDPAPBCrzCKud52Dm0FNps4wM/XTSDtjC7pz3lXd3Qs=
X-Received: by 2002:a05:6402:3594:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-5782fc1d68amr18531a12.4.1716318100237; Tue, 21 May 2024
 12:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427112451.1609471-1-stsp2@yandex.ru>
In-Reply-To: <20240427112451.1609471-1-stsp2@yandex.ru>
From: Jann Horn <jannh@google.com>
Date: Tue, 21 May 2024 21:01:02 +0200
Message-ID: <CAG48ez0rOch3wemsmrL-ocadG1YeJ6Lyhz1uLxJod22Unbb_GA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] implement OA2_CRED_INHERIT flag for openat2()
To: Stas Sergeev <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, David Laight <David.Laight@aculab.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 1:24=E2=80=AFPM Stas Sergeev <stsp2@yandex.ru> wrot=
e:
> This patch-set implements the OA2_CRED_INHERIT flag for openat2() syscall=
.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened, if the dir was opened with O_CRED_ALLO=
W
> flag. This allows the process to pre-open some dirs and switch eUID
> (and other UIDs/GIDs) to the less-privileged user, while still retaining
> the possibility to open/create files within the pre-opened directory set.

As Andy Lutomirski mentioned before, Linux already has Landlock
(https://docs.kernel.org/userspace-api/landlock.html) for unprivileged
filesystem sandboxing. What benefits does OA2_CRED_INHERIT have
compared to Landlock?

