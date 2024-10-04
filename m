Return-Path: <linux-kernel+bounces-350316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0C6990360
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB361F2148B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AB420FAA5;
	Fri,  4 Oct 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vV6j1jt6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87029422;
	Fri,  4 Oct 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046668; cv=none; b=AHRkdVti3apM4czRbjRoN9Bms96ixtnyPQWorExYfTmjF6+AfDj3u8+Su2Wus7cQHNdSy/923/QASz9omV3CS+QD6W1nQ8tvxqQcv3Tm85w4BqxouVckhT4hLmBXuUfvo+smpgE959zuerl+Fg601poDNsorl8L+cMaNO0cgczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046668; c=relaxed/simple;
	bh=UpHDIN2a0D3yKrjyyUv0yUcS2Wl6mrCpy3nXr97fulY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oleRO1rgkzoSFr4FrDFsdhn4kjO6FwE35Y+XIP9h5L4tLJsXvsTnrULb7AUHW/FNVkccJNaFJPhybJYEVIgrASg9nAJ4qansWybxVMdV2US4ENXdA8bebxd4TzlG6Bb+CSW8ymQXcPFfc2Fc9hzADGTFhhKhgbgc3EBpoYBTh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vV6j1jt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5E8C4CEC6;
	Fri,  4 Oct 2024 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728046667;
	bh=UpHDIN2a0D3yKrjyyUv0yUcS2Wl6mrCpy3nXr97fulY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vV6j1jt6qrrq2cRW/UxbUnBFlKhkMdg+BHP2su/YX3JAJtN4a/k1N7/3pCbMQHBKn
	 2+XyiTRgoM9bm0Q/qvOMjwKOJEfbT1CzWnprCZQsFqCNFCE7lggTZkpFCMUe7mRAMd
	 fWKPOW8wQ5YIIY1sxG2wcMSuoqLsGrWTzJUt4R0I=
Date: Fri, 4 Oct 2024 14:57:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pimyn@web.codeaurora.org, Girgis@web.codeaurora.org,
	bemenboshra2001@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, nogikh@google.com,
	glider@google.com, dvyukov@google.com, elver@google.com,
	pimyn@google.com,
	syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: usbtmc: initialize memory written to device
Message-ID: <2024100452-echo-chokehold-f6fa@gregkh>
References: <20241004123313.2463701-1-bemenboshra2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004123313.2463701-1-bemenboshra2001@gmail.com>

On Fri, Oct 04, 2024 at 12:33:13PM +0000, Pimyn@web.codeaurora.org wrote:
> Avoid kernel-usb-infoleak by initializing all memory written to device.
> The buffer length uses 32bit alignment which might cause some buffer
> data to be read without any initialization.
> 
> Reported-by: syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000006f6622061eb52dba@google.com/T/
> Signed-off-by: Pimyn Girgis <bemenboshra2001@gmail.com> (Google)
> ---
>  drivers/usb/class/usbtmc.c | 3 +++
>  1 file changed, 3 insertions(+)

The "From:" line of this commit is obviously not correct and does not
match this signed-off-by line.

Also, as you are from google, just use your google.com email address
please.

thanks,

greg k-h

