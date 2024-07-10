Return-Path: <linux-kernel+bounces-247026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E1292CA14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355FB2843DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56641A84;
	Wed, 10 Jul 2024 05:11:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BAD4A07
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720588264; cv=none; b=i/lj4X1gZOSSxW+QA8nOzkUawBMPiTMH3H37RWUMQwWz/AikdX2Lj5Jh1DOQi7R0t/1iOtRX9CasWwj71p5oet5959uk/JuKPKrQpwwsLlP4dVMdtWh2/CID+US+QbgiJum87JUOb/T44J9lch3Jd3TLHzuFEPRvoVi/xq8A/sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720588264; c=relaxed/simple;
	bh=5WwZZS/GnossFKcZhqYUOwZ/Ni3kvr5R+TdE7KtXpBc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W7e8EYcBiXIVk08mvFlDs5GbQootDojqBc//1YmMmpClOxrdJtlzaoKwdSMbiR3i0cHq+FF/y7WHORVXuqYhLx0qf2UxVYvb0DfNK6JOxAPyF4o3KdtfCYqBgMRMUGpX5+8PMAh0sfP5+HBXW739/aRykPtckQ0KxTlBN7xfoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f682fb3b16so483603539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 22:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720588262; x=1721193062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cYo/+8P+Tx6CDbTq021WZoOhi1qMhLygAn18UoLwJ1I=;
        b=j23KU+HKLLVt+RgpzALuIOGHQk5V3cnOpAMxMQc046X8FKgTt8BJe2DjjQmpfiwUnY
         CoMvzYD3pIyAf/8grKbDifJSQOTWeC1BxN68DAypdm33f2+kHdqm3iuipN696FBK2N+e
         vF2S6S8t1nLQ0j9poFj28g0OW/crVcWfNzfe0h1QzaoSt2cA7XnIqPDSou8wL68F7bb9
         mbprXe+Dn3pfpKoFpEacSIeymwPSSghJSGgip60WnpumKGbETcj9MYDTWgwIZNikexC2
         d5eWKOy0pkNdgLVEXs1gZi41Dba2R/qfVtMsH6rAIZ41MdKKf+4/rGctWhP4pa8ICmD+
         U4Aw==
X-Gm-Message-State: AOJu0YzRykYO75FDimji7oR7+Ew1SRM7ry5Y2FBvrN3TCh+RuDqTtq+P
	C/ldBu2KAfV4NfdZcmV+HTUVdlAhmJwgIIPdjXbFd/GepsjhioyyzRXpY2RmyBMK82vPDkgo7nV
	EgcsR0vzdlIEwEyn4cChtGrzTCKNr5oiUulmNuzNjMJAlCtZGZrwqEWw=
X-Google-Smtp-Source: AGHT+IHrQHRI2bpe6mhYOjyKw/dJ/WJv3kOAOsIMpFWL9YAVWZyKiBB9YqkDR9ALCVZuf9J6n0CR/XxzgKW2eCRwGnkeeFcuIJBa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c7:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4c0b2b7ed9fmr571934173.5.1720588262555; Tue, 09 Jul 2024
 22:11:02 -0700 (PDT)
Date: Tue, 09 Jul 2024 22:11:02 -0700
In-Reply-To: <CAMc0M--OXtWqECVC3rQ8=jbcLPmYPS2op+DoeSJFKyn0ND_jCQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031d472061cddacc2@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING: suspicious RCU usage in bch2_bucket_ref_update
From: syzbot <syzbot+e74fea078710bbca6f4b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/bcachefs/buckets.c:1040:39: error: incompatible pointer types passing 'struct extent_ptr_decoded *' to parameter of type 'const struct bch_extent_ptr *' [-Werror,-Wincompatible-pointer-types]


Tested on:

commit:         34afb82a Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=e74fea078710bbca6f4b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140531e1980000


