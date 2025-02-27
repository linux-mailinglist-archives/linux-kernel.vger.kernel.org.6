Return-Path: <linux-kernel+bounces-535853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500B1A4781E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DAB16B007
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47BE225785;
	Thu, 27 Feb 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="RVbL21y6"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB32222A5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645885; cv=none; b=FNOC3WSZ9pA1zsUdCOU6Pc/c58qRTP1voibGmJGQH6BR+aOAvZThtH0njbBdGthY+owjzfoBn2LLjDB/stkjQMTupRQUfruSVykBvoYNIs66qvn0JpVvme6GCqnQc0tjA7cIvvYm7jDJGB2CMQtZyuvmzStl9DT+j5iX7ON8hpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645885; c=relaxed/simple;
	bh=JGW9cxzzsY5VN/raILkwjSf7H9fvm109h9NaTvo8lac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjs1Xfwnz2Gd4I6ekPwdl37BKsy6f8ToZo/vX355ncY5ArvjUEJpyR6aug1nu9qSR43EwQjvrkiS1NM1ZEhOyIDAoNUVxnDCPILQ7RXXr3wdjaWCTwe+Q3K+N8g1cbjJJ2zf3jb3dXO+S1gjAiFccqfJVBzoYGCOtr9xtZABntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=RVbL21y6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5MZDY9LEAwQLaGy/5t3sedQ+InC4HHqCTBWMRr1Rdmk=; b=RVbL21y6Trpv8FYuCJuwa0q4YZ
	j6HQ7xFe55AuYT7lmC4Gf/GF3zjg+r5aQKTMTGLeNnFQJYre3w3w3Ux794RbN9DfuaX2UQtpDjiuM
	rHTvDuY/Qq6BX0S7zNx68eBQWt7IotR24gJ1OQHNawYd4PeQW5OLCJG9NLdLVJJDiH0GmZo9o4o06
	FTod+l+W0JiOW5Zn1u2MuNumi6eGa79l86OqXBZwChbF0luXJm49t/JSp6qRU3KPwnO7lOs9CsLcP
	/+7xIDnXjuSkMJ2F+BcUF/uD1LZLOIpV9Of5VOF/lAAE4kPUiKQBkWh9BVCgUAK5ccCiLTZgte0Sc
	d/zLl4nA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnZVI-0007pV-G7; Thu, 27 Feb 2025 09:44:24 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, dakr@kernel.org, hjc@rock-chips.com,
 andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, quentin.schulz@cherry.de
Subject:
 Re: [PATCH 1/2] drivers: base: component: add function to query the bound
 status
Date: Thu, 27 Feb 2025 09:44:23 +0100
Message-ID: <12995210.iMDcRRXYNz@diego>
In-Reply-To: <2025022153-outdoors-snugly-3967@gregkh>
References:
 <20250220234141.2788785-1-heiko@sntech.de>
 <20250220234141.2788785-2-heiko@sntech.de>
 <2025022153-outdoors-snugly-3967@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Greg,

Am Freitag, 21. Februar 2025, 07:14:07 MEZ schrieb Greg KH:
> On Fri, Feb 21, 2025 at 12:41:40AM +0100, Heiko Stuebner wrote:
> > The component helpers already expose the bound status in debugfs, but at
> > times it might be necessary to also check that state in the kernel and
> > act differently depending on the result.
> > 
> > For example the shutdown handler of a drm-driver might need to stop
> > a whole output pipeline if the drm device is up and running, but may
> > run into problems if that drm-device has never been set up before,
> > for example because the binding deferred.
> > 
> > So add a little helper that returns the bound status for a componet
> > device.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  drivers/base/component.c  | 14 ++++++++++++++
> >  include/linux/component.h |  4 +++-
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

just for safety and not stepping on people's toes, does the Acked-by mean
that this patch can go together with its user through the drm-misc tree?


Thanks a lot
Heiko



