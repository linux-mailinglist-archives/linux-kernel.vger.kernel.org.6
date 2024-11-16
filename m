Return-Path: <linux-kernel+bounces-411643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A69CFD4D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5364B23841
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AFC194089;
	Sat, 16 Nov 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="cHhR8YQI"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC238382;
	Sat, 16 Nov 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745373; cv=none; b=XFTEBsAODa0LmhA3LQfiV9mjnnqMBzUnHR8M9s0BwPila7xDVfPIFtGLErvprK12PO5dp9cBr4TpOngnSio1hHR6PBAyYl0e6griwLVIlXyNjEI7DaqHz9i+aPr4yzBvj5XL8MYlWosxuAIml57bFbcu9a/0vNuw92DN1jXfbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745373; c=relaxed/simple;
	bh=LuDcn+RHguKWaiqobwicYIMlL673APuvhJZ9OzNXM/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obC62vL0Q6kK7eJQqutCwajAVd8TaekRUiF09KWRqP3WNjhJBjFYEuU4MHkfxRL0OPHSdeQzEsxz/jxjQfoNRZS9CZKNDy1yxdpHV9vcggX3zmvCBEY3KK4lMe4GKkM0WWs4rFLKcKFr2WSKKrs200KFxdj/RKlCPoOyGJ+rz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=cHhR8YQI; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D3A6914C1E1;
	Sat, 16 Nov 2024 09:22:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1731745368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8LkjK7OJAgL/T02i6vFtgd+OiEHmfvwmO7csCxkIwE=;
	b=cHhR8YQIsj09AmJOtyuWMsmjBQjV48y1gKTpkUsCHj6RxyTDxpx83Rc6AQqekGJ0C6RCnv
	0RCV3GRNsRzO7TmNILFVIW4wXnYAIqceNlN88ajVzA1WGitO3+1fIal6Pmvk2tDMQTDpB3
	HYnMnDXDAsPl4qqcJIBw5pnTP5kqts6L35iE1zjse/oTDMLT7in1HlSv38lb2KJammJzFa
	PeNaSDfxYpaDHHp6rUjf3p7IQev7nHhONV71lbY4Zkj2axbeQUACR4ME9Mv2VQSRDPnHhB
	9hpLfG7bpvLMJk+NAq/7AzlHSkbaHlE4N6HwoY8pmBvFJZCcLDITKCJkyxg1xg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 74a3c321;
	Sat, 16 Nov 2024 08:22:43 +0000 (UTC)
Date: Sat, 16 Nov 2024 17:22:28 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	v9fs@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v12 2/3] net/9p/usbg: Add new usb gadget function
 transport
Message-ID: <ZzhWRPDNwu225NWz@codewreck.org>
References: <20240116-ml-topic-u9p-v12-0-9a27de5160e0@pengutronix.de>
 <20240116-ml-topic-u9p-v12-2-9a27de5160e0@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v12-2-9a27de5160e0@pengutronix.de>

Michael Grzeschik wrote on Sun, Sep 01, 2024 at 09:11:17PM +0200:
> diff --git a/net/9p/Kconfig b/net/9p/Kconfig
> index bcdab9c23b402..2d7e596e22c3f 100644
> --- a/net/9p/Kconfig
> +++ b/net/9p/Kconfig
> @@ -40,6 +40,12 @@ config NET_9P_XEN
>  	  This builds support for a transport for 9pfs between
>  	  two Xen domains.
>  
> +config NET_9P_USBG
> +	bool "9P USB Gadget Transport"


It's been a while since this got in, but I figured I'd at least start by
getting this built since we got a minor fix recently, and this being a
bool is a bit weird -- any reaosn this wasn't made tristate?

(If NET_9P=m then setting NET_9P_USBG=y doesn't seem to do anything?
while it should be buildable as module, whether NET_9P is m or y)


From the code there's a module_init and MODULE_ALIAS_9P is set so I
don't see why it wouldn't just work, but I still haven't taken the time
to figure out how to run this in qemu so I can't test this trivial diff:
----
diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index ee967fd25312..97546a6a3475 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -41,7 +41,7 @@ config NET_9P_XEN
          two Xen domains.
 
 config NET_9P_USBG
-       bool "9P USB Gadget Transport"
+       tristate "9P USB Gadget Transport"
        depends on USB_GADGET=y || USB_GADGET=NET_9P
        select CONFIGFS_FS
        select USB_LIBCOMPOSITE

----

Thoughts?
In particular the depends might need adjusting, it's already in an `if
NET_9P` block so just depends on USB_GADGET is probably enough, but I
don't understand the rationale behind USB_GADGET=NET_9P either (can't
have NET_9P=y and USB_GADGET=m ?)


Thanks,
-- 
Dominique

