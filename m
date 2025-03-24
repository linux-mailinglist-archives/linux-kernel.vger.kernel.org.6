Return-Path: <linux-kernel+bounces-573081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7491DA6D2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0F13A5EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA331EB5B;
	Mon, 24 Mar 2025 01:39:03 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690815E96
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742780342; cv=none; b=ad1ADwgSedrRCyFL9PMkEQVs03mSbXZsZmhe+FA97y2B+9RU13Z9Upmi5rfVUNko/17W+wjiXxHoWC9wsmz9OjXl9mxRB/UuCknOTE9GETNZAuVI3d6tYEukiE+rqvkXoDAHvSYYDYQR9Q1MlA8GtkU7OYrGRWfvuswzrgMRCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742780342; c=relaxed/simple;
	bh=SyR4veDHasYkwLFjXUjavTd/hbvGPMlZcvEaOyIDaN8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iWEr0D65edP0PnQabDGcLAJo9wMJ6Dg1EU0spJyNFbRRD7pR10w2yXriUST+uNvchCaHANQfHumFz/70+1PSWM7Nnn7rRVKF3jnTrWK4xDHte5fWxgsboYrUyXPb5RNRlUhihy9L9YrVRaaD1N78e51fM3LUUUfq8tE3Ge6CrUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b41b906b3so403378339f.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 18:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742780340; x=1743385140;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QoYcq7gpBLI5mZ2GcIxQTFpbnu82YLU35vchXrF8EzA=;
        b=R1Zmor4ESl9ZVdTkDFMNh1kgjsTp7GKzaKl8P0RZI2iSvcGs9M/MTUtai06RiKsodE
         ouQSQn3GonyqIhqOvTkZjqgiQJ35cOWVf7Kk2GxtoEVZvg9flmfYtSwqiaqID6Z+AEha
         e4rstaScV2I9m6Q8d88/8iAob1ap+WN9G0IT0tlDqhgP+uaVlEQD00ScvK/bTCQoieEH
         9Dmc7lvDd8NSZY2IQDir12uAOWowFqc3acL4ER6o/Ne1tCvYcjA1vknGfQnAh6gxf/Nm
         tIZvXS7TTYp69ZuvUO+Y5EfcU+1ACauUOD2YrN7NJsKhh5Fc6zJd5kX6P2KkBejsnu25
         TwdQ==
X-Gm-Message-State: AOJu0YwjF7klGWazfPQhsh4dI0J3ThQNgwoxhFYth+/MHBM4AVyLss6i
	1raciLR4O7gyAAzUeh8WspVS6l5A1lJ6gzZz0UdWKc9gjh6XkR61sMeVFWjD+NIloKmBUlO0Okb
	rRhhNVrkwHDfJoa2mmUWuQlZG2An58VXvJWH86zDJZYjyW6JXKeijsfk=
X-Google-Smtp-Source: AGHT+IFIAsQDh9jFre3ASuPsIWhY5LI69mHIwGUReBylS61AXYObLV+Ub/VQqBrMBhswWRKSSs+m5cLTLu1XQih4qDpX/UoBVNoG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f8b:b0:3d2:bac3:b45f with SMTP id
 e9e14a558f8ab-3d5960cd058mr120428895ab.4.1742780340116; Sun, 23 Mar 2025
 18:39:00 -0700 (PDT)
Date: Sun, 23 Mar 2025 18:39:00 -0700
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e0b7b4.050a0220.a7ebc.0009.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
From: syzbot <syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Author: lizhi.xu@windriver.com

#syz test


diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..1969772729eb 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -309,6 +309,8 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 	}
 	memcpy(rc->rc_bitmap, dchunk->dqc_bitmap,
 	       (ol_chunk_entries(sb) + 7) >> 3);
+	int bit;
+	for_each_set_bit(bit, rc->rc_bitmap, ol_chunk_entries(sb));
 	list_add_tail(&rc->rc_list, head);
 	return 0;
 }

