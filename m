Return-Path: <linux-kernel+bounces-236435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2318691E247
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1E7286E00
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF3316133C;
	Mon,  1 Jul 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBJn6iiA"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED243D3BC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843724; cv=none; b=lk3U2Ua42VzBtq0FhAUw+u+MuGZ1Ql2jxRZ3rbi2A4e3+sihgRO+NbNTY9b26/ZwDV2Vyuew7a2VbkbRZ4uw6FZFkBj4+IMCnYcycTH9hoyGOTYaHFI9W8B0iE4x9Zo6Yh0gfH3CSsmW7bh88cYcdQH53H6EUIhUXtT+56bSqQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843724; c=relaxed/simple;
	bh=LxtuEpJdzPr3oQLvmbS2EaRpqRT1WsjVufXNSet/JJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELRCoz1a/uMPtIIPE1X0rmCbswVsD4WPa4x5mVdiDR8bHN2TUcrtbRopD2tuEOtt2mOF8oqXBND3gPbBhuqaCJC7CBR+UHZhBFIE6lmOLb2roS/+fmWxqUDR5L3VTPFFOlfZi55omrGrhzlnWnXKefbfOzZoZF4x3nZLGuPXLac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBJn6iiA; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5c219c54800so1466913eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719843721; x=1720448521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K03ObKsb30WbBMyJmbDqIqKU1C0pbAUrdm8Q0M5cO7E=;
        b=DBJn6iiA+Z4zfHYauu4eakrGIkjCctb5g8yj+KA+LF0cBpvfTvbEwkfvBfIikHJlvQ
         ud5kXKyVgZXwjm9KlWn32Ft1Qe1W0NS/NiNtZs6NsmprYDilhJvT80X7mq4P+t+q0lAQ
         VW64OdobOL34jN1Qidjs3ZWbBV50xSlhRhuzUJZZgx4/BUPaCX3/ou3Wns/BT33bUiL0
         JbShdXmPVeSpct7vvTrBNqTsrnVz/muwTtCDIdzjIEc3fLJqNEeUywG/5QVS/lYWxcIe
         q9/pJo1zV0sL0KAkzkWE91hXiAXrxIdXhSsoXK9ZPcUHB3DbXCE3oZi0qnQo/OvOD0Yx
         u8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843721; x=1720448521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K03ObKsb30WbBMyJmbDqIqKU1C0pbAUrdm8Q0M5cO7E=;
        b=tbNdTBKW9llde3P7XM1ZhAZ/YspJ43xr/fieSMUXyqA6Ix2fTamXcvJ2r7bmyLpa5I
         Lju7Jlr4owvL37/FVhIeu+/R+7qrU6lyD9SEA3Dr8FLpMVH7SReP71EPpVL6h0wpnQxQ
         PaEawHIFSdMBM4gz5Ri87j+KN40rx93TthAUjhtRyGC9zFe1rib1b3cwSTSm8AyEbYp5
         MA+HjIZFBaxLfSPbHlc83ojuBz12HjrthrQtIJqrCf8mLFPlMaPthNzaPUtDrjR/mgnD
         6nS49Si2BV2VStqyHRKk4wJJwwUNVP1bat78UQa9Bfj2zUqmSzuGU7SylcJKYrO7JsAS
         UXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD06hBl3R2KEvityvnc6KuFeO8q1Lj/TX8gb96Mu50oRLUCAigIP07KsqHmHzrk/IV4d2JGGWv88+1Ano9OcvklS9rv81NfJSqktnw
X-Gm-Message-State: AOJu0YypC3JerEicHe/X6NS0cv+YFR0w/um8DrwBGzQ78tKO98MGSvHR
	GcBvGT7BlIV/Sn6hbcJZiUPx04cGTwl/KWldNplVyApFxu4OjuuhpH6KxY2vLBA=
X-Google-Smtp-Source: AGHT+IElmVojqqFPd7WLZo0rySoK5/PWWVDrfwUNFIIu56dR1A+tJUy5Ehoq4+320Cw3qTfUiDaGJQ==
X-Received: by 2002:a4a:b246:0:b0:5c4:4787:1d4 with SMTP id 006d021491bc7-5c447870301mr3948738eaf.5.1719843721139;
        Mon, 01 Jul 2024 07:22:01 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:e8c6:2364:637f:c70e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c414835d09sm1028326eaf.11.2024.07.01.07.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 07:22:00 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:21:58 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Martyn Welch <martyn.welch@gefanuc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Michael Straube <straube.linux@gmail.com>,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] staging: vme_user: Validate geoid value used for VME
 window address
Message-ID: <d5ac7346-f8ad-43b7-a794-9b7a55fedc3c@suswa.mountain>
References: <9ccf4b68-acd0-465b-a5dd-4aa4569da9ce@suswa.mountain>
 <20240625095804.11336-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625095804.11336-1-amishin@t-argos.ru>

On Tue, Jun 25, 2024 at 12:58:04PM +0300, Aleksandr Mishin wrote:
> The address of VME window is either set by jumpers (VME64) or derived from
> the slot number (geographical addressing, VME64x) with the formula:
> address = slot# * 0x80000
> https://indico.cern.ch/event/68278/contributions/1234555/attachments/
> 1024465/1458672/VMEbus.pdf
> 
> slot# value can be set from module parameter 'geoid' which can contain any
> value. In this case the value of an arithmetic expression 'slot# * 0x80000'
> is a subject to overflow because its operands are not cast to a larger data
> type before performing arithmetic.
> 
> Validate the provided geoid value using the Geographic Addr Mask.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d22b8ed9a3b0 ("Staging: vme: add Tundra TSI148 VME-PCI Bridge driver")
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v1->v2: Move geoid validation to the probe() function as suggested by Dan

Yeah, I think this works.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


