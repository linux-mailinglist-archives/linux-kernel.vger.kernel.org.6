Return-Path: <linux-kernel+bounces-253456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7FB93218B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772C6282155
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48014207D;
	Tue, 16 Jul 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi9eln7A"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2D3A28B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721116574; cv=none; b=Bwwq/Lcc6jsR9+uBdZjlnzEv9SVEUAHO8Z749NpHefZkkXYCnUeSbD9K8DZqVm2BJayIFaOBrNcyo5onOstuuB+OHnr+vSVC7LuTLUmX2jNuvFniTkI3V4H72lafJEvr/S8ZF4wTLBAUMA4MJG8IglJBG7m8hJjE+9h8PWWaRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721116574; c=relaxed/simple;
	bh=eGDaAY3/XRuFEVLW6WrpL2ooeXOn8wKy33PDdF56nlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgxoxhGINGdse9/KpWRMc2Hgd/2UoQphr++PKlTWU1OKdPZu2gtb0fFQhyUCxE0K3N1HkYQtsH/v413wiyHiSMVnIUk4r0jn8pLms+RgojN264uSo36iYt+g7dcjluzkE3xcGEoDP7ycrLXik364eCzD2lyIMc7kp8aAIxvpo6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi9eln7A; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso560566466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721116571; x=1721721371; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbPuTnb1Ew+1mycf5dpfDFxGO4GDa+awfYDpyI/Y7u4=;
        b=Bi9eln7A3vPbRczQN7oV2jXgyef5Ty2Vf2WlEdVWKYrmMCbdd1M/MYBvteqxTp3SvK
         RyhykCu5H7epuYTAXiAjWIc+KYrriQJLU6x9uUJpWpQNiYx5WuiG1pUp8AkK8TofHYzg
         zu4AHcQt8uMyec86SU3Fg+hbc8gTl3rm9uFplWHywDO2Rq5ZFVyX0/fDn18QQEoIIlMi
         kd2mIQn81V1hKcufzpu7aGGLCT6XAsnNrU9Eu3Otc5YUzxIZtKhdT1r++bJcI5TzpETe
         F23D28muzr6SlxYjcyhCm+mBon1+uIMWvW83PeQBRO2vgT112pzrms/FNSri5TgdgOee
         pxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721116571; x=1721721371;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sbPuTnb1Ew+1mycf5dpfDFxGO4GDa+awfYDpyI/Y7u4=;
        b=HBkcVJykJQKcYZitlbd/jlxn3J5yriApw/wHEYgvzH0IC+RvDsEcnaUTmxXvNDviYc
         CEdfvca4TyCPIRtzrJO9NWoRwNwWS6kRdSsNQaqumgETeYcQ2kvlTIDmirFI8Fx8YcpX
         k91iH4dZ00fDJmaPIE6Sn1OInV7HYUdW4D7BFsg0UDFI0jUxYvCOq9VM5d57vQARXTUH
         G15+DThWmQe2IoQOKUFrSIaWBKsJVYXi48r+yIMdMsG3V0FEMmtuNmCrfGvcc0tK9NEQ
         5RZPubSWovcjPnK6tae+ImL7t7tjdmNvT7Tp3njRFbpfE6nm1LFuIkRo0Q3RQqwWw2hG
         46jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYBVcD+92XgLsgsmXwBBg4i7uY/CH791AtipSB5p/J/rkiqdmnYKkSvdaLSDZxDt4/yCaKzt6eUfQcu0mqlNFYW7nJ6/TakAYchmC3
X-Gm-Message-State: AOJu0Yxf4vnTVUiMeTQdJ2T81f5ZCl7PyEXkosR1xgnM07ESKsFsLBMJ
	v8K4Jt8rCqbnJT6GXHBVmJ+pkjM+rf/gliAjUiElTRzF7YGc7riAJDyZvQ==
X-Google-Smtp-Source: AGHT+IH70xDJfsbk7HzzKTXm/ODoPf3OSVeEkLZOxb8ox0+h93UtzF0hJU29RPGgLiygMJ5pwTWYOg==
X-Received: by 2002:a17:906:f6d6:b0:a6f:dffc:54b6 with SMTP id a640c23a62f3a-a79eaa7c640mr79355566b.73.1721116570426;
        Tue, 16 Jul 2024 00:56:10 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3a93sm279696966b.6.2024.07.16.00.56.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2024 00:56:09 -0700 (PDT)
Date: Tue, 16 Jul 2024 07:56:09 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 1/2] radix tree test suite: include kconfig.h with
 incomplete path
Message-ID: <20240716075609.rlw523szys2jztpy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240712074151.27009-1-richard.weiyang@gmail.com>
 <20240716021543.ghzeiq5yqtov43lk@master>
 <ZpXbalVnI9FzHMHx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpXbalVnI9FzHMHx@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jul 16, 2024 at 03:31:06AM +0100, Matthew Wilcox wrote:
>On Tue, Jul 16, 2024 at 02:15:43AM +0000, Wei Yang wrote:
>> If you think my understanding is correct, I would send a v2 with proper
>> changelog to describe it.
>
>It seems like you're trying to change something that isn't broken.

Currently we don't find the problem because these two kconfig.h is similar.
The only difference is the one in tools/ doesn't include "generated/autoconf.h".

And in related files, like include/linux/xarray.h, includes the correct
kconfig.h.

It is not broken, but doesn't mean it is correct, IMO.

-- 
Wei Yang
Help you, Help me

