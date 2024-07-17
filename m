Return-Path: <linux-kernel+bounces-254587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4FC9334F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 03:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123CA1F2335D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 01:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86B515A8;
	Wed, 17 Jul 2024 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1K8mNnwm"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F3ED8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721179346; cv=none; b=eiJII87U6qwIee/ZUH3Fmqx1F0R6taNA5vj6Ij/1yXGId+GohqRJEsUMSAwHIPa4GoTAqSLumATtHndRPjmS2/y3MymWfw1HRG3aDSpAQ7j1miCBc88YknLHYd56gsm/rmsH3Wg2wV94rvK63BGWa5Tf48cpp87yDwNJjRMxUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721179346; c=relaxed/simple;
	bh=UZUI7FJG9zfLb/AEzcLaJN+U3HH2U+41STHrzAi6Mvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udQuBWkMrltKnY3gD8tFyT5IhUfGzZvecL7804QSbYwmKbjjhzaJUpFaHF5wPZywUhoL1I8M9+Uift3wygg8NOHOY+XYjta1ryCHcL473vI8gWLjcEIVbXwVAB/TpjoYvGH3zmH/r1t1BDl421eUe0We3EomQEmNNUvqk23+4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1K8mNnwm; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e036d1ce4f7so305025276.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 18:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721179344; x=1721784144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZUI7FJG9zfLb/AEzcLaJN+U3HH2U+41STHrzAi6Mvk=;
        b=1K8mNnwmbkFvohaDyrXMpHA3XvOTteaZP0UkAhkJ3gOXLljpwbiBgIAq248PhWgrmb
         E6ArUo6UFo0ih3yKZMY6ufdrjmwMs+tbY9a02ImW9L5+4LF1Z4FgJMAe5VVxa7BD78ze
         FW3m5IywxB27Rk6051Xda64JFHWusC/2hp/2iu4yWq+2ZQQSBVWOVB87Ko3313Bes9sz
         foFik7k88UWJTE8N23AWrix8k2EpqZAsHY+zkeEwJ6rtC2xFlHnb9ArqHTXSfymjAEi0
         jj8UwlQ9n1rRjijQ6PMlj28Y6VNpu+zO4GCN5U/wJhQ/oyipXELyknhDczB63vZSa7mb
         JaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721179344; x=1721784144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZUI7FJG9zfLb/AEzcLaJN+U3HH2U+41STHrzAi6Mvk=;
        b=oiJnxWShtreL8K3poSoNDVekss1n2KFoj0K7gfeHSrJ5MCfMfaA5SbR+5WjlMK8WDv
         Ymx4jZahf6ZSpIyAnpcSt3pr5Yqtpdwa5SPqv2Y/YZKGeasrhBlLtX7xJ+2X5ApNqqJo
         fqPjBCyujJWKS+fbwFG3n6hJgQ10e1ElwLq8HrpwzpoInigkkKbNYt+f7kt73OrnRccU
         1WqjYMJ+XHFSVMvQfH40k61gC3wkQOGg0epjKvbdV0JzQsdVWohCnxkUG6mvwJzOGvJG
         CI3PWx4Rp333GPng4/Oil3B2aWDD2z+dvG/AUgaFS7+CuuDgKFtxFS/ln/Y3AYC7pSqY
         SziQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIs7zLZdL5ZhOOPnC5i+OTCIrTYaikvitDR44ndrQRyGH2vCNoDqVT6ppmz2DQBgzCS0se8uROWddLZeoQuZigaC8PLvHOtz14fyHD
X-Gm-Message-State: AOJu0YxuVNqeewpH2xc7GtX8PmgCLI6j05u+s3E9I8dsLznyt2gvSbI0
	338GH4C4DLZGqULIBm4w42CMbUPdrKbKkS0bSyY9+NRk43GidrSMvjdR/BavKOW2JTA6Pm2jfPI
	D+YWIdJeaHzlyp7/8ltmRXlFHqk64X4JxmBJ/
X-Google-Smtp-Source: AGHT+IH7H0lu+6NNAxh1bFNPzp0/m26YBTmH4JeTpQTaooazXAIaLFqjmsBHamMvor1xI+mX4AJv81vFwtlasdSGI+k=
X-Received: by 2002:a05:6902:c0b:b0:dff:2c27:c019 with SMTP id
 3f1490d57ef6-e05ed705177mr166528276.13.1721179343430; Tue, 16 Jul 2024
 18:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711204626.1669138-1-surenb@google.com> <ZpCwPCAsN17ADt-R@infradead.org>
 <CAJuCfpHX9SzPBTxQg2NjKPjbeD60HAotdK6DqnFmn3crvnGdvQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHX9SzPBTxQg2NjKPjbeD60HAotdK6DqnFmn3crvnGdvQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Jul 2024 18:22:10 -0700
Message-ID: <CAJuCfpFmfMH0=qOUz=Z_-QjgguhL4XKbZZ2ahx26HyYC23NGWg@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: Export memory allocation profiling symbols
 used by modules
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 6:27=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jul 11, 2024 at 9:25=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Thu, Jul 11, 2024 at 01:46:26PM -0700, Suren Baghdasaryan wrote:
> > > +EXPORT_SYMBOL(page_ext_get);
> >
> > > +EXPORT_SYMBOL(page_ext_put);
> >
> > These really have no business being exported, especially non-GPL.
> > Please rework whatever interfaces need them to be be moved out of line.
>
> Ok, I can do that. Thanks for the feedback!

Replacement patches are posted at
https://lore.kernel.org/all/20240717011631.2150066-1-surenb@google.com

Andrew, could you please replace this older patch with the new
patchset (2 patches now)? I can see the old patch in mm-unstable as
ac5ca7954e4e ("alloc_tag: export memory allocation profiling symbols
used by modules") and I think it's also in your mm-hotfixes-stable.
Please replace it with new patches.
Thanks,
Suren.

>
> >

