Return-Path: <linux-kernel+bounces-362729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898C99B8BD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6FB2821FB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9B13957B;
	Sun, 13 Oct 2024 07:29:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84928FD
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728804546; cv=none; b=K55RrmboGxfedMeymKuJgBatA220BKIHTjRLLuGFmm0/WTQQx4RN56+meEpb/GZtsqABvf9C3JJH4kYPTvK9M5mRpoFuq86aPGMKksduBPiHrAIK1Ak3CsgiUml3hTlpZlPreBhiQdMuNzsd2onuv/QDnkiYEILYNW4KOVYmsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728804546; c=relaxed/simple;
	bh=8uT+SOOTmCaaDC7YAp2Takzkl7vdk0sLD8BQgQsvRAM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CSHYpu+qn8QIa0/rnydwmjfz5VOJQDQrAYjvXxu2Y7ySZnFD9/USOqndUbvCJ6a+xpG9oHNCDYVJD0UpUf4jVv15ulV45sHV4VHshJBG1Zlsr7Jb06EICjl06g184ufd2Qy8eU17IwETh3l+o549OJwAIHsQIQpVYK8JYSz3uV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so3812995ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 00:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728804544; x=1729409344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=db5Ly146jWc3nCt3L1HoMiYuuI6HICXVIjpCZOtX7yA=;
        b=KcBZV3a4lAavbW1leTsMMUAx4iIKhcB6JCzzHTa6d7zddQ6Hy+lNbBp7F3qEMIaTXl
         qll/fWvoMOhYOZt4glkyQVNF3+DRN4Oc/+Vhd/Msm8fYd/mIx/So2Bsa/dF2obXsaxYC
         CXbqG6p+n/gG3lNnBT9c6Wdg+Q3qPBZPeUF1oNOisDs/XO62Nbvb+2yL6EIWOGINgCwE
         xRFOrM0sVO+n27k9aQ+FCDMv2sKWbgK6L8r6hRCiqIXioGloA+SCLwYvrRB2oH1fEXz6
         +zymIoPfXJ86gcQZBHSKe30L2OvTLZkYzEN8ebx+H2ItvLI5s+RvU70UWoRwoNMWmReo
         9z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMymrq3Jis5D1pVSAu2UaabeqfEEXC4gLksCOl8nslXzbXzT0tirwtO21TeiR2gzW0f8YnHhEL+vMJLSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Aqj4D2RpKpVrintaTFIG92Tng079Iskc5EDfQtimz2fGd5fx
	y8QoKtiscAO7dFfsdrmn3EiIVWnqPhfzY+SPAYX8gueix9yFEiANjqwAVgxjS+Z4WyUqOoq8Stv
	KCpYZd0Cl+YgTVfdtuGi2GseKOqPyXZ+NsizTqs6cml6tUQ0LKQDdjiU=
X-Google-Smtp-Source: AGHT+IGR/c85WMY64UUCu6KxmIOb6huaC6kmJFeih6vbrVhoyGzOPUbse4fWhlREoqWqjub4il9JGPJwCNnwVFIfaZ+zVSR+yV39
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:3a1:a243:c7a7 with SMTP id
 e9e14a558f8ab-3a3b5f1de00mr61120785ab.2.1728804544320; Sun, 13 Oct 2024
 00:29:04 -0700 (PDT)
Date: Sun, 13 Oct 2024 00:29:04 -0700
In-Reply-To: <tencent_D10C2E5D6C0C9404EB3EED72CF4878F66F0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670b76c0.050a0220.4cbc0.002b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_read_virt_blocks
From: syzbot <syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
Tested-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com

Tested on:

commit:         36c25451 Merge tag 'powerpc-6.12-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12860727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=797d4829dafe3f11dce7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c3f05f980000

Note: testing is done by a robot and is best-effort only.

