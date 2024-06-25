Return-Path: <linux-kernel+bounces-229589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A568491711E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84841C217DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A917C7DB;
	Tue, 25 Jun 2024 19:31:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5A1870
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719343892; cv=none; b=dNK4zaldANAPpjgYdNhmkxntwYqqY/JIhOVx9guGC4Sn0E9Gcf5GL3xVFowvGkxw1J2V9fJ3eEHC7CfNsNAW0i6Wf0FQ6m4qJ1/Y3fDVJUnFi8yvvQrqdyk7ozUmCTC0y3XnOjnNbZfMI6aAXmwx3LDovHJIwduq1gCbTp+47hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719343892; c=relaxed/simple;
	bh=Xg3dM9TrPV/JvIttR8XcOQKI9Q0JfbjJOvYDcS+KHbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jDyeOu9QHskufrGT7sIxcvI2KX5wo+p1v9RadKAzJ2fodZrCLvF2A7wxl5tjcYqEVxBgDNT4cp2EKA6FX5XShbYF4bYW2IlCyagWVc5VKEQpGtf17Uf9hu3eNYS4CeGdWFWy71xZEr9qstc0FJZRuwuBXDjFVmSSOTNSRFYt3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eee4ffd19eso828522939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719343890; x=1719948690;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xg3dM9TrPV/JvIttR8XcOQKI9Q0JfbjJOvYDcS+KHbI=;
        b=xGP6NRnbCFa14j522I0mqHO1IKnTI9xjmdtpxAoBLUZJVPcBL6i1yv0TgoHKuS24QU
         6KB0cpfWhZQoGi2I62k0F9mUAAwHX0k/sE8ZW+JY2TBtNK6R5ZgQtgcGr9PQal3c1mrR
         wp+kwM0aWcCuMnRnSknK8yC9nWZU2E+fR9HpO2M+vgCLz2v8moI8fdKyYshSxdh80RuD
         WxYT7FT4lFceefWAoIqcum5AHcuvastPGEFTQazNiJ7dH6cB5oTspmkuGWbHygzoVimP
         fK8Jf2br9jztorNcLfEF/6VS/CBeDGzJ4QYbM6V/i9reoI/5hrFCBGJnB55+D5Z16dFO
         mNzg==
X-Gm-Message-State: AOJu0YyaKF0wbtMQa3aU6f4vJUlyqrqSN8RkXxsdIjzVIamfh9OnjXw0
	mJU2bGnEOmgecp4QDhIv/SuyWlChNZQjkjF5LbPRlE6IjBjyoeijcK8uMoZ1bFcO1KZrijsGoBj
	mrJ94qBLwsnhjxbUv9I+VebBdrJgFGHgmpq5c5n6LMExFXo/cJcjU8yo=
X-Google-Smtp-Source: AGHT+IG/5a8ghplbXL1xiR/RLhFIExs4mofv+abN+ajqQYxzDwNtrdTdxs1USytgulRdLMW48Of661CdpiqsEekuOFjWxvXHLv8D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2190:b0:375:e04f:55d0 with SMTP id
 e9e14a558f8ab-3763b0b6d82mr7931185ab.2.1719343890214; Tue, 25 Jun 2024
 12:31:30 -0700 (PDT)
Date: Tue, 25 Jun 2024 12:31:30 -0700
In-Reply-To: <000000000000b5c648061bba03cd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2c5f6061bbbf1f7@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in bch2_sb_errors_from_cpu
From: syzbot <syzbot+a2bc0e838efd7663f4d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: slab-use-after-free Read in bch2_sb_errors_from_cpu
Author: peili.dev@gmail.com

#syz test

