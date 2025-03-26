Return-Path: <linux-kernel+bounces-576505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1875A71017
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E1716E5DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13D217A318;
	Wed, 26 Mar 2025 05:20:46 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E86AD4B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742966446; cv=none; b=RgB3b0htCeZweb4RToyiFZTkP9eFW4WR09DtrVZSbVe56y8zd2dxPLRPi2FlmYG8reHMfSfoaqv/abYeBCUKFSEidm+zmsnV/zE0uqgtF4ADiI38VaYzxPftVIj8/wBAdK5XJTPUgDN4hUUYjypSjUinazc6JtqToz2njHL6ntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742966446; c=relaxed/simple;
	bh=tUPrxKhsrLu49BefXP52XeGxCXJI6bC5Bv6xo431gaA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=trsoJvNPTIsy5wcFYbJq/ZbzIQGPgtLnFYmY1T2ilAfj8nmYNMGhzdqQlSRjpeUmncDx8IYT+IRX/+V2XHHPNethgt13UI+hTuWSUssoP+A3efzT2EG7KAHb4/aUJOFXDP8Fdc3nswFOmlivrPDMJvOycIXDKSfgxIAgdWqwASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-849d26dd331so52675939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742966444; x=1743571244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUPrxKhsrLu49BefXP52XeGxCXJI6bC5Bv6xo431gaA=;
        b=WArmmD9RK8gdTEI563m5qGpnfkH3yWurUG+cmvxC6dPwn/kGplbhq+SbTqX5bHP91b
         bPxGKZNjOOuPDPYD8sc2guTaJ2yiYcGiXKKqySB+ijdd2jNczRqZmudal9rwfR2JP+jY
         CQ3Jc1iyrtODTOgT5UPBaAlqQsacaQoGCPuCoJmiPdRufnBOxlrVgfpn1HanmDzEIdyD
         99qHHN4gy5WTFTyMLBKc17PjGVrH07ycQJLLLx4L5UrNqROu2xbvdzob+829cDXdvw14
         JOtalLuI2+uGU370Qhfeo/Em4t/eskVkutrNkg9XtU+NumMuX3pOuVtBazVVP4YH2d9P
         tr6Q==
X-Gm-Message-State: AOJu0Yx1WMq9qb3ItqN03ZBuGNG1exKbpzPFRA7Pj17HHJw+QBiAnyBa
	B1lR2eYJDyKxHKnV+8mtcli16CSM6kVUFI6hgMIKy+IY7afxnbWI/ZtlmP4QFUqQoXYtjbXhCox
	uPhvnjtObVyeMor++6tTEcdGyPumP3KJH5AvYHmAH2OsFzGkUUSgbzz8=
X-Google-Smtp-Source: AGHT+IFjkfTlk9uNc5kneSbY9qVtv07u0j4ify4bNbx8snb+j5JOAqnYt5tWbWm+xKEMyvNj3MA+hE9op1ByqVPcmSdRMj2jon/T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:3d5:890b:d9e1 with SMTP id
 e9e14a558f8ab-3d5c20dddcfmr29597785ab.1.1742966444028; Tue, 25 Mar 2025
 22:20:44 -0700 (PDT)
Date: Tue, 25 Mar 2025 22:20:44 -0700
In-Reply-To: <67cd170b.050a0220.23b02d.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e38eac.050a0220.a7ebc.005a.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KMSAN: uninit-value in
 bch2_extent_crc_append (2)
From: syzbot <syzbot+79e4e34c2a37d5a9c1f7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_extent_crc_append (2)
Author: richard120310@gmail.com

#syz test


