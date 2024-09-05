Return-Path: <linux-kernel+bounces-316387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71496CECF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BBC1F274F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023D189522;
	Thu,  5 Sep 2024 05:57:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0A14F11E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515825; cv=none; b=FYzMNndzs5Fy64Bh+VoNDYfwp5kGLlMXjRJIo+adLNwnEE3HRc55XSBaO/I+pdl9cRglKSjzNWn5K4kb4rG0IDYJzlFp/8faGIeYO/eNarlxm5mG8qNFs7O6pPEFHdEpCVBU5nUp53W0afBZu+ZAH6Js00Ls7PZKgabf7DNrA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515825; c=relaxed/simple;
	bh=pyUAhBX92buKhrzsf2G0r/M8qmQA7L+1+Ncg4M7/daw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lOVZTTGjEibW2TKK2HlRheWBDK67HxkMUpZbUWzLtNTOICLwyVd7159ZBMMxaBxhq3X3SxsF8OiUzqFC3F9o2kXe3z7ion22lz5rRa1lJUV0nRM4sduXQXChGvVhiJZpvKlhrSRq9BTBKZWns77n6JLAsXUuzlxXigVRwlWzHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f53125f4eso4760165ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 22:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725515823; x=1726120623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCD5nD1M1msY2xhN3qs13wTf/0aKlhatVMivpIcFI+Y=;
        b=ViNb04fKMLa2d4KyqhqOrYHdfXk0AZk7BkUcnW8fT7UJnIwPMMB4hTVxUwjBuEQJxK
         Eql059nYOk+aIgklCzXArZe/ih4jZz/G5T95RKtqlTs1wYmroIs9L9c85CXOExITKaMD
         G47ChWJInrOIaloSoTWokN1ApZzmBra5SFDdO57+XpcIt0wFqE4Q4noZG2qz3grdnxvX
         I6AdMI47GycgJ5PETl88Mj2r16GsnJqYAYDz8l4z3x/wHF+oTq0fml27wgs8AT/Ufskx
         Awr9tBoNmo1gnca/iSBos9YVMJbyLotb4iuU46fNf905ufSibt9JhmjpY6tO1eb4K7Mm
         FMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRWUfw/kHBtSmR5ub38VOEQV+J8gWEDMDeMwy/z80ydLD5i/aafRkiGVX5Hfste3sXhGOcC/rNR8ccch8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRnqln6bOQUaQ9BoTCfUqOQjXrpZDo1GtTkTmwmpc4sC1Btuw
	SALtDt8kWN5G4KnMAc5aF/zj3f0TZlJNS2FaqxuYwd5cCA22CJMKQI+QbJ+hJFO02d2Zu7VErWy
	0/zL/d6OUqSwfdIgf5WmdLoruk56RKxvBnWSyPMlZm2tzKNt9xYFw5x8=
X-Google-Smtp-Source: AGHT+IGCvnHCK805ji6QbaIknsKC6dw63UMmm8pwocMTN3hobf2dzJHRedIyr1YdG/fO3ZASs9c3+UVO+bPSwV8gReCSrtOQsB7Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2193:b0:39f:5c02:48cd with SMTP id
 e9e14a558f8ab-39f5c02bbfcmr8859215ab.6.1725515823664; Wed, 04 Sep 2024
 22:57:03 -0700 (PDT)
Date: Wed, 04 Sep 2024 22:57:03 -0700
In-Reply-To: <20240905052532.533159-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b96245062158f5aa@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 unix_stream_read_actor (2)
From: syzbot <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com
Tested-by: syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com

Tested on:

commit:         43b77244 Merge tag 'wireless-next-2024-09-04' of git:/..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137509eb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=8811381d455e3e9ec788
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1196cfdb980000

Note: testing is done by a robot and is best-effort only.

