Return-Path: <linux-kernel+bounces-343001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390E09895BA
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E69283A89
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D48F17B4E5;
	Sun, 29 Sep 2024 13:40:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CC5166F3D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727617209; cv=none; b=hcmjabevjzMW5MpgPWTgZQE7yeezoGzuus3asVk3BTVFH7sUBIPpEw7h+6pPBGpADfjQkwTP2tQL42NYulOoTis5H2x8aCxjilI65/IhrXv92OtZtkfhITMx4ilLNtF7BbplKWcw2E8um7HsxuJKxoka2kbsWPAUL5b+nWMWa5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727617209; c=relaxed/simple;
	bh=HI7L3Nzi7HHrPtEzfU1a/XedgRThEs3wOwX0WJylRgA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SbuCOjvU5FL63vDBzqrToo9scyxtwfG/x1LK/qH9li5K+g6W94jj2DKsL3jI5SoOk+9aAg5pNH96Q+ZON+toRdU0m1OwAEh5ucf6wmG6n7xif/eODi/X4QtY+rqTdiEh/O/xyGgMEShEjsRUBuIdPKpMOxAqGcRK57FOh6XFdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a8a4174dso28917535ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 06:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727617207; x=1728222007;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HI7L3Nzi7HHrPtEzfU1a/XedgRThEs3wOwX0WJylRgA=;
        b=HtZKM7egbcQJxZxRRyDHvxnBnH2CEMLzWnPkB+Xd2GFud39koigeZQ093Tv2R7WGJn
         +hw0xvpiXNSr9UpfLEQEE3dLfuNct8cCJpQcicadj1Htcngsj/DNjzKJIq7BRuvzVkOh
         oDZg6rAlrnDZZJDe3NMU9T3ZaOtuDvAcmgUAuvh7Dv7BbMXtnzV55Wu4v42XqyhgTvkY
         rWyVnMlyYSXuCvTUfrR4+Zg/8GzwEDCDLENZPjN/oAtTicAhF3ELV/5J2RwKSuFrhYFC
         ktKYMbM8YkRMkh5YdBF/+LGs8j6msFWL/CrVPH6RfmZwpBVIox/wIm4JSRec28yAkAka
         SifQ==
X-Gm-Message-State: AOJu0Ywqw+d6lIngWA1c/ZAst813K2SeWNuThQgw4jaFgFe5HEn3eX2W
	/xntG8VVG8/tdufdplOwzFAZ2hjNhVKCzlgw9Pk1lAoYNV1ra2chLOgDNQBBThS+JBb87n1YKP6
	peEKSqUU8K/1Vo0nUIlf0Ms3pZINwhdBMHIEd6SQZUshCbNRYKQrfPow=
X-Google-Smtp-Source: AGHT+IE9E4jQXHwGBq1TNA3KdtxqDE/BysheG2TWizy5ACaKSPs5EoLm+Ie6roUB7GgDfHXoa2+0U2yQIU4/g7POd88iMWhKLpLs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154c:b0:3a1:a3bd:adcc with SMTP id
 e9e14a558f8ab-3a345168f6bmr62331625ab.6.1727617206895; Sun, 29 Sep 2024
 06:40:06 -0700 (PDT)
Date: Sun, 29 Sep 2024 06:40:06 -0700
In-Reply-To: <66ef45f0.050a0220.3195df.006d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f958b6.050a0220.6bad9.0013.GAE@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_btree_pos_to_text
From: syzbot <syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in bch2_btree_pos_to_text
Author: pz010001011111@proton.me

#syz test

