Return-Path: <linux-kernel+bounces-441812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE49ED458
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406E3188A3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22811FECD7;
	Wed, 11 Dec 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N1lfyNT1"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777BC1AAA3D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940182; cv=none; b=peiqxocWkbQypLw8HHcKouQLNtgve0x2jsYpKR38sHelOujqC2eUVvZxPfCSnbOgMdZHrKGGph6IJ9ruR51/2I9P6YHI00kuNuBn77SYrcZZzLByPYlsccWZsnY3YKZ/frbHzGLqBUI4g9i0TLGFq771O1kwRLOlF9F4qKp7ntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940182; c=relaxed/simple;
	bh=nS7HyS4ozxW9sPRYjPUD/a5phvFyGZFlPgAOVWKF+uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhTyamsj1X5RIMZHT9TfKBa7r/ugD2cc7cucGeAUYmDytyRVO+mBL26FtjW4AXMScK9tDsTvI7mwIXYBGHkaV0Sd3Cy1i+KKPwXWBWflNv8UtouS3Iy5vBjE5ceze0dczJfuPFlyCle6ha0gxXYSEkd+T/wOeKCEOBclNzjTl9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N1lfyNT1; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ef9b8b4f13so68063057b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733940178; x=1734544978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqtcPeGztb2EjLpFwZkziN/sq/KtEWy6S2Bxg643PTU=;
        b=N1lfyNT1s5uitXj87cF5ZCuNw0OzDiNymqof689Q+Aw8u3HB2OA9kqN5N2+mxpuYHO
         3fIPYYz2nglWHGegls3mKnRQUvqv/Zj2Ua7MA/3KlnJf19wXW+zvDgGR/G9M8yC4+dc7
         UWpcsbCwDzD2sLAV2z3TJdncyEZlHaJfASes/H3FfZ7PDshdHcPBaKoaVJ4RIObxq+XN
         ogbP3lXT+f91uC6p9GUCFTElBd4Cd8YhoSQ5Kqt9vwn9H6vU/FCoBucBqEcIdAfZrEdm
         8a/wWHgdAmcrJRwko+x8PI+BYT9nEuyWqS+Oda2XJicxfxMOapx0EhPbpB3ht8TMHjnw
         ISig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940178; x=1734544978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqtcPeGztb2EjLpFwZkziN/sq/KtEWy6S2Bxg643PTU=;
        b=nXH7SHbVlcuerNxrxpZVVe+zULnX/QaUQdyJXRYS086WANpOUH3OAL6gZaMg66DakK
         UsLu3lgKravW4Xh0FR/m3Cea8tqPzkbnBVGljBt4c0F7uh9uwAGp5sRUkqZRbb/SnGve
         eH4O7wcgN5/ndj8N07REJxbxOgzqGYyftKa0dFY3QSgR/iqGfdvW4K8N5u8QTWA94v6K
         qZ76600ltXtQhStuSdpThkx7R8jkkEIqdmd96fkHntmj7h08mflrUg18xdGRnpVPlkNa
         WtTrsGIPMe/G9eo4zoeIsr1AuVZ5msnXf+PHSeZ7AKWACfUlu9g3DChQbqs7q2f54VK3
         Ttng==
X-Forwarded-Encrypted: i=1; AJvYcCVJKts0lKrrWnATCVr+qRT/g7F0PXME0KnL+DDIj+ajv90zzSkWpa8JhD7BBqeS/utWqlWPGbfkXQ4bBK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01CKXGpnfYGd8PrnSfuvl914Z/C3A2hiwD/5QtGNkvNbsHVcV
	IWTV3PORMKD4W+DE/FY2UQDF5IuUqkMnVorE9Q64zWipbv1N7ToHX3N8YSJ/3sEYG9XXJUZo5WY
	vJWfg7wfINH/2cGTWjVqw6mLByJ4DBp5TMAfHPs8b/tJXVHhW1Q==
X-Gm-Gg: ASbGncvCW+9f0l1xog3TuzgBUXU2aCYt/B5/rPlB3SrlD1jkYkCj5+O4en61aG5cnmr
	09U3mKmgp3Ll2Np7ii2niau2RbKp1lnMKhA==
X-Google-Smtp-Source: AGHT+IGhaiFjX/L099aGUNCtwGLyut2XxdA9jeU0mNzlqVQ9FVK9XIMu333rd8wujZZNnZZmrQ7W8WIJ6CN1dUDcaf4=
X-Received: by 2002:a05:690c:314:b0:6ef:61b9:dfd4 with SMTP id
 00721157ae682-6f1a50fa362mr3546537b3.30.1733940176912; Wed, 11 Dec 2024
 10:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210010030.2854024-1-quic_jiangenj@quicinc.com>
In-Reply-To: <20241210010030.2854024-1-quic_jiangenj@quicinc.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Dec 2024 13:02:46 -0500
Message-ID: <CAHC9VhSNc5AeVDh69SV9-pSLgsC1T0Fip=Y3nepYCdc8FBFijg@mail.gmail.com>
Subject: Re: [PATCH] selinux: KASAN; slab-out-of-bounds in avc_lookup
To: Joey Jiao <quic_jiangenj@quicinc.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:00=E2=80=AFPM Joey Jiao <quic_jiangenj@quicinc.com=
> wrote:
> From: "Jiao, Joey" <quic_jiangenj@quicinc.com>
>
> BUG: KASAN: slab-out-of-bounds in avc_lookup+0x174/0x298
> Read of size 8 at addr ffffff8846ef70b1 by task spdaemon/1037
>
> Call trace:
>  dump_backtrace+0xf0/0x13c
>  show_stack+0x18/0x28
>  dump_stack_lvl+0xd0/0x128
>  print_report+0x13c/0x6f8
>  kasan_report+0xe8/0x148
>  __asan_load8+0x98/0xa0
>  avc_lookup+0x174/0x298
>  avc_has_perm_noaudit+0x60/0x12c
>  selinux_inode_permission+0x278/0x3cc
>  security_inode_permission+0x84/0xc8
>  inode_permission+0xb8/0x2b8
>  link_path_walk+0x178/0x7c0
>  path_lookupat+0x6c/0x298
>  filename_lookup+0x11c/0x2e4
>  vfs_statx+0xb4/0x3f0
>  vfs_fstatat+0xfc/0x3e4
>  __arm64_sys_newfstatat+0x88/0x340
>  invoke_syscall+0x6c/0x17c
>  el0_svc_common+0xf8/0x138
>  do_el0_svc+0x30/0x40
>  el0_svc+0x3c/0x70
>  el0t_64_sync_handler+0x68/0xbc
>  el0t_64_sync+0x19c/0x1a0
>
> To fix this, protect the rcu read access
>
> Signed-off-by: Jiao, Joey <quic_jiangenj@quicinc.com>
> ---
>  security/selinux/avc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 32eb67fb3e42..ded3823d4451 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -528,6 +528,7 @@ static inline struct avc_node *avc_search_node(u32 ss=
id, u32 tsid, u16 tclass)
>
>         hvalue =3D avc_hash(ssid, tsid, tclass);
>         head =3D &selinux_avc.avc_cache.slots[hvalue];
> +       rcu_read_lock();
>         hlist_for_each_entry_rcu(node, head, list) {
>                 if (ssid =3D=3D node->ae.ssid &&
>                     tclass =3D=3D node->ae.tclass &&
> @@ -536,6 +537,7 @@ static inline struct avc_node *avc_search_node(u32 ss=
id, u32 tsid, u16 tclass)
>                         break;
>                 }
>         }
> +       rcu_read_unlock();
>
>         return ret;
>  }
> --
> 2.47.1

Thanks for the bug report, do you have any more information about the
kernel that demonstrated this problem?

I'm asking because when I look at the kernel sources, all callers of
avc_search_node() should already be holding the RCU read lock:

  avc_has_extended_perms() or avc_has_perm_noaudit()
    avc_lookup()
      avc_search_node()

--=20
paul-moore.com

