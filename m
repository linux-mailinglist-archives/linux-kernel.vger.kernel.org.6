Return-Path: <linux-kernel+bounces-418989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7530A9D6819
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74122B21FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D31662E7;
	Sat, 23 Nov 2024 07:53:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63417C2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732348385; cv=none; b=gwmsOjwzLLwnUPGKYyDrioMpqnzD0XmNWABzSF9Pl1r+XomeWqqOAtg9j+O1sWL0xCR4yBXUWoksdwP1hmBer8sl/uvZs+1jNZUZvjn9et5RQ5Gn2vOY4TTgGK9zsfEjk0qN5P9+l/nVpuPr4LtBx+xRGFeBBO+xbgnQPMthWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732348385; c=relaxed/simple;
	bh=CG11Mx8KJkmxhvRSr96DMSc5GR6zw2edXVk/mbwpfAQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d1cDH0jYQ3hnzwzsPLJwfpjDtXcOzHW1v1NKg/87WEY7amyJhRxTiWwvMtPGS/p1211w0dnUC1AeN49xw59WZg8cYimdzfMY/c1IviMPA3kQcupKgRtMUf5Wx8pKfi6b4HYMfoG2V0rdkaS5Xg8bufbM20ewejy0PTnsUmEthh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7807feadfso29723475ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 23:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732348383; x=1732953183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fia97Z7ySxbHcy6nJJ1KE40vgds2YxCSDRL+lj8H8Fk=;
        b=g/MMpL3i6K8LzkLddm0Gw8UTVivU3zVzrBm4hIMTKy/E9VtElORZHpdMfOM9atkAXK
         pdi7E509N3zQW4Fbmxr6bMuG/N9x6eVLmh3IYKrSBjM4DqFcjpJHp40cyYnRvErZK1yp
         dVuiG+H+qTglww6OU6kt3PTiBfYEWAn6wN/PLQ7aWtkVXX2UkDhq4RLit4mR5dT2Hrbd
         HtSPSvqDRVSvJhku8LXdde8jUn2gLw9UCCL3HBo8YQjym0htVis1U+oulikZg5ji56fe
         MFNlRGon1XhAhrPuLnYs4HhNM6ZcP+ILaHEMxAj1m9nzVhUlkHffvo24YcntjR+Ww48L
         1aHg==
X-Forwarded-Encrypted: i=1; AJvYcCX8OWDa1d01AB4YtNvsc3sjC3miyuSiTPAKqkbkhHZ9ZNzpJ0AiBGOHfLQwEy/Bogl6VWmCjVYd/y57K3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rT/jZHosj4ei+snKvDCmb7T5sklEhyyOqlK3thKR9cOPFODK
	TkW47XGTGniJrvSMX9c9rntFtn42SuU0UlVsPZNFHW0uHApPWh6IVzQh2x+u4XIX+By4DR4csHY
	Wu6P1PMqxTpm714gL9K/RlY81H3/oOsC79Oc9pEoO+qzLQ85tHrHvEe0=
X-Google-Smtp-Source: AGHT+IEqxcV6I3j/RJyVchz+nWxacuko23+9Krqko8Becp3DyMBhhDMdcGPIwWeqsAQCL/0jU1lF4+Up42cGWOWwnkmEUbugNsA6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c9:b0:3a7:8040:5962 with SMTP id
 e9e14a558f8ab-3a79ab8148bmr74494225ab.0.1732348382981; Fri, 22 Nov 2024
 23:53:02 -0800 (PST)
Date: Fri, 22 Nov 2024 23:53:02 -0800
In-Reply-To: <CAHiZj8hcN-OVsfB9f1fx_bTX561j_Af2rW4L3e0+hM9kptN3Yg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674189de.050a0220.1cc393.0002.GAE@google.com>
Subject: Re: [syzbot] [iommu?] WARNING in iommufd_device_unbind
From: syzbot <syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com>
To: iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com
Tested-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com

Tested on:

commit:         228a1157 Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f5bb78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1350975f980000

Note: testing is done by a robot and is best-effort only.

