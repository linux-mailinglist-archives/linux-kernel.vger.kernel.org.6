Return-Path: <linux-kernel+bounces-255648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A6893432D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD66282465
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CE51849F0;
	Wed, 17 Jul 2024 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PJOmvklR"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939C6A022
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247699; cv=none; b=O+24oAEJuPPKNIWVnXPqTuVooC8MOfXt5KSx7vi5L6LlVlBq+DOKMRLhTV/Tt04JTR2G2Y3ECHmE0qsKNQ8G41joWJOYfUyaFso0C9nhqi6U3dzHJ+j++HVMbTp+O8tSjK5RA13Tej0ukucFS1Ig0m5BiHqAm4yJQbB+eQzzXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247699; c=relaxed/simple;
	bh=F62dhyXKuf3KuoDqBu23LhP34ibc2G9DlvcvwONj4Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggp9Tokk8TcxxmIfNHtNBlSY6UHQxbW6mSkOY5kwlsgTwwBCmJbhKGt3iq45suKRvxsVcmTKg87e2pK9WVlHmJdfmrBu+Hcm3S/+1lcgtkELwy0va5qYXTXnGF44eocS0tW3rsOd3zAfY2CgVssK/50/PwD+A0+d9BEjFZo/ANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PJOmvklR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77c9d3e593so4780966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721247695; x=1721852495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcYek1X47IdJAigxA1PBJaYwzUbk4Cxy09ZUwrhJ/mQ=;
        b=PJOmvklRfuRFO1BxFfcH4ZHuJ+jxyhhEhAjoUo6mp9ouNO69yaRugjntlSqVL2TBPm
         G+JEjvKPSbg/jheBmgoffRJSP/QDsOlOPgI4qjgQBE2d/s20xZmfkg/TI+8mLar/4E8Z
         Ku34Wyrv/Z00Ws3rZ+L4+pbtyvt3WUQ1GNyCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721247695; x=1721852495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcYek1X47IdJAigxA1PBJaYwzUbk4Cxy09ZUwrhJ/mQ=;
        b=sjVjjN5hJs1TRLmZRgtJsl8/PSqZYDqTfDl+ImNwm0pwEVqY0/SXMv9qlCqN7x3+If
         /E5ZBP1BTinP1xPa6yZEaNMYO5PMfRTL9TECKL3G2dFpUalOTiKrZz/IkBiAenFC2Wzi
         gDoTUZQXSmYT/TlY/+8bFe7gPBG9GVLivEVumqs9ACbwLIigTNh8/l8NBxirasZt6bM/
         a207UeNI7YTDu3UZizOYpccBsluhOvGE5/6D11mvUCLO23UPZ7XDm0KoTFrUECHFh8G2
         sA6IZR8QjQfRSJeAXczQ+oPPJvsKLMg0y6MWAZrvr4uPy9MScD+BX6latDQiiQdX1q1N
         HhhA==
X-Forwarded-Encrypted: i=1; AJvYcCXVZIcr4GRclkWU7Wj906UhgVDhiEaFRhZtx4S/wkm85CtKtRtl+F6xbQf7mdit3AK/6aCk6aZL5qct+1jDCrtQhn0xTRGNHEq9n23F
X-Gm-Message-State: AOJu0YwJV7k4ZSLBP4JHBER8D/bpRwJWfPW1HC2M7+a09XRJN3MUe0Jy
	hZhLtDDF1KnB3Pllw56q+5g2Ar1DIv4zSviDn2giQR9p5VObnyMeqpEucBIKnPtQ5MfRedWjpW4
	ZCvG0Rw==
X-Google-Smtp-Source: AGHT+IFqTrKcUxt4qsTl8EHHngu+wle64riHfaiRFcgnQDbYwiV+5w81I/T9luWFWLuE9yEzrenvug==
X-Received: by 2002:a17:906:360e:b0:a77:c5e4:eebf with SMTP id a640c23a62f3a-a7a01347ef8mr188598466b.54.1721247695278;
        Wed, 17 Jul 2024 13:21:35 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3560sm481703766b.4.2024.07.17.13.21.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:21:34 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a09634354eso45330a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:21:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTJMtW3NDwwNEbWySfkLe0VBINMEHCSb3aGTBRKZlj0zP9ssYmvaq3MdBdiYIINm3XA2ZGNnHxfpqCtPkm7TGIdbMZOrASSuomGU2m
X-Received: by 2002:a50:d593:0:b0:58c:6edf:d5d2 with SMTP id
 4fb4d7f45d1cf-5a05bad527fmr1878679a12.15.1721247694305; Wed, 17 Jul 2024
 13:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721066206.git.dsterba@suse.com>
In-Reply-To: <cover.1721066206.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 13:21:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgw9uyrpi+qL28Ee650p7jaXEMjUoRzXBymraoENDMt6w@mail.gmail.com>
Message-ID: <CAHk-=wgw9uyrpi+qL28Ee650p7jaXEMjUoRzXBymraoENDMt6w@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.11
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 11:12, David Sterba <dsterba@suse.com> wrote:
>
> There's a merge conflict caused by the latency fixes from last week in
> extent_map.c:btrfs_scan_inode(), related commits 4e660ca3a98d931809734
> and b3ebb9b7e92a928344a. Resolved in branch for-6.11-merged and that's
> been in linux-next for a few days.

Oh, and I notice that my resolution is slightly different, but looks
like the actual code is equivalent.

I kept the "q" logic that had been introduced by commit 4e660ca3a98d
("btrfs: use a regular rb_root instead of cached rb_root for
extent_map_tree").

I don't know how you prefer the code, but it kept the two "while
(node)" loops in that file looking similar.

Of course, they were very different in other respects (ie
drop_all_extent_maps_fast() does all extents unconditionally with that
retry logic, while btrfs_scan_inode() has that whole "bail out on any
contention" model, so whatever.

Anyway, it all *looks* ok to me, but please go and double-check that I
didn't mess something up.

                Linus

