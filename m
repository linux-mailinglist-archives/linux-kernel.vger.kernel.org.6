Return-Path: <linux-kernel+bounces-343575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E97989CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7AC1C21763
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49574178383;
	Mon, 30 Sep 2024 08:32:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4711CA9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685142; cv=none; b=UBseIhU+Km1U03sAQIgiK6G9Pvk6YW7/Pq7HnDvfa9c+INaFpRbTilwU6lJ6BMb8Ct7HwnIgXeZJwUJY7g97SzxginXci0WckKwUdBvx3hMoJ8ISg5MFbA/wZgY7Uhi+CcsD8Cz2MtLAtw+F1pGswJZcvJE7SdAljH3KttQ9H6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685142; c=relaxed/simple;
	bh=17u/iTsaS2E9xeQVzQR2iNWn8T2A/VrLY/o3VUZDCTY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PEZ6HzptfiV4y/w0srSCsGs6z+X62q4U4Comhw6J6B3vHmAZ89YRrQ7AhbiM4r+kf+32ar1szx7mOjbgidUjES4tn27pDKc+RqBg+EcBEOlmeYUJVkcuJJHAdclnbOw7mMdDd8NFx6dvGCWvqidpwO9bzk8k5sOfVgpcQ7LGzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3412ecb29so39346845ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727685140; x=1728289940;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17u/iTsaS2E9xeQVzQR2iNWn8T2A/VrLY/o3VUZDCTY=;
        b=cEK5CRDAEjkyL8cXH4v/1Kl7CCePuy/uKXNzc/gPoF3nRjlJKEg5AicsWKpoD4VBHF
         p7Of0eF8/oIOPt1LBNytxMvJIInrxqr9I/cxt94ZmUYH7zOWNc66Ie+W02DOP4i1uMjv
         VrqQbEWJVXPVsai1nGCT+3HEmwB3XulI0EpoykjPb4MuGza9XARYhjBTC9uy3ZZ0nvKK
         imYkO8jk26RD1+8jIzPg1WNQ7L37xxBizz3RPMJ1MpuWpBuB4XHRLuRK6YjbNwnPFw+8
         CLz0eqFF/kUbBgGfQLcX5nZ6bCCOvwTsM3PF9XO4DgJqHnIAnc0/3K3vFZXoFz8E39gU
         I/pw==
X-Gm-Message-State: AOJu0YyGAuVG2e9BZMthDwyOenAMLzTyVZuuFkrCdylBEjhxNSiCxSIs
	6VFNmusXtb9F8vdSEvoRs1ZeAAmbA4Rpc0EdFuhMe451xlB5fxR1Y5rb4gHy/Pxv5rBZLgqWxdf
	PIz0cfQ9Gsy7xfWMgoc1Lz/bNKttyx9WXNwDLIBvKppVWQ73Q5Zl00pU=
X-Google-Smtp-Source: AGHT+IEJnVobnsXGSX5oK0/XRIB0PdPyQct0I33YxulAXq406pdwdIJJdEf/rhuYdPOBmyL3ITMTdkYCBmT20LlmdIBYxHhQXdJQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a345188ecemr83560445ab.15.1727685140486; Mon, 30 Sep 2024
 01:32:20 -0700 (PDT)
Date: Mon, 30 Sep 2024 01:32:20 -0700
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa6214.050a0220.aab67.002c.GAE@google.com>
Subject: Re: [syzbot] Fix NULL pointer dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Fix NULL pointer dereference in read_cache_folio
Author: s323713@studenti.polito.it

#syz test


