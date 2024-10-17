Return-Path: <linux-kernel+bounces-370670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8D89A3083
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AC6283EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC701D6DCC;
	Thu, 17 Oct 2024 22:14:23 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046A137C35
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203263; cv=none; b=t3vrh9XluOhRUit42vTzAWLXq1Hp6mPzjdTEwqovHbbT2gXRuaHxdAA5FqCmC8RxsLAqS0859PMzm+YiQRC8rTiJwW7zXt1ZkLxsuYuxgDuQiM5YiSlMBUg1JV7owu0BS7wB8D0220kzIfMIVt5uVelAakaaSxZz/0j+NZ+Ld0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203263; c=relaxed/simple;
	bh=U3rAXlspAvLAynmepLq9gCaSw4zez7Y+lt/TmWHvqn4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D5v0TXd0VLntlCXBgF1Cf9Q04jOhx8UarWYP7zaVCUh5nmddmTbF23TP/HM9AFFN9iPYE5rkfV7VOpTEPDJFnU/ZkClAz06X0wsyiD/yCxPnFOCLfyNyyuyQ1UAHK7NgI8x8itWaEjChs9Xn87omenYNVI87NV3CC3cpXKq4GUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so14515475ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729203261; x=1729808061;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3rAXlspAvLAynmepLq9gCaSw4zez7Y+lt/TmWHvqn4=;
        b=LjQJtkxYdnmaPO1/htFBa3q50yulUHanXCRAel2x1IHlD4vOpEkSOcPuFx+St4p09v
         B+1oO73DXR7S4LIwydvE9d6r5nxf9gs0bLsajcEKdn3GYUZx3CU7DkbpYgfYThs7epiz
         Z1LI+tx0GXMw7MwRAbzw/RpgGrZ1LQHIoK3xZrUE/LiRkng75OizUIDvrIqVFjcqazrT
         WWNxQClc0gDPhSnDHQYFsPud3fiY9Z4I+8PSBsjjN+yKBC7czlypKQDu8jQVHpVnf7Wh
         aea0Gm61nT28j7Bs+OM7qw57TxrPl7b+8IuHh3xot81NlPAyUioNmDl4YHUhI/riaIsn
         +Y3Q==
X-Gm-Message-State: AOJu0Yx63K8zahzclRsR+4O8hdYsJ6dnKp1IFOkx4fxASVJivaA5pJIO
	iQMomRXPkuIgAtZWW4xuZwOn05ajvGxVjWyH6l4kmnCBr5rZJCjqB78g9JbKnWrUs0dtjCYvllK
	ohT4CACaC6GwNvwPD4MTbZRsYH4GC8tMQqIYCQdka9jI+swkqwmKc7Do=
X-Google-Smtp-Source: AGHT+IFTfnFyeWhFuWs9zTAYgXcg/7z0J6R9j7MiUtNIWShvXmSQNKaB2wxspjO9iIuDIozMH0Hsq984xMueGw/nOz8LAkb4Tv9p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:3a0:985b:ddb4 with SMTP id
 e9e14a558f8ab-3a3f404ff3amr2916835ab.2.1729203261192; Thu, 17 Oct 2024
 15:14:21 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:14:21 -0700
In-Reply-To: <66f057eb.050a0220.a27de.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67118c3d.050a0220.10f4f4.0006.GAE@google.com>
Subject: Re: [syzbot] KMSAN: kernel-infoleak skb header examine
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: kernel-infoleak skb header examine
Author: danielyangkang@gmail.com

#syz test

