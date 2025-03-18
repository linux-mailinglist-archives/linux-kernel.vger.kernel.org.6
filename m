Return-Path: <linux-kernel+bounces-566418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3EEA677D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AB119A7E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2B720FA94;
	Tue, 18 Mar 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="uHeN0teI"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C920F062
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311510; cv=none; b=TzTLV/JIUv40l84CeH+LnlN5zErVKFUt3YKWdYDMg6fWF7waL/1MW7t0sZt6DFHgjqdTalxjdInZD1ABwIoohT9tM2j/hMmJRLId1U6C20ylrltduH7aHggf/9WtNDW8XD6O5wefT+SsBGoaRZD5XFWPfkyyG7sjaJ9dwq8Ka6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311510; c=relaxed/simple;
	bh=gg9eWXRf0QSIvFW8j2BLRd4qu0afVH6hood5n862QTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRBqFfo1MswkoceIgxOz6aJb5Goh4iT9AnZsz6e0rmhbN9N0cY5ETcbAwtE18SJP2ZtRsMiwICxfp+tWMdgyHkW8FvYmxgfJ/kawUGVtmEUxmL0fWHvfR4abBhrOxWgq7F6pjsfqwT63Za2TZqMn0w/IfOykNN7Vo+cn53ssujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=uHeN0teI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fb0f619dso97851605ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1742311508; x=1742916308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/uyB6tr0Jci4VoVMKtWhkDfXKFhkPYq2fT4hVGN3rc=;
        b=uHeN0teIZfZssPOBd0xAaM7LDR3LhAAzAPhkzj7yR5qYBfmOkCXvWJdAqKBtzLov+F
         eCy8WLA+0cUJao1oedZp86Be2QlUiCdBiTgDGieitkwZxk0wJS5dIBq6P5aUDSCTDZ4F
         oabYlzXzCTeyHb/8HDL3pU/oAG5q/YvemQa3BERk1xzoxL6TxZ8pVqqhQlsOhh8hdpHs
         QxIDnQS2NcTlfciaHveaDmPMiTocpbruDuPtC/SwMOgjtPaWhPKvalXPMqK8WP/GIpMY
         Yd1BwC0QGC7hAx4KqiimsJZvA0M9wXr8idNREnPh4XXaFZ35smlQ8vsSVC83TQjPQtJU
         PJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742311508; x=1742916308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/uyB6tr0Jci4VoVMKtWhkDfXKFhkPYq2fT4hVGN3rc=;
        b=P1zOKBKWvjOTJjpV1UAGytwtMokqikRRdtcchN2FkZ7BpVfPenBr1YwxPz7zQKa65f
         pMmVEPdMKjghaG/Mf/CGxsHwv6oB5aaG8IIMwaNQtbGUr/fjj/+2YtbKqlnSVMpReANt
         F36jLrt4cMV11d1yiiGEseNe+N04GZKwt5WJ37waKfO2EAtwh4Spqg/ofNh7NIUuAJbj
         +wcBYjpmMFC8p2LIAMwMw6e9rERKyJP5qKIRj7tHn5eltDOMAihsvbAzGZhpiyoeInXu
         7RXongsjpiFEJo3qUqpbanIPkOStYpvZy6bYD0hoVrbO8/cSutMARNPHW8rpb5c1XoHW
         usqw==
X-Forwarded-Encrypted: i=1; AJvYcCUAptIR1vvFphjd+XW+5gwuKBzi9RBu2rhdurw0D+sZzTf+WAR0p0xBs9IMdU9yApAC4oypuvQj4AfYhcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQwq8gwNRi5DAuy1JVKLz8we/YfUTOI0OyHmtIf5YTqDJIKjMK
	a6FsR+e+leJvRhjfooEFfv5DPBYFTOk1EhdNhYRUvykEIbTk8F70cWrq68RwAkd8Tzog9nLv1HK
	YG6/jA59pX/nnUQsvaU1zU8YVjrzNc153lL7H
X-Gm-Gg: ASbGncvw0k6+elfv8jqVVzy5okGXktVF5VVHxvy900zSlfipYIn+5JQ8mtPdtwA8VS5
	qC1EIoniK39R6t3e2aPp9a2oXo7hiCAfbqtl4z+t9qCdFzPXkgwzfKUjcpGfNkKJgmNgveP48TS
	nnFSwD2SRTS0eVqn6Fo1nuBKd35KemS6SoFyZjxQ==
X-Google-Smtp-Source: AGHT+IG00JMPu1DGO8+srJWzsNWnbHMlwlrPLuqvFNUYo4+Mbs6IQUh2po/+vcIiaHJBdv6OOCnmocNuu+XHO7/Kt5s=
X-Received: by 2002:a05:6a00:9a7:b0:730:927c:d451 with SMTP id
 d2e1a72fcca58-7372246dacbmr23678821b3a.20.1742311507812; Tue, 18 Mar 2025
 08:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318101256.01afbb47@canb.auug.org.au>
In-Reply-To: <20250318101256.01afbb47@canb.auug.org.au>
From: Mike Marshall <hubcap@omnibond.com>
Date: Tue, 18 Mar 2025 11:24:56 -0400
X-Gm-Features: AQ5f1JpP-N7TrJ8T-KTozAiCA9X5hFTwApUXqUk7ri_JLAbHt6GNt-GMEvno2lc
Message-ID: <CAOg9mSTNLVWjqU4DnHFhBjAfJ7Do_Lfj1Oxe0cn55TBb-hYPwA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen... is there something I should do differently? I might be
using an older
version of the patch, it was sent to me around three weeks ago.

>>Caused by commit
 >> 50fb0a7f43c0 ("orangefs: Move s_kmod_keyword_mask_map to
orangefs-debugfs.c")
>>merging badly with commit
 >> 063f8013373a ("orangefs: move s_kmod_keyword_mask_map[] into debugfs.c"=
)

One has "Move" the one I'm using has "move", as if the author (Arnd)
made an update
to the patch and maybe I missed it...?

-Mike

On Mon, Mar 17, 2025 at 7:13=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the vfs-brauner tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> fs/orangefs/orangefs-debugfs.c:101:8: error: redefinition of 'struct __ke=
yword_mask_s'
>   101 | struct __keyword_mask_s {
>       |        ^~~~~~~~~~~~~~~~
> fs/orangefs/orangefs-debugfs.c:48:8: note: originally defined here
>    48 | struct __keyword_mask_s {
>       |        ^~~~~~~~~~~~~~~~
> fs/orangefs/orangefs-debugfs.c:119:32: error: conflicting types for 's_km=
od_keyword_mask_map'; have 'struct __keyword_mask_s[]'
>   119 | static struct __keyword_mask_s s_kmod_keyword_mask_map[] =3D {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~
> fs/orangefs/orangefs-debugfs.c:66:32: note: previous definition of 's_kmo=
d_keyword_mask_map' with type 'struct __keyword_mask_s[18]'
>    66 | static struct __keyword_mask_s s_kmod_keyword_mask_map[] =3D {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~
> fs/orangefs/orangefs-debugfs.c:140:18: error: redefinition of 'num_kmod_k=
eyword_mask_map'
>   140 | static const int num_kmod_keyword_mask_map =3D (int)
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
> fs/orangefs/orangefs-debugfs.c:87:18: note: previous definition of 'num_k=
mod_keyword_mask_map' with type 'int'
>    87 | static const int num_kmod_keyword_mask_map =3D (int)
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>   50fb0a7f43c0 ("orangefs: Move s_kmod_keyword_mask_map to orangefs-debug=
fs.c")
>
> merging badly with commit
>
>   063f8013373a ("orangefs: move s_kmod_keyword_mask_map[] into debugfs.c"=
)
>
> from the orangefs tree.
>
> I have applied the following merge fix patch.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 18 Mar 2025 09:43:37 +1100
> Subject: [PATCH] fix up for bad merge of "orangefs: Move
>  s_kmod_keyword_mask_map to orangefs-debugfs.c"
>
> with "orangefs: move s_kmod_keyword_mask_map[] into debugfs.c" from the
> oragngefs tree.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/orangefs/orangefs-debugfs.c | 43 ----------------------------------
>  1 file changed, 43 deletions(-)
>
> diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugf=
s.c
> index 98b52ceaf011..f7095c91660c 100644
> --- a/fs/orangefs/orangefs-debugfs.c
> +++ b/fs/orangefs/orangefs-debugfs.c
> @@ -97,49 +97,6 @@ static const int num_kmod_keyword_mask_map =3D (int)
>  #define ORANGEFS_VERBOSE "verbose"
>  #define ORANGEFS_ALL "all"
>
> -/* a private internal type */
> -struct __keyword_mask_s {
> -       const char *keyword;
> -       __u64 mask_val;
> -};
> -
> -/*
> - * Map all kmod keywords to kmod debug masks here. Keep this
> - * structure "packed":
> - *
> - *   "all" is always last...
> - *
> - *   keyword     mask_val     index
> - *     foo          1           0
> - *     bar          2           1
> - *     baz          4           2
> - *     qux          8           3
> - *      .           .           .
> - */
> -static struct __keyword_mask_s s_kmod_keyword_mask_map[] =3D {
> -       {"super", GOSSIP_SUPER_DEBUG},
> -       {"inode", GOSSIP_INODE_DEBUG},
> -       {"file", GOSSIP_FILE_DEBUG},
> -       {"dir", GOSSIP_DIR_DEBUG},
> -       {"utils", GOSSIP_UTILS_DEBUG},
> -       {"wait", GOSSIP_WAIT_DEBUG},
> -       {"acl", GOSSIP_ACL_DEBUG},
> -       {"dcache", GOSSIP_DCACHE_DEBUG},
> -       {"dev", GOSSIP_DEV_DEBUG},
> -       {"name", GOSSIP_NAME_DEBUG},
> -       {"bufmap", GOSSIP_BUFMAP_DEBUG},
> -       {"cache", GOSSIP_CACHE_DEBUG},
> -       {"debugfs", GOSSIP_DEBUGFS_DEBUG},
> -       {"xattr", GOSSIP_XATTR_DEBUG},
> -       {"init", GOSSIP_INIT_DEBUG},
> -       {"sysfs", GOSSIP_SYSFS_DEBUG},
> -       {"none", GOSSIP_NO_DEBUG},
> -       {"all", GOSSIP_MAX_DEBUG}
> -};
> -
> -static const int num_kmod_keyword_mask_map =3D (int)
> -       (ARRAY_SIZE(s_kmod_keyword_mask_map));
> -
>  /*
>   * An array of client_debug_mask will be built to hold debug keyword/mas=
k
>   * values fetched from userspace.
> --
> 2.45.2
>
> --
> Cheers,
> Stephen Rothwell

