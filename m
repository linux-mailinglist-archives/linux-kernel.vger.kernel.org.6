Return-Path: <linux-kernel+bounces-213205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C9E9070EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9931F21A73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F6156458;
	Thu, 13 Jun 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AuyuDpfu"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF293C24
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281916; cv=none; b=KKTqDR+4oaz2HvIrFKK2RuR8aJLbE4i5SyyKV1oDujLgjdRoxQsvWgWxMby/SOKba1Hr1UYNJUi8KPCT0NbZBrNYSIOZ8qVM4StSUF+SfVGIEpg2fKhohe81oB5AAbJppaLZQZh1sxe+pKb6940nFyb/Jlr4NinM16bRdWkrIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281916; c=relaxed/simple;
	bh=AZW8Rvb658mUQ4oySqDO6/NWFh58MvjugKtDExhrDBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFnkrIPYyK0FLSh4K8mZlzRvMlYpM5rEMyZmznaiH4ipmsx3wgxkzqAYAXyTbTJQabedNNzS7E5Fr1DZ9QOOzYcjgBgRhhsU+oqgvS5xPI1RiRcyiDrQuQuVJUcH8ha/CaLilyCX/Vr6AutAttc1WS5yeq5+55tvDdOlqZxuMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AuyuDpfu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354b722fe81so931438f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718281913; x=1718886713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8egxTfBsYw5OqoHOD9rOCey9G2kZmw/BykgzWMoY1t4=;
        b=AuyuDpfu8Wcyt0e8bOhAvpQu+UECnLOWf3OPPneo33z8yTMaD/uWEq677l1yD/+BAI
         4l/4t8z4xQ3ZHR+sLVBRRcIqL3GOrI+G1Tm33Wb/FVOq0ARhGmLi2jUNY9RFCZTFCUqF
         aT3JC5zOj1RmJ7ErAQyHxVJW3ApdS6bfHeqYamL2MWuGpF9WLak6ERa1PhjFJQK+bqe8
         ekVsr8lgjd5yWAV8sSiILRbmQgnjCadEo14DBnNSdclZMl3+XHn8k57yinEc9u1MSMLD
         9FqyBs70t46vtDtmXpRMc+X5pNXoJZYnQyfeeLdugeg4h8c3EeIDdXBnTrzqyNBEML31
         6suA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718281913; x=1718886713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8egxTfBsYw5OqoHOD9rOCey9G2kZmw/BykgzWMoY1t4=;
        b=tGl+jrn+C1WD2XkkmNlr8m6sbFCcNwvhaoHzcpwyZThnB5x9+vM+0F2yH5ydPiBice
         PTIGPe6yn2g+sKhQYYZrx1SCxfT399DsuUd9fXKSyw7YE7jww/w1TznommUKpAoBLJXk
         CtkVjqRitPvmMZHB5uheyueoUZVJHrL7Hlc25ahImgzVYU0FIQ3z8H6cL5eeJzy0eBdC
         H3gbpVgtOD1RZzReAVpyJH4iVKkCDMa5BGkIVy4j28stBCx3BNgf29B6PCxME2DRZRKQ
         R/hP4Q7Vn7neRf7LqUgqymJ8mKA2ht9K8wWlZ0rfCJv6EYGzwbKctVPn0ddh8rPSRtlo
         FqJA==
X-Forwarded-Encrypted: i=1; AJvYcCVAI06Cl9ufL8hGTFEv8wxqKA+aVCa0nXnJmVNqLNAh1BqBr2M/ikCSHtiUULJ6hQKXWIKFMw0phc1hUn4kRkfcPNaQtP0zjT57xP43
X-Gm-Message-State: AOJu0YzuJ+pM9qnVt66ns+GO9io2W8QvVdmRXvA2v1RYCL4/I6s4r3GT
	nVP54l20hGJSTHQdbBVnYzeSt0rOctDe7WWmmvN7nc7mdKT8i7qDSCIoLc/7kY8=
X-Google-Smtp-Source: AGHT+IGf+yrqH+XhL9ODE4D5Aoj64YLHx+2o1MIBZtpH9xcNUucehMkrP4QhhWTr6HcAn9HTxXlOow==
X-Received: by 2002:adf:f7ca:0:b0:35f:25db:b2bd with SMTP id ffacd0b85a97d-35fe892a4bdmr3952383f8f.47.1718281913230;
        Thu, 13 Jun 2024 05:31:53 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm1656203f8f.79.2024.06.13.05.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:31:52 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:31:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Sean Anderson <sean.anderson@seco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] rtc: abx80x: Fix return value of nvmem callback on
 read
Message-ID: <b961981c-14b5-469b-b356-2282019ada92@moroto.mountain>
References: <20240613120750.1455209-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613120750.1455209-1-joychakr@google.com>

On Thu, Jun 13, 2024 at 12:07:50PM +0000, Joy Chakraborty wrote:
> Read callbacks registered with nvmem core expect 0 to be returned on
> success and a negative value to be returned on failure.
> 
> abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
> returns the number of bytes read on success as per its api description,
> this return value is handled as an error and returned to nvmem even on
> success.
> 
> Fix to handle all possible values that would be returned by
> i2c_smbus_read_i2c_block_data().
> 
> Fixes: e90ff8ede777 ("rtc: abx80x: Add nvmem support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


