Return-Path: <linux-kernel+bounces-247607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C992D1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BA21F24C93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A991922E3;
	Wed, 10 Jul 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMO6hb9A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEA190485
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720615438; cv=none; b=hxJoS+EY18fbZ9C/jIch3C7eOvP8dX6hlcoVSrx1okxH7rQongUSGRdHU50u2PQUagFdAABkBI6AV5Y3BHQy2lRz0lxYAWTrs/x9XFnRnnUUjE0oF80eqtTxOIqv1yttljMCNobKiNgK2BUpQGAW5sSphjHoUmLiUUjzsAUBNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720615438; c=relaxed/simple;
	bh=43DDJK4SeQY7M8v3PtNKvgwHxdoCohqLSGhU/xmdabo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmvysWBMfbhBu3HV1ixQgwrM4NUyoUpTa/296T46kmhlbVoRp6QBCQDaBo4qJcs0MeL8f1noaoGydNDwTZnmR6qni8H3xbaNx0Ba4IXJCfvBzJ/yP1xvvyH2tcnc2AoOkZhjbrbJjjUIpj7uO5Q6nNtC7C7DeIQOtmGq6Fl/Km8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMO6hb9A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720615434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2/9lippDLEXmtWgWziQzdujSsOrakrUjnFWOu2HZ5zc=;
	b=CMO6hb9AXYWKvSLxmwukDJk1pb9C3w68F9yKeh1cP1JavrS6OBiasI8RvWrjULrL4HPcig
	Ft1pQepEFadxnizTbwrK+pnTZF99yQAS1Fsc+fcRounkMnnzmrpjP4zM/2B6Bbq45qpZDt
	gOIGLWPH7hAzoC0YlUf/eEYdyTMPP3Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-25TrsA6tOZaGSRYJKjlwNQ-1; Wed, 10 Jul 2024 08:43:53 -0400
X-MC-Unique: 25TrsA6tOZaGSRYJKjlwNQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57c6979daf7so5291084a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720615432; x=1721220232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/9lippDLEXmtWgWziQzdujSsOrakrUjnFWOu2HZ5zc=;
        b=AXdEjQ8GrJsTwN1mpE3Wc/MVIjcRUeS5gD3cM+qDyCyC67yOsW3QKbzO+JZ8oZQJtB
         QozlA+BeYapiwto+yu2kU7ElJYMBCGbuHrMi6p8TxzQgMKuJXkdZ7x8z788Po1iwMMyO
         Gk6SHmUcMlSb2UTyvlZmmmS2a7xWXmibjT0OL8FqGgdGaU+QLPS0lZsYD3HD1uMsICtX
         5isDTcHD2TbvMJXbEHvJY4oZA+3DS4vcekM3/gH/Qb2LitUWuD7hBm7rKJX5InB0rogc
         18a2NRfHb3GAEBnLLXgGIJbxKL51ZTpnlBqPBkVTit6TifMBLO5TDx9EDRRTsjrxo5XH
         8xlA==
X-Forwarded-Encrypted: i=1; AJvYcCXzgzQ4eQuJph7XM50tnUNcPGExjbEt5CazoCTSH1rnWic12oftwAcquSP9FaPFqn5K68vsVFJjGKk/fgw2TbRN4Vqk0pI8cwCu13an
X-Gm-Message-State: AOJu0Yx7YX3yxNUauDkPElcxgjoSSpRbmQl9vDIAB6e9RQUQR4QJZKFl
	dlYRTftAKmxsx8cA+FUT6lNEUkapPHndNGa1C1EzO+xr8h3G7OycaD+pYA5AxEZD07JChaGQQAC
	RtvnansUYyuEPsOT95+rUtHdcQaqfMn2j6JRq+UfPd8oh8eAOiaVvqsNa/X4INQ==
X-Received: by 2002:a05:6402:270c:b0:58c:ccc1:17f7 with SMTP id 4fb4d7f45d1cf-594baf87f81mr3887204a12.15.1720615432396;
        Wed, 10 Jul 2024 05:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGizrLSJI1qs8JqxXWm1KqqiwDtq78ZjQ4fIt6a38oE7t7gbjWggSz07taF+RS8p94KE7RgCw==
X-Received: by 2002:a05:6402:270c:b0:58c:ccc1:17f7 with SMTP id 4fb4d7f45d1cf-594baf87f81mr3887184a12.15.1720615431778;
        Wed, 10 Jul 2024 05:43:51 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2cc82sm2177127a12.23.2024.07.10.05.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:43:50 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:43:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] test/vsock: add install target
Message-ID: <e6oxt6gw36mhv54qbgc2bihcaym2xrquxtsjhyvm2u7wj76nu5@zneaxujp6oei>
References: <20240710122728.45044-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240710122728.45044-1-peng.fan@oss.nxp.com>

On Wed, Jul 10, 2024 at 08:27:28PM GMT, Peng Fan (OSS) wrote:
>From: Peng Fan <peng.fan@nxp.com>
>
>Add install target for vsock to make Yocto easy to install the images.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---

LGTM! This is a net-next material, so next time better to specify it 
(e.g. [PATCH net-next]).

If not queued within a week, please resend specifying net-next.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>V2:
> Use VSOCK_INSTALL_PATH, drop INSTALL_PATH
>
> tools/testing/vsock/Makefile | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index a7f56a09ca9f..6e0b4e95e230 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -13,3 +13,16 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-p
> clean:
> 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf vsock_uring_test
> -include *.d
>+
>+VSOCK_INSTALL_PATH ?=
>+
>+install: all
>+ifdef VSOCK_INSTALL_PATH
>+	mkdir -p $(VSOCK_INSTALL_PATH)
>+	install -m 744 vsock_test $(VSOCK_INSTALL_PATH)
>+	install -m 744 vsock_perf $(VSOCK_INSTALL_PATH)
>+	install -m 744 vsock_diag_test $(VSOCK_INSTALL_PATH)
>+	install -m 744 vsock_uring_test $(VSOCK_INSTALL_PATH)
>+else
>+	$(error Error: set VSOCK_INSTALL_PATH to use install)
>+endif
>-- 
>2.37.1
>


