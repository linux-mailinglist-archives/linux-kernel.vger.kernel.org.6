Return-Path: <linux-kernel+bounces-399270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8559BFCDF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC0C1F22376
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0E112FF70;
	Thu,  7 Nov 2024 03:12:45 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DB6FBF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730949164; cv=none; b=c3x55F8mZwM58eeK+CMwP96eICT90lBtwHFlLdC/5FSNGIth4S1MFwQIg4BSXWaE92zPCiaZf9AP6zp94dGeu4nGLfX3uSCBt0kTGuiTY9N8/p019Yt/gK5wWgcJdwbKGX8XuCvNgAo1gz5Xk6itQ5jHiBubnkYWAZvH/JmZtbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730949164; c=relaxed/simple;
	bh=D37bF/2scRclf3FSOsaMsDYJWc0Ywnx39B3vicHl6k8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Old6TYvLHOMAjJQFP7MJWaQC7AAttFHzAsP1shvePh7DqE9mqKDvUAPcVJdlNKfeRp9yRpzIdVItIxtwM3yxNoMfyMWamxvRqOpi0uxxVrXUppK9sf5FoINzpNDDDg2VANoG3K0SkqLpXG3NdO38kjRZnU3ym0eZayG9JDaFmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e80ccd1bso5810405ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 19:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730949162; x=1731553962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhyQHCMFSZukOAneSPf7ywClemnpBPt8X/xJgdHHAgA=;
        b=IdRGwXCfFdNBeRJHMQaSmrNMA1t0vyT06oSUGIq8OwsA7LJRqeYvanh/91Tf6vmYi6
         k9HC7/+BW1FzyQd/0G3dZvrOTGSOAbfpDzIB6//jQnVie+h8L3s+oJPLjjHA+L39Yb5g
         FZxPGsB0f46J5xeEEoQbSGU3nStHo0Eq+6ogqDX/nNIQ5NhdK6QnZpfxqiTe2RZww9hd
         EGM1LObKbc+N+TDmuSI5+QOGldw+jFjAwLRyZJSIi32nptoRgXp2o7PE5fNNYvMlvFBA
         SAkJNMjnGm/RlcrNmSHeO48vBpgUlPm+kP5Kx+aRNwdzyLeWnwPe4nlTZC3VEYcT0qz6
         7jwg==
X-Gm-Message-State: AOJu0YxItywC+t0qAU2v9NIp3vhFnc2wXtYP9AgYDVpLmWAEpyxCS7+B
	mBkeujKO98yul8POZeb2o3gqSd3TRvkOmBqIpNzY3U2pDPOzzUqekl34f/IyrS1xBrIyyNUQx2z
	AhPfBTB35KQe/luGZxzNkTWhe0UscZ5z5/IkbwOamMpEwXsFG9EflkUU=
X-Google-Smtp-Source: AGHT+IFe1nO8vR7o/pOAw89zU3uhhz+0drv9HD0FqcjPQi4mGeebTs5oVpsdsWwit695lrBIuJF0kTa/oiyA0pS+yM+p8FsW44pi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a5:b0:3a4:e62b:4e20 with SMTP id
 e9e14a558f8ab-3a6b0281c6bmr219225165ab.9.1730949162079; Wed, 06 Nov 2024
 19:12:42 -0800 (PST)
Date: Wed, 06 Nov 2024 19:12:42 -0800
In-Reply-To: <672b7858.050a0220.350062.0256.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c302a.050a0220.49393.016f.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
Author: lizhi.xu@windriver.com

add resched to avoid retry too frequently when rreq need to retry

#syz test

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index b18c65ba5580..079ba61e24d1 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -512,9 +512,13 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				if (!was_async)
+					cond_resched();
 			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				if (!was_async)
+					cond_resched();
 			} else {
 				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
 				error = -ENODATA;

