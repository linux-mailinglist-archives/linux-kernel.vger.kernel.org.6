Return-Path: <linux-kernel+bounces-282482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6594E492
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2BF1C2134F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE849659;
	Mon, 12 Aug 2024 01:46:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ACFD272
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723427169; cv=none; b=h9cxVNqbwKNw0qyEu2I/zcXueaxNLr/f9S7YuUQg67+Uueu3a/5QK68XdA9tOY2hm8Zp73QTLHQaVqxeqRzB/FF9fOgI1I6Gd+KiZeus0eID16Xgqu7OzQXizhpjMQWv+1wJ79A5dQjDwn3xys92ehczK+IO687IpElAdQbMmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723427169; c=relaxed/simple;
	bh=o8vgi5BsARnN6+/V4qLRsIGTUZjuPZEyjaHqvtqa7p4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CUDcF+O3+4PBeytvsZKfHQqQjFhnErra0Xiao5Oz3aq/x6MwZy0Z0hObIJ+Hu4zdlcBzeqyjzO3/i27bi6eI6Och1eO+3bJ5SvOA9ACiv9HG859YQ3wS7Ihtv4V01U2hFL9QRx66tP7W3rFtlUhF4gnncBcBU72+hyo0DPGvs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fa12a11b7so494820839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723427167; x=1724031967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8vgi5BsARnN6+/V4qLRsIGTUZjuPZEyjaHqvtqa7p4=;
        b=BhVcerrSaH+pU2JyqJp79sCI4nqdG+nByo7phlbQ8s5e6LIVd2D8kVOeT9UAW8Pnx1
         1Ye03fKCwn9mQ7RfxhEy0O/pzMmli2BcozX2DXQ0MdWnPldry58axOkppVq+nTO7UeRP
         snUFfsA3Gsr9ZqT88615a58Sxua6RWCzFrgCZ4RcdUmEvnmsFyiO2Mfq1kKxXl8o3TlB
         KI5OZR/vZblBF3oWsngX5W2diyXF8Jn+/8J2+wrggBBMBeYJLFzdhDRV4lRCkAH4DPb0
         41gGSJH9epo6XVkRkJiA1zkEZeoOA2jsbZ6zantI4F+2TB778CW6PG45AaJqfT3q1nej
         lBPg==
X-Gm-Message-State: AOJu0YxXWVQeTq5raJETvguysHt6gIrJrVbios7/WUQmF6bMj146dvN+
	0Ncz2wfCzvw/lcL+OBVHH43kOJ22kFBpONZ/8sM9nkrah1qDLQX7TBWLRQwGpEGg0MPj/1gylNG
	1+2VOv3qSosFsQJZg2ek4qz+/2mwumMmq8YtweGBu38HzaScKVeCKk2w=
X-Google-Smtp-Source: AGHT+IGe71JJCMKjSmjWaXAWgKF1vT9AwQtB3Rh+b7eGy2W7Qn5N/ufqhLdDIV9CJeH9SQTqd2drW0irZaE0E5U6e8toaKVPuWlu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1787:b0:39a:eb81:ffa8 with SMTP id
 e9e14a558f8ab-39b81342950mr8603275ab.6.1723427167636; Sun, 11 Aug 2024
 18:46:07 -0700 (PDT)
Date: Sun, 11 Aug 2024 18:46:07 -0700
In-Reply-To: <0000000000005f5a6d061f43aabe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fa085061f72a8fe@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [virt?] BUG: stack guard page was
 hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
Author: xiyou.wangcong@gmail.com

#syz test

