Return-Path: <linux-kernel+bounces-361130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF24599A3F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F89E281D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B898421733F;
	Fri, 11 Oct 2024 12:33:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C921CDFA6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650007; cv=none; b=pfJ1EDm8bzJw45le6lDhpaOlYNFWGHahYPIuVbZrbVzccLnN048cB/Bo71QjWAQbRY7Uusr2C9Fu4EEumeAT3JTiVeCfjbHrxrHwOm+VRz/aMUkE5Ap1zDNO4pna0MmgvEHmgA26QVCZ8/VaQP9TbXsRrRpUyLA6LAZsIL2hp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650007; c=relaxed/simple;
	bh=tAGG1y1LZZik2eJM5cMct9MC7ETH4zYakVcDsfNUZAY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iw6eP1AvL4usmZ61PDSnXO+RvvEXwu4qCGdJf74kYvsZ3aS1H3AVyznaSdVuDCWQlhyt0f2Ckw7DbDNssw+00jTItUKDeiJN2/QHaZuIKPNsRgKD6zeW5naBCF9YdeaCQaTVC/Aq9r80xU6PuJ+d02IBZdgfwIXikS2khcb4bnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a36a8fa836so12123405ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728650005; x=1729254805;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAGG1y1LZZik2eJM5cMct9MC7ETH4zYakVcDsfNUZAY=;
        b=PmhD2hf4/m1CIqYRWVIVjYyj7HVe6yi/M5cJifQKHVB4L9eNfP8Z6pEVpPrzyPE2pQ
         L22ffEy7JrS3RplxkRF+ce8vhp7/FY+kYW7bOy/fPMayn9agomQUWZzhQD4eTggyO+rE
         5aTExrCfbeQNrqpG8qBqfEzA8VF6dPX2gqwfBlzjbw1smiP82A9H9KwgfV5TgBp7oxbN
         Tj9pP4N+t63T0XYV721nSrLNtalMyzwcSs3OLEPf/Q2JsuIvyp1kN3HPix/02Ap2Vyvx
         H9DjuBks8ola9yctGgZ93lrlqCPT6SrXO2eupW9vJdncGjYhdS3tDVBRH87oUyW9dGf2
         2IGw==
X-Gm-Message-State: AOJu0Ywi0MrqBLAN4HbkmWdJMVCE0YZLXfYBMzdZBFiJ4mq/+5NwocUy
	gM4pYsNL8UyoVlj1eFT25wDI590U6zJXNFAq81T2/prQMBrB0gtY+UsXJsH+pKf4pKbefOHFsHR
	ae9ao97JYboENTtk6onYf4HbQ/DizJe9slGI02CDUuW2P35taTfKAVFM=
X-Google-Smtp-Source: AGHT+IG/52pX6lwSXPwFuF2VGDfatICk93la9gqDeB92+tMHkKYyDMv/p3VvmjIyCUpZCFNapcWdgJm1dOjfGOB3MehIwmzYioXF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:3a0:8c5f:90d8 with SMTP id
 e9e14a558f8ab-3a3b5f38d13mr13574935ab.6.1728650005072; Fri, 11 Oct 2024
 05:33:25 -0700 (PDT)
Date: Fri, 11 Oct 2024 05:33:25 -0700
In-Reply-To: <67014df7.050a0220.49194.04c0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67091b15.050a0220.4cbc0.0006.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __exfat_get_dentry_set
Author: sarvesh20123@gmail.com

#syz test

