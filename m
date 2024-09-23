Return-Path: <linux-kernel+bounces-335344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346E97E45C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 02:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FE51C20D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612854437;
	Mon, 23 Sep 2024 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QzuD7/8M"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A915D1
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727051233; cv=none; b=QhxtNK6zLkdInGh8HrRTMo+g3MKzFWyoIgpwizWW9rHvCNRyKPFBTfqyZVtGgqD1LA0g7F5onftLVYGLqmHyx1wIYbUYzJuKUHmfw68HHZB3tCJXvLsyjyVfc2ap6aZNTUPS6WB2zmZMaYjFWLmTNQ2sjS7naDFl9Xr7DFRceXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727051233; c=relaxed/simple;
	bh=oLxuxNCpKBxvXYvoL6b4Q7Aizd7jXbH6X+IyWKEYb58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcpdL5phu5dwxBPGVNcLvcnAZqO3XpaX8CX1H0RgQoLHZu2+CTdeQPDqGAnTXcGODQjtX2fMYxmOR4nubJcMDgelsN0fpvmp1x3fOP5st7Ggv+FRhKT4ytbS5RiI8phV8k3sxqtlKFz98ZKoJa7sILYsi7ig5yy2/O9XMPuEPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QzuD7/8M; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dde476d3dfso28958937b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727051231; x=1727656031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi8j4LrsfBHpaAU+oOhGbxOKTJgruMUCSoATW7J/yC0=;
        b=QzuD7/8MwSy8KyO37RHc/eQpUw8Tc2tilmbZPsBGXIlU4XByPd4/+wsxNmGb58dcbD
         jNzzpnhiirdGkF+MgfsSBbKJz1xlxLKgihcMWGebYJ5toCvdY1lBSkc/UfjhLOvjSwL9
         pUGZsOrvf3eMnrgs3Q/+Wk6tYyp/qQj9fRbooX/hAoTKozF6BsIpF4RPOCPPO2N7c9Ni
         l1tUtfVFdj81KOuVq7qzPasPDSoprxsxsYq60NZ5hIf+geyRCjhJ/Xu28lMeNecRAiCb
         UqqNzGNyqTVlxGFjU1rWa8H6eJsa0QTN/9DONZ1pVElg5P3vq/IlZCp7JesDycNlQZoL
         4xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727051231; x=1727656031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi8j4LrsfBHpaAU+oOhGbxOKTJgruMUCSoATW7J/yC0=;
        b=L0A4jAv2NtfoRJvVGGHWKunnMoE/PiaK7NBag/togcbc7ZTMMnvici0R5e3E9Q/Hys
         9riigz/6QaS2XkX4mkPIjubOg7TZ5IgmcKasKKKic5k4NakNB71EOmA3y35O1khfvZMJ
         lWEbGb8m4RFLnEKAQtJOgeeZdUw3CUdbsrWjR/KEZEcDTP/6/LCczf0ga1+EI564Yr8y
         TJ2D1NEc7LISTZQBdZ9L9HyCuHdsQngGHgnMPKmTWsldP0gYNmdmq4wKiWEzK8SPbCmT
         AKBPati3pOZ+DnsJnQ3Y/sroqvaooNfmklaYY4tgH+Um4Ucfml+RydV7nI3q3luw2a2X
         bpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrNltTtqyETqe6GempPoF4qipVfLFVDi1TZcMLc1f9zO50hoaKZWMuT7KOXvyV7+4QOwgNsyY9pqAmSJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJr8J+iGjvtxHB1EJXHNrvkI+BY+yxLCs3yWVSV6zVejA6yRo
	3G6XdYATk7ImypB4liRFN6OCW1KsgUqWrls9VizRUzAhQu9ohFiyLZtDxtrEsMweq2VYLBIIae9
	1HrNn584nxnAW/tIJci6ZUoXpnVGpuPtPpgfC
X-Google-Smtp-Source: AGHT+IHcatybpDEQzXCmvPF6gj/lvbSwHzmNWrttTn6Kr/ycJO3vl8uev83L1AwpATO4K+zKtnaxiV5/+vn9MKrSO10=
X-Received: by 2002:a05:690c:2fc3:b0:6dc:8359:fb11 with SMTP id
 00721157ae682-6dfef0195b3mr57322077b3.37.1727051231133; Sun, 22 Sep 2024
 17:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922145226.491815-1-linux@roeck-us.net>
In-Reply-To: <20240922145226.491815-1-linux@roeck-us.net>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Sep 2024 20:27:00 -0400
Message-ID: <CAHC9VhRWhknpRkKv7-yZza-kr1Bq2nhch8bYm9BsfDpurFir9Q@mail.gmail.com>
Subject: Re: [PATCH] ipe: Add missing terminator to list of unit tests
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>, 
	Fan Wu <wufan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 10:52=E2=80=AFAM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> Add missing terminator to list of unit tests to avoid random crashes seen
> when running the test.
>
> Fixes: 10ca05a76065 ("ipe: kunit test for parser")
> Cc: Deven Bowers <deven.desai@linux.microsoft.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Fan Wu <wufan@linux.microsoft.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  security/ipe/policy_tests.c | 1 +
>  1 file changed, 1 insertion(+)

I'm guessing Fan doesn't have his tree setup yet, but if I can get an
ACK from Fan I can send this up via the LSM tree for the next
v6.12-rcX release.

> diff --git a/security/ipe/policy_tests.c b/security/ipe/policy_tests.c
> index 89521f6b9994..5f1654deeb04 100644
> --- a/security/ipe/policy_tests.c
> +++ b/security/ipe/policy_tests.c
> @@ -286,6 +286,7 @@ static void ipe_parser_widestring_test(struct kunit *=
test)
>  static struct kunit_case ipe_parser_test_cases[] =3D {
>         KUNIT_CASE_PARAM(ipe_parser_unsigned_test, ipe_policies_gen_param=
s),
>         KUNIT_CASE(ipe_parser_widestring_test),
> +       { }
>  };
>
>  static struct kunit_suite ipe_parser_test_suite =3D {

--=20
paul-moore.com

