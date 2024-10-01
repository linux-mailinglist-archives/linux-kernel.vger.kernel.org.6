Return-Path: <linux-kernel+bounces-346750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203B798C84B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2262827A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B91CDA29;
	Tue,  1 Oct 2024 22:35:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650319CC39
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822105; cv=none; b=oI+UYx+PfHNlGmv2TA6N/g3aOzADZgeppM2vTToAilZxhOV5yircBrjwrFRh/bUYzCS1NuLUur6mNfxA3EfdPgf/Wqgox8FvSRxRoHce4WRlEe+WRJsfFuCRArOm6nnwsxUkD3IdxV9xRHz6i6BZOQ8CwrBuEZvwynYkNAlxJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822105; c=relaxed/simple;
	bh=W4i89F2vI33d23ZEV/Q9yilWGTOTS9JRdbiarqOyGLQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mz+K/AfaWGrX0/N+CbsyLV3GWuf6iVEPNmHvVHcQNXagkulAV6kUNpEPnjVio713Kb7Xr23Sdj9wtn4dUYIAPUwnEYpIwm7ojggzTQVBC2XdpNgE2b9o+aRADFz4g5smDKi3saeoOF/L4DplLa2W5lsq1Wgo3fup+bPAyST3Tk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a364ab1eedso7469585ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 15:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727822103; x=1728426903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQFz9EwZUvQdV4W7DBoeXqhN0Z7D67k9T3Y8GPkCTIE=;
        b=b1/9f0Vt9AxVi91n/2+HT2P+OyDt3LRxDx4y7vB408ha55FUGoLHN8ztE1JUcXOQHb
         ldmYaNqvRyPUtqGuGB1X+RlQ3sCi2wKiKavV6GUnzX6m2qKnCld2QqLDYNc/WnaW/IKn
         hHwbIzDNXq80vpgztv9OhKKDfvoM7QP3F52Tr5J1CQx7dg1idfp4y2NQXA8htMOs7ua3
         FAKhMtmx1MG2z5hoH8PN0CUrHrbuuhv2eXd4S7jfff59E7BVnLZJ2RmaVS61myoavfu2
         e3/E434D0V675jqc75S2jI6P/JxFPPp79OnTpb6DETx1dXfZa1NWpzvzaFfXk/AHYy+M
         WFLQ==
X-Gm-Message-State: AOJu0YzKde1o3aymqI4ug+P2uhd43pkInIYl8qYD4XXdDscT2PUM26tj
	iSe5EirhxDznSd3cNOaxZAyuBsiEas4NlGVux7Q2XXYKNK1S5fXvf7i6WsE9x5TYEBj58Si5NRi
	Ksi8XKGK/3ekMu4p/zYOmfbKYUm1bRQB1kz8vHrljTiShGTsvcLRhwTY=
X-Google-Smtp-Source: AGHT+IHr5hpxacS6TW6BvAgavNNLq4cr6wx33GwAuWCtxqcqYO0kcsAkYo9PJYM8G8MXa8lyssznysFp4nLl20Z4aqO8BIvcC7fZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:3a3:4175:79d2 with SMTP id
 e9e14a558f8ab-3a365943070mr10332715ab.14.1727822103486; Tue, 01 Oct 2024
 15:35:03 -0700 (PDT)
Date: Tue, 01 Oct 2024 15:35:03 -0700
In-Reply-To: <CAHiZj8gaK1pvOZzxndtb8KTCMoj=UczhHv6_f6ogbMtOU7HdPQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc7917.050a0220.f28ec.04d9.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/hfs/extent.c
patch: **** unexpected end of file in patch



Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=85d8f50d88ddf2a
dashboard link: https://syzkaller.appspot.com/bug?extid=d395b0c369e492a17530
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150f0307980000


