Return-Path: <linux-kernel+bounces-539905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13928A4AAA6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAF1170D99
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441351DE4DB;
	Sat,  1 Mar 2025 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prGAcD6k"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EF61D8A0B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740828546; cv=none; b=aQhGs45kocfNrFk4LnlakE2KRSmUxbydq3YAArF+X0IvanOZqZ7xRUJCN9w3VRIt+JaEjOkqcGCN0ap4pCzy/B5/VQiWtoetE9RVDeBEJdtbgAZdclOmAFM3Bt3p3a0vCFaD1S0JqDFN/u0an5fU6NE0bSRnuAQeyqA1oFm+gmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740828546; c=relaxed/simple;
	bh=E9DujR3IizOT6sbv3rY7g2iXJ9du8KJP7l9vYi2xhUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi+x/MI3OBekdRJao/iuJSBcCYagCy9jEUHfp2Ccix7fhbNd3HjSGpZvOZRN9CaRhHGm2+dvL172YzEbLracVP0d551sdJJsHsxWELmtf/G6ZDjdtFxF1WfPZJfnw0/tjffn6GlQ5kUVn8Eaumgk4biusj3rGn7lXJcAKQz1Vrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=prGAcD6k; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so584179566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 03:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740828543; x=1741433343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhzJnfdycFMueoTPI5BXB8D50gcLoAdCXXuIai65Q+Q=;
        b=prGAcD6kwhreyqaQAREmdznrao895DvpGog1nY/0aYIX0iGVF+8mKpYPvATUfeNffu
         NZbfMM5GEOlCu/QhXQUhBB6diLIcblSsx8vXDtY3861Likecw9nahxy+e0IRnMR2QfsB
         pfuRtMaAICBt2Bksgav748AUNeQ4FCbA4fulY5a8AVMku3VjGPL0L/lNvRexHJVwrIMU
         viBM0/iomcD50VD9qj+QJ3TQCXCprotVe3GCoyUIWSIglJLgeU0e0o12OFcn1bT0kpeD
         r8xEgszUTztQcAOiV+HSEPu5S/+B0evNMtA2JF3suyJvlW0O8vqsNlgEnbbplExkhpJI
         iIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740828543; x=1741433343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhzJnfdycFMueoTPI5BXB8D50gcLoAdCXXuIai65Q+Q=;
        b=ZBPT+8sCSx7JFDJJmm4h/udcCh7ADRT6o9aSvhd96q4FLqbkSAEWDQTT7Wx3U0E7cE
         uDfLz7I5y6MKY6Rt8RRIHKRZlJ3+WGjlgqnZB/a8SmyYcwisJkL+c+iV1BCevsurOFq7
         pLA6pVrdAnyyDv/c/DLvOf3A64Rbv2cmq03J2mtF9X9w7/PzR916DBnqAMG/7xF2JGFV
         JBajswUuMU+RsW0Ph1EJsDTfC4BaAdWbvkn5LBIDJkDqHzyG183hZ+1dDmfFxw1N8NpT
         V35RMoK9bhP6LaOzYxybSYVh/JkvPD37Gedo1zO/WJj719gVW5XJgf1YOsmeAVZadjb+
         ycSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuqcks/jBHyGrQo72a2DyNPd0ovdAODB5iI/9q7FPoZeEvBgOj9VbUnGOpiQLgbnQsjzj1nWusa4ZsmGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3qbHlBPMalPClnRL9Bw0+kCUfOXA4KfQeX9SmWogd51WKi2C+
	BiSpvtGLZi4UNQV8XSb5YtKZ0IqNjwHWwzcsacpu2v+kgyIewZJPRXv62ZMlL6g=
X-Gm-Gg: ASbGnctmB0XaCzOPKFNJyYv390lciKffy/gMU5+y07Fy9RR6tkprOyy7YCdqdwInnp4
	dZ2QNbJkpFEBrqHUjFVSU3YU3C6n71CjbxNHU9AH4oukqbfF3UOBRh64VJWFd9xtlJPfRO9lreV
	3oDxYBTfxUAbmZAOeqBZG5XcH58pBVWfu9qcNMGWe5obfv7qklWinnVmeKswmczIhsy72qNDsNx
	0yghrSE4Vgs9Gc+q8AoeykgWlk9iiDLjkFV2cORg7+X2WrsUeVZbDyhoXlqrXMAqq/Mn1eGaFE3
	07RD1uOSxsLpo+uvkw925SpOhp9X9574PO4GfsjrSuLyx06DJA==
X-Google-Smtp-Source: AGHT+IEmtT5UDlv6mGlToR9LRcWyhK4Zao/oqUAxcObLaZwH1AUk9XBYd76/u37kZ+ts9n5DOSxrLQ==
X-Received: by 2002:a17:906:26d2:b0:abf:40a2:40ce with SMTP id a640c23a62f3a-abf40a24533mr409191666b.31.1740828543140;
        Sat, 01 Mar 2025 03:29:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c0b9cbfsm462821866b.14.2025.03.01.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 03:29:02 -0800 (PST)
Date: Sat, 1 Mar 2025 14:28:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Karan Tilak Kumar <kartilak@cisco.com>
Cc: sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
	gcboffa@cisco.com, mkai2@cisco.com, satishkh@cisco.com,
	aeasi@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] scsi: fnic: Remove unnecessary spinlock locking
 and unlocking
Message-ID: <95135f06-cd1f-47a3-8253-c4275e7a5c3a@stanley.mountain>
References: <20250301013712.3115-1-kartilak@cisco.com>
 <20250301013712.3115-2-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301013712.3115-2-kartilak@cisco.com>

On Fri, Feb 28, 2025 at 05:37:12PM -0800, Karan Tilak Kumar wrote:
> Remove unnecessary locking and unlocking of spinlock in
> fdls_schedule_oxid_free_retry_work.
> This will shorten the time in the critical section.
> 
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: a63e78eb2b0f ("scsi: fnic: Add support for fabric based solicited requests and responses")
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
> Reviewed-by: Arun Easi <aeasi@cisco.com>
> Tested-by: Karan Tilak Kumar <kartilak@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
> Changes between v1 and v2:
>     Incorporate review comments by Dan:
> 	Replace test and clear bit with clear bit.
> ---

Thanks!

I'm not really qualified to give a reviewed-by tag to this, but it looks
okay to me.

regards,
dan carpenter


