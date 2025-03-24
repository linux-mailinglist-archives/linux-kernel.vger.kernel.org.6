Return-Path: <linux-kernel+bounces-574074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB5FA6E04E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E423ABC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAFD263F40;
	Mon, 24 Mar 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqVAM1mq"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252233C5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835404; cv=none; b=TjnGBWPKvmhMMifFHcr2vQToijqOoyTCEhadCGhogYeIXQEx6Sw4W3soqLPGaGR8LusyFO19MFrXMKb51/Xu6XiGv1TH/H95kj5ORmMeVlR95PEkoNIaXsbS5QYOlIp5fV8NXicTd4NqD9kX8zOPxlZ1lAsSnVDUqz8OMTtr0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835404; c=relaxed/simple;
	bh=KKguH9yZvEIeLSK3WuQqBmLIdnREe3R8haHd5zcqAdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIhv66tTRCHFn/jk8Z/xQbGCUx4gABAEBnENg2lw/l6JXd1axsIeHXZfxkEt7QgYzcpkl29Z8JzHI2pGUT1HaVK2sbg2q/otrPR6vm1l5BfcrKVT7JV06P12y1kUAS04vOdAzWSJydB0inK2yH4G8nAS2dxU3N8uzwYDXwu0g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqVAM1mq; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51eb18130f9so2398702e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742835402; x=1743440202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+R4Zgv1+YUQI5Stto4fUNNKCwwq4ux5aT/NqJLsqnU=;
        b=SqVAM1mqO64hGSAF2q1KR6zBhFPlnBCoW0DiD475IHrqREeWviXqNBTynlN8Y0qyEU
         q3J2anY3luv7ruAs6gxcLjKh94OThKM24xiczIHjliC749cWxZRhWUC8Iofbjn+ySxWI
         VS7KJaojMXrxHdu2XKv6YqTVR6g23Z0gXFKcLpJZ7mf9onehIGpT3VK2qsZ0n5lId+KV
         uWbUI4rCZ1K2wfxP539reKhDNlyPTQA0S3Jb4Ex6wUq2Yw1Ee9/Xdc7LOX8KCkdlVU5+
         lrB+0/ZDxljrmI/pgatVm+j1EzlRGPYzGga+2vOii2CcF/vcrPJXIxKccVwf/xdkoPud
         NNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742835402; x=1743440202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+R4Zgv1+YUQI5Stto4fUNNKCwwq4ux5aT/NqJLsqnU=;
        b=EuFBSyrtaEhhIaHEQaQDu0BG70ZaD0/wqG7XNFbWbDeooUaqacWLDCfqYYSvxQTqv7
         XaYEHV1eZfL8Rnjhdtb+Waq78R+i9UmxImi9wgTwLJ9H7uODHYOT3ohobwM4mz1qi3qk
         pcSTi3Qlw/ap0SuV0YEVsEuUsvCPDE1KJb/6HjYHazlFgzfcyO8iXJ+5xvNtySoxR3TF
         kIo+F2skM6mhcpoTVLjGG4ilsx/Prdr1UIS/QLDxOTRkiCb411qsGtUOioiMu3d5HBHz
         hZWA8mHFNSmncbQ78UO1cbUvxppcpNwsyNfxY58+nO7QNJ4yiZTQWfBoIfIoU9PFKqE1
         0TAA==
X-Gm-Message-State: AOJu0Yzr0pOziVKMYcAr6PSL9nrJ3DxUlG70PcXDXV4mszc7BXAacJj2
	TDyoFXONrgsb2pk5wic8M+xIKa8Ovfs8LhEUAUIwGAuvFNYhuFljLGawDoYS7KBzddX8eQoJmT2
	XWYIsQjK/CB8BMgGoYdrOKF6E4rs=
X-Gm-Gg: ASbGnctk7qo+lIfbRQIf/nIhM2/8S3A5tOj0Zhbu/PxAahS1hhUVZ2zvd7O7O8KvPY6
	giIi5o+fx3CpfwZrpK5/LZLMf8HSIvfXtrkuyf6/Vt0g3IyfDxV2zxVRFLWm2X0iiWgirZ7y6gT
	75Cmulq4iyCZV0gSK7VxxMHmq4BYWrHszvp1XUEoHsWgPF3YqGTd7oodBZK2k=
X-Google-Smtp-Source: AGHT+IHsfFOp+DbRVW4PSnT8CVdboozFUZfZK2d4+gQt+Qgg1TwPugvPDiyIJpiqBHf6v0VU2bp4D6qEvu0sikK9AzA=
X-Received: by 2002:a05:6102:3908:b0:4c4:e21f:6481 with SMTP id
 ada2fe7eead31-4c50d47bbbbmr8736879137.4.1742835401559; Mon, 24 Mar 2025
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321213328.1170234-1-daeho43@gmail.com> <Z-GIOxj1reO87F6E@google.com>
In-Reply-To: <Z-GIOxj1reO87F6E@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 24 Mar 2025 09:56:30 -0700
X-Gm-Features: AQ5f1JrjKx2Rv5zNO4PkTiOMHmTWHFNwr67g3LdIx9yz9VU2CLcZpMU6HZRn6GU
Message-ID: <CACOAw_wLBW1p0z8yNRfwX0GPUtvcoFVYVm_TbJBWe=yzVvwKsQ@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: support zero sized file truncate for device
 aliasing files
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:28=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> Do we still need this patch?

Yes, in many circumstances, we cannot remove the aliasing file because
of SELinux.

>
> On 03/21, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > support a file truncation to zero size for device aliasing files.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v2: make the extent length zero
> > ---
> >  fs/f2fs/file.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index f92a9fba9991..69952f208086 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -775,6 +775,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u=
64 from, bool lock)
> >               f2fs_update_time(sbi, REQ_TIME);
> >
> >               f2fs_put_page(ipage, 1);
> > +
> > +             write_lock(&et->lock);
> > +             et->largest.len =3D 0;
> > +             write_unlock(&et->lock);
> > +
> >               goto out;
> >       }
> >
> > @@ -1036,7 +1041,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct =
dentry *dentry,
> >
> >       if ((attr->ia_valid & ATTR_SIZE)) {
> >               if (!f2fs_is_compress_backend_ready(inode) ||
> > -                             IS_DEVICE_ALIASING(inode))
> > +                             (IS_DEVICE_ALIASING(inode) && attr->ia_si=
ze))
> >                       return -EOPNOTSUPP;
> >               if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
> >                       !IS_ALIGNED(attr->ia_size,
> > --
> > 2.49.0.395.g12beb8f557-goog
> >

