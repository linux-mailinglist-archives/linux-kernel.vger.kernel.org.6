Return-Path: <linux-kernel+bounces-229441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11708916FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F642B22697
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DB8177991;
	Tue, 25 Jun 2024 17:57:40 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E27176223
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338259; cv=none; b=DrzQEIRtBg53oBtBwAS33cK83ZiKPdrvMjyMzWrwgDTqkRzXmAPryl7vJzvSB19rArZIFS+y7xUjIAcLPUByHhq5UwwbKgb9mtJFDJIpL1a4vjHWPp93FEtfOLxWvSf4WHDCNUyz1lregdhh2lTIgcdIHiLRDp7EGlG2e5VIz7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338259; c=relaxed/simple;
	bh=Del3kJrrhiF5RPoGSTNKjceWejcbVGzICaYyMUqPbIQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T+nVnDgOrnzSlrpZHFT+0f7OYsCnWVlvMKsAU0B8IqtkFQVpmgjh+rsTYrazc+U3AnwFO9axnDOkpUOvSw5v22TK2znsLrltGxavrOYg9/zu6VMlDINe4DDI+TLMnzliRhRnBSMQtuhcPSRHkJtx7PtTZoGCc0FJJf0l1Bk+qpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3737b3ee909so82686155ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719338257; x=1719943057;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Del3kJrrhiF5RPoGSTNKjceWejcbVGzICaYyMUqPbIQ=;
        b=O7J9ck2BEN4zd7hOfTkSMxksyVRUV4neMC0vYfmA4MWetYGhvrTo+9uxFq24GjU6qd
         f5+MCZ9clLb9LYu0ieyr19o6b2Is76lUQQfzg/rIbxWYlN9n6oLqdK5XFVUgl8EwD4CS
         wZiv2ojAdqz1Nu8gsGwVLxNLOga8xg83/tyNvNtRpQNYFXZNyjmiSGYSttdM8a/OxLgU
         EtFvlUlBRtfg3DJGiZr9q+ghfP6GJ0+EvXz5OJNOEhh6y/xDS1AB6VpxCg1BI2DK0sb2
         UjJzGEdzzzj/S2DSilME5NIZ7tkibEx6ushTT//jucgyQvcV4ssHpGZvqGVRenWEHbkj
         LL4A==
X-Gm-Message-State: AOJu0YyNmr9BLBb6I28KskDC9bpgwCA/B0b8Lf4S1ItDv+gT/UJkSWPv
	W42RjYdn0fZBYize6bgfJFq3H4Ml/lw1wll9xSLYAdUhPWgGOExtPpua6+LWNDzNhrzm/gIFZgy
	kTREJTjLQZmQHgHibs5sLApNaDdGIFt+F0QiU1cbakwMIWsVEeabsojM=
X-Google-Smtp-Source: AGHT+IFSCPgyXa4m00532c1y78ENcogEXmtj+amN1s7OY+/UemFCTaNcSHcxH6Ba6kRKlzhCHNEtzFKWprvhAapV1N5WZFMiaOEv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180e:b0:375:88ec:810d with SMTP id
 e9e14a558f8ab-3763b3695demr7091075ab.5.1719338257621; Tue, 25 Jun 2024
 10:57:37 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:57:37 -0700
In-Reply-To: <000000000000b2c201061bba0374@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000183670061bbaa282@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in bch2_blacklist_entries_gc
From: syzbot <syzbot+835d255ad6bc7f29ee12@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: UBSAN: shift-out-of-bounds in bch2_blacklist_entries_gc
Author: peili.dev@gmail.com

#syz test

