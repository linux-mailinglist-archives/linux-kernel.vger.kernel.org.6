Return-Path: <linux-kernel+bounces-381870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B313C9B05B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280BCB2369B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA5E1FB8A3;
	Fri, 25 Oct 2024 14:24:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0B7083A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866247; cv=none; b=isXOxAYOC1AO0kBWh62tVmtoqnfqFklPzsPVJPhDrcaR0FEnTth+L764aGaDj/WR2bcvELy7tRD05f9+jFREgW2I3pkYBGWwIRkv32CLbLxuhg3v6f4Qdo90dvOCAJYuP6TrSnE0VMSL0G2zZo/rJmsbjh6zbqhOMUTHN3zs7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866247; c=relaxed/simple;
	bh=AdNetgnw/o2AGaAD5ULGYpsqaIOucqi6Cs5EYU5+CWk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LkHQodQv7BT7Z8sjINK8vJsQzMFDA79dy+TPcomuuPriowOpM8k/C/Px1yAa2Z5+cBm1kT+S7DQSqz9PclMKbj1z3cKiUS0RylFswQ6jlsrkTouVaZiTmNnSu1A2i6Cd6fqH4Ugp9/KrokVvmEzDXHNcYFLEG0mn3oOeKcnEePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so21618415ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866244; x=1730471044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdNetgnw/o2AGaAD5ULGYpsqaIOucqi6Cs5EYU5+CWk=;
        b=v3VMLF8Do/TztqdutsKFtlzkMb4jjbubn/QmvlczSBZqCujK2x8Z55Uro5W7+9VYEZ
         +0N0YC0ZzvZYzlKWpBx4BbSQ1HwVJHUQNnabh/ao8zR7QH3ottTElBe7S/PUL4ELR6wP
         2ZiKBXBI5lrltf8LW+/ILNBqjCxaCl9gNppcerievkcmlH5A1oMG3v7bqAxVWavoYZUK
         CN9f8etcN6E+0hfteQywgb2XC66+duCcH7fcLQBMDpUq02NIYq/T4ywyMLREbTKYTtfd
         SknDqerJZLguaDLlNXmEM/fnYiJRgwzIdDzVBSwc391gQQQFZ1Fbuo41MepDdfN20BmZ
         MpOQ==
X-Gm-Message-State: AOJu0YyzmwEM0f/UnIil0JtWHJMTStb3/Z0SFGGwqlQu2n7RsLz1M78Q
	Fk5S3Ei1CtbgpYquQ/BoQDmHGiZ8CfWqHebg9Szvud4NSCrLmNNPHVmJLRZjD/zIgHDAIEVTijE
	xfNqGUvZqe+ZBO0VAOTWrDuaTQ34GVrcgakZU87P1spyVZIPenZbr38k=
X-Google-Smtp-Source: AGHT+IEdXoMjpRe2YvGPgsJstvPnQpJpF95b1mcLpSh7NeXZ0q26gu6K5U1+dL3Yr8ldtI6/R1v3oI0AyZkPO4+Rh5ilVgE+oj4g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214d:b0:3a0:9fa5:8f1 with SMTP id
 e9e14a558f8ab-3a4d59df6d6mr112540745ab.24.1729866244475; Fri, 25 Oct 2024
 07:24:04 -0700 (PDT)
Date: Fri, 25 Oct 2024 07:24:04 -0700
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671baa04.050a0220.b833e.0004.GAE@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: BUG: unable to handle kernel NULL pointer dereference in read_cache_folio
Author: gianf.trad@gmail.com

// test if repro still valid upstream.

#syz test

