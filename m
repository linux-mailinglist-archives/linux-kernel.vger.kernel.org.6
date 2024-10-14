Return-Path: <linux-kernel+bounces-364758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3A99D8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58301F222E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793C71D0438;
	Mon, 14 Oct 2024 21:21:52 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8277156F44
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940912; cv=none; b=DJLc974IcPDD834qnizh8Gb8vnAOjwEBSVK20UEyvCUDcQhB96TZMwMYOiYwk+rGui0wSqMZ1PI8jvchhBLpW3c7cqvgt8aBHv+yidI8qmTGZCikYIH4H+prd8XkRHt5hlv2hyXRENOpCE6VFSixdFRQlS6cQAQLPlNixdKsHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940912; c=relaxed/simple;
	bh=sh0pr+mOE+8Igk+y81tnU/k9ZkaaK/8LH+o/M0+zw8A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qpyaxsX114zYsa9nHxydNlCgYrhhaMdTjY3Ik3yNJ+CBEgKGq8jxgZfCdC7ax43TfnSjjbK24HkiIIQEXXCNH2XFhCHrevaAbBtiDcYY0g2HHvkgG8JuU82cnckxBLGbrUwV4zYB6vakssBMZR99+i76Z4ERyFixrznmZjtmDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so12435005ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940910; x=1729545710;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sh0pr+mOE+8Igk+y81tnU/k9ZkaaK/8LH+o/M0+zw8A=;
        b=vupMZ9UmxpeFGnCrHDRVccLOUroY3dVeFrsZazSgJnJM408XlVrLmkyrZ1HA48pd48
         CK5Zsferv2u/0T4jyj3zQJOY/VE5EA9g1E3WQcHSU3rmwptTQcDl/G7NUExjDRCs6KRu
         2AsNGBEcV6QCVW4QQpZvsoDwqKlrl++fwZ99WzXeHw5y1x8CnUnXbjNe/rLUeTacH5aK
         9bDj7mz9yHGLMbuiWoymgDBxlbUMJsfDscqQi0KmgEv4eE6sqUcw4cfWnKhcpt4R4k7X
         Wj08W8vieZnabKia3IoJAZwS6ZhLuC5zwZ0urAkFTju8I/RKoZ71gl6xka+xdRT4MOip
         S9JA==
X-Gm-Message-State: AOJu0YyXcFPhafTRBHQgdUsPcLYyO1oeytm3gf1WzaCp2qDcZpR6Tw40
	FiNPb6EEFKtZzL2/P4FRsUwIh1kVGnvMBdCwwe4/4JfLQj6PT/x44c8sC+MDDT1xNEt4yPUVBoc
	Hai8FZ7RMdv9uQI6IndEIQkQnv1Bb1UkYK44B3kZUCgfUbqjKq3rTl0o=
X-Google-Smtp-Source: AGHT+IFW2ExMxBTVjB2Ev/Y5i3eahU8g5RV2S8WnkPduOqV1qX2eu1Fkpk9oluUxLsAD0ApdoHipulaVGYCWx7gkRmdsNaTXo5Z7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3dc5:b0:3a0:378a:884b with SMTP id
 e9e14a558f8ab-3a3bcd96be5mr64362175ab.3.1728940909910; Mon, 14 Oct 2024
 14:21:49 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:21:49 -0700
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d8b6d.050a0220.d9b66.001c.GAE@google.com>
Subject: Re: [syzbot] Re: Fix NULL pointer dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: Fix NULL pointer dereference in read_cache_folio
Author: s323713@studenti.polito.it

#syz test

