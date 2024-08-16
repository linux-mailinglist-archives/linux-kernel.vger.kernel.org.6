Return-Path: <linux-kernel+bounces-289250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A11C9543AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878672858FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A618286F;
	Fri, 16 Aug 2024 08:08:59 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419601D69E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795738; cv=none; b=V2pvBWOqfd1PMTMfWMDdH6/U3qtbt3VYVCBYr/ovXtzUOatwgPC7fFGWreIJ1aIAiWP99mcLVzTK35SLXQOIdpR2+QE/MKLz7ox3a50BK7amW++O8cXpnGUTaWBiOKU7DcFNBZlJLH4yqDISTWVbyJfcN+g7BgNO8W7sXUMuhB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795738; c=relaxed/simple;
	bh=RuPTXir3GWr1XxRy6t5L8EIGrDrRxAymHUuhRxYpwyk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XcLqXmipqq+35ZBEnzxixuhZAX9o0H4k8sdij7+aE7psiDrn2v0cg6R9RtgN4PiCotdSKnC9mNOWQRTNNUDX2ryUrds18gyyDNQ8Kmu8O6n0fhBEsSOf0EeOqdMcQ28Q4qUJ1lgaQ8KoHphQhhspR+efQHx1cVYXR07RnvD5JHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a1ba36524so16294815ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723795736; x=1724400536;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RuPTXir3GWr1XxRy6t5L8EIGrDrRxAymHUuhRxYpwyk=;
        b=Oii5u6B3YMvv+j/vM6K6jLG0Wb7t3y+Nc2WdFGgpXags20bz07UGGBLhPqyWxH2NCE
         lG8xBXGaUXtHWVEAKhdkRS9yENAbsLkrcyfF5R/SKFsY1Y4Jo6KahVLLsiqtJLxpAJ5X
         lNL8Y2mLsmRm8pOvRlNS6Nvx07/p9jc0Kx3Pag4g/maIsrs/UgspV/y9DCo2UzT9Nf79
         L4pEC8zLCV+PujzmO7ZeR1ahI8lciuM/HO4UTZw/SEHlBRK2xrezvmlOwUm21hCBgbZj
         MtomI6oEs0p7qcZCUOMaBVUfYMU8n8Vzy6wcG840ABnc/Op3GP+F/0GTqMqnL0P0vbIr
         1HZQ==
X-Gm-Message-State: AOJu0YwQUvcwoPdl8YGkQLh+doCiQaFqXr9z+iEuB7cyoB8eDE37AM9R
	QGRhwhgZnXCjPpn16wA04vXwZVw95NmVu/NpvubJc8Wbm3j3qVkyF5u9fVjzw1zqBmZ/0Ds5LST
	6wldzfRVo/suUMd15gRfGa7Fgky+yPqka8HJEtlUvkbc4eojAl39DeQE=
X-Google-Smtp-Source: AGHT+IFcngMD7OGLA3YYMARqdGBgGtqy/kBwyL2Ao0/kzGLxE3GAIU+DLZJAHtZyTPChBeNV+ou1gfZuTQlALLEBRRuKv9CLzATl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b01:b0:39a:ea21:1202 with SMTP id
 e9e14a558f8ab-39d26d95dabmr1549435ab.5.1723795736322; Fri, 16 Aug 2024
 01:08:56 -0700 (PDT)
Date: Fri, 16 Aug 2024 01:08:56 -0700
In-Reply-To: <0000000000004e582f061fb691ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000876e60061fc878a3@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
Author: lizhi.xu@windriver.com

BH_Lock state check micro buffer_locked not work?

#syz test: upstream master



