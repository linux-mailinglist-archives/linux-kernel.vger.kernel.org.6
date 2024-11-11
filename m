Return-Path: <linux-kernel+bounces-404879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD929C49AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D0BB253DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44EC18A6AC;
	Mon, 11 Nov 2024 23:24:55 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20015699D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367495; cv=none; b=CiViXb5s/CjAVQnaXoGuR3opXc69UcOuUKSDE5ZyTxVwtW8GxpITRCFn68LAgGRXuhAyF3uJKvpcF/VE1Stv745ihfgqE2bCksKgA3xEV/dMgnT9nlgO2YXagiDpkHaJKzemQ+1STIn0EVzgdxiSwjXyCSzL3iW7SdjIzAPV0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367495; c=relaxed/simple;
	bh=hbIpnS+URpvAyTJ1xTBqOdFUnKaXpRqxrapc6IgmV04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GyH7cFE6JoMzpSaL3UsYw8aClSMHb5ax7DWWKzkwqRDYHnk+Kf2zKaFo89KkHykcStY3WYwInnHf6wqqY/UNe9R/JZxfQhHRfivJtCnPEuv7c28jjtaO9KEXiD/NSZCd+1lglNRw9adWd+ie9hC7U+QZHkP8iIwEmxdLCyxBztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so68355345ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731367493; x=1731972293;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbIpnS+URpvAyTJ1xTBqOdFUnKaXpRqxrapc6IgmV04=;
        b=dXbwl7lzh/AIn1Y7J77bHVPZ7HXjrkKaQACQpKQXBWf6FqQ0oVJhdlruiCVOsNq8Do
         lgzSyP9c4tj/X88UyIMNA4pDaqCOtURqVopun/QjofAa5K8VuIlKXNZjcSm4st8zNu0z
         CYyeW+zyUkxU+RgMN7XU4KQTuyeWnUo+whHAGgiP5wOy7I1yiTGAVxG3a6JWmgf8ZZUK
         VIIyOV8gGyIMIGfCFQIGYUzEnkQxcTPbS/hGtldCOIefKSu+lVMG6gRygHX5iOCQTZcF
         X3LprTsSPffZbqO0ETAe+brjHu0sxIpMubfwIUwdOEgFyx1XwyJqf+QxKaINfw5Sdrsn
         qkug==
X-Gm-Message-State: AOJu0YzYkFyo37HUy2IfBXbX++e3LqX+STg1InSdQCYtsxEprhThcq7G
	nHTrtoBBIMh8fs3/fxN0sEK3l53TG+kxHi0kth/guzbZveFAIFRJ2UMdw01rlKhjbLPjTW/ingE
	3E0pYBvGYTvi8MGA8Jk7nvfrU0jxvmipzPONbpzsFe+t4aqolU7RL5aA=
X-Google-Smtp-Source: AGHT+IF8GUKCO3eCRdXWD68a6R5v0vYO9vUhb0v1VsPV69v1NjHDteJ4m4nfH1A9xt1oTQ2nElr9UPci0TfYEJVGlwxnJ6n4GHYM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a6:b9bf:71ec with SMTP id
 e9e14a558f8ab-3a6f19c2ad3mr152508935ab.8.1731367493174; Mon, 11 Nov 2024
 15:24:53 -0800 (PST)
Date: Mon, 11 Nov 2024 15:24:53 -0800
In-Reply-To: <672ecc13.050a0220.138bd5.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67329245.050a0220.138bd5.00cd.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in bch2_copygc
Author: gianf.trad@gmail.com

#syz test

