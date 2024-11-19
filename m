Return-Path: <linux-kernel+bounces-414033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3129D2221
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA54B220C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D519DF77;
	Tue, 19 Nov 2024 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KGx2XdLK"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B761474CF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007153; cv=none; b=gZPs00QAIjF92tx9WjdOAF0xAl0Coa8cYTedbUKYVvpfxs8fRiRXMAsh+rOawJkTZYdd9oU0PHXoj+v5nhj2Az2Um14WeZHXrjqAkH+bQcVhEsYq4ZBrgxZ1Zd+2vPa94JfTgxY3LlZt40LFvcPwySS2xhxYzzuvAzw/LwQJ1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007153; c=relaxed/simple;
	bh=N2alj4BmRrIOvTic6YYotKnQgR6KFlCIUzkiE42YH+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCl9j0T7ge86IaexwtxF29edbTwUIcI31AGV7/gJ0hvaM8D/QaviV7hI9Mn80wc//7oDt9TJ4JXlogtK5/XocPJfVE+kIYlWUyeQ6+gX2sw9D52hKoAYxoAzQs5EYcL86r0iFcATKyxjeE8N+O+d1p1pOyQRo6WFZtYBBQ36WGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KGx2XdLK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4609c9b39d0so25252431cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732007149; x=1732611949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+TcJ6YrE5I28mqgFyB+jLz4liPKaJparkuuvli/dXqk=;
        b=KGx2XdLKviDXUVQA5WQot2vt4Jy6M09CdydVulgETgAzdtCbTSLQFpYLOYNHABH6uS
         j37b5v5OULKzRGMOX5iGdAXoqRkStZIziy0Nd9w4lqgM7Z1KfiQs55TGaHK01Sg5MFT0
         39PVjtr14US5XUFwwzRetxXi/g6BGQS/i5Cbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732007149; x=1732611949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TcJ6YrE5I28mqgFyB+jLz4liPKaJparkuuvli/dXqk=;
        b=T2sy9B1lh7jzD2Xqu7G1N0jt2LX4vAHZOoBKHHQAeB3anj6HOf2+5iXzt/JtlfHP8H
         gzEFoguckebivM7RpRD2vp3R/aHzG3hYJqPgi3S5a4aSukJ2wbipkUJXCAl1z093Qxp+
         Nl/xBp+0EcIRzZiSXXhjDWVEDkBilavMqbvQD84MY9mIZSgeR/7okmBv97zBxkOgXuPk
         yqGq/GBjA8p6l8ooHKTqmevtGecZuaPXFPZviAmu38QIUU0a6vYzhVNGSHalEky4+j0D
         /vuSZHogODALuk2yt3GkGsViiRl1KTFOlqmEIA/99iEisk+yGyzHIoRloziscnwH5+xF
         zocQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvCvf1Ns3LEZ7Mhal4Xa79rYX9kHiV7f5fh7QdR57Tm87hkdTgPOqYABqZoprMK+WkrF7Bld3EZMfHA9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIZ044tcy71JVoU8VsUaZgBQoaQHK62HmOeCV6V/dHEYkwxjS3
	d96k3LDQ2fnRjcXhDM1S0l1E0L0OZjnGxNo9SlXoch1aGuNJiuqGRNg2KW6rbcShqAgTx1NqtXA
	hCh2NTGujvopIpy3rBjcKFIFIhi0zR1bHxl3hCg==
X-Google-Smtp-Source: AGHT+IEMAq5emnll1nkE8jbEYFWUcdvqCUSQWuUzb10IHw9jaCmEC5N3mlyGo0TdfGO92TzodaMEy2DH3K9iD6UPON8=
X-Received: by 2002:ac8:5206:0:b0:463:4b88:caa7 with SMTP id
 d75a77b69052e-463773c8f21mr112410241cf.54.1732007149263; Tue, 19 Nov 2024
 01:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118141703.28510-1-kovalev@altlinux.org> <CAOQ4uxjxXHX4j=4PbUFrgDoDYEZ1jkjD1EAFNxf1at44t--gHg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjxXHX4j=4PbUFrgDoDYEZ1jkjD1EAFNxf1at44t--gHg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Nov 2024 10:05:37 +0100
Message-ID: <CAJfpegvx-oS9XGuwpJx=Xe28_jzWx5eRo1y900_ZzWY+=gGzUg@mail.gmail.com>
Subject: Re: [PATCH] ovl: Add check for missing lookup operation on inode
To: Amir Goldstein <amir73il@gmail.com>
Cc: Vasiliy Kovalev <kovalev@altlinux.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 19:54, Amir Goldstein <amir73il@gmail.com> wrote:

> Can you analyse what went wrong with the reproducer?
> How did we get to a state where lowerstack of parent
> has a dentry which is !d_can_lookup?

Theoretically we could still get a an S_ISDIR inode, because
ovl_get_inode() doesn't look at the is_dir value that lookup found.
I.e. lookup thinks it found a non-dir, but iget will create a dir
because of the backing inode's type.

AFAICS this can only happen if i_op->lookup is not set on S_ISDIR for
the backing inode, which shouldn't happen on normal filesystems.
Reproducer seems to use bfs, which *should* be normal, and bfs_iget
certainly doesn't do anything weird in that case, so I still don't
understand what is happening.

In any case something like the following should filter out such weirdness:

 bool ovl_dentry_weird(struct dentry *dentry)
 {
+       if (!d_can_lookup(dentry) && !d_is_file(dentry) &&
!d_is_symlink(dentry))
+               return true;
+
        return dentry->d_flags & (DCACHE_NEED_AUTOMOUNT |

Thanks,
Miklos

