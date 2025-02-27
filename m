Return-Path: <linux-kernel+bounces-536343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248CAA47E69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB9457A6A93
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1256622E011;
	Thu, 27 Feb 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6zhz1Ob"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770622D7A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661121; cv=none; b=NfAJYxa8uttZSRBgnG7fNjIIjDO10EvRA1wjx1NVnSdMe0IoNhqaHFJDrf+5IwMH//rpmAoTre2fke8yzNpVUUrAyr/84pqTqSCCHv2XwLJw2neILCAL+pPGSYTgkkv5D5qV/9a0r0GLtto5iUQuCLNmuzD44ECtrwzFh0e46RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661121; c=relaxed/simple;
	bh=OFYnIq793NuM0btT5FzmfI/mMUo5NiWyCraruKChrVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMtOo5LpQ6KlW1XUKF3clf4njYjU8Ij1dcyOQITeAsKdkDcaptxycaPHCEWgIGWE0TNKfF0UC8KTQL6omvQHsiqPuauSxndbJXzgDxggd4FD7gpn5lJQp1P7SdhgePRGQ7VXOMNUbs94UC8LVlxqW8dfSHDCI8kcEufUCvcT81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6zhz1Ob; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-472098e6e75so200761cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740661119; x=1741265919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CcZCFB7SoHZkFrArtueJCGhId3S5+D+C9zJ11KxR52A=;
        b=L6zhz1ObzcfzvFK26Bii2Kqz3mYePnW2rPeXfOXuPmxoDITZgluJ5CT9ErJCX6ps50
         ar6TwDzWMM6n+NSD0pR0eZN6fJaqJASAvZMMmgrMFqLWq5q0tuT7b0OcFKrPV6Wh83do
         3u2surGFQIA1tigVx5O8D+Rr6X+/ngEcKvD08Hc6Xt8JN1VOy+6x4allvGcUyVI9cdBm
         CkUqOxhRASsi9ne9B/FbCLXQuMnohNxZ4AgAtcxdW3K6fSnzzvIu7DVIyKk33g/Cxier
         0luGHKer3B8DiPLVgDO6rCBH3RQ78DEJGs9wXY8etDSqcx4YgxKyMI/y3gHEF9zgeaCZ
         xVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740661119; x=1741265919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcZCFB7SoHZkFrArtueJCGhId3S5+D+C9zJ11KxR52A=;
        b=grRA8qrUbgt8D1U7T3WZKqz3mBC6rk6fvO8JKQKcTPwaMaHi9uNoGfjg46siDuZFQR
         f8fEqtTsTvGW8s4/vXHlpCp08L08fWXxNJj8Pm199gFkceLFX/91LqdAxlWb/7XRQDdb
         SQeF7/1/9C4pM4FITJqJy3f0/JpJsTPKdK+D45u1bXs/asc3xVEOUXSYEGv6nzATX7pz
         aBHbfQvYz/7FF7SffOKLRImQi/Ulje64STZPHXftPCz0Pw/VrYol8KUCeYj6WFXvP3i6
         5/pWoOqAiUSSHgOw6D6XcSuQPoR9HUzywpU01JbSoSB1rWUXZ9/TWvGWYQVjkuai6n1i
         MpSA==
X-Forwarded-Encrypted: i=1; AJvYcCX4gg8fI2YQXlOrQBCdWJsktKzS0BTOdQwFw5X6rx80IZSasFeYspX5H5hV3SlvqqSz0PPSXu4OkTmLlYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm34tkyIyiCO8p3gWX5GpgSJsQYcdjAMjwCk+2+qmstVWS/pUZ
	XPXfEL1fqzNcjPHTYM7frnLpKu6iW0pVcaVcSJaY4PeImxdC1ugVPJGuOmCb0n4g6Ez+C97Uk9E
	It08c7DyiSBtRkVKoFeEtv9qTN5WtIWGYX3hr
X-Gm-Gg: ASbGncsV6g/s4beVsb3OOr0MFVHxgf934D+YX7T4+CWb8FqWnumptZe3oBN3UUhBVo/
	G27Hua+aYiEXETuvifUZUQLq0TDkuU7C8WHYorenwDepDha0SrVPqqCsioY6hKJhQu/q8gBBLTh
	mm8x9AU5HgFMKRkWgurxj0vILeSees1QP5FdBq6w==
X-Google-Smtp-Source: AGHT+IEuBKSHpYxPNkV0mEO8sF0yf5/Lrk4PNkOlzERDCq6vsKG4jqX9UOkFNRukujqr7d02y1J5NqmBMP5NaitgJ5Q=
X-Received: by 2002:a05:622a:1651:b0:465:c590:ed18 with SMTP id
 d75a77b69052e-474a79840f5mr2914841cf.9.1740661118636; Thu, 27 Feb 2025
 04:58:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
 <20250221-mm-selftests-v2-8-28c4d66383c5@google.com> <CA+i-1C3qSSgxJKREyVxFqCwZxGfZ+2962P5fKMATYFLGFb7fWw@mail.gmail.com>
In-Reply-To: <CA+i-1C3qSSgxJKREyVxFqCwZxGfZ+2962P5fKMATYFLGFb7fWw@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 27 Feb 2025 13:58:26 +0100
X-Gm-Features: AQ5f1JrLdoCao1EqWIf9mO14WcJe1tYISuwUsBkKuAzcC56r8Ht7D8KrPqBSm9U
Message-ID: <CA+i-1C3SYay4WqhGUG1nDpVZT-FRDSzgLHEbH1ONQygjYJS9GQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] selftests/mm: Skip map_populate on weird filesystems
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 11:25, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Fri, 21 Feb 2025 at 19:26, Brendan Jackman <jackmanb@google.com> wrote:
> >
> > It seems that 9pfs does not allow truncating unlinked files, Mark Brown
> > has noted that NFS may also behave this way.
>
> I have not investigated at all but I _think_ over the weekend I saw
> ftruncate() failure on a QEMU guest where /tmp was tmpfs.
>
> Most likely explanation is user probably error (like /tmp wasn't
> actually tmpfs or the tmpfile() did not actually come from /tmp).

OK I double checked. It was in fact a 9p filesystem, turns out
virtme-ng uses that unconditionally for its --rwdir/--rodir mounts
even if the root is virtiofsd, and the tests operate on files in the
CWD as well as in /tmp.

I am still pondering ways to tackle this kinda problem more
systematically but for now I think just skipping these tests is fine.

> +               ksft_exit_skip("ftruncate(fileno(tmpfile())) gave ENOENT, weird filesystem?");

This is missing a newline though, ditto in the subsequent patch. I
will wait and see if any reviews come in before I send a fixup.

