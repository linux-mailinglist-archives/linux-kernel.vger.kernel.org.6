Return-Path: <linux-kernel+bounces-297722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1C95BCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA92822D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402D1CF2AC;
	Thu, 22 Aug 2024 17:07:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AE1CEAAB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346424; cv=none; b=gIZPQZU/Tk+oOb3pEQYcp/y4J5ndNXX+SPnVCwjAWeM5AkATzGZ33G5WBSlbUM8tzKSHdlDiGtAs6lMfIrEz5LiF6cak5cxpD6gO45Unxat/Oxf2+ehKNIOjZDHNHq07NoILouJb3qlksnaIqffANnJxBULQD/G8+f+wb0wkYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346424; c=relaxed/simple;
	bh=L4uWNuEJE/TL+NF8p+tJ+mgnbBCK9l8dxcx71PXfep4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SZJbanAWQnLYSOLlNSJRFcBjst9DweOlVel3I/Tb/adGUh7TwdMP3hX+crBEQ7iGRWpyYHjB+Q5XxzomhsLa1iT7MNgM02nMGK03h56pDw9I4U9paAulbH3MVMDGJ2xGlwi8Uoq4BdfER5ZskM2gFEIPgOuAP211Ql9N1BJfUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-824e12631c3so157582039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346422; x=1724951222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4uWNuEJE/TL+NF8p+tJ+mgnbBCK9l8dxcx71PXfep4=;
        b=B98seNs3lASBw+e+TvCOrZCsLwqZ76Dtr5xS9Tep6B1zS5t/URRYq9ZbOC+iKw6YYT
         VUZLfk6ccKX0iyuZftEl0zGN3zpIPBvCcS/ZFCeYkgou++aRtDS0qZ5IMbVqCWDKzcT5
         FkAVv1Zi3U8xCHi+dIWQvVWYhSGlYG7sjyX2FE37+vXUNDZmc5SHBonSaN3uk8eacei9
         ZQzqz4+LwH8cQf0OvytZOtIhtK9D+lH2TkfLMGkygmto2oQsEKYpL/v0ugv5AGx/CX6+
         Xt49IZuTB/GG95pcLPv0LukPWE1tI7kean4em4OQvRq7wVa9omW0OAJM6OGDx78tOR/F
         X0NQ==
X-Gm-Message-State: AOJu0YzSWhKpz4n708joRhhIlOTY3czYb+Mw9ufE5lZwrl9Tu9DKhS1C
	xOawa0BRuoN6kMp1Bonry9N+UtUNJjp6SAVGefd0SZ6JaITwl3DkH4BzJMjfSlH+QKz5AioD4VJ
	eVDnSb/PF/V4rr/cwZsfNCuX9fsjJMmEvGVvAgtYReUF0V87T7Dghbco=
X-Google-Smtp-Source: AGHT+IGWLasomLnuXF0KSyTVuPyZ8a+mB2MBdnUKC9MXzCL85em2kd9MGGcfTZxnNVL6z2bkY54ncCYVj4BX/n4D9/sk9RSR0DVj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9821:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4ce72f29fa5mr97241173.1.1724346422187; Thu, 22 Aug 2024
 10:07:02 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:07:02 -0700
In-Reply-To: <000000000000b81e880618c085e7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6ed0c062048afd3@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bset_fix_lookup_table
From: syzbot <syzbot+097987693500c9e31552@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_bset_fix_lookup_table
Author: kent.overstreet@linux.dev

#syz invalid

