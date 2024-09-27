Return-Path: <linux-kernel+bounces-341273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE91987D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6030B22406
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91495166F0C;
	Fri, 27 Sep 2024 04:20:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F032C9A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727410805; cv=none; b=ggeSYx55LpYhMeG3ic1NQqIvX9d/19tKS9VhI++3orlaz1zb/3UbT9oFDmLJFtsNUwD1EMB5ZqqrdhffyhgAUYXwaTU6/pnDTMuXUVGTrA0d58zL+PDMjLOEibY8oqJWW1b0SfddvUzhhNzvPb/6m+nE4ad69uxoZ9PZrP2OWSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727410805; c=relaxed/simple;
	bh=Cz6JJs57+3dSx9DYgXYCtXzib+9rFlOY5gSdPVNNKsI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dPfD7IfGxfR+2Bz0J8KsgxehbMhMLf3GuPSchBk1K2bGNGo7m2lAkOJQZ3YX6/B4YIXLqJPZsLoTT9GHBAFngQbn2IfIFbdvNphWYXphJ9ILp4toTN1obaYU9z2oPxuu8kKFbY0T150kmnsfnGQZGlQdGmu6pO6fgMMO6QXTcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3412ecb29so15377415ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727410803; x=1728015603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CX7Ep58qCR9yJrnzmN32s4RVd+dWqpEw2O7CfZWsEYM=;
        b=DapzPQIbKXJeMpjS4gAk2DCJiiO21FGjIUj8ruwtDjWWpyUOm4Fk67wyt4QMp1aPuP
         aboWxhOji7ouEqqOS08AtKEPorDs6fScTdxc5znwb3Nbg2WyJEEdBpmaCbp2rmZFTfVd
         Zw0XydtgvPxdXqnHLzKz74Vkja2JPtiBsZDSHfxnObXf+pxSUfmPi+8jOpQWpgMgWCFC
         Dn3hCc+a4dgOl6+BYBvmDYgbCTL1w6PVBJZcVj6/w2KSV2G/XLLvz9Dv3Lf+J/oVmIY3
         fc/sCjvEp2h6gN6UZcuuTKRvkkRG3SufaC762pPFnumxIk1jv/Mlvc0OGyXFKniTXISg
         2Zcg==
X-Forwarded-Encrypted: i=1; AJvYcCVzDFfOOcZQBlGYzn5kLr6uAK1VB9YsEYU62jgFD5LNof04oKc62NLTMe6t/3X1Jed/E4QG2P0KmCGiLyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrQ/yzBawZXkccJIlqZgf/JL/CWDK+uXI+jnFl5WcVx0NEJkk
	UltGl7/lz0jmrDabeFu46qxzqc1x+I+t6gkZQnE+zEsKJqvW2pwYVBKgpJVdWynyE2uzx8AuBlB
	KGOugBX4nbUotVTmbXX4iPG/18DhveQ4epMppMkIXkX/fKs18ZpKXGiY=
X-Google-Smtp-Source: AGHT+IHnAeGa2fogoKQQ3xKgpkIzQPw/9IMr0+S2KhTJxzq8wBMWozCxFrIa7vtViMGq5Js3NAjz2zwOX7zugx6yV2wQyNptIizv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2a:b0:3a0:98cd:3754 with SMTP id
 e9e14a558f8ab-3a34515569bmr17755785ab.4.1727410802883; Thu, 26 Sep 2024
 21:20:02 -0700 (PDT)
Date: Thu, 26 Sep 2024 21:20:02 -0700
In-Reply-To: <ad1e7e02-26f2-43db-b18f-ab995cd4f982@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f63272.050a0220.38ace9.0009.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in copy_huge_pmd
From: syzbot <syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	david@redhat.com, hpa@zytor.com, jgg@ziepe.ca, leitao@debian.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com, 
	peterx@redhat.com, rppt@kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
Tested-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com

Tested on:

commit:         08768b86 mm/huge_memory: check pmd_special() only afte..
git tree:       https://github.com/davidhildenbrand/linux.git copy_huge_pmd_pfn
console output: https://syzkaller.appspot.com/x/log.txt?x=1087aaa9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=bf2c35fa302ebe3c7471
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

