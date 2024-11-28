Return-Path: <linux-kernel+bounces-425099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4389DBD6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F368164CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF651C3F27;
	Thu, 28 Nov 2024 22:12:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F92837A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732831954; cv=none; b=uEeX/z3dAkASAomSeiNMZVO/YYVG61DMu4bMkde6XyIG9W/cFt4oCt26sPeiPV+TW75pfa4jrX5kmxT6DX8lA4+ZiyNwmnheTsWZWDKML1xqqMvMuPlt0rvFK0ZmDK3jYBZ89wRJ6o06TRhvJSp6ow0geB4ue2/trvHctbdkgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732831954; c=relaxed/simple;
	bh=2iaPKUzkKnksZXHS84sYIHCEg1NkdBoOSr5EsImUXRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gR3vVB6adZ69WtO+jIev6e2cG9SgBgItJTA8IY2v60djNn+ZAq+odwS1ePYkPvBnLIBEXSfB7JAZ4PIHFuV0qCcB4LWFaqCmEdHeTFRprJenANGZFoNPG61pT1rL5GZxice7k86S15rc/xgDToDQpe/2RLTztO02LPWKBYo8Ubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-841a3f2aebfso96675239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732831951; x=1733436751;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPToYAzaOqYSWFjCZNGy57zdecqsZa0rLMd6PJ3pNKw=;
        b=wy2MGe2rVaU+lJS6IEzFEq85R4EAINEqEzk8+nBOWPiMdnIpX/rIGB7snOktfErVa6
         aG/1HkQOiUogWKya/kGAyHFkaLmBzI6WE3HC4FbkRyIsKRFRsiH+tcfyttjzoRuOZ2d1
         hJS6jvcLFpL7N8WFgIKEBn3rbVhqtKkTQ4rbEszqO1UA8UU4SBm8TrqSss/VZ8/AqxAL
         ilnAhMI9AzdZSU2UmocZAdbHUts3NN0tqleNAHSpAu2qd9RmkhlfLMy2skj00Aony6k6
         6RmUOJ/lq+s60g9PJ/425GFHmNXAs3pwhQNeXpti/mfMza0XRh+dRHRM0CKOMqACnaTY
         RlCw==
X-Gm-Message-State: AOJu0YzgBsJ0Tk0H4eOzziqthyPsKOQRrbBCljO5fOq+T09SkgzbcEvy
	z4Sh7Ier4vrj0GD1usy850GsQDbASBLcIdMhe20kDxyOyU6DnXv7NzmThyHYFlT30kwtvcMp2sq
	RnU8f9LABNLpMnH9sKy92qb2j0R1tQi/b8iHoEayt/3ylyBeSyP4UxAs=
X-Google-Smtp-Source: AGHT+IF9OX8u9puXPgxUT+CYK99dvcD0gjmEFuOh2VZy/csoWa3ViOUXmxkOqXKYs17m+giQb8fcYta/p5xAr1Iay0yGTUdwuzHo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda4:0:b0:3a6:aade:e30f with SMTP id
 e9e14a558f8ab-3a7c552544bmr115901765ab.3.1732831951750; Thu, 28 Nov 2024
 14:12:31 -0800 (PST)
Date: Thu, 28 Nov 2024 14:12:31 -0800
In-Reply-To: <0000000000004169f9061ceadd8a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6748eacf.050a0220.253251.0092.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+85700120f75fc10d4e18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Check for bucket journal sequence numbers from the future

