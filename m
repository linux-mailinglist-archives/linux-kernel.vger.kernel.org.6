Return-Path: <linux-kernel+bounces-565826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B55A66FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C32C19A0A58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5781ACEB7;
	Tue, 18 Mar 2025 09:31:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A611422AB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290266; cv=none; b=i+K1E4PGD9CZZk/dlnJt35543fxzG9Q5J9Glm34E0PTDrFjR7buv/yjgSoYV3xoOcKTJKe1xQwh1mwhmrQDNKaTRFKQN5z7pUux9IrhNqm1el+MPabhBem8I3SBMEE5srHnal/JfK6Zz0M+3supGflKcQYZVPD2WhyWyi7XAZc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290266; c=relaxed/simple;
	bh=1+GAtWUgqYYv1PMFiGSlr3pTGevBYLP1Y7tBdF8PrwE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FOkkGTibe3izJ+NF3JPeR9SoyrrWyHK9lpTWZf96FcKFPMS0GAA3tqbqcB0M7B1ZHOZh/RZuJGZMqrypkudtTtmXfnHxXphcfAjbXPjkR0/untr2izG1mKBT1G6IqX67H7bxcHlMlKuZ9pRXzDHibk38qVqup8s6lQCC46AzDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d3dee8d31aso51806235ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742290264; x=1742895064;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6/TkonFkz5fxmwS4sDJtS4PAxIoyVa9173dJtRmnwc=;
        b=pJNVL2XbnI7D/b/SC/c7RFSIy1dD6OA72v7r9rc5FWoCUErTno7M1FR8cS8n9g6Wz2
         hMyoaJNivfDzM/Wg++/E1jOec8Wq0FPLfNnh7AJfr6GcVzl4BMCvCAbWrIT4Mjk+/uNu
         ehl7Y5xZXPINaE1CvYtauutoxTVMA0xgzadYUpm9l1ITsMiwfmSj1lUZfdoT2mlX1rwR
         vfhrUo/+eJWKRQ/Uh0UD+fhGqzZ2FuTPycqsWvgG0TVJWPv6oMyLolcnNrP8uEAi/E08
         sJeE5b81JqDWtZQWqnjIStT+Kgy/Qdif8zqCuahqL8p/BYyrCbczQErGXxDtXnGetDeH
         0MOA==
X-Forwarded-Encrypted: i=1; AJvYcCVzuCyzc0apQGP+QdWra9tOejsrk+Havgwdzo3bZJKTtrSdMIHKQR7/iYo4uAL7hNGMbkFXm3rwcIuET9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyviHZpTiKxSltcKl+4hnDDZMtW97TllgsMWbzTbx6du7Faj7F0
	WxkkOs6cIzbvtPXobffv60bQH18nqwbflhlMJRqfO+AqXhzw/Za6oqljdSJeTd+kbtIbaKRr8gA
	qtxx1pRJeqKhjEbGnlDhxWFNAdF57SKGzcaxDFnYUvY6eD0x80NVNz8Y=
X-Google-Smtp-Source: AGHT+IHUR3UV9tdFlbDhqC5JO6ymSl1Y1oTVNZ98E2LxLA6E6N99DgeLQ3X1DN9o8ZEKgAsq26827u4fHM6WZqP1RZ2dE+tyRK7C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2603:b0:3d3:deee:de2f with SMTP id
 e9e14a558f8ab-3d483a14189mr194722845ab.7.1742290264412; Tue, 18 Mar 2025
 02:31:04 -0700 (PDT)
Date: Tue, 18 Mar 2025 02:31:04 -0700
In-Reply-To: <20250318091024.45600-1-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d93d58.050a0220.2ca2c6.016a.GAE@google.com>
Subject: Re: [syzbot] [afs?] general protection fault in afs_atcell_get_link
From: syzbot <syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com>
To: dhowells@redhat.com, enjuk@amazon.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
Tested-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com

Tested on:

commit:         76b6905c Merge tag 'mm-hotfixes-stable-2025-03-17-20-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1290f278580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=76a6f18e3af82e84f264
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a7244c580000

Note: testing is done by a robot and is best-effort only.

