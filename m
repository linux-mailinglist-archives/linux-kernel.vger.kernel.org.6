Return-Path: <linux-kernel+bounces-297740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBBD95BCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A571F220A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A61CEAA5;
	Thu, 22 Aug 2024 17:19:02 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7061CE6F9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347141; cv=none; b=VbUV6ItKKskHYkGTUrqkhReozjG4hzd8SxJ2HNZob5G5qmhNz+J8pEhzwQ8Wxjmn36W2GWQQ7RRuEE2oLheKOIiMbQKf2VXs7ABgqsCtgtX4GvNPBgI8jToMwFo/DX1SAxlnXhDpLYIqJN9HAtcPGKr0F3k4HLppO9h9hqFRgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347141; c=relaxed/simple;
	bh=zp+TBqTfmLZ9tMnPeE/w5jsgcH5M9cBB8UjPlA5r6Tw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oXSLPq26FyDGC3G8UyOmEPVQN6/FxBfB5gAxK1s81d4Qx41mMrL7sZKaSmgvnq/a5xXzD0zD46+dnwPR4X4dAo/QehF0gsCRFdtzM0hivFPY+9+pu4PwX7XpWWdX5dyFPAjE+TV5A2ysRZKqeoI87Th0N3R85LMNYz9gK7DzKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d5537a659so11038005ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347139; x=1724951939;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zp+TBqTfmLZ9tMnPeE/w5jsgcH5M9cBB8UjPlA5r6Tw=;
        b=RKNlH5iVSau/BTIuHODL4KXKZd8wH35VUGli6pNnoYg6/6plVGOwDrp0pSP0o7qlqw
         jqG4HOIGUWrYtQ4+rzzH0n2vwHKDUOPoHhjgcenhs+AC+3N8aafS/8SxBohNHP1LI5tJ
         0MdQY54z25qxen6ma1XknXj0DmRf6+55DfvoWu49LJGOyKmymq3PCS+MkdcBeuOEeXg0
         WCbBhhjDG6/dA71fk+BOsJsg5YRb7cLHqmvr0KBcWZliytlCyR5aCmUWo1kd1PFsCnf8
         MbRdCR79RwcBO6Zgo1QYjUf7LchjmekWSJyPTxb5X4l8B03ATX3WQNnbPHjMhXjpDm2j
         qqYA==
X-Gm-Message-State: AOJu0YxMkT0xd9QNBYqeBCSoT9xcpUMbmZBkgQak09oV5xEXFksshnmK
	BoxTqd1uIvSrjwlB9WUAr0IB7eLEQDHJXHCd7fpgJVvcPd0/TPqA6fzgAz0CEb6WM01TTnAJ6MP
	1uq2PTtcpjuTwyvwJtaML0YWVEhbU6KMoEyUXiB/+8a9+BkrB1aNH+og=
X-Google-Smtp-Source: AGHT+IHl+GyHnHrCBSqhezgMXEp022lkw+GmdY2l86bw9FqVkQxlMZS3ztavy7SNP7+yUDShtzqdKEF41JD91QN/90P5SXyG5wY5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:39a:eb4d:23c5 with SMTP id
 e9e14a558f8ab-39e3a6e8c91mr262875ab.0.1724347139545; Thu, 22 Aug 2024
 10:18:59 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:18:59 -0700
In-Reply-To: <0000000000006c777106196a68c1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8ef51062048da1e@google.com>
Subject: Re: [syzbot] Re: [syzbot] [kvm?] KASAN: wild-memory-access Read in __timer_delete_sync
From: syzbot <syzbot+d74d6f2cf5cb486c708f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [kvm?] KASAN: wild-memory-access Read in __timer_delete_sync
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Fix shutdown ordering

