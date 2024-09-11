Return-Path: <linux-kernel+bounces-324678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B3974FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2961C2233E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471F4184537;
	Wed, 11 Sep 2024 10:22:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49915DBB3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050152; cv=none; b=IFrxDMJb7LFmZ5ajpjCXunDMRpaTP77s4sDvjpX4s7TuDebd8PN0EkUpeS8WyVDbE99JFXhF5yAjcMNjPYcuugy7L+lGEbY+xfkJ2UpaB5EfQxHdBXXiechwBeIENb2HwT7C/u5cj/HReT+0qVJaOQaiQ7FwfGHHXgeipwlLCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050152; c=relaxed/simple;
	bh=IzlrtpBuUEkl2AS/wbJLfkdZ5Y9XzjMa60wQk2jqqfM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tNphcpP8HuE3gXSJbVUAvgYSB2rseEU249wDI9yrsQNUH61a+4AE5cH7419TF6q0MKA3BRxd8LBzrj3ZOwG9O6KOlRz7Uiset9K2slv5jdjAT71qvZiYgEED6R9Nnnx/2YF+Aqxp8ANitvoMDKRxg7s4KK5cbTsFdgLylcUnYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04a91237dso27589015ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050150; x=1726654950;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzlrtpBuUEkl2AS/wbJLfkdZ5Y9XzjMa60wQk2jqqfM=;
        b=EJH7yFw2//UhHPh/PiCTWygZpSDymQLmU6WKcGGISYEqUVg/+EjZb6OOdQ4LiXWg6B
         TdJvCWhH9L6hm99g00DqgTEzkeuw9wqFXmV0bh5sy+SNgAcg3kDXuPwylZbHHxotrSuu
         DetC8AOSQSoWn/gHfYplYp9u5bcQaS/nn8/cA4EJyhR/jfDk/25GocVEjFosqzFrvEyj
         QmvVwVsygAm0dICn4H5ssEGxcVN10zxzLh0s6kdWHgyUaQuOTjROh6LnAsOK+vqD1tCp
         UVuQ8lmxRMIkCJlKziPLN79v3XjP2iQ4NFSm6BbkdqgM+cLF3o8ty3XINpw67XIKqvf6
         5q2A==
X-Gm-Message-State: AOJu0YyNMZrS1JcXdE2j2epS4VO1tQPEnF1k1Q30obPU+8JLRgtiWZJ7
	YOgOSWhVXEb2XNf8g119xE81Nu5sSZnEXdKtkiKdnOYXQ3+9G8RZ56FThiggYY0qyaXJDUTU8g4
	z6Kd78kZMCbMmwkyYYs0SrGltiGzLJDSrYKKNFIXTSvcmt+m2hUUuoGg=
X-Google-Smtp-Source: AGHT+IGkpVy78FQlvPwLfEPm/ABeErvuswk9+9wiF4XROyJoEVDf+9hEK7Pb9xirFs5qeyezeCoGgDkEUhmzFDUP6+RtqbOiMrjX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca05:0:b0:39b:3e01:cbd4 with SMTP id
 e9e14a558f8ab-3a0742302e7mr28840545ab.14.1726050150623; Wed, 11 Sep 2024
 03:22:30 -0700 (PDT)
Date: Wed, 11 Sep 2024 03:22:30 -0700
In-Reply-To: <0000000000000311430620013217@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017bcd70621d55e56@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
Author: alibuda@linux.alibaba.com


#syz test

