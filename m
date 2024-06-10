Return-Path: <linux-kernel+bounces-208427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E090250B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C87F281573
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274813DB92;
	Mon, 10 Jun 2024 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDyhZWhS"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E013959A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032258; cv=none; b=ZVM1oW6+q5CaFmpZbfxY0c61S7O3G+Tux5ZhzfvNFaei247anX4FCLkVQtcDRYQ0gk2gdLqWqdgwuKnRpiC813A+R9auQVdAvCSguMEdjXuO4lQnBO/R+q+ctfg163MaNi7ZYvaJZGP2hIR6dOKKMAA2brzj/ut4LZXFolQ8DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032258; c=relaxed/simple;
	bh=ERuOVVdn5GsO46O7DDRbGcmv/ifApz+1KsqrXPoPF7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVSLSuivCWNM0TBeKcMe3FOsEy9ElcC5dDtKKaayG6cg5DLh5M5RqO80VQDcrPKIKSYVMsUCVzYpQRB8fctaKhrxU6Jmfi2mTX6qVNn0AS9Xm0EKGAvIK8t3H+VifGJVm6u0klRACerMjBRdV1Jh/6ac2iPdMEc4ybLl6ZRDzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDyhZWhS; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-804ee8b03afso1300359241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718032255; x=1718637055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cycnwNbB2QbkiUYzy7U9ut8XvQ6A+eLFN2UjpJnGLXE=;
        b=CDyhZWhSg8kFmnHloRpT/QLPvZk93+jwTKxDYE787mn05m0VSws0DoS3cLyUgop45Y
         PscYumdM7geKthqIUmDpD8/6mpD90nUtYT0ZB0Vbj/tamXA10V8/8PPKrrk8IWZx+9QU
         v6ejSq4TVSPxvYir/SoUfEXnSLYIZMNoQjLKhnUmss97fnPnUSACgHGkq7J9KEkNlKTP
         tnfXyO1jNftig4+ql3QaUK+qhHTice41ZsrLm/PmBHxPL8ZuQRXJeP6tcajTOQZuO96i
         z1AzGsIFUe4PwlYJr8cu88umqgXKSMV6uj8FUbJaBFWZZi5hukdqjdrhVAiSwmbDlFrw
         IWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718032255; x=1718637055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cycnwNbB2QbkiUYzy7U9ut8XvQ6A+eLFN2UjpJnGLXE=;
        b=e456t3GPpPVXZry+ashS7PBy6cB8iTcbASMWMO6axs9DEmzMRdg4Ema0hC9SI/C/YX
         IcOkAR29ViO4CmiVnPc3TfXmSuS8+AeGsq9rS9Hbnxi0oR7FKZsnk+qouHLrvwswhSFd
         mOh4TZmfncQ750kw/gyrE80jE+xyxuNkUf6NhLALIk4tPvtwsP68ibCFSLBxRjG8j4MH
         HrtmUEeGugx+d7iLY+G6ntKgK7gIuNs08QLNJtjtbKzsngJYP14r7rKkmSIVyz/uFeZl
         ambX1idJ1YjrN1Tg1GxZsSlng4W+P3VcyHvmLweXdkcSWqsWLcoovFv2rHcrMagx1Geq
         ArzA==
X-Forwarded-Encrypted: i=1; AJvYcCX8D7iv7CYu9eDwt73StMuVE1l2Yv20n40Ri52vLgtmRxzB8zDRbCmZy1R3+NyWm4Cvz1sxJjm5ufJCrkn0qYF1Yzu335OeSwJlGv5d
X-Gm-Message-State: AOJu0YyOkAXAg8fv+vRFK1lbgFSmAla9q0l4cHIAV9oNHGU0Ts5UYJ7Y
	vS+qzHTFmrIwoW5//6lNmru5BNXuxOPBiizHSlS3xvsbXO2jX7OKssZeM+c7ILlOder1EOszDlC
	wwT+2CU7Txk4+AKCwflbq8etVGmCGns+q
X-Google-Smtp-Source: AGHT+IE1bBht3Q/RKtsJwKtDwwtiDOLpGrE5Ye4Ip0oqyDxrr1J0UcUl9iVD/cn4DnAfDoA5lFDmV46W8zkQB61nLSE=
X-Received: by 2002:a05:6122:298a:b0:4df:4498:cc with SMTP id
 71dfb90a1353d-4eb562325d3mr10040880e0c.6.1718032254029; Mon, 10 Jun 2024
 08:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606095213.4087668-1-chao@kernel.org> <d38a2712-f7cc-4aea-a343-00335a5215a0@kernel.org>
In-Reply-To: <d38a2712-f7cc-4aea-a343-00335a5215a0@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 10 Jun 2024 08:10:41 -0700
Message-ID: <CACOAw_x3s2m70-cBhA0X0h5AetCQgDzVh7hRM00OVm=0Od5FUA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to add missing sb_{start,
 end}_intwrite() for ckpt thread
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 5:36=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/6/6 17:52, Chao Yu wrote:
> > After commit 261eeb9c1585 ("f2fs: introduce checkpoint_merge mount
> > option"), checkpoint can be triggered in background thread, it missed
> > to cover f2fs inner checkpoint operation w/ sb_{start,end}_intwrite(),
> > fix it.
>
> It needs to use sb_start_intwrite_trylock(), otherwise, it will cause
> deadlock as below:
>
> - freeze_super
>   - sb_wait_write(SB_FREEZE_WRITE)
>   - sb_wait_write(SB_FREEZE_PAGEFAULT)
>   - sb_wait_write(SB_FREEZE_FS)
>                                         - sync
>                                          - iterate_supers
>                                           - super_lock_shared
>                                            - down_read(&sb->s_umount)
>                                            - sync_fs_one_sb
>                                             - f2fs_sync_fs
>                                              - f2fs_issue_checkpoint
>                                               - wait_for_completion
>                                                                         -=
 issue_checkpoint_thread
>                                                                          =
- sb_start_intwrite(sbi->sb);
>
> - thaw_super
>   - super_lock_excl
>    - down_write(&sb->s_umount)
>
> Thanks,
>
> >
> > Fixes: 261eeb9c1585 ("f2fs: introduce checkpoint_merge mount option")
> > Cc: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >   fs/f2fs/checkpoint.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 55d444bec5c0..66eaad591b60 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1828,8 +1828,11 @@ static int issue_checkpoint_thread(void *data)
> >       if (kthread_should_stop())
> >               return 0;
> >
> > -     if (!llist_empty(&cprc->issue_list))
> > +     if (!llist_empty(&cprc->issue_list)) {
> > +             sb_start_intwrite(sbi->sb);
> >               __checkpoint_and_complete_reqs(sbi);
> > +             sb_end_intwrite(sbi->sb);
> > +     }
> >
> >       wait_event_interruptible(*q,
> >               kthread_should_stop() || !llist_empty(&cprc->issue_list))=
;
>
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks.



> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

