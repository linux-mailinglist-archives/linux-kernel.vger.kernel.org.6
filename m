Return-Path: <linux-kernel+bounces-262502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1689593C7D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5815B2281F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333619DF70;
	Thu, 25 Jul 2024 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnk3fHc+"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D2DF6C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929690; cv=none; b=E4HWPY/rlaHO9BDic/a74/4/dRaOelGQ0mX2Rr62NsOgleZWDbuBswctg7tBW2VJDUCk5UigM7xxtKCWN6w3Oy/Ba2RFJXWVf1ikXW4X91vf4MdejYGRLaY1fRlxBvFYTuT2CZVRRIHrgFYTQ9RZszL87IwDLDQ+CL6HBcYecUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929690; c=relaxed/simple;
	bh=ylJUHDQVLMCtIOGlV4v9JiMLen6bUSpvudW6kJ6gWcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkRc5DD+J47ZYdcuLJ8LqD+T/GXWLB9lQ6PjJf6sE9bL4os7LGKjVNhDwMFb9CWg2SxJAuK4pO+d35xkWeNHUPkJHnu9Hkh2PBC1op5nlyZUSnKrlGcYcq+nVfJcaXE84kfBOZQE9XZfsX7QBYQdtBWo6hhUOUtFJardLTS7L3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnk3fHc+; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-260f863108fso224482fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721929688; x=1722534488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=totiZmnc2/27l/qRsmSwJoAADxPrKT4IKHrFXmH7sCc=;
        b=tnk3fHc+R0WJERGuKZy2km1H2Q49PGh5oS5moZVWlRczOAxkDjU8vTd6Je/W7zoOIp
         Qlruh0XjOqnWZTKS90hl+znrY+Ulufh8ZZPTza9cmZXuVQK/4cs49SrQxUTTlbqD6clw
         DVXE6wC1jpv1Ke0KvPDny3R+RBpMojGtAzMoLAlZVh54/fD7RJKMolBlN15ALso3Iyax
         xZANyDIqFgCiseUDBIb8mV//a+ECldVt5Smi5T28ZBr1GVdwLCYA4Sg+qGo+ikZ5iLxi
         m7l80dFBwCvob+dk1MVBTjH8Voirxr6l3cZmj5OzoGSk5u4LnACp8WMUHwjgtRrjXbUT
         yMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721929688; x=1722534488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=totiZmnc2/27l/qRsmSwJoAADxPrKT4IKHrFXmH7sCc=;
        b=XOa0JaEUXefMPQzPvzgxaEAlY0QK+/zrScn//EafQBE9dNJH57CVTfBphQZQPn9WSL
         qA2NXnLg/2JcbcjuDgsD+WRbe94KaC8qlhXSwXh61POehuvEN1v8P5k4eciFzTmwv0ww
         XMNIkl9Au8jkCRQF2w2ek+V5svI2j31l2HEfXaNFAfOi9hTxSjl6xx7eKjcJPJyf9sZH
         o8NCCzF4Cv8ofvDa9XDTG46sidRMRGjpEqmG1zy9IJFWEE6AFaPx+wAVWxssHGZtgtMI
         BCpjTVChB3v/Xg9Xzu1MStVGkYA1t0VO4cb66zKCQ3xX+qW+egpYbxBvNvj5RJTkP6G1
         5SFg==
X-Forwarded-Encrypted: i=1; AJvYcCW73erlWky8OstUOpa6I8qg2m78kNjs38mgXifV8UmtgxC3Lzrya36td9wD1iGCGVwq4HdzzmUIEf+TyW1DlurYrLJjuF9bBHI6dZpF
X-Gm-Message-State: AOJu0YyKsRpKNPq2UHuxuwMjUW+Mws5lQwsayvvvwuzkfr1MusnOq0BA
	6/plBTvKGtTYfByHyxeaTjxq+Ku1J2sHRwBb6FqIRfjglw1PIVBgGnvAhyzmRHU=
X-Google-Smtp-Source: AGHT+IEX/kCSRxywmObQDI6MQ4+hW7tcaW8VoM4BAXUAqED2n9Rupayfm09laEbHhUk2rsVzTqZCKw==
X-Received: by 2002:a05:6871:1ce:b0:25e:24d5:4d6b with SMTP id 586e51a60fabf-264a0fe70bbmr3437026fac.50.1721929688167;
        Thu, 25 Jul 2024 10:48:08 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:6751:f2ec:fdb9:323e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-265771e484esm356209fac.42.2024.07.25.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:48:07 -0700 (PDT)
Date: Thu, 25 Jul 2024 12:48:06 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: core: WARN_ONCE on nvmem reg_read/write()
 returning positive values
Message-ID: <775f8dd7-75cf-4772-967e-3757c2375ee0@suswa.mountain>
References: <20240725112126.415071-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725112126.415071-1-joychakr@google.com>

On Thu, Jul 25, 2024 at 11:21:26AM +0000, Joy Chakraborty wrote:
> Nvmem core currently expects 0 to be returned on successful read/write
> and negative for failure from nvmem producers.
> Warn incase any nvmem producer returns positive values which might
> happen if any producer ends up returning the number of bytes read or
> written.
> 
> Signed-off-by: Joy Chakraborty <joychakr@google.com>

Thanks for fixing all these.  I've double checked and I believe you did
catch them all.  Plus if this patch triggers any warnings, then it will
be annoying but it's better to know about the bugs instead of running
into subtle issues down the road which is what the previous code did.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


