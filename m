Return-Path: <linux-kernel+bounces-376461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248E9AB1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430AC28148C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE5B1A2562;
	Tue, 22 Oct 2024 15:21:55 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F114A18
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610515; cv=none; b=pTSWs3GFMF2QeiXp1hme47/wlwxb8kdZIhbEr5cRo6/hZGySOqzLV84+nCVZ0TrZkx6LV+I9xTD7N7hIfeOeCUBxwpCiGRzaT64wi32DH5IwN+tCY2L/B5ZZHPub7pis4PRRFAgHC+Nk0kAIp2sj/1uTBaBDHV9GepUqogR4gds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610515; c=relaxed/simple;
	bh=wet4GcyKcPBYQGsQ+XIpVWvHP1vYW5cW0Gua9cBX5eA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YD3T4++IKrvHO4lLd2s2Y+2TgTY9kkp3xaHUhYUkfsKwfSEGpSM5OnC5BwPIl4yAaJM+/VFT79DkUOh6MXyN/41aw3Ebv2IyGARr06ZaHPDD5lRzrQuMNoi8kMUdYi0cbyyQkvXO28kM8rbRZdcZWa3EmTPT9S5S4H/N3TRLJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso45399735ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610513; x=1730215313;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wet4GcyKcPBYQGsQ+XIpVWvHP1vYW5cW0Gua9cBX5eA=;
        b=SNjfCHE+VCWv7psUkNKiL1gNTHofxuTYj3HR2cXf3qUmZMxFAawrdVZK4AdCff14G2
         BO1hDLP99LpdL3T7UQ0XMYXF1jZI9MK8WHUbvcR/zMoNz70MC+mizVbLAFukZ0rSSt9L
         TWGy1qpDauCnNT/LRJvwWsWLJM1CjEFatobJixMoRreDA5fb4OSMtpWorCbFZXmwwNM8
         6QgMHggIdjj5wtEQKwh8nSKzyGgjS2kuIqYk/y6d67LhvQDb7B/adWKqIU5ug2Ro2DSw
         aHthDGD7hhNXcJYGB6ltfFs69B+QSPccPSEMpa7wt+0L4w0uahE+qGCpB7bsK+OhcOZD
         x7hQ==
X-Gm-Message-State: AOJu0YyCoQX3bJBG0owPo1s8bquz2yQhBQOXmUa6ik4XrhogxbCpRJqy
	/uTgyJ7HXi4Bkvwm5FjfYarJc7rd3brRKrkrCOnMTXFfxRwNrZQCZcJKTjJo52uAg91k+1gwF0G
	XW+J0Bk9rRDx9/mTPn8kc7+0Dpm0f7oOqgWwjkw/cyfYxk16ua0SR0BU=
X-Google-Smtp-Source: AGHT+IFhFn/+Obp8kYAaU0VuQZg/y1Htf/jxBgbn1ODqXsORGQEtIWiaoGc5/PuMB3eMsz5ZIU/ueLR9gaQJo7TdYY1eoItKrcKf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c5:b0:3a0:7687:8c2d with SMTP id
 e9e14a558f8ab-3a3f40cc458mr133384145ab.26.1729610512766; Tue, 22 Oct 2024
 08:21:52 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:21:52 -0700
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6717c310.050a0220.10f4f4.0142.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __hfs_ext_cache_extent (2)
Author: gianf.trad@gmail.com

#syz test

