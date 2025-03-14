Return-Path: <linux-kernel+bounces-561781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42093A6161B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D9A19C1E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E643670824;
	Fri, 14 Mar 2025 16:19:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2311D12B63
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741969146; cv=none; b=B0s0ZoEkd8ykMzHIvJf5iAoQ3rePJoz/I0NVuRim1TXZ6Debe88HrHyiCu4kxw8eesrZmOftpqUEwUYuYw1JMsBFyoEVv6sjQq/Wv41F26CjnDJKDt/b8rQEwJ3GOrmHJdUwbBHXQFTIAEA5Gx9QclxMf9wqCmVYjg0MQXofJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741969146; c=relaxed/simple;
	bh=1PyPhPPPXzUrW81edLk/hVexOnLGTmWk6S6oTJDjr1g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ag87vlD7soNoE6FNdxtAZNIev5LeLNNl8Jw+rpfY+2eiIqhgSqkhdB3SPc102he7ANTcc1GTB2QrxGRaIXeZnjUh8S31FSBIHY7yz5+uEwydYUfXc37LUbHkaPd4XPppD8PmFoMxCfGEGDXpd0o13xg+bT/Ak8sj22O06m3MlD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-849d26dd331so370019739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741969144; x=1742573944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxgpvdqPX3ylkbOIJHtNR/2q3jsEmcofJWs1Q6fg4hM=;
        b=YmFluSb5ot4w+FMdjw4qBUtlAAkiRL7sa/2wmEKaQNJ0nKW8PT/L6FYwpjs2rA5/aM
         jPizH2JvDc7/7Y19wOeFEgzmMQ2UUROb26IeQLlTn++/bwFwQlAzlwsqPY5AKIv6dTdJ
         M1jFMqFXKjLxrOJCAV1Jw5pmle20QnhOaj/02oE55jCewthoMHUB2gAmJvY2oS/TjcjB
         RGStr+RaQeBE8lBl3qjuRkX2h5hfrcTcKKNgZerf/lm8zSrt+gg3OQz+r3HWDMdKR4Te
         SCvr6Cw67o0rFeFloZpkoJgEKKnOEW7pd3n7M2MB1S5Haryu2qZCinagjIFSIn/Ruy9n
         L1Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVO5vSvHYn+l31mkvqNd2Ogts6aWzd83dBFyRPyukiY90TU4Fcl3fZHWo9eE3Pg8cJTmDkEoML7SUnYI1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29oda5/MQDydOkMJbS4P33O5BVHFKT1/mQtvk8AAOj7HdcpCS
	2Rfqj3R+rgZpX6lJktl/fxD9SIFRxaJS4toTVshBlaUnjBAG7rl8aee6UbkrjxD3Bh+D5tz+fjA
	L7aQBx5sa1+S5IRKgFjwl4MLpoc/N0ADt5A+4OZhS/ocxkE9l9y82JFY=
X-Google-Smtp-Source: AGHT+IEE3iUoDMvt6vpYaKTf9X03mBdBOF392XsUet07v7oD5JzD+kITjp+U2pfYs2O9VOBXHhH9vfIZPElBK0LwW6g4S9LoSoY6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c503:0:b0:3d3:d156:1dcd with SMTP id
 e9e14a558f8ab-3d479f6b87fmr60200315ab.1.1741969144137; Fri, 14 Mar 2025
 09:19:04 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:19:04 -0700
In-Reply-To: <6798b182.050a0220.ac840.0248.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d456f8.050a0220.14e108.0047.GAE@google.com>
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_buf_find_insert
From: syzbot <syzbot+acb56162aef712929d3f@syzkaller.appspotmail.com>
To: cem@kernel.org, chandan.babu@oracle.com, cmaiolino@redhat.com, 
	dchinner@redhat.com, djwong@kernel.org, hch@lst.de, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a9ab28b3d21aec6d0f56fe722953e20ce470237b
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jan 28 05:22:58 2025 +0000

    xfs: remove xfs_buf_cache.bc_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17fb5c78580000
start commit:   69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
dashboard link: https://syzkaller.appspot.com/bug?extid=acb56162aef712929d3f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174cd5f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162e2d18580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xfs: remove xfs_buf_cache.bc_lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

