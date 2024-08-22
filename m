Return-Path: <linux-kernel+bounces-297717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC14895BCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A08B25524
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD381D0481;
	Thu, 22 Aug 2024 17:05:31 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BD1CFED7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346331; cv=none; b=Bwb8r9v4eWX8VMwIT/+D+1OwDA6m8sgl8gXaPv79bN1kLrowdvV1FQK8uHuDEUeFZmHHXz25FrIMFuVp8qM0NYF9O6MdtJkOvnV1jYZQcfY5YEorYqYOUwZBtaRFs854kG6Lzxe7rtfRC5kEtYKihkauIHvy9Aa3DSIDYDAAsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346331; c=relaxed/simple;
	bh=MNquCfmiqIbx4wZ7hfGkMVmKIq7ix0qkeUEeXuucmbA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SHYfvwjQyJr30ZSx/Fl8O4CCrGYYyHHD6FfpBetw0fzEE6NV8Z+yTzYqDIis+Si5vlsx3JhCUPO4dLzGXHW3xMZ6BDad+Rlb1LupujjwmAzJdCgH9PPIrA0Y6LHbfsF7S7gDu5CHehPz5FGEoBE3ILn2XrLxGrTTauJjrSJQ2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f93601444so109152139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346329; x=1724951129;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNquCfmiqIbx4wZ7hfGkMVmKIq7ix0qkeUEeXuucmbA=;
        b=wE8a9WZBAcJSWzcvyfPZzkjukjGbCXO596uPpQgjpPza3O04Gl9MJflIwZwfnD5uCl
         mWKAJBTyf0LX7ncZC6Du6X8f3fMe/h/VNxMplYDIqs2NLODyDL8kCLViceQMbm/xF4do
         QhbDLz73RAb6uV0O4Krb71yMk9U1xjXbwTxHl0R7nQi77hxyQA619SzNPhTyFFA/v1HP
         PIBsixWPyqlKkBr/7jo0OE0GKg/LnsoBPJn1+Ce46naIEhyvFJoMV48MGerMqSo86m7F
         7IQ6XKQ8a8FfNyqdNZ79Sv4PFTaPvIj2UTyf2VQxLdeXQNkv7JTv0gXgcCDTv1fjGFD7
         yfEA==
X-Gm-Message-State: AOJu0Yzt7JghCxTgZpWZ6EcmApJNSiVArs7GBlXviS+HgcBr8KPKFCZZ
	lJd+T1oQ/icB/HCu3MLz1FWrw8SxMxSLIr+oFFwehbKf866aTzZBp6rqnjN4pHqc/20i35ZsUQh
	nL2EDGXsFTDjiIN+HyIj+DxivnfUKUyfCgMKTOkRkgC8rY1Mhr90rr9E=
X-Google-Smtp-Source: AGHT+IEycVT4T56QPnACyo/htrgviUWKIFxy2chY6wvUrPaqN+tGJvAmJ0ZzgshDj3VmQ7IhbMh0PIhKB0v2enTLuRV9sihOrxVc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8909:b0:4c2:8e08:f588 with SMTP id
 8926c6da1cb9f-4ce62d97df5mr261083173.2.1724346328602; Thu, 22 Aug 2024
 10:05:28 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:05:28 -0700
In-Reply-To: <00000000000039f54b06197bd063@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062e83b062048aa29@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in xattr_cmp_key
From: syzbot <syzbot+915b205d9237d1182095@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in xattr_cmp_key
Author: kent.overstreet@linux.dev

#syz invalid

