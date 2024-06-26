Return-Path: <linux-kernel+bounces-229948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1891766F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CC81C22797
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3897838396;
	Wed, 26 Jun 2024 02:52:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752981B806
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370352; cv=none; b=JSymPJDAZ43XoGo3JxKv4lx4C/v3fBabkaKzyydkbQS+UCkFoa4hUFzYQaaZAWV3bWHa2cu8oTqiGjgPfIToilK9lFsJPlC51m2JEqPU+CybqYM41O9786Dmi2XreEqU1RvVGd1liNy34TaCJhm97VA978l0qHPxoJoxuTHosz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370352; c=relaxed/simple;
	bh=2P9ciSlu7Ek9y6TGFOI752MUh8bHFPb7DN1jU8pmlJ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Iw3PhG4DGseRkiWFRy0Y2DRQIsrnMh7AfFgklzByVinAouYgtrLezjDkTwkMuqiI9JGUM1QRvgE2B9L3iYqbTMxUHKS+pDJwC9NMDRZ3DD5yf+CRIeKVtwiVws5MWcEF4QgBNea/5580M6K2G63bAmJTSDr08YcNxZDdqT+w7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eee4ffd19eso886838039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719370350; x=1719975150;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P9ciSlu7Ek9y6TGFOI752MUh8bHFPb7DN1jU8pmlJ8=;
        b=F7GS4D+EMM453XD9O7cuU9ugFL1+t77A4Ed68QEgnrNzq+Xn5AjdZk+Xn5wrM5Sjgd
         YaOf3UGDfNbnJP994YY2kl9ox0XP0iFKqP1D1WYwExOM5FK+Qn5tcpnWaZWz0B7VAHUk
         GmrAihMiOxmatixmsBuBYLEFZXoY2/SisW6m+1AEM6EnDjqTigKJdx5fYuJEC6AoXdd6
         dqtSZhVlfxVwrxd1gbuwpWz7NGYtvYWrnZEwcj9lZYd7p867Y1Q94BAjsOfkJTEDZsBp
         +g6KyGfKKgEC5chP6vk5cGKw/+PbGB4vD9MmtmAc/Vf+IYnQOnrXUsxibPBUmrnpxu/2
         p21A==
X-Gm-Message-State: AOJu0YxFPm5Qkh6hgkqGQSnc8mcPE7BL2jHraNXzXXPAmwoE3l4Y9tN8
	AglESp+Gk3z3OKU+uCGLWYtVOGvQdGcChfWXgEqzm6Uv4OSuNEILaoDoEVpa/UVjw8L8qM8ETd/
	zAi5hI+HZPq0G51JsWVFYN+FuLrfzAchdegUjxIYruo6oI2lWXH3igT0=
X-Google-Smtp-Source: AGHT+IG2GRc+1Xc3l7l/+CQaKH0SZEMwlrb6zy1XYPEizgZTL2pjjPHvIc5DzcL26kzN6HimSv+I34MFj1xGkK1r1ANSdnc8Yd4N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35aa:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4b9e7b983d5mr506116173.1.1719370350788; Tue, 25 Jun 2024
 19:52:30 -0700 (PDT)
Date: Tue, 25 Jun 2024 19:52:30 -0700
In-Reply-To: <00000000000085bb82061984e155@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff162f061bc21ad5@google.com>
Subject: Re: [syzbot] WARNING in __kvm_gpc_refresh (2)
From: syzbot <syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in __kvm_gpc_refresh (2)
Author: peili.dev@gmail.com

#syz test

