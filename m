Return-Path: <linux-kernel+bounces-325395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07915975922
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8362CB239F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119231A3047;
	Wed, 11 Sep 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eO2RmY19"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22025FB8D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074943; cv=none; b=ixQUNO6dgqhoRZIkSM9LuJ0eFE4o5HDXSMTohDNSz0EPJpHPRsx1al1Q1wxrGJnkLyWwn3zHLCbKWp0aE+BAlV6ozdkYMaYmj0R5fGNCgcCbJ4SORX/99h6bGjtQwFcUBTJxJEbrU1nGaXMIjntGX5TebQ+ZQFjybWf/KgcJwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074943; c=relaxed/simple;
	bh=gKSJcWcx7/FQZ2m0mQH0VM1o1ZdEvOQ4khTHZUPZj0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7tq9KKzl7GnsOZNmfmCRzp2t20HlKpKVj+cNeT/xJRJjcEa73OXTv37r61+kMyoz9gECx1f2qe7IH8V6Qmgp9R9oQabNZSIRgJMRg6b38L3AfGsbOpLth5b8Q3TFyjBNzaJY9pWGlJyaYT+UfAtJ2sPPe6SY8B3LTdOP5c+CDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eO2RmY19; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so67431f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726074940; x=1726679740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7hIkqY6yzMI19aPeRgJcYOawca4yCAFYgaDnXopqdZw=;
        b=eO2RmY19Wwb90cmwTy1uXwIv0RIAV+JI5M2nKyExKJbeO3+1ez3Yeud9Y7Wzb+lqeL
         EpPoekWJ+u3RYgddgZ1jZNInA2WZ3gZ1RQQBH/soBW1QMa5F3TLTeorb4NqVewY0Jr1q
         61DWBZ1aIqgXGvvY238nwuOrNdd5FVaE27yAJpjYKpdSpBGwmgMPUPC7yOb2C5dM6Ai4
         iWx2879ACyePrnQI/O9qqQlGiJTwBGXeH4BZa8NrAv98lmleou20jNQ7UMPf5x/sGZcm
         vkXPnM8dt7VFkuZ995GzezZhtPhOzhZ9zZuKfozxulyY2f8M2GEFZoLVo19siCMqdcgt
         zylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726074940; x=1726679740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hIkqY6yzMI19aPeRgJcYOawca4yCAFYgaDnXopqdZw=;
        b=Z8+RsOEicKO/SJUFEn39vb4Qg7SeziHrmahf4hLqhN5tOs41geOKG6uOMQsfAt5nrL
         UkhAvhO9t57NR7z1MTj18joJLPDEVl17HdFD+AIIFrS+/fUFHUQkyoX+xxUriKQhvVns
         xsa1HyTyX7jyRcgL4WPu4wWFYx0X/eWSOaJpaf805IvaxP/G3hPRyN3MDNIXa2NHmpDz
         R56Gwlvc8JKDd3dM/RXOhIpuF/8VNvwAEA+f4Kl2iWwnRQ+Qi14tNZEg7H3iBUi0FaYt
         u8LJmey2T2wthoiRufmkif+C2Q0ASdi859i1/TOYQOIhEc0ST1HAXCX9zTTQgAdZVoWk
         sZqw==
X-Forwarded-Encrypted: i=1; AJvYcCWDWyniqzhbl/GnhCteyDMyJN1s9QtJjaYSKrV1v9xZukBcDeTcRVKQtHOrOMIP4n924LMUUWwXBK2oNjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxj0EBRHPDpknnxiyBLoqT2HqFtEoHy8B4FQgYL6L2LgQN5e8v
	6UXD0WPkztLfw3ScWwAVNr592bUn6jNaoMgN5lbENjvCu7sEipbOfuaKRyKeNVg=
X-Google-Smtp-Source: AGHT+IFwsGFDDcYLdQbQDbnH2ecaEuRN6fTPY6e7kQA/Klr6JIoXz9qoW0zDvWsGSBZmy4CX8Oxabg==
X-Received: by 2002:a05:6000:124b:b0:374:c942:a6b4 with SMTP id ffacd0b85a97d-3789268ee7amr8782092f8f.20.1726074940059;
        Wed, 11 Sep 2024 10:15:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a340sm12072218f8f.24.2024.09.11.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:15:39 -0700 (PDT)
Date: Wed, 11 Sep 2024 20:15:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	konrad.dybcio@linaro.org, andersson@kernel.org,
	andi.shyti@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, conor+dt@kernel.org, agross@kernel.org,
	devicetree@vger.kernel.org, linux@treblig.org, Frank.Li@nxp.com,
	konradybcio@kernel.org
Subject: Re: [PATCH v2 0/4] Enable shared SE support over I2C
Message-ID: <ddb6143c-1dab-4397-817a-32015984ff55@stanley.mountain>
References: <20240906191410.4104243-1-quic_msavaliy@quicinc.com>
 <ZuHNJl7VvMSv8q8l@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuHNJl7VvMSv8q8l@vaman>

On Wed, Sep 11, 2024 at 10:32:30PM +0530, Vinod Koul wrote:
> On 07-09-24, 00:44, Mukesh Kumar Savaliya wrote:
> > This Series adds support to share QUP (Qualcomm Unified peripheral)
> > based I2C SE (Serial Engine) controller between two subsystems.
> > Each subsystem should have its own dedicated GPII (General Purpose -
> > Interface Instance) acting as pipe between SE and GSI (Generic SW -
> > Interface) DMA HW engine.
> > 
> > Subsystem must acquire Lock over the SE so that it gets uninterrupted
> > control till it unlocks the SE. It also makes sure the commonly shared
> > TLMM GPIOs are not touched which can impact other subsystem or cause
> > any interruption. Generally, GPIOs are being unconfigured during
> > suspend time.
> > 
> > GSI DMA engine is capable to perform requested transfer operations
> > from any of the I2C client in a seamless way and its transparent to
> > the subsystems. Make sure to enable “qcom,shared-se” flag only while
> > enabling this feature. I2C client should add in its respective parent
> > node.
> > 
> > Example : 
> > Two clients from different SS can share an I2C SE for same slave device
> > OR their owned slave devices.
> > Assume I2C Slave EEPROM device connected with I2C controller.
> > Each client from ADSP SS and APPS Linux SS can perform i2c transactions.
> > This gets serialized by lock TRE + DMA Transfers + Unlock TRE at HW level.
> 
> Where is the rest of the series, I see only this cover letter??
> 

Something went wrong sending the series.  Here is the resend:
https://lore.kernel.org/all/20240906191438.4104329-1-quic_msavaliy@quicinc.com/

regards,
dan carpenter


