Return-Path: <linux-kernel+bounces-208727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EA902898
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E098328286E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37114B96C;
	Mon, 10 Jun 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eLSeMQEb"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC014A0A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043898; cv=none; b=LMnLmOSECjt1h24V1nsH42oEFgwGKHyLDjP7Gk8Gg+XHOw3TQ4LBKIYLRwyJLmtPI66kIEj0kP6ZQnl5l0rAdj3unsd2oOACMA/JxDCci84fuSbGWBXZIDtoTQgYiYuVjRT868WD0vFqu2SOh5eDCuc+GVYgDm/x9iwfwUc+/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043898; c=relaxed/simple;
	bh=QXuGc6rD/i+3ogb5lW0kNGaFEh8y4OM7z/QYgEAr5MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnnKnOHFiI62/1I7zEGVIs2A8xmBhdSSeubRamV/zSLC+hmSUeVR3H5BEeNUeEnkJ76i/XBgEjSlQ/VxqGvl0kEVCJ8+pY+6SHtOzerXhoSAsy4Gpj+SFaKvUSJ7ASuRfhFT4kw6+BJCEYD7d86v/WYGIzoSYnDhhL6Zi8KwNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eLSeMQEb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bc1acb9f0so273923e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718043895; x=1718648695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85fV94iKDPP5ejIcWWbM9CJA1/LLXYa+BC+XEnAE7UA=;
        b=eLSeMQEblQEHvINMM8wPoPeyYMEbvLNMsN28WcBhjSepzbia2IrAjVXvCG9YQl2c9S
         U5ani+ASsjlq9Edxez+ZtyxKmAyOdYOUugB19gxT16orQEXZ0BmVxm2ObiwTXHz9Mscx
         4WDv7UrFboxomyaFBhFEA6VAWOK117RxDlRwGTDMunY1o/iBNQTMODFumrAT6FAA/1Q0
         v0DDayOXH+hvvxFC29cGf1KkCs+caAfZVuvyhg5XYpbYmbvW+EoWii64Sc0pd8w16BQF
         2tzVSuAjVjP9JYJznrG7D9WSUE9IqxR4fXwnet9kJoC4KMUr/4I9A49PIPFt5nI0vSGm
         8wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043895; x=1718648695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85fV94iKDPP5ejIcWWbM9CJA1/LLXYa+BC+XEnAE7UA=;
        b=FZ75zznl3MS0ICjURl6JhtDkz8yabsIXbNeIEO8Oo03AQH6C+hQghHabtiftEBjvNW
         OWjURB1FYY+xi2thqcfnq8zwKlkspGBcYFzAPchtxDcvCUDJ0VNd1RXZkk+y1IIpwtHv
         9LfHY094z3nhGJDAPIjAie0w7KQY9pfuqxjD8XZSIPIXduFZFib/iPD2tIz2+NaU8egn
         2wf6W4KynYL7jy3LxF+L5w4sPiOlsaccL2Q9BFfNjy2DeBKmd06mNmpI/WDKPUYSos1O
         XZFFZR1LlSCVThIP5J3ULepGxvrw39tuk9j4Q2/oYKsUwyDUqvJrMtxyQ4NWJDMaDqFL
         H5lg==
X-Forwarded-Encrypted: i=1; AJvYcCXDsEmI4mTxdI09eS2JeRiBAax7XSDJi9e+LHuMiLGXrOysq2wXFWtx+JsBoHdMqUHJYCcKLSa6SdEV7G8wBA/3BsBFufwVOTArtrHz
X-Gm-Message-State: AOJu0YyqpCADOdaemsPJWEMYuurKPLfM3AaphembLUmk5JEFB0i9lJ2p
	dksalRONBSQCDJBJfw1cVGwi85FYskSAxHxZJ9j482kHXbo3GPetgkCAKQwvdUs=
X-Google-Smtp-Source: AGHT+IETLq0+3npA+1ldTNeNlD3hH0XVRYz/fMMGTaoJ0jb3KRoa8rWuG2H/dtzMV4OR8i1EIR3YDQ==
X-Received: by 2002:a19:2d07:0:b0:52b:c1d5:949d with SMTP id 2adb3069b0e04-52bc1d59815mr4865449e87.54.1718043895209;
        Mon, 10 Jun 2024 11:24:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c8f54f091sm436234e87.133.2024.06.10.11.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:24:54 -0700 (PDT)
Date: Mon, 10 Jun 2024 21:24:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com
Subject: Re: [PATCH v4 05/11] misc: fastrpc: Add static PD restart support
Message-ID: <cy3bb2vch7pg24ldjhcq3pg456n5vrdwqsdcwzpghytrxzo6ta@hhhr3nelfipy>
References: <20240606165939.12950-1-quic_ekangupt@quicinc.com>
 <20240606165939.12950-6-quic_ekangupt@quicinc.com>
 <wsdk6i6wp5ahxs3oykwabtxfkqc3fytvaguchkl4imd43r2lv6@mq2ejnbwmpmo>
 <5e4a8de4-73b1-4518-a99b-78a85dba028f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e4a8de4-73b1-4518-a99b-78a85dba028f@quicinc.com>

On Mon, Jun 10, 2024 at 02:35:48PM +0530, Ekansh Gupta wrote:
> 
> 
> On 6/7/2024 4:55 PM, Dmitry Baryshkov wrote:
> > On Thu, Jun 06, 2024 at 10:29:25PM +0530, Ekansh Gupta wrote:
> >> Static PDs are created on DSPs to support specific use cases like Audio
> >> and Sensors. The static PDs uses any CPU requirements like file
> >> operations or memory need with the help of a daemon running on the CPU.
> > What do you mean by 'CPU requirements' here?
> Something like file system request or any memory requirement. For these types of requirements
> PD will rely on CPU process.

So, this is not 'CPU requirements'. It should be something like
'requests to the HLOS'. CPU requirements would usually mean something
requiring CPU cycles or min/max freq, etc.

> 
> Planning to drop this patch from the series and move the pd notification specific implementations
> to a different .c file as per Caleb's suggestion.
> 
> I'll address all other comments in the new patch series.

Ack

-- 
With best wishes
Dmitry

