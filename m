Return-Path: <linux-kernel+bounces-242091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F36928365
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70123282B93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9F213C8F5;
	Fri,  5 Jul 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="kMFpwsvI";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="StylesDB"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4225481AB;
	Fri,  5 Jul 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166778; cv=pass; b=S0JGxkWIAWZRwLGZ8rpb76/c+wi7OrEKe5flq230cHavzCPxFTBiXKPq6GIE8acOMtcR5AJB/XWMaPAHR639+kJQKNMJItgJjuhdgM7sMiStB3AyKcAsFXpck0ybKwQ+8rJSVadraKC++hb66ZHsAMwgES4KIpBKJ/FIvMQHraI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166778; c=relaxed/simple;
	bh=HDBFrB9U+1H6Na8SeB2ejYtLMqLM4DgPnBZYGDCmFME=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=RNmbyCfPJRewGbmU3EfgudgMTbPNu6SwHJ/DzWIlHSryYif+MZxLjA2y6Ae7ydfGq63BChh4rrhaE0ODgnAahM+NkuqXmhxbNC2RXrbWAFGIUbGfgxQWjC1k9fLA2tgZNoBiH90R7wO6w+xeidy+X8JLcZfkTLkU0qcqMatqlRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=kMFpwsvI; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=StylesDB; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1720166734; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gl5nexwVkuoIwhgOIbBaOhBfqWlI8nmyb27HyyKv6XdYjnoJfU2bRbCS1UauQcyOLW
    2z3OWKuyXvxK5UnfNl7cB8In3ywssXW9UvRFNrynPFOpM7b0o7G9BCQGD+fyCzUPmNF7
    3xHYqgBpZ9+3s02O2GJ9aOp7g5dO8iRc1EL7jOd5GdrgwnYPmi4tbl32oASfdktCyoiZ
    WEu2woJpavdUZzUQ5dW9b2L3S4ejq6aB665o5pvDXsdV5cCAP2piZyxz0vgcve+x4/cy
    44hCkxHo1wg1AAKStJnqo+Vu0u3XDfC7f2C6DWrYol/WVaWEkJ2rVcMJVLz/bfuG6IZw
    Xr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720166734;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=a97yB0J0sjTTHMcRbynjfBCKVta83Ey42tiJN4TdkTM=;
    b=OhVE4p+Dp86eMVBYIddhGzOjjolKBO2p5hR9+5ewZLP+kmumbvICdCDmvJgtRYH4Ql
    gnKQbGcX9xwgH+QjXJXrGvwRgdSd1Hom/jH2StiLDWJW6FOSeItRrsSiLh0II6ME28kZ
    G+axLatTFK8wUmenkFVMusCMc2ul8z9stmHHwcpocTKeuJl8vYeBQKrXhELemhowQOO6
    XsSyxGo9KDSnlqz794fQOcH/MzmsPi1qfvQRravDSsWTra1k84yi2oAe5FUUNlIJ6sy+
    A4zHik+z5zvF2/F/NJejNAcDc1RaUrCYUjpnSOMBtUEv8E4bFSGWNhrgy7K49F95zZqg
    SMQg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720166734;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=a97yB0J0sjTTHMcRbynjfBCKVta83Ey42tiJN4TdkTM=;
    b=kMFpwsvIbsd81XW0VouTIMRlYW1xlT6HcXfU9/NbhToZBUvFK8h2NJUbng6SuVe2X6
    I0a85rPR/uRTXM74xuf4a1Vc2UOS5T6/hf2Sh50jHHEFKlP+vB9nND+0mOneM7FGSg4K
    XBTyaBxCU52YiedwGxbXvWYbenDUFuYZX99jK7dgdGvzgiP80MyTHS5JIo1ykguHhWG9
    KWGthG1eetHoqIzdcVJowupuSMAwqQMMuuYCLcMUwuZOLAX/CevE7EwLRquAMXDqtRRh
    YBiiroY7KieOmvOK7i6qxjAKfro5rMnjii4ctjNIlqS5WoSfSmuRaAvqrl8oftaQfdla
    lIMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720166734;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=a97yB0J0sjTTHMcRbynjfBCKVta83Ey42tiJN4TdkTM=;
    b=StylesDB/lgRsS+lQ5LcJxNXmcFf27sGs4aT9DklxOlApqThzoVfVKzhyeMiYj8nUN
    YDQe4FBftGZ6f4NmK4CQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5m0s3zACH4zLZuKVd30n/B17YES0k2Xt9gM8w=="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id e0838906585YVPi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 5 Jul 2024 10:05:34 +0200 (CEST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PowerPC] [PASEMI] Issue with the identification of ATA drives after the of/irq updates 2024-05-29
Date: Fri, 5 Jul 2024 10:05:23 +0200
Message-Id: <C7B869E5-95D9-426E-A2CB-8336CC9EF432@xenosoft.de>
References: <C2FBFAD0-DEEE-4906-80B1-5FA745CD9726@xenosoft.de>
Cc: Rob Herring <robh@kernel.org>, apatel@ventanamicro.com,
 DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 mad skateman <madskateman@gmail.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Matthew Leaman <matthew@a-eon.biz>,
 Darren Stevens <darren@stevens-zone.net>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <C2FBFAD0-DEEE-4906-80B1-5FA745CD9726@xenosoft.de>
To: Marc Zyngier <maz@kernel.org>
X-Mailer: iPhone Mail (21F90)

How about the other patch[1], which would be far preferable?

   M.

[1] https://lore.kernel.org/all/86ed8ba2sp.wl-maz@kernel.org

- - - -

Marc,

We will test the patch as soon as possible.

Christian

- - - -

Our tester has reported, that it doesn=E2=80=99t boot.

Link: https://forum.hyperion-entertainment.com/viewtopic.php?p=3D58627#p5862=
7=


