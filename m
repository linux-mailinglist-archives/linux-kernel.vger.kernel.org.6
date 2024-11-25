Return-Path: <linux-kernel+bounces-420515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DE99D7BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AFFCB21869
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528215573F;
	Mon, 25 Nov 2024 07:20:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2454765
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519205; cv=none; b=Xvvzw6jbVD04+rsK0WLZMGg933Y43aRWcWVvmUJWIEz2Tk4QWLqI7/pVNAS+EHy+zYb2uRiE79MVst0e0coWJigP0Hplg9vvT/ZNfeX64d2kCebpJSpAjbZsUL1MPwoalnf1F/8qQJKxIqKzm7uVmu1uC4Y5JQ2kQLW3sBQ+lXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519205; c=relaxed/simple;
	bh=3VEdrTPoSyT8/3X8sVHPKBYJYT7xchVOTLibk2c++Y8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NY16nZXTlJb7/+5HA1D6o6ZTHGjkl7Mj5PY9LMhZEQsCswl1UVrBFYX5caWvKe8NO6BjwAIRV/R5JfTshYo0mtxgY4Ud5FiecoV9vKPs3JFQdKZEQM4AMbcCvTpV2eT2hTLCTGLUOLrC2qW7WdTN7l7ubVNQB2gAkb3Z0O4+474=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-841a6e28b52so20382139f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:20:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732519199; x=1733123999;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wAp4kJz1ols9+Ebj+0ieMF5LVByZMuqtRetN/bmnJBg=;
        b=ITETghhlv5WEpoMp8QNljYz6wF4K4Iq/QN6QdXFJumAgAYLlwbah7MG6C9eu2QjXfe
         YFnzrFsnPi8SQHEdaMIpOrrSMDN3pFU3vd2+NZ0EBrxinXmE+Vm/xPMV6WzZ4yQfIHYO
         LbmlhUkuJJUtvWnuMjtr1IGJeh0EvJfazp/1eMP1parXQkR2QDNfxXumQO4WB49/Viy2
         iTgwCYOROapzxvbj5iOh7cOmXItHwpmDUlu2Zwvfgl7/mtyZ0xt/vKQ7wuG1Trkufvv7
         kS6Z/iNpUxLbgrSP3kWYN+ixlZ8fdTBJmPeD3FqDxCBwuesk3ilTUAOHGK3+4WZRtc9j
         VPyw==
X-Gm-Message-State: AOJu0YzrLeUIJ6DBAik8L8axH5m2VZvQc2IySSt/xhcwh81NgzAdcXuQ
	oiP7sAJdAoPd7n1bm+cUL+kLGpJ8TKlRMeSCl5UqJz/D8mi5rie7+Ed89zerdEoakEavoG8e+Qg
	ECehmREtyKQ88Vz39M88l4/V1Gzmu2z5Qb0cNS2bMVCPRdXsDcB+1EOM=
X-Google-Smtp-Source: AGHT+IF0DdVYuJGZvFtbae8igCpgweu+RVisu90LEXEfYJGXkF58HpqtOP6zS1c8LMzlgdt/73raJ46lHa8p2PlMTOSwCiE+9NUD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e7:b0:3a6:c98d:86bc with SMTP id
 e9e14a558f8ab-3a79ad100fcmr139533855ab.1.1732519199557; Sun, 24 Nov 2024
 23:19:59 -0800 (PST)
Date: Sun, 24 Nov 2024 23:19:59 -0800
In-Reply-To: <00000000000057a891061ad8951a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6744251f.050a0220.1cc393.006b.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+026f1857b12f5eb3f9e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Don't try to en/decrypt when encryption not available

