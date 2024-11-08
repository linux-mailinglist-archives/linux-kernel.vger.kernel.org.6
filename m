Return-Path: <linux-kernel+bounces-400832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DC9C12F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E52284172
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019101BD9CF;
	Fri,  8 Nov 2024 00:18:12 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DCF64A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025091; cv=none; b=U6xMZOg3ZcxVwup6dyLZIVN6EfdplVIW9xs6XOb7rASyPEkgkHwnuksNLAWkLcRyuxO57M4dvXTCHmqIi5DpRzBE2Q8edUvDbcohEHUpPc8O43fkqOJnddguD0Owep0LToyFLOXUtYP2qK3IkgdbfxEnGc7PQ+uk2Ri4q7TGezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025091; c=relaxed/simple;
	bh=P2sGN3qVPo9UCxRWCJe4Uy9gdC3NhMgUcRNxnm37o78=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q8JqGJyQrVRgvUSF8p9GOylzk6e6Irf+WDDODtSwi8a+hNXHf8JCFS/e1EUPoxtp/HmjI1+RFCgAz32eZg/NvRXXnZnIbFINWqA/rPNZob8sWlzUWWguSC5ne/icfldlhzLQaumD9INFf0nlB4MpHPRWBSTUQumpz1ZzjFEt+w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso20923345ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731025089; x=1731629889;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llYblZUdJc/PStXg9lw/+Y1d90lDu3URw9vWkCeocls=;
        b=qOb517nj30geN5TXer7t21dIwbqH2FFDL1AwD0oaSs7m+WMeKgc+WXolhPVYgEnFen
         R+oQOD8PzdbGZ0EMmz28tvgaGupwLVhF7z1WY/iazKeM5IrUIjxLvzURIjPeJ1ttapW9
         DABVx6REwyZ1LG7B2FDoTKOA57CHhBIJ25965KVCJifyZFVcYz/7BxYV/aLVpf4ha145
         ok1tJv7raHyMxzTAuj1Q592hWH6ZKGQEnMVWCIe3kkqL1milxUogxGAN9HVPErcspfuA
         H/uPFy2BEd858GmntKFHzZH1BiYPOO6Dr6bABzIi6d14jo7huuyDdaExa8zOsFE9fYhf
         3hcA==
X-Gm-Message-State: AOJu0Yw9gAvLnuPrmK1nHgog3nUmSDgoKHDtOy+WgKQeTQADy7PZo2/2
	CCk3cmkwZh0CUzAzyol31MzpCXhPJUzlgvocx3tApxhRUB0ZIpbFEja6KqFrfGMBJTTEAatRS/G
	cUct6Sbhu32v45jFaZO1yNX4WFSfTuGuQ5gfa7EWkMtUFI7dxhMfTt74=
X-Google-Smtp-Source: AGHT+IEZja2rIhdLdPUJo2513w1XTCmEXv0+h1cuWvej/t8Jhie7JqtlIotsaifEMRugEnGoiLEkH/pHlHqVnKlUr1/E5SMDgVps
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:3a6:ca38:6866 with SMTP id
 e9e14a558f8ab-3a6f18cd43cmr14253925ab.0.1731025089361; Thu, 07 Nov 2024
 16:18:09 -0800 (PST)
Date: Thu, 07 Nov 2024 16:18:09 -0800
In-Reply-To: <6715d924.050a0220.10f4f4.003d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d58c1.050a0220.0db4.01b3.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+f074d2e31d8d35a6a38c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: -o norecovery now bails out of recovery earlier

