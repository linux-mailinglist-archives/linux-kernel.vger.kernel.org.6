Return-Path: <linux-kernel+bounces-307907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE29654DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6DD1F23D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB76C5336D;
	Fri, 30 Aug 2024 01:51:39 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3231E7F6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982699; cv=none; b=fzd+BD6DgcL+KxgWczVhHxOAtFvMKlrXQu+TTER56RvXXl4mL9rx4rsc2/8IFDZyVNtvUzncy9KG818C4phmvz62lcGr7xWN/kAiwJ1xgv06jn3JC+NjUDTH3jbFyDRuamRdzDwtuFi6F65poXYIiaJ+adQEFsBcsHbvLy+1cDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982699; c=relaxed/simple;
	bh=C4rCFqOS+p2gMTJIAuid9b8iLM4Pu5LztHIndFUFEUc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rR6cRJ1sFZjaTsuoOW6QRIlhFrRcrz8Edr1NKr5fq8h7MFXeHKBQ9V0JLbkaCgSyQAt8Kp/qEtKBtS7tKgC7trScuqke5veBVwAzLYBjV45ri6hu03q3iPo6pKzuI3+bA118sN/5oi++N5SllnaWSssnlTol5ug/7zkF0Na7a30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a1c57f4a1so133394439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724982697; x=1725587497;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXyZJqxp1NLMWlznB0Yme0nTC5vPrClwSBV9RzSWXxQ=;
        b=m0SmPeO9BY6lN0sR5Vxxu9vETQDcx6DF4SvtKrCIJF149hgsT4j8llp92+3EHIq8T5
         J7L52ZL5l7P2GWep2Msp7fY3x8G3M3Ywb7Jr7huT/met1Pu1GbTnItNQQjDRedDa83ug
         yOec489d2j8FRfJUntcPMNgcEIsosKxs31rVPZRnIuyyeC/2p1+FAAW4R1vZYqMM/rVG
         ++FxrdwJY/a7Mq7TVTj92sZVboWYSpAFPjIj7HQIBqfxmegyH3unYefDyol6X8xY6GNa
         ZIctcaW9qjJ3XAzHaMnM/OWii3w2jnq0An0EEjVz8DkD3HV3YTKHjpjPqGwadupOl1z2
         QxgA==
X-Gm-Message-State: AOJu0YxuNKhDeFo1R5fJmiHFi+w6PgxfHiX8iVNQU2IpaT6/PvHvutCV
	YA+OtMdil1SDw0dbJ0lDYd00wkIYK6my4RTiw4By2Tsu8nSH2L3/sYodROwrEWF6fkOB+sSw3z/
	pndlkGGdOfEDL3+pvGDow8bdt7qPOMltu9Mc2xAsWYkZ4J2dtzSgyTYo=
X-Google-Smtp-Source: AGHT+IFKL5jhq+SDFBCZfB8d4gE9bvKgsZfAqbmUQsXBU5yhq0jTHzrcAbGumDeeuPKK9lYIL7mp6y8gjSSkZYmu0KZU1oLXO+WY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b0b:b0:7f9:919c:432b with SMTP id
 ca18e2360f4ac-82a262fbdeemr4004339f.4.1724982697073; Thu, 29 Aug 2024
 18:51:37 -0700 (PDT)
Date: Thu, 29 Aug 2024 18:51:37 -0700
In-Reply-To: <000000000000be46510620da5362@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e72e8a0620dcd4c8@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] WARNING in hsr_fill_frame_info
From: syzbot <syzbot+3d602af7549af539274e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] WARNING in hsr_fill_frame_info
Author: lizhi.xu@windriver.com

missing lock before call hsr_forward_skb

#syz test

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index af6cf64a00e0..3971dbc0644a 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -67,7 +67,9 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
 	skb_reset_mac_len(skb);
 
+	spin_lock_bh(&hsr->seqnr_lock);
 	hsr_forward_skb(skb, port);
+	spin_unlock_bh(&hsr->seqnr_lock);
 
 finish_consume:
 	return RX_HANDLER_CONSUMED;

