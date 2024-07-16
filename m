Return-Path: <linux-kernel+bounces-253438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C193215A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BD42822AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0243AC4;
	Tue, 16 Jul 2024 07:38:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238E4436B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115502; cv=none; b=YU9NYzrvkTt5LlfxL3OwNG7Oy7yXxR68E/UmL6rHfncgjss5ggIaerCElJSNptcAdqDjokRXmqI6G6CbrBEGISBxxLYCgUfmqOI0BFiX/J8YJbi8H7HXrHo1oDaIBFvwG62YuK+LHnz0y6Yn14nbTGQrzLHPaMcOMA5n7cvGpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115502; c=relaxed/simple;
	bh=3wTpPa1DkRIEd6o041BTlvCoxXeepkGmn2dyuDs6Jck=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ltyEqUEY/BN5ncRjC0S3DCfkJH+trXFTYiZKY2x3cW26oplOv+iVaXXzlMuaPd92gcInMg/hnaLtJzI6/kuSo2DyaoRmvW0aJ0AjAQ4CCWzF3XW2EQSJu35hc//CnGgvETsvrcnp5oEjNOUUOEijBkRD9YqM1VXc8cmMHoWYFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375e4d55457so57039155ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721115500; x=1721720300;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdLGOSEceOQNovV+JdJmxiXAfysoVI7+8Rd+baOpbP4=;
        b=Lc6eQ0GuwTGSoA/SNVLUxCtaX0xFupRoZOjX3jYnJpVthUOIUSqYAqiWrwMp+MknXy
         s3u9JeXPKkIMmKG/RkNSPD9+3uXGqTXnSMuyja1KpdGoNZabiyPgkovcEVtDjY3O02Gu
         /yLDWSef4ayL9IpSohPk/pf6r7rEu5Ql237kLXMgVQtzCxFlk0dxSVVj5KuSKEmLZMoE
         zA5Dhaf/sVEq/FnxT/2ot2+a5BUZt4XjsgfR9lDsWXriAdWXjKmTAA0WOQtmWPWyGKge
         4XQmkPJyHQ3lfAJ6BQCQDPhaWgOIjs96vGsIdTTelGNX7PNhYbc4NY6PKEmn34K0VkQq
         xatw==
X-Forwarded-Encrypted: i=1; AJvYcCV6VhnDu6q8AfMdhX/K8GQFoYmSsIzcQXdrQtjTbO0Z7EhQNyAxIp17IMHDUsSOPWmjvDAmGmFkeO4Z/kTxiS47Zohy2VQv02CcxtR1
X-Gm-Message-State: AOJu0YzbXhGIFmxMv9hHpbpWbz9fBiPGOQ7xKoAiAvFDUfNAMqVWcw6h
	zDHiayJnJu/Ecd7wh+rFzFICM7ptF2iKV8ray/MubEuEOQdZzjsFhW10CSrLTHjCxxHYLeZPOW1
	OvzDjQ0mXa3A6idvhiz642NbXw1D45dmQCFbRzngMg3+ycWMfxlPMVTU=
X-Google-Smtp-Source: AGHT+IG4j1+PKw/NLIzGgtz75Fretlw1fCOMn+jUHs7hSBg12YJF8nMjZQpxQHUWoTvk7vLk8oIBNc8Cf4X8c3bf17tCNHNTwuLr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:380:9233:96e6 with SMTP id
 e9e14a558f8ab-393d394b3f3mr1205085ab.4.1721115500461; Tue, 16 Jul 2024
 00:38:20 -0700 (PDT)
Date: Tue, 16 Jul 2024 00:38:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005ce69061d586eb8@google.com>
Subject: [syzbot] Monthly udf report (Jul 2024)
From: syzbot <syzbot+list412cf9f56cbbacfea953@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 27 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4034    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 299     Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 29      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

