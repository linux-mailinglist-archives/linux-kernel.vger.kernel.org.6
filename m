Return-Path: <linux-kernel+bounces-299286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7FC95D258
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6832E281C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE07189B90;
	Fri, 23 Aug 2024 16:03:51 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0201C189538
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429031; cv=none; b=nBgELhlJCKpiQUOA7bGjxeU1hIsxC0a3wiwGq0ZCsEAErshi1NIjy66f6UGqMri1TY53Maw/cuHvHp/sB2kgD/OGoxfUenCEYMUon2r1uWUS84UQ1T0bzaJ/oZwbSZ8+EQkVvzz+mj2CuQqaz8N7V91pWGuoswwD2yYPMaz9S6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429031; c=relaxed/simple;
	bh=U9Gl9ntcoE6UcdH2YdWhblDKpUeuLPy8ER5hsrza0JI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ndyiks3DPRMyEb5xg44UHbgoS1W0P5NIdJ7FW0umDe9p7sllG34c4N4VRyqSCECSsmlEdggLph95KjcoNOll9RicYkUKgeMvSGjGfWhO184IAztpJ66romVRAiJYP8fZvl4xXzl50Rtgvns4x2qlO/RrKElLdsIJC33Q826AQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8278114d3a5so148540339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724429029; x=1725033829;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9Gl9ntcoE6UcdH2YdWhblDKpUeuLPy8ER5hsrza0JI=;
        b=Dce6ePB9OiZixUSgI6n1VuJSgVJdTveVBB5DhBMe/zIov6s30HiAwWtVEHMu4Z6FlO
         6+mKAlhKAO5I4y8tenZomBZDydP/60PSpWCzHZmFavmqI8+pKbIqtB2f0ss49XAcGyD7
         v+N3BgNPNSBhwnvAmuRT2909bNBhPz1LD8CkKIoj+v7veGlC/2HlGSkoxgRbtgG9P1TI
         3996kMM1P5Crr46WFq8LfKUJpDpj28Rn9v1hfWpmI1Zy7TRRy7w8IDUgDgIjml/68qAS
         4Qdyf4me893e7nYdvaunn3HAeThy7EDGbyPNnAyhs36I3X5WBI19EZGhl/zrQ9aaHA59
         pFAA==
X-Gm-Message-State: AOJu0YxfcY6nJ8hScySfYiYCukGejkiIFdACqCgQRUUqiiruV9Y+G29Q
	HK/GtLs08Q3p6MzBsdYFiMw6ZKWi4HHOLtM6OYtECBw07xxIUmLAlYKwAE2asy9T+7fJOs06V5F
	kEm+EYg0ekO/H9y/dzjyoOajOT4GZrYR26xixetij7Jrw3mrXMLKY+DE=
X-Google-Smtp-Source: AGHT+IEzeK+fphXKaeazQGaAneX/Vy6bZfKyWpzNr6YRHnUf80VZC6zV/rs57N3u5nfwGRjO7q1lEDnOJubJh44+KbB18kGy2yta
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:396:ec3b:df69 with SMTP id
 e9e14a558f8ab-39e3c9df59emr1504365ab.3.1724429028820; Fri, 23 Aug 2024
 09:03:48 -0700 (PDT)
Date: Fri, 23 Aug 2024 09:03:48 -0700
In-Reply-To: <000000000000b6f58d05e9f95a0c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b41c6006205bebf8@google.com>
Subject: Re: [syzbot] possible deadlock in mi_read
From: syzbot <syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in mi_read
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master


