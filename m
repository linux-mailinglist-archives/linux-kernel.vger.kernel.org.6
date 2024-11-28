Return-Path: <linux-kernel+bounces-424934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DFA9DBB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD09B2288F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B51BD9F2;
	Thu, 28 Nov 2024 16:47:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C51AA1E4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812424; cv=none; b=UrdJQOJn5eGeyqbVqwSV6bH1SJJOHfM+sJK8w4ImW1wHonx7gTcapY3qe+iPkwGR2sCAfnYA2akQ5bLl1VKqKmp49dHnOcoDv74W4fd+/ugbUpfW4ir7qmxLu5qAEGyYHg+L9d9PSBPi2qT2nYNq++WGW+PulqTMbvBV6fooQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812424; c=relaxed/simple;
	bh=qN1BVZeLJUZjyfFPMYiLwnibmO0IeO2MVIckXI60Xak=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R/kZ0ncVqw9C0TyJJBWDyxNGIyjHhbRwQZxw7JB2B7Y71feJ/N1TOiy+SaH0einLnltibNrqP/InoHCRBX/nSLBrlHKAnETsvOAHB6kBQZ9f8hcDOJjnLp/wgUh1l2Nz/xL3XdbjvbQt2NfS4vBFSsQOGsPkinJYt47+mfafvsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a76ee0008cso16117715ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732812422; x=1733417222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB6QKltZBqgTuIMurRDLD1EU9kWoXkGKf5mAkXTzeZA=;
        b=B69OQ3MvcHt8iurON8emEBfLxnhIAWEUAx5s90i2pdFTM8Y7YGt2HH1/nI55ufbxL9
         pcxdMrhe1UJTrTyRChPPPgsscIUhmCEFpg/lRcmLtJg6WESmBv0RDfimlEWx3SYYbu21
         HufEVP0lNpFVBO2QAEOAR1y1MOL84Br0vBI/lNOo9KmwCuRgCYnZzsG2eXSJ50oKTvAV
         eHA5pgcDccN1Vs5gTLAT+oYENpwob0dLuWOoKfa+04UHiY/vNEZICms+jcsSVnp7hqxj
         pEbzO6PMPs7NrW/fYhBfsHaB+Jn3ulXH8j+Aj7I45jjkYdfkgm0ei9YyFNd3JOzuTo22
         ABUg==
X-Forwarded-Encrypted: i=1; AJvYcCV0cpHv8Jb/+Px1mampGsZDDsyil0vvPAZvl3fUxPyz6bFFSzvtW5lyCK04Bm/bX8cfoaSs7wWd0uSX1JM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb4feTEbpgH5qE86/BzzfZcTXW3ET7REjN8UglwCEpyp9R1wR4
	0jAJzMUXY5m89aMMj+BAs9PAxKHtfACabAdyPFdHQBMNMpXnJQdlHCNs5NTSDK7Sg32bKIMfgxR
	Dd8XepkoBWNskZl4nQbDAgugg3OWpMBF4gbG4XR3BMSkUsG7I5Y/NWLQ=
X-Google-Smtp-Source: AGHT+IGy73L+vWVZwSdwyqjH0wowFE8DqdHmgCJRRlhDtScRZ/8AHk/G68GnqvDB47rZRjSRuLeAnzjjBbs5SrYs+07ze2mvwjsD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:3a7:8149:6aa with SMTP id
 e9e14a558f8ab-3a7c55fc480mr76935615ab.24.1732812422060; Thu, 28 Nov 2024
 08:47:02 -0800 (PST)
Date: Thu, 28 Nov 2024 08:47:02 -0800
In-Reply-To: <67483ca4.050a0220.253251.007d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67489e86.050a0220.253251.008a.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_get_scanned_nodes
From: syzbot <syzbot+64e6509c7f777aec3a24@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 50eecc37ec7c9caab87c938b912bb5c686316ea5
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Nov 27 05:29:52 2024 +0000

    bcachefs: struct bkey_validate_context

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a64f78580000
start commit:   f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a64f78580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a64f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=64e6509c7f777aec3a24
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1389ef5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164a8f78580000

Reported-by: syzbot+64e6509c7f777aec3a24@syzkaller.appspotmail.com
Fixes: 50eecc37ec7c ("bcachefs: struct bkey_validate_context")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

