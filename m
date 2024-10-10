Return-Path: <linux-kernel+bounces-359009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0E4998640
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5702B225C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797271C463A;
	Thu, 10 Oct 2024 12:39:37 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F41C1AD9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563977; cv=none; b=ZnqUM3mjKwzWc3w1GU2cPOJnBjo2rq0Nq+MqmYEIJsDYf8OkYxLUr3peuyOp/7VIQOhU57Z4ydJ8EzXLB12b1ltlTmO2Mqzj02pnmChzxFQQsrC0JBnbEcsqfDKdfC2wCShXCWGrTZCtE3ZPPmISI08N6PStkTSfteFmPT6Q/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563977; c=relaxed/simple;
	bh=uJgwS+EYHWGuZMYuGhsSHk/r40QmgerLLW822ZRQwaY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GIsxZj+tAs1kOTRAnIAWmZIdB8u1Vr6ACGNIYlVVqWR8qaVwFR2NKgl1HpGcE65hz82cyyfS66gzsp04XV4EGjhTVhbpRNq+YDdNRcqc2bOM70ccXBoqhtbnWeeVTzdIAlORpQgomO3V8cHvcSSuBqV/P67hvSE+/rbzYeo02RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1925177fdso10520125ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563975; x=1729168775;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJgwS+EYHWGuZMYuGhsSHk/r40QmgerLLW822ZRQwaY=;
        b=P87djbbcMytTOe7VPLlN5jqVvAxSDqhDPqkc7xhDkfulR2hE1Jz+Gw4nfMXSr//Tqv
         LQQGFsb6JqebkralHwVfHTVWhQTNeXZxActhXf1DeA3hWmQunp4nPzyUzn4d7DpBk0O7
         NHI+6uMiDXWmunfOLJ3+1bbQIHSDKwhR5ix8sB9OhGBUgVBt5bWlEsDZvX4z4nz9mbgw
         SDr6zNhSoM0N3Ng+mM0JpLqb9fnYdx2rU45n5Gj/QtWxqMRbeB90M+1Nj8FlQpoTB8HM
         VSH2llmWW5I8PZyqz6KUZuXnkU3rzxtmzgjeP+bqMXfe6ZbjLVHrS8uB2FVWNgMSMd4G
         j5RA==
X-Gm-Message-State: AOJu0Yzur2whTZSWumplt6M9m0DoUJ2KbmLZ9yqrJPiedcbbnuutGQd7
	7oQzV3NzKu9lbLzgLnbCT1oYzJMAzkd7tvZCSnyGrfDNwGpBt5bGBVvnEDSjXIncepcm4JijdIS
	m8u5UI+fWAFD85yy1Vv09rpls9K33wrjG9NnzsyuAoFQ8L+73XEL6F7g=
X-Google-Smtp-Source: AGHT+IHOshf0CXFaKnrYsH45V2T/BIubZ81pkMIKvtSeQj4rkiVNrtVsWqvoKVOqW1JQ+lb7veY7E2WuMUJcENYPn0MDRXVEeGi7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8a:b0:3a3:778e:45cd with SMTP id
 e9e14a558f8ab-3a397d17988mr68615455ab.21.1728563974855; Thu, 10 Oct 2024
 05:39:34 -0700 (PDT)
Date: Thu, 10 Oct 2024 05:39:34 -0700
In-Reply-To: <67014df7.050a0220.49194.04c0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707cb06.050a0220.8109b.0007.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __exfat_get_dentry_set
Author: niharchaithanya@gmail.com

#syz test

