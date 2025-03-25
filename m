Return-Path: <linux-kernel+bounces-575874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386FEA7086C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4B3B7A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE8263F28;
	Tue, 25 Mar 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="RiFmS2yP"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91641263F24
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924841; cv=none; b=YyTNbjdq0yKfTEPEXGyhads8yuXJdmLuOuzr5jDM/4I/ru+pBoofL/aUXejJWFZG5hw4Kx6fMlElS4mVOqgdA4OLHlxzmx1muBKHJL+myL01nhWYF4PzhzMBbeNIfpy3VE1b/ALUf1/Mgq/mtk0UyEuteqRh3GD2JCWxwnMYAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924841; c=relaxed/simple;
	bh=goKPkMeXynwdrhBXnRq9X1VvT6tW+FJCFrUGgCdOnmg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWW0NWxBW2kkqtXNpws8dHmDPPCm4I68bdG45dXLxzV+2c+iWhLYX4rfJqkgTI0nRJ9a5ztQAjPuPhQYjxifPKypQkp1HD/rPC9YpFOPntSu7I4cvbpH0jBOTwGQK6Ea5TONVYQqA7z6injS9YfXqDsGJfgLglMiuZLibuu06gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=RiFmS2yP; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8efefec89so51522316d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 10:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1742924838; x=1743529638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjH1g6ftKk1WIu6TE8/3Mya2cmPNBafybymHxTD9mE4=;
        b=RiFmS2yPwpzXwLruNurFXEeXSL2ike4PAgZjfJvw3f2bMQp7D+X5aQdEi+/iHOD6xb
         QEXChE3bWBBE0BQXE+G0KwrGRxKb+BUFPVrblKcVnlgY+9t1Co34dsS6M6KReUaHicen
         J8Y6tilYG818HT0ShqpexiSCxaeXC9GH3VZtUJvbMgZZICUHDAvgad0c+xTuBDgCqmVz
         XcmPVcz0YqWGZLHenjXXW9syLh61SwAlL33m/RsgyYXm10vCl98ALzk3rEgQmq8eB+UF
         yxvMWP2D7JV1Ab70eClf6abpx16+bPDt4nVOTV6LbuWKXIBBQNzcn52uQOUzNPEKIiPb
         hjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924838; x=1743529638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjH1g6ftKk1WIu6TE8/3Mya2cmPNBafybymHxTD9mE4=;
        b=IBleoom8qeARN87t1CJ4w+aN/VQdYZvgMmfr9JUmJn0dfRThVLjW+/WjBmYjX5G3BL
         ndfkLFBrsp2/VTWW/E0iqf/4LBN7TTkY39wag8fg8I8H05G+5onyj/7zk+fM5nmKt4Oy
         vIy1KhhbSURz5DBWapXm/79P9XBEzfyiTWGjb93JfLmycwFEGfW2IeR3OKqJAF2YKFh0
         DvQtDthrGP4g4+ZMbTFwhjSqrmAMieIgTVmVa43b5A1e29244z5DY5+EBvNLl1vdTlTa
         DRV7kg2rqFiV8AzZSjXSJWyhFD3FBWNUm8BjqV85H41P8eOwijbPP39mHpvAPOcmNDDN
         ZjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3mvn9vykbz6aBSCX0Z9a2L5B2swaVhwlntAv7HTC9Sh2xXBsLd3i4+GT/pXRB1DnPEBrHkyzOAmRCFgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmErqh1EANSxalufx2Yt0zwoBrnt+LnXWxyQ4vpMnnFmSHvDN
	HS48v8C5RlEf9Dw3fDRdJ23qlakQAjKOskA66L6EVxIEGHmxOkKw6ZfpfmLgGA==
X-Gm-Gg: ASbGncvqgJool2v23tdFzW+FE1qJ7aLsrFAQGobXFCJSWWFAONVOqysKQepqC889Ldf
	87MzKJ0pGN/jnoL8yunUdQIaCFXFnHVg1XrZQmxfskrenZmcYTjw38G6xuXeRE0zWmjje2dcEl9
	qheqyHErekhRwXTz2VZA9am5jZC9N+QmOb4m5PqwE37+ISjaPwFBX8gxjQvqwJqcuCrMshq9FWO
	reeuXKElcKIhlJ4cXGp+TZUEX4wfEH/Eatl6aCe5Q1aM1Ubvj6isjQ0x3yEvbYd1NnYENp7Gr5d
	u3QzICkYLwbV8YWuagc8NQlLxkuN+IcAiM3SiGmBQtqnQeJKuazJomMgsgvBX/lyKH36PZpdsND
	DqzYNG07CDcjU0rGLkCFlMNTsihFxgtVr5eibrw==
X-Google-Smtp-Source: AGHT+IEE3s2WyDicsHyN8I8hDTQsl58ko3gMhcMuYw+oTIF/jYZenScg9DM9xoAREespRcfMxIvUaA==
X-Received: by 2002:a05:6214:19ef:b0:6e8:97f6:3229 with SMTP id 6a1803df08f44-6eb3f294676mr269179956d6.16.1742924838295;
        Tue, 25 Mar 2025 10:47:18 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc5a1dsm58469186d6.79.2025.03.25.10.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:47:17 -0700 (PDT)
Date: Tue, 25 Mar 2025 13:47:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	syzbot <syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	linux-i2c@vger.kernel.org
Subject: Re: [syzbot] [usb?] WARNING in dib0700_i2c_xfer/usb_submit_urb
Message-ID: <6bb3b80b-a808-4992-8666-535ed9a5c980@rowland.harvard.edu>
References: <67e1a1f5.050a0220.a7ebc.0029.GAE@google.com>
 <acfa19a7-9d24-4cd6-9d1d-580a9ac7473c@rowland.harvard.edu>
 <Z-GwRNe8NIigXYtS@shikoro>
 <ecdc37c4-b178-4e43-bfbf-45bd3ed29ff2@rowland.harvard.edu>
 <Z-Lg3glmnzA44R_H@shikoro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Lg3glmnzA44R_H@shikoro>

On Tue, Mar 25, 2025 at 05:59:10PM +0100, Wolfram Sang wrote:
> 
> > > > As far as I can tell from the source code, the dib0700 simply isn't able 
> > > > to handle 0-length reads.  Should the dib0700_ctrl_rd() routine be 
> > > > changed simply to return 0 in such cases?
> > > 
> > > The adapter (I assume the one in dvb-usb-i2c.c) should populate an
> > > i2c_adapter_quirks struct with I2C_AQ_NO_ZERO_LEN and then the core will
> > > bail out for you.
> > 
> > Or the I2C_AQ_NO_ZERO_LEN_READ flag bit.
> 
> Yes, that would be more convervative. Does USB allow zero-length writes?

It does.

> > What about all the other fields in the i2c_adapter_quirks structure?  
> > How should they be set?  (Note: I don't know anything about this driver 
> > or these devices; I'm just chasing down the syzbot bug report.)
> 
> As I also don't know the hardware, I suggest to leave them empty. 0
> means "no quirk".

Okay, let's see if this works.

Alan Stern


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5fc319360819

Index: usb-devel/drivers/media/usb/dvb-usb/dvb-usb-i2c.c
===================================================================
--- usb-devel.orig/drivers/media/usb/dvb-usb/dvb-usb-i2c.c
+++ usb-devel/drivers/media/usb/dvb-usb/dvb-usb-i2c.c
@@ -10,6 +10,9 @@
 
 int dvb_usb_i2c_init(struct dvb_usb_device *d)
 {
+	static const struct i2c_adapter_quirks i2c_usb_quirks = {
+		.flags = I2C_AQ_NO_ZERO_LEN_READ,
+	};
 	int ret = 0;
 
 	if (!(d->props.caps & DVB_USB_IS_AN_I2C_ADAPTER))
@@ -24,6 +27,7 @@ int dvb_usb_i2c_init(struct dvb_usb_devi
 	strscpy(d->i2c_adap.name, d->desc->name, sizeof(d->i2c_adap.name));
 	d->i2c_adap.algo      = d->props.i2c_algo;
 	d->i2c_adap.algo_data = NULL;
+	d->i2c_adap.quirks    = &i2c_usb_quirks;
 	d->i2c_adap.dev.parent = &d->udev->dev;
 
 	i2c_set_adapdata(&d->i2c_adap, d);

