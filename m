Return-Path: <linux-kernel+bounces-297755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5495BD44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D53287CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E33F1CEAC5;
	Thu, 22 Aug 2024 17:29:58 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A01CB33A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347797; cv=none; b=HpPMos1fNthGXN/wh2h3mzQwX839+xGcao7s9yRSeus2MjZT+sIKrBY6AxU+ievR7G8/0Mj0YX9jFP4y2X76jB58ySTw1gWB3MZuAiNPmvElESiBW+KgWbiuUdSObuHV8nnGKjxN/HyWUKTPfi4oo/3e0ImbxdLgFhL/5aGsKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347797; c=relaxed/simple;
	bh=yRtikrtUpmElBLFpC5COBd2S/vq5zJol2ArSPVHFkyg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uphVcdBvcSNNfcDco19B/PwJJntPJgAiyK9BwU8tT0TMYajDtol9RExSaXu4NauI5Q09RslZTialgLzbRQkLwl13/r0seaHOI17TbUdot/w5c2LTSaFS/89bphBHlvGV+IujgwwBDqscOkOpkMq2Tlob50cS3AmYqrCiuSc2T3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d415635e6so11522625ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347795; x=1724952595;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRtikrtUpmElBLFpC5COBd2S/vq5zJol2ArSPVHFkyg=;
        b=ZA2cpqpkRMCZHcyXo8kTj2XkjbRISuKlChJ+Abs/kSPejUnlMPswWWlUy+RxBeERz0
         VgQv7ychUWAA8y7DtAuiJkUjU8091SNLq3fTkLdV6krOCBgHVj1pd0wWPmtu8xSuQsXv
         3566yxmjFiKYjWYUD4kp0e4D9uCaFb3OcqdqK0vorqBGKYALAtstz/bn7KaJFzZ5nMzc
         r2bB2ztzyfQk+HUq3Eih+lh/hdGYiE+63TQLJD3vMaesjHj22RRh78utvsvBaulNOxaP
         07oKSPzW341hNBm/iXi84S8DbondzeNRDrV452pahxw/JiMLUoMwg9ecnAEgOYpL9nYB
         fFoQ==
X-Gm-Message-State: AOJu0YxdSvXnprgA39SCLBrXhY1ab6XoLU1mbxRXzFeHuP/8VQAN/DgA
	nLKEcXtlMhFZfvAFQ2EVeYUew5+V8Ul3uxnjWkwr2jJbOWL7pQL7EPOTHEf1gUtIlZhcJlvAONl
	wgUwfaJ1G3nu7umKDO2+w73uMdsx90w12kWHclychFJvzjq/hR3DLUFA=
X-Google-Smtp-Source: AGHT+IFG+IXkvt8r6OKq8QG/WvG61LNxCK5DSxnJKUNBfxtJF3Sp44kyvl4kvBHaZ7SMEj+E5Ocjlzp+H4am4W/Z2Qw8+SsusQ7p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:397:b509:6441 with SMTP id
 e9e14a558f8ab-39e3a753ecbmr264235ab.2.1724347795718; Thu, 22 Aug 2024
 10:29:55 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:29:55 -0700
In-Reply-To: <000000000000e84de10618e3352a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5523106204901d7@google.com>
Subject: Re: [syzbot] kernel BUG in __replicas_entry_idx
From: syzbot <syzbot+6365e0d1ebcb50170e86@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: kernel BUG in __replicas_entry_idx
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Delete journal-buf-sharded old style accounting

