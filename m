Return-Path: <linux-kernel+bounces-318682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A956396F1A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4461F24146
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3163A1C9ED8;
	Fri,  6 Sep 2024 10:35:13 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78A1C9ED3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618912; cv=none; b=EtwXT+vRgNHyU3OhP/d7sgUbqbxKpOrDVpoPmECf7w2Kig2vohuZ5uoJk5pXTQU07FQ8f7bqkT8S2yQquvM9LwCDvwzKQK0xobP3KRgaZ5EldEXn1bdkUK/fVWLoGlBYeJoj2zKc2fPJdSKKLGmYwEv/4aWEoT0x5SwJx2ntw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618912; c=relaxed/simple;
	bh=S7Xu1cDYAA4EhW4xDjy1vlJTKV/EOoPgdzSNnVlYtO8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ITRSjZgNY/UlIkNi3Y0y23nr80QswC/Y5/8At15SN+/xM5w3R9n8k/WY37yv6F+YnFMjROYOnuAlQMOTpK1l93fPK4jMqz8sNApEDV5i2Gu1ZTjJtvaCqebdTZlb0vax2+LjvA1z+LQr/adYJzj5sYluZGu4ohCNbAdHKty42g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a1fbaba4aso566922739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618910; x=1726223710;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL+GZIl+lxNflYuL9JLBrFh0EG6nvxCHgUl8IQoS1vw=;
        b=RKflCf82KkPRbmJ10R96vSJfCJLqPcmL1EU2HKXG1TBQyflECmqCU+i0IPdoj5+IBx
         clZdvaPAubVdxNJhbnJUr+uFnAwL5m0v4A/30rDrrtuEzMViIFVmybWcC6PCTHnJgy8h
         ol5NH1v3oR64bl0eMnK/IZp41BskcNsW/ceuuXVTBoa6jt/0mtkRYE4IvqqJa1ypPlov
         gcEcqbqZ0CXbcwanMn/nMLtRzgZeotD5S5CXFw1/gEQhQtFpaLJ/3mYPGEaw4qm/fDXc
         Wo4OJ23nqGFDZssFU9Z0r5RjLddgHOoLO7xrcq47uFKboreq5K6kd7gZ7zxh1Wtf3+M4
         NmCg==
X-Gm-Message-State: AOJu0YzE/46XDOlEVJpqezHqaqI1foPZ+cFtXqLlwsfzEdObyzbbFR7a
	3ZEis8u27xPKBgHfgXkJf9kk5P9qUGLB+f3oMusD9LK1lyqOs4hqOXUCFsBERefCdG4ht1k4xVZ
	7SLe+vbzhjX4dGWJ4D+CzMOLK0K/MwgqaQGmebTKxbvUC+Tjp7qkx8nU=
X-Google-Smtp-Source: AGHT+IFqZh6wlv0d6jslgImyn69QwVH2x6slK6jy9TpxsB3xYJiMNZkXvQq02CZDidy+5mzoUri6NjPwG29LpoFvJUz8JFNUnfNj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2411:b0:4ce:928f:ad9a with SMTP id
 8926c6da1cb9f-4d0847c7c99mr196229173.1.1725618910602; Fri, 06 Sep 2024
 03:35:10 -0700 (PDT)
Date: Fri, 06 Sep 2024 03:35:10 -0700
In-Reply-To: <00000000000012cbe905ac0f28c1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f386b062170f658@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+a9b58a6aa2a3e1d37f87@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: nogikh@google.com

The reproducer now hits

WARNING: CPU: 0 PID: 5640 at net/bluetooth/hci_conn.c:565
hci_conn_timeout+0xfb/0x290 net/bluetooth/hci_conn.c:565

for which we have a separate bug.

#syz invalid

