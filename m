Return-Path: <linux-kernel+bounces-250406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A4992F77E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BFA1F23D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B914374D;
	Fri, 12 Jul 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Yz3NEP/0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUK9ASdu"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFB81428F9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775057; cv=none; b=XN+hl71DnUXpYrKW7riivrWtSDxdDfLQz6yW4nxLSf+rumKWQgkyKMalGlQNWidPI3puy1OGiMeyDu1fxKmCQdYcseHZ92ok/MOl+NopkS9OEb7ELvqx+HuGEAU3clIu+JbpboZTagVHQe0Vwzy2aB3iW0m7k2BdHE785HzWhu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775057; c=relaxed/simple;
	bh=HYQPf702jtmtqHwiiK93ZD9gJb6Bh2+y1F+SU4mhwLs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=hKzcHJ/cDPg8h2gE0Dn/pijvM0o8QtlDv4L5jHyzvvUPqU8Qg96eYqDr6bj8Uo+pETZJn3n2oj3xGleter+R/QdoGGlr5kNJCGAZxKT5zPZySrTGiRoGXV7JehCLA5LdTYp5aVg7Smoe37OvgVVnY2WCnuR2YV6o+ikmkKSZZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Yz3NEP/0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUK9ASdu; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5B97C13887B7;
	Fri, 12 Jul 2024 05:04:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 05:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720775054;
	 x=1720861454; bh=S8kuUOlqHAm/2VJ6W9Kwa2XQoBvPPN3nr/A5wlnpq5c=; b=
	Yz3NEP/0xzZyReGOGNEw6xOL4NVLyDEP7UOpusBZmSClo4WdGthhRAgkXR2doFeR
	8O1MP/wflOpyyfSARyoGmUaWy+RF3LwM4L48l763R+yWgts3uLKziNGDlGbnBhOb
	BKNt9Oj4415M2tAQZSnM7EX6vXYwUACW401K7qfZRgRe1kOk9Z1mjoXU6lnTJHlF
	0ntNvZ3H2qxYEufVgNXmt3QVjX1H3cCtEaViefcuDwTZ+gg38VEGtRD0PIcwr0Kq
	l2AOBBnMiC4uO2RHnVWRjvJdmTA3uIAgVOlJCre7zKcZSoXjG5KvN2Wx0NntM7K9
	eu7YVGACn1qaYrpSAsLShw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720775054; x=
	1720861454; bh=S8kuUOlqHAm/2VJ6W9Kwa2XQoBvPPN3nr/A5wlnpq5c=; b=n
	UK9ASduNUHCTKrDR4Dp5EgYaXpxiZpLceWGcB3abXRUJjYJpqS000oNpgtrZFjzt
	T4EX8i7rjuVsMTn83OS9yp893rEEjuu8WBAMJTu48ldsHWslq4+XyPe2daiHFXdI
	Q5/knwv85DuxUcRLoocIIBzOrDGNzl0ZuyxZz36oXbxEZUgK7nbwVmhG+jk9Ia0w
	VSbLP6/XUnWmAELtF7dhsC85Ip9QqObKXyxavpOlgsCyehczSpn2hwlQqbjKrATh
	GKNJ3PqBuYpJGzzlpR2cximRgz5B5cYTPOCwBIWYqVL3EwVIQO70FRIvXpjsSW12
	KFzIS5tjT0YA8bTpRTkcw==
X-ME-Sender: <xms:jfGQZpFrTsPjWdIizStOXl17PoLcawGsG7KcN-7GwUPZWfmCJzF6lQ>
    <xme:jfGQZuUuqszBzRdj92sF9rL5pgrbj3bb6r0srg1h446MEthV5S2n-uNu4D9odU50D
    lDC48ZJdssNcz0wTbc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:jfGQZrINFNOX7NB8bYk1eRK0bnO8Id9I2X2V9ZEStOa8RcuJ49yf7w>
    <xmx:jfGQZvEs0yQSneJn9bNcG9hsmD1xR_Y5vyv7L5cPqz4usHhrgV3MgA>
    <xmx:jfGQZvVsuhDeo6qqwbvbNo6kvmdl-ABHh_Fg42HmPLmi7NYovExmuQ>
    <xmx:jfGQZqMeBwbWLQwutuRZeOorVkZILoIKiZvXGy1vRU6oRWiWJ9RGeA>
    <xmx:jvGQZhLX4fzJCokTY_FYC0eYRRFDCx_tk3dmg3VDwtjSm8Gz5-8k7K0U>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0AFF4B6008F; Fri, 12 Jul 2024 05:04:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f6afe212-8b28-450e-ae54-0de996be078e@app.fastmail.com>
In-Reply-To: 
 <CAMRc=Md5zmFxXXM89LQs6dspC0xnp_6=z=+a2SQypWjwpiRgow@mail.gmail.com>
References: 
 <CA+G9fYuCp7Q71_o74yo9ge_5-G=Ho9bC3kJdX_JvtoqWOQujkA@mail.gmail.com>
 <CAMRc=Md5zmFxXXM89LQs6dspC0xnp_6=z=+a2SQypWjwpiRgow@mail.gmail.com>
Date: Fri, 12 Jul 2024 11:03:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc: "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>,
 "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>
Subject: Re: next: arm64: defconfig: gcc-8: drivers/bluetooth/hci_qca.c:2501:2: error:
 label at end of compound statement
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024, at 10:34, Bartosz Golaszewski wrote:

> The actual code looks like this now:
>
> 	case QCA_WCN7850:
> 		if (power->vregs_on)
> 			qca_power_shutdown(&qcadev->serdev_hu);
> 		break;
> 	default:
>
> What can be done to silence this warning? Or should we just ignore it =
because
> it's gcc 8?

clang-18 and gcc-10 still warn as well:

5:1: warning: label at end of compound statement is a C23 extension [-Wc=
23-extensions]

It's easy enough to fix it by dropping the redundant 'default:'
line or adding a 'break;' Luiz just committed a fix, see below.

     Arnd

commit f14c0bb78769f2670fdd8bcd28ca5543a7601c33
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Jul 10 22:30:57 2024 -0400

    Bluetooth: hci_qca: Fix build error
   =20
    This fixes the following build error introduced by a887c8dede8e
    ("Bluetooth: hci_qca: schedule a devm action for disabling the clock=
"):
   =20
    drivers/bluetooth/hci_qca.c: In function =E2=80=98qca_serdev_remove=E2=
=80=99:
    drivers/bluetooth/hci_qca.c:2501:2: error: label at end of compound =
statement
     2501 |  default:
          |  ^~~~~~~
   =20
    Fixes: a887c8dede8e ("Bluetooth: hci_qca: schedule a devm action for=
 disabling the clock")
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 030153d468bf..ca6466676902 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2499,6 +2499,7 @@ static void qca_serdev_remove(struct serdev_device=
 *serdev)
                        qca_power_shutdown(&qcadev->serdev_hu);
                break;
        default:
+               break;
        }
=20
        hci_uart_unregister_device(&qcadev->serdev_hu);


