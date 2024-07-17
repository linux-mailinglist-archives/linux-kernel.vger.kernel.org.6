Return-Path: <linux-kernel+bounces-255767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E279344E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B4B1F224B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2D537E9;
	Wed, 17 Jul 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OCBwfmDT"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8A41C6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721256398; cv=none; b=btjyU+rJxzJL0X9yVzvY7yyUZ4dAWjVgkn/+VhPU1RfQwwKozD6cqDqhs+D1WSiX/wXtVK66AhbzmcdI9Y0xzVl+Tjqyo/SOq/Nijkwyd0W+ym2qth4w+l8z9NgAE8YMmp1yEKgnEKtle0c1JagUz+h5qSR3vdZDIOzLyX8wnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721256398; c=relaxed/simple;
	bh=/5ssnIaPhhILazQ6ejiFbTxxbY7WdW6Y/GEgqLzcgb8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkHGnA/u5CcIBSbqpq4LHhFoFoQeXctVL8ac5JFRZfVfkq1e97tDYL/pbVqPAMuHh6GOMvBCowXUdtdt/ZT4TVHPVeS1RxdiHhqqm9utGm/btb8lxuYPhpLQiTFLy7tIylEUxDpHoDgodTbI3t6dzJ1lkCaL8WoBBGM2S/aeaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OCBwfmDT; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c694d5c5adso57640eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721256396; x=1721861196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wJ3y/2dvs1WFSHKfrAXY++/8u2h23DIsv3lh273sEkU=;
        b=OCBwfmDTwi0PWA2eDm/XrG5SGmB88/+eqA83T0XLw6m5L/AF2cQGBYlMolv19g7INJ
         ExC5Hxrk0Uit3Z42eu8vQe8k838BdQjSX+hVQtvoNHpOzpxA1IYBtp0xflaww4+RLeRr
         F3xRnxgVVW4J6Zvzmnd4afPJXtNfJqmwDiEtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721256396; x=1721861196;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJ3y/2dvs1WFSHKfrAXY++/8u2h23DIsv3lh273sEkU=;
        b=H7hsc4a+p+mNcQz2DR8+pdSVKSwNjXlok729QJqw71U6HetnBZeYQeOcoi+Xfb1El+
         U+9/dlHRqDwUU+7ROQzSOUIUe/H7drOoI8QLQs1bMqmmUyeqfiPGq6jOEFecJbbhY2Ee
         EA42I03YF0lCPjieaRabQuRaBtAYqXdmXsWEe5ZHyA885SBdra8tLrQQ68/cmjSfOibH
         CUGBYkBeg3KWwk0V4RfqNVwT7g2YEuc7EUB5LJJ7X+Cvg3PkckPypKa8pvJpyBrKgrtF
         DZbEi+fHddLUINyDf50kYstVB04fID+ZHGGehWbrgrb0ar652wrbksjoX2yRzMYdAXNV
         rfoA==
X-Forwarded-Encrypted: i=1; AJvYcCUf7NbPGEgAGJE9hx/h3oWfVD3nZaufnYDmmVzxEi6zhfWbGNleDHq+o5MhkIjHAgWLrDYkWqCFI2BRLGvDFQGF2TbdbNEAXZODU87d
X-Gm-Message-State: AOJu0Yyy1tPfMNeIwaqTRJyCBFc6jShQflJcZaIZ9GjZaa/Pvstsc3xY
	0RvjlUb6b9mV9ev1HGHJ+iSW58FJa9Mo9+i+f2D90vGLHiGkviV8e+iO7btUmoalNoOe5JgPwSG
	Moac=
X-Google-Smtp-Source: AGHT+IG2DOt6NJzNqx7F1J1cFMJNFMREcICId1xOoafataWoglSDZZOlhy/M0m/iwMJKLN51mtVjrQ==
X-Received: by 2002:a05:6820:2918:b0:5c4:4787:1cd with SMTP id 006d021491bc7-5d41d88bc8cmr4055721eaf.7.1721256396434;
        Wed, 17 Jul 2024 15:46:36 -0700 (PDT)
Received: from LQ3V64L9R2 ([2600:381:d627:95eb:19b4:6e7a:6e37:ba63])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d3cc6b4fedsm404829eaf.39.2024.07.17.15.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:46:36 -0700 (PDT)
Date: Wed, 17 Jul 2024 15:46:33 -0700
From: Joe Damato <jdamato@fastly.com>
To: James Tucker <jftucker@gmail.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: uapi: add TCPI_OPT_NODELAY to tcp_info
Message-ID: <ZphJyabJV2wDrKzi@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	James Tucker <jftucker@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240717-nagle-tcpinfo-v1-1-83e149ef9953@gmail.com>
 <ZphI8Z89iLe3ksVP@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZphI8Z89iLe3ksVP@LQ3V64L9R2>

On Wed, Jul 17, 2024 at 03:42:57PM -0700, Joe Damato wrote:
> Hi:
> 
> FYI new features should be sent with net-next in the subject line
> (e.g. [PATCH net-next])

Sorry, I should have also mentioned that net-next is currently
closed for a 2 week merge window. So, you'd need to wait until it
re-opens to send patches for new features.

Thanks,
Joe

