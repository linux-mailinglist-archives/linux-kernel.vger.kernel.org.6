Return-Path: <linux-kernel+bounces-258895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70764938DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C14A281B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB2916C69D;
	Mon, 22 Jul 2024 11:15:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408016CD1D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646904; cv=none; b=uq+fd503dbAq2mQQ6mknLz3rqBiu5ydu6CXjd6RjIdXBhwUgPBfTcAQ0ApbBrGNeLedrVNFlzvqWBtyEe3nf5Xx6ALJAqee68r+7fe8ZzT0zpi+hyvZ4ODHp2ychphhwjCh9kI2jrAmicJzBgCZD31xMKJ4XbKW65ItKJpp0CZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646904; c=relaxed/simple;
	bh=WkuKFQJ+IKeaLG4+Ed4WfVQU18WpgTrAsGLYnWC6jvE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QVUC7gXM4RZmv7mOk7LtpznCYLoj42lkt+jNr58hy0DafTK3dxabeEbTMI6klO9V+NMrpy1K4QAFBC3EZ1lrWj0A3RjLNZvIjEzjuW96vHl/BH4RMyYuqGqV3g+SY5PsXneFSftIwgZtObbhw/qFRNmqp9fSH9QsGzeeUq2O7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7fdfb3333e5so759911039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721646902; x=1722251702;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSP9j0V9uYhme/Z8aQ29/SVdKTk5nZEC/U+OkdKOpfA=;
        b=kTL767y175FiHfUWTdavrRvsmdpovwbAuUiRBToPZIIY9Pq15IVwuLFpswh6NjTAWl
         CXaBN/ZuDBzUQCLR3un6YXln0+Kuy0L2sV7QsagSP6VXgvBtTs9Iy2aoeF4yncgPdOpc
         V1TSqbryY6PjgB7cmPEPgcqQhXTMFqSh+TIeiWTYSiRUbJRrTN9u0RtbcGuACGf0p6z2
         NSNOwSeT2BXxum8nYKdOu93zTORW4/iCDRxrHmn1OGVpwVXi5N+HEaup4Qvhl1ejHQw0
         V2SmJ+cDwAAFS9+LULM+D6+4Oa/DPH7/ZtIK2DhuuFLyluXBtdt5vCUzEC3Y0/WcAJoT
         wbrw==
X-Forwarded-Encrypted: i=1; AJvYcCWdPG9byM4+tj0tWcTTtlr8sDKbQda831kR2aGJz5YP+w2Yrx4CE5ZnZYDhJ57Q6WiwYeN6eNgmO6anCaJpl8mnenQuGI7/LEF9L7Wa
X-Gm-Message-State: AOJu0YyitUTTSgjgsFU6bdc5rjybm50PsIvcrIAzEodt49Ffd/y4CgFF
	lAe5I2IxjM4S746lNJsrvnbk2EaqFrcFI/NDis9JhSJDFFFmU1NGa2TiXmRKIE72pcB0Dyc8Skr
	keHeSQX5Uq6vM4m05FuE6MXaTTpmeTFOQnYbDmB/3kIbaXJzATwFfaz8=
X-Google-Smtp-Source: AGHT+IG04+kQQ70cW8Ncv5JeKyc1UOAD7+G5aUlpxmSMLJRrFoXun4KorsmW7InAp+t73/onfC73eeQe4lCVNTDtGzn9AxsEPDED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3041:b0:4c0:8165:c39d with SMTP id
 8926c6da1cb9f-4c23fda401fmr580637173.2.1721646901857; Mon, 22 Jul 2024
 04:15:01 -0700 (PDT)
Date: Mon, 22 Jul 2024 04:15:01 -0700
In-Reply-To: <20240722094330.4024-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003a0e0061dd428e9@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux.git/3b2aef99221d395ce37efa426d7b50e7dcd621d6a6fcd19d7eac13=
35eb76bc16b6a66b7f574d1d69: failed to run ["git" "fetch" "--force" "f569e97=
2c8e9057ee9c286220c83a480ebf30cc5" "3b2aef99221d395ce37efa426d7b50e7dcd621d=
6a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69"]: exit status 128
fatal: couldn't find remote ref 3b2aef99221d395ce37efa426d7b50e7dcd621d6a6f=
cd19d7eac1335eb76bc16b6a66b7f574d1d69



Tested on:

commit:         [unknown=20
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git 3b2aef99221d395ce37efa426d7b50e7dcd621d6a6fcd19d7eac1335eb76bc16b6a66=
b7f574d1d69
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D93ca6cd6f392cb7=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3D707d98c8649695eaf=
329
compiler:      =20

Note: no patches were applied.

