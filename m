Return-Path: <linux-kernel+bounces-382845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7A9B13ED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 02:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB472833AE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A2DF42;
	Sat, 26 Oct 2024 00:47:59 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FFFAD51
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903678; cv=none; b=La5HoQBXgrDmpcDp8R78WCzfJL1Xg15ptW6ixCMKQRLi7c2cMnu9D2yCUF2OOpb5cCdeihbEh41DSefHZbbo1aNb+ZdleSTGKu0ZXYDK2SgOkjL9qN404vaEnbv4VcxyPnkVCzSnVARzo//h/vbswUdi2+2lb7AMhaYXqcSkBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903678; c=relaxed/simple;
	bh=Yi35yHUZUgamdXkOn6SwrEHUC8JvPZH7NIuG+j7AVA4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p1P3uHgBNiS6klx6b/e2koggNx4a3UZiiDHiA9VnxXg2lsQmS9gtvfvQCtb6HXGp4XJO6SkC9FNykMisbeqaEAKm6X4aP+tnGWqBl7QTxlnlMwYRX4eYK4fiIbccWObfm5q1m1ClYOnoUUl/rovwMHEM2Tc+B5YTCmp4NdLYgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so25971225ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729903676; x=1730508476;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6arsnv65N2EV6xxjc3lWr09CkLLcwdDwWgL1G3q5y8=;
        b=dytwNbh+c7PlzjXUCGiO6Ib+xr0wWeFXpWMB0kWj3nzcva2RBY9BPIJeqNKEckeL3Z
         rsTa+/8HTo8CdpQ0Zpp3E4bixqeejdtIGpI987IzY9AwRxyF/8XSmCG6DLg9pkp7dceT
         5Nheq8IslIeUj4bpXyp26P+wtT2yG29gyylvE4siQ1+Oa6OPWGeyqpeewCx/LA6fo7xp
         CHA2N85KduXW8bXbICHPXBpKmw2Pmkktg15lfk7nlRKxQPCVB6Dw7RPV6zbDgdZyEdCD
         f3gj8MBwg0G/rDa2+93UePy+yF4pS/fpkBMhJZODA5iS7Bd0siAqUXsbvzZTHX1MXAst
         yd4g==
X-Gm-Message-State: AOJu0YwORdxhKxnqr0A2QmxGF9U9VOE0JmvSFqmN0t8CNPuZZuvgUiJw
	RD5VkxET4anIKU539lMuL4IKAEVVtylFAD2SmDuIF3AdhAsCHadnjRevj6sLnCeXJwPwukS567r
	xZNzXOSAqyPgmEWGFp5DIHhbTqAas0mu2csaGBFI47bBtmbS01rQSH8o=
X-Google-Smtp-Source: AGHT+IETNG+mWx7Ah+lw//X10HJOEMaj2VXfrbAlRs6iaVkdvo5x90zWa8OQjdy0NPd3Gku06EaIDNmYT+oKBj+4+fIYA9wARXKt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54e:0:b0:3a3:9471:8967 with SMTP id
 e9e14a558f8ab-3a4ed29e555mr13384985ab.11.1729903676143; Fri, 25 Oct 2024
 17:47:56 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:47:56 -0700
In-Reply-To: <6715f84b.050a0220.10f4f4.003e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671c3c3c.050a0220.2fdf0c.021e.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+7f45fa9805c40db3f108@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix bcachefs: fix shift oob in alloc_lru_idx_fragmentation

