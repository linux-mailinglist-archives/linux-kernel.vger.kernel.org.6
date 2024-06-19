Return-Path: <linux-kernel+bounces-221143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9231590EF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF6D283551
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14414EC60;
	Wed, 19 Jun 2024 13:52:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D413DDAF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805150; cv=none; b=dRp4dAPhNjWZf3O2dTVLcyjThDvB7J8d5qap0X6xhdHdfPWIoXWSt5QrxjkmZdxIZYryfxhhkFyZAFozUi6jXvFLXkk6qheiXRWYWjCSTRxLTwpgXWyUIpJgAyg31vV1IVsyatRbY0g6r3DPYzAN8JPXyF6OXe7hEbdUbj9f3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805150; c=relaxed/simple;
	bh=YSpE9S2xxyLbufDRVIPgnOEAcdIQHmLKAesUq+HAkcU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FNP/TY8HrEVt3Tzc7nqHhwcb71mOJxV6qEnCcniCaJlgAAdTGI7/FyKENJ+Q5KafbB3THT1MgLOxWzFYrYpNTQocqlYhgJUbxITfk/tsL0NXyjAxLixV/CRtENkpNJIM4Q2z9hj2eL6Q0FXYabsKnhbQRAJdGkEmzZbmzHnhPRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37613924eefso17626795ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805147; x=1719409947;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSpE9S2xxyLbufDRVIPgnOEAcdIQHmLKAesUq+HAkcU=;
        b=m6SxsKNHRcW4BjP6GodQ/DfaM77Azww/+bl2BbXZBA0IIg4YtApKP0w8I0bKLD66bW
         JbAZyjSs6qAOgi5BE8vuD1NekUruTeiIMbNhGJNlLMmzoLF2xV+KVRUJFU9DqoSkThi0
         jGo1ZV+WcHOLqqBfk4Etls1WLd5WAocOIyLwen0LaRuX/vAA6cqgnpFfgF9/MM5gCMHc
         WbtuCTnK8DW12+I5iMHpZotdIsGJKCYWCnEdVYdwi1HMv2HJosmORe1W7TRu93KIKIur
         yn/TnrTLNUhYFzuQ2fjMrCD2I/HxxFcr6ipWDk/fOZo+C+ziVV/8Gd5nMXJQWBa7CC2K
         +1ew==
X-Gm-Message-State: AOJu0YwtIaU1ZOEm1naOW5NJ6uv16YBVg4X1rFEdBpZoHkgEjx2ItucN
	pBc04hg6AYfsdljwYUhN6pqLLWwn3ZCD+C//iR6lWLB2G7q81KylqrXz84l02diMCK7VTBGiOHa
	F6199K79G1a2aQnA1cpT++2Scq8hvN5ZpNbK0KVeBKEZCC7co8mfGyx0=
X-Google-Smtp-Source: AGHT+IFXF1PwSNstlp/VRJ/BmHkVaBriTLVKLz0/0UrIJ4UF2+9LELnCah0VRMwHv0MhRmqLUw8Se65Ys76XPY013VJccjpqLEBD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9808:b0:4b9:6f13:faf8 with SMTP id
 8926c6da1cb9f-4b9abe2932emr76153173.1.1718805147334; Wed, 19 Jun 2024
 06:52:27 -0700 (PDT)
Date: Wed, 19 Jun 2024 06:52:27 -0700
In-Reply-To: <0000000000007a5ef50610c5799c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ecc42061b3e82cc@google.com>
Subject: Re: [syzbot] Re: BUG: unable to handle kernel paging request in bpf_probe_read_kernel_str
From: syzbot <syzbot+a0fa177e13690b663c74@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: BUG: unable to handle kernel paging request in bpf_probe_read_=
kernel_str
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux 3=
2019c659ecfe1d92e3bf9fcdfbb11a7c70acd58
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

