Return-Path: <linux-kernel+bounces-420514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB69D7BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F494162EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E6D15573F;
	Mon, 25 Nov 2024 07:18:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0071426C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519084; cv=none; b=rJGP7h82MSHMZG1Do4EorSkZBp32hpQOQNg2J47WkXFfrwK1sxw3kuFROWCL2TnCjptHyocsJEJJ9XiFZxd2/+OOdaEHpWhYZjN2PrHSRpvm20oDJg4F0Zf3Eo15h2WpOpxtBkxH35CFYSEYBI/Waohsk/yOuW0Br2TqYdnp59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519084; c=relaxed/simple;
	bh=t6JAVXD8WqiXmLj15zGTYYmdHkFUyOOl+pK+dClTZh0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZX+WecS9uKkGxcgN00lztm0JNCEjPIqfsj7PeAFrdiuYwZyFMZ+ONyEPXkSdpwK5j/x+w19KJ80PSv7Qy6BxSBbo+gi0nX419gpLShcH2pkOC+tQ7BcUel1qcP3s9B3YU99FG108HfuEOC6S1/RY++s/FZtIIAbLPtvCFYlhk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841a9ae0f26so7307339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732519082; x=1733123882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feIQqSjdvg7Bfd/l2BCw57TRwHGtqWHuI9KbKj1vENY=;
        b=QQEj0zWIJNSG+pCx8Qpyrm7DHwOWbdH9yWnI9U7Dpo43vH29ZAiQcv2BHw+R0jCqt+
         hXQRmDJT0I1JInE08gsd1+MaWs/M225P3uy8ll0avBlPhGkKetMizlrBMHjm2QoTF7eE
         neCqV7WzCKO9ysEOwo7LUIVa7kT3BUAbfGYP2s76Chk82dx6OJRgDyxqTe/i9aXymIMu
         KifZkWhUXaWcXa2z6qYqm5cnTO5m3D4g8uplxq3LOQVi+XdNtDsDmupBf6Aai5x/FsMI
         951pntvEwTIp0xPwWZ7n9/rEbv0pGhiJXqoQumagfgvzUqWYBr8pSXmJHhXfnwtwqKrr
         B4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXYk5hE9E66vDzlyPGWmJslvGOY91+ULeJfV8I3rYbH8i16i8c/AZLWwQ2wf8evLR5ATOG5xPOrK1UJBqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTYLpv8tyT+DQi86PXcIm6piByjHrniNeoh/9qp2uuqse2/nJr
	Gw9IlcqmDGSdSJweqZEbXJhQ6Pp0swGDpYzfoND2Dl9m+XAQ66+iA1+q3kLi6a5a7BCb2ruw/jD
	vx5xKYPFWBd6HnJfD2mXa5F3yj6xCzV3qvnrWA/ofK/zhyuWZA14j2FE=
X-Google-Smtp-Source: AGHT+IEBhAyRf4moH9b893tkNjNZJbLqolLj7Ej1pjI5CpjY9xgeh7qHkzgGgVz33bU+gVsNhtTKymADNKeEh7FzQ9ng2GwwynCa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3a7:776e:93fb with SMTP id
 e9e14a558f8ab-3a79ad10bd3mr137582215ab.8.1732519082356; Sun, 24 Nov 2024
 23:18:02 -0800 (PST)
Date: Sun, 24 Nov 2024 23:18:02 -0800
In-Reply-To: <CAHiZj8hdRB=x0XBn-MT_kH+FTEL5Tu0_yMDfuB_RccSScuyE1Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674424aa.050a0220.1cc393.006a.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/page-flags.h:309:25: error: implicit declaration of function 'folio_nr_pages'; did you mean 'folio_page'? [-Werror=implicit-function-declaration]
./include/linux/mm.h:2056:20: error: conflicting types for 'folio_nr_pages'; have 'long int(const struct folio *)'


Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1718a5c0580000


