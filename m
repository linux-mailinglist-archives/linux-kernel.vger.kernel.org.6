Return-Path: <linux-kernel+bounces-544502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C82A4E1CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FF77A260F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD325F990;
	Tue,  4 Mar 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swyEXDmw"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828425D206
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099721; cv=pass; b=MyHHR+iSnQjuD1rLNhCaMInzOk/coIkDFxbMqo+ExzNzYFukY8wmUgXt3+e8syyX0IfE62oVMNuj1sImhJw6hQvb4j3EqrDH1AgW7je41sjJtPFhtE6tIog8YmdCpg+FIgECyw3QbPDjcwDF8oXG/z/RlLNxHh88uW199RQZ2rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099721; c=relaxed/simple;
	bh=o/Y21k3K8BAtGuRlqRGQ5WfAu2QMrDK4uLxkfdiPHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX8Kd5epTDo79ahRPvWpOdAD4l7zsL9NI9V8RX2zFTLsqw/Qbhcg83+aW4WsdkUwGCD0aiKnEto8rfCq7NnCVB6acBGRa81q6iZSrH0jOlhBVVjx2HMv3OAnPYK0RkchABTYi0fw8JwERAGbVE6+h/byZLrZwJSpo/NjVy7lT7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 7332640CF139
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:48:37 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=swyEXDmw
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dnT5FqHzFws8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:47:25 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 755C84271F; Tue,  4 Mar 2025 17:47:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw
X-Envelope-From: <linux-kernel+bounces-541768-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 3292E4205E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:10:35 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 72E112DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:10:34 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DDA7A3FF0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA02116E7;
	Mon,  3 Mar 2025 13:09:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F121128D;
	Mon,  3 Mar 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007390; cv=none; b=FdJQf3C0V6z+/iJwkmai9q0EUpkpGnF1m2ZxTM1etBOl94WxqZl777yR/R9sL5atzBdVh3RVqXu90sVcdjcxdVN6ecQDpRS16lrD0gfWxfhs9yViKbruy4/qD7xjW0m7VSrvugKXVdP0+lWjyzXALv0FFGqta0ijY3O0j3N1Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007390; c=relaxed/simple;
	bh=o/Y21k3K8BAtGuRlqRGQ5WfAu2QMrDK4uLxkfdiPHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz7JZMWxnvOViyg8wVY04DyIRkeqKZ+oEu4ZRiyHuhsz5XHQAl4r+EPFNofGblR1kzaeuO1bDyHQYI3x3/kvs/Us9qzqx9ZKaSwV8FxRKnWiUukBuq2XVG0R+M+BLWgV2o04O848YMZn6SrWCeruRRF5vxKBVjOHVAwVhkNbQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4727C4CED6;
	Mon,  3 Mar 2025 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007389;
	bh=o/Y21k3K8BAtGuRlqRGQ5WfAu2QMrDK4uLxkfdiPHqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swyEXDmw0R0g7ZRw44ogOiq1HHP3y2FeZWG29C850ReRwgC8lzNdttVBTaHFVe65o
	 zVYLN/A4vGP8u73Ji/YrtcfHWGBO9pVsAXxaZDTIvI6w4WA5owD39ZYG+WPsqvtxtt
	 6rfvzRPiOvRX9p4m3FK9k0hAmJI4VifjelwS3VIi+Qqzx89O2pq8cSMhGEWt4zeX5g
	 /J7PQGlObpo+3VnrZr33tGBzuiHEkzryDdXAGsvjicCP+5GLyi2yw93+6o12fFMSVU
	 ytDYWysry3KgQaYBbbyO5mF0BnaqsPZnYFKudU33iNwWvClH0C+6o57GuX/9dcgFSt
	 U2WifXCRtyomg==
Date: Mon, 3 Mar 2025 13:09:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>,
	MD Danish Anwar <danishanwar@ti.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Subject: Re: [PATCH net-next v3 2/2] net: hsr: Add KUnit test for PRP
Message-ID: <20250303130945.GS1615191@kernel.org>
References: <20250227050923.10241-1-jkarrenpalo@gmail.com>
 <20250227050923.10241-2-jkarrenpalo@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227050923.10241-2-jkarrenpalo@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dnT5FqHzFws8
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704449.8366@HMowIdut88ZYrPUvxOcWiw
X-ITU-MailScanner-SpamCheck: not spam

On Thu, Feb 27, 2025 at 07:09:23AM +0200, Jaakko Karrenpalo wrote:
> Add unit tests for the PRP duplicate detection
> 
> Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
> ---
> Changes in v2:
> - Changed KUnit tests to compile as built-in only
> Changes in v3:
> - Changed the KUnit tests to compile as a module

Thanks, I see that this addresses Paolo's review of v2
and overall looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>



