Return-Path: <linux-kernel+bounces-205872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0079001A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98144B246A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D1187339;
	Fri,  7 Jun 2024 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdRobhu9"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6B1862AC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758497; cv=none; b=aslprps4TttkID4I3TIMlykX6RRVX0ORx6C0mPg/1M+ovU4G6+xiQ9hoh6AASoDXEP1m2Lwi2MbrPbPhoZdIMPgv4eCopQtNJrsB+/m82yWj8bwHrRCJpv+xJ94liWZAKHvRCvYQBuKEthshNDv/WO5zl43TgDOtzea95KKAfRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758497; c=relaxed/simple;
	bh=grRwC724PvUmoNcGmdXgtk47euMXChWb+9LwIxsSnRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmZPafHDN0tJmgnaI/aCrCcZuehBkiH1kQTJkYlvQUGIdZQZwGv9TsNil4AcikIGoFjttu1pnR87z+JYy90AhALBmzyNRWMOdI65+IFHNNqaigqLxcPOvF9m6VfyBFc3XW1cJxsVWfxSVrG+ryZIAiodOQEijOMekEraN6+jK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kdRobhu9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5295eb47b48so2515315e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717758494; x=1718363294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwvApUeqo/GeZM3yb0HNmlUq35XuhdMdPtdEy3Zogv4=;
        b=kdRobhu9AGcaO1stgTyvif1eN+kQNrtnOkAgo1ucPz/tBGc/g6skg+0nwYCeE0UbLI
         Fxv3kbz0VBrT7y3TyS16KO7lA7mnJdxP3r6XAhGcE61Mc9wgzl2m1/i95aVKgESVuS9y
         cu+xv1ePWw7fB0hLY+bmsvb1qLv1upK5DQmkDd/IqfCwvsVNfZHixRZXrUymgmyE+C8p
         vW/nfCeWpxlGD61jNPbvbwbunxAWYDLvtAVa3e55sliT5ls7MZG/Fl8n59PhDJxY5cZQ
         cuU2tt7tQtCkBrk09ZpC1D2Ug6KfVbfO3UpSedDpZmPd/M8VwdjACMVUg7nZt5R8XMej
         SHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758494; x=1718363294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwvApUeqo/GeZM3yb0HNmlUq35XuhdMdPtdEy3Zogv4=;
        b=d7lR9CleCYWAKZbkhpMEXdA8ILkaq3Rq1ek4T5d1VCDSIpLT6h/IjzA4L6oZBWWWbk
         J7k+u8PZJNib4MMXACJ9mbzQx6RHs0KPzqH//LLfHbYABDdiirxQTIA6QzwgQrhReRlw
         cFa5rkGeDi45sAPY/fiH6hepeyufMxH6003LDq+Cn/tG22/F0Npg8si3Ed9yZJk0nYAB
         oeq9IM09ZvRTMYR/xotGHNAVkIPmrsIlvwdIxi+92k3fZ1JEbb1c8PoOLEuwcRh3v7/f
         E1O4QEE6rchTuFAb5nBZohfI/t81lDGOMiLyLzerHDzO30FPce5jmEIUdZB5Q1sG0yBG
         NFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZEyZHUHWJFznxdpSKDISq3GExOlLsbMcxg0pmo9Ir0QeAeoCPh+l7Zb10NGvbG+Llkgz/nRsX53B1xPu1KN7BX15gQ3ZejOmnezfY
X-Gm-Message-State: AOJu0YzMTiCrqsfXMGG9P3qUOMYv6zNhs4zAnjw8ZcCvnocD934tSaK/
	9omcM21TJEUMXuhIUQmcxsven0v1cgH6zAqq58HUsISjWYtwOdzRGrIc1dukacs=
X-Google-Smtp-Source: AGHT+IHMqehAzz0w5PPYFquWBtdJd6J+PcTWUMrSDVqV2ejVV83fMkFQGsrAwfj1Oh2Peqi8rq2fUQ==
X-Received: by 2002:a05:6512:b9f:b0:52b:82d5:b369 with SMTP id 2adb3069b0e04-52bb9f7e70fmr1530867e87.27.1717758494141;
        Fri, 07 Jun 2024 04:08:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb42166c9sm498491e87.164.2024.06.07.04.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:08:13 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:08:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v4 02/11] misc: fastrpc: Fix DSP capabilities request
Message-ID: <ueglf7wcoi7prt7wrjp6nfjavzksk4wybepep3qa3xmpug4hkr@ha37oovjfbbf>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-3-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606165939.12950-3-quic_ekangupt@quicinc.com>

On Thu, Jun 06, 2024 at 10:29:22PM +0530, Ekansh Gupta wrote:
> The DSP capability request call expects 2 arguments. First is the
> information about the total number of attributes to be copied from
> DSP and second is the information about the buffer where the DSP
> needs to copy the information. The current design is passing the
> information about te size to be copied from DSP which would be
> considered as a bad argument to the call by DSP causing a failure
> suggesting the same. The second argument carries the information
> about the buffer where the DSP needs to copy the capability
> information and the size to be copied. As the first entry of
> capability attribute is getting skipped, same should also be
> considered while sending the information to DSP. Add changes to
> pass proper arguments to DSP.
> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

