Return-Path: <linux-kernel+bounces-521930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401AEA3C408
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 342997A948D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13D212FB8;
	Wed, 19 Feb 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HhPCt1z9"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F97C212D68
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979608; cv=none; b=aUGEthI5RF/t6/l8QZN4kooTjLPJOd6VY+WyHQOZeJRIQ+zWhZfmlRZHR+aI3AMX9lu3wFCfb0CW7vzawNcsYqSM+cRy8kxASHa2zAPiu/jJlxqf84EuOo1QnM4kh2fqPRVGgywcisW67B2n05JJcyTF3s0ZDHfuJz8bqmunQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979608; c=relaxed/simple;
	bh=buTHsj2oaFq5Wqga1EBuGagDv+saNvOZR/UVtfuyT4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KetDOefBJ9jP0Ci/PUDvGpNXZ1+jgVEV3fN29+VVo5ZgJSeoHcMNrzg2gDuPi4cBaqvgZRFPN1v7AnlQkT+9X+hz/5NXCjvaOci/LlqcH56HHBqBbeozyLYbd+Z/G96KYb7g3XbQxHxokG1iMEL3ToobOVOeNzeVqM6KHO6pXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HhPCt1z9; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-472003f8c47so8875801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739979604; x=1740584404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=92iIBWqK77Z7RcDzOrfe8c0bA9AELD7+jjJwAT/7JP0=;
        b=HhPCt1z96x0HkTwLe/IKTSeyx0/SOX03j11AitZXAifIeLfRbKtaTUf4FVqm0A9QW4
         aahVvQ2Wgrqs7Fga8Vic/BcH7HZ1nbhh1y4e/yKNBPmz7GkvT54cAyU+n5Tead6a7Coa
         vfI831sXwnkxlpZDxsDC2wtHQjHp2Up3fyxfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979604; x=1740584404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92iIBWqK77Z7RcDzOrfe8c0bA9AELD7+jjJwAT/7JP0=;
        b=DrMyOrT32nCvi6sCvlPhE7mbPBwCcOOl3iIRHsnJNbPNSue/fnKdqP8JZnTm0kbfvm
         eZAXV8mSEIHmx5Q0Vgl/M2WLc4BBcTfMGfGYCrKOpB34wSGkEQLVi72lGfSo9XwdnRQY
         RrT92ZQCPMiQNNRdkv6pONsAJb1F8vts6//Ty/pD0r8ZXlKcepPt4Z9OqP1n8Uv8mgjN
         qBw04ZWkTHVgino69GzosCzWENW69SWkOAbxfRBGcJY/j/q9H/hf1Gbej2noWp1HkJuU
         ZMW1e8Q2QeFQOGJUB9D3H0iLl3TW9AHBrnjKH5iuPyndPoRlL4/eJaiH9/CFSiVray9n
         2DKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHzvbP2ovXiMJhT53kOSzMrd+vLgTn5+0kyIG9BEu1E74zZD5Atr5ZP+4WfbfY4W+MhUidOuqQ+knaJGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSWiRU4ZlzSrHMP1tnFR+Inqm2ugiSNL2UmD632C+K7AfCYc2I
	RoNi7SndldQSbdoIRoj7GSRMxbJIBkY74Eu+AfadoMbPtFDTk55SnxgiZjzQt3purhgIu+q7PBv
	6I/wN2pk/SLAaF5miZXjc2+EyuawVqketZUxpCQ==
X-Gm-Gg: ASbGncvLdocKOB9O+U0gP2DRa3APOcbKDc8PU0+xPgXlETSeOO15bgGfZjJFMgj0Ou9
	oTQUcfC3zHuSWOHmO/ImZ18Oen2pNWCN2URa+noeQZw8P7TxYlAYybi62lnxEPaYokzXM6SY=
X-Google-Smtp-Source: AGHT+IFAeU/+H+SJFluznNcKJQGWZ0dI8+j7igAo72ORVv+picT+17KaUR1+ksOwgZMe+UPUb+KJUxbhqcefENa7mOM=
X-Received: by 2002:a05:622a:250e:b0:472:2bc:8763 with SMTP id
 d75a77b69052e-472081120acmr72334071cf.17.1739979604016; Wed, 19 Feb 2025
 07:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217133228.24405-1-luis@igalia.com> <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area> <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
 <87r03v8t72.fsf@igalia.com> <CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
 <87frkb8o94.fsf@igalia.com> <CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
 <87tt8r6s3e.fsf@igalia.com> <Z7UED8Gh7Uo-Yj6K@dread.disaster.area> <87eczu41r9.fsf@igalia.com>
In-Reply-To: <87eczu41r9.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 19 Feb 2025 16:39:53 +0100
X-Gm-Features: AWEUYZnsd8RmZK6RM-APkCg4E8uZetY9FeJcgcAmTH8on7mvgs9rhtwhdwChAuM
Message-ID: <CAJfpegs-_sFPnMBwEa-2OSiaNriH6ZvEnM73vNZBiwzrSWFraw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
To: Luis Henriques <luis@igalia.com>
Cc: Dave Chinner <david@fromorbit.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Valentin Volkl <valentin.volkl@cern.ch>, 
	Laura Promberger <laura.promberger@cern.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 12:23, Luis Henriques <luis@igalia.com> wrote:

> +static int fuse_notify_update_epoch(struct fuse_conn *fc)
> +{
> +       struct fuse_mount *fm;
> +       struct inode *inode;
> +
> +       inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
> +       if (!inode) || !fm)
> +               return -ENOENT;
> +
> +       iput(inode);
> +       atomic_inc(&fc->epoch);
> +       shrink_dcache_sb(fm->sb);

This is just an optimization and could be racy, kicking out valid
cache (harmlessly of course).  I'd leave it out of the first version.

There could be more than one fuse_mount instance.  Wondering if epoch
should be per-fm not per-fc...

> @@ -204,6 +204,12 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
>         int ret;
>
>         inode = d_inode_rcu(entry);
> +       if (inode) {
> +               fm = get_fuse_mount(inode);
> +               if (entry->d_time < atomic_read(&fm->fc->epoch))
> +                       goto invalid;
> +       }

Negative dentries need to be invalidated too.

> @@ -446,6 +452,12 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
>                 goto out_err;
>
>         entry = newent ? newent : entry;
> +       if (inode) {
> +               struct fuse_mount *fm = get_fuse_mount(inode);
> +               entry->d_time = atomic_read(&fm->fc->epoch);
> +       } else {
> +               entry->d_time = 0;
> +       }

Again, should do the same for positive and negative dentries.

Need to read out fc->epoch before sending the request to the server,
otherwise might get a stale dentry with an updated epoch.

This also needs to be done in fuse_create_open(), create_new_entry()
and fuse_direntplus_link().

Thanks,
Miklos

