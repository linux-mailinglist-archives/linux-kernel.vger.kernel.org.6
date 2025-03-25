Return-Path: <linux-kernel+bounces-574764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E2A6E99D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49CE3B289E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A171F940A;
	Tue, 25 Mar 2025 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk9capCw"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E2A93D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742884318; cv=none; b=gKS865Kut4eqbVKBrsmCD80v4FILqva09aCEJtZzCPbSfdAyLeWX3q/GSc1UA5UmKs6lTz6TnIW9uluYUntKDwPQ3St8fSxRkcJK7MRR3sZJ4pzVsYK+6ArKUcwmG0qysH/oPUX699tc+UMHeUCSS75xbKAMjNqGthfl99InSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742884318; c=relaxed/simple;
	bh=SkQqxGKNiljyIZlnqn+Lo2DrXF//cWUvDJHxGd4e5Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLIonQDAseabvREydGpC3DLIVeUp17O/S1vG/tSSM+WIFY1SPNF64xcnZZ0RaqqRbcFOleDZBzo/+mFZ1P6XSSBAC3+NxcXFHbcLD8rb7Nfx7Cqy6N1zPOegS678oErz2/b+sEItHUQqByac2t3xlD7yKUOgR1D9c+OXGqYFbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk9capCw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912a28e629so242423f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 23:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742884315; x=1743489115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X860nupmboDfYtXL+tF8XtwY0bU17LDXV6SNYZ9AyHM=;
        b=lk9capCw6WPpEIwUw7Zekl2nAUnwZQGw78qyd1+yJ9LPCcliqjPUPF9zAi1AVSCGy+
         JQYwt+X9NI7oE0KE0a1HyeFUCGNx+hKCbH9GR63S44BzLLAAjjnZln6uLgT6yXnvCwV9
         0vDDK3hIgJuvJio/GB0+DGMFUR1pC80LlPGh4hKtmd9tDH7KN/qkodpwrQYRPzakpxnP
         n2JG1CvyBhSZO8KnGTU0hwZx+8STDyBbjdDDQXFb+9VeMJ3nhB6GlQvx3Pymt2Sj+kse
         34LWZZwrgP1yKAHUAqSZE76767AN3HexJsyJUW84I2Rrn/4acJFOmg2W8m31SzeBQnKm
         RPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742884315; x=1743489115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X860nupmboDfYtXL+tF8XtwY0bU17LDXV6SNYZ9AyHM=;
        b=woTns0qt+ndn65m1RaP+GqLnf9uiVdI9x3SyHDxnH9g0EiAahRC+7mOJ5ngoLWQo8G
         8BTZPRteT41VbUmbnTNbW2lyrN6PFCyGobw8UGptIqYfwGszvIli8eD5nmfWpI7EdesL
         6MkfTb+PRKNuVSVuVacpVO3oadTmniq3fNtrI37gs1Xi8L8JVbvfI33lod42Ot6QmKE+
         xwPdDOyDWKURILfu/S6pOUZ1vXsARLud3MzOsuyKvlX0ns9OWzs7bmAN90N5WA0H781c
         Q79EYhCATtELIe2UZmcVg4T7j4HBuXJCi86mNBUeQH3G7a6ylqUyOZY+LcSRmD7kTx7e
         cr3A==
X-Forwarded-Encrypted: i=1; AJvYcCWV/cRetzKmQYJzsEr/lW4H5fEGmiV7gCmqdu4J6tSNEV3AyRlhee4Sr1cAQqVfqadPzYAu2RvBrsmRWLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirgMx91g2kgaij8OTaUSfbY9FYUYY1LgTpHZn7rgpTcmNg5zD
	HW8TAvdnPKde31HUYp30gI3n8t/fi1nM55clm5UFkrII9gZnN2diYCm+Vn+jZ2EuPorB6+mO+TK
	OaBEDJLLcNy3sF0iXGYsFmRYME9E=
X-Gm-Gg: ASbGncvcBoR1v8x2KjeLY/FTRNAsCBWSUK2ewbHgodSzyS9pFF8W/BobueoKTlpcY9Z
	NXUdFAD5dbw5WtO885xo8tlE77fI7ukmZk0otozJEvng79/P9yIKi2x6WEl0T24ZNHiIR8f0Xx2
	sSqwM3AryjsAiRkbRsbvHezGPZn20=
X-Google-Smtp-Source: AGHT+IGoIQI/mz5IUCpAdia8cBAvR0xR7P0OJVTwcj2mE0+pGBWU7JWFbdNKih2syBdjS0lvzRisq1remstIlnIxcoo=
X-Received: by 2002:a05:6000:459b:b0:39a:c9ae:db5d with SMTP id
 ffacd0b85a97d-39ac9aedcadmr141710f8f.9.1742884314557; Mon, 24 Mar 2025
 23:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324113249.3084413-1-chao@kernel.org>
In-Reply-To: <20250324113249.3084413-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 25 Mar 2025 14:31:43 +0800
X-Gm-Features: AQ5f1Jr2M8j4355BvwwdTTEt9asuKdRyEj-MRl0ABAnqui0ZPzUw1Z8OFBwx9JE
Message-ID: <CAHJ8P3L0vJKdLQMSGGQJuDD3_++8BhV1b4cvL4PCFu0WY+EWwg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a fast path in finish_preallocate_blocks()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B43=E6=9C=8824=E6=97=A5=E5=91=A8=E4=B8=80 19:36=E5=86=
=99=E9=81=93=EF=BC=9A
>
> This patch uses i_sem to protect access/update on f2fs_inode_info.flag
> in finish_preallocate_blocks(), it avoids grabbing inode_lock() in
> each open().
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index abbcbb5865a3..bb6ba3269de0 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -554,19 +554,24 @@ static int f2fs_file_mmap(struct file *file, struct=
 vm_area_struct *vma)
>
>  static int finish_preallocate_blocks(struct inode *inode)
>  {
> -       int ret;
> +       int ret =3D 0;
> +       bool opened;
>
> -       inode_lock(inode);
> -       if (is_inode_flag_set(inode, FI_OPENED_FILE)) {
> -               inode_unlock(inode);
> +       f2fs_down_read(&F2FS_I(inode)->i_sem);
> +       opened =3D is_inode_flag_set(inode, FI_OPENED_FILE);
> +       f2fs_up_read(&F2FS_I(inode)->i_sem);
> +       if (opened)
>                 return 0;
> -       }
>
> -       if (!file_should_truncate(inode)) {
> -               set_inode_flag(inode, FI_OPENED_FILE);
> -               inode_unlock(inode);
> -               return 0;
> -       }
> +       inode_lock(inode);
> +       f2fs_down_read(&F2FS_I(inode)->i_sem);
> +       opened =3D is_inode_flag_set(inode, FI_OPENED_FILE);
> +       f2fs_up_read(&F2FS_I(inode)->i_sem);
Hi Chao,
F2FS_I(inode)->i_sem is not needed for this judgment FI_OPENED_FILE area?
because inode_lock has been hold and this is a write lock, if process
A get inode_lock,
other proccesses will be blocked inode_lock until inode_unlock with
FI_OPENED_FILE  been set?
how do you think?
thanks=EF=BC=81
> +       if (opened)
> +               goto out_unlock;
> +
> +       if (!file_should_truncate(inode))
> +               goto out_update;
>
>         f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>         filemap_invalidate_lock(inode->i_mapping);
> @@ -576,16 +581,17 @@ static int finish_preallocate_blocks(struct inode *=
inode)
>
>         filemap_invalidate_unlock(inode->i_mapping);
>         f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> -
> -       if (!ret)
> -               set_inode_flag(inode, FI_OPENED_FILE);
> -
> -       inode_unlock(inode);
>         if (ret)
> -               return ret;
> +               goto out_unlock;
>
>         file_dont_truncate(inode);
> -       return 0;
> +out_update:
> +       f2fs_down_write(&F2FS_I(inode)->i_sem);
> +       set_inode_flag(inode, FI_OPENED_FILE);
> +       f2fs_up_write(&F2FS_I(inode)->i_sem);
> +out_unlock:
> +       inode_unlock(inode);
> +       return ret;
>  }
>
>  static int f2fs_file_open(struct inode *inode, struct file *filp)
> --
> 2.48.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

