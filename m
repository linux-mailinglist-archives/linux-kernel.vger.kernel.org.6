Return-Path: <linux-kernel+bounces-357410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE929970F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75D628589C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A221E8829;
	Wed,  9 Oct 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEUEz3Ik"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204B1E1049;
	Wed,  9 Oct 2024 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489525; cv=none; b=iZvpm4lBKTcFw3J0ps489R/UEF7naPjW3ylJcc7YpEKKa1yAsGyeJgAvOLpapme3DoN1NdNc6UqAScguAQOU4Qn0+SngGqpjju2XMo9EJsCaOiMjwC70MdaTXxxkdhs8YkmbSB7sP6w3P4YDzFxiV7O677KlXse3TA9dQnU1p+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489525; c=relaxed/simple;
	bh=oBAwiLGHSHDOj8mD4XS8encO62UfaTbQ+URhaPIFhYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt3nb+FGOYcgyZyiTMr9atWTkDr/P5ZAO1lvnRvNwjsSUYTxZPDbkjXhnVr+sf5lOMg4dTEK58OCB8oXIXpotCGVydv5h6DrfXicFJSwxIUXUb7b3o8NPX6tEklO5oMcLs7AnhuYySaJGUs33LkdhiOeEtWvGzcxv5lh+M7IuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEUEz3Ik; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71df49bbc2fso655974b3a.1;
        Wed, 09 Oct 2024 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728489524; x=1729094324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBAwiLGHSHDOj8mD4XS8encO62UfaTbQ+URhaPIFhYI=;
        b=NEUEz3Ik4n3K7xA8PLFw0Mxl/oit20T5DlzWUCki2L4DMBj52mVOQp5ZfMjMPasm90
         oQtwPqcAkO7TeDctKZejZFKe3HIo1LU5rayTfEq1rNkyVQPtao8ripX8mnIB3rc2+iDS
         KTD50FjhxnLxJ5tUdS5UL5ST2qPVz76PLN0Lxt6jmOj7aSbvv9R12sz7zOuQkMCbW3OS
         AfQD18u5+TWlvDF7oNAfyYrrLpIQjiF4zvAyyNn/Zs3oaebiq7T7iZdnKVcT5AE67Wvf
         qFsErZ8FzIppgeXMykCKNTc/iWL9CAyQ7wHiK9Eql8kfM7rx5Qi+aU1zeF3qxWrsck9I
         ORuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489524; x=1729094324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBAwiLGHSHDOj8mD4XS8encO62UfaTbQ+URhaPIFhYI=;
        b=Th+97mc77hGtnL8WLeXgRfvlI63AO2RbQ2nB9BiMonQ1csA4B4CBbu53VCotmbpmKq
         3dF0tojCY5IB7UZ4pam19y6qLqCrtn0ZNyjOco/ZxjWkMoaVAtNCpKR3KhTEwStUu6jJ
         tnzU+PB0n2ChDtgni+gMPugnYTt8O+K/Kld3e4n0L9R+T/JlMxKJHBilum0epsA14BuF
         3gYM+Q+qgXgAip+TpoWK62+lpcLyu53EekVQHkio6gUZkswlEMLDIJ4kbEHpoOGT1fxM
         Yr/ocR2z2JC1uQtoXjJBAUdMsh4IDFLqTXVi/y6UkDezmed+nduT+cdhHz5InDsVUc0F
         nSLA==
X-Forwarded-Encrypted: i=1; AJvYcCUaMx+1jO+fo0LTPFNhjasj2rIqZwjFmDnXdVOvqMTEPyvL4SNEspDjkQTlfcX0M6Q2rbEx77sYV2TOl6A=@vger.kernel.org, AJvYcCVpgJ6gLodHIdeLM3DbqQRHmt3FaNEYMM1zQrHfkZo2ntWjWJsZMDsSBf1tg1+j/VoJ4MF0zAccixOJYvKnzbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwkgiE3sZdAvwlOlO3Z3U2jOc1qjtznRhh5V79B9WgDbgv1SJ
	SUcfNUt4j5auSq57bGzH9RnSvAkXyqvcqKru2KXA16MIwZiu1mXy4J3wsSYuSutNRYgF3Rz/31B
	kv7xEzAwQySdzIVfz4aDN8aSHQMs=
X-Google-Smtp-Source: AGHT+IHH2/cB4g/2MUkUZbMiqMJmjHju8cMBFQXUzMyG4OYKXp1NPuWe1VZngIGtsINbvtnXZqplRrwh0iEB23xRDJY=
X-Received: by 2002:a05:6a00:1a89:b0:718:e49f:137a with SMTP id
 d2e1a72fcca58-71e1dbcb854mr2071628b3a.6.1728489523704; Wed, 09 Oct 2024
 08:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009151017.26685-1-tamird@gmail.com> <813594ff-b167-4ae2-8105-e2f958ec2cc7@gmail.com>
In-Reply-To: <813594ff-b167-4ae2-8105-e2f958ec2cc7@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 9 Oct 2024 17:58:31 +0200
Message-ID: <CANiq72nUT6cFXCGg4jfN07W7UE-8vma=o9a5DQjsRwtNsKUGbQ@mail.gmail.com>
Subject: Re: [PATCH] rust: remove unnecessary #includes
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Dirk Behme <dirk.behme@de.bosch.com>, Filipe Xavier <felipe_life@live.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:37=E2=80=AFPM Dirk Behme <dirk.behme@gmail.com> wr=
ote:
>
> * Theoretically the grammer fix in exports.c could go into an
> independent patch. But if not it at least should be mentioned in the
> commit message. Let Miguel decide if he wants an extra patch or not ;)

Indeed, in general, one should not have unstated/unrelated changes.

> * Maybe a
>
> Fixes: e26fa546042a ("rust: kbuild: auto generate helper exports")
>
> tag could be added? Even though Miguel might route it through
> rust-next as its not urgent for routing through rust-fixes.

I think this is a cleanup, i.e. just unnecessary `#include`s being
present, right? In other words, there is no "bug" apart from not being
optimal (one could see cleanups as things that should have been done,
but I guess we should draw the line somewhere).

Andreas: was there a reason to keep those `#include`s, just in case?

Thanks!

Cheers,
Miguel

