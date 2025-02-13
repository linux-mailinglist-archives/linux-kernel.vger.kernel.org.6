Return-Path: <linux-kernel+bounces-512295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE37A33731
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7250188BACF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3317A2066C4;
	Thu, 13 Feb 2025 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="elJJ/cjX"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971D204C1D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739424090; cv=none; b=ph/HCrNfsAQPzJPGV7G8Md6FHalHXxfy3nXyRtjpOokCKAn6YHEV0yAc+co9OMpM185hhCqYUfpEFyDavNmM8rgem2pWNGb3ng35A7fhrbaFSegWGKFNtCFBcI34JBq53wFjtEPpB+NqHecjmhjAcpDV9tuQ/GiaaYKXNFyrPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739424090; c=relaxed/simple;
	bh=/hYQIFN5eLsEw5ZfLn9JjnNAr5fEBGpJclbHobhz3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0SAnS3mylOPzCRtZ3O1vmIEPZ6RTwA/vAPFM/WwWfi1YGulJXsRm3yDSltvQKywyu15QNU8Oi91WJcPDRMbrf2ChGvpaWDevT0dTWDmxffKR1adPro9+Ojn8LPE50WEaD8ldpd97JK5gPwJsTY/Y6aRf6ZmREsSfbCfUwaudgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=elJJ/cjX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7f9d87b96so77771366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739424087; x=1740028887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=va3y7gaOp0Y0VVUn/Hp+/Cra/1Ee6/x5n3PcEqf4xos=;
        b=elJJ/cjX6mjaLHai5BjUv/rRdfKGiutFiWmvn7dhnYuqItegLFqm83YR1jd7guwv3K
         Tmldjo5Rv5Sd89qf5bFOmafA/LE+eC5GOGCcQntMakRBPtWTCVFRYE2TY75XWrb23GXy
         KP8q22baKN7BmTQA2RlvjP/S6gddfNEhgBa7O452nXIv/rJKLyOVMK6lg3CCIOWoUIi3
         WQnLogajR+NLVK9U96T+YQp3moaZkAECBByKBJer42//oUafgLbwYXD19fMnWVyhwXI7
         u+o2FQ+N76me7gC7yxBbGXRwai4qxYNPXm52rwKLc9/e0+LU2jYedteUnUlZxtI7PFkS
         muAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739424087; x=1740028887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=va3y7gaOp0Y0VVUn/Hp+/Cra/1Ee6/x5n3PcEqf4xos=;
        b=HD0hGMW44K9Ohbaw4W1CSx1ioDc9AM9icDZPrGSlwV97t+ml3KoA3ojcqhevZmuouK
         8oUn9sXszvfH2b0GV6HkibKH662gKiTzNhUW5riGtv01W4wyzaovMtX2gY/htr6kKQOJ
         eAhXOfJ6yy0J/AYkAd6v7PcxtFLrjdgHysyrTzuVfV5Jd2n8x44WTAMVJjiYz8ZqfR/M
         8Q7tUDTqQYDIeObDoT1bavgO3We1l3A2nqPzFsyH5ud3E30g3Xk0OsnntKlKa2MSXNLd
         CWLAurLyPPWNBiIKpldqoCH+VbnoXUz0BRulkcqkoaAsi8qe9hnB5BRxDoMEcCZzZ7iE
         vpYg==
X-Forwarded-Encrypted: i=1; AJvYcCXC0Q57ILr02LQY7++LlcrvoZ9hqgxPf33IXzlezqjBzH72OdzLTy2C4bVsNwJTh5Vj+MF4jNEM7WEZslc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqaRdggxWSrfAcsocqgx1F232kh5SIfOSopdeWmaumjHy2yjeH
	177jO1sFDai/axlq8UJzH+deIYnCNxhMVSB4cCEFIEeSylJChqx6NfzcXhP/sFw=
X-Gm-Gg: ASbGncsxVbs2Yu2eNv4YcBICdrlOJBseTGAFCwMf+HEkC/xFikNioJfDryzwPPDrK2a
	rRQZssYpzrrdv7+bT1ricR7CdMTAisKW1/MxPwetIOsTbLwGtvMjMYmw+ehbzW+RnY/ZLaka8vp
	MHkfO9AmwFoCcoBIGqIEW2nPu5q1I9Nm3SjdKk6pN6KqzVViuM7n7YoGbt2WoO4krb24BpJWqVG
	iWqt66YaLrW1JD4aq/TlcG60HicgP5BuqkPIH8BuQFWsJFRrK4r/VyDIKnyc9pvuZWZ5us1W2wU
	3QqVOgl3bq1hpnRpIFXC
X-Google-Smtp-Source: AGHT+IF++tzvA4ozNyZQfnVkn1og7OUT+54+YHB7mg9npVmHLsgg4X/HxYxaQJ/l0a+CyHudxXqOAA==
X-Received: by 2002:a17:907:97c5:b0:ab7:d4b0:9254 with SMTP id a640c23a62f3a-ab7f33f5f77mr528766466b.26.1739424086964;
        Wed, 12 Feb 2025 21:21:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba53376713sm53891166b.108.2025.02.12.21.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 21:21:26 -0800 (PST)
Date: Thu, 13 Feb 2025 08:21:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] Bluetooth: L2CAP: Fix NULL dereference in
 l2cap_recv_acldata()
Message-ID: <189055ae-a400-46b3-b265-a93a23f0d715@stanley.mountain>
References: <f9975604-6a65-4bcc-b532-15fcaa6da0e5@stanley.mountain>
 <CABBYNZK-ibR-+ri_+FFiorLkEvT_1tD2YKSOeSuTsyoS4dM1CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZK-ibR-+ri_+FFiorLkEvT_1tD2YKSOeSuTsyoS4dM1CA@mail.gmail.com>

On Wed, Feb 12, 2025 at 05:23:42PM -0500, Luiz Augusto von Dentz wrote:
> Hi Dan,
> 
> On Wed, Feb 12, 2025 at 11:40 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The "conn" pointer is NULL so this "goto drop;" will lead to a NULL
> > dereference when we call mutex_unlock(&conn->lock). Free the skb and
> > return directly instead.
> >
> > Fixes: dd6367916d2d ("Bluetooth: L2CAP: Fix corrupted list in hci_chan_del")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  net/bluetooth/l2cap_core.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 6cdc1dc3a7f9..fec11e576f31 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -7456,8 +7456,10 @@ void l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
> >
> >         hci_dev_unlock(hcon->hdev);
> >
> > -       if (!conn)
> > -               goto drop;
> > +       if (!conn) {
> > +               kfree_skb(skb);
> > +               return;
> > +       }
> >
> >         BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
> >
> > --
> > 2.47.2
> 
> I went ahead and fixed this in place since it has not been sent to net
> yet, I did add your Signed-off-by though.

Thanks.

regards,
dan carpenter


