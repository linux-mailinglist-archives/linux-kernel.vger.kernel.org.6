Return-Path: <linux-kernel+bounces-327649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73119778C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECEC1C24432
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0061AD26C;
	Fri, 13 Sep 2024 06:24:40 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181D913D296
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208680; cv=none; b=VluDeF1ERQCybcK1dQaOSLM4NcrhJurN5ciqI0+7ial33Zi0qvUQ4osDQVgPp7xkV4/iwnOU0NPDwe0sAWdfCVppLp8nXqPrpFxgqM/4hB1VI4tanwgStytKnE2d+1xftRftzIMpxqC8rEqER2bAenwh1ldjWw1L1D2jeN6I6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208680; c=relaxed/simple;
	bh=vxxTghY7mDQbYyK/BVb+4L4D0hdpScAiZ/q2HLx9J2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AY7SZMTQHuiqpcgGl6VBaCjMiSeEHQsNrg4anwKmf12HI4vMp6ICkimNpa+nyTPP7fEmiZh18j0FuSutAr3IpA2HMhkZSr99slIRGCm/vll0qFOd0ooYPxcI491HZZAN6wVbWalkxH+oWj842R3cz+LDll3CBFZwfepRKmwh08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04af50632so21365085ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726208678; x=1726813478;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxxTghY7mDQbYyK/BVb+4L4D0hdpScAiZ/q2HLx9J2I=;
        b=RzWAKdzgxeELke4jcpP4F3HnxfZU9J5LZ+Vstfzil86GlNZ85Dg0/gnZKq36sGjc1t
         VmX2WTPJ94eDF9IHPNZseFMhe9rJGzjKVS7IdzKo+Io3Q95tOm6w1VCKJFJq165rjM75
         V0G7qmyQvvEad0zTw+2w+TCUWNcXdjBQZh6dgHdTtMKIKn4U2ZFGmw+J2bhZBTp35iYb
         yWjsAHz0tRR3NuEhSrT0UkvHbXWu+6Gbtg2bfj5prM5A64OgCBgM4IavSxc2aiKHu0zB
         wmZUylwNwx42BK6H+RMQ6AeUK5UJG2r2G/LWw4kWBJ5YXHiin33QUOC4CujYB1PJzMaR
         rtjg==
X-Gm-Message-State: AOJu0Yy4SayTzUPRAsRIjkf8FuQEJHULEMA53xpR3gezo8yeavIEb5Tk
	SPiP7hMcvuHUdLRBHG+0QPdeaKAMICtHqphuk3O2wC5E1pwvbbxQ+maaiP7q60GlDbJrZ18+v3I
	dl6DWe3sgmHr7POB25knSHF/DXdYvkZ2erXVAtoBwnc88PBUFyXjK8H8=
X-Google-Smtp-Source: AGHT+IFxQNeW3AuxM4GEhJwfcgP2yNnWKhB62Eav/Ej3GlQKA47ucAWK2mUds309910vU6evIJT/dk/N/eiNc4HJTl0uIrB+Km5E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:3a0:4250:165f with SMTP id
 e9e14a558f8ab-3a0847d0c17mr56516045ab.0.1726208678239; Thu, 12 Sep 2024
 23:24:38 -0700 (PDT)
Date: Thu, 12 Sep 2024 23:24:38 -0700
In-Reply-To: <00000000000097e14f0621951335@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000132e600621fa47bd@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in sw842_compress
From: syzbot <syzbot+17cae3c0a5b0acdc327d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KMSAN: uninit-value in sw842_compress
Author: ksjoe30@gmail.com

#syz test

