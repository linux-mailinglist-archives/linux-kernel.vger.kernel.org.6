Return-Path: <linux-kernel+bounces-195012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356568D4635
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CD11F220D0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122444D8B5;
	Thu, 30 May 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IuslHGZK"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF9168BD
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717054840; cv=none; b=Bf/L5qJbpRdZJEUAqhfUE2/aS1tMcyrYsZhSNXDLq5OWeH7M5vgAJbB/fKSjubjkqBgm+tugeH5muFPUqTt9iYa4tu1GJXTSzqedzzM4t6xQxkDwWUaF2jJ7nIg0p7nYMvoU66j+j1vgz7dHBLxTWIB1oaT3uMDjQXltO3UWgq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717054840; c=relaxed/simple;
	bh=0vBDNTxwzir6Deuyiolc3iWuewX9NJBN5vrHmJm71l8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=hT5ptyhIqk8gpMGEfiJFvjobvgeqqojubO9pn1T53GvKgepEe3HdqvpWuf/Go7sWEc7flvpkNOnsgdOo09EQjoSuFWq9ZsvAigEcg37UiANHgsp18Q2wyglkW4gNAW2PjDxdswHZX9Qp/JA7WCiQSr53SBIYYGlWXcsk9vWrOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IuslHGZK; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240530074030epoutp01aaff5aa995d6f22c619c61b1503e1a86~UNEVgdouj2328723287epoutp01U
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:40:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240530074030epoutp01aaff5aa995d6f22c619c61b1503e1a86~UNEVgdouj2328723287epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717054830;
	bh=KzVuwfEF3G8TNaPo6TezYCEF4u7EfVxw85LvHsZUNBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IuslHGZKWj3OCjkd90uly9JJ9/7Le7EnrZSLOuWIlgipHFbC4oxkzWeCqOqlMLTax
	 Tu2f+LJz0eVWZ5c2OEof93R4uhLvns0hpXU3Gn8DqEdmWKH3wckmXLvAbK4NKrV/Qq
	 iJtE+DuPs48EAsyGp/Bz1XTMwMNIWHt3k0S0dxd0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240530074030epcas2p3d6ae943a68d2390bf933c7bbc135265d~UNEVO7wKf1569315693epcas2p3q;
	Thu, 30 May 2024 07:40:30 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.100]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VqdT94smbz4x9Q7; Thu, 30 May
	2024 07:40:29 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.34.18956.D6D28566; Thu, 30 May 2024 16:40:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240530074028epcas2p2c6091ed95530299bae9248bc6efad648~UNEUCaqmu2194121941epcas2p24;
	Thu, 30 May 2024 07:40:28 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240530074028epsmtrp2acb209a5ae4f49315d88465c60bbeb61~UNET-DC241064010640epsmtrp2o;
	Thu, 30 May 2024 07:40:28 +0000 (GMT)
X-AuditID: b6c32a4d-247ff70000004a0c-52-66582d6d8392
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.C3.18846.C6D28566; Thu, 30 May 2024 16:40:28 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240530074028epsmtip12c79a658ac443affd5e4630e94fd0773~UNET2s9Wk1467414674epsmtip1Q;
	Thu, 30 May 2024 07:40:28 +0000 (GMT)
Date: Thu, 30 May 2024 16:40:53 +0900
From: Jung Daehwan <dh10.jung@samsung.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, "open list:USB XHCI DRIVER"
	<linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Thinh
	Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb: host: Add a quirk for writing ERST in high-low
 order
Message-ID: <20240530074053.GA48462@ubuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2024052845-unwatched-sprig-b0e1@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdljTQjdXNyLNoHUxl0Xz4vVsFpd3zWGz
	WLSsldmiedMUVotVCw6wO7B6LN7zkslj/9w17B5b9n9m9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/
	JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
	v7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO6Oz+Q1bwXfOiscNP1ka
	GPs5uhg5OSQETCQ+tS5g62Lk4hAS2MMo0Xp7DjuE84lRYtuPwyxwzurL75lhWrr+XIeq2sko
	8a9pJ1MXIweQ84RRYqkxSA2LgKrE1C/bWEFsNgEtiXs/ToD1iggYS/SfncUOYjODrFs4UwjE
	FhYIkFj/ZRMbiM0roC1x+nUblC0ocXLmExYQm1PAVGLBo2VsIKtEBVQkXh2sBzlBQuARu8T3
	x03sELe5SJx9fAnqTmGJV8e3QMWlJD6/28sGYRdL3Hr+jBmiuYVRYsWrFqgGY4lZz9oZIY7L
	kOiccwnsLwkBZYkjt1ggwnwSHYf/skOEeSU62oQgOpUlpl+ewAphS0ocfH0OaqKHxPITf5nh
	YXhg8USmCYzys5C8NgvJNghbR2LB7k9ss4BWMAtISyz/xwFhakqs36W/gJF1FaNUakFxbnpq
	slGBoW5eajk8vpPzczcxglOllu8Oxtfr/+odYmTiYDzEKMHBrCTCe2ZSaJoQb0piZVVqUX58
	UWlOavEhRlNgXE1klhJNzgcm67ySeEMTSwMTMzNDcyNTA3Mlcd57rXNThATSE0tSs1NTC1KL
	YPqYODilGpg8q37Nvhnr92tz0mnfncznA1dMCdv1gLGWN7i4YPJ1x5t1f282VZQ5Hn9wobWa
	X6eOgenq1wzxs4INs636A/acNLm1ZMuq2MurqzZGPY4se/chvkKgfKZxQPANHVfjh1/S+C6t
	+73B9s7s7DCpDWtOFv3ZN4MtyuvufZ9pNfIrrA7UzJodU1MuMC26QeFYyK/EsKTDezR6Q23j
	9p+UKGA953J82sSGON7bZnJC2Sf+1kg9tv/V+kde7O6B8NXPWI6X2rLevjLbLolddnnZR++/
	ksuDc/lTaxLzVKTPiBZ22U+/0C62ZMb8T45CD7iW3XJdF9d7XKnQIXWFwMraK4ujZrnHZevf
	W8KYPImD8YcSS3FGoqEWc1FxIgCRGAcRHgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnG6ObkSawbQOI4vmxevZLC7vmsNm
	sWhZK7NF86YprBarFhxgd2D1WLznJZPH/rlr2D227P/M6PF5k1wASxSXTUpqTmZZapG+XQJX
	xrYjq1gKtrNX3N37kamB8QVrFyMnh4SAiUTXn+vsXYxcHEIC2xklpjQsZoZISEosnXuDHcIW
	lrjfcoQVougRo8SFD4/YQBIsAqoSU79sA5vEJqAlce/HCbBmEQFjif6zs8CmMgvsY5T48WQS
	C0hCWMBPYvrDNWA2r4C2xOnXbWwQUz8xSjz79IERIiEocXLmE7AiZqCpN/69ZOpi5ACypSWW
	/+MACXMKmEoseLSMDSQsKqAi8epg/QRGwVlImmchaZ6F0LyAkXkVo2hqQXFuem5ygaFecWJu
	cWleul5yfu4mRnB4awXtYFy2/q/eIUYmDsZDjBIczEoivGcmhaYJ8aYkVlalFuXHF5XmpBYf
	YpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MNVNPPckIah6Q7i7we8Tz1Oz2jZcOvd8
	giajzQMGLgmB+5u7n29gkWk69O6a+6zS1iMRv25U24VfWXQvVdT0SqbjrfDZGgJtaoe0zRe+
	ibt/at385Mef91gZFK2f1HzfU+fKz/XsezP93vDdfWedO1V5y8dFSR8XL/38S/tXUrWrMEfk
	kTs5Lz7sm3M3+z3/Q8O+0+Ylnp9cNHm0WWL39AoUTBAvKfpp9PWPo17fwvhbp24k700TFp2Q
	OqNZ3t1jk9em3zummWzN/xPbw//y9OJvNt8V7uWVHLm4snGZWKyg1tnv30Lj6/q//X2yLztn
	2+boP6ZZYlsnznBWDz5Sauzc+W/nlltX1rtYPBPoedWmxFKckWioxVxUnAgArn6i+d4CAAA=
X-CMS-MailID: 20240530074028epcas2p2c6091ed95530299bae9248bc6efad648
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_191f6_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc
References: <CGME20240528055659epcas2p4f86642d6647855747cea35b04f8a46cc@epcas2p4.samsung.com>
	<1716875836-186791-1-git-send-email-dh10.jung@samsung.com>
	<2024052814-exponent-domestic-6da2@gregkh>
	<2024052845-unwatched-sprig-b0e1@gregkh>

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_191f6_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, May 28, 2024 at 09:29:21AM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 28, 2024 at 09:23:43AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, May 28, 2024 at 02:57:16PM +0900, Daehwan Jung wrote:
> > > [Synopsys]- The host controller was design to support ERST setting
> > > during the RUN state. But since there is a limitation in controller
> > > in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> > > It is supported when the ERSTBA is programmed in 64bit,
> > > or in 32 bit mode ERSTBA_HI before ERSTBA_LO
> > > 
> > > [Synopsys]- The internal initialization of event ring fetches
> > > the "Event Ring Segment Table Entry" based on the indication of
> > > ERSTBA_LO written.
> 
> Also, what is the "[Synopsys]-" stuff?  That's not normally in our
> changelogs or documentation for how to write a changelog text, is it?
> 
> thanks,
> 
> greg k-h
> 

Yes, I will modify it.

Best Regards,
Jung Daehwan

------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_191f6_
Content-Type: text/plain; charset="utf-8"


------40rWTt6DAFmUrjtMexcyNm5gpMTj9FMdHa8zGfbdWx6mQz74=_191f6_--

