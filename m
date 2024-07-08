Return-Path: <linux-kernel+bounces-244554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4292A5E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A991F21E12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90ED14374C;
	Mon,  8 Jul 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6THk+Uf"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942791411E7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453286; cv=none; b=jLUl8y/KLWl9o+TDU3IfCQX8u7s4FnTI0mej61ErwYPJvKqlxFMQf2NALda24JItuAfcOhEhFfhrrvA2EdGqdnCzfFgmA+1heFFeAB5Aa678aDDHgtb01c3WImbUnDGo+7a4u3ccBXSnqfCCU3dxUG4nYwnYEbQQRIERL96ogGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453286; c=relaxed/simple;
	bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvTxB0lCIYN1A+qjtJgg6At+M8F5rwjY2yI5nsEbg/PajcdS1yVtFm6lKnD3BXnv958aj4xIm/I9TG8REIOh+Slfe+cze8q6RrionFukadaPdR9RYG1ZYCA9ZFLoIwnV4lr9Y7rupI26N7aLU2ikp+aFYSn0OnutNQ118LDilf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I6THk+Uf; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d938024c67so226900b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720453284; x=1721058084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
        b=I6THk+Ufxa7oPGUpTwf25paKUBL/GcJ6sRYE480kVLl98UABU6FlLsCfabp3KC/4rc
         kWwXlPPyzqiDDVedwk/hJ+ZgdvSocmZEaccUEtvdEd2GXo9JjhrQCLQ6u7XdmB4MqXOG
         VBNxpVry7lAKQcf+9sBKJqkNVOSe0L6jbB96Jz9r/dvS8pLHH5NOZ8omkexEy+YQqgPE
         7SodmH1mQXB3ZisLRFGdH2saZZxSYBxSSYyZt1HzCVIGPvtfEutcYDOWnYeMlUmHXszM
         DD2g61wJWzdjQtcJ73R5qd/icCNRaKHFazC1u0Z1Nwr0winO0s0Q8xjLo4ed1daD7Oyo
         RtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453284; x=1721058084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
        b=pCK9pKIbF8hI6h1PXhaIt4Dn3LpioJAmemnP++1yITml/tBXYccpqwCWEVg9IrWCJE
         txIeL450KPyn8w7VI5gIjYBP5YC8HXoCjvMJRPf/kiwaWTXoUgUCBfjCmmRzlGabaZBz
         kYMrNM3CGe6xKW1J7YUGU1EA0LdN54z3931UU3vPntsAw7PmxmpxuyP3cTsyfE5Cc6cL
         c2Uhd6WS1joVe8oVyPxoHic89mtxVUFjr3xGAVWRp+B/EwTBh8/Fzq6JeuATxYXr0W2E
         xsd4xF790bzYUjM9XUuOb00wROuFIj85gn2ndTwFwwJ5s3nn/TuCw2E7B/GFFxRdJxLc
         hYMg==
X-Forwarded-Encrypted: i=1; AJvYcCVSvOnhirjhbPcQkWCAalitioJJCEMbdjitiIve9pbL74PhHzQAanElKsUsNhjd4i/4v8C7x/tsDtuoy3r5/GY7A0ZnOS1Kyq8uoyDC
X-Gm-Message-State: AOJu0Yzwro8OkqMWV8dqlLnebEkR5B73qpPCddhdpINOAAaFATbErwKF
	OuJ+KdvBFygAhCcsTftUYUthAAvAMb5aRayo1eA2oLB9M3l9eOESjbXuOgxGeJ0=
X-Google-Smtp-Source: AGHT+IE4fartsbVqJ1ZXTAUJYr3DKVogSxSpB+ivKX+k3fcl6RoAaf2u7l1kY5INfh9HbLRD0moHGg==
X-Received: by 2002:a05:6808:13c7:b0:3d5:633b:3d8d with SMTP id 5614622812f47-3d914ea41fbmr11853349b6e.53.1720453283519;
        Mon, 08 Jul 2024 08:41:23 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6fc:b7f5:4853:aff3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93ad2b3e5sm28150b6e.29.2024.07.08.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:41:23 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:41:21 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?=C1gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	patch-reply@agatha.dev
Subject: Re: [PATCH v3] init: staging: Fix missing warning/taint on builtin
 code
Message-ID: <11f00921-e8d5-488f-82e5-a22e68fc5748@suswa.mountain>
References: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zsk54zosv6tht4j4nma4ix7lq2knxi3ylqadd2foznc72nkaa3@xbc7gpozx6ai>

Thanks!

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


