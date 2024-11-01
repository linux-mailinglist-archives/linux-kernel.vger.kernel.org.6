Return-Path: <linux-kernel+bounces-392869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDFB9B990F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39FCB22002
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C021D1F44;
	Fri,  1 Nov 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/aRegKB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D841D0E14
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490924; cv=none; b=CwQQpltrBtkohwSmce7RIY2XIlTsqZm8Mrs9RrfP8bputBu7UbsNoeZCiQTjgyeJU3eEOm4SQvg6zKhaNck9lNLRKqxW6wrWGfbyzOuuF5obsWL7XfrsyJLDccTafV9/jLfSOEUhLBo3O/jSdD51npuG3ZihGWp0+b9KJxYSDEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490924; c=relaxed/simple;
	bh=kiXT218rgaa/i6xragvSEs2O7A/U/zKhIUlWSZvWPy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdUbdvpSH4TyIFo8vgDAMdHoG67S6JTDemvJ6lvbyZ5VFbwPhB07lrAIvhguptspWsIMlPyncbq1fBI3VzFOIpAq3c0nPdO/AfeqH/jjQWetSefDBEqV1c+dKq/81rXpwCNNK9v4BUvyouxOXCK9yuqRtyPuSkHyPlLdEPTERyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V/aRegKB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431481433bdso20205565e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730490921; x=1731095721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2KfVmPf7yDTyzuQV5+HlYzS4nyXc918Np3+MFMf2YBE=;
        b=V/aRegKBVZv6wjKtHJv4cJ0PZVSj+Hq47JFZLCnLr4hI92X4PZ6pSsnNgziba2xPEs
         cCivp+6ZvS76IBBQgczpMhaAqNvQjhglyEYzURBExa4PvzdiILaFJeSvvQOab8qkHmL3
         66DcQpaletEh7/P1/gsKR0sPiMQ+qu3b/XQB5SkQrgx/O//Us20QfX3gC4XWcl1EBomZ
         ibiOXHl77Znxp4UI5I5cZeDNbBN/SMWv1QU/WqKm/TXQrc/fAWe4E5f96+7UF1eXx9fL
         W6uwbU59uxWrjmDplORepWXn6gEMUdrPWpMtEUI6iJJJz/mMM27FQHt0EMgC3mq7LhZ6
         FtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490921; x=1731095721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KfVmPf7yDTyzuQV5+HlYzS4nyXc918Np3+MFMf2YBE=;
        b=BwQmxO+g/2AHRKad/l3GC5l/CYIOv3dKhbAxARTdv9tqAPsT8shiN+tp8feQyB/5b0
         jbMwS8NrnFdcA6Ck3PKo6JLTVAa5BaOZWpTViyOdmZMLvy2Fb9LK/FeNlkPooyiAIxmH
         3hZIFLWlsW9HNjjBnypanqzSBKkrzZDRwTPm6zR78xyMN8V42DRjf7bbJ7HwOJz6bEmc
         6W3ca3SUvF3aMdrGEAgjJNeXgJPPWo1DjcYjH3nM2aJzCxOepv3ZWygiBeakAECGnmN6
         3UgTt0SYtnGepGpyK3cB0J3abqmoLgwMMu71tEbBQ/mPeFDES3o9zbR5y8aJRfBUT7my
         UKfw==
X-Forwarded-Encrypted: i=1; AJvYcCUmV3efCnFv37c2HCAkDd2pIEQlNyp+fkmMqnCAVyN2ZutVqhNZjhwCV7aVw1FyACAy9aFNTYR5wQYWNHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/tA1gl5nG5FmOodI6vRgnlaAq1/jCkCEwlBYbmKqmEB1349NO
	r8TR/RzS9hwYAg13AlQfDWo9DijWJejyRly4acu+sYxk7IKk2lMi5ZU+kA1lTQDAafmhIIk3AHK
	i
X-Google-Smtp-Source: AGHT+IHt3uDFbfzDcf71B+rvAWS1uwMPRAkznrr0HHExtuL8F7pBTpvZ0BozP1TN+HDS/qiK/kLfcA==
X-Received: by 2002:a5d:64a1:0:b0:37d:4fe9:b6a7 with SMTP id ffacd0b85a97d-381bea1c1f4mr6976997f8f.36.1730490920787;
        Fri, 01 Nov 2024 12:55:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5c65b8sm71002735e9.18.2024.11.01.12.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 12:55:20 -0700 (PDT)
Date: Fri, 1 Nov 2024 22:55:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 8/9] Rationalize lookup tables
Message-ID: <42c115a0-9611-42ca-b326-e28b13988c5a@stanley.mountain>
References: <20241101174705.12682-1-dpenkler@gmail.com>
 <20241101174705.12682-9-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101174705.12682-9-dpenkler@gmail.com>

On Fri, Nov 01, 2024 at 06:47:04PM +0100, Dave Penkler wrote:
>    Remove bcm2837 table as the only difference is GPIO14 and GPIO15
>    which are not used with the current pin maps.
>    Remove GPIO14 and GPIO15 lines from the two other tables.
>    Re-order the tables so that the bcm27xx table is used first
>    as these devices are more popular and numerous than the older ones.

This feels like the patch needs to be split into three separate patches.

regards,
dan carpenter


