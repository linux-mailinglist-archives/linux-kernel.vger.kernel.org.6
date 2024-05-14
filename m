Return-Path: <linux-kernel+bounces-179250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE88C5DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0371C20EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C24C182C98;
	Tue, 14 May 2024 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="tkXrVZLt"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901B181D1B;
	Tue, 14 May 2024 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727616; cv=none; b=VMuMOJMJiPJEUnKAMT5LiswLhm8/KEWf/6hzNf0qrjjkyIT2VaQWv3CenKMwYzuEZQnQpyktBlkf0Io+AfzbQntrWAi3KK2Nf9r+qCjsmgMYdUsv+dy5V3nWi/eVM2/PSH9xsv+F4YDPeop+TPHuZYb0118dz8s1SmNlIUV1qXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727616; c=relaxed/simple;
	bh=0MJ2bhVM/lmkgpCeYoXAEkoKaZL3wiXzUAz0VtakQIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+fZKdiUWJ6T5rEW8pixDQoyZ5rxVhxYpcHOaPIW8/1oy7/eEPbtvoVONG/Kiyrjgt15HfdSBA6bdc2r/TPlutfOLEmCJWTHLuA0d9+h7swhYNwXIHWQ7rHR5JnkjlUlzLinb90bQnyjYBTdyFuJ1UNQrWOK5dQx2+6oOu9XLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=tkXrVZLt; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1715727602; bh=0MJ2bhVM/lmkgpCeYoXAEkoKaZL3wiXzUAz0VtakQIo=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=tkXrVZLt71wowUEscx731wUeG0+JcplaZ92K+ND1f+dO/usaeAmP2igEnxIRMAY7J
	 XOunD1uQVVq14Cbz4o+MCoZVvbUh4VOPF3yYr/xb2unKxaPqEFym0vey/hoN2azrX8
	 OdfuukiPL9L2Y3QShoqWdlIDbRgYNLbhyndmCXWw=
Date: Wed, 15 May 2024 01:00:02 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, badhri@google.com, rdbabiera@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: fix use-after-free case in
 tcpm_register_source_caps
Message-ID: <b5dv5qmijibyhqsgcv5mcdr2m2sig5hlu2vqsual5rzszl7472@gznxkm3nztbx>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Amit Sunil Dhamne <amitsd@google.com>, linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, badhri@google.com, rdbabiera@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240514220134.2143181-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514220134.2143181-1-amitsd@google.com>

On Tue, May 14, 2024 at 03:01:31PM GMT, Amit Sunil Dhamne wrote:
> There could be a potential use-after-free case in
> tcpm_register_source_caps(). This could happen when:
>  * new (say invalid) source caps are advertised
>  * the existing source caps are unregistered
>  * tcpm_register_source_caps() returns with an error as
>    usb_power_delivery_register_capabilities() fails
> 
> This causes port->partner_source_caps to hold on to the now freed source
> caps.
> 
> Reset port->partner_source_caps value to NULL after unregistering
> existing source caps.
> 
> Fixes: 230ecdf71a64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>

Reviewed-by: Ondrej Jirman <megi@xff.cz>

Thanks for the fix.

Kind regards,
	o.

>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 8a1af08f71b6..be4127ef84e9 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3014,8 +3014,10 @@ static int tcpm_register_source_caps(struct tcpm_port *port)
>  	memcpy(caps.pdo, port->source_caps, sizeof(u32) * port->nr_source_caps);
>  	caps.role = TYPEC_SOURCE;
>  
> -	if (cap)
> +	if (cap) {
>  		usb_power_delivery_unregister_capabilities(cap);
> +		port->partner_source_caps = NULL;
> +	}
>  
>  	cap = usb_power_delivery_register_capabilities(port->partner_pd, &caps);
>  	if (IS_ERR(cap))
> 
> base-commit: 51474ab44abf907023a8a875e799b07de461e466
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 

