Return-Path: <linux-kernel+bounces-316220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697B96CCC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1138DB2419D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B2413A25B;
	Thu,  5 Sep 2024 02:42:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD48F66
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725504125; cv=none; b=reCatWSL9UH6tFbWSsD8nDiCQvvZMTTF8qAd55Uag40RqoI2uuNjtUfYBJpBFI6jZvwaxW/+UJyx7QScMl2jT/g9Z1Ou3PG7QLSACrph/Rlxl8l78Jk04HV/a5BXYtL3S8+sRwzFXtn4PBGd47QSgIoyUiao788MgjTwV52PjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725504125; c=relaxed/simple;
	bh=z9wdOSa9W/7A+ckON2sUfcBitcKLWVp/2htI49gfHl0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qUK0WNzrs8Bp02ouoeHAhGbYgn4Qe5Vx50IOLjpbeA29dGshOujEkiRy1Ogb5fuCuSPqHwQ1fEBBKSa/k8+lZTm+XBtNOAHI03t97GZfn51S46aCYyM2lYXr0ASyGqHrCgb9rQV6svDde3EOlZxDW51yLcL+8THMeQeoLpBFlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a124bc41aso36075539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 19:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725504122; x=1726108922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9h81xMbplpUiXJ1CtVTecnSoMvutk9dvgJyTXkQb2G8=;
        b=VniV6n3Uiweck4HHsrUUBn3fsHFj+HqvGus+lGkTAoxqqlk+XrSgxsircsmVtOI0eU
         adG32kFPQg3Oy4QT4xHSNi5cVh58CeyFghlyx3Q+wI+eKw3tWII0vn2vFSd51lIPn6CJ
         ZYOh/9suykaUT6mAVVbj/1Ts18oexMLRfZ+zExRRs4zBl2SU1IzcMwjdPgWYm+SIDqDH
         Mo5QL7gblVoB82+7xTuW4tMe+HD8SYmE9ImQfSD9btDGK/v/OjknkNqUG1vJrs86kZtC
         1/ih6YVTDj+pwxAF+xMWv+QxRr9W8XTdlegD9798WiCBMfrUcy7qVQbjEWyTtV4M28o9
         ebZw==
X-Forwarded-Encrypted: i=1; AJvYcCWGyYUtNPX4OT7D2t7XAFA09NydIvUwsrD7+0rERLrAo8UM1DjTzK8+wvUNyAStkkVFLLa26JzzsDdWask=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWInHSzcbpbj6QC97cEkm2PcyPW7zRgRG1SLlkoU+Czf5QnWAK
	5ezyEHUtlfjdsX/PeXpwkmustMyaq1iko8Q1V5kNdelgrN5m6AaV1vr2cAhPRkuYun6SGXHIjr3
	RMkI46gJ1d/Q/N9OFzrgNrbrswyCKWiftAn5uwB/VGXT1vCJKcWvn8mM=
X-Google-Smtp-Source: AGHT+IHuBTd4EKE8UDEyJ0Wz+pcTa5+vU6TMpKx34FkdO16z8Q9Pbmg0Dv0hibKmzirxwA2sxoLOhyPvplR66N4lZcdJ0QduIOew
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8720:b0:4b9:6f13:fb1a with SMTP id
 8926c6da1cb9f-4d05e73844cmr173124173.4.1725504122671; Wed, 04 Sep 2024
 19:42:02 -0700 (PDT)
Date: Wed, 04 Sep 2024 19:42:02 -0700
In-Reply-To: <012b02d0-97ba-4d5a-86cc-2d3d36ed71b1@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a622f0621563c7d@google.com>
Subject: Re: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
From: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/dev-next: failed to run ["git" "fetch" "--force" "3c3147cbfa20ccaaeceb3a944332ec2db65b4a22" "dev-next"]: exit status 128
fatal: couldn't find remote ref dev-next



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c686716759500c2
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc98ed414ae63d1ada2
compiler:       
userspace arch: arm64

Note: no patches were applied.

