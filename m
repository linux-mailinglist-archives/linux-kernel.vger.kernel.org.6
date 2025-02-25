Return-Path: <linux-kernel+bounces-530817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0873A438BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A0917D540
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C726560F;
	Tue, 25 Feb 2025 09:03:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666D267703
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474187; cv=none; b=isKlDWBHlZhiQmzJAeyku83PSjvU6YgSwSCfDRoHe8+ElByp4NyS2BsVHCaVkX0gca1JpYjYKWbNNoFvEwvuT13tvvQo1Lalr/NoLMweXPI6SJ4Gnx//OPFVBhDlwpKbC1qFVD8rjR+V1vwd77yscjfcJY+m6Sy7MvcbgbaxqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474187; c=relaxed/simple;
	bh=ph9J2T2tkv6wl4oG1Qjb46B3HKdgnhT3IAY+Rqwbtx8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eJG6ZzimvlpHKq7N1UxkheMrQ8xhdhom+uNTir7P1UZHxu+OARDoVfFDrnCkw6/aFq2eFWdKgSaFs6HvjAOmPfD0izTPhAKIBRN/nzXKNgLMjQCCQItm9h8bi1tKwlJ7SDjXlbdhsak4hnklA2erc8DqgjnVE2gkuGNbyI2sUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso114468235ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474185; x=1741078985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhkqq4jjozW1nvqYWPjbkQaT1qBiVATIebTUIlROaOo=;
        b=fDTv6o1J+Ful0kmDTAoO99I/WG9zaf+4AXQZgdfOlwQIOh6uLi6kFAB/1P43V5++DS
         y1evScO07H1DR72YY5+HNsleRabiUVxphtncstRYxwpekHFA/GLuA75rShHFnJ0Li3lQ
         9ieVzCzYF5JWJ0UPKbcX4bFIp3q6iZEdbTIjmEjmLw8gtNho9V6Iau6+NhT4svKw1Dwe
         urQLpZ/oPtmejMFG2N4kh8/EiHtp+w5Y8r+ngMgntVL98nSFsfkBow9nLFsK0fz5F0w4
         /Yf2oWtuEIj7G+BCQpiq/fD7bB76s9NnYrVXRPFTVbebK18CEAJrfeLMGMRet8Caw8zJ
         mA2w==
X-Forwarded-Encrypted: i=1; AJvYcCXQh2WuJeXUqmEWFl8K2AVr4HmIRmUSyz4pC2n4XxrjJ2ZX/kmY0Xg2sb0B+0vZYBYhfhigN8oXYCIcVqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQX1IAqJmc4uMILwsT2Wvy2RqeABUvaxqdm020rWL7hApFekpD
	VQfXDrvwT+T+Tku3wQPiQfNVgfcnJNS3pLXlXO+2ZSa0W0DttlwjRmMcsDy37jpNwfFN5jMyiS5
	2HocwjSWYpxJr2M7BHVQfJZeR9K4oWGCYMdqZ7ngQm94DxLgWI/MpL/s=
X-Google-Smtp-Source: AGHT+IFLsCOJUUj8CK9vNXNbqMUJC4mTVTcOffAFpSxqWkdGJ1NB4AXek/WMlOjHIFyi90lJ9vMYReAM++p8bQgCzxA8BWrUGNnC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:3cf:cd87:1bf9 with SMTP id
 e9e14a558f8ab-3d30489e1femr26327065ab.22.1740474185335; Tue, 25 Feb 2025
 01:03:05 -0800 (PST)
Date: Tue, 25 Feb 2025 01:03:05 -0800
In-Reply-To: <tencent_A58D9392315DBB5DE51976CFB48D98A58207@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bd8749.050a0220.bbfd1.00a2.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] [mm?] general protection fault in lock_vma_under_rcu
From: syzbot <syzbot+556fda2d78f9b0daa141@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

<stdin>:4:15: error: use of undeclared identifier '__ref_stack_chk_guard'


Tested on:

commit:         0226d0ce Add linux-next specific files for 20250225
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e945b2fe8e5992f
dashboard link: https://syzkaller.appspot.com/bug?extid=556fda2d78f9b0daa141
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d3c6e4580000


