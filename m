Return-Path: <linux-kernel+bounces-258979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5310938F67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADBC281F84
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F616D4E0;
	Mon, 22 Jul 2024 12:53:46 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC516D31F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652826; cv=none; b=duPL37rCz8BJhix0uZm0zevDn33wn1Zgbw58Z2PCHie5NdmRLFGrR14BLxdtBZ3zWzsreXGqMj8tEZlB+yq55rTB1uwOG+6zdsbGIYynZbrYA/dng+DvgtlXSk3G8z0siT+MINo7r/rH5nn6HzWBjKYk4pdGDAtugwHErAeGbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652826; c=relaxed/simple;
	bh=6QRl8l32dF99Sbj1Ib3bZ1QfS7bKFy9osRTVqmZapc8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tb3/w1mXQLA+reU0Clg2shbcRWRLeRd18LGTIjwVrblq7h/N9pbZwzhdcZ09E0NRUmbSO8Jml10WvmBoWFeCURrwJ7gAwbs7BosW83juc46iJh9foHAQ8vDFKcASKMOc6yMOXJv4ja5kgQpR8jmj+kdAlv7NycjDaGNt/DL7bxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8048edd8993so706156139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721652824; x=1722257624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QRl8l32dF99Sbj1Ib3bZ1QfS7bKFy9osRTVqmZapc8=;
        b=SWiEUID8UVxerGbrbu1+LYdUywh1kN7LsW+jP1pJGrMv1XAdN3m3ydsrlHbSxZB+Zl
         3Y6oPleEwjnRG7Nqjwd+drg7kXPxFoDUjLyeFsrTInzxf+2weUB3FvKNnaW6FbVMWxMk
         +JZ8q0po0Ur1wfGbT8wdSc0bBsTjOiL5IEcGR/J8jLr2kYB5n0YBHX+KeYJjCS0FPRZM
         IXP4ahJAUS8hSeYF+UMrGC7+EDXWrXnrUU1NeparG/QUvZzboWmaQ5KwBmji0gtfkpo8
         sIrT1Z8p014KR2W6fG34LEPeKPUnrjDab04PhBjr5cYZUdUpd7yXl8kDXu1tO/4MHarE
         jIag==
X-Gm-Message-State: AOJu0YwEAlT42ps3NXKcqtlZqivpXzqhLgiZHivA4VfnB+Ww0/ZYrhpF
	ITdIUIkPEoourULoAz9wAkjf05R9uTHPyw3VLAIGFpji1b0W0hPKTtLboQygl+ChFsrBC4a6mdO
	H15DXOqZQ5Tb4AoN2jIS6/XR1O/gVj9VL2l3aSwLwhhPUC7sBFSMLPX8=
X-Google-Smtp-Source: AGHT+IHqDMELw98SRY0UuKCLlvFlZjqT0Mp9L3E/rCKHCQnSVisegZunRvDiOAo+2wvv7p8y/g5SAPRa771AF5eMdhrlukXCZl93
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8323:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4c23fe4534amr539503173.5.1721652823881; Mon, 22 Jul 2024
 05:53:43 -0700 (PDT)
Date: Mon, 22 Jul 2024 05:53:43 -0700
In-Reply-To: <000000000000e8fcab061d53308f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe90aa061dd5889a@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
From: syzbot <syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

