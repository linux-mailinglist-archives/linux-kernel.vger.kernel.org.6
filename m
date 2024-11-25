Return-Path: <linux-kernel+bounces-420553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02A39D7C47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F73016328C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6A17E8F7;
	Mon, 25 Nov 2024 07:59:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54514AD2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521545; cv=none; b=K+LWd/3bNuVVJ2zbwEedrVY6fjwRuoJrBTLA5sPjWeOv82QL8iUJQzYtXz+o3qyKTF4lTKIouchVqmp5uJGaKwwPCMkfkJQ9u1HKaUlwWS8wALctk/wt6NqlEYvVYVy9Zq0uGR5gQUx0YXIsDn9VpZ/y7cffE5qnHgtI8m3gZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521545; c=relaxed/simple;
	bh=SCE2WmtsrmDSSAee8KmN5SMZfnebEtLwEeVqxQswg4c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PhNvY2+oW+XE3BMSiRAC09v0Hek2jxY5t8ASUB8frR4u8KIPYRJpgktBx682fmhJLHISWc94Xb/+VvyAfQ1QzlFSmNY+xCcpzWet0sdGrQ+8kQSryQ+aWOprA3Z0bwuXJly8BvbH+V8K2x/t4vXVF2AicsLJD47ifHa73+Y8em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78e952858so43868855ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732521542; x=1733126342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+J1XfTvEGbnZYT5cgi517gy4DhClcf2cPE32t/nKLM=;
        b=e2S0GSuO2kdsIWIqamjaQj1G5IQbs+dDbJUrkK+KGC46rO2zWDkHSRU7G062TgL8xd
         J70mAMq8JifdyV1rcRCnUhtHyEsklCS7GJinGux22xkq57n3LWFG/HTLn/48cquNJS59
         L8RixkiLSMfhpSvoTXJUZIYnDpdy8rQ9nBsOj+WB+DrxDo0Ov4Cwu1wK7JEQYqLahxrx
         tmwrmadiJdbBO9G/+9za51nSzZO2jwTAJum8cee8fLS1BjQCNnoldHVJYgwNjuHdh6wy
         m2l9EfhIV4ovQzaQg65zleE9xfKuYKBpPP3xlsxstkkimBWjA4Fjkk7sTOreooc4WFul
         0lsg==
X-Forwarded-Encrypted: i=1; AJvYcCUkhCNnf8tPn8zsMaNJUPDGL8cK3hSmlAtX46FHDd/OXaivhFInw7bwjoiI6YkO9HaVDttlHFO3ocBLDp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CDSGh8zxonqMZldYCIiHcx4TFcR718T2obJb2gSsiisqolQn
	yK//ambetpLg24dU/w3ysHuTof1GBjqSDKwf9qanqymFntfJGcflcLSXiQq2urU02mNpRieB3un
	LApqSKYs4AlGCzWH58qOx+hkUTyMt+knoXmYYQxo3acVFUnMZZe2kNOs=
X-Google-Smtp-Source: AGHT+IHho4965BcfojGJDwPeALwWVvHbmUeKaS5qZvRoO5hkxYTkMEOBrPgIfbCBfar090ONoFqz2GBQrgoK0IugYAIdhnsIvjos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2182:b0:3a7:6721:7ada with SMTP id
 e9e14a558f8ab-3a79afa9c42mr99183385ab.16.1732521542788; Sun, 24 Nov 2024
 23:59:02 -0800 (PST)
Date: Sun, 24 Nov 2024 23:59:02 -0800
In-Reply-To: <CAHiZj8hLZjkoctrBfabk2Vc32xQP7BW-sVdX+Xhkjd2AGqPWWg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67442e46.050a0220.1cc393.006e.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./arch/x86/include/asm/asm-offsets.h:1:10: fatal error: generated/asm-offsets.h: No such file or directory


Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=146fb75f980000


