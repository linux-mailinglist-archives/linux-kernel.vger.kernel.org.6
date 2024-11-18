Return-Path: <linux-kernel+bounces-413018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D199D12B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578BAB2F495
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819641A0B00;
	Mon, 18 Nov 2024 13:41:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797519AA63
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937266; cv=none; b=OQ/7lGqk8HtezFqotp08LhmMKAH9szeCAmVgccOUEmQtYvtjbrthCjJ/qXONAjK9IXXwmQCsjIZVH/O6JtTz7GeSQUAGQuE1HvFs9Uu7zixvxGzzDu8c7KAb2S1sH3PB418FyIWu8oiHObBibyKHRzTPNDDgqZXNOkfAD3A+H/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937266; c=relaxed/simple;
	bh=g3GNsMnTLhukQa4thuSub/EwWdjggPuMhd3nDrGe694=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qUsZqdRLO0Ie5SWE8A723W1R3q5Q/iiTwbgshs9HVOPB9D/B3n48dlYJi+N0HdVyZ0iA7f2jJfqVxDGwWha+3SzhWmWKI9vGLMZCWPb+nsoI9kSR62SQ9PERxeKdlkLbZoMfnbB83uhhYZBUG/kmfUZeRtUf2pRv9XZzyDAZw7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abf68e7ffso479647239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731937264; x=1732542064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGchWN+fhp+tr75N9iVHWT7Zjo+XXifF4dFEhTK8yfE=;
        b=wf/iFc9uP45RiRftIDsue035/0ZWF0sDhH7lzn7EJVQEs/IzNKchTTpcLQSYiBkzfF
         4BHboTlKPjBfP1bX/mxXE879cUFl8WlTuv5xz1r6J9IUeXRns4End6ViPE1FGrrEq06Y
         OvM0E3pmyOymD9LzXdJzqBLcre9yNMzrCfVNyNw9BXHBXygelpLRnPWRSk1+XjCiHjAw
         TSajMTOfO8hTK01DMdD1KyWfYqRyrVi8k3M1dxgVLtfnXVWp6kiFQvKy1qfBX2vUo+2Y
         nvBQBDzRrfTeCxGfBAUTdbosh6idYhjWsr6okxZVYZ1cwNAMgtEwSD0lQ+DKGVeqp9T3
         RU/g==
X-Gm-Message-State: AOJu0YxIRiV8ZCiWvzul63Kwkvssxqf8SgEdOgp17OlrOk8g3xutoHqp
	2NA8qXk7HsVXDzwRZ3BEVT3yAqRuiqJEVwXD6RrP+OBm9yB+rNMssilaHXUt1nItP7xRJpig1Ec
	QZhlwahiUlAf0XFnQJROcpBJGs96g86hjAA/TUyQmG1aK2rBdvweMpiw=
X-Google-Smtp-Source: AGHT+IGUSDvVOyJuhib3JS40fD+0nHoZQkOKmM8P2hslZ6piUtWXDVoLYncQgWkVz+QZRDiON0lC1AdkZmdSyCDFdFRC3UqrZEBe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a44:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3a74800e6admr133899825ab.6.1731937264000; Mon, 18 Nov 2024
 05:41:04 -0800 (PST)
Date: Mon, 18 Nov 2024 05:41:03 -0800
In-Reply-To: <CAHiZj8im=xETmWAt7yi7X3KwwLy4Ad+i6Yk7NwWqJMfJR_kd-A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b43ef.050a0220.87769.0040.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

Tested on:

commit:         adc21867 Linux 6.12
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1189bb5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31661728c1a4027
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12086ac0580000

Note: testing is done by a robot and is best-effort only.

