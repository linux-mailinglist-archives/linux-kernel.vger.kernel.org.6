Return-Path: <linux-kernel+bounces-297719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE3495BCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCF61F2205B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4361CE70E;
	Thu, 22 Aug 2024 17:06:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAAD1CE701
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346369; cv=none; b=olXUD12Y+HlRJzuaBEruBTX9AU7i6QP/fSA1fb+qaZgQCwg4bIxZFjtC422mFJUeeCRHClFkWfAJlEmRU1Jx4QhvIbHRrrEmW5kOl6vb3+N+Cda7ijIlP370JG8MjP1ZWsQ8n5gWBeRPHQN+mKLu9cWOkTVDmG/G5nmDgPw3SNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346369; c=relaxed/simple;
	bh=TWkaTQWij0E5heclCL1oRuVVdWOsxd+Bgm0+hbqdvHE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mFWpFShKDS0ALm986xmwBM80P4Lis0nOB2PRZBjoJjYV6DO/3TMJUAUacTlz8psCmJuS9bfAMbexthgmPCLbs3eQwTrv5nsOOfWVu+gOpwtI/pc1aR0p8kyyXUTV7WE/ifew+zcrqpSr1qgRrUDQ+ZC2wzV6EHYnXQYddwEcmNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d470803edso11977535ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346367; x=1724951167;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWkaTQWij0E5heclCL1oRuVVdWOsxd+Bgm0+hbqdvHE=;
        b=go0es7pPe0dNP2h2iF/ex2LDcey5OcHOhtmUGl+KXmmcxon+W7W68ZkG7prj2ttCK5
         LnymTofpBL82IG+mPhxGcyVEoYR4PdLOF4upicssgOKeAxbLYK8VYrliR15376DFs1G9
         lKH0M5M4t+3wDMTrYzLUb2c5rJnmIeblDFRpY1uQDMWecKDUcUZeI33QV9F3oy83//68
         l70yvVUHSGYsmOme/7UgybRie07eN7ec5Amz/Hk1QKjXGGp6KpIg1ipg9nvfvYIreYaK
         F3BIDKzxzdULsSs/fG2RjQGxpqvzyN7OHbY9Uqo9Qmw+YmVPAbB9t+gIyAYoqHvEpcZs
         WfWw==
X-Gm-Message-State: AOJu0YzNtUH8l590X7CGuept7YO9l2Kfkr+9sVku+VPkIri7QZbbZ/5Y
	xHIJO4bMlumbIvHHr2xbKEHXWMN37hkcuzXF9kW8XZ8WcZLTBfyqulCsrAWZLcv52WaZjpwe+6g
	+M+pS8RVmNZikfw05RypQ0J2pcY1UwIfmz4dYhtB0KPbBPZgmY9bzRlk=
X-Google-Smtp-Source: AGHT+IGF8qgcHR0xNPckMKn+URKJzPmU1DPPhth8T9RDh3Zhj10yUxrhfP0LEpgiMJNxrz0aVvOETuUAH4VegUfduh00tIrzNm0A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39e3a5dd86dmr156355ab.0.1724346367111; Thu, 22 Aug 2024
 10:06:07 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:06:07 -0700
In-Reply-To: <000000000000fd5e7006191f78dc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae82a5062048ac74@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_btree_node_iter_init
From: syzbot <syzbot+f321ecc68453b9ac9bff@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_btree_node_iter_init
Author: kent.overstreet@linux.dev

#syz invalid

