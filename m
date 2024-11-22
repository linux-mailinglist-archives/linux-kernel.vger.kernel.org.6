Return-Path: <linux-kernel+bounces-418170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054299D5DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD7F28538A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36E1DED45;
	Fri, 22 Nov 2024 11:21:51 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706361DE4EE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274510; cv=none; b=EJwPZyBawIrAb6vhVLQGJ9gcgXWoFiQoHoHkU0K1mZm/H4jwSt1P55akmYzRUcK7bVdplRXJkuVf/9ZwKzmX4iG0b+gMNG6RlzhTWe1OTyS8H/Xf/7/hm124W0al1IG1MpJjZalJJ/HJ5wBe3UefkU4RCgTm9Ak9JvakZmFnK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274510; c=relaxed/simple;
	bh=PbGAKLlmMVz7P8tT+j6d/x6LQUshLJlQN6AwuQe/8k8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JmS/B2MtKt8z6e00tAWF4YttcznIb2vsCtRFw+H/dQQLo/Jf9DxWiX+EOzsUHzOOnE+WsfDyEwqm7l91XxOeSZGzUMS63jzhhuNpiYfT+33PcNRiPaegnAFRJ3qvxRgKzKO2PotJdHnCBvuIlIADHx6WuJOpr/rPZ1wbPzTz78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abb164a4fso205601539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732274508; x=1732879308;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbGAKLlmMVz7P8tT+j6d/x6LQUshLJlQN6AwuQe/8k8=;
        b=a3oQAhBLARhGD+guKFXER9itI0hkjxa5HcEfa4ByfZGyDqtPdAzh7UASuiAeTO4nwE
         ZzQeyem5XZJ5vwG6Q/piJi+16xT+EBXE4s9gJWjLi5cSeCE7JcpZvzTlfVXne+boFTTw
         fpi5+KgdzdFaJcYshHOJN7/WT1DgxNZcbM3FG0zqYlEj3n+tCS7ANjzdWj3IujVuMa1U
         I2VHuiXMM+xY7F6csnMa5G0tOsDW3iJNkn3Oh6m87Z9zeDH5G8qguk9QAo+/zA/uvu9m
         6EENvPvmkmuMWPho0lRxIWvL3X2yXsqbYX2oibDkJl7Yu2oK+oWdXeXCQKVuG0+Z7J6P
         y/lg==
X-Gm-Message-State: AOJu0YxT9Wsc3n9131Wt1I1bBDwE0zFe3+PpKOa4KIcGioLstXvhJhKF
	o1yPK1IfWpDFCotfC3Bnm4U6pa74sBB/albGkb1uLRgmAqRh+FJWlQV3gkopa7GK5/NU83n5AWO
	+fGlG1vu5CMDrluGqPsHx7YjP6JOBaVw2t6/ekSX2W36kt6M7vfW89r0=
X-Google-Smtp-Source: AGHT+IGctHz8y1zppOMSLdq5gdaMAlm51ZLfPrn3Bd3VJ7WO7SgkOq87BfCmg7oy0jhQwXms9wVpm723bbMJAAjuiexq4LQtD8ui
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3a79afd9ab5mr30083845ab.24.1732274508658; Fri, 22 Nov 2024
 03:21:48 -0800 (PST)
Date: Fri, 22 Nov 2024 03:21:48 -0800
In-Reply-To: <673f39b0.050a0220.363a1b.0126.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740694c.050a0220.363a1b.0137.GAE@google.com>
Subject: Re: [syzbot] correct the fix commit
From: syzbot <syzbot+0058f72ff908dfa2dbf5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: correct the fix commit
Author: nogikh@google.com


#syz fix: PCI/pwrctl: Create pwrctl device only if at least one power supply is present

