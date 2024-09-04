Return-Path: <linux-kernel+bounces-315259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FC896C016
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B3728C1C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0A51DC198;
	Wed,  4 Sep 2024 14:18:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FD1E1333
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459485; cv=none; b=kwQY4qKjZM+5unnZNqJJ9ekCLDX5So09F6JjK8pPaY/45wewbeTrtB+i8am4VIpqG25k1yMHoj51k+xKUJokDMyFlo1vRSkSkweDkVhTQqIbmQkEELS1svlPV9PEIcCTnPSyCfhCmcjvPOiXhJR7k6+nZANdCx1VJbBxyUgl1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459485; c=relaxed/simple;
	bh=Dl+woBPjr6PDYwxopJNwbiHByLrN1ddsG0Y0AF2UvdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PsyiY+FrxDiqrxUhIz2J3Evg9GNxOkoT99sf9x8dZexG3tJRgCa1aJayV28dlqhuDi6EIT8TblkxXQP8//5M5Ey/5AEcI2QSz34aVatgV29cJM0fOVV8CkDcD7D06Nn8pjTQ+Z030bC6eh40GYlN+Dl2ZcZO2Jvk48CwiJangX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a045bf5779so2441315ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725459483; x=1726064283;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl+woBPjr6PDYwxopJNwbiHByLrN1ddsG0Y0AF2UvdY=;
        b=WunbALCDU1jggNbFu0MKjhuTi0efA1GDHyNifu3tRd2VXnRAv9CuQ7fWjWHsJt29tg
         JC8zc17y2Y2J/fmX/bRNWQ8eToRHQu7YIbnPi7nhojGppPSFm+Kcyjkuj2QDxlETtoZy
         oUDLNL5g75EqlxdKtJjXRnPiMnkCUW7FwV48Ttswt15pvCQswp5rxwfwlRyEggRuHXwc
         XMn1099L5JWxtEiRbKCAEJmmMti5S9pJBy3JiBurNlYWnnQ8l/vFpaFDYWkPYDR1ve7J
         OP4jRSxvxqFHDB1x69TZHqRY0UWl6xVdEBkmBVnkdThIJLxy6214hJ+hmHPFhQx+HZ06
         ujdw==
X-Gm-Message-State: AOJu0YyNhvvwZh9iUhEek8jN9Xbt7fQ/Va9a6La0J0Jx/mJtU9HPN+9g
	HvUOt+lvwUOOGMrkBSoIRbSJ41s2vRQ6dbtku/EcmkUSPFpB5DYu8ayH2QlqEyTuPjQ+zf6hd0F
	qhnpBYsulZkODPPc0u+X+6gMd5bzbE/dv6j7xSXx3FHArmRQo2KP1os8=
X-Google-Smtp-Source: AGHT+IGui7ktwVbVT6/su26TlWRcMICoyGtio7vN0700N0eReS9YDOlMZFRtegClswGCXwM4y4/v4QMv4COFXIwzwFh6YVZk/syv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:39d:1ca5:3903 with SMTP id
 e9e14a558f8ab-39f40f042d4mr13500205ab.1.1725459483047; Wed, 04 Sep 2024
 07:18:03 -0700 (PDT)
Date: Wed, 04 Sep 2024 07:18:02 -0700
In-Reply-To: <000000000000acfa76061fcca330@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008fcb6c06214bd748@google.com>
Subject: Re: [syzbot] check
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: check
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 128d49512f5d..a5df8f4c0150 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1472,7 +1472,7 @@ static int ntfs_fill_super(struct super_block *sb,=20
struct fs_context *fc)
 =C2=A0=C2=A0=C2=A0=C2=A0 inode =3D ntfs_iget5(sb, &ref, &NAME_UPCASE);
 =C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(inode)) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D PTR_ERR(inode);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ntfs_err(sb, "Failed to load $U=
pCase (%d).", err);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ntfs_err(sb, "Failed to load Up=
Case (%d).", err);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

