Return-Path: <linux-kernel+bounces-331144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B497A91D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6AF1C2289B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86A15C123;
	Mon, 16 Sep 2024 22:17:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278326286
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726525026; cv=none; b=gspXuqz0AnzFyRrK/XgmiDvX8kGELHhIIN2NHGwhMFGPISp0fqXbm7Bd1y/c1k3tnBfeWr7wffei0+wxxL5s2fddLIG2ER8nlT5CBal2iKkAnBkbzKDeBMuzoWRqPhzdvPITQ5uEaglk5MX5OJfcdXqRGGPp+ZTmetojzK6V540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726525026; c=relaxed/simple;
	bh=aJD9WtuwYBiQaUqpimgfA8EwlSn4ltiwoqX/L0Gbc1A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K1wjnYHtlVIaxVJU5AjPAt60wTI+VgdOqxUcMcz7d4EAKF0xSlwBllAcTnkSnn/uBo/Dif97m/vaKetQwG0GtTkXr1fbG/+FEMD6QW+ED9hCiclRVVWvCq5ZTGlx4ir0K91IuYA5decHhn8Cp8MD4c5dogMpUSUzeHL9L2o+nD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cf30e0092so605598239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726525024; x=1727129824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgcGZCyfntKXtqIPJmTqbATT7LnEZQili1pco4Cea8A=;
        b=OLEQ9e0OvLYSXvqOikSjuFeknM/FxZeJ+3Wnx/VvPoZ291+z/ZrF0Lk2ANFfYVmwpF
         xi0un32eiQo4jjg+X7Z2SRBOllKScXLnrK6PlKaATagYX3GRmDyysZzG7Lto2kk95Jg1
         7K7MBk6hbM5s4ZV/AZeoHmtw/4P8vJkAC3Ab72a0s1gbsszzvpibHLyWYeMKtnAip1n6
         a8kSkqvL2HpkKoNVoiJEnDEmes52zfEhBNb2I1q0Ziw9aQqirT8E35HoKH8V5hVG2u4O
         EQi0Pk8fL/esY7xU6aUNm9DXnyW9BRGzB5LGV98FoWTIVgP64pjCT0+noX8EXzh78vRp
         YZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCU8cyJhvz2BMH0DRUmMSvMmbOjSh8OAkAf8XDGlOQi8nixjMK6vQqdzwn/KyJOZEKAoCWmXV7BHaGtmcCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50PRjCaopBLW8jxmxfRY7lmc5fuCQ9Y1Meajg8IufCXE8bQE5
	wZl4OHpT3vkFgyLvEggVpxjAMjAetmT+UUcM3Y79ayKoC8QgszIbf4RojqXA9zgNN+iPIUV5+4z
	Y/ujC1uyqqdj/iYtnO6AzJgY6qHUDVhAXmQogBdIeuyO8lfGZ8JxtzPw=
X-Google-Smtp-Source: AGHT+IG94wCVnBgNT67vBUJeJvAs2cbCSAsfUMy5mM737eu9DzeOIxlpvVlu9CkWWsMhZTlZn22WqrV2R4l+Z2MiqWz8JG4BVAnY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a0a3116a37mr32175765ab.21.1726525023808; Mon, 16 Sep 2024
 15:17:03 -0700 (PDT)
Date: Mon, 16 Sep 2024 15:17:03 -0700
In-Reply-To: <20240916211117.90936-1-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd85ec062243ee59@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in prt_str
From: syzbot <syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com
Tested-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com

Tested on:

commit:         a430d95c Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156ddd67980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9ab5893ec5191eb
dashboard link: https://syzkaller.appspot.com/bug?extid=37186860aa7812b331d5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ee5c07980000

Note: testing is done by a robot and is best-effort only.

