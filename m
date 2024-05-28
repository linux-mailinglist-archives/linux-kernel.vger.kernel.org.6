Return-Path: <linux-kernel+bounces-192684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 775108D20A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03F78B225A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4654F17165F;
	Tue, 28 May 2024 15:43:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C78E16F260
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910988; cv=none; b=JyAJzExyeM6lmouwEVb86i77fs4ELisD+U5if8a2vI5mDzdXXnpAeZpwI2d46f96r355yAhCHoGvBXFEdRDHQji3yKtHc+lE1sW4tUJm5n6U/WHkgQGd9N+4D3jVz9PLgMK+Y5nazRivQNwWwCf50GfGbVzViz1r6PFhmyZJAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910988; c=relaxed/simple;
	bh=m8dWd36Ko5UDIOAVZmfQHf6AlSQP+P/87X28TrM1dbY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sQsPKXffMaOoxlfyk3oGh5OAo8y8k05VPHlkmGj0vcgXY4tyk9/+DHc2dZRO/e12NVBMd/6Yog7ku0D56jqmArTXxXWc5y4k7iLi8C1d1r/m6NMOi2tqHT1sdq+3SRRRRoh8DzcnRjeosUUldFLBbcIDCOjp/ET0u/DY0/tIm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e20341b122so110309439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716910987; x=1717515787;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nJ84aBxOyzJElxkt3YSTP+R595rZEalfyLp50ct0ww=;
        b=t/ztzEIpfmGrrUZqHOsJ4x8fnt8DGSVuXrGsvAOBsD2aAA1UIPcSgO73OZr1DO7F6D
         irYFPfCf1Qmw8ghPJ6ZY6K0JTy8XPNVtNbV8Mkzdr/nbU6NzX79IWyum7zZSe5iEj7nu
         q0VcTDUombR2YgqZzBmk5RDpW9g/7QCXc8gVS2DynacT8Ysrj3bo9s6ZD038LRlUjIRt
         JYGFfjuNIKD3oJe434C3Ia4ZGmQ5w5vRQ0F0sYiU6uP2dN6yORxl7P0XNU2oaHvkn7RN
         L6D1wCvexA9It9lQ25ZE1guofhaFE76VNEBGykBsu0QDoMzyVdLNGD7RAbUBTNV4unre
         IWWw==
X-Forwarded-Encrypted: i=1; AJvYcCVMGIgj8c+ZrHTS0FtZDFN6Z1hyxSDZxBumQ3fN0S1tFnjJJf+UcGu/t9XurPEFs0wU94mRQ4KezVstHmYlI1Qg36C+VKE782otopu0
X-Gm-Message-State: AOJu0YznxaoWnFpfC33NtUHY50hu75c/p8wh1UhLibkCJJkLSzUmM4to
	E4+0hW1RXI3Rxk+2/avZwq70KdDzb+06U62iJMzHCG/TsH+WhOUe1oebJbYSqvXtutRqf+T7daN
	HZl4l41FMExGEprrJFgcS4bWRixImqVqg6+jBr/qrEyNoAdaW4Gs4h8E=
X-Google-Smtp-Source: AGHT+IGJI9lXHPZA8JwJDsjj+KjBSOmd5bkDiFOW4CNG5zofWCPnuDcrlXDGggYYJ0uAbsXHw+XC/qMi5KS21910t4aXvkFEN+dz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c566:0:b0:36c:5228:462 with SMTP id
 e9e14a558f8ab-3737b31cb5fmr9012235ab.3.1716910986931; Tue, 28 May 2024
 08:43:06 -0700 (PDT)
Date: Tue, 28 May 2024 08:43:06 -0700
In-Reply-To: <ZlXAFvEdT96k5iAQ@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cc41d0619857dd4@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/hugetlb.c:5772:51: error: expected ';' at end of declaration
mm/hugetlb.c:5782:4: error: expected expression


Tested on:

commit:         4b3529ed Merge tag 'for-netdev' of https://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c8c38a980000


