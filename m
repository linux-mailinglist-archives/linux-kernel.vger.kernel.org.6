Return-Path: <linux-kernel+bounces-337888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B799850B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D24B1C22E43
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB012148310;
	Wed, 25 Sep 2024 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DVfxL+tO"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6414174C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727228779; cv=none; b=W7nHVur+h7A2h8n1fOFvL0d8k/1brwTa8TL0RfqI3tVXVS93ACPDPiSr/ObTUH9RgkIWkTgV/ui4SYCXog4A61YHrb0CxLNcv9FKYJqvEIq020X8HUFJDIgc5Dn9VE9d+4DY7BMEHMHWOqch3cjSdCPnD/xdsrnjQL1VkjG/GFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727228779; c=relaxed/simple;
	bh=xUF69c+JXEl4NVUwF1HduHLgeTxgdRww8qHXpky5/BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DRxtTfw3/IztHh42HxH2xFNWy7d+FEgEhi83VJzEBWlACMy2Xt182GJXrEXnox1MKoyVQ+hudsR4fEhDrf2pxlSlDeSbQ6KbYCaNwci/16HSGpv/OPMkE8tmFQKUWuzbecGOqTW+a1F8zoSI/LjBXwCy8WUno2nXDoZdhQyvGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DVfxL+tO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d2daa2262so793310166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727228775; x=1727833575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPyihdkphzHjYHkiFltgJ2kdLQLirrIMMdhZ8LE0uX0=;
        b=DVfxL+tOdPFWW4PVOXFe6V3R1x20HQrmE6C7eUXEpqjVGKcrWOAI9XeHVSagCbGb55
         vwF/kuYhw1WdHJZM4ov9ZLQ/RZiCnR+Oxlun3dQmXCdKkYomTB3upwLZx+iQ5UZcMp/W
         krXsje5rUn9v7tuvVYP8tPuyzfJ+ce6mlehAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727228775; x=1727833575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPyihdkphzHjYHkiFltgJ2kdLQLirrIMMdhZ8LE0uX0=;
        b=aSD24TNg8Whl1n3lmF6CGUuRVxYt0gRBA36r17iD0jfFUlJvGTfuTjQPUWeE2Tlqy2
         NgwH7BAz1Fyt44f9GoYnuGVcGGWKrwm6z3W5bQFrwVRC/ZG9KQCYb4PQ1bNAjjFT6oxi
         5Op1KgCvSQO5joQFeT16AKIylUJdwVpIx15x0dM4TUgX676DU2oK373a8o6jowXSI1Gm
         EU77hRT0aAj/IRlIrZGcdfmoyUDGM9r5PjT4Rw6L6G2vAt21cK56rbNtbow0tq1ZcAnq
         m5VueECpezKlqyplXelqGcgOgkAkbbgUXFMC/KtrQeeTo252kZuOhmDFsrLaZ0sQzFeL
         AgQw==
X-Forwarded-Encrypted: i=1; AJvYcCUE/bNSKXLM1jcm1OFWEGQSsFmwlgMPJLXjZULqv+gZg/9nALTfoVt7+8TWFciEvwBSvzaWXVtkZ3Si5xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSRAQVouApsH0huhCaZSkqUUkghrd/BHuwnldT8V4M9FBfdhd
	0ftJ2Rfwoe8ZlRaSPzsZFqJlmldFrwx0MLB4MHP+d6848G9fp5co/xOtPOaHHl+g4h5rPAtNkip
	axsmHcQ==
X-Google-Smtp-Source: AGHT+IEZMmTW4Qvo7cHeiLc22Es1DRnuyZo9jusQ7oxhzM2HQog72TWKx9uMJDEL29i/TSAfuO5l4w==
X-Received: by 2002:a17:907:e25f:b0:a8f:f799:e7d4 with SMTP id a640c23a62f3a-a93a0664be7mr87736766b.59.1727228775493;
        Tue, 24 Sep 2024 18:46:15 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f470asm153366766b.151.2024.09.24.18.46.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 18:46:13 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so66855a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPnZV61Ezfp9LmhRKUeWnd1zqKh+MGOZFlArrx2gXjYbQQu6znSg8lP1UHwODAPmicPKDqk5wkRa1V5xE=@vger.kernel.org
X-Received: by 2002:a17:907:e6ca:b0:a8a:8915:6bf7 with SMTP id
 a640c23a62f3a-a93a05de3a2mr90554066b.51.1727228771898; Tue, 24 Sep 2024
 18:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area> <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area> <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
 <ZvNWqhnUgqk5BlS4@dread.disaster.area>
In-Reply-To: <ZvNWqhnUgqk5BlS4@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 18:45:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+zqs3CYOiua3qLeGkqfDXQ0kPiNUWTmXLr_4dWjLSDw@mail.gmail.com>
Message-ID: <CAHk-=wh+zqs3CYOiua3qLeGkqfDXQ0kPiNUWTmXLr_4dWjLSDw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 17:17, Dave Chinner <david@fromorbit.com> wrote:
>
> FWIW, I think all this "how do we cache inodes better" discussion is
> somehwat glossing over a more important question we need to think
> about first: do we even need a fully fledged inode cache anymore?

I'd be more than happy to try. I have to admit that it's largely my
mental picture (ie "inode caches don't really matter"), and why I was
surprised that the inode locks even show up on benchmarks.

If we just always drop inodes when the refcount goes to zero and never
have any cached inodes outside of other references, I think most of
the reasons for the superblock inode list just disappear. Most of the
heavy lifting has long since been moved to the dentry shrinking.

I'd worry that we have a lot of tuning that depends on the whole inode
LRU thing (that iirc takes the mapping size etc into account).

But maybe it would be worth trying to make I_DONTCACHE the default,
with the aim of removing the independent inode lifetimes entirely...

                Linus

