Return-Path: <linux-kernel+bounces-424576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDDE9DB62B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59361639DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50099194A74;
	Thu, 28 Nov 2024 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="rlrLEGV7"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB81925B3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791776; cv=none; b=rytvLUefq/0R9amEooJgoi7ZQkhiIsOiLOnpQBERUqafbdVjWTEo4kKZbjAWx2x/GzkRDjfm9pjAOM6hjJe86sZqND3/u6Z23v8/km3G88R8DbUUvHNYvI4m9IrwLnSWyq085C9qZ3fH4QcjT1EmxV7TLOCjL0ey8sEz/61/PHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791776; c=relaxed/simple;
	bh=HkVtIayR9foQ5xZVMRAYZGNzyqx9gy93kknz1x9CCF4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va8pychY2UxRbEwrG/GDy6PaqkJLdxsmc9wmdYQgvupCfLja9vUtf/IEYcP308n6A3XKN4Pq90SlHE8VtL2h49emn4K1rG6AvsWCCLgZgzE8eEk8kmu+YyaF8L24JKjaNbrdHLoYsKbtakVkj2o89b9ewyKIfPcq7MYh0rWL/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=rlrLEGV7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d071f70b51so844347a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1732791772; x=1733396572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2jwobz0tUiTEvoVAQRqFl5xUiWCnjuXqJcLdQu4lR4=;
        b=rlrLEGV7J0Hi1G6VETZBW9SaLe95Zcy/SNuTmz1ptRbEgsA5h6361gmQMCT8qtOqcG
         5nlaKHrTPQtX2z7qylUWJYdo9k/PScwSFquuovfAe4lHPYTVEeQgSsV/ku8c9U0yQ/pj
         AJuwxdz/nadyi0hnKjb9pvD/h6pyhPOHlagrfECXy6XvWlNlfwzQ90LTD1ldqv91FEMZ
         0AfF9r/Ck6uIU3uFAyBcBaU9BtSQyx84Iy1WAX8bAVbq6R0Gf5GecFkZlBMtfVgZn4up
         wFvjY5Oef/3hPC+bi+Tw2z2hUNYvIZ9qWSrhkvSM35SfnEvXik35QPcBoSaTAGFgCAMa
         XPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732791772; x=1733396572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2jwobz0tUiTEvoVAQRqFl5xUiWCnjuXqJcLdQu4lR4=;
        b=wewxsSqxyYEXVP56yZrjSWcs6maZuU2lXsfX1fyM8t9GHlcAqslEMLFOBxzynUNPWY
         DlziLNuv+4iFbx6FYzsXWapMlPtlkeT0U2EkOHEFrW3XD86YpKahcF6pG1a2f66tmFeU
         5jZodpqhURaN2PTbK+kauiNDDDaZWzy2PzrgX61NP7h8SNJzFV1K3MQ9W3G/rShOUbrA
         ZOiXB4zUtVObVaNmIw7mkcF87s3RNQcLaFzQuhKfFx+kpkTIAWuuUW8AmztkDB2ZEu3n
         DSnajyyF2bmdREq/3QwiPIGhcL0u9oKL+zhL9XGvmvpmBxl9IeEk9BsXIlKCdovUAby9
         1OLg==
X-Forwarded-Encrypted: i=1; AJvYcCWH/nvctvxqz+U/hs/+9bB9ZYUEuNpN4jdYewbN04o3m8H0rM6gRx0iud8KgnPKrGb9EnSchi3unnUtlWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1C0DsP2fr8iixxt2vLxKkaxFhGiA1YyGtxXVOlNNxXpSqazQ
	IX8l+f1LzFaoJoRU2y3ITQAJCDnHg1P/c4Ta/0PXXVQnuvrlcYZVFzULvS6wQej+RUtwFoHzrCS
	tRxMn0civIjBH1tOrn1xMReGi7agAiAQ2oGCnqwc+t2VWpGJVpnx2iNypzFCY+VS9XrOltzMhc/
	B4HbizxI4Fr6LLsOSzCCTMkOHUqr8=
X-Gm-Gg: ASbGncupgn5H3jg05fKGIK5Ac79HYHnmF6ErsTbKALTtfuE1YggXOY0jzNM898eU8Kq
	sK5M5pAnc6prNjwS7wt62zX+tLPNQbtVfIykCs/nhryPKJX9PoDlAk2Q6s43DCJj/YY2VTXutzX
	3sbWrpaamLm8cfgm/lZ1/HbHOkZgaNQVKv4odXiOpjTgxDtmjuY/eORigkZThmPvrzLmcM1vZwc
	Zds/UqntYxsgETllWRdOHLIxeLAEutliCKn9nNsK6txrBcJn2qw7wc3VRXF/qIf9XDKbUYm2oCJ
	XBqxGS7JqISBwVQd
X-Google-Smtp-Source: AGHT+IFX+FbOsE2yr5AmUhyG7Thr6Holt/fq6gB5PxSluSHCix4v+HkEd87hynKdzyr22pwGJOpyIw==
X-Received: by 2002:a05:6402:280d:b0:5d0:a43:cf40 with SMTP id 4fb4d7f45d1cf-5d080b8c9bemr6225787a12.4.1732791772129;
        Thu, 28 Nov 2024 03:02:52 -0800 (PST)
Received: from admins-Air ([2a02:810d:aec0:2a54:184:ec69:1c84:8a04])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5999058fbsm53856766b.143.2024.11.28.03.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:02:51 -0800 (PST)
Date: Thu, 28 Nov 2024 12:02:49 +0100
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: robh@kernel.org, lee@kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, pavel@ucw.cz, linux-leds@vger.kernel.org,
	linux-doc@vger.kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH v9 2/3] dt-bindings: leds: Add LED1202 LED Controller
Message-ID: <Z0hN2WLfIOEx7x8l@admins-Air>
References: <20241121165829.8210-1-vicentiu.galanopulo@remote-tech.co.uk>
 <20241121165829.8210-3-vicentiu.galanopulo@remote-tech.co.uk>
 <173222307644.3811087.7654504224510124517.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173222307644.3811087.7654504224510124517.robh@kernel.org>

On Thu, Nov 21, 2024 at 03:05:14PM -0600, Rob Herring (Arm) wrote:
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

There were no changes in this patchset with regards to the dt-bindings.
I wrongly, did not add the Reviewed-by tag.

> 
> Missing tags:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> 

