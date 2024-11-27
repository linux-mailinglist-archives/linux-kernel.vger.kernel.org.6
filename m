Return-Path: <linux-kernel+bounces-423156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD79DA392
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F41F7B22696
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6517A58F;
	Wed, 27 Nov 2024 08:09:14 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79EF9DD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694954; cv=none; b=L24P6F5Yd45fPK7Xz405MBiUQBn4HtSzbZdHCEhgsqg0IFG5jNdRwROAjiK7O2jodHeMiT+6PV8jwiLSPV98j6MFpZN+OCWuhcTm7iOHfw5TOKuPyxUIBxgKAj8umjNKHFUEnLK9nFLLZ4MGVBtImvVtFwxyh+/AVPfCxRI6bDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694954; c=relaxed/simple;
	bh=PhZtHbnQcbN8cpsAvZB6kdjeXKwIqLQYyJizfvYfUr0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aPhsb0XkblDXzfO8t/Crv1F0Rm1nzOJ69QF+g1CGLNXaSijaTYONTvDKz5n5cTkj4tsV1+bw1WVnkM7gboOKMU9aSMlmJpeTvyhDpGf7hMNdC8bupUNz+QOW/o0iDQsbxrs+rLLQDL5MUp7hYEfCpe8kyA4O5TA3iH7e2q8i6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a77a808c27so68909685ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732694952; x=1733299752;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2s9s9MKWoyz2YV2vMohWIzgZGvPusmbpjpne+LE344=;
        b=GcKNftQIpQBmN00yExxrcd5pyh7wI2lNdW08eNsqWczJzAtKqsmqAfoUfbvnMQCbvN
         x4N9ptYGeQhs4xKJAd9XgTiUtCSK4ddM0US5Go9wKb20Qh2olPOeSxsM8ue4t3gFYCzt
         eeeMJNT5nrS0CY3JvCwAzDv2v55lCILqZ/dmSVxSL6zDmXhLtgfmCOWErf/tnAspXv8r
         wRhEdMQ4RghWyM0OdRbSuHxm3ZUmqxYu9Ry65b7G7ZLP3Ou43C7/ydRFGNi8z85Bm+3B
         2t6rwT7BHyY7g6qim3g7XjMdw/nJp7nar9EyOIVmY0I+yHJ5ci19TPxv8DliRtcdX7pg
         Reug==
X-Gm-Message-State: AOJu0YzWK90GZFq/a/mZ10CvK0iZ81VK5vE+VVDwhbe5FcqcRczBmbO1
	Z4EiYPp0crO/Zf7GxbPdK6F4Ccxt55ADNMobrdtONQsgyDeo/Kvth3+0yheBRPu3nNm1ZvtLgyY
	5pWjFg0XaO3C+YExuUSTt0tIIqzt0L5v9PfMpmzyu0I3Kxr/4OyzB7HU=
X-Google-Smtp-Source: AGHT+IG4VsA6kZCcRaH5w/2EfgRIUQ19qoZ5ro54D8zKWMMCNK8XeVhcmnsn4uRdlZZlhaA/DoELMSYp/nDBvStHTnoGwGNBK73S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:3a7:96cc:8cc1 with SMTP id
 e9e14a558f8ab-3a7c552322amr22262475ab.5.1732694952207; Wed, 27 Nov 2024
 00:09:12 -0800 (PST)
Date: Wed, 27 Nov 2024 00:09:12 -0800
In-Reply-To: <671b3f3e.050a0220.2eb763.00d4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746d3a8.050a0220.1286eb.002c.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+e22007d6acb9c87c2362@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Ignore empty btree root journal entries

