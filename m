Return-Path: <linux-kernel+bounces-373869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 861309A5E34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B01F24B92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B91E1A2C;
	Mon, 21 Oct 2024 08:08:33 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815E04C70
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498113; cv=none; b=oDDgV/nEEnd9/CfPiGUAThoGWg2IxtoMY6VQVnQgQeAO5FdfXIFmmwlrKi4Y4oF6qws25ShL62JIRfrDpQqd7NKQX93JIbvBvmXY3w1pfiwvYzh7o5v1q6wjuB2thwnQfobzW1lyUjxeE02BlVpK8ttP7eX4mrI8THHnm/zBwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498113; c=relaxed/simple;
	bh=7BEFaaok169hD29f3U7ZM6kdTNs/02qWrX4flaRMq2s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WEgxgL8XfOALSSWy85UdzNmM7MHpd8lMiaBdqPpfaone9RAniS5edgzejCWb98NvKCteVnm0cASHypS249/rLRKnCMsJKmS/s9gHJNFqulnoxr8ASAODMv9nV8nTNA6xIzligHEBxk2I0mcvuInpkUxHZB6utYh3tyGi473yXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b7129255so40669155ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498111; x=1730102911;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BEFaaok169hD29f3U7ZM6kdTNs/02qWrX4flaRMq2s=;
        b=E+NN+3yAlmXMWdyLSooJZCbOpj2wFg53S89DUpzLmwJb863G7gmxULIU//xJCynNML
         5yR3lX4H+jwKDyqpoPocLfmHGOd0oz87YhaYaVRFU5htW4SHpeUEQ2e6/Ec+v7/y5yjV
         5QZsHDQR0dbVnv0TPSN5d2M6Xx0JOpvAUUzYfWKVE4aMfYd+eXwBX1FFGHZcjuBLBR9S
         4hgzn3M/cDwT94u9Q9C4snDI3jx1Mx4qUj31OpaRB5MC9pmaEHzUFw9o28d9FGQ7WX3/
         1lCEWp+yio+VauascKJUfM1xl96NsUXMCR2NH14jWxU1+LNFz9MgNnCbvMaGuiPH8Mi5
         5ppg==
X-Gm-Message-State: AOJu0YzmrKT5uiWuAH6MzZrlBxp8yGvIBesdzfpqrLmofW0C6qHbpOST
	wy96H17VneNURxRjEswt/FmHQJE83Yg0kPl1CEd5P0mm/oWvf6rAQHSIiRpmPfiqe3jsNTLeU32
	fm5LQ6QIBIpCyOSN/xgFhBfJEQXahi/BYjDWPKdcgNohEx/OnRqnHZSs=
X-Google-Smtp-Source: AGHT+IHzoEImYM7HLTyNzDlpFdaJohYyHlduP3vS8ltqKdOaZag6i2q17SJ9iX0jPCV2z+pkYLb/3gx4xg79QVX67rDWm5ZKoEt8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa3:b0:3a3:b4ec:b400 with SMTP id
 e9e14a558f8ab-3a3f409e6ebmr87074515ab.17.1729498110712; Mon, 21 Oct 2024
 01:08:30 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:08:30 -0700
In-Reply-To: <67109a9f.050a0220.d9b66.0182.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67160bfe.050a0220.10f4f4.003f.GAE@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_bucket_alloc_trans
From: syzbot <syzbot+2b6a17991a6af64f9489@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in bch2_bucket_alloc_trans
Author: pz010001011111@proton.me

#syz test

