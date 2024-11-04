Return-Path: <linux-kernel+bounces-395692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A179BC1BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8AE1F22314
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671C51FE100;
	Mon,  4 Nov 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XdGVBH6P"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43E1FCC70
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764605; cv=none; b=ZspDmpcca9etvNBNDWBLOnV5SGla/8g2tf+AILlvq0v9wMrWh+c7hKHT4gVIUbLQ/NestraL+QdwcUyfr32sWVqsCh4B/Od9SA6N5uv+HKfmR680Ttton6r/yqPpEX8FTNAaYwq0BnbBaENv2kCptU42U7Vppx+IP+8TmQDgkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764605; c=relaxed/simple;
	bh=GyiMXQlBq6qvZrV4GoHO1EgraZe6/DObPT0hriIoVh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8ECudPaGFYptWd745VfrnkT2OPWZgjSAccLz86Zx9EosQ4q2r32CyI8H6EU2sZlLNEZkSpnKZSMm+BwzvGjm6Ki40PDLTxQR/oDBSmEUBj1MOeF84WK6yHdrQgKRn0B0xmTbH2cwi0WMEBz1oPoIBCtXdbKP93nB/BLizvbg5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XdGVBH6P; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cb7139d9dso44616215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 15:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730764602; x=1731369402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsX/sQ5xC5xk/6SdoZ3Q3KNFL650Ny8AuOYjQqoNMy4=;
        b=XdGVBH6PIFblysFLRyTEqNwDBLYOa5M0nUUmCCUygzetbGDFPB7BNdNqe+FUANvPwv
         iI3Sv1mV+Jju8r0kaW3NxSIMmTCS5eIPdhMbt8DtvnRjZs8zFgPObJLPqqfzovWtbNDa
         lq6LgQU7VlhxdDnb+HQo5gpsLFU51nGMuZ4TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730764602; x=1731369402;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsX/sQ5xC5xk/6SdoZ3Q3KNFL650Ny8AuOYjQqoNMy4=;
        b=WuwNEqfQRNoAMkqTqz5tbHIXJZQz+SteZb3fsSD7Qp0siUj7y+xFCrAL9lsaY8bAC1
         XhECvpwdntdz2Lls1ozwDP68aoX3tDq4SvTldrKWpVF4CMhqawHchJHGYkqLbPJrnedF
         VuxOXROEyKDfgUeWJ7c9FH43qpymaoZgovFOU07WrigJ/H5BYWZ1nhiRELEHxGDqXps/
         fApJR7Ox/2MzeZZe0flUyTAr8RfGoCcOmAVkU74iDBSQNsicM3zW0lfKLge9nq+XMqeq
         15MKDe62hw0irS+hGLpCljAjeuRjA1+YmpE416aTbnTtuy39J+H4VW4joa5zQF2TE7ze
         ynDA==
X-Forwarded-Encrypted: i=1; AJvYcCXNCPw3nsUw8xWwWjBl5ut7gZFCRIs9zl5SrmzLBTme7kBzLMshyoYWeYVg4FIKi+smRau2Nt72TiwM17U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxX45ribTotr3z//vvjte6dlSkWyqS3CLtlRhb1LCJmJ6e9cZ
	pPVndMOCQQfOnzRi9Ep8HD5ztVCS7xZnR1X8pj4C6/FpWPbucgXr44c64S5Zv3I=
X-Google-Smtp-Source: AGHT+IFXrKScWi5lR1AqaeFnOC9rvxSoVe8YOCE1enP0wNblmedq/YRlE7wtDuDZ1oTXeTsAa9yTLw==
X-Received: by 2002:a17:902:e80f:b0:20c:9e9b:9614 with SMTP id d9443c01a7336-210c689bd32mr446173145ad.15.1730764602405;
        Mon, 04 Nov 2024 15:56:42 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3c49sm66855305ad.253.2024.11.04.15.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:56:42 -0800 (PST)
Date: Mon, 4 Nov 2024 15:56:39 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 07/12] selftests: ncdevmem: Properly reset
 flow steering
Message-ID: <ZylfN-YE0-dz5eVl@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-8-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-8-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:25AM -0800, Stanislav Fomichev wrote:
> ntuple off/on might be not enough to do it on all NICs.
> Add a bunch of shell crap to explicitly remove the rules.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

