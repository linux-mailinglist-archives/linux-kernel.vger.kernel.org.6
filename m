Return-Path: <linux-kernel+bounces-229582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088A917107
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460AD1F2179B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A7F17C7DE;
	Tue, 25 Jun 2024 19:13:51 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775317994D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342831; cv=none; b=dwzhMSlXSXaX4xIjuOE0WBGcFcRpv5ymVKDWj3jhHlr7gi95mlAtvfLFP1jYgL7xJiMp2SVs/wLBgWDyH7wnm1UuWz3Rs35CCb7rbzkyBLYxf7dSARyjUDOlYmtQnIF9XSfoDsV7o2G8YlFrtMkvGpeD63lgaD3RMGV3TzbLZho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342831; c=relaxed/simple;
	bh=Xg3dM9TrPV/JvIttR8XcOQKI9Q0JfbjJOvYDcS+KHbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S5QFFbP/V1lmy7iN9Jl7z+vufzs8muZjHVcxO1RqmyEW1S+jtneoXiHv4aEMW6J/bhOUu7deATGiGg8ZNVbJh8J1I7LpAqR8bRVfVkpCWbgPHvB0e43ZumBI36VMWmj+gQwwyaeP88d6BQsuTg/m6yQMjGUWrXe4xZVMVmLe2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-375df29cb12so72026365ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719342829; x=1719947629;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg3dM9TrPV/JvIttR8XcOQKI9Q0JfbjJOvYDcS+KHbI=;
        b=IiiD8dYuf375PSynB3uC51PvLgJgRATNlRoIIT+covwdeqbg1zoYH/697ksEDLI5vM
         3u95Ou1jS9BqpeTZRBekVMOo4H1IB6s17dhgxlEuhihxGpHNQ1gPmzyFPbZ8a71tl5U7
         oYqcLsOYTlZUemXvtL0tMggiIwQiMEMQvfbWUUKA+Sgmb2TKYaDMHVJCCdZ+5D4QgSfm
         /vn/ucvzHglx4/Po+Tx4TH4tt9qdY9xq6ooTxWabbUejXIEvV3hdUOETvbbTP5A+M6g9
         qoVZfvK9cGy/1ncONXUGpCvcNzvgLuCG+k+keNxd4ErIioElqmjSIiTvcVuPnjbjIaLY
         0S2A==
X-Gm-Message-State: AOJu0Yyg6HMB2wcB01D7WKZ5qpm5uqnx3Tekw73gpHF/TauYBRtRTEIV
	O2trqnB1tJqz0HJHYc8pcMH6zlCRgAbFQOcLwHV/+Med5pY/MX6Pec06arSIHAeDpuoWiw5/fld
	SGuLEkPsmZ3FKhgp//2s2k5eCQ+37prOGuT5Bc0/P8+fgmdxZnNL9xww=
X-Google-Smtp-Source: AGHT+IEV7Et1lUHTBAjYka6RuXvRctz0osIXBMhQCt2fZnDUsmPHSyFq+uH47azH9v/DYvbeBjTnWmslISTYs2eCg8vP7e4f6MHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe7:b0:375:e698:d0f3 with SMTP id
 e9e14a558f8ab-3763f49d3dfmr6212305ab.0.1719342829097; Tue, 25 Jun 2024
 12:13:49 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:13:49 -0700
In-Reply-To: <000000000000b5c648061bba03cd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093689c061bbbb291@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in bch2_sb_errors_from_cpu
From: syzbot <syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: slab-use-after-free Read in bch2_sb_errors_from_cpu
Author: peili.dev@gmail.com

#syz test

