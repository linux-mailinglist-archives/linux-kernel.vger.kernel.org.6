Return-Path: <linux-kernel+bounces-362649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B8899B7B4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468D11F21B70
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CD3149C52;
	Sat, 12 Oct 2024 23:28:47 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52E126C15
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728775726; cv=none; b=Ckh3DmewJmfz0qWxt+LWfhq9mOYM7oVNk4KxgyxqkLyyooVBJULl56wJdXHmYz29GWfbSIx97D/kCpax0mbiWEXbOKRu5iYrIkx1fMsAQjOAtxkweOY2ZVR3Kg5MV68J3dmFdollHNGLRY9zX7Nhx81feu6uTbAJxur8HoaFj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728775726; c=relaxed/simple;
	bh=v+agA1GzMbSPyko2lfKWPfx4t+1C0NQ1LVVBokmMLiI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bUfUOKMPB7U9qQhNex/ygm3eCphVTE4WKwtKrNwQgLkHDBCnq06I0qmEPcm1aiUx1mjAS88dX2i2IYQjYfhBMtAJHeZJF1Sa9zO4osWytTYxc5YEuGwuHccjZvrKnMgSF+3j9/1EPWo5L1lwf4TtmE4pn4u1zFRy9VViuq31/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bea901ffso14252025ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 16:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728775724; x=1729380524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+agA1GzMbSPyko2lfKWPfx4t+1C0NQ1LVVBokmMLiI=;
        b=fzGtTv/GQPfIAG3XzY+nRdMhN6qgzC746UAsI8CE5yhz94zOexy92dwrwbZsgVHO1a
         NqgkbS+3PJmSBQ7uE/iF8lr7gdgKngOJV0y/i573Nma2f2HAmtqow/yIyutEf0omsAzp
         DrCY2pLR+qjqjLkElYAoPXEvbbBYuzUuHwFp4QK2xxVZekbmFlwBMNO9rbpMVVmqt92m
         cKTLfj0xuQqFiPx41LlNvICerUL8V0BbtpDvw+Rb1qzfpRB2nf0MTRDzlG/tx6PwY2Mt
         DYsnkk9WtXEowadVjUQW+VzdHbK61TScconv77Lv+JI/5UYl4f7/ueTenhEo2+OKlhHf
         XDgA==
X-Gm-Message-State: AOJu0YzfvyQBTiXrfJFsSfqIcPD+mur+2zjhj+Or9HVR6v5/MQIltevn
	LNvKkcV0Bj8gWpH33e0TBcl+XaPurJC4XMDX5uFYdx6+qIdZtas7g8FvSTJ74Lt9iaeQm9OZnPO
	se9PCEbtgT0DDyjN7dLIjDk8X2ge8b5FM3U99UAI6BhRG+cecdt4LGr4=
X-Google-Smtp-Source: AGHT+IF97E7tnw76gYYQrUhgNiHYak2toOCX4R1zNgZaGOM8pYpWILtI3fXEEeYYOlWWLI8EHT/uvJhvyc8gLMomBwgYvOpN+s9E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cb:b0:3a3:3e17:994e with SMTP id
 e9e14a558f8ab-3a3bcdc0bdamr33227985ab.9.1728775724402; Sat, 12 Oct 2024
 16:28:44 -0700 (PDT)
Date: Sat, 12 Oct 2024 16:28:44 -0700
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670b062c.050a0220.4cbc0.0027.GAE@google.com>
Subject: Re: [syzbot] Re: Fix NULL pointer dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: Fix NULL pointer dereference in read_cache_folio
Author: gianf.trad@gmail.com

#syz test


