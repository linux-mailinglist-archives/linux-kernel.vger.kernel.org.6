Return-Path: <linux-kernel+bounces-374069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061309A6206
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A0A1F23DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3F1E3DC2;
	Mon, 21 Oct 2024 10:09:19 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BC192D69
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505358; cv=none; b=HIE3hJrfZVVbToHqoG76XnDnnT6TuOuqGbvsq+RmcJzUv1/y7VaIg/QtLiC6b6MjZPDWtH+UQa7i43/oPBBjggdSmcIWClxZZ06CR3mnMyQDr8b70Y4MSW/ESox2CYc3VBYhaDO1jLwpV5tskVkXoBC47OCpTIqtBbF/GTre+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505358; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BB1zRyPo36kd3KeoCtV8xNNUVe2TlKoJQGDy/+UAUTGLZL76VgMKNsG6Euw//P4p0yTou3YD41WJKEV2J7xOu1J8Y7JzJXe8/IDLuFuzLWs5lOU5ND13QFxoS7erw61nBy3poYpqKOw8Ol3JriYBF/WWUF/qIm6eTFszbmxiprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ac0354401so270526439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505356; x=1730110156;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=HnVdQr/W6woNxxyjpPUrgAKx0pBOUSN4qc5sCEEGHlNzu9d7kVfVsKJ4WDEmQL7HRF
         3D0GxzHFvLClSgZeoLCLZJkMWT6WxMdBuVjEsBwHIKlio2USN2QldvufA1wous1zZ6Iq
         zsk5Ssr7ZU6ZcP+Mw5YqolVRLYw3T/fiyD4rhdbGtTwxPsVP3rpKdyz9PYcCqnAi3WNc
         HCd6fos/O/hfwEGKsMRTa6VXU7mBj6fznEHLxI2QAfB2zpNYu0sO06XwhrG6n6U+0bJe
         m5DawV0PDN4q3qnCfI+YPhCyjPuxVbKcCxBbjxA9XOPZu+Gh2IcnZ9YdqGvksqADJw3O
         aliA==
X-Gm-Message-State: AOJu0Yy9GGbbnA87jei72L5C4+S90iFLe2cVy1MwUstVg5WuopNBJFmV
	pBNp1yYrLXzXpllJPO5f3Zd1Tm3FfCuWZLGRKRHandDEUReXY3sXXMWsVS38rkNhEIbwqonEJKr
	ug02kovk6KFF9bjKnOwGwnnV1yerXFWJ6kh66sc/Od2tuEPRcoLhm3MU=
X-Google-Smtp-Source: AGHT+IFXXAm5TX/HkxCOMS5A7KRekc9uNT3nD2BhVkuxqzKrSZ2iouHgQK3G7BMLqiasH9O5V1dicYQgfIDY61VFycj3Z6s3x/Bk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc1:b0:82c:fd75:813a with SMTP id
 ca18e2360f4ac-83aba5bbfbdmr927665139f.1.1729505355972; Mon, 21 Oct 2024
 03:09:15 -0700 (PDT)
Date: Mon, 21 Oct 2024 03:09:15 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716284b.050a0220.10f4f4.0046.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

