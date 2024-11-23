Return-Path: <linux-kernel+bounces-419139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B839D69DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4A7281C43
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7BD41C92;
	Sat, 23 Nov 2024 16:06:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F32EB1F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377965; cv=none; b=B1/nilVTuW/DbhVEAUNa17rcUNC9xS5onwbyUXvUBgIVanYoianCO3JJsfUpJVmJGAW3ImA7HAHMfOXWkChKVYx5e0jW8pAn6BlgsKyXgw4V7WDA4zz29Sy8gdh5I1PAQUVSxOFDLIssBkcTAe0TVJT11Wlc/3rwodgA51PtwdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377965; c=relaxed/simple;
	bh=/Oe7C8tWFR+WpQtX4zy0qvLDM/utxO6jL0VZWbq3xac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r62JtzgBLJ9g7DEZkToy6h2Djif/hOxKzB4rqMEGutlHPhKaDCexKnbLYHZj/YSYZfznUII2q2iepl8Uo97e4quSk328diNhBkFUYjlwjQEdm+lvWCITHwzmauudv4cOMqWphuvjGNk8zy9vVpTbGRPCdDZKvmXTd9K1fPlLGPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abb901672so361313739f.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 08:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732377963; x=1732982763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LX7/6JCZjAchMCgt4YjUfhqTQQacnrhf6k9MzJL65s=;
        b=k9lKEG5Kra0UREXmVMgCb2HtA1MMuuuf7WZoJLJd8SozzWLYXkmMu0kjiNIkhFTxmS
         asddH2OpvhZlEhRUtGmsXQJda+djs/i/94YMAv1T4CQerYGHjzisH5K+CKCuKwGBjHXi
         AOIDK44Xhp35G4Lz8F/MSB5HmxgSRp3dUrHuu4YuSH9YNEx+Q3thchet75Ooya/UomzI
         dxFPIRxGQllT2wfU3MGvTC3i/JiyHLzeUFLhSZYAt8xXeP6Dgly4WNFcsHgCsyevcc4w
         Pdw5PT2fdPXsvPrLa3vhbnFWpyozozV9EG50r+PoNDhwKSDXm4hlgadoc00R7bseL5oP
         FttA==
X-Forwarded-Encrypted: i=1; AJvYcCVSiK7nk38vT8xq4RYoJ2kM4HKTGuz2H52OAoIr+znIDwrfwKMf8/aVfqIblo2kQX7T8ZHFtE8j9KR78Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIK/j+2qTfzflrOPZYRW8fpf7jNqmKU2BZHsmM1F8JKuMEQpp
	0am79J7I5CHlKq7e2JdDNDpIK+XKhGDQ+6rE2BH1AtqwRtloI+3XrZwvi2JnFDG4MIhBvJWDU7/
	vmixGoMBAmDgN95E5KL/R7z4UM/EjD0kZfUHbYwIHJVfqxGfO0QWeEKE=
X-Google-Smtp-Source: AGHT+IHid+DYZc0rutOVjJkXhhK/zT4IGdk50i6NK0wDiOleYfjLPSpHE43QmXfMhzjwKaijD9FmOdOtiyzjhAeftaObjZP0fY7h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c41:b0:3a7:6e34:9219 with SMTP id
 e9e14a558f8ab-3a79af336a4mr52136325ab.14.1732377963227; Sat, 23 Nov 2024
 08:06:03 -0800 (PST)
Date: Sat, 23 Nov 2024 08:06:03 -0800
In-Reply-To: <CAHiZj8hNe6jgUgZ=FViJV33wd89cpeHeEX-Ak02nn97t2yGiHQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741fd6b.050a0220.1cc393.0018.GAE@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
From: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com
Tested-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com

Tested on:

commit:         228a1157 Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ab7b78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121981c0580000

Note: testing is done by a robot and is best-effort only.

