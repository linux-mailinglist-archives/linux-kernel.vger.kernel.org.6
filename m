Return-Path: <linux-kernel+bounces-354676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA16C9940CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183651C20EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99BA185B5B;
	Tue,  8 Oct 2024 07:33:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FF176FD2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372804; cv=none; b=WgE9gxw8SxrUN70n0xoN9GsuAJRBfUHHaN6h9kH81OjwMyEC19c+ClY3QaZalPyODLysj9M6wenfbn4ULxeM7xvO0Fq+spTnvvCPgFtv2/sZXZ3pgXOXVgJ/3vZo87Zr8ghKLNGY7BoK0Xu7qYPFzUgAr9iLn3aPoQKEvZk4SVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372804; c=relaxed/simple;
	bh=W+PX0x+/8c+uInn25egUjAFDR992Ap5uCd3zlSULtFU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q4M2FFemcXiCMTplCIFydeYWyHGvM/48n6OJPXNcbc3mCpd6BU6q9CMPdeHBmBQCoPq8Y8hl/81lIJtitjHs8zW37a+WCZrEWXxItGsOsiEVm2lWwSyWT+SI+699LZXdd6ZH965Zw7G8aWLJICtcAdLE7NpOHGk0KXvAJSEPGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a8a4174dso50259365ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372802; x=1728977602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+PX0x+/8c+uInn25egUjAFDR992Ap5uCd3zlSULtFU=;
        b=MbRgjqdyqATKVa5J2Vx3jSjwNY29IpAsfNVqHc7vK19q62E8rmlIt5v5Vivc0SXhdz
         nuldhlKFmuadECxWvDP6f8r65IhQQtFs5+ZvyvcfahQZxB5WGRA+cg5cx93Mzn2c02N1
         SzvNqJiNXiFM6jjMQib27jEtvy1pf+Xed0UgBE+mdEsI/C+sn0+l3lKkH0DunmBgp8XR
         LSrljw23rQdibzJikKavev1ZeSDAhWA1Z4auaadgWsqDZ23FHuxZIl5r7bFLnhFjzGY0
         Y7cYPzdaXUZhJ51SvQt32E1Dz4JbKxCp3uVf6LamQneJMPLbUXYDPcXF1TrpweaIZA0z
         1aZQ==
X-Gm-Message-State: AOJu0Yz05tFFso1SkJPDVwk0APE2AVwKXcNR4z7FJ117dRN2EnqHnZV5
	MrbGBLD+1tYuOIhArn2Wdqsi/F7gFmKtiAlREadeNA1tisYtj7uRQxRfxetmPd4HUj3Gp7sxVjt
	Pm3NLdX3UuYy3fFYW934PRgQwu8S2mu1fFm0aDkKCnm6blx574TttoGo=
X-Google-Smtp-Source: AGHT+IHacyJzrrjJLD/ONIl9XgWUcUvoxQ0m9EDXqYn0u/TW/AHT78TglUAxUVrP2r4QFazludjktQq1gHsotUiztAqfHjUqAn29
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fef:b0:3a0:8f20:36f2 with SMTP id
 e9e14a558f8ab-3a375bb6e7bmr135550275ab.20.1728372801964; Tue, 08 Oct 2024
 00:33:21 -0700 (PDT)
Date: Tue, 08 Oct 2024 00:33:21 -0700
In-Reply-To: <000000000000d1e1180618b99e10@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704e041.050a0220.1e4d62.0084.GAE@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in dbAdjTree (2)
From: syzbot <syzbot+412dea214d8baa3f7483@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: UBSAN: array-index-out-of-bounds in dbAdjTree (2)
Author: niharchaithanya@gmail.com

#syz test

