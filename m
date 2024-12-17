Return-Path: <linux-kernel+bounces-448974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB39F47D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC01164D48
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084C21E3DEC;
	Tue, 17 Dec 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JOWeYSFE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088F1DFD8C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428583; cv=none; b=FfGmaQWenDK2yOoDjoj3RiOjXkHifjuuq0oZd9YUlLGz0gKXLL36A9KPSqR8/Dn4Tyw3iDTkype5IGPu8d5icTkr+AYrBL/0ptMQloiSMq3PXicUnK7q+9e5g29rnjBDYVxwpMCu0yFex9P/EDX5XZw4U5y7Uc9KSLst/WHJZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428583; c=relaxed/simple;
	bh=pxyVV4TGOyj6n7ajmdbw+BlYGfszS+y5BbGyHT34lA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVPug2nGdbEFp2A5cLNNbAUrbA4aQJ3b7/HNumnmc0Wy0fonXc+e9nCZ3GyidWVWRlo/AttGASBhQK+DP/6+nXFRxrM6XxfSmZKePg7L7akM1j3QOUUdvoWOgYQSGeTphovSRAIcgadOKgiSX0b17pOQv9Nt876+Gh0Hv0exhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JOWeYSFE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38637614567so2277141f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734428579; x=1735033379; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0zWscc6GEjowz54BGQSGkW1pJRwlpJhMbPNayl4nOs=;
        b=JOWeYSFEzD2yTDr4UIqZYi1RHu3nfkPrP4Knt1nGwVItRPfsYQnHUWR87cxLpOL0Qw
         mlY+7PBf1FnjzKWbYtuYwWiyDTTT4gjAmFXvC8G8KhK5HtMh+nvZUaRsvBfQrgLnMELc
         oO23C/MNc1Bm8refYDb3PnJ2Tese1wP35dwxa8A2+yu7T8PUVtiTx3pbhVLiqjJ2pVOM
         vPiitIjcHHdW4xGkmif/vnczOtUS+VPM+tIc3dQp9Ef38KN+MNVgQGnqEvRLqfMkBAFv
         OeeWf4c8s/vuBkKOrg5Lb4uKO4nzR2eBQMWXLybG3j2HWEZ/FyB/sgMS6sf6520PEDLW
         qN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734428579; x=1735033379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0zWscc6GEjowz54BGQSGkW1pJRwlpJhMbPNayl4nOs=;
        b=si41LhkC9IF5ukw05dx1s6+vEoX12FErx2oaMIdG2jCj5Fp5VmwqB3kmr4u54QDa3I
         l4FF9hh/WA8S8R6EN7ZmC8JAJurN5xsk+NDljiexoq9L2Lpijt2z0rYGkdT4lC9GfoIP
         iKfrovw6j3V5wlcTMkPY7ZteqWlmKeAJLIB8RkPLgy490NVZ6p+zTrv+Qq2zHSyY4SME
         n2xfELolEY8yESbF4hP0CyT35G/PKxIP+3uqmJoEsl02aoXBhp2JW8srdwlKLj6a+h+Z
         D/gOuumYodmtkqJV8lnLuLNlnE4MRjsmQbGOMTy7oVlPUYpwDnmXIhhq9N70/hHt0dYm
         dW/g==
X-Forwarded-Encrypted: i=1; AJvYcCVhPCiIXBOVvtSez6j332g1NW9z39RP5KaBokEqH3BAycVoNSet8A5kAPOs0HcHqyzmD0xzbJ0XSs1RAgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxpj465dqPj/TuqGd9g9oe8HOu7ZVHQ4PcnUVV95lk5USPwemz
	SmVyu7JtX7vCnhqA3De3tZzNmiRjg1GsKC7l5MpKx+8vJSQP90LmMGTsq0t8uLUyEtxQTBYRRJz
	P
X-Gm-Gg: ASbGncurWcVW7AiqK9DVEn3lvjK1NzytnB90UTZ2/MBUeT5L+75KGmbYNYFojmhg4w4
	XB59bg1Ipdxe110SoMS0BPX7VFuhiIofnwUszJHerYLGIhZ5Hsat4S4UUnMjPrYp+/ZN8afVjVo
	vjHmR/qDsbYHL9eaqwe1LP9WFwaIC1RjXgFeLmmnbLGBG5WzEVXvtk5VwQr5ahPyDF+BaAZixxF
	ut+jFZ5r7NoxvgPC9yFXbkf3BNSsQbvfZLrJ7sLeLU=
X-Google-Smtp-Source: AGHT+IGlCacQMt5157fXg0/qexGu+6hbgZyluOnE3cEPg1UH6883ByoMHDdwDSiQkWiABMZq0skJPQ==
X-Received: by 2002:a5d:6d8c:0:b0:385:df6b:7ef6 with SMTP id ffacd0b85a97d-388da5b5c27mr2633644f8f.51.1734428579357;
        Tue, 17 Dec 2024 01:42:59 -0800 (PST)
Received: from localhost ([177.95.19.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dd3ef6sm55936895ad.106.2024.12.17.01.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:42:58 -0800 (PST)
Date: Tue, 17 Dec 2024 06:42:55 -0300
From: "Ricardo B. Marliere" <rbm@suse.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh: declare ctl_table as const
Message-ID: <7j4sqkjgkj5wd2sraigedoppbojjvnptrajspl5bqehihlvzln@pc2zwgtnzdkm>
References: <20241216-constify_sysctl_mac_hid-v1-1-f60c0871dc03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216-constify_sysctl_mac_hid-v1-1-f60c0871dc03@gmail.com>

Hi!

On 16 Dec 24 22:20, Luis Felipe Hernandez wrote:
> Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
> ctl_table"), the sysctl registration API allows struct ctl_table variables
> to be placed into read-only memory.
> 
> mac_hid_files is registered as a sysctl table and should be treated as
> read-only. By declaring the mac_hid_files structure as const, we ensure
> that it cannot be accidentally modified at runtime. This change improves
> safety and aligns with the recommendation from commit 7abc9b53bd51
> ("sysctl: allow registration of const struct ctl_table").

No need to mention the commit twice :)

> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> ---
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Suggested-by: Ricardo B. Marliere <rbm@suse.com>
> ---

What happened here? Signed-off-by should be last and without "---".

With those fixed:

Reviewed-by: Ricardo B. Marliere <rbm@suse.com>

Thank you,
-	Ricardo.


>  drivers/macintosh/mac_hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
> index b461b1bed25b2df106ecf612b82efaedf69f62b0..369d72f59b3c10869bc914f31e7dcb73e029ef7f 100644
> --- a/drivers/macintosh/mac_hid.c
> +++ b/drivers/macintosh/mac_hid.c
> @@ -215,7 +215,7 @@ static int mac_hid_toggle_emumouse(const struct ctl_table *table, int write,
>  }
>  
>  /* file(s) in /proc/sys/dev/mac_hid */
> -static struct ctl_table mac_hid_files[] = {
> +static const struct ctl_table mac_hid_files[] = {
>  	{
>  		.procname	= "mouse_button_emulation",
>  		.data		= &mouse_emulate_buttons,
> 
> ---
> base-commit: e25c8d66f6786300b680866c0e0139981273feba
> change-id: 20241216-constify_sysctl_mac_hid-55886592c206
> 
> Best regards,
> -- 
> Luis Felipe Hernandez <luis.hernandez093@gmail.com>
> 

