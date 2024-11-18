Return-Path: <linux-kernel+bounces-412715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D89D0EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D6EB25AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622715B0F2;
	Mon, 18 Nov 2024 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ng/vFZMb"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A991194C62
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924905; cv=none; b=GM8eKvtKj4RINMWsJIWoKtKI6dRo9cwMKOS6BxfaW83IvUI0Di/5Xv3Otze+6bkxPuCRxhyVTzkRZ0kgeNCwywFHbSH8bqIfnO5OYa5B+aIVRUGCnIdA/Gd8+C4yF6xoX0um/fxb6LiZT5Tb4BcVZpx0LHnZPn8l8o3X8gI6MCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924905; c=relaxed/simple;
	bh=VgZc9WgLY4GTSHitRZlL1UjHtqbjSNb9UuqP6p6n02M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKdablMW3pd9wAHBGkR6aUJwEB0xAagvuo/zIHy2pqOr2LP5l3Ggs3XbEmRd8bRcGViH1GTW9mOuu1mhGss/trwxoCYFWvfbcF86m1bjPwqhC3AI5vEpSxbei9slxFTs3gaPRFFaF58EnEuEYtLGH2oQH0/Q2YJDxlDnISlxzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ng/vFZMb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea527ae14aso762294a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1731924902; x=1732529702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NIDiweyvQXVWlSs4nNHBLpApFjUOt/gpJgjwpqppQ+0=;
        b=Ng/vFZMbYGpxPZ/bbLC2PvReu70X8ayp4pZFs+YpwS54XvS2iT4StEckmOPp1YUTgg
         w84StBDhro1ElsxThKOYXTagM+AZ60N3qLrj6i1fLWmlH34et7TBNVDBzS5IQX8zUYCT
         Q+ThTaBAa8dR9vjxIBPIVQMcH09t0YXgyyelqC7GoQ5E/aKkWB/xudUc4TOOWjEIgiby
         NudJfPOtztaSYDfUPjPMKa71qZEnDcm9xmuD6oof4Td0pogYbCvo7G+L50LfmaJkx3yv
         KSohDmHkd//Th08UFWmDH6SkWuke0suwtObGTX/ZmVz0psCx1I47fOwGnHHnxUZtcxUW
         12VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731924902; x=1732529702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIDiweyvQXVWlSs4nNHBLpApFjUOt/gpJgjwpqppQ+0=;
        b=vgxEPC7weNR0cf0uNvMHQH2oGJeSYnMYKJ/NZZX0+a5ALFGJIz43Bl3zlaEe0U65me
         5fTsxEJAVT1bmNq2Kbwog2yAEpaH0pwtxWjzMOEHXOhyJzi+ySKJuPCOaWj+LlJuNTmo
         X0VnWDmf3ejL7aiZjMVtQdCLdiAK6WWXTWCZNY+TeTOwyWSeE6IGG9pRkm1lseHcyWyp
         tLKMONBCiGOuKACwRKQbGsjplCoazgzy8o72sHpsLmm8l27+fIWnRgQXBhD95sAvaZM9
         WTns0wXooW0sMBcW8+C9agfNpL0lJQg4fShlbVCtPAewoZ5aejIEIExrFnxxQWbfDQ3C
         NT2g==
X-Forwarded-Encrypted: i=1; AJvYcCV3po1rmyFDdbpboORBPAGW1p7xAdoTlWxfJVsFxqe918SbDSXucM6zPXeYCAuLseJX1YvFXLX2igTnPX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxxjM0pcZR7gbg+gAHdq3WDKxviqhfUeEaXEmq1zBx/lQSDt9n
	PulQqgCuTUutlB602MPyB5PpQ+zTrp8lwx4OkcYcsq+2D4Cuhel4ATGxFYYc0RBdhLLRRGxBLdw
	T4zzb9df1dG5MpeWE8kWNs0+E+nzucVCEJc7ChA==
X-Google-Smtp-Source: AGHT+IE03Dnz9IB1V2vd8Tz4seKW9DCt/IH1Y3NNeUkESMcxjmV3Zu6mC9baHdt6E8R0wKk0SDO4HWaQ8R8wKE+nNO4=
X-Received: by 2002:a17:90a:c10f:b0:2ea:5dea:eb0a with SMTP id
 98e67ed59e1d1-2ea5deaf3cdmr5192834a91.4.1731924902534; Mon, 18 Nov 2024
 02:15:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114070905.48901-1-zhangtianci.1997@bytedance.com> <CAJfpegsF9iYG04YkA0AOKvsrg0hua3JGw=Phq=qeOurgqk_OuA@mail.gmail.com>
In-Reply-To: <CAJfpegsF9iYG04YkA0AOKvsrg0hua3JGw=Phq=qeOurgqk_OuA@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Mon, 18 Nov 2024 18:14:51 +0800
Message-ID: <CAP4dvseQoAohAZniZysw+gR=EGjMrKyyAOQ69-1FD7BOKS4VOQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: check attributes staleness on fuse_iget()
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi Miklos,

Thanks for your incremental patch, I test it and find one little problem:

> @@ -207,7 +214,8 @@ static ino_t fuse_squash_ino(u64 ino64)
>
>  void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>                                    struct fuse_statx *sx,
> -                                  u64 attr_valid, u32 cache_mask)
> +                                  u64 attr_valid, u32 cache_mask,
> +                                  u64 evict_ctr)
>  {
>         struct fuse_conn *fc = get_fuse_conn(inode);
>         struct fuse_inode *fi = get_fuse_inode(inode);
> @@ -216,8 +224,20 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>
>         fi->attr_version = atomic64_inc_return(&fc->attr_version);

Here we initialize fi->attr_version.

>         fi->i_time = attr_valid;
> -       /* Clear basic stats from invalid mask */
> -       set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);
> +
> +       /*
> +        * Clear basic stats from invalid mask.
> +        *
> +        * Don't do this if this is coming from a fuse_iget() call and there
> +        * might have been a racing evict which would've invalidated the result
> +        * if the attr_version would've been preserved.
> +        *
> +        * !evict_ctr -> this is create
> +        * fi->attr_version != 0 -> this is not a new inode
> +        * evict_ctr == fuse_get_evict_ctr() -> no evicts while during request
> +        */
> +       if (!evict_ctr || fi->attr_version || evict_ctr == fuse_get_evict_ctr(fc))
> +               set_mask_bits(&fi->inval_mask, STATX_BASIC_STATS, 0);

This check should be moved to before the initialization of fi->attr_version.

>
>         inode->i_ino     = fuse_squash_ino(attr->ino);
>         inode->i_mode    = (inode->i_mode & S_IFMT) | (attr->mode & 07777);

And I will send out the v2 patch later.

Thanks,
Tianci

