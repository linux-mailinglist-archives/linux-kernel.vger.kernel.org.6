Return-Path: <linux-kernel+bounces-367391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30D9A01AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C841F22B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AFE1925BC;
	Wed, 16 Oct 2024 06:42:58 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7919018E37D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060977; cv=none; b=eN/CvDPrykNTgdTdggdVTDxzVButa9ES2UG7F4v9hnq/fUSHpvnyGsuLA8Atf4HeUtEsvdkVTh+hpr3ryg2gojZTXMTHPV8sc6kZSjHLFfrSLo/isGMDnwVuFHZokgygei+Nd3EVm9DiKVn/HprPmvCn3qqmjly9uGY1Js6HhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060977; c=relaxed/simple;
	bh=GWwxhh0nAYzm5C4/pUUBI8qxHuAt745ivHJVcYQGU+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y2wUvQ0CET4k1j6lM6wwT9uqf1huOTEXMN1uH/ToWg5dh7BbK8PkFsWso4yQTd32KTus2vSEZ87cA8aPvbsxA5SjZS6eKp6zl4rL7NHDfYXcTk5fljE0GSmmjYayTqZ9vJVyepgSNvLoOWMRIIuoZ07TZ0jLn3lTVfrk+nF7hf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b45bfc94so39000565ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729060975; x=1729665775;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMo3tm5waadTIHnWKbCuWMp3eDlrAGY4SZ166H3iClE=;
        b=nAJSkyEvGsva2uNTr/5oN3sdLfONa/mRpcLlk/JaXryGdjEOhAVIGj512+64MbqEIn
         axGCy6eTiztxlJIZqIRDvXn9WDafHdWieDntFwwRtN24sEA/yItYYIOueqeGiF59/2NL
         gALLqgvTvsFERGhyN1t7FUcEBAt/ZgLC4QVq0ow+vev3WbdL0J0TFacnyU+87wTFigm5
         ZoOUoIiEK+rlYznMLAtzEGWSRwfg6o/zt4YPKIbbQKwBWXVyeYZb52l/TUtvsGBOzuBL
         KHvH6W+O3PYz6EBm+grzSdBrJuhpTnl1qlGCIwYLNl4NsevGgCqJrvj9vDoJ76wqILaF
         rhmQ==
X-Gm-Message-State: AOJu0YyVPgKkJOBVkDk+wnqeuDmI3iOUgV90E1RKUhkphGKBxWPpumiq
	SNTiWrrX3xsfrvjUMELJ+mcboy+92lNWYTtdQclX540SYROpDFvGCEEDyhSVgOUAMB4fh9EgBMW
	ixQizowkG6enhLrYnDvGxMtbD34yGbpJ+byoUJ4RnjV/2aYFzj6FLK/E=
X-Google-Smtp-Source: AGHT+IGrQ01lggTum9UOXFG1i4eHLdBgdlpx8YyGZBCupyxNaWsRAwfNXUXtk1ZT1R9OSlduxCAHlmtgNQgYhOHA9tPoljeit69G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c244:0:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a3dc4f9191mr31471695ab.24.1729060975546; Tue, 15 Oct 2024
 23:42:55 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:42:55 -0700
In-Reply-To: <66fed783.050a0220.9ec68.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670f606f.050a0220.d5849.0013.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Fix lockdep splat in bch2_accounting_read

