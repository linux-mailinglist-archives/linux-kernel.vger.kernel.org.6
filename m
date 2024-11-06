Return-Path: <linux-kernel+bounces-397580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FF9BDD99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 04:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95265284DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B8D190472;
	Wed,  6 Nov 2024 03:30:18 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66418DF81
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863817; cv=none; b=YsHTmHN33Z1lVMHTGj88sv28rl0u3COnLusGUf38iWsj2my+06FaMtOh0kJQ6zrOuwQ4LZ9j2GLPIcIm2jpKi32fgTk8gGffCuuvBST0AA+yZ4CmpO9dhmGfOU8rCpdX0TKmH6WoXAYXwDqmP8jVtpyUUrM62oWoXK7Xk4MgM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863817; c=relaxed/simple;
	bh=M3lD6cxcnkextQjPr7CViWpMtHaB30dJ56Qz42cJpCA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OROhTcRRwb1kpSBH3NnfkJv5ZPud7v23SIH+jIhkwMB0jnpSX40gEqxF6+sjE6hxWzjVaJHTH/djx35X6YxLYiLWYTLlPnl6BV/mJzYlKbeAZAu4jcJeCnxatOu8OKdNAFwXgO7g6I2XnBdAya31ligUFliEyxNoE8UH+U6b4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso51455025ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 19:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730863815; x=1731468615;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3lD6cxcnkextQjPr7CViWpMtHaB30dJ56Qz42cJpCA=;
        b=Wwr5g5yJ2LcbKqTZaFhpNLC0ItDOdW3NU+WJhxgEP0Dva7Ftb9GmLDqqjb+C3+8nRT
         lJZI++ytgJlgPOtV5CQdfz6khzrSxqJMy4FYgQRD8PQom3gUdCQSZPpCR0EBPJvoCKTH
         PIzEhyFdHMp2oSzXrQJBdNtbAW0aSmAStIIzp7u8dpy1AUEzwy4LuDWteNAS/uy9bWfK
         vHuvA5XGIWmy/KNPuc/CAKkfiwKPF5xkY9Ynj5pXwAm+8bxgRfILkqqkBfhH2qE6sTY8
         aMnOBfqhdB8zO3il0dmP8oOTpChvcVGIYBE9CqxVwTXiZ2dH2C7OpIxTCgre+F61GdK8
         NAQw==
X-Gm-Message-State: AOJu0YycBVK3DuxRgzPj5ODxoRB1EBZRG9TMksq0NSw71f2nlHzrIEzr
	uamhGFmesz/0qW6AxzaoSkNwPmdlVTliSeDR3H6K4yjbxkY05QcDKOa+Bnpckz19MIMFEpxSk9Z
	A2VjtaVmiJdD/xjBaxzJQF9uCpvDQUM8ouOOXTkZ+MDJdLVCzTdUr3BY=
X-Google-Smtp-Source: AGHT+IFbV9agwpQRM4yP1aOcNWOfMk1j8I7b01pN10FnGSEGfBBwNQzzncR2EioEtc99S5Jx8UawvUJXtyWlcAe6U5dkQOuhsjpJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:3a4:e74c:1042 with SMTP id
 e9e14a558f8ab-3a6b02d5fb9mr174626245ab.9.1730863815262; Tue, 05 Nov 2024
 19:30:15 -0800 (PST)
Date: Tue, 05 Nov 2024 19:30:15 -0800
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ae2c7.050a0220.2a847.1aea.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __hfs_ext_cache_extent (2)
Author: sarvesh20123@gmail.com

#syz test

