Return-Path: <linux-kernel+bounces-381024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C39AF936
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EEF2834F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A49018E058;
	Fri, 25 Oct 2024 05:44:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DB1BC5C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729835051; cv=none; b=h89yvMY4BAcHjRntku+tjtAADFyPooPNJxfHHn/nLEAuPVWgXYercacDhFrzqFF9JMPyzqvwDd9Mx9InTC0yAwaNwn0Vt4EpmYaYh0G4qVmzDCtX/2LcYzlIPQ8sKod9FaJKMzRTKamSq8kiZeqbCyeCtDXsCUOXHbHQFxSJ1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729835051; c=relaxed/simple;
	bh=b37uSE3Denko+MGREyZXx9iSU2x92nZ+Nz79EOZkaEA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dv8ym0sYbfc9rLpXHmRfHFjNCHtNnkqT7UPTD1Efwm1BQ5wg7Gx45HmEqhivIV/8woB6Yxw/kgUGNmOBGgEtnh1NR+B0CApaRrP/lijxSC1TH7YvwxhBPtATNlWEor8Wimo/4BFimp6yAbylXnL+GzEOIDf0nKKd0Dxt2KDzK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b7b13910so14983045ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729835048; x=1730439848;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiT6nIdw2XJzUlwCgPuAoXE6wrcRpvlHvMAwMozDubo=;
        b=ow+q6WhHR8FRynjyy8dVpJWNPyCb1dTVcNjQD3OnU0dKZ+QMEQY3vSVGCd6XUpRv7p
         khCK/GDOVZ2VQ/LG9vAcCaVCKKAuT6xXPkmo1RQoNUJCEtnB6+klRp70NkaUX9ornhYx
         BF812I1z1YVOeT0qOQze8k8HZJuOSEeIJYl4oMXFL957pTpQtSET9zOb7Bo2nEf1A8pg
         1nJ9uEVOFceiUf0GagAehEv9TzAileIY5M/N5uBbw4+B4VrlNP7FfVzGkZm/QO1HWYgR
         LEXOrMTBgVxAZGzXfWaszfEcrEAYK05VZrij/S0TZN5B59MPghRdqwaYuQl+dic/bWf4
         /l8w==
X-Gm-Message-State: AOJu0Yz3m3YxT0b/hz5Gbd2TtAqEz52Qu/wy4vOcdINAJzood6uqcCDk
	hc6GYNTnDxKjYWbNZaHl2zcUA2yNRg5lO0/yYl0ZLHlOuOwlGk3IN5/gRTsVOlyAtaHh4Z7lonY
	W7PGwLewmTI+02edVFKZ2rC8KXkIqTn7UXVyyeiUe9yBxx5UQrJ5J7t0=
X-Google-Smtp-Source: AGHT+IH5bd7gApNn2i4xDz+4dKZdktINiayVFJASpnKMSmuEuVF8PBBXOHPvd4cLtHA+t9zGm7xUg/GCOiAmfrvRVoUI74Ud01rb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fec:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a4de826f4dmr52621325ab.24.1729835048352; Thu, 24 Oct 2024
 22:44:08 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:44:08 -0700
In-Reply-To: <0000000000004e41110614187d35@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b3028.050a0220.381c35.000d.GAE@google.com>
Subject: Re: [syzbot] Re: UBSAN: array-index-out-of-bounds in htc_issue_send
From: syzbot <syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: UBSAN: array-index-out-of-bounds in htc_issue_send
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next eaed5fc0c322d75cfcdbc7a16c0c5023d9e4f6fe

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..a5bc0a5dfe7c 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -294,6 +294,9 @@ int htc_connect_service(struct htc_target *target,
  		return -ETIMEDOUT;
  	}

+	if (unlikely(target->conn_rsp_epid == ENDPOINT_UNUSED))
+		return -ENODEV;
+
  	*conn_rsp_epid = target->conn_rsp_epid;
  	return 0;
  err:


