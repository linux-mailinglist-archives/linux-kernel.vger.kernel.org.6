Return-Path: <linux-kernel+bounces-299756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683A495D9B8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3EF1F24937
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628081C8FD8;
	Fri, 23 Aug 2024 23:28:13 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622C61FFC
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455693; cv=none; b=iUDtWx8rjBrVZeU13dw4+MSCdliE4wX4z+cjQCWLV5L7v6IV6dW/3Ovhy+KVwkGcDfL9guBodB7P5FIyWiE6Nwx2A+v67dxY9PwdyTBok5nlFmmYtDhGLeoGieFyeMC8sL6MVRRlKF8GEW7ExqnJ4dyYhVy/Gwp0hGvAeshFFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455693; c=relaxed/simple;
	bh=Rr1yHC4GkVt44KsDGAllWQXvdIIBCeFGse21PqnOdqc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EC3TL9wTBGjkHPgEA1Tn01S5t2fN015zHFQ2gOMtMLBllXc1FKH4tlT0NOErgUD1xwPXIduEkDtCqi8IgWQR52Xkm+VVmClKUH2CfSTkWOWWAlZ0Vqww/vrzj/xitfnELnYQB7dFibmVVqvJqB82BJOjKHrZ54ao8N0nbKgLiDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d244820edso22513055ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724455690; x=1725060490;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr1yHC4GkVt44KsDGAllWQXvdIIBCeFGse21PqnOdqc=;
        b=MYxPLiPym+Uar6g0clqGASCD+OeIhE514PbTXhkr7YnRCrOX84bM7WHWzzw8bvaLES
         2NxMmOlfBYAhGWrDcBHrNpswWFzeLgnYb2l5y6rdm9W47zEZr7OT0WCuPJFmUzvIXtkw
         LbFVS1K41v497ORpVXfa064jPNLFzmWooQ5lkw5AVOpuGRpeW0tZNBr2bzc24En2xkXJ
         vSe9QsrCyyKKAFean4GENkWAVaH0WZvE1/1jwrWahIqeKBfoTUttRmQMS/CZJbkubW/i
         yyTVEnOduhVWi47iivKSH3eyhhBiodboI6Nj0Ska8Xz0LBjbeT6M7hONkPGIx8h9t/YF
         oGUA==
X-Gm-Message-State: AOJu0Ywn/37Gnqj7dXq4S6Bpb9H0NepqnM7JPnVf4T4Az0MjPg8fewl9
	GlbJ2JiD6zfQFKjgxRmWU9wO+Gu4wPw6ZfKc4lKVKsn/82/1Vx57P3nrgv/g5KgLqijSiNOxKzp
	nUxlJ/SO7bFroQ7qEJ6O5jgCRQuIBj7+2Zy4+hT1rAWmzSO3hcQdOkzI=
X-Google-Smtp-Source: AGHT+IG1H9yIHFIyE9R9r4d3pfM03uTn2uA8Z55xpM1gHPco3mZwX11eLC4qdpNDgvkmJEUzYJpLcuZiL7afWaDK3xKPjetmcfe1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:383:4db4:cbe0 with SMTP id
 e9e14a558f8ab-39e3ca065e0mr2600955ab.5.1724455690645; Fri, 23 Aug 2024
 16:28:10 -0700 (PDT)
Date: Fri, 23 Aug 2024 16:28:10 -0700
In-Reply-To: <0000000000004492c2061b8b3796@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000df429d06206220b6@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_bucket_alloc_freelist
From: syzbot <syzbot+3d2944b5612507034fc4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: kernel BUG in bch2_bucket_alloc_freelist
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Don't use the new_fs() bucket alloc path on an initialized fs

