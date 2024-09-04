Return-Path: <linux-kernel+bounces-314064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A396AE79
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90065B213A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B268E2575F;
	Wed,  4 Sep 2024 02:12:52 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB157E6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725415972; cv=none; b=Q1oaPwTCMG2PA6WuImwkuPx0gU6OEPHEvHw8YhWMYbu/4iKHYz2fI91ePJJKRJ/D5FM+N4r25xzH/x3pEO1qO/3kJ6ob6qdi4ooJqy/NfXLBlDP2wrSZXeG/mMg0gkemNe0IxBM4whlXCamSxAzq5MXdECRFxDUfwyzaRSkE7y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725415972; c=relaxed/simple;
	bh=IKbOGmclXnYBKQhqx/oVMjijcbFqEqTA53YzlA8Tivc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YA/Ak/CUXHrOpnaUYUTUqqs1VBUdvsH0a3UmdK6hh1xQ3PP6NhT2+4Ts7Yg21bKItzpiZhWWXFX/IwKeTxPZTsbrz2e3eg3oOqGiKNlN1jPOkFxQ2pf2zbKCIjcEeK2CiNTz672OPpfaVCrEnK2zPXKpwE/UbWk74Zh8tpS/SSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a2058047eso728375139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725415970; x=1726020770;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKbOGmclXnYBKQhqx/oVMjijcbFqEqTA53YzlA8Tivc=;
        b=aybO3A1dGtS0KIPdINYmHu7ggobf7W+AO2cj2sT/Rj1eQuYvMQ2BLz2lyMbTgIxwyx
         OzDtSyRU8awlQdgraiVDYUW8n+JXISRJ9D9HvTVBwO9rmSgk5i1ZP/TFFsL62taZ5oiI
         BZyV2G8z0n5fNbBsjbkWjFz0wCjD72nClsTaRHPLl/8vnLQOWRboMMS8eZLw8+I4zeeB
         1tFjEEKCRklzVa1Bzr4i6bMQT9xaGSNc+hKudV7sQtyG9C27ac5MsFa6e+lpj+io3XVv
         E7ZanB5wK85tL0n6JBc9aMk6jz8CzpEjLkPnjmmIuX1pwtn2ufKV4IQ3IlkvomSHjtEe
         jiWw==
X-Gm-Message-State: AOJu0YxjVZ8sDHeogzrg57X43oRPuUOiEAHSe9ZQD47IrfbY1RlfZHUC
	ediQs4vAdoL1T2eghLV9TfPHkXjc1+204BRMuQLWMX0gGfstCdUj1p/g72vzbB05iCuSmEySsIP
	P2C9VlMT2j8qMck93ihVoFCFGryYQv+/8oUilyV+TfSRYiVX6HqIgCa4=
X-Google-Smtp-Source: AGHT+IGauNb47V1l1BPwiYtLTcpeZhGWGw5N6yqJnjqleG1J+x0twEAEjn5f0v66b99o+CvKskWtMWqdU4dx/aqV11wqbKvu5kBj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a47:b0:39f:6eac:92a5 with SMTP id
 e9e14a558f8ab-39f6eac93b7mr2352965ab.5.1725415970149; Tue, 03 Sep 2024
 19:12:50 -0700 (PDT)
Date: Tue, 03 Sep 2024 19:12:50 -0700
In-Reply-To: <0000000000001b6052062139be1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdab02062141b5f6@google.com>
Subject: Re: [syzbot] [syzbot] [btrfs?] general protection fault in btrfs_root_node
From: syzbot <syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [btrfs?] general protection fault in btrfs_root_node
Author: ghanshyam1898@gmail.com

Added a check for the nullability of the extent_root variable.

I am not sure what error code I should return when the variable is
null. Can someone help me with this? Thank you very much.

#syz test

