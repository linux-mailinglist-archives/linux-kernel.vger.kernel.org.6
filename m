Return-Path: <linux-kernel+bounces-403580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24679C3780
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610431F21DFB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1292C381BA;
	Mon, 11 Nov 2024 04:31:58 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2DEC5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731299517; cv=none; b=K3DiDCEec0zDcdj8SShWsdDjcrfUqCCiWQXaTUpRLd35CuAM91bJHY4kQMSERqED23zMiQCJlfaZgJ0OCdwKxaJjjwLKlra5GNVvzBT/8Rhs76MBRnDJH51GCM09ai4Tr0auMYO99k7SlLpKd3I4qCbahLqm8EFfnOiIZLtBMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731299517; c=relaxed/simple;
	bh=xKKsu3yJ86D3xjk/+o+69N8G5fBIpcXRSHBREefw6cU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W86u+cXE6qqUATAlmWPUH+ehU3m1DbMDP453B4DC4Wk0RsPaPElsIiALyEqMYsqhCV5qc0+AGRYk8fjQS6cJBB9So/7a57F43hB6WzyOdKJfkI0XWV2bm+4Cj0m57jZFLCkWaeju+Tiv71KCugSRaQPvoHut0L/hZUyVRfd738I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aa904b231so486953339f.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731299515; x=1731904315;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sorKxfRdWXAsBwmpP34FSOxGOr2GbPMZe/pqKlJL8wA=;
        b=OPCUbFujR3SuaRlxNZlcysYBYlH8tarPGoQLYVmKH4uiKg+sgxQAUwCGz9DgvGXNh4
         lbn2VIvxWrK67brJzMrFy+6bQMXj/i+AyEbyKW8yXqhHz9iQaeAK3dZmsqsS6AiQ+gJF
         XHVUEFgVkFJCnvO3GpE3OHjrIP6BPNfHPGZr+fmmtv/JeWIDwgMgFX3YI50UXyedoUvf
         ceDGaqunUhA+3bc7x+/qRsr3yNdUnOz5yVH0/Q9fXKSoCVREMZwldJOLIDZ/b9huii9m
         5QSBPn3KCdcm0sgORe/SEB7z/jlvsauhpZwAsE1Et34uIJrg5RQHujzLdMSk0RjXkZx+
         42vw==
X-Gm-Message-State: AOJu0YxevLa1NHyMtHLp+ibp+5G66+knBMzRpDiHuvOZO9W6bTsfo6jo
	wcnHosUUSPnmlqV/n8Zo0v1CyTRfnQ2hxcuJ3bwqmAk1m6n8v0h6T5edFpK09TBsJ7RZDeiJvPx
	SH0WkATUmhEXrYZwz3z/94HRs8M0+R28PItf8Eavxp4gfULytmnrAUGU=
X-Google-Smtp-Source: AGHT+IGmK0QIsW8AoactBVsbat/B+iIHG4bscHVoRccRgptEHs0xDSBQePqLX0LtmClHuEuUQffRWfI0AZwImEvg8uFKkAmo1E1L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:3a6:ac4e:264a with SMTP id
 e9e14a558f8ab-3a6f19b1626mr128563835ab.10.1731299515347; Sun, 10 Nov 2024
 20:31:55 -0800 (PST)
Date: Sun, 10 Nov 2024 20:31:55 -0800
In-Reply-To: <671a8834.050a0220.2eb763.00c5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673188bb.050a0220.1fb99c.0141.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+a27c3aaa3640dd3e1dfb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Allow for unknown key types in backpointers fsck

