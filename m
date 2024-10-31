Return-Path: <linux-kernel+bounces-390207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D9F9B7701
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3C5284A39
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24F01891B8;
	Thu, 31 Oct 2024 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfiN0w14"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034241BD9ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365369; cv=none; b=DKwcqUGD0VR0efcM0EIrln3aMGNzXktTSQwe/Tmnni5iRXVBPm0Z8XUCpVwrc/CQaMZJ2ftJxZVa7N4UEJ/xrl7ee72Afe5AcclEHyha3YUSibaVQIlzp0mqYDxVqP5Pc3TVPOJEPzaJNmlV2cQAnJCB9+lRTbZb8Gtb+fgKfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365369; c=relaxed/simple;
	bh=aQOOsHKX+VtMPkNoIXtwdYgBlNmoQJYuAgsZIpkqWeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYTm7Iei20N7B92p7gBcun8rwLCgQSUCzg0naOfXCNXhlqHB9odt/ZD9dXPzmPDfHkbVgYvyFxTimyPPythiciGifdO11czZYhr3zJBwxAuq0i/yTixsIjetGg1NNGvv+mqSs0rFby7OLO28Gr5/Pk4/0KAts8dy8wO5/QU3b7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfiN0w14; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e3f35268so807539e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730365365; x=1730970165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diCjjIIPfoFiLPd26Ivqm5QC54mYBh2hOIyG4081rTs=;
        b=LfiN0w14x32EqHVOoPrwZJ/k+kC4M3e32lMg9XxN4WrWNqtqCUx8DL1QrFvinCuCKh
         EjEGenFbXLishNxBx7sA4B2cCfcAppYUi9LpgdIb3I6ODGIoILT207byMgOExaTrK5TK
         NX/wrt++Vy22LdAi0wkmgtzpCfNKhWpUiiyaHs1jhgyDOq3GlsFM2CxiiEREFfNFBaDD
         tMH5MykZW4gQLVHo6HlIZ2151TFG1PnNjR/RNKsBL+H0UUvAd+WkJVwSSgjgzx26Q97C
         UmMcQ6qU58o1+8xeyokuqg3gpY5F/8ZXgMdAzyh0LsTmvpEfkLi/85CeM08235bGibLM
         SeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730365365; x=1730970165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diCjjIIPfoFiLPd26Ivqm5QC54mYBh2hOIyG4081rTs=;
        b=YHpwfPCSoX15+30BETOCI0HsasuY1iBWaPWxoQgRru8+eRQw2MOpL5GSFsrwi46RMy
         OliUC5M/OC0+NLRSGTyz9ysBKsZg79WTgN4h8L7Nw9HzA3ZCbGhL+BHD+MA5pxBE7S7s
         6pw6bG8fBXm3FoHkuIEMxpXJhvza9UAaYjecUwmgw1x+GrPwxhUSptcf3soIKYW16MXq
         BG9HyrMZrf+LZvMm5umhtrGzDyorQncVHiVtWnDXaACmb9VGnWT+vE0vGW1Erfq9j5Ns
         4abbonXqcBxch+irORhpGePw4WBidYdWI08+MLNa/Ftqayhn3tFT/hWl6mk9VqMBSAsb
         IFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE0BEdkmIdz3lXwUoF2X4ngjRZIHR2BjaTduwzXE4hSnOgpfahj6tXiWM+0b2uFEWY+rOVcFn6DBKr3m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOUnr/+FcCw49vpo1hSgAqwngEX8GvSwxkiBhg6Hc545PKvhy
	DwoDSzjYx3OotKpSUNIGgRNZHXqssok+WJsRKqTUfCQEZjTIo7fFLz0thOXDXDGIMrDahw4uSjy
	K7mNv673mz30r9DA3WQLEVqyKbFo=
X-Google-Smtp-Source: AGHT+IFQZfON1PaqZk2EwYmBP+wro619qFeGCKNYvjbn6elze4HaRm1SsdtZymT+f05/Why++IhChf3AUyCzbSq0BE4=
X-Received: by 2002:a05:6512:b02:b0:539:adb0:b76 with SMTP id
 2adb3069b0e04-53b348ce5camr9006161e87.15.1730365364803; Thu, 31 Oct 2024
 02:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030103136.2874140-1-yi.sun@unisoc.com> <20241030103136.2874140-3-yi.sun@unisoc.com>
 <036ed265-23c1-4a16-a1bb-452b90e8cf1f@kernel.org>
In-Reply-To: <036ed265-23c1-4a16-a1bb-452b90e8cf1f@kernel.org>
From: yi sun <sunyibuaa@gmail.com>
Date: Thu, 31 Oct 2024 17:02:08 +0800
Message-ID: <CALpufv1JOLN_6iS66thD6KhkY9TAeQd6E5nRoC4uH1kSBWGftA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] f2fs: expand f2fs_invalidate_compress_page() to f2fs_invalidate_compress_pages_range()
To: Chao Yu <chao@kernel.org>
Cc: Yi Sun <yi.sun@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/10/30 18:31, Yi Sun wrote:
> > New function f2fs_invalidate_compress_pages_range() adds the @len
> > parameter. So it can process some consecutive blocks at a time.
> >
> > Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> > ---
> >   fs/f2fs/compress.c | 7 ++++---
> >   fs/f2fs/f2fs.h     | 9 +++++----
> >   2 files changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 7f26440e8595..e607a7885b57 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -1903,11 +1903,12 @@ struct address_space *COMPRESS_MAPPING(struct f=
2fs_sb_info *sbi)
> >       return sbi->compress_inode->i_mapping;
> >   }
> >
> > -void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t b=
lkaddr)
> > +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> > +                             block_t blkaddr, unsigned int len)
> >   {
> > -     if (!sbi->compress_inode)
> > +     if (!sbi->compress_inode || len =3D=3D 0)
>
> We can remove len =3D=3D 0 check condition? Or any caller can pass 0 here=
?
>
> Thanks,
>

Yes, len=3D=3D0 can be removed.

> >               return;
> > -     invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr)=
;
> > +     invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr =
+ len - 1);
> >   }
> >
> >   void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page=
 *page,
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 3c6f3cce5779..d3fe66a93a56 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -4384,7 +4384,8 @@ void f2fs_destroy_page_array_cache(struct f2fs_sb=
_info *sbi);
> >   int __init f2fs_init_compress_cache(void);
> >   void f2fs_destroy_compress_cache(void);
> >   struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi);
> > -void f2fs_invalidate_compress_page(struct f2fs_sb_info *sbi, block_t b=
lkaddr);
> > +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> > +                                     block_t blkaddr, unsigned int len=
);
> >   void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page=
 *page,
> >                                               nid_t ino, block_t blkadd=
r);
> >   bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page =
*page,
> > @@ -4439,8 +4440,8 @@ static inline int f2fs_init_page_array_cache(stru=
ct f2fs_sb_info *sbi) { return
> >   static inline void f2fs_destroy_page_array_cache(struct f2fs_sb_info =
*sbi) { }
> >   static inline int __init f2fs_init_compress_cache(void) { return 0; }
> >   static inline void f2fs_destroy_compress_cache(void) { }
> > -static inline void f2fs_invalidate_compress_page(struct f2fs_sb_info *=
sbi,
> > -                             block_t blkaddr) { }
> > +static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb=
_info *sbi,
> > +                             block_t blkaddr, unsigned int len) { }
> >   static inline void f2fs_cache_compressed_page(struct f2fs_sb_info *sb=
i,
> >                               struct page *page, nid_t ino, block_t blk=
addr) { }
> >   static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi=
,
> > @@ -4759,7 +4760,7 @@ static inline void f2fs_invalidate_internal_cache=
(struct f2fs_sb_info *sbi,
> >                                                               block_t b=
lkaddr)
> >   {
> >       f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
> > -     f2fs_invalidate_compress_page(sbi, blkaddr);
> > +     f2fs_invalidate_compress_pages_range(sbi, blkaddr, 1);
> >   }
> >
> >   #define EFSBADCRC   EBADMSG         /* Bad CRC detected */
>

