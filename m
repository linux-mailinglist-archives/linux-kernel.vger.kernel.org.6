Return-Path: <linux-kernel+bounces-392977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6D9B9A56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054D11C212E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769D1E47C5;
	Fri,  1 Nov 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="gsgk7/D5"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7621E2612
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497381; cv=none; b=MpOWmaMtl4qvM7gANHQa5m2MLqagIQwazifgtAcxyxIoj9CCWaRsSF1NBZbc1Cmwh8P9edfxz8IeRvwAKBvrklgTJT0RmXT4h4a2hvTYTLNSEf+2DOQPSoG3xlEO9UVtJ+3fx4PYjr9Ighgy26KSDFNIJNGzNs3NomSBlEjTDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497381; c=relaxed/simple;
	bh=/ZgM+DthZuf8tZlOitoakk/860/05c98LB7mxNSZshs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uI3vaUn65DGV2mGuMvi1yqcrnUY4Jr1mWHRDR7IG3m/m5PkmIcmaMBUhQgThYRDlP8WCd7WcDxJ0a2DYsbr5oOTV0kYV6Jhbw58XB5LVcobQPVxopBZV/pj7jWyXx1T83wzZYdv2Nj7qkBgKOkDJKH56bbanMw+y/yWZXESVecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=gsgk7/D5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314c006fa4so2659875e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1730497378; x=1731102178; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZgM+DthZuf8tZlOitoakk/860/05c98LB7mxNSZshs=;
        b=gsgk7/D53SvZmOhZVyxvXCwUIPrnGx888dRgAm+sp9e7biD+/ajo64u0wcZiDNtRpO
         4ywBiOocrq7lZ+UBgwFFp//d6epq4fndPTotIw5RVuviMWvdmvHT4KmNk8+epWM+bSJQ
         FfTNkqx0D9UHoDpOHtEET/DC7kF+Zo05GVfvYr13dF0ARVxYUbBp+I45a3gQCxUxQtF2
         jEeQEjsRq+bjvWeEW80tVY8w7OhhaKIY7YBjEe2TGau9AQWehkFcVJ2FUQn8QDKzNZoG
         bhVvtOhoYw9YZhXv3iQ92vyVaG0lcjeR0rKkJ/xJ+XKlde752f25aQQnY69ryTzLwzKU
         i7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730497378; x=1731102178;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZgM+DthZuf8tZlOitoakk/860/05c98LB7mxNSZshs=;
        b=jK5srDxtmjWuS6UrpzbPG8kJ41VUXU9xzyCxvx4r6t3/DGLbMdxo/zhpUNK34NUeSI
         QZV1rzDXOzwT6oQjfaCIJU15cLETrmzA3YrzXSn9SSs4jV60L0xgyFj5pQ6QTu004Hro
         7HSCbm7k/Tb6z4RJvHJe+zNKGZ7eAk9r3G2ynMbLOX40JDQjdZ5vl0sbZoYvhta2iCFe
         AX/eqxd0V+qxVVTgga+2VwnZKzIcU4Kkx4oc+h3zDgOZQAuh0GFBCb1bf6Bmsu7GwUGO
         cOEomoEakx7/cQjUPDndps+M3dZ2wTS8dUuLEY3kVMfpTpt7jgIWYdSccuL14AITZr8K
         sU/g==
X-Forwarded-Encrypted: i=1; AJvYcCWX2yT4ZrJv+XDLttG33lvvGX4iyq8P99IsJS//SJjiiTDwy11Axxx8FaLQwlBFsBm2jAZKPcz4f1xsz8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6uUCL+vW9dS+8FJEhiIzZvkQYTMKcqq2tJYt4OfyhaXYc36F
	6q6xS1xA+LgORP8gnLur2ivD2STMpaHGIUNxR7hKU1SKERY0WtczxvNOUEBj8ik=
X-Google-Smtp-Source: AGHT+IFLzBdexP8pqlR0nmX/00xf7SVomBe7J6FB0aM0mI5tvdjCnjz1DnH/K8jss5nUXrvUcNS6ew==
X-Received: by 2002:a05:600c:1c91:b0:42c:aeee:80a with SMTP id 5b1f17b1804b1-4319ad40b45mr97057145e9.7.1730497377649;
        Fri, 01 Nov 2024 14:42:57 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:a4f:301:15ba:84ae:1181:c3ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116a781sm6283185f8f.96.2024.11.01.14.42.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2024 14:42:57 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] params: Annotate struct module_param_attrs with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <ZyTI3NoFY7uGfTWo@smile.fi.intel.com>
Date: Fri, 1 Nov 2024 22:42:46 +0100
Cc: kees@kernel.org,
 gustavoars@kernel.org,
 mcgrof@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B4C6889-9AAC-4AF6-A2CB-9FCC0E479D2A@toblux.com>
References: <20240823145931.107964-3-thorsten.blum@toblux.com>
 <ZyTI3NoFY7uGfTWo@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: Apple Mail (2.3776.700.51.11.1)

On 1. Nov 2024, at 13:26, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 04:59:33PM +0200, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>>=20
>> Increment num before adding a new param_attribute to the attrs array =
and
>> adjust the array index accordingly. Increment num immediately after =
the
>> first reallocation such that the reallocation for the NULL terminator
>> only needs to add 1 (instead of 2) to mk->mp->num.
>>=20
>> Use struct_size() instead of manually calculating the size for the
>> reallocation.
>>=20
>> Use krealloc_array() for the additional NULL terminator.
>=20
> What is / was the resolution on this change? It seems it either fell =
in cracks
> or being abandoned.

There was a false-positive Clang issue with this patch [1] (and other
__counted_by() patches) that was mostly discussed here [2]. Clang has
since made some changes and there is a patch for the kernel [3].

I'll probably resend this patch once [3] has been merged.

Best,
Thorsten

[1] https://lore.kernel.org/r/20240913164630.GA4091534@thelio-3990X/
[2] https://lore.kernel.org/r/ZvV6X5FPBBW7CO1f@archlinux/
[3] https://lore.kernel.org/r/20241029140036.577804-1-kernel@jfarr.cc/=

