Return-Path: <linux-kernel+bounces-446212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7969F212B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF80B1887934
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D871B2196;
	Sat, 14 Dec 2024 22:16:33 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E919CC0A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734214593; cv=none; b=QFjGJm1WfyY5Q4PvOe8qOuM859jicSF8ciMBZF7uJHJhaUIYkLzFVz/YPuG49poAb1ueh9a3IbhtD3AKDxZ3Hv+jAHLQqXgg0IwB9EAOkP4RtCvUv4T39XiMFPi92rf9CXkAU9AkeEUSnSm+BGmSQrFs3///wedKOI0ak2YgTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734214593; c=relaxed/simple;
	bh=jmOfGx8i6WqW/9e9eV0esQhvVw6dNrC2SZ1/lyEA2QA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MGb6wksaDXdxVhoJpmhGdBfvRT9Nj+L6TKp5I76PrvVCvFFKSRl9/5DrpSZd/YFryBtfdu6/CEG62U1N1V8a/ihK9/JrB0WSO+668mna72ze8zWoJpkXax7A+UiGMWIUgHtmFyWywXzlhonZ9wAyHefvzSAWrqRk2yqqsUDoF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-844e5cf7b42so209700839f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734214590; x=1734819390;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bicnoxgy/OVG1OfhR8q3/VJAcXZClP4+JgLbGeU2LYg=;
        b=wfWtC9YxJ7dU5Kx4LWy+kcVheBvvtEKKnDp3mAMlrgK5KNgtYECNIcXKm+kEGngxNV
         9phc7pcPqxrvy4moarO6t3aydU68acXFFJEt1dCmU5lcP/0iqkDwLfa2Sk+Bvcvf9bBN
         5UW5eS6WbJVdRfoEVgPJfmWC1EgsUlzolj4jwa+yMyakeUCLCq/4XiqxdBOaqP5COk4i
         3kwrRZP6tUkSMIcxnW+5SDYZ3PjKAfE18GaMbEpZOp0YrCGLN25E/ZGa/X/5+Gd1Lg2L
         mOnmcwDHEf4x0ySjOuNqYsdv6K3485VVxv+dZmucncpBL4zztfR4VWFpZ6BD0RcpWrmZ
         jzjw==
X-Gm-Message-State: AOJu0YxSz8SOoUOWMpCFH/AabeYtzHsaF8ThAVJUD1kf7dvHTmD/rKH6
	5hBlcrGFkp+VKM45a04iO2zm4Al4i2qDEgaMypFgK8tLPPqTTWgN8GBj23DHStQMfuI//09g5Xs
	8jrDYPKjCDBG09PeOn3679sxiV3cm2L6LHRpdEUQNgoeveT5Ha93kJQE=
X-Google-Smtp-Source: AGHT+IExdpHTTQgbpsWZ2SggNuCAvpoxCCIhAH4lOu0LWXVsVnx7P5JN195KzUUE+G7qb6LGidpYeX9rTOw5YX7eKwuHGllEFd0g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198d:b0:3a7:cf61:ded7 with SMTP id
 e9e14a558f8ab-3b02e0383f4mr69089145ab.10.1734214590647; Sat, 14 Dec 2024
 14:16:30 -0800 (PST)
Date: Sat, 14 Dec 2024 14:16:30 -0800
In-Reply-To: <67409854.050a0220.363a1b.013f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e03be.050a0220.37aaf.00db.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: mazin@getstate.dev

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

