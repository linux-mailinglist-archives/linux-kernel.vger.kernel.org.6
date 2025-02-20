Return-Path: <linux-kernel+bounces-523820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42925A3DBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9018C7AA169
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84A1FA84F;
	Thu, 20 Feb 2025 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eDvOrpSW"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8F1FA14B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059380; cv=none; b=eeuKjyFEqIk18viDSIgfNwZ0HLFeSyhi0Qsp46UhGiSBlxVJz4tBwcOq8cXpTHywAbNU0TVACJFenHrvopWhjaA7MnexfNmKeqPLPcp68whsbXJAo+fBR+QqZKIRrBrR9B0it1TIFv8ePTQZb6Oq74O/exw3FtdDT4nR8fkij5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059380; c=relaxed/simple;
	bh=4jLX1QgKymHnqQ09UPLxaU0hjyassiaoN+lFIDukKs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njgjUzSJR+dBcSHDCUJZS9JPUU2FBECI5s2MzYlBraqK7FKrR5u5Fnk1lYWeedH5WauNkwZFGIkShn+zWwjzRXf7IsY+Q7SMoAONynZaJRpHD6g0A5dhe6A8QVOmsgWLM7go+PppLIaG5zqJmpm38Y4byR4wbr3PA3j5ttaPSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eDvOrpSW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a29f4bd43so8876651fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740059376; x=1740664176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JVChDugCDHNh1sYydRHTglk+V7CxAJZfPMAov1KRCoA=;
        b=eDvOrpSWLoHdDcjgcfot84wmPDejQVAXsez2OM/SQ9qtUyAt/YaXQEU4ABLTkUaa2F
         k1QqCxObIoW5uQ3hfEmcXR7JRQijv+lcCOSCBXDENINCqxATe851TSGPOytAw2yjgprq
         ZNGtndnipv1+hGTjyPFak1+hReu70IXwmzyh6bNbk7jEdJd6WloOsOujiefH+suLI83q
         NnSL5Clb0sNFEA+3ECIH2YgkU98CwlKgKhb7ueg71tlDQihjyFvYf14Ejk/zxpz63JKQ
         yLFU435PBIEpbAZyHARzapm/E3rKFbZ0eDpJ01TcZRvWMQgnVMb6tsTXnwGoPazoam1X
         d6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740059376; x=1740664176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVChDugCDHNh1sYydRHTglk+V7CxAJZfPMAov1KRCoA=;
        b=OuaE34HCcqEosK8MQw9SNYac4bNod7K0RPJEb+1tcI6lcH5zFWBwjQSAIxopUD0jaW
         44IJFfnaO4KqISwk2AISmrknDV5WJh6qpBse1fSkdoBBYhwfaYpLQFA+9j3U3zOkzS5x
         JBtSHrsbJZ7yuI49syIBk0mYxMsjRVenATaqV1SHhwvZdlgjgUn0vx2y6pFbT/YYiNj+
         0qhhsHwNbgfvRrt2NiNBMmjdWvqPZRiDgzebI5/tvcG1Zo7oR31myoxeOnbnuKC73dbm
         RZWfRLnbbIr9G1HataDGM3nUnKxYqLIJ29rHUsjF1rdfIDJyv105RfWV2z8nmgpv8bj4
         wyoA==
X-Forwarded-Encrypted: i=1; AJvYcCWCxGygOWwq6yJkKbe0k4kX7W+vBNyQj+oNUvGHgeqI4x/f3zZ0a3W5RbywlVc5zSidKmpF/datrjI0wwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfpk0TbDnPfqSiXDkyJCe1IlCJLEpaIJYhAJ6DRfFipLmRmnb4
	Ej1njkeDwir/APHxhpfjFl7idfhpVP4eNNFSVnGdE4YDLf7/epgN9GbZ8OJtw44=
X-Gm-Gg: ASbGncvGO4ToGi59gw//Wzx4+T1LJEOHvqtTPA8nMZWn7du+2Yno04kS2P2wjV5q3pJ
	J6aur5ATbqdJ/hrmxMTQKprYA8G+wcdzRIWSIgcjmZBjSFChuPpC9wCqdQa5JY9ATXz7MortFLD
	1NGUTn/AOCuuf7joUmeHtDUF6zk+fQmZZ7Nlx5z1leZhjBrEL9eay/seGmDdTK7Y3AevRVgY6vg
	NsiRRPZfTyZhJnT7toee5aYoV9nAdMGBiVn5gnEQgybyYjExBW2N3lQwgmDDvojP9iRmSumEiP+
	MvthfF2N/jKZ9Twes486pBLRnYCo3D4EpqkE4UbDyh1fvvxwMxE9r9/qrQ2kb0mKyVpVQy4=
X-Google-Smtp-Source: AGHT+IGsOfsqDJo7AefkxFTmXC+8Xia9z7Pzt320U3bkWePPHzHtswdcejk3sC0/NN4ev4LoA3nCRA==
X-Received: by 2002:a05:6512:2342:b0:53e:3a7c:c0b5 with SMTP id 2adb3069b0e04-5462eedb4c9mr2941295e87.10.1740059376386;
        Thu, 20 Feb 2025 05:49:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452e9099d8sm1939324e87.79.2025.02.20.05.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:49:35 -0800 (PST)
Date: Thu, 20 Feb 2025 15:49:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, thomas.petazzoni@bootlin.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] drm: writeback: Fix kernel doc name
Message-ID: <xgkfvp7dmgzd64hriccbpyc2beoj7syiw2a5pgmtaao3fmlhdn@a5vudlyhzhqm>
References: <20250207-b4-fix-warning-v1-1-b4964beb60a3@bootlin.com>
 <9efc1ba4-89ad-4aed-b4d5-b0a53b120fd4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9efc1ba4-89ad-4aed-b4d5-b0a53b120fd4@bootlin.com>

On Thu, Feb 20, 2025 at 01:51:37PM +0100, Louis Chauvet wrote:
> 
> 
> Le 07/02/2025 à 18:35, Louis Chauvet a écrit :
> > During the creation of drmm_ variants for writeback connector, one
> > function was renamed, but not the kernel doc.
> > 
> > To remove the warning, use the proper name in kernel doc.
> > 
> > Fixes: 135d8fc7af44 ("drm: writeback: Create an helper for drm_writeback_connector initialization")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Closes: https://lore.kernel.org/all/20250207142201.550ce870@canb.auug.org.au/
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> 
> Hi all,
> 
> Gentle ping on this patch. Can someone ack/review it so I can apply it on
> drm-misc-next?

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry

