Return-Path: <linux-kernel+bounces-442120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9E9ED839
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7581884A09
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A33920E010;
	Wed, 11 Dec 2024 21:13:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C382EAE5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951585; cv=none; b=Ezm2Xt+CUGkf8TPqc9h9hixw8aMQQBSQ+qb8jNwe2SNzShGL/3jNThBVXln5hXigdKk+1XQhOZVC5G/+ySUZSsGu1xdyZXJW1vWDJcUP9l6HbZUsbFYaWzwE5+6MfEqLYbCLzMFSe1lnDF+zKxtZe1VbhNg2yOqpCPAYlGnog58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951585; c=relaxed/simple;
	bh=uEFBdd4xJT+Gb97aSEalUdJhJpEc+SjwIppMqpNR3wY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g+2NybiEmzUnlPpNljvLFp/rmncYiL6HifTUlZUxGeR+3wqbdCRsmyo7KGcRnHsSkALAfJc+Y5guGYCbmvMSqV66nTQ7qQ3xOVvYdA8ukMw8Pxg2daqlUWjj2XyydyHEJVsp3lu5mOwUytXVjjm66Su9/Z/BNcYrPI9DdS/ak/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso38652875ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951583; x=1734556383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxNKt2n8gZASD4x9Nw5YyzpR4bvFH3niso6JZ9o7JX0=;
        b=rczF0DWNfZUNBoUobzpjh+vBDFgPPtlrGElbaAkWHH+LX0TNesxOrXi094TvTKbHEs
         ZuwBdy0G2eCyV2kqwiIak4+xuV65le6+n678NeW44NkLWFXU/wDE2yBTJQr8jKNhGdta
         XRv1y3vVAC2OK5eqMSjGTH0VkiiVR0aEYQ9wwcOyOMImWIf3OaIiSWBx7hqvshxZEDB5
         P9Rd4Ltix1Y2K3pE00qzF4Qlv+zyKQbFeivzwsYhbeFRV7258qf27bqgAPd7FYmG8upo
         x8FGc8ZbMyB8vn1sAP1FHiEPyKOx/dy+MXsYtOQWca+IKaVQTMhsJSoYvR7OmZiW5l24
         eqJg==
X-Forwarded-Encrypted: i=1; AJvYcCWJyb8QicnTYRV+1uhieKPLAbq7SoFlpp4zNzDmcQsDqvnpm+LZlRzbOVGF6dtpTfAyFhN0zNDindVXSzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CGVwJJ7OTB1fAyrY3+qUrv/o+8Y7Tj+vgbip53ractYiT5kI
	osdurhpY4iMz5L0JSNnVs9PaSExbb/iX970VdUsTTD2/Iz9cfZUQ9f+5m32KTGGfRvfGOa93Y7B
	3FVsrSAUCP2GivDtNobTG8TdDG01A/6ec6Sko7EJgTDl36X6+ys6H5NE=
X-Google-Smtp-Source: AGHT+IGoSyLdLWfA/ylYkwW6cIf8WerDzg+iG2cE3VMHhUQSkHVUCUBeo3i24f2WlaX+6N0ePkEEHs4pxSuk74xR6pwNV9mzY2Xf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:3a7:81c6:be7e with SMTP id
 e9e14a558f8ab-3ac488d1ee0mr10544265ab.13.1733951582942; Wed, 11 Dec 2024
 13:13:02 -0800 (PST)
Date: Wed, 11 Dec 2024 13:13:02 -0800
In-Reply-To: <20241211210417.193376-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675a005e.050a0220.17f54a.0046.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in __alloc_frozen_pages_noprof
From: syzbot <syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com>
To: leocstone@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/gpu/drm/i915/gt/intel_rc6.c:139:19: error: static assertion expression is not an integral constant expression
drivers/gpu/drm/i915/gt/intel_rc6.c:140:12: error: static assertion expression is not an integral constant expression
fs/bcachefs/str_hash.c:164:2: error: expected expression
fs/bcachefs/str_hash.c:165:30: error: use of undeclared identifier 'inode'
fs/bcachefs/str_hash.c:169:55: error: use of undeclared identifier 'inode'
fs/bcachefs/str_hash.c:171:40: error: use of undeclared identifier 'inode'


Tested on:

commit:         91e71d60 Add linux-next specific files for 20241211
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149c7544580000


