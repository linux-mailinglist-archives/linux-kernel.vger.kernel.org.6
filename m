Return-Path: <linux-kernel+bounces-299288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C7295D25A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C21C2297E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0C1898F8;
	Fri, 23 Aug 2024 16:04:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EB18891C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429063; cv=none; b=s6ooeJbcZsOhDRYfQfys18I94XkH5u0HRMWzXslyhVY7BREKHBOhPjs14sv8pf3XejI/nNmmpQamgZ69wpgWuFqv4QMxPL1CDUwuRf1WXrzn4ImkRuROZzSjN1DthryxaUlKtmm4qST4XBWxz7xXSvS1el0Xah/7ahHc+3E61GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429063; c=relaxed/simple;
	bh=SCL0O1IAeusfBWnsa97ZuzrCOIrIKk1bU8/ric3GNR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bkNF38yK+wdi43wcmj1IyRPgsC5TjhEEuXBj8CNOVWdyS4HXbbo9rAb9gImLSOE1bejT3OUUP+APNwVEL8arESXbfHhH9uZqTUcKS7ZQhT6W7OBtKGZEx3j2yPbOkV23AeuR2hEtuRPXfTCG47gQricC0/qAHOU1dUk0Hbxao8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f968e53b0so210866139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429061; x=1725033861;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCL0O1IAeusfBWnsa97ZuzrCOIrIKk1bU8/ric3GNR8=;
        b=oQuUNY2YCSKZwwUekzAsPVPUT8kd4RsdDAtkBVrDhla57VTOBpp7rx/mVdPAourSK7
         VhxKOQSwQCATTjuf22D+tu3m8dRjXVwsdSi//WsnkQdg3E0UgzcNKGo25+npuFq2c0Sw
         ys/0tJFqP1F583JwPxl/F4hixWmm2rWpGVnQHVebjFu8o3zA6iJiQUddKMcBfTawRtDT
         A4l9i2Zw6jSivryr2LNpBVmHAe6pPlWgZwGZohsaR+3pbW5tLLxwvancu6lKXKZ7IbFT
         nIZgUBvchrh8qQmtluqsQDfsnblqf3u2QcyRSta3uJTBpzRUSqP6qLZKyM7uX5BqOo33
         DI0A==
X-Gm-Message-State: AOJu0YyEkamdzjW8ID9B983k+Bomhb3N+EJycmi8dhe+fiQnGyIs/6mZ
	hXLQQUyNLYlYAy1jUgtjsrQGVSVincVHHi+jkWE1BmGueeggI/j4j4kCysrsLfn2utIJk3zHcQY
	1bfhlshFugbDkG3moQQcCWSMOqbUnb5Pg7scqls/znfW0lTc/OK8w5Fk=
X-Google-Smtp-Source: AGHT+IFIv6AKGHAVWarrBBzZGx34yoI2A6RJJDpYdSYvGnDvIRJdZPXn/wTZSMpNhtNSNIiJPEGoxZ54vKJws4Wlzu3XmSINEJKr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6412:b0:805:caf8:4e1c with SMTP id
 ca18e2360f4ac-827873956eamr4473739f.4.1724429061315; Fri, 23 Aug 2024
 09:04:21 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:04:21 -0700
In-Reply-To: <0000000000009a502f061d1ada4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3eedc06205bedd4@google.com>
Subject: Re: [syzbot] general protection fault in run_is_mapped_full
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: general protection fault in run_is_mapped_full
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master


