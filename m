Return-Path: <linux-kernel+bounces-418692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4509D645D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 19:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD79161253
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2181DED7F;
	Fri, 22 Nov 2024 18:59:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5B91632C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301945; cv=none; b=k7ZerzdLIe/o1II4OjjTNx8KJYYpolBzPKuvMote2V8SNg/rVQBImsWpACuyD4DII/4ccq1lzG/WQ5Wf+IgLEWpFLjLMzQXL8iJ37HIXPXngLlczu1wPwSxnN0MZet21jkyzgNvnNOPqsA8uUcEiMd4Ix8Am7jkwB2cCzao+Cbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301945; c=relaxed/simple;
	bh=6ld5kFiKdRT6Rt8GPPxX3xkAybOWMHMK3WubvUewtuc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A7OuGYC+Xp4udo3j5RU8aLyYBY+h3Kmf48lLGR0iXPJ55rgmGLKxjV0KBtgDQ2uUIR2SBnvHR4tOefWxZ4BTUnu9pVb34lFC25DhKJfbLk6RN+Oz31Ep8T1KlW1eG8+v4vPuA0uy7NkxAoeKNsXS8GBjP8xsPywQfzkCS0s6744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ab3d46472so245517339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732301943; x=1732906743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdAmXdAPdBzHhDcH3V+K+cc880TcrmvzLXOSoHMOqfE=;
        b=oMNSCji03UEeU2z2T1qJ+CylHPwyNNAZfonOHvr7aEmf2H3gi3tw96KwX395OwBGfA
         IfzzbiS9hG2wlavxixWFgjtJYcXIsR12Fs8hMiYk6gFP9U6whDJA3nVtTWaukErdWwPT
         OtWnj/mRLCrut+Cez8XPUfjtA2kSGLz2xSKfgy+ndWsKG30P46ONJkUpjACYPhfxLDM4
         X7sRqMyH26VwdQKElrGxFfc2jJhKSM6mLzZY+NufmdXXuCEdTCXI7mUV7nCuO4U/6SXt
         m5ue8RaryXWxgxqVAzLfSjbQeYAnTZSbHUbKyeXbFWSXDsFaB53swfhKzJ1se6jvrBwR
         xEPw==
X-Forwarded-Encrypted: i=1; AJvYcCUcQiHdsMMLmePJoOmAoTHGIX5VJPmNQOi8BlAN3ya8WyLUFCvIidr9XbL0zHzHIe6VrlT0uYomeYzPkyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3plrw45zmucdiahJZVqUY9V3i+7LqgT7Gb1pGEnlvOH7j9RF1
	SKYd9+3w2rinM1fIvVibJb4icOxflosp6AWD7b4nIsxHxoEp7cNrRxXhku9bb6xRtG9zEEjBlEH
	CAVW6Qz8PAHkGog1v8fPeIH98OheByolKk5iC8MZrWwKrqYUMxzWrSDc=
X-Google-Smtp-Source: AGHT+IGwx8jgTQovViJnP411PUjlojkeF9X9REtkBhao4syiTWX6wihuDOSgJpWq05Yfl+InRrZ73KDosfkRLzsEybMGq+JGAieC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c269:0:b0:3a7:70a4:6877 with SMTP id
 e9e14a558f8ab-3a79ad0ce76mr48020495ab.7.1732301943155; Fri, 22 Nov 2024
 10:59:03 -0800 (PST)
Date: Fri, 22 Nov 2024 10:59:03 -0800
In-Reply-To: <CAPXz4EO5poAP+8+TVWOzahJMa7Q9NGVs+6RuvV38u=YX_xyV+g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740d477.050a0220.3c9d61.0198.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: bretznic@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ext4/ext4.h
patch: **** malformed patch at line 8: @@ -668,7 +668,7 @@ int ext4_try_to_write_inline_data(struct




Tested on:

commit:         28eb75e1 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca2f08f822652bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=fe2a25dae02a207717a0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140ddb78580000


