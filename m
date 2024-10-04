Return-Path: <linux-kernel+bounces-351528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59E3991289
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F1328564B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99714D2A2;
	Fri,  4 Oct 2024 22:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aGuwIpkM"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B829514BF92
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082574; cv=none; b=B5VzKyhW5Yr0WI7aGugXRuqJ+Mu1aXQk4YN8fObI3uXslX8qbI1MDxScRmDdBmPHZUYB68czrydBbHuqESO9AClR6bnhAsZf7sdanLarDM6sIsFgrtTaMbtBKI11wp6Nm04HVKMmeOUYyqytalodlvKsMKyHQJX5HvHU62gcJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082574; c=relaxed/simple;
	bh=vSVmowQuOxKR6DuGxvZIDGlX/xY6PERh9dFLSMSYa7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3jiN+pX4UNLogI7HGRQNBjhJvZ4nGfrwS0kbLKzY2KPjIfkN3o1AHAZlKVnkPzEQqko+t7QA8dBd4MD9MW5zekklZg3a4gEUyndLRYZcK5kDAcUGdY0IofXzYl4wjnGxvCSe69PzZSg8qIjEn2k1qfit1rhlg+HQDRV1kb5b3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aGuwIpkM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b6c311f62so23917045ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728082572; x=1728687372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i/GyTrIjov/Q+/DDFg8zN5CnnVd536FyJYodwBH8Fzo=;
        b=aGuwIpkMcn5q/XeBM8A68GrDLIuSZ6tFTj0BuFAop8+QPnsOtWOmak4qp/lJTudndX
         0ebdZRMmohWvC9GMVg+1dvJaQ5P8Yzi4Lj5fNE4SmOM4smh1nIIPn3PInUHqJvRmPOS0
         +wa4PrjnqG9ZFiIXg4ZnO6Jp7z0c+79aDFqFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728082572; x=1728687372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/GyTrIjov/Q+/DDFg8zN5CnnVd536FyJYodwBH8Fzo=;
        b=soZQOQda27Nl5com2BnMp9V4RQzYsob2sqlOWL0aa9hkLlSwmsacQdqwDfxsrkHmT4
         BmAdGqsYGu4ltkkOmllRG05zVg/WHFXrQ/irryXUOrFfIzBxrJ5WATIKdpzzUx2rEONQ
         IIPsHw6ZIOyFvTyfA03L5N4PHq4Mz7jhc6u1KnNQl3fobx3xPOGkKxJAixZ5Dg0M+FoS
         w8+QNTaeUa5MoFvSmaPP7WhPViOBhFHkSaR+Y9Fft05t4oVXgkVruyGBOZETfnH2Kv3q
         5V9uXODWea5FCAQRNV2hiFBCgo4mxu4nO+3455XCnUhquZb433nLJg1dgD5DrZBTcJAz
         OLbw==
X-Forwarded-Encrypted: i=1; AJvYcCWfNDyg4WnXPZzy5r8AueElQPAQwb/oRLCaEeezycFQ5Dl2BwCE8BS3Q0zVJBQRdl5Cof7zEFb0jdQuRa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/N82SvD4CVTKlMnkFddUBxwIf8QAbgSKGSo/rDr4q4E/mhEVa
	NSz5wIs6hm9nIIM9OM3v4PKP7Fe7V2U+d9i8q6mGgyPzi0q5K5tVPF7rBbPMRhFRZNxqC5Ji/UA
	=
X-Google-Smtp-Source: AGHT+IH6icUWoo4zdrKPw2th4xxk94nYEcoQEUxeyVS111ASawmnl79xThXdwoJ/OkAtj0v4Vq37qw==
X-Received: by 2002:a17:903:2452:b0:205:6552:1099 with SMTP id d9443c01a7336-20bfe022cd9mr46260195ad.8.1728082572054;
        Fri, 04 Oct 2024 15:56:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:431c:f73a:93be:1ac2])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c138d1568sm3516015ad.75.2024.10.04.15.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 15:56:11 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:56:09 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 01/12] wifi: mwifiex: add missing locking
Message-ID: <ZwByifOXJMO6PX2t@google.com>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
 <20240918-mwifiex-cleanup-1-v2-1-2d0597187d3c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-1-2d0597187d3c@pengutronix.de>

On Wed, Sep 18, 2024 at 01:10:26PM +0200, Sascha Hauer wrote:
> cfg80211_rx_assoc_resp() and cfg80211_rx_mlme_mgmt() need to be called
> with the wiphy locked, so lock it before calling these functions.
> 
> Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Brian Norris <briannorris@chromium.org>

