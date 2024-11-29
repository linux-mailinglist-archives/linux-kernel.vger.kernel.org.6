Return-Path: <linux-kernel+bounces-425156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C49DBE43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E13282370
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E17A933;
	Fri, 29 Nov 2024 00:39:40 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084E211C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732840779; cv=none; b=sruKueAEZFdjaGnYC5yqZl8+OYHAMrzu8I3fVqKxvJaCb6095Djt3iLejeBOFAvGaPgyjmplXYZwe1SHZdavTUowB1I/JQTjXLOXxtz1fmSVdzs0/quw5/UvGu11xBhb7aFcOmI3cl7uTy+htw9vcyH2zq0Pumbc2ZYRuD/pZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732840779; c=relaxed/simple;
	bh=gssWQA/uYQApVQXEj9okVJ3Mxd33jmzIz9hOIEWyRmY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nj2xlwpfyP1rXPxTN2ydohPSmYkZ3Zo6crfry6b5avj3+1K1dfHZl/wdTIB5iTwUQ35qz4N4hxS8sZZDsWEPQqBi1dZaOxSUPfjSrYoQRm7a2cbCNclhis5VUv6EVJUx85kTTaJI+6wt1qdAgtiF5dL5NY7KOXVc5G7On225zaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so14988275ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732840777; x=1733445577;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OAdMefHFHqQi/VAPJLJkysMsynm/0/xYy3jYIDSozo=;
        b=qRiP3tgiYBwCXviBRtbVbdhonA0kUVK1IpNBGSPWYnRsay/prXmLRncmvultNSZs4E
         4Uc8islfb+pg83TgeCoSXmYvR/RvQmnW2vbYd7H8/UhSYStFmjZjSueQCoiARR4s3dNi
         WfU6sig8Ia8gMP1MzY1p7gFPPGDHLN51RmuAj2Sp/BLcWqL9nrq9EviYicYabKhYLsf/
         vVZ899IzKdT0EeivfDoUzNfFUak9TxE7wRQIeh7X2EwqPeQq8qu/m4/j2VlTNAmRyPjw
         dLfKKhvqcVuRT3MpPEculEP3LHbQQoyjGjFzF0WuJFHYsydZ6c9EDcgY5QjkbgG2RLjQ
         1E/Q==
X-Gm-Message-State: AOJu0YwXqDaztVOznrgayieYKUqozTR1jj2zahxoOqA5jm/ofrURG5YV
	c7hnEVddJHNOF+LiEIoQQ0Sei8vfJRWSXPposl3geGG16o049RunFlZVMYpB9MNDy3BpvM6ax0v
	AwTlHa7NhTPiwLcvw9Up4Lsg3JiuG0WLLqo1gCCPMX86gAKsIzFW9IFM=
X-Google-Smtp-Source: AGHT+IG4yWM8IHxJ2E7rjAo5tWZo87S5N3CcsZiVxXBFBkQ6SdYqNpr+xmhDhm6uk4DugfxOeNOxP8kXL9WiJKMkCJzNYC+8AcOd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a21:b0:3a7:9801:9d11 with SMTP id
 e9e14a558f8ab-3a7c55f26aemr75003665ab.22.1732840777590; Thu, 28 Nov 2024
 16:39:37 -0800 (PST)
Date: Thu, 28 Nov 2024 16:39:37 -0800
In-Reply-To: <67447614.050a0220.1cc393.007f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67490d49.050a0220.253251.009c.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+bd56952613b5dae47ca4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Kill bch2_get_next_backpointer()

