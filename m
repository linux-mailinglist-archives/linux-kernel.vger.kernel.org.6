Return-Path: <linux-kernel+bounces-342798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6498F989315
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873401C22E07
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFA4084D;
	Sun, 29 Sep 2024 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpebcOGx"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581FAD51;
	Sun, 29 Sep 2024 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727585842; cv=none; b=Aq/FB3POT+8RG4nL2soa6CKL8Ob1uhlslYgnA6KsgAPeI7jFfFQJJ+cmY6GWpJ6DKE70yCWTQD13txKJKW6wh/GC/5Qr/xT1+xJPLwt1Te/+phM3jPlsyHhqzpMwthRpBBk0azfjh7bz942gbu+wga59RmVc2RVJOEyJMQcpGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727585842; c=relaxed/simple;
	bh=iVKKF0BjXUG7u227051PhJZgzxqc+pmCNvnbtWbrm8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOidQBOXOhBZ+/7i8GxjRQppVoK0i0qhQxNpKtWsMD7emmCU2oprw8JY3+sZ0JTbBgCTV3v5ICkJZjp/11TzGpyHhvRAjGqD5dvmLHGET4s2DSP/3VGadqdoBNIUCTtXFpnMItSpgaPEcX3uMlRgv2UNIMo50+mWzWuf5cBQ+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpebcOGx; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53993c115cfso131224e87.2;
        Sat, 28 Sep 2024 21:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727585839; x=1728190639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6OHpzljVpojRQhUWTJ7tAWWTeoQNF/dvwIOpqQRPLs=;
        b=CpebcOGxmpaAmnLS6Y75pK1yZdjBhjGKQaOJJUcQuetO7pM5g+HMpyZ4NCAZF/0Jva
         G+dNAKyOW15pStGNtWpo6cVhwz9oy71qF0UaJBuiSNvXCnM0ysFNGF2n+7JxbC9Gh9Df
         hzj/Fztumt1FhTpMvC7yHUkIRD/Oit0SSQQdwGTjJBx2w4d3caJiezrX4+52C+dQLzce
         7KE3H9rr9ooNd72+8mb/1InezsOf1AB5BsoTcrG2I6lCbZxCwpZPV2Nna0RwKvsW9r4w
         TqhtOorECR8VS9WtPUaaAS0ErqdM1PRP+UYmLe+ufQ8vg1KJ4IbxSnMTMkNOS1K8Vvjb
         TcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727585839; x=1728190639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6OHpzljVpojRQhUWTJ7tAWWTeoQNF/dvwIOpqQRPLs=;
        b=rbvi7ciofql+40GDGpUUbrBZ8KjS/4cIwGbeyFMy/svoYMAXHJR0UBug3kmnMOPhYY
         zm/ylcU1rCwookk+rG08ytPOwW/Z4yrHrHeOmHF2/RdbaYVJGzA/gxeqPk0JkU4NkNZT
         ZBSR8w/RF0tNgQZInxceIzBUh0+m7toglHMRWqzTYm5vWFAyTk/SF6WvQda/vJ1tgnSL
         2aXVUgeSkArRFY+hMAEiiYXzJYC9g6prSwT21fukg1XlZZPnbjsXi6haNEqYrD/Y/A0e
         b5c+SUv9K6vMEy4bNV5pxxNllqIIJDRpE7D6wbnogcrgvuG7UqvxUyVsidEd2rcFcNbC
         dxdg==
X-Forwarded-Encrypted: i=1; AJvYcCVIGapbw7On92lMKyaX/NHrDrPdVFsmxkvVP1cGOUUhMAZYMg5FhditeF6wV2OxxITtDWQWSES1fhYz@vger.kernel.org, AJvYcCX3al9wd2vmISOyi4AUMpMRFVmwkXj9xXLfzusqeUbm9alB28hKxzOrS6N8f1K9IKvLnDE5HzyXtku7DFv2@vger.kernel.org
X-Gm-Message-State: AOJu0YyBtyq/ExYwDYX9dnfJIHIVtEtWPZEsV22dlBHQmVZ1DddSmhxK
	2w4LdTLF8ngZejl5mk0z7aVUtxgUihq5NOOhmIXxtIc3L/40iKqp0T+kM0RIkKbJ2DP8AcVjheZ
	7pjNBnZOR/v2IQ2YIx0wbsowPnZk=
X-Google-Smtp-Source: AGHT+IGEotrBaxlUcfXSPE0uWyVEm7deJNlk13phztuSnc+XFcV8m/n4fBrVnPemU3YiIadeyxbidLXkI08AsZOZp7Y=
X-Received: by 2002:a05:6512:3a89:b0:536:550e:7804 with SMTP id
 2adb3069b0e04-5389fc3afbcmr3703315e87.18.1727585838280; Sat, 28 Sep 2024
 21:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928215948.4494-1-pali@kernel.org> <20240928215948.4494-9-pali@kernel.org>
In-Reply-To: <20240928215948.4494-9-pali@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Sat, 28 Sep 2024 23:57:06 -0500
Message-ID: <CAH2r5mvqrWHX6n58eXGL0EgVuhKBD-aZbgrF1DBG9evdXNNaCg@mail.gmail.com>
Subject: Re: [PATCH 8/8] cifs: Rename posix to nfs in parse_reparse_posix()
 and reparse_posix_data
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

since they are being used by default for servers supporting special
files in the "SMB3.1.1 POSIX Extensions" ... it might be appropriate
to keep a less confusing name ("NFS" for "SMB3.1.1 POSIX" could be
confusing)

On Sat, Sep 28, 2024 at 5:01=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> This function parses NFS-style reparse points, which are used only by
> Windows NFS server since Windows Server 2012 version. This style of speci=
al
> files is not understood by Microsoft POSIX / Interix / SFU / SUA subsyste=
ms.
>
> So make it clear that parse_reparse_posix() function and reparse_posix_da=
ta
> structure are not POSIX general, but rather NFS specific.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  fs/smb/client/cifsglob.h |  2 +-
>  fs/smb/client/cifspdu.h  |  2 +-
>  fs/smb/client/reparse.c  | 14 +++++++-------
>  fs/smb/client/reparse.h  |  2 +-
>  fs/smb/common/smb2pdu.h  |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 9eae8649f90c..119537e98f77 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -223,7 +223,7 @@ struct cifs_open_info_data {
>                 __u32 tag;
>                 union {
>                         struct reparse_data_buffer *buf;
> -                       struct reparse_posix_data *posix;
> +                       struct reparse_nfs_data *nfs;
>                 };
>         } reparse;
>         struct {
> diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
> index c3b6263060b0..fefd7e5eb170 100644
> --- a/fs/smb/client/cifspdu.h
> +++ b/fs/smb/client/cifspdu.h
> @@ -1506,7 +1506,7 @@ struct reparse_symlink_data {
>  #define NFS_SPECFILE_BLK       0x00000000004B4C42
>  #define NFS_SPECFILE_FIFO      0x000000004F464946
>  #define NFS_SPECFILE_SOCK      0x000000004B434F53
> -struct reparse_posix_data {
> +struct reparse_nfs_data {
>         __le32  ReparseTag;
>         __le16  ReparseDataLength;
>         __u16   Reserved;
> diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
> index 35e8f2e18530..a23ea2f78c09 100644
> --- a/fs/smb/client/reparse.c
> +++ b/fs/smb/client/reparse.c
> @@ -81,7 +81,7 @@ int smb2_create_reparse_symlink(const unsigned int xid,=
 struct inode *inode,
>         return rc;
>  }
>
> -static int nfs_set_reparse_buf(struct reparse_posix_data *buf,
> +static int nfs_set_reparse_buf(struct reparse_nfs_data *buf,
>                                mode_t mode, dev_t dev,
>                                struct kvec *iov)
>  {
> @@ -120,20 +120,20 @@ static int mknod_nfs(unsigned int xid, struct inode=
 *inode,
>                      const char *full_path, umode_t mode, dev_t dev)
>  {
>         struct cifs_open_info_data data;
> -       struct reparse_posix_data *p;
> +       struct reparse_nfs_data *p;
>         struct inode *new;
>         struct kvec iov;
>         __u8 buf[sizeof(*p) + sizeof(__le64)];
>         int rc;
>
> -       p =3D (struct reparse_posix_data *)buf;
> +       p =3D (struct reparse_nfs_data *)buf;
>         rc =3D nfs_set_reparse_buf(p, mode, dev, &iov);
>         if (rc)
>                 return rc;
>
>         data =3D (struct cifs_open_info_data) {
>                 .reparse_point =3D true,
> -               .reparse =3D { .tag =3D IO_REPARSE_TAG_NFS, .posix =3D p,=
 },
> +               .reparse =3D { .tag =3D IO_REPARSE_TAG_NFS, .nfs =3D p, }=
,
>         };
>
>         new =3D smb2_get_reparse_inode(&data, inode->i_sb, xid,
> @@ -313,7 +313,7 @@ int smb2_mknod_reparse(unsigned int xid, struct inode=
 *inode,
>  }
>
>  /* See MS-FSCC 2.1.2.6 for the 'NFS' style reparse tags */
> -static int parse_reparse_posix(struct reparse_posix_data *buf,
> +static int parse_reparse_nfs(struct reparse_nfs_data *buf,
>                                struct cifs_sb_info *cifs_sb,
>                                struct cifs_open_info_data *data)
>  {
> @@ -414,7 +414,7 @@ int parse_reparse_point(struct reparse_data_buffer *b=
uf,
>         /* See MS-FSCC 2.1.2 */
>         switch (le32_to_cpu(buf->ReparseTag)) {
>         case IO_REPARSE_TAG_NFS:
> -               return parse_reparse_posix((struct reparse_posix_data *)b=
uf,
> +               return parse_reparse_nfs((struct reparse_nfs_data *)buf,
>                                            cifs_sb, data);
>         case IO_REPARSE_TAG_SYMLINK:
>                 return parse_reparse_symlink(
> @@ -507,7 +507,7 @@ bool cifs_reparse_point_to_fattr(struct cifs_sb_info =
*cifs_sb,
>                                  struct cifs_fattr *fattr,
>                                  struct cifs_open_info_data *data)
>  {
> -       struct reparse_posix_data *buf =3D data->reparse.posix;
> +       struct reparse_nfs_data *buf =3D data->reparse.nfs;
>         u32 tag =3D data->reparse.tag;
>
>         if (tag =3D=3D IO_REPARSE_TAG_NFS && buf) {
> diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
> index 5be54878265e..2a91f64de557 100644
> --- a/fs/smb/client/reparse.h
> +++ b/fs/smb/client/reparse.h
> @@ -18,7 +18,7 @@
>   */
>  #define IO_REPARSE_TAG_INTERNAL ((__u32)~0U)
>
> -static inline dev_t reparse_nfs_mkdev(struct reparse_posix_data *buf)
> +static inline dev_t reparse_nfs_mkdev(struct reparse_nfs_data *buf)
>  {
>         u32 major, minor;
>
> diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
> index c769f9dbc0b4..0e77a4c0145a 100644
> --- a/fs/smb/common/smb2pdu.h
> +++ b/fs/smb/common/smb2pdu.h
> @@ -1550,7 +1550,7 @@ struct reparse_symlink_data_buffer {
>         __u8    PathBuffer[]; /* Variable Length */
>  } __packed;
>
> -/* See MS-FSCC 2.1.2.6 and cifspdu.h for struct reparse_posix_data */
> +/* See MS-FSCC 2.1.2.6 and cifspdu.h for struct reparse_nfs_data */
>
>  struct validate_negotiate_info_req {
>         __le32 Capabilities;
> --
> 2.20.1
>
>


--=20
Thanks,

Steve

