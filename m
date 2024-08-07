Return-Path: <linux-kernel+bounces-277527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8146094A28F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C69D288B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69791C8242;
	Wed,  7 Aug 2024 08:20:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07062801
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018805; cv=none; b=jam8xA4nmTJzaPNBl4GuTTbwEu4t6qrW9WYT2pDWdVW7PbCSmTXPzBy3SEq6u2sEhHGQrBaeTkxJXyOVHR9uflKio1d4PCMu+4Fk5VzoHkpUzxKVMJUJSEKH5C/ZsKqlag4Oqlruf0QCqwEQABvorUKY106XUFkAjJJeZV713qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018805; c=relaxed/simple;
	bh=y0nLgbP6+lsqtOkDvKriTr5VZDQ01ZqKxNskY6l8tj4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jrc0xTEC8ca4xH1B1H1JHl95OPdwYUPzwuUZCFQCp4xIKu3emTy02k/oJnzyFXSnaknn6xHYPtJ06sBBivYW1geQt0gUetRFDSyGcFmzVvwPkgUv+d4lzRX2pAJG1cqknVwspdVfDsRw7b0MemvAvYGOgjvRhRjCOk7zZFAxBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f9504974dso202933539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723018803; x=1723623603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5T2A+UUesVETh06KL/V4sZRuvYzRGIN6q6zMcN/thU=;
        b=uyhgYusLrD6QfdZTzONbkoh0+Mmn/JD5WXu2mDpzu18xgw18O2qKZ2z07GKNwYcNZg
         Tr7ukJen0ZlQxw/YgNNxQBZoc4VtqmG0yah24LLcOZ0QUYrfh8GisQ7+cnWLseda1FEi
         TowVLqI/DlMxoJJZ5S5DLcNTIp+q0BhKj3mTKhTKqbbOXkAtCuVXBIXGhfHf/zAf0GQs
         9/HlfIviyaWvazr3VG4hX36u/fIopg75j8GSp3E7+9blLUJy5rYOEAl0hCSIzpvjREw3
         pwd6AxzJXecw+QeHYA/+/qpStaSAR4QnvHNTh6xJtLybFXzqG0WvL26YN593AvsCvHHa
         zDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm/L8ELL9UPk3E1CxZ1P7OiKNJ8gwCy8OTRkYJDYW0zdkbafE3/qYZBisDITEDJwdjnitzCAWTdWF/r3hnLnk+YguXAu7hW1dzaZLA
X-Gm-Message-State: AOJu0Yw5/Gs9E1K85sdwGPBfSBijM4e3AxGMlZT6g707t3mm/OtJscw2
	vaDedbuof8+LJDt5kvYZDY+3vgyIgfAJDq1pHCdfRecfEIV3gq4RErcfcgeySUj/Cr/xPL4wHq0
	mcyuNC3ZWbxqpGjEQ6ipGWKZDm1wiMuSexdMeKSDDQ54N9eqahIIu2t4=
X-Google-Smtp-Source: AGHT+IFaBFRGjjeniLeFbQYX1ffjHbY46uP5mBRmyYpenpnr48unkI/v/vNXBFTBvMvWagmHD8vwPP734rqwHGTrVBX0OYHssDC5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e06:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39b1f79cfa0mr11525425ab.0.1723018803107; Wed, 07 Aug 2024
 01:20:03 -0700 (PDT)
Date: Wed, 07 Aug 2024 01:20:03 -0700
In-Reply-To: <tencent_6F9E3F1BBF4B3A1B5E25B6BA7BBB14331108@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b36953061f1393da@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com

Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1255b2bd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f2a005980000

Note: testing is done by a robot and is best-effort only.

