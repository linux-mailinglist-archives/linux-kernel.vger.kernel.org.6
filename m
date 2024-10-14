Return-Path: <linux-kernel+bounces-364748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2BF99D8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFBCB21D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70681D27A0;
	Mon, 14 Oct 2024 21:13:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B881D1E9D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940419; cv=none; b=odjn6n+aCOIJkuJ+eaBPhIwTzLhmBhlW7SY8sW0CDTk7w3wMAXUTrvTLxOlddb+uIbq6N9YBaYEtn11varCk4KELYjFU3OIgCH8mGP9JK3ktMZWiCM4gJbbgafKAwwwtQ9b+H4Iqe51Vae5D4CNOmAThcZ/qZwyY4z/UHPg6QnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940419; c=relaxed/simple;
	bh=ZxfBwRlLY96pWS3rv5giwEZEPfeuzdV/jBcK467SqDQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EQUGFij9PwoUxLPrDNXkIfdJ5f+yL7ZvQvpj6M9HcIIc0aZRYLHqbyNoyTouGXTQDvFa1xEgFF3VRdVZ9b9N425wQzxL7koKV7hKd/YHdgn9yn4xdkMFKIDU7fuCe4zj0V051ICLgdz7++wwsunBZOui+tBRg7jZ+J7tEFzJsQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c4ed972bso9796065ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728940417; x=1729545217;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxfBwRlLY96pWS3rv5giwEZEPfeuzdV/jBcK467SqDQ=;
        b=uaxuL4Rxh+i+gzBLWA0uJRFk3jnhDgBXZt/cxIv+cOKrIa7RwfgB1GtcyohDnzDovu
         duocvvWDzJJfEDw1SE0UwUpIrikxorNXhxUxi8BsC+F7BZMY9TQVXgO8xkETIS3cCoZj
         3lPJA+W4i7xr1F3x8nsnt3VarHH1BP/8g5CYoYERKKaz1WIyRPt7K3siaMWQYWQI+340
         ysOTQBCrn93+SUWg84sSpt+/+C5PfnQt3xihUpBK8M0RVHNTfinJInBrQizG+6iZt391
         LntH0F+Er47WLc9bRI9sZCOK+y6EGpS9nSZmorIxp1436SlpRjjBNVRL1Ys1YLoMjtD3
         oCqQ==
X-Gm-Message-State: AOJu0YxIB9ps5GIZlr/6eals3W/bIW6NDwmoad3EJKoFFm1AeEKBCeWl
	2kCLb57NlntpeGt4MonhAE2ara2C9NInaW3/JuccZqHoLucBTN8FF7j2XzzX8JRaaS6yCpmfGGw
	5e4LFErS6vHAvQk3J8784jWkOAd7V2Rhuc3dA/X1t9HEk/v5ccrOnBwU=
X-Google-Smtp-Source: AGHT+IFJI48vKy6iRMFyV0b7V2LwyUipydp/8iSYbClzSv+usLRy4ZThDK47zGFBAvtfJ3Y2lyiYBHbqgTt01wnJ2HKqhLTOiwd2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc9:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a3bcdfc2e6mr73322585ab.16.1728940417200; Mon, 14 Oct 2024
 14:13:37 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:13:37 -0700
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d8981.050a0220.d9b66.001b.GAE@google.com>
Subject: Re: [syzbot] Re: Fix NULL pointer dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: Fix NULL pointer dereference in read_cache_folio
Author: gianf.trad@gmail.com

#syz test

