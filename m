Return-Path: <linux-kernel+bounces-222081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C510A90FC99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DDF284E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E483B28F;
	Thu, 20 Jun 2024 06:15:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529D3A1B0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718864105; cv=none; b=h84IKkDUjugLGYp59vTpo0zhd+RawF5fHgJaKFExHeuMWWt5IPnlaMmMYn3ZtTg+jl+meO2h1V4TGVi4JNhhm8YuLBdVKVxvada4qoVxM5O53+/4NniHtTxvpGGU62fYh5GfjDrYqEpBuN+nFdo/CVG1CoCVvsGAzhe+Vteyn5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718864105; c=relaxed/simple;
	bh=kNMQz9T7fIcSX+LiMHe9FHdHy1kFTypEU6F0wYpWGLc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u5zxYqGv2E6WeqLpoBNLP8yFU1ItB52PDwccWEkgF2og14dED2q/CyomhfyW1Ud1fsJ+HuzC46mSHB4bM4tCU4bjeaEY8hiTngvDF81JrkNV3dn6kDE8uWx98wthFPTl1OzIr9ImdmBngiq89q6h2dBkm3OCW+XaYxGEWw20REs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so71021239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718864103; x=1719468903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8764yuJbvNUEMryvKz5yvNM4195TRiAWbRuOnvDInk=;
        b=NATSVpoWUBS50/a6SBBFkUkE+GaMdXDC1q1Ge2u3GjNexPSsc+8cjlo9kjzHGv4wL8
         TgrCTHQNym4RpCU0Nk6JAzoTLHoJy3q544HSTBqJ7KMjQdACmjq9vg4xZsLg4RFXT8X5
         XtY86GkHPvSxaq+yp0SxsWQ7a9C+HuVNCyOkkZW5JePQwHrJuZED5sX7vwqUJ92DeuYQ
         GYIl5PzdVvJMjQJludNFvg7RW4Pz9pI8UgEAneK9bpqOXJObJ7kHY+RUNY7Qc78jBo7M
         HbLz5t52VLpZpapaDPCMyOKAx0sK8jredd75egKa5HXa+MrIFNXWgA+1iIz6xo2JxqyQ
         Jvpg==
X-Gm-Message-State: AOJu0YxL60gXL0qDyklwfyzkcwWIIBle5GJxljS53uA9yoYOYU3vr0+7
	1aRYKvKMvQHLPtKHp9zL7KZG4VU3xscxze+2yBIhllAKp877brehgRKi4N+OYF+WpZ6ZjLO0GyY
	xjD3EM78V/vTF5WFVHLIPPl45poSPTrvTD2+8kOCgMuKWjUDn6JwdKlE=
X-Google-Smtp-Source: AGHT+IGhc/LulR0st7SkFkz18u5WcXSLuyTzgW7wNVQUi0tZyg1Okb4KodyZ4qiMYq9WDzr9MUUELKbc4Zoz4WcxAa3A3BpqJpBf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8620:b0:4b9:6c10:36cc with SMTP id
 8926c6da1cb9f-4b9abe11d4fmr138656173.1.1718864103231; Wed, 19 Jun 2024
 23:15:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 23:15:03 -0700
In-Reply-To: <PN2PR01MB489118B0901BB49F1880F759FCC82@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a6197061b4c3c72@google.com>
Subject: Re: [syzbot] [net?] [bpf?] KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://linux.googlesource.com/linux/kernel/git/torvalds/linux on commit 0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54: failed to run ["git" "checkout" "0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54"]: exit status 128
fatal: Cannot switch branch to a non-commit '0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54'



Tested on:

commit:         [unknown 
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux 0daa6e5ed1ccdeb65e07d4884961a8bb288a0f54
kernel config:  https://syzkaller.appspot.com/x/.config?x=13e7da432565d94c
dashboard link: https://syzkaller.appspot.com/bug?extid=c33bff5d5da1391df027
compiler:       

Note: no patches were applied.

