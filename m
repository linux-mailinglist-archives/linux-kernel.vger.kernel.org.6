Return-Path: <linux-kernel+bounces-571976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2759A6C4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E614626AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF32230BF0;
	Fri, 21 Mar 2025 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0DR3139"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD41E9B34
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591795; cv=none; b=ogqxxc5UBb03gyEDPLp7CUnG/sc05feWjpmVR3hjvOZcRHFdNvomsRRKHKQq+cF0X/oxycp2BSCbwKgVyZFgjc2Q8l9mmAHArtYxSRm7rO7wO8sT9T/6W3wOnTyPQhLDdM+Q/35fMavKemctKqtFv06g1c1GIXRtTJeCEnP4w9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591795; c=relaxed/simple;
	bh=wJ3PcZFovR2+HuKsYgLMftJrP+jth1sq8pBzOIgwhgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/NtKshZNqCZb0+CCM1dGkWuOpDiD+Rbzk293DQG2UmpDzG53DvwBv6/dc3OXKwIQm3Xg87c9qrnyDysRCjN5w3Zld+qsRJTue2JxqgyyF4Nz24LGTGeoK/LCbE4/oD0435EGm8GOUxvmsQcTglg2l9vFoUeIHgrU/bqz6+h0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0DR3139; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523de5611a3so1146422e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742591793; x=1743196593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrB+UnqLolCzuT8djao+tEQdgGyNcCnhT8UNOjKQIkw=;
        b=k0DR3139s/c1ndO9Np9wwvnjffAnHVgGGX0YC4Nk1minyJFlu+b9jsGiWi8q/nFTpZ
         6FjTtWScrs8/YsLckGmYJimIbiO3EeiTcLAeZVK2Rpj/2CcFPfWlTJ7pRp2yWNnCjh6l
         1j+uPDu/zIiXLpQgXiuPLNfOJePkcvZm6pk9Aq1OvIfXfbHxQTz/u7tyAqHrKy3iSsM2
         UGa6LURVXr0jHAYi6UaGyTNMWcXy8UOg/5qs10qQatASu0L/WqljvfzTBs8m47Uw2aXb
         LL7bV9E4h1NEayGR+hOX8Ch7y7eLbjllkkSngYDC4LXP9tknE9VUISrNP38nC1aIjeqT
         zU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591793; x=1743196593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KrB+UnqLolCzuT8djao+tEQdgGyNcCnhT8UNOjKQIkw=;
        b=NMQwPhNLlMr1Yu/vxuafgUo+llyolMWO8xAwJ+lyRPU687FJrtdCghIsx15fM2US9P
         +x0Gaubbjc26f6d9kvElhBb5kMlruEKI438xuRge1EUMy/LEQAT3XxUoemwD8JHjUAUN
         NJSnt5u1XAfP3/5umj4fsBfTfPsIQC2r8CbGfdnK/Qc4dtV+v5rcSSt/BSRuF3AqV5Bm
         BULVP178KHDqlfkIdLFEClmCCXNScHWZuN3h4a3TsSNxf2+e5y/gEiCfzKGGDIg46tFy
         vQ/ja7vkmaaQC4VQ646xWBJd5dQdOvzM8zMuq4WyAmRzanHQu8nYlkdD3MPXQHBmaCl6
         q2tQ==
X-Gm-Message-State: AOJu0Yx5ks27mqWS0tDrXmy6EaENf+N7M5sNHqAR1YkgbwoKh7aLCXyD
	+uYM+HywRqba1XhKFkGGACnqv4rdkTZi79kH+zwmCsqakjtoarssYW6gnichNVSOGQR/0Y/xPSs
	nsyRh/4ZNaz1+a5MGewf560+5f8s=
X-Gm-Gg: ASbGncs+p9jQcaDGcfpikQ0NPkKgoPXnbiylxbq/9DxDp/0y5fjLLQMVLMtQ6+C4SdN
	X66lA8J62djWPfaHYmgcepGUSXm+nY/MDL9u6RjdS/qReO6anGmxZoMHmnZQtwpbpn2+PXA8q+J
	yZWbfGAqVOV5gELprMp0XUaAkHh5wbS+MG2YFoA5+FcXkpFtagM4ghaoeZX40=
X-Google-Smtp-Source: AGHT+IHvsFdkFEAa9eO0IQCA1HOgDBxu4qKbvZx/tf6NJrTq009BFqrlAQC5xjZ+LuQRbFwwo+1TP7Nb3OLCG5AzT4E=
X-Received: by 2002:a05:6122:1989:b0:520:5a87:66fa with SMTP id
 71dfb90a1353d-525a834239cmr4956406e0c.3.1742591792546; Fri, 21 Mar 2025
 14:16:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317190809.678626-1-daeho43@gmail.com> <ea3988c6-7708-4da9-8009-85708a27275b@kernel.org>
In-Reply-To: <ea3988c6-7708-4da9-8009-85708a27275b@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 21 Mar 2025 14:16:21 -0700
X-Gm-Features: AQ5f1Jr6GrdhGsN2xcP0b4Yh2BAHbCIC2Xw4WIdrgQR3tTNnjyKGXUpV2KwDBGA
Message-ID: <CACOAw_yhfZtmVkmuN0jNVxiEkcEdpmQrSZPiK2CTY6mjjcrUKw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: support zero sized file truncate for
 device aliasing files
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 8:45=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 3/18/25 03:08, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > support a file truncation to zero size for device aliasing files.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/file.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index f92a9fba9991..7ae5a5af5ed9 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1036,7 +1036,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct =
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
> > @@ -1117,6 +1117,9 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct =
dentry *dentry,
> >               if (err)
> >                       return err;
>
> Daeho,
>
> If truncate(, 0) failed due to some reasons, maybe, the file was partiall=
y
> truncated, should we tag it as inconsistent status to avoid its later acc=
ess?
> thoughts?

Hmm, looks like I did it wrong.
Instead of invoking f2fs_destroy_extent_tree(), I need to make the
length of the extent to zero when truncating the file.
Is it okay with you?

>
> Thanks,
>
> >
> > +             if (IS_DEVICE_ALIASING(inode))
> > +                     f2fs_destroy_extent_tree(inode);
> > +
> >               spin_lock(&fi->i_size_lock);
> >               inode_set_mtime_to_ts(inode, inode_set_ctime_current(inod=
e));
> >               fi->last_disk_size =3D i_size_read(inode);
>

