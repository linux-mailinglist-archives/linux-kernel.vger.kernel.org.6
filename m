Return-Path: <linux-kernel+bounces-404644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A219C4629
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A982840A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287BF1AAE1B;
	Mon, 11 Nov 2024 19:49:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA62AEE0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354547; cv=none; b=hfxO9xuAAk2x7laClDIT8+zQMz3wFI/otZZ115UonmuMaahukOmh0N7ZXrIqeZViWobBLjbjGo47VeHa7hS6caTawf9skJMUVaL4L8l2RfwCZsfQaxd1LGB4lXQwG7TLOf8Y3NadnrQUJzIf2SrVAwEnbq1fgXZ0DrIwDHX+nnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354547; c=relaxed/simple;
	bh=b91D0VtCE3kP5eIS4Y/nNQ7nHBy+Q5WAPkvpqIetcoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CD4bXuSRIxWNfclt6Ftl0WOy8s/tIL3lQ6IPoqKnraxjPFCbSljSkyp27bCK99b39zYa49V4c/zSdsvsS1eMU5jW5PzSzw14VwHoVYQwKvzD7HrXIYl12kA1XnZjOc708b4E6vZyu0rrBbGZ0Ecy8lJoteONST4IBRe23jitKq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so59267275ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354545; x=1731959345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b91D0VtCE3kP5eIS4Y/nNQ7nHBy+Q5WAPkvpqIetcoc=;
        b=EIsqdrOTLT/LiRsFbSJKE12Kh2SNLQAq3+GxcV3A8kcy/4wO2cJWSEHuOVKBTK97gm
         ib6Ir+jRMp8g0mKrlF8UjWvD6cF2RkvWKKaWBe9qO9jqfWidMaB3pmWy80JyDnfXgD9a
         NzGzSmvWaziAmcK78NuVO7QGtb77ed05UjeyrBtBY9z5Me8m7yaXcV2AkhdvR7IfWT0G
         AyxDsT68RWvnQ2iSq3pvkJAwNJ6F8XtoCdzr956iGM+1tjBxoYMgHkoCNuDXvKymX0OG
         9K5aDNbnVpLtBYoswOlan4Uw6trUDKM+KactXljvRK8EhaDpLxrf1Hksr2O02QRzW8zZ
         rYIg==
X-Gm-Message-State: AOJu0YyTJFbtXuz9Glgp+JJaxgoW6OKYPaw0YstViYvXXxcjrUv4RC7/
	AXalH7u3caobimLbodzIcd1EzwDE8e986w+FyX0/G/QbYQTutjx8agrpO9gToWAUStR1SbAwgD3
	GslUjUsUNTKGkOF5lM1XB91vRg6ENTZF0EUVAUf3sA1VVCKUqsV5kP4Q=
X-Google-Smtp-Source: AGHT+IEZ5hy0RZpUcQNMiJsA0x4Iz0GBtkp5jFdHQaiSrWFDg1tyMqeq4F2hV9J61Vg5zO+mbavhC+Gv3LToutAOjvpgO/ddtMf4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180c:b0:3a6:ad61:7ffc with SMTP id
 e9e14a558f8ab-3a6f1a6441amr164323265ab.17.1731354545470; Mon, 11 Nov 2024
 11:49:05 -0800 (PST)
Date: Mon, 11 Nov 2024 11:49:05 -0800
In-Reply-To: <00000000000005d7e10617c3a3f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67325fb1.050a0220.1fb99c.0152.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in hfs_free_fork
Author: gianf.trad@gmail.com

#syz test

