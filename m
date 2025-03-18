Return-Path: <linux-kernel+bounces-566346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A866DA676B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CAFA164668
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD9C20E038;
	Tue, 18 Mar 2025 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+Bk1qT2"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A220E314;
	Tue, 18 Mar 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308926; cv=none; b=FY8Rsof7bHDaw+aQYCdt59Gg4S0EvNK8ebYzns+uDTdQXFFryhY7U03+O4PXw6TX88Ma+lEBcJdZ/lqYV+h5TqIQ8yI/d5+1df7FP2T5MMQhV+9+XfWooYKOxQWECoQxSYNsL2u2H/GZW35Oe5aOnt/KKCcUIBqSMQyQyomtK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308926; c=relaxed/simple;
	bh=m1D3DrSuMH0PruSbFteoGRlHfAZPJmpFXuyq8yrrSZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qo00COigIotJt6S3MHQT1KFM+58oqRx+xUEzURHSjX7qdWF8A/SAUVh8zCu6csxydCCLE2+QnlSz/tFYOjiI3fVtD86LTR6N26tN7mT54ZlVY0AzJ4t1sGD3+Aymph0WqyGIe14K6fjmrRqcuSI4pi6u2yPy2sn16CaGNyIRc8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+Bk1qT2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1095196466b.3;
        Tue, 18 Mar 2025 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742308923; x=1742913723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zspl3wVIwLYgqNp+ulEkFdZZ5E6KvnR50Qw8FWKSplo=;
        b=h+Bk1qT2SS+6rWx3D9LX5OwhcUdMxbHScqRh3ycQ4qfDnqjiR+F4/cQnLW4Z92kVHa
         bb7lMxn8qD8OOxpHcAOGRMfEKwnmIX5v2j79kiidH6gI/mao+ZfaCgExqRZVVS9bbT7t
         pBmW8xXHw9Zk2j301S8Wn/3NbyPNys7JXELQXAldU77yXQhaZV21VLAFfmcKBRNzI5LU
         lFAjh4vPoOiN9yy57aDxzH3SONW4KgzD9fx20WuKbRWAi1OFS/AoJ/fhikRzR/Lq2nbt
         o7zvymyVjriXbRM9b+3Wn5k5DylWPXoJzHMz+2fyOpaIy8SyA+lfwmEBFbVKACvnGRMa
         aKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308923; x=1742913723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zspl3wVIwLYgqNp+ulEkFdZZ5E6KvnR50Qw8FWKSplo=;
        b=epGOiMJLheHxIeceka6RqWVNYmkm25sJNY0a54YbmB4Hr5EdWEG6NVdDyfgiWY6qEf
         1ITggKEEFg/6LYewDzRvzN6+O5gCob6IVLMcMFkCwCmkUBGMOS6LQelp+XDNnsTrX02Z
         p3Cxt+tFxCzM5NLeULJUSHeM20oytaFd7Iz03/Q0wCemNk4oWOa9PrRNv4ngFxn/kObZ
         Bby/GIlIJ5yxRVHDupUwCuoHhdhq4AILNMAY2UBoywabcCgV5hARIooRnoIO5FZoeJZr
         fofJjImRUmlXJuJz2GiBSyH0EBbaGqrT43fgP7h6nzIFzh6EGPXsX/KAKS146QZQNA5b
         Tauw==
X-Forwarded-Encrypted: i=1; AJvYcCUt2pqgp0qBNtnSOt/OSsrmGl8q2vJgZXFwDvHso6OGYCZNkgMgEKz19LJLGoKIjL7Un6OKcUbWLhcM68BJ@vger.kernel.org, AJvYcCUxm5I2nHClZq/XIzlrh2oqlzl208mTf45OQj5BaNqez5k36a8gZMTLIpmsV6atEhbjq0XO3csoVejM@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1BUBk4TofGM6E77p2CKZzCagJ1a+ciHBEkK+qTKm1sB3MWJL
	ex9UV5W+yt7Og+7ppred/1gnJSHC40obBpWEbLUXcbl3CPO46XQl
X-Gm-Gg: ASbGncvLF3bk27zEEZxpVI8d34439bJpxSUtF319c55EfVXrBFyHr5wt2qUFDiYvGBS
	qotlmSX9hGzXZ5fsc3hc0ppdTyUwnHUaa91kj4TcKfGHA+NemBWTdXscbV9xAsEcHPnJtDPAUze
	GQ9dSZ+2JPZK+6BtkJNWGGGSGM8hv5+sErd6PQRRDEm3+IB40WWn1XApQo66C2g+wR1ietLOTMo
	9/evzXcu8qje6Xdi673I3VZ61ucY6uqYQGK2oYvqjoBytLodltJneLIkot+aNEfXZDEYpTehjkW
	o6Bjryps+sr16wGLTLzNH+Yv+61+inqfuu0HxGnbgYeE3I76KTd16aVrFeozlcHthhHZk1dlwsR
	LoUNSQL8x61y43PXYpoD8gmE2PyIQt6VYfMMfho9L8Ev9kg==
X-Google-Smtp-Source: AGHT+IH+JBVpBEJjBQE3T9bMDFZsvcfOx0v4Sq5kpGyqCVHUlHEPiHyf4bAVLVQeD76GwckPOycJng==
X-Received: by 2002:a17:907:d22:b0:abf:607b:d0d with SMTP id a640c23a62f3a-ac38d3fa372mr443830866b.16.1742308922125;
        Tue, 18 Mar 2025 07:42:02 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-95-251-108-181.retail.telecomitalia.it. [95.251.108.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81697509csm7722106a12.30.2025.03.18.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:42:01 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:41:59 +0100
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend v3 1/1] arm64: dts: imx93: add ddr edac support
Message-ID: <Z9mGNxfcquaYW0P0@alb3rt0-ThinkPad-P15-Gen-1>
References: <20250225192159.2907320-1-Frank.Li@nxp.com>
 <Z8+mcZw9yjOr3m/y@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8+mcZw9yjOr3m/y@dragon>

On Tue, Mar 11, 2025 at 10:56:49AM +0800, Shawn Guo wrote:
> On Tue, Feb 25, 2025 at 02:21:58PM -0500, Frank Li wrote:
> > Add ddr edac support for imx93.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Applied, thanks!
> 
> 
Reviewed-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Tested-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>

Thanks,
Alberto

