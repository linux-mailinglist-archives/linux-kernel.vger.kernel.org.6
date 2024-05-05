Return-Path: <linux-kernel+bounces-168857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE3E8BBEEC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 02:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1961F216BA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C9CEA4;
	Sun,  5 May 2024 00:31:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263D37B
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714869066; cv=none; b=u8/S3kEnaMV5ywiqMaGc2cGTHK3y+GSo3ym7GBUNIrEjBr+XUOJmmJlc+tdo2ByuIVoMyaV1qQEn3uIrIE6xYpNTDr3d+64gZ6U8qs6GfsRr5sQgGHkM3z7WIQcOOmanik8OO2IZTT7wMujVRF7I0fmVYrLC6JaeiitoKjhAhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714869066; c=relaxed/simple;
	bh=yeaF0KLOZ+F6G8aO6k39fO/HrEIy9PLV3aNNvKJG0eA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p82+vK2m/KveFM9+fxe58+Tr5t7P2MNRpbAfDMLkE9gToN5YKe1LZZlUx7rpA29p4vlS9hEfConIcN8DrGfpeN+Nfgpfo4bEOgq7jKpCKng+usOI53n6f6xTqpxdaM9CVOJz10o4roV9O4ONyUGBHkGC92FhQCZGQRj3z60rYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dec58efbfaso108786739f.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 17:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714869064; x=1715473864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6tqYYYhRvVaZvIPd6vQAP0ZHe5jVSZk7yANBhSLvOA=;
        b=DLAuRFXbmrdE1hPE4vuZG6vcV+zEu6K66/e3OVdyTwZg4aLHKXny9tD+JkTouQ3PRl
         eGFS36CnHAaWs3LnqLGQqVGN5MU3xTL3+uosBUqx/NGrtZp4jLzhj9rkGSbE45mqdQff
         JuCa1QKqpGYzx3PWK7y1knv9B77urg5JUj84HUUnuVuhEPrti3Yj7uVNcsDv/HiUZQUz
         n6jjR9WlQnZyvaXiW8FKwt2GuoRezVVY1fJfHxo4XjmDfwBBzTh8kvsIkByUct8An10/
         0a5hFDf6exhVS/wTETmiEHiaaRN7dUzPkLVPqpp+XafkhIOx6xMBssT8cNydui3D7zme
         IQiw==
X-Forwarded-Encrypted: i=1; AJvYcCUbcBk1QpE7c3ip2dRn2OzcL8lX+zmSvCdFkdz07A75FAcpYsVrlmcgU/AzvsgAY2xcefbf5xjJK2g3Ta3bsb4uuWrH66cnR9u4C7fi
X-Gm-Message-State: AOJu0Yy4IwUNihQR92rI1jYsdA7evQuZj0Np36eYC95U1Rr9+Z6Wm5ag
	L1KBcFhmjlFzmwB3jAGpVJt929IHY6qlTtdKais6xwsIDKxqGdedYqjIby4aQzV0qAcp+F7ybAc
	ZsA9jiwF9j+KEOd3GtEWgiDDHxOui3axieUyBUm58sqqRRDpGL2eQJ1w=
X-Google-Smtp-Source: AGHT+IFLMsK/rGoaPZGBS69uW22a167CN1WRtUS8TpkqpPJVNTcVYNwuDZCUxezA+whkMQo3ywS0PIu1Cj06lwHZLXYzTHf08W2S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8517:b0:488:7a00:9343 with SMTP id
 is23-20020a056638851700b004887a009343mr60839jab.0.1714869064791; Sat, 04 May
 2024 17:31:04 -0700 (PDT)
Date: Sat, 04 May 2024 17:31:04 -0700
In-Reply-To: <20240505000131.203160-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007189860617aa117c@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com

Tested on:

commit:         7367539a Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174c15f8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5179255943c0cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=d2a2c639d03ac200a4f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1144eec0980000

Note: testing is done by a robot and is best-effort only.

