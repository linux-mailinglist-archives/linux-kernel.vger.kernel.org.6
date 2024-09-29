Return-Path: <linux-kernel+bounces-343134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8DC989718
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1678E1F215B9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FEF5A117;
	Sun, 29 Sep 2024 19:34:13 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0661EA84
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727638452; cv=none; b=bNi6hyVI8OvE17IqDOi6neYv589uSoszOZFIjfLJA21io7I4Ksts/G7OF51Lpyi/Q/XC5BzlvaanT1YYdHY0MwU0QErjs9HFBaGB9U3Cwpc9AweK82d9AVedd9irGR2Rbf/ILwCKftgV0KvbZPyMffb9YAs1TU6g/3LPVT9cYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727638452; c=relaxed/simple;
	bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=H6Ora4uAffvgMX65SsN51GiL1qwgVJtaR+VLM0ugVWIh7PSWPN7+hXQ1cS+DGWOI54yXu9yOWUVb4K6L02sNrZx4XS2hW00BFCFB+gz5qnBtEzFpZ8ef+NHYwhW3dvRKLLVv7h3PMnbbdqqBoSXdFxsoQ4BCdeYEsszCXsHpdUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a344da7987so33799875ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 12:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727638450; x=1728243250;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn8kTjaiavDdyc8/wlZpxrXePEbx3gjEURKJpd8Gq8k=;
        b=ltBnY4GCctxnhGepISOasmJgkyPr9tWDTUt1IYKPOpab8r3ueqr2VVkJfgIpjAK25Y
         Vs76nqN7xA7hB2xMwSl6J3U0/cuUsxeUmPLVD56N4ga0SHzzVDcHuMCVEq5c9CmJcwvH
         VrmmisLLxYv+7PgLCrOZI9RtJxZ/xrbso435vDWlFuo4UXOSBchLbSN3aM/3/xq9azId
         Gmexvoihimjjno5a9zH0ofSbTO+d7qDkbW0F0ng5Eg96KA8RUXmIzdMvvNmXgeIMzw7p
         aeHObr3EPMn3ZMSk9GE7HACTxZsk2wf0PG1NjXiIKrd9P4naGWLsvWPjMPTkUb2hcbmD
         6s/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDtvNBKY0a48NnCf5IuA+PVQLAEZW3NnJpbCNeE57JceCTyARVSzMk1U58VGgIxHO8q2E2QzT5N8PUfa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Q4yth/b2SMCQwFBHinpJmofRxu6EMemdfwR/2bHBY0r14Ho0
	bZjZiWN4CuLF1m/BCRH6npyTolZRTICpWPEGQEHBPvqmngeyiGv21Hl6lYzrvFbuSRUGbCo8iML
	O7m2LwN2RJJ/kipeh1z69mVkfPMvFH4pSiCtl8OLxvTVAxN6sHhgxDI4=
X-Google-Smtp-Source: AGHT+IGF5h2Lll3nBYst7vuQF26k/79JcOVm/Uokc5SOeKE8cmw5FbRA8Pa5lB3mVNKJ0jgY/kX9YZy6rrFdf54kJotYarSuiCpF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:3a3:445d:f711 with SMTP id
 e9e14a558f8ab-3a344fc8ff7mr100096185ab.0.1727638450550; Sun, 29 Sep 2024
 12:34:10 -0700 (PDT)
Date: Sun, 29 Sep 2024 12:34:10 -0700
In-Reply-To: <Qa_lEgHr4VCuP5FBI9GjQHZNrQUqZcYp-B3iI540IbqHw_5OKSHt7FntlcF5qeGA9e1EB2LpnLmYl-sNsiMLPrZ98UAPnEEmSk34lSjo_Ko=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f9abb2.050a0220.6bad9.0026.GAE@google.com>
Subject: Re: KASAN: slab-use-after-free Read in bch2_direct_write
From: syzbot <syzbot+19ad84d5133871207377@syzkaller.appspotmail.com>
To: pz010001011111@proton.me
Cc: pz010001011111@proton.me, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.


