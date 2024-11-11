Return-Path: <linux-kernel+bounces-404167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698319C401F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D792284BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7AB19CD0B;
	Mon, 11 Nov 2024 14:01:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865C175D2D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333683; cv=none; b=UzhMhFiMs6qb8tJ275OFFLaTMFBxES0Uzh3LCtyf1Jmqu3Cbu/sxH3EdlHqqI5iPsoK8xocXY+Y3QopuL8TrsjA3n8th7+9GysRPoLbq+K9VhrAhmSioZazBeqhM6cdhYCCICBTkBYiuzwjAA9pl/lkSBDZWE7TVynQa2rEWYTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333683; c=relaxed/simple;
	bh=hbIpnS+URpvAyTJ1xTBqOdFUnKaXpRqxrapc6IgmV04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KCk7yJMSZyMHj8q5f9pvR5DRnbPwvuqWHC8Ekb8bLs7HF2Ppq1uxLnyAhaNNreJDNx4OjeOuo43YaYtmNR2QIjfq/WKjr9OxhVaHHHSGwrJFeiwMsW+Jyu+5fKDTr8xWRcjSfuTSRzG+pwaOkXBR/4JLjjXkNVhg4mzhpkcZgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aecd993faso481423539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333680; x=1731938480;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbIpnS+URpvAyTJ1xTBqOdFUnKaXpRqxrapc6IgmV04=;
        b=Yp94MPqxvfk/FU/0NhNKgkMKO4hCsW4c/slqvpfXh1jkgE3m+9OBEXtTSUFL78BGbO
         CHQDNh9IikHXCPzhW8Z4i3n5ek0qSf7VnNZYsk54AyfTyK7MjqtfXLx21DdxDHXrtAUZ
         yc3kejYrl6RNX+3C+j142gdpaJvDudblTgo+KBA2bGj64VY75M+zPeVFmKRzR+Z3yHV1
         ux7XcOzK1byf7W9DT2e8OUdu0BU25paKk9ykM/xtiYJg+HtZ87uhqieP7kusFl89ysX6
         7Y2J3tffkNDWToSOL9EOV8+imgaEW0TlLaqBMvelK3mC612WgsfdIsVKA0BUmNsJqddm
         ZN1Q==
X-Gm-Message-State: AOJu0YwR4yymUyAg6/PmVCpyn10KaTU7z6EBtVIC3JrXF0r84tapQIeO
	Lqz3Ch/x/odvFAbctsImZCPS1cMe+rII98iQPj2scfQ8ytAvbYaxrBKqIkmI2wV1WGTk61VcA2H
	EnOZuketX6Cpk+dIZAdC/tVAxzKmB/mR1ZKBnt1U7E93O/CyfVpA8aPs=
X-Google-Smtp-Source: AGHT+IHVx7FGX18htxA83igWZ/K17keJ9i4XGHD4Pa3aqhK2T8PK1QNkLyNQYERbZ9yJSLiP4xUqqr1jecBhm0T35eWcYAA9Llpn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cd:b0:3a2:6402:96b9 with SMTP id
 e9e14a558f8ab-3a6f2532be7mr118361945ab.9.1731333680552; Mon, 11 Nov 2024
 06:01:20 -0800 (PST)
Date: Mon, 11 Nov 2024 06:01:20 -0800
In-Reply-To: <672ecc13.050a0220.138bd5.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67320e30.050a0220.1fb99c.014f.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in bch2_copygc
Author: gianf.trad@gmail.com

#syz test

