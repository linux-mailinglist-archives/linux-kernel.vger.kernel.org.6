Return-Path: <linux-kernel+bounces-240082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF49268EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36306B21A3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8C18F2C6;
	Wed,  3 Jul 2024 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W8ft7wQo"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71D18754E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720034325; cv=none; b=ZA0WtZfAwxys5Ds3XP7HJDljNkRCrBMEnEAQQ8/COtNX6ZZrlhRgQt05SNVmufqr6TsEbHHiPRiN4p6PMhKrFEQsUsaaFHzT9jgSg5iQFKnVBhkIjBzRI1bTSGieDajfV6XBiwopTZ1ifc4n7ocsMjb+zn+R8egqb4HNRXJ/CNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720034325; c=relaxed/simple;
	bh=+AVBoBhIk9uvDrY2HwwpSGMN8MBB00EEF6Yp4o9XmHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzPYngwimIvFWaXJ+P++sjv8fjevADCK8DOOVhMky5A9+PKf01LTOR14j0tGVyF6m4Q8opnE9HnkOGS/OeXDSCCzfqpyoS3WXxVCiR7vxWP0s4MicxHMpfElEGfihRl7V/B14H5o5WuQyuDEHcVYm+CtGox7QJtdk2o7kLvmpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W8ft7wQo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a75131ce948so562624366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720034322; x=1720639122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X/vmIOX7+1mJHRpZ4d4vcUWyg4V3MldncLokOxZ7oSY=;
        b=W8ft7wQo3tUkgBoduBdifVgL9Z0NNJ3xlRdNz2JgMf6OA04d3GCY2LZ/6HbUHOiqFb
         Moo0DF/5fWImNeTgN5Yf27CgGnm/e5js9odE7DKh2XudvnHeP+bICdGrnhtQidcS5xeP
         4N1wdWaqGS0qfymF9ctMv1P8d7Tl17OoCGBCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720034322; x=1720639122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X/vmIOX7+1mJHRpZ4d4vcUWyg4V3MldncLokOxZ7oSY=;
        b=qNhv7+635X3ttYIMi0pTeAx59lDAXcFdZz5jna2g6aaX9VG24XBJS5yyg6OzAaJyEM
         iBg8kqATGN68POgy00gWnT78CybuPAHJlm24RYZ2Dv2huMROP2w4Ae85TlrIH+pCRv1N
         OvpR6nMeIrrBrS0B3QSnEqW0S4ThAk26US5+zjq0SC0ncxKxSMASBwSsa1glBWyEWnLx
         +iyVMw6GDxHdvojo/17mzczmMbb2nOirF9663ntJy4ZtduzqcJFEzMrlcP8DtXQqqkbP
         t+O/1JfjJT05k7b+nmDL7BdQubpZyIvxVVdUWIPoD81dNgaJ+FJoVOoZV8RGF4ii047i
         6sjg==
X-Forwarded-Encrypted: i=1; AJvYcCVT9XxjE7GEvcwmI7vhxUvDVZbGz1hCf+2jkp65IbToVn1NdIwMrE4XlEF5aLEPmZbOsQsbhs239hHrncSqwz5U6WDLayfUwmeq7wLL
X-Gm-Message-State: AOJu0YwTDznA1oY+61rQ54fqmqlttA/6oIwuXb9yUu5hJDo2LAl/XgQw
	Jc7X+0tcXUrHoJWkRDNxaXSvLuPkZZsi9gZHDyvpL+H537zjePxwzbIqDDcbGETULQCDWP9gCQA
	xadqXnw==
X-Google-Smtp-Source: AGHT+IEFVq+n1V48XwolK0rz3AHTmWPKLuyqeMowisi1Lieh/AKfWjm4mByBldPgJC2eoLj9FkfLiQ==
X-Received: by 2002:a17:907:7f11:b0:a6f:fbc7:9088 with SMTP id a640c23a62f3a-a75144a2b43mr919891466b.60.1720034322137;
        Wed, 03 Jul 2024 12:18:42 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab08cf7csm536913866b.155.2024.07.03.12.18.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:18:41 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58bac81f341so2340277a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:18:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUt540Ep51B+PrxBhoxGhT0XaeYkoJWhf/nE7gZelzZg5sl4bWP4ISqfjxvl6XHbfhEW81e7c4kRwrf+7kRMu/vkGeIA1jhI2cnE7W1
X-Received: by 2002:a17:906:f756:b0:a72:42b8:257c with SMTP id
 a640c23a62f3a-a751444c4b3mr871005166b.35.1720034320670; Wed, 03 Jul 2024
 12:18:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com>
 <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
 <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com>
 <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
 <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com>
 <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site>
 <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
 <CAHk-=wii3qyMW+Ni=S6=cV=ddoWTX+qEkO6Ooxe0Ef2_rvo+kg@mail.gmail.com>
 <20240703-begossen-extrem-6ed55a165113@brauner> <CAHk-=wgCttiyp+3BBzhqKv+uXuUr-fzw2QbmH8kXwO+sB+FAaQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgCttiyp+3BBzhqKv+uXuUr-fzw2QbmH8kXwO+sB+FAaQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 12:18:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=So-PDxjetjN6bs3878rOYpz8EQgU+JvrHmLF_0hgBw@mail.gmail.com>
Message-ID: <CAHk-=wi=So-PDxjetjN6bs3878rOYpz8EQgU+JvrHmLF_0hgBw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Christian Brauner <brauner@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 12:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Well, I do think that a *new* architecture should indeed add all of
> those, but make the 'struct stat' for all of them be the same.

Just to clarify: by "all of those" I don't mean all the
stat64/oldstat/newstat variants that we have for compatibility with
older ABI's, but all the "calling conventions" variants.

IOW, all of stat/lstat/fstat and statx should exist as separate system
calls, and libc shouldn't have to rewrite arguments to make one into
another.

(And yes, things like 'strace()' and friends should show what the app
did, not what glibc had to rewrite things as, which is a private pet
peeve of mine)

         Linus

