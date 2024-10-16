Return-Path: <linux-kernel+bounces-368012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454B9A09C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FBBB219C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007D208962;
	Wed, 16 Oct 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buM+2ulQ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9B1B395B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081746; cv=none; b=JKtj5ryQnRVZQpkURhC1YU+bAIWI4BvmVFp2P4o1Hvfj3XBSmTyZJvCObws1qZjImPBnQbkwpNYfye80zEKNudxT3IrX43djwQ725q63TyyJus1+BoDOAMApohhpV1F5G7JSTrLTrxkj04ospILAinSk7XiHfl0m+rF3EFe6mGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081746; c=relaxed/simple;
	bh=KspREqt4KaeMO3yuVoFhoMugEprbEhTggHjXvlDeyWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7h1nWmit2+oK8dJ98SDaXtBkSrRuVPZHVyksYGkXHItmx02SZwH67rNG0G9f0pyk2hUnVwZh/Z4qqiR2ImGnZQFrDVp3B1/hnbMKNSXmCL2FMTQ0cXtq2taxII11c5b3/Y5oCt+TVr8/Y93fZoGpt44L/wL1MVpkXYwzXl/nFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buM+2ulQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d47b38336so4176994f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729081743; x=1729686543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqRq8K4hvaYqPN23feyTC2SjJloWN6BY1l6v0lnE3aw=;
        b=buM+2ulQVm2rSmUdUzV2SMq3s6NZkHz1lCo1TkNMVbS1VJD5WekjyhHdXCizkgFJ2C
         4IRArdFcZt3K85omS/wofVOWhiv78XI0IlYABSE14yG98LbIe24Ok6LIMn+gAp5CJtGS
         bHggP4i+HpxQG6mZmrQJY1J/ZsHOYPYu7F+jSkTtjOIBtQ2H030vcJd/j3n/O1rbqJso
         ZWVaZLxq1jCNIHdxN1yVQYvQ0ldWAje3QZZoVfWtm7Rq7LZr8KurT4uNVNrDtpYcI01B
         57HfzRrainUigs7yU6JlkF7zdrYuv7msBagCShOcVQcRyYzM+jjSGaLPQtooCi0U8Flu
         VbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729081743; x=1729686543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqRq8K4hvaYqPN23feyTC2SjJloWN6BY1l6v0lnE3aw=;
        b=s+l7i24v3vKmOPObPZK+Ssr6yt3T8jJ2Nx6K+cGczKKWsnsriAWY0sQ9bTfVCcivLK
         5QMKQ9j8GCEn1v8kVGdE07MjwqwxlNDoZKxaAmbQstG4j2+qX7awyhEiMW343SnJ+6NM
         OuQjhSAHf8MYEIlE3WzJaSHU5iXM0gJMreFF8n3bdWxwOujOQVqCRmBpzhGhCI+u4lTw
         bcos5AjArSQzTDsY95mWCbeUoHjZUp5c9pxeCs91stm9/flQdT0GaWZnPuD33g5JkjzZ
         SMpW5yh/8gH9dTcU0WPlS466VRrKBs/sq+1WekXLaRVBRoai72pDHHUxaFyJNC13YOQI
         3dBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4XbANLRLwAGNafqrRTPefbK/okwcjQ7n2djcWUC5lXEMAnYfjlHC/CGWrSFltwDWEFsEG84sBo663kyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpLbTDFiCFPtFyozhWdat6wMqkFTya0FFn1zX9Vs/b7oHGd81
	uxXgoO174IlaEc0wQaGsYLUPZWGrNY0kkzG0NassLWVq0eovJZjm
X-Google-Smtp-Source: AGHT+IEQPsc5ucfJIMAR1q44dVYgDTDvroc8uy/5hf3QHqKN1OwsH+h3z3mltyjwdebTtVq7U427Rw==
X-Received: by 2002:a5d:4e0e:0:b0:374:c56e:1d44 with SMTP id ffacd0b85a97d-37d86d59a06mr2489037f8f.48.1729081742681;
        Wed, 16 Oct 2024 05:29:02 -0700 (PDT)
Received: from egonzo ([82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa90915sm4243400f8f.56.2024.10.16.05.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:29:01 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:28:58 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: Remove unneeded semicolon.
Message-ID: <Zw-xilwBCZoFea5x@egonzo>
References: <20241016113010.1619275-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016113010.1619275-1-roheetchavan@gmail.com>

On Wed, Oct 16, 2024 at 05:00:10PM +0530, Rohit Chavan wrote:
> This patch cleans up the GPIB driver by removing unneeded semicolons.
> 
> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
> Changes since v1:
>  - Make commit message concise
> ---
>  drivers/staging/gpib/tms9914/tms9914.c | 4 ++--
>  drivers/staging/gpib/tnt4882/mite.c    | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
Reviewed-by: Dave Penkler <dpenkler@gmail.com>

