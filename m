Return-Path: <linux-kernel+bounces-422008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344EE9D9334
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A478BB21F59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252719FA7C;
	Tue, 26 Nov 2024 08:21:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE815E5A6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609265; cv=none; b=oQtgaiD75JKAIunx/mhqXSdyCGm3gEZVkjS5vFSYn9SddYjkdqaE+/Sb29v3SsH/emfqxXi6EcA9BI5B0Iwhedb9Xss1MhFC4meKAwyi+XJVEiw4wZGJdY+khQHY2bvTk11chh+hDU7IuBxp1rD/Y1G+/6MQVX12cAFadnOV33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609265; c=relaxed/simple;
	bh=h9nxMfZoyZaKDKdbndcWcPk8FhPa2LWsvLlV1sQAuzE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KQn41R6ld1ZOfAz8+PKE6VE3n1RA8inmrdxlNUb4/wOGc0ISD7c/O/CUHW7W/N0Bya0rN2icWbRE+k01RsRXDitH8tHX4Q/8SRO08QfAo84uqd2UpxTaYGXflaFDg7UfUZaoeuJxQb/tX/v/DITnWl4GaNbPnQJbwuhfWgonWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7bdd00353so5967985ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 00:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732609263; x=1733214063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5+ka/LQkUtx8jqUI9tIQHYyI9Y3XI1v2clXWRUx1l4=;
        b=ByA9A+Z6NA867aokloxZAuI45QxedbyN8h/7TOcn5+LldsZJU2Zm4rlBy8hxjRhljz
         xYgIbmlrL8POMDh92oViesLIKar6BGZXUTtmBzrjGWveLP49pMdb70oIt8zjnyrReO5m
         R0uHmAsSnZEmdg/2xpLLvHC3OUXK2D3ANkqJ5cdeQx+fxET8A3FIqaBfuKMlMs9uuqeE
         U0Kr7lEBR8xoECGKroYtWtZoPD7L5N0ooR6J41oHTZ7EjLjBSrFrLSvXgeeUnH78DW43
         DQuPIAIe302rT+U7F9R+1FtzzRQ3dDh8lu+R0zMZql6MDJYXL67O3jJjW7SnjzaNJRtQ
         BTiA==
X-Forwarded-Encrypted: i=1; AJvYcCXJu6paguJMhqH5gCsrcm1WjbUo98TRBrzF6KsBWbzacXle9Ctyjw4SbHZNfeTLUnPyxqbmkIZLrw+QKgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPykVBtuqmkv4VaytjcL2L1ktHCHVSJPH2s4qYmn8QHB62eqO
	VLwLrBVoHcehmEF5Yaz7gJiEaIfWl9HFB8y6LmzRIwyqEHHV4qqe67VDw1r48STUNlSkgwO4LmI
	h3CbJJK2EzTV241KUWi075RlxcYU3NA4HgnQr7IyyXWhSPJQj+jIXayQ=
X-Google-Smtp-Source: AGHT+IFwXL3nob77/IIe9In4L7I/CoaFe/f9qVhfnO9G/KT25rpwIjIeOzOQaytVB9bG1dp+fBiIOw82HsNZhZhKXDTsj0eolgY1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a62:b0:3a7:6f1c:a084 with SMTP id
 e9e14a558f8ab-3a79afec520mr192599725ab.23.1732609262857; Tue, 26 Nov 2024
 00:21:02 -0800 (PST)
Date: Tue, 26 Nov 2024 00:21:02 -0800
In-Reply-To: <1806e4a5-7e78-4264-87af-2468289e34af@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674584ee.050a0220.1286eb.0013.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] WARNING in io_pin_pages
From: syzbot <syzbot+2159cbb522b02847c053@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2159cbb522b02847c053@syzkaller.appspotmail.com
Tested-by: syzbot+2159cbb522b02847c053@syzkaller.appspotmail.com

Tested on:

commit:         1b7520dd io_uring: check for overflows in io_pin_pages
git tree:       https://github.com/isilence/linux.git syz/sanitise-cqsq
console output: https://syzkaller.appspot.com/x/log.txt?x=17b85ff7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0635751ca15fb7a
dashboard link: https://syzkaller.appspot.com/bug?extid=2159cbb522b02847c053
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

