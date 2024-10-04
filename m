Return-Path: <linux-kernel+bounces-351430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF9A991114
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DC28447E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1DA1AE000;
	Fri,  4 Oct 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z1EAhie9"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC012231CA7
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075767; cv=none; b=U1fQFSF0n2WAcuzYlRn3U39RJe6bMoeWM1Nv0h8HAgHrqUJ8Bwv0ajMmH9vpzi5xnquvHymxnV9r66II/HSp5wxU7l6GCgrtm0PY7Pndt0O2W3Qzdkj9Qky57xBADstUM/tWlrtWJugERFPYFtz8OZ8UC67WAVsBb176Yff1q8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075767; c=relaxed/simple;
	bh=Z0fJUiXSWKF0/oClww5nKjc/i6T4KrfOP1RoDUDQPuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T+ytqOgJKDolzi/qGYCmRYhyAe1eoTSvc+eE/zFamnQFm/RZOKqeDKcKZbj2vKwIsQVmRZB9QjQR5kDo+4gflvIKfJo9wwvXoZyjokFvbvZQuNG7K1XsvN5sgvkCo4FEVG0a33KeGuYqCqKwIzEvuvusp+IFdW+58RA7u4X1Wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z1EAhie9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b01da232aso21186935ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728075765; x=1728680565; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0fJUiXSWKF0/oClww5nKjc/i6T4KrfOP1RoDUDQPuw=;
        b=z1EAhie9MGLkjxXXM7AhbkKvyCIRHeO/QJwco3IMNMyAjnzVcJ42lr2A8HWHhqJCIA
         L0bXETTLb6eYku5IFpN1vecJX+TrQEComrj+OR8Pdxg6gdXmnJxZyITQJvFKDcX8z+++
         hMhzhec2/UcuLbtWurrtCX4+/o8C1BrKpMQcYiQ3vZoRd7wS6JCP+stuQx7DWttaC7lh
         Tfhv7EjE7bQTZ5r3OMrpGQNnFyNMdUeU8ZPpUy+qQ13agq5i4VDE70bkQ85gMiJpCaRq
         4MGaRm5pji561LcCwiYbY9HbEwto+h4veBWOeZsqrN0gPvr67QuMC+DBIBUMTctPrfFE
         no8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075765; x=1728680565;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0fJUiXSWKF0/oClww5nKjc/i6T4KrfOP1RoDUDQPuw=;
        b=ocrzdtGwWmvT0DeTJAkyv2T5+zzfWJl1+fcA4/n0IwV0e5TCffYXC+3iK2ym0m73J5
         ZgkH7iL9bQV++HI/wLOnymjxSJ0UabKN+c3/6E3jT/PtqEz4OIdwp/ZwGoPeKN7b0TYL
         1Ae2J6i+wSX+pDSwUvRNB3r0ZCIB3QbAgIULiXkdVU/9ZHdLU6IgqLh7C36ON4zsBkxc
         SqI3mxWViJuuid5SPGQlYhY15NuAnrWW0CUhYOT1iW0tZYlpteop+tVq3Z9bViwfmwBT
         E/N3ciyBaeo6qHzWEPVPfmBzCyuTdXUs1Z1Kbe/mLO+RFiXK4x+ikd3qYNIPFSfZpZxn
         47dA==
X-Forwarded-Encrypted: i=1; AJvYcCVEwjUmdmpDUWDt5Lo2YejshHlRZHPreML7hWnHxkX8imWkn/2XorEhfKu5IH5JqDwHt/bz2kH3I/1xChk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBeiKxXmQm2eC3wQipnANAdwQ8tQ2uVzQcLtKIiIhbjFldThL6
	HfmyHrFJIf+6115+IULbImHmNSko1vtwSd4Uql+57i+zgvxBhNngCydlTSWaoRwxrcXkVOSt2nd
	+
X-Google-Smtp-Source: AGHT+IFDNzDiJhD0c97txDHvcsLQ1YdPdzVbr7H3zXAo1awU2N/Zgy5I/d7MVIKR+rnQSS0tJO808A==
X-Received: by 2002:a17:903:230b:b0:207:1845:bc48 with SMTP id d9443c01a7336-20bff589deemr57720895ad.30.1728075765165;
        Fri, 04 Oct 2024 14:02:45 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13930b92sm2677745ad.128.2024.10.04.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:02:44 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Paul Walmsley <paul@pwsan.com>
Cc: kernel-janitors@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/35] ARM: OMAP2/3: PRM: Reorganize kerneldoc parameter
 names
In-Reply-To: <20240930112121.95324-2-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-2-Julia.Lawall@inria.fr>
Date: Fri, 04 Oct 2024 14:02:44 -0700
Message-ID: <7h7cank2dn.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Julia Lawall <Julia.Lawall@inria.fr> writes:

> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
>
> Problems identified using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

