Return-Path: <linux-kernel+bounces-302552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA8960021
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B991F22E46
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF228689;
	Tue, 27 Aug 2024 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfsczR0Z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D645024;
	Tue, 27 Aug 2024 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731113; cv=none; b=hdSXkw4GoxBnoFscox3gaoejUhPEaC6l5p+lx9QJaBuwEQGy+Itb3bbHiEpIv3AFtImnLZbBWYg8wyVsaM/bRTmoDcdGS5HZkprLz6Wzujzg31Onr+zOQHhdpbBkVlCrekUNNA5scr0ag6q3y0TRKNREvukdSMe4r2NSt0c0Bbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731113; c=relaxed/simple;
	bh=6CFOT98r5Fod3U6oQTSBBboex8E+qgNayAj3KyGoUeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1TsGgaLoG3SH2ES6GAFBQyyp8WdaWaG61KrTgAReQiOKXGtKYv+cjYHiZr1l9byx+YDD9VAYa0tViwuWFEI9db9AiRgP+2041IQkd7sV9OnzAEbrilGTE+VMBGeZY5yW4BhPJYXqnwWPBmrdbibVWYVP0VyyegsoRlumuCx0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfsczR0Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201fbd0d7c2so40798145ad.0;
        Mon, 26 Aug 2024 20:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724731110; x=1725335910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKW36OOVVaGjYnc4xLLFE4dsBW5TSJQVQszH560Uq9o=;
        b=IfsczR0ZAXlcnoM6d4+1pNuG8cGupdccXrYgNGRXB4wAinFFlQ76+A6HMqqTpCHQv0
         LzzDyF40+NNndCenQxxhB7ZCRB75pvOzi/kpFETYlxpArLBQmf1TaJsRC+oIM8/yEkg8
         nJobl8N0+hB1BncljGF46ZiPU8WALPry8mHaYl/kB0x/Z7IMf9VCIi4RnEjSxZ3CyWLK
         awbCnLKG3xRV5/CZSWgv0qqKyO2o6ptk6XreT7V5NuHiGV3+tjGZ+c/kISJ055evB048
         lGbzL180O6rbRW7tjqXWue+3yKd6w9gifzQNak86PU9R41FjaOFlR/2hJDqw2/xTEP2m
         QI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724731110; x=1725335910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKW36OOVVaGjYnc4xLLFE4dsBW5TSJQVQszH560Uq9o=;
        b=lBEYzWZxJGVPUKEEmIsi8jb+ZmFqHTUntSgMcN7rzgFrglpK4mV51dfRY6EB9aMFp0
         uSw1/1CnI104pzX9XbQCzn9y9ZLmrMWuc+n6MBrraqmxreVMNw4rREIkEU8ddoFRWUD+
         tbZly82vHvwb28HpscDSQkGYWNxIRKccqMLMB5HnQALb7rDylWbaTVmN5riN6oSADukg
         x200gvex5MikcpzVI04lIOm24Er9rytlETEdU5Aj3czlGHv0QjNRimb3P3nMEx+2PmD2
         bMNytVsqHeVQwCfIlt2EGJSSzz2mCPageF1dnbZo8+N+n2JLDDLg+2ltXR44+a6xPK8g
         hHxg==
X-Forwarded-Encrypted: i=1; AJvYcCU7A6PD9nu8DNhzHD2ckX8J8UuuozfuZxo8SoPY9QQECM7cC0dvAs6Kk5EiB4q24pdKr2G1jQecZna8Ki0Z@vger.kernel.org, AJvYcCVgdlDEv3jt21DQfMtNW7AUDtOgpi77BVQyIxP3TB5F0k6ICpz+iUHzjNqg8WpBA/NboDZ6Au4kVNb3eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmnrBcHlBSJ99cfuZq0CK+HrqX/3qFKZAtrsoXdKXZxNY5wumw
	ojEiL0QVzXtjc3HCbFD+d5qynsb5BkN1P24qMiaGea+Xms8JRzVK
X-Google-Smtp-Source: AGHT+IHpkHWFQ3vwrfdMYAjbb8aIH3A5SLLz9w5XQ3Xy0LaYPTOtxjsfZiy8c8TUpatEexyFUytw/Q==
X-Received: by 2002:a17:902:da82:b0:202:64e:f9 with SMTP id d9443c01a7336-204df4840c4mr15324925ad.35.1724731110417;
        Mon, 26 Aug 2024 20:58:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385581165sm75044285ad.88.2024.08.26.20.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 20:58:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Aug 2024 20:58:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, cosmo.chou@quantatw.com
Subject: Re: [PATCH v2] hwmon: (pt5161l) Fix invalid temperature reading
Message-ID: <c16f3254-36c1-4ec3-ac09-ca15ed547413@roeck-us.net>
References: <20240819104630.2375441-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819104630.2375441-1-chou.cosmo@gmail.com>

On Mon, Aug 19, 2024 at 06:46:30PM +0800, Cosmo Chou wrote:
> The temperature reading function was using a signed long for the ADC
> code, which could lead to mishandling of invalid codes on 32-bit
> platforms. This allowed out-of-range ADC codes to be incorrectly
> interpreted as valid values and used in temperature calculations.
> 
> Change adc_code to u32 to ensure that invalid ADC codes are correctly
> identified on all platforms.
> 
> Fixes: 1b2ca93cd059 ("hwmon: Add driver for Astera Labs PT5161L retimer")
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

Applied.

Thanks,
Guenter

