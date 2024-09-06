Return-Path: <linux-kernel+bounces-318497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FEE96EEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC261C21722
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D91C7B78;
	Fri,  6 Sep 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEpTkb31"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57C417C223
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613377; cv=none; b=mt5PqkwXfhfO2uQYHXRSqvCoAOVPbhWvZUCgiJGShgaC5PTiLJ3YdhJyrTg4zrwGBBOwMETrmLBl1sk7MoawvHQgO3STVWzPlCdUm2rd4Dkv9KFRINMk6QmN3RM/UfpGu21uVn6S/FKhIBWbvGjQVav8D7ww3kYj5u1/7PwoYbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613377; c=relaxed/simple;
	bh=vXI3+CWnVCxD3jxgBFr8fRdSkjPReA3J4iCsJpW7vwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0c84W+iBZtccZ/zujLK2RVKjHbqKEJSRtj45Lj51/rCfwD18xRKas9JEKq5UgOWMFFWkdxHBRUvRmeoKa9etKS8RXs3ZwEpet39rnBBK5rspQTTQO67pJvPePgMCXGZnf/9PW+cDMiAZJ+JY9Ut158+S4wX6L+yvViBOG0VAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEpTkb31; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so230032966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725613374; x=1726218174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWDTdSp8MaQzxWMHggACQJpon5x26di5jgLCCGz319U=;
        b=MEpTkb31KsvCryEyGDxNp3q8SOrDt2aMP9JixZqPYQqb4ftp6q303xMbWAEprPcb9Q
         u7EIlnfs9s/A6mpE+N3Hyxeywe8biOVCcExXclPzSCizkT0sZnV6L0lAMkLSFvrCq1Up
         fvqqeBi8Tj7VYjexJsxRW8bnG/REIN095NiHGC8jIZgK0iM4HYGTxHFPUGPlCMfDs+xS
         0jGlv7FhBUUdzezJZf8Lk1YHj2TE+Ecjmm1vau/S4U6fYhUh/J47UzEkHCeET8ZENqP5
         P9hvTwxf4s9CYBIcRzp5/QhzdCIxrQhhF8+r5kOQTPYgFxgNocjDUILEmecEC1+S3jaI
         9Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613374; x=1726218174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWDTdSp8MaQzxWMHggACQJpon5x26di5jgLCCGz319U=;
        b=kNyAWskNanqp557H1T0fvqL6gc5yD9vgoGLzdmskYhm9SCp2e80KEBph5C2eVWanO2
         VsD7lRFW97au+JC9VBXjeoicqpTzDv69+ZEMrahyuCDbAOVCsxkPSamdz4IAT8+2BZzf
         WhPdtFz2CxdaeOnVdrQQz0nKDsSYWK6AoyuL8/LOajAfgN+eVVKkO1entXEq1LGybxue
         tBaa+F2iQX0HPEJR943xZ4+HKBmRJYokWNNPsebI59wI6co3BeheHWnNrlCKcHIoW/fH
         ZyXCJdrYZJ/IOBei8yz1ZMh4vW/HGljYLuZKWKHgxVQeWE2rux3J4xsustUtderx23Ti
         W8Fw==
X-Gm-Message-State: AOJu0Yxlgpqcf5555q+LlAWngLHNYnnCo4SuipjCWZoE+k/Egv+31bFk
	GqWfzopjuzo4xff+7x88mNFxVb+YQFE9khX80dbwQ4qTN+FA0DQ7fxKxb/8weQLWhZPTRHYXNyR
	Dkdi8myXdxVJD197etFANi7y7TV6WX+WM
X-Google-Smtp-Source: AGHT+IGhbjH44iESmJRDI5YEdttWpwN9LgkjOlo15dwFpBWi8wXypKs2uNe88KizYFdj9URI2+1ReXZ0ojziyLKapC8=
X-Received: by 2002:a17:906:fd8b:b0:a8a:809b:14e0 with SMTP id
 a640c23a62f3a-a8a88871d22mr141192366b.48.1725613373791; Fri, 06 Sep 2024
 02:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725334811.git.bo.wu@vivo.com>
In-Reply-To: <cover.1725334811.git.bo.wu@vivo.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Fri, 6 Sep 2024 18:02:42 +0900
Message-ID: <CAD14+f2M+C_21h2bV6=GMhNwgWzLVaCL5jv1SQxsuKoveX6P_w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 00/13] f2fs: introduce inline tail
To: Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wu,

Interesting patch-set.

A quick test here on my daily-driver phone's data (785558 inodes) with
both compression and encryption disabled, copied via rsync to 2 fresh
f2fs partitions with and without inline tail:
Before: 170064928KiB
After: 169249780KiB

So about 0.48% saved.

Let me know if this is an unexpected result.

Thanks,

On Tue, Sep 3, 2024 at 5:42=E2=80=AFPM Wu Bo via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> The inode in F2FS occupies an entire 4k block. For many small files, this=
 means
> they consume much more space than their actual size. Therefore, there is
> significant potential to better utilize the inode block space.
>
> Currently, F2FS has two features to make use of the inode block space: in=
line
> data and inline xattr.
>
> Inline data stores file which size is smaller then 3.5k in inode block. H=
owever,
> for slightly larger small files, there still have much waste.
> For example, a 5k file requires 3 blocks, totaling 12k of space, which is
> more than twice the size of the file itself!
>
> Additionally, the end of a file often does not occupy an entire block. If=
 we can
> store the end of the file data within the inode block, we can save an ent=
ire
> block for the file. This is particularly important for small files.
>
> In fact, the current inline data is a special case of inline tail, and
> inline tail is an extension of inline data.
>
> To make it simple, inline tail only on small files(<64k). And for larger =
files,
> inline tails don't provide any significant benefits.
>
> The layout of an inline tail inode block is following:
>
> | inode block     | 4096 |     inline tail enable    |
> | --------------- | ---- | --------------------------|
> | inode info      | 360  |                           |
> | --------------- | ---- | --------------------------|
> |                 |      | extra info         | 0~36 |
> |                 |      | **compact_addr[16] | 64   |
> | addr table[923] | 3692 | reserved           | 4    |
> |                 |      | **tail data        |      |
> |                 |      | inline_xattr       | 200  |
> | --------------- | ---- | --------------------------|
> | nid table[5]    | 20   |
> | node footer     | 24   |
>
> F2fs-tools to support inline tail:
> https://lore.kernel.org/linux-f2fs-devel/20240903075931.3339584-1-bo.wu@v=
ivo.com
>
> I tested inline tail by copying the source code of Linux 6.9.7. The stora=
ge
> space was reduced by approximately 8%. Additionally, due to the reduced I=
O, the
> copy time also reduced by around 10%.
>
> This patch series has been tested with xfstests by running 'kvm-xfstests =
-c f2fs
> -g quick' both with and without the patch; no regressions were observed.
> The test result is:
> f2fs/default: 583 tests, 6 failures, 213 skipped, 650 seconds
>   Failures: generic/050 generic/064 generic/250 generic/252 generic/563
>       generic/735
>       Totals: 607 tests, 213 skipped, 30 failures, 0 errors, 579s
>
> Wu Bo (13):
>   f2fs: add inline tail mount option
>   f2fs: add inline tail disk layout definition
>   f2fs: implement inline tail write & truncate
>   f2fs: implement inline tail read & fiemap
>   f2fs: set inline tail flag when create inode
>   f2fs: fix address info has been truncated
>   f2fs: support seek for inline tail
>   f2fs: convert inline tail when inode expand
>   f2fs: fix data loss during inline tail writing
>   f2fs: avoid inlining quota files
>   f2fs: fix inline tail data lost
>   f2fs: convert inline tails to avoid potential issues
>   f2fs: implement inline tail forward recovery
>
>  fs/f2fs/data.c     |  93 +++++++++++++++++++++++++-
>  fs/f2fs/f2fs.h     |  46 ++++++++++++-
>  fs/f2fs/file.c     |  85 +++++++++++++++++++++++-
>  fs/f2fs/inline.c   | 159 +++++++++++++++++++++++++++++++++++++++------
>  fs/f2fs/inode.c    |   6 ++
>  fs/f2fs/namei.c    |   3 +
>  fs/f2fs/node.c     |   6 +-
>  fs/f2fs/recovery.c |   9 ++-
>  fs/f2fs/super.c    |  25 +++++++
>  fs/f2fs/verity.c   |   4 ++
>  10 files changed, 409 insertions(+), 27 deletions(-)
>
> --
> 2.35.3
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

