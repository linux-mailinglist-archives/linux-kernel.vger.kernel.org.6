Return-Path: <linux-kernel+bounces-237522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06335923A47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99AB284747
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5715689B;
	Tue,  2 Jul 2024 09:39:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF815217F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913169; cv=none; b=sPjUBVvz0Kes7b5TS/Eun8CGPU40Ryzj50OTnEoKYRU107DzSHJNquiHzuTcUbJHMywVbT68mPYfAXytJDMI5ID18DOoPg9x4lXgKOptQZnc1rd32AFuxSMLlDePYOIdeUXgjl4X2O4rkUITVKGsE7SxO5bRwtbBRCaAQzz0ABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913169; c=relaxed/simple;
	bh=zeu4yvD5SbUG75V6+9YyZDDcdHUc4ZTFkm1jovp958M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NbrYVBAWyTtTXaX1vBHceHvdpSe9sQjWNmmYvQQVWxrkic0ZHgsY8fwRpfzNyvjCQYgCRHih+JYs/9BjXgCcY/1vH0fHvVFyYnzSAkPAKoH6KXVQjtmJKkDLy/IGx039HsLPCi36WiZkuVHgo7he1L2xT7MyddR4A8knLqrcF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f6200ad270so427864739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913167; x=1720517967;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeu4yvD5SbUG75V6+9YyZDDcdHUc4ZTFkm1jovp958M=;
        b=rJvVidWjnOLp4414hoIPHy4g2x26vwzxBTVwJ31zirYpqo9ZNucTXg9AS5QZe0vuk0
         ouJjikhNs5BQX/wv3cZbfcyYsxAROazcF8HYtwjn+ZPDi52A6gCvyUPG5ot49meUFRL8
         yUTXp8R3ly5MRh3jr50ToRlWRhuuDiaBaTW+gvBsCGJOcyUZieoZ6EiUVJT02lksk0H5
         ewNpIZvB9k0/uba30tT48SunD8Jc21Ui1DLw2lTMhqXtI4XSgnTmwUxRfeT0gWdHH22p
         PZx3+vv07z98M4kqxLYFxiI9uRAVUMRm17kWxEmszzxolna3qzGAAHXYGyU/A1X8NcsN
         NFCA==
X-Gm-Message-State: AOJu0YyD2YkN2eeV+QIIulog+bbD+SafFI0uhhufFcRf2l11Cz3i+yoF
	FiuY7T/xxRpRkB5TkEBmqFEP6Ey7Pq1VRANZw/9/nDrICXul7/UJyI5Xn0/vwDjsqtwVrV069I5
	2vQwRlfNxaXp7EZjrPFhKOiur/Q2W9XB9l3bbe6C6KHz65Bb7LVywBso=
X-Google-Smtp-Source: AGHT+IFekelir2GtbX7zysfPT4T9vhRzCxVRvb+m22l8oTMJLSAVSo5iRRghMAQaZsoS1sho8Ihm/qeQKnLAWr6B7ts697ap7mIX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:890f:b0:4b9:ad96:2adc with SMTP id
 8926c6da1cb9f-4bbb707534emr634165173.4.1719913167259; Tue, 02 Jul 2024
 02:39:27 -0700 (PDT)
Date: Tue, 02 Jul 2024 02:39:27 -0700
In-Reply-To: <000000000000aa1dbb061c354fe6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000611b33061c407dc5@google.com>
Subject: Re: [syzbot] Re: [syzbot] [netfilter?] KASAN: slab-use-after-free
 Read in nf_tables_trans_destroy_work
From: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
Author: fw@strlen.de

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf-next.git flush_uncond

