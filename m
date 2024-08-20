Return-Path: <linux-kernel+bounces-293213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3D957C12
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15521C23919
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA07BB14;
	Tue, 20 Aug 2024 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="W+pm20zO"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9720439851
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125679; cv=none; b=c4rQozVPAmNHvZJXtA1AOlvekVutd70w1sqE968vNvSZtYWXfw05to/8v8d6aR6lLTqZQMrYoUwqCahotFosl6Zko7tKKpKKUFsXVCuiEuhrOEuZkt/+2X3cFIAOW7rL9lQkkqvkBMj0Iq93q2tnmNGiGy5ZoCFsHtWTZf5Icas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125679; c=relaxed/simple;
	bh=A5jn3//NS3x+LgskY0W2ovObg+zOVBXDXu40DajFuAU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f5DuHASqQUqs0ccSknJZUdpjp+UXH4P+/IF/rJ3I0S8r1ZAVEOK3s+vq1tJQv+CvuvsXTL+ROwdCnP1wyOn4Wd49Tqh3Yc79ZSA7Q0ClGHPc4IWrHQi2NSOer9J7tAYBogE11i5LkWcyKHfcxkidybTCsCvQm74H5eObzZqc2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=W+pm20zO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724125673; x=1724730473; i=efault@gmx.de;
	bh=kwhtZvXv13qBbMLo0CQY+8kbCRzlxswSyRgpKEHkrV4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W+pm20zOkqkJy5qjYM9UuwBCAZXsQxEIU+qTtv2PlSgY7rxMgqdKmaWTHDkcOeuN
	 vGmxXc7pVzkAu90RP4Z9+MEPWg0EpVEkNDn+H1McQjt7d4lLSNHvatJWRvqNBu1Wd
	 PsLsJgR0QbPlSZBDHJtDo0vnbaR/Y0/uyVgw8dUySdzmgUXs5cKI33ZrACmNX+1F3
	 DHKCoH6cuLJj23p6f1a55ZTqQC6mQYxkCFtGygaWvN3QR9YqFbTT6N3zMBBSkdXyw
	 jKdS9QSGlkhS2b00p5Gj1M6jVHdU8cz+bzeAuzbHY+dd4zwpZRvwHBmuQxdmRNath
	 Fn68xZCwlm1Bjv4cIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.139]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1sDmin33NI-00ajsR; Tue, 20
 Aug 2024 05:47:53 +0200
Message-ID: <8ebeabdd2be02d26329345220e7e25d0ad6e5a9a.camel@gmx.de>
Subject: Re: regression: 9eac534db001 ("firmware/sysfb: Set
 firmware-framebuffer parent device") broke nomodeset boot?
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 20 Aug 2024 05:47:52 +0200
In-Reply-To: <af56820e03d9a52a472ec914a17310d11f8d0227.camel@gmx.de>
References: <af56820e03d9a52a472ec914a17310d11f8d0227.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VYLw6vuQ6Bu8+5xLm3pDVrod7R05dMvjmrNn73aEl2RHtgqbcnc
 wS1tepYtKqYXS6Knn5xE/zi3waUq6zY1k5qN0E1OGl/bjbmNfAWLtEoBfcboxx8amPEqpSA
 QDfmHn5OEHmm9uyNmr5p6Z/AZ+VY79M9WcE5U4wRADzcpacU4nYcUk/NhYTaiZeIJPDPAXk
 gMF1CbWDopHq7wa00fVUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jRu0ikYQ2rk=;5NGgm5s5sxbxgUj+yGdrZyCw8UJ
 K5nBAf0YN3HK2QrLTGNi4C1QwDpZVX4hnzwLVFHk84PZorNEE4iWPtB2yMYL2rW7TLpiIQEtP
 fBY9aBBmxLTqd7dRKV/CLF7WuQTrBDwxu0ECDUMFE4GfKcA2DpiASjvhjNrZ2l6d8sAkiNtvh
 MNVK2Yfx4uF1DMOHFQRhBn4p9npkbquCWVs/y+JjYSxqTw77X24awkY7kCjp6kB4QQlzNiB5M
 nrmiqKJxFbQZxost+3h8+CnSaTUeP3UVt/4ILA+rZ/wemEVezPN1AgdZHaLED2B0GBnQTr6ds
 oKUS3UTFsbSmkNM15gr+dZsgRIJLmvnQ/jiGornV95wnCHQExyQpRQSJFJbieUf3eg7I9lesl
 0eKCJi3ItfYOQ5sFVXFBTPRX2hZwwOCo96MPzkpFgPpo35445TJQQpFDwTFrreTyJDXNBWKa3
 0IeGoaYU3NxS+bh5H4ePyHE4YjL8qNqEiLp4rs6rSK8iNMEL96XSQpYKI1tnDQSgBD7+3nThZ
 5CEQvI1mT7DmG4tKzM4E3zX7C+st+LBAUzmrt0VNil3OeOc7wOWxgyM95ntrHRQKAYWs5OacG
 +XpVBCXGaSzHqF+ED0Wja4w+NCTBKxt/4P2mfeVaKJp3k8YSrOmJvEeOLRkYIzPfD4Fn1DzGb
 TCeUNatfdebNwsMT9XjACJ5GodKvwxUY9QyqOi2VLOtSyGL9mrgdssxnLRcrOyVSIjbgdh6jz
 ZFv4439dfjcuDZg2X3j3+trVP80/i4nWPLIYKSNfEaB/pPYUIbxboNJgD8UV2K6tm0afM78jb
 dumf0IpAArlYt2x9TPQvLbXQ==

On Tue, 2024-08-20 at 03:31 +0200, Mike Galbraith wrote:
>
> I haven't yet tried reverting the series...

Hey, how 'bout that, applying a mallot is not only easier, it works :)

=2D--
 drivers/firmware/sysfb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

=2D-- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -95,6 +95,7 @@ static __init bool sysfb_pci_dev_is_enab

 static __init struct device *sysfb_parent_dev(const struct screen_info *s=
i)
 {
+#ifdef MEH_WHAT_COULD_GO_WRONG
 	struct pci_dev *pdev;

 	pdev =3D screen_info_pci_dev(si);
@@ -107,7 +108,7 @@ static __init struct device *sysfb_paren
 		}
 		return &pdev->dev;
 	}
-
+#endif
 	return NULL;
 }





