Return-Path: <linux-kernel+bounces-299827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F895DA75
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6155F1F229EE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9714290;
	Sat, 24 Aug 2024 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OAIFGqyf"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D198F6C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724464964; cv=none; b=CHAO5T/oABO3Qf4KsIKBjTZmjPvg9cyg8EAwDtz+f7crzCjWDluh93aad/1ebucRqCnrnkBLxKYHdRMFfS46Kyh4pk2LcUToS6ZyrHyjpoSBHiV+wFEamiSn2rLPLm711MHa2OZDpmbngS1gsgOS4Y4R6+MUJYDEH9GnJVTPUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724464964; c=relaxed/simple;
	bh=PvxEnZaFii/sPRVmM5l16yEI1y18EcLbXmugTXFTBi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opKyQe6Xw6ngFbApZNYfXIXF33Z/wqnfZiLgbbqdh2XjH+XdbEz1B8CF7+W2YnaNkR+C01fFm2o1ze/UyvqteKevwZqLUidfljKUcQIIIpwUJTSYYD9JVVP97zfxqicbzq7wzz43n5NAxmLNeoTU3E47drEvOS5n/A+PximXM/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OAIFGqyf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-533488ffaebso2863431e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724464960; x=1725069760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ym980CqYxCsLXdz14ErVB+ivOLKtukT0tUKXVKCXag=;
        b=OAIFGqyfxnVCFKl+BQXAJlIpyu3PF5R3RB4gsf2TRCpuq6xO/KAg4//rQ3VCLx3Ij0
         mZfYPIvdd/0+yjCsvNEiiwVuZynA+U4F31H4m8RIoYAlTpgVuCmXtwHj4B7UTNfG0a3C
         b2FSY9PEgPXwyns/95IezhwmMzrIq7qSX9eTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724464960; x=1725069760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ym980CqYxCsLXdz14ErVB+ivOLKtukT0tUKXVKCXag=;
        b=syDKNuiBX9JX9DOFYX93QLl3iBMoXE6QPcgw+rYIFxHWbl0LwwXdW2zhhkGAF89GJn
         BaPLKCWD2l/Jyerk4oA/xEx0AEkXK3TrJpZSkwhQGBSh8nZX67Fpsvmu35UwzTo0U6cO
         ZxMLVhAJIeJFymvE2KrD8Ricu43wnnLKefd9deDC2NxWzRz2bm318PUaOXKtKhVhImN1
         g1AFJ1b7errt4jKX1KP3ibtlcMEJz27eOpOivFbfFf3BjUa2TTgVRCbU2disO+3MUBWk
         mDoMnYls447mlTIRCv29QT3bP+gT+wBn8bq8UDJnNRav9FGnneCm/+tTVLxjgQpii4Bz
         ET8g==
X-Forwarded-Encrypted: i=1; AJvYcCVlT+xTTLuu70ptG7NcZ2/LmcfADYoIjh+euafdXvYkXO8JDO3z+Q1PxESDGiZgMJyaLRt37Br/KD6N2bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCldRBnDMXz+OUlChIS/YPuXD1gNFgYM6mrjp7cI3cqTOJ9/q
	NfTeLleXvM3bCxHmGrN//gNw80tfsE6bVJNYWMUJ222XHnGu+ucOwVvdDA529jRYs7Pqptz3aSx
	lFclD2A==
X-Google-Smtp-Source: AGHT+IF5vcpJdjcSTVRF5sRlMqs5uWjwQYj/FvYI82caqYPavXKuPMFzhNGUL/kQpocQ5Bcr+K5BRA==
X-Received: by 2002:a05:6512:eaa:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-534387be220mr2405838e87.49.1724464959704;
        Fri, 23 Aug 2024 19:02:39 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea295d6sm706735e87.10.2024.08.23.19.02.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:02:38 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3f25a1713so27742381fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:02:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVH2xNYMgLZWcTRo5ZhNIXgG8wuZZWWzO9NJJ6mZ+ZAYAijzOUemcs5fg+1CYmnbPvsZacu477RDNGdvSw=@vger.kernel.org
X-Received: by 2002:a05:651c:32c:b0:2ec:500c:b2e0 with SMTP id
 38308e7fff4ca-2f4f4901deamr21932221fa.22.1724464958055; Fri, 23 Aug 2024
 19:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-firmware-traversal-v2-1-880082882709@google.com>
 <Zsj7afivXqOL1FXG@bombadil.infradead.org> <CAADWXX_zpqzYdCpmQGF3JgsN4+wk3AsuQLCKREkDC1ScxSfDjQ@mail.gmail.com>
 <CAG48ez2_Gs=fuG5vwML-gCzvZcVDJJy=Tr8p+ANxW4h2dKBAjQ@mail.gmail.com>
In-Reply-To: <CAG48ez2_Gs=fuG5vwML-gCzvZcVDJJy=Tr8p+ANxW4h2dKBAjQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:02:21 +0800
X-Gmail-Original-Message-ID: <CAHk-=wh2rRLv5hu4BaJ_8JGRrX+UiOA6x4mPtUHp12oNhnWJWA@mail.gmail.com>
Message-ID: <CAHk-=wh2rRLv5hu4BaJ_8JGRrX+UiOA6x4mPtUHp12oNhnWJWA@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
To: Jann Horn <jannh@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 09:49, Jann Horn <jannh@google.com> wrote:
>
> One other difference between the semantics we need here and
> LOOKUP_BENEATH is that we need to allow *symlinks* that contain ".."
> components or absolute paths; just the original path string must not
> contain them.

Yup, fair enough - a LOOKUP_NO_DOTDOT (or LOOKUP_NORMALIZED) flag
would only affect the top-most nameidata level. Which makes it
different from some of the other nameidata flags.

Not really fundamentally harder, but different - it would involve
having to also check nd->depth during the walk.

> (For what it's worth, I think I have seen many copies of this kind of
> string-based checking for ".." components in various pieces of
> userspace code. I don't think I've seen many places in the kernel that
> would benefit from that.)

Yeah, the kernel usually has trusted sources for the (relatively few)
pathnames it follows. The firmware case is probably fairly unusual,
with other sources of kernel path walking tend to be paths that have
been set by the administrator (eg the "fw_path" part that is set by a
module parameter).

I was indeed thinking of user level possibly finding this useful,
having seen a lot of "clean up pathname" code myself (git being one
example).

                 Linus

