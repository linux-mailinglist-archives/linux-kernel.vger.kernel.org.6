Return-Path: <linux-kernel+bounces-364930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEB099DB40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B6F1F25447
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334914C5B3;
	Tue, 15 Oct 2024 01:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS2E9u4n"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2891A184F;
	Tue, 15 Oct 2024 01:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728955120; cv=none; b=psmOU6mTRKvbNbaUjiV5E29Sxo28Cxwz/IcAgWZwep624unWo2umdYaPVLrJiiZN1pCQstgTJqUaqgY2eU+3auchdwKqThxFHiXvgqryzqeNsd1WfsgVgTREWMU+gSN2As9hVI3+8s8c2He/T2jftxtO/ILEJzwhb5rsUoNJ0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728955120; c=relaxed/simple;
	bh=5/bXP3m0Q4mEvUmx0OmjCLIQItF8jOXbfM/6ldYROco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AC6VuvhmLuEXkCGXab+aREjTRs6/Mlk56U3Oox6/h0G7vKjI471Ei+udb57WCkvAi73oR9jaGXQ080bc6MouTuPh4xZhD9ozIi4G6idJBUnaCY4Wrch5NQ8SD+qlpIhD2MmZHnYajujghcWZwNs92Yd/wLZLxXUI2In10It2HXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS2E9u4n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so3753043f8f.3;
        Mon, 14 Oct 2024 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728955117; x=1729559917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/bXP3m0Q4mEvUmx0OmjCLIQItF8jOXbfM/6ldYROco=;
        b=LS2E9u4nx/UxpAfn6tJXxep7QVKrqmT5cJ8+UzlNhFRo/XIaDnP+79014a5p1bvovd
         ZpiftTK7G18FPMhPbA2gOUxdtC07FjrCdTeMzkq5qihwQnB1NB/cWomxIz3q1UcOuWTb
         Xp2WCwOVBC6riWmawZK/JEDhvUTh9/dX1XKDUASRnBOspAxfwUiDcMVyle/q0Y9rR513
         4RAk4suu1aCtIToJ4g9o6IHRvDNYsKEw73Q4Fus5CkMkRMB6aW0YbUq1WxIYhgckmJ/P
         qA13wEvJ6yO/QQzKmKBVhA/M7tZ4n+7Gw3CPI92ra3gIOh9kqsvJefXoFdYMpmaOZrTF
         xZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728955117; x=1729559917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/bXP3m0Q4mEvUmx0OmjCLIQItF8jOXbfM/6ldYROco=;
        b=cfpJyjuZTJwLBPWdM60VGkjC2Rdysy2cUI70jDoSbyLl+V5hqxzVqXrC8HSrvps7sz
         1CJEN/YbvgRpIRRAF23qoed1X4bw47F+s3cfnqIOhX3sIh97TcePUPRvEIYQsOxxliJL
         EBFeWpEmHQ3gUsfew1Dv8vc7HN9YJQ9dcUkz7gUs1plSkzGRSH09Ff3sWtUZHtIqtXJg
         kytUAwVqDsM4Hozh5+Iu6746m78E4zj28MQI9qV/hUtwFpATnRIEScMFJyuyVuVhprLO
         Wat3f2taTYBRGaySVCDZi/6merDcIILfMwvdZCRo67aQQcA4GnksQ+AGO90Jgo/7umL3
         FaRw==
X-Forwarded-Encrypted: i=1; AJvYcCVRdhWmuE6Jop+6yU+dUxsl+pp9eboRJ46kWjgN++HFTSIQpnQejdTP8GpqXnF9MSPsM7RcTtP946k=@vger.kernel.org, AJvYcCXBPqBBxIOXPgvTZSucnSwddCWhyHzfGX0zaGA7rm6gUoZ3Ebes7SFv3mdPdG93W0WFUbDT/+qclNrH@vger.kernel.org, AJvYcCXVl4+wE2z2Lzzj9nkH3Gig5mrUkmOPYV1R8YUZpgdKEdqr7KiDiBxQEddp4evyLrCoKEQ4U18U+ZEsjpyX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+V3dteyANDtso1uK6VfxE5ne9RBlqjoHug52xboUiB9MX5aFs
	m8f9EZgqmwgjRZGS74M4Do3xnqD9shK9Nin/Z31XexM5Z2GiNbQYnovTrIyDwcCo93GbnmHkhZ6
	cFHSgFpkN4KCVL6UmIXMJypKIylk=
X-Google-Smtp-Source: AGHT+IFtf+x855A/MZb6mMCgpyufRS4x7cJapnTn+jP4Vzfg2f1CrWh7r7FOxPwBA+jr7T5wHmBHsDAzKLxh7gY5SMA=
X-Received: by 2002:a05:6000:459f:b0:37d:4eeb:7366 with SMTP id
 ffacd0b85a97d-37d5ff27c30mr7704415f8f.4.1728955117170; Mon, 14 Oct 2024
 18:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+fCnZcyrGf5TBdkaG4M+r9ViKDwdCHZg12HUeeoTV3UNZnwBg@mail.gmail.com>
 <20241014025701.3096253-1-snovitoll@gmail.com> <20241014025701.3096253-3-snovitoll@gmail.com>
 <20241014161042.885cf17fca7850b5bbf2f8e5@linux-foundation.org>
In-Reply-To: <20241014161042.885cf17fca7850b5bbf2f8e5@linux-foundation.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 15 Oct 2024 03:18:26 +0200
Message-ID: <CA+fCnZcwoL3qWhKsmgCCPDeAW0zpKGn=H7F8w8Fmsg+7-Y8p3g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 2/3] kasan: migrate copy_user_test to kunit
To: Andrew Morton <akpm@linux-foundation.org>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: 2023002089@link.tyut.edu.cn, alexs@kernel.org, corbet@lwn.net, 
	dvyukov@google.com, elver@google.com, glider@google.com, 
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryabinin.a.a@gmail.com, 
	siyanteng@loongson.cn, vincenzo.frascino@arm.com, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 1:10=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 14 Oct 2024 07:57:00 +0500 Sabyrzhan Tasbolatov <snovitoll@gmail.=
com> wrote:
>
> > Migrate the copy_user_test to the KUnit framework to verify out-of-boun=
d
> > detection via KASAN reports in copy_from_user(), copy_to_user() and
> > their static functions.
> >
> > This is the last migrated test in kasan_test_module.c, therefore delete
> > the file.
> >
>
> x86_64 allmodconfig produces:
>
> vmlinux.o: warning: objtool: strncpy_from_user+0x8a: call to __check_obje=
ct_size() with UACCESS enabled

Too bad. I guess we have to duplicate both kasan_check_write and
check_object_size before both do_strncpy_from_user calls in
strncpy_from_user.

