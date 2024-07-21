Return-Path: <linux-kernel+bounces-258218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEFD93851A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E98F1F21169
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC81662E8;
	Sun, 21 Jul 2024 15:13:52 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B3946C
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721574831; cv=none; b=LcLjH8Vtnmeptk9uV1PMCaoWzxT5AnzS1bqwI+YohEDtyQUqBI55usLWut1cvvAIXoSxk2ngt9hLg9h6o524SIlQbt8tH2y1EeoCEreSJOQdU4wlzaI/t8xmIGy6h8y9OMBFLfua05lJBx51GpPXaoc3pnkf6D8UYnD6lvh8dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721574831; c=relaxed/simple;
	bh=dOdPEV+asefpi6L6HftfaXqFxWrG895Rr2yFfmMBYCk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TuKsnyQP+Macn7Ymg5rk+sbZx+JBTOUsBD2CCA8VVBhHh+xmCuwE02gNc1IDnmDuGIbpZxkKDV2eXgaitsAsqzGRTR/wENMJA+b69BiWcz1gopa0JkiqVdl4JWRUnNahYAEtbq3Dx+AIcfQvM7dzbOrD1JsHf6Su1eqJ/NWQptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81257dec573so568730239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721574829; x=1722179629;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOdPEV+asefpi6L6HftfaXqFxWrG895Rr2yFfmMBYCk=;
        b=VYSsFKDN2Zunj6gY5HbmGXC+cNWXJ2+4A/GBbSj5MjrPgK3AP3gxkLiZr6apQ+mZG5
         65Lz1UIULTCWKFwMQkVLbvOCseiDWHcyqstJJJHCj0zvRAWRXJfeI3Vgkg5gxefV/MFY
         5fw9roYCXm0YbcW6JmkG2DjhXwzPLp6SZggLLuKSncol11kZw6MN6CVyCvNHCa3NG+Vy
         K2ussqTGpQBb7rU5ZI95oKjCmGCalRzOrXnMWgaMt2axkCPcCkjJHH5AkebKnrXM3dq3
         XnYbBn4yeZIY48a4wMlonIrPiX+1RkZqmMiJ4/zdRLb6ndoICq80y71P0eKjynzp9Zav
         vvkw==
X-Gm-Message-State: AOJu0YyMo6a7d9cgrLfLtOh5+Gm9MLvzCkKaUpecDi4Wyx4HQ36Kdhrv
	nb8IOSb1FrUgLxMoe/aDak+f70IJELxmJ70X1UOIJsYw87vtc6QBIlULbNt/as0eKA8k9x02M1C
	xueHQ/BVrIBCPg1LUQ59grH+W4i+yQLIBUidxzTzp0nfsFngMUJU0QDs=
X-Google-Smtp-Source: AGHT+IEHXbJkWNBgNVCYT+S3T8LUOYL5ioqmZ1GolidyfoEg64URGfefcflYHtNRn4ZOYyvWCh4QaIa+WJEMB9EAP7p6sUICoLR0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4129:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4c23fd14c9bmr324655173.2.1721574829586; Sun, 21 Jul 2024
 08:13:49 -0700 (PDT)
Date: Sun, 21 Jul 2024 08:13:49 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c0ddf061dc360c0@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free
 Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d839a73179ae91c07f5f2f97ccb9c69b2b7c3306

