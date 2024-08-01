Return-Path: <linux-kernel+bounces-270490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDB5944138
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1361DB2B77F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E8E135A53;
	Thu,  1 Aug 2024 01:23:50 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260BB14A4C8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475429; cv=none; b=Yj4SKEegjSYEJGeev3hc3HeTF3fhFiLuBxi1SJuWqcwfhBeIAmFsqQRiIUw8uU+pJ9x9fqVtgjFdvEQaqEGSLdkDCYD8YcSDY5lG9nveBEU/PKPHTW9buDrhi8mkzKairO6ntZHbF+EYb7yOke7SAT8EVzVtnz6VdELi194p9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475429; c=relaxed/simple;
	bh=88R3I3nJMuOBubWcM4qZLeuRhWZLK+c8AwPnq8IWZ5Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o6pow8QzgJ+bruEr7qHVN+6AE3M/TV4tWhjuxbDNpLEwDB8wtuTAfJ3WzeiCJYPGbHWhvBPVSTcx2JRmAQRiZ7lioQAJUzj17D8/Dg202N8F9r5j6vMBCvCxoh2I4Pwa96mcDqbqGClfvEnCnXOl/a66GrMuBz+gv7r+gbmOSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39ae9bc764bso83347855ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722475427; x=1723080227;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7c/7LfuOUosVBv493AWIei1s4Bg5R8/Ms3NQCI0I54=;
        b=M2OZK8zHKMboAZ7yp3/452K+TIgyQOe+kyU1/FEzBhi/DAtThpHj/ovP67AcAyRtSB
         vX+QoBWj1itdZ5fpOWSKtO1zECRsJEXxret1jbZTK2JBDsLQOqtc3el1EbEuV/wODeMB
         /vNYHYwGGBGL+5SBZLVzMqKYX8WtyWW8QtXQvWYxbBATAn8791wEpOPqYEseZfRqWC6T
         1F+DiiXgKhkz+HosymZZUVTe6plf4078mWv/MZArP5V3ng9CmZ0wbZSuSbg6oxnO1FVa
         4MJwTVHYlySjmmqNaroZD+PPsvLGp2orb6slz1g+V93NIXgKR8451W3HaRmK2OHOAvd5
         YAdw==
X-Gm-Message-State: AOJu0YztsXFkJGr+3HCDpZhOpGRKurNgN4VFqSW3AnvJfzW5+G4HRSpL
	IQ7YfnDXXyn69Fe1nip5ACNprSenXBGtDimT+PYYt7l3lWGxeRzNi2PXsX4QIsIjFTjICCNdh55
	LIIkX+17CQKoXSQDo5lXnC4Zt4RB6bFftJQCXv3vDHjz6UioFD8HbPKE=
X-Google-Smtp-Source: AGHT+IFWcAnRvFj2e5rM7UVq2BmbnU1c+lZcSctXvjsyjFftm4VerLNwP3T2aiqI4q+ngvI1FOz6uT983RZmfduOdJEzqcjjOGcZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a88:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-39b182e2272mr516385ab.0.1722475427206; Wed, 31 Jul 2024
 18:23:47 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:23:47 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f929b3061e950fce@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
Author: lizhi.xu@windriver.com

if alloc new folio for filemap, init mem to zero

#syz test: upstream 2f8c4f506285

diff --git a/mm/filemap.c b/mm/filemap.c
index 657bcd887fdb..1b22eab691e8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3753,6 +3753,11 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		folio = filemap_alloc_folio(gfp, 0);
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
+
+		void *kaddr = kmap_local_folio(folio, 0);
+		memset(kaddr, 0, folio_size(folio));
+		kunmap_local(kaddr);
+
 		err = filemap_add_folio(mapping, folio, index, gfp);
 		if (unlikely(err)) {
 			folio_put(folio);

