Return-Path: <linux-kernel+bounces-329794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7EF979616
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797F6B223FA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF271C8FC6;
	Sun, 15 Sep 2024 09:13:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70081C5781
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391585; cv=none; b=DSKbOSLVpcWMGLiLkMpcNBOEokBdkjapET20sz60va62WzXGolnPphOAEC/mzGcSjKWTAtefkDgWUo+oY/RazTKT4xXyYo4ZKH3lylzNgsn/WtSESonfSx4TnyBvV5j65suPTv/cQSVfmqWARWYirgtfQrUcDunTuHMUGA9ZI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391585; c=relaxed/simple;
	bh=obcogjNcsqjeuEQcVMzw3nQV5MzC37SJTeEb1i3ZsA4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sSEesckqiU0PYTBoUrzvvrsmr02d2CK0wJXdDZLQfAP8hG8Ai6HlgvtJWXv8kWz5J9fgFN+Bohm6kG5kkRN3wp7XQ/YeDtiIOC7MCSlLYSbqnIhSnJC9SgTfv0g7XKYa82GrLRKo/Lvs8lnaciIrv7V5SRX3TtoNpUURoSyIsWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d28a70743so67837975ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 02:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726391583; x=1726996383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nX/PHEcxAF6yOVeouz2VAmJYKjpm4n2mEyY9/W9VhY=;
        b=rIY/ZyuRIMvKhqbZkFyBkQGDqLaMDzUE4wh8bRzPf7Ti1bqc9u9xPzlOtWykCR/x6V
         ofHkLbarqOfvPuhw/PTtmoJMxncGvfd+Wyf3nsG/rQtsLWEP+SUb27oFULWmJsLwLFw5
         BgxTEJ61Ev1s+mPLhwTNb1805MiYc/TeXzl/kB8mvaOxtu7tqSm9RUj8JU3dqM0jHMce
         Rnd/ctFqCMs5Bc0ft6W/AJDILqV9fh2rmN/Xig5Ywun+KGhOJBc245N3Dq4SZmtB/XY0
         4n2uKMnYfhiwbTVsQ8DcluCvfayOX2Kq72wQq1NHC5F1pgROEoisSm1eQMGy3BATlYWX
         AUgg==
X-Forwarded-Encrypted: i=1; AJvYcCVXH9L0cjVeFmaojP63m5mZB1yJId8gr1cF29L3rL//iJuVeXTkZngC8P0AK/cSAmK+Gx3xnNE7OwJeBsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVDCx8iVTU5HyGfJZH3Zub3EBr8dd1m2381Ft/JOSpU2eyHT7
	d5t1AgUQ/tjLfwswzEeTGyDoW5utWPpl1N3C98tMN+ZCejmNYh3T0HpupwUO3RVQYPD7Y98rMGb
	k1bZ1tKfqgyyUaJ2vGGFboqV40uF6mA4KPKS/uj6XhW40CAqtWclQuI0=
X-Google-Smtp-Source: AGHT+IFkt6/rWrHU6SRdfTGZ5jbGwpASvKEEgPHh+DkBFDbmyxA/gLNYFAbBOUjMGepbj9wDL7QqYIFfGK1xvLBqZIpnKheRIyv/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:398:a9b3:d6b1 with SMTP id
 e9e14a558f8ab-3a08464e152mr107788645ab.12.1726391582997; Sun, 15 Sep 2024
 02:13:02 -0700 (PDT)
Date: Sun, 15 Sep 2024 02:13:02 -0700
In-Reply-To: <000000000000ac4a9d062044e498@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c5506062224dd83@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_reserve_local_alloc_bits
From: syzbot <syzbot+843fa26882088a9ee7e3@syzkaller.appspotmail.com>
To: elic@nvidia.com, jasowang@redhat.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mst@redhat.com, ocfs2-devel@lists.linux.dev, ocfs2-devel@oss.oracle.com, 
	parav@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174bbc77980000
start commit:   0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14cbbc77980000
console output: https://syzkaller.appspot.com/x/log.txt?x=10cbbc77980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=843fa26882088a9ee7e3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129a6407980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167617c7980000

Reported-by: syzbot+843fa26882088a9ee7e3@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

