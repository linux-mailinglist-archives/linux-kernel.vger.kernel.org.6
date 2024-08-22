Return-Path: <linux-kernel+bounces-296932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF595B0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08421F226FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8BA176FA4;
	Thu, 22 Aug 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FJI970c3"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D41C6B5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316131; cv=none; b=mlD4SurM39HnERlrp/CuaQUL3jY2kr/e58+psOUELuLvSVgm5uNPBadL+mHsjZrvNe8DegG+HmrMf6CEjNFg9rAY8gLHweD6NoQzzgV+fiLxLf3EvIRsY/TsjgaMGmmkiGkQtK1Nk3NXX5IoNGTEByG1qEev3jOZqAi+VdzsWZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316131; c=relaxed/simple;
	bh=zOwZKwgQbYh9I6K5vOjV4zHXa+b8rQusxeapSFGjSGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AN4yfUyM3oE880UGHw5yxko/4FcynXuzWTHY4q18I1wh0z0lWrEFeOZ1bpBZhdsvIn9uvHSLHRw+cBQtrxfooLOkzlseDf/YlId+FhTiOXDjhZQ/X6P8pvR+Yn4pNJR1uU1rpYwIh5Nvg206DNAYi/lamZGJ4Sg5vFl+uGipijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FJI970c3; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3bfcc2727so6976181fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724316127; x=1724920927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bn43WhWNELjWx/Xqi85FuxI5tpjHJSqlZGW7dAS/4hA=;
        b=FJI970c3Rer+TpNqutIKvgcFJ3eJ0WNhfdY+CR2GmgWu4kHbJgXDh1uYJ7sd3Be0bz
         y533t2b2Jrph83IOJg2z+MIH3KsPKSkFhIi4n+GDxBVu+MYF4b+4UJ3MTHlo22imD8lM
         /YDVDXpsv0bsaX8xoowaXipeRCxh6a6aQTEoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316127; x=1724920927;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bn43WhWNELjWx/Xqi85FuxI5tpjHJSqlZGW7dAS/4hA=;
        b=U6VdysiDl6pDd8iqRtWKaFXwFOYMk/UYz1vbUS66nO5t43r646TN2x3IpMqeTz2xEE
         oQo1u5Kk7MnAqxxIdRcWU2QnBuORSXSjVEuOyNZbFzRTIK80U5SDwuRXd7kmDH8aMwC2
         uyKG65SHPapc2IMfpJtrAXzpGQqkOnNg2kY3El58sywNvjo6plXbw91j6mvjDvu6LLmu
         1pV14k5+DFr7GS7m+iSUe1Cn5d31PTfEBv/gJzjqRiD3qiUENJaPeAO3d6kAsK+9WACp
         mpup4r5IHvUBVG6oPVRlXWzQYhGso0p+UBagHc8kMP2644uqXwFFjbkKO637v6bX9L6m
         BeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwlEs4tz1YwPpAE09Y1wz+NCVROCu6mfqXtr2WuunKXR5XXI2AltXuxUGnFv0ey8pJD2lwfycgOLLyABk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziAwrXm1IajvkBHtVvsTssVRGq+bB/HaCuLT33rIXdPFWJbWmK
	MFrnHYOF9RcXlae8agRjqD86aj/IXWLhUiVz4P8+Ux5hI2u6TpDXwMREitQDdiz+P6vhaMdY5ZY
	BdjT6PzJ0xPievhQnNo9i+c3SgBB9oFmNqEAL4A==
X-Google-Smtp-Source: AGHT+IG/YZ/WLpUENQ2C2Qgrv8N5KPSpA05zNxhVmjt9aj0GznyncRlTONhGYjX9dV5Eh1HlsEUMjsLQEPEEDjHgszQ=
X-Received: by 2002:a2e:4c11:0:b0:2f3:ed2d:a944 with SMTP id
 38308e7fff4ca-2f405d962c7mr8408181fa.15.1724316127228; Thu, 22 Aug 2024
 01:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-11-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-11-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:41:55 +0200
Message-ID: <CAJfpegsq5NruDeL6HRgkpj=QvdOKdnqOwZiRS0VY092=h0RSkg@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] overlayfs/file: Convert to cred_guard()
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Replace the override_creds_light()/revert_creds_light() pairs of
> operations with cred_guard()/cred_scoped_guard().
>
> Only ovl_copyfile() and ovl_fallocate() use cred_scoped_guard(),
> because of 'goto', which can cause the cleanup flow to run on garbage
> memory.

This doesn't sound good.  Is this a compiler bug or a limitation of guards?

> @@ -211,9 +208,8 @@ static loff_t ovl_llseek(struct file *file, loff_t offset, int whence)
>         ovl_inode_lock(inode);
>         real.file->f_pos = file->f_pos;
>
> -       old_cred = ovl_override_creds_light(inode->i_sb);
> +       cred_guard(ovl_creds(inode->i_sb));
>         ret = vfs_llseek(real.file, offset, whence);
> -       revert_creds_light(old_cred);

Why not use scoped guard, like in fallocate?

> @@ -398,9 +393,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>
>         /* Don't sync lower file for fear of receiving EROFS error */
>         if (file_inode(real.file) == ovl_inode_upper(file_inode(file))) {
> -               old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
> +               cred_guard(ovl_creds(file_inode(file)->i_sb));
>                 ret = vfs_fsync_range(real.file, start, end, datasync);
> -               revert_creds_light(old_cred);

Same here.

> @@ -584,9 +571,8 @@ static int ovl_flush(struct file *file, fl_owner_t id)
>                 return err;
>
>         if (real.file->f_op->flush) {
> -               old_cred = ovl_override_creds_light(file_inode(file)->i_sb);
> +               cred_guard(ovl_creds(file_inode(file)->i_sb));

What's the scope of this?  The function or the inner block?

Thanks,
Miklos

