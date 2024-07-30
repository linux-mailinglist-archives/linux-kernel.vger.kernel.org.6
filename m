Return-Path: <linux-kernel+bounces-267801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26A5941599
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38AC1C22E26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257171A2C22;
	Tue, 30 Jul 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbQwnnDB"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FE21A2559
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354192; cv=none; b=bKxz/wwiFut6W4oKTNnmNuIOXFnid77k+Wf4AZoi3JNZxc00yixSHejcsWnb7LZAEsaVC8ouXaXFq/ntmEfYToilSO0WgwMmCqjbhf9C8bBjDsWKTzMgOvunLytziedfDg9sjNChSd8CntLe0ic9bJxOsURS8pY0SiE0z6yFo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354192; c=relaxed/simple;
	bh=rSvGfadipcs90Hv/YQ9X3+4TBeY+iyPipFcMLItNGww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvMF/geTjw4tPpA1shPBsXLvXK8cMm0Y7XLp7SMrL861FIVGdi2qpq2gZmvZABqnifqpoNq1Aap7neiBFhAH2b5WrXMpmEwT5HPVvbXAwRFvqJbk8hwUHvAto3Y2+ISXFkpOz+gj2jLbJLOW1GJ3oBmDkmPJRcq4Y5DfTdZ7NaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qbQwnnDB; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25e3d8d9f70so3016525fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722354190; x=1722958990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZs3J/cTXLWFL7SSFr9tAI/IXhUTrybV87IR2TNiVLQ=;
        b=qbQwnnDBWqxhif3jbOCD5EjvTscFRbA1mdvEaMFltz6TtvtOHsojQrzbmAgh8wTSAH
         T23A91Swf8LJYfDP3HGx2rBCEOqGL3IgoonIH4Mf+R9PBd8bsO+2kOrAtE7eDt4nzPNh
         RsHKALDAlxDzC6C7KPyEv2vayTlT6pXtSHOhJgtBd58DPaxCUdemv1wfq479t3VNpAdN
         sZ1oBq6Bd+9APK1HUGLalzeV0sOrMVoz3MqDuuqmuQ9I5Hy36XWYYRkmTEdHJcqWh1+5
         fH+3SAGuhOvWkRq19Z/jLyUemr1Bm0bftYyYfSfVcuvhPxVgdkJxVJNUZbYX5L+D3aTE
         nDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354190; x=1722958990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZs3J/cTXLWFL7SSFr9tAI/IXhUTrybV87IR2TNiVLQ=;
        b=F/96hU160Zy0q/KHDMy+qajm1D5B7QwpAs4+2OrOdK5wPfnP5Ezg+Av/tyhVSzxAyb
         pO8HkxpCw6O74Qa9ZdAJtToD4OfWoWez5Bn7fsA9JdVdFBWS8KTGzdD7vtbeyjWWh2Ju
         xjYPZ6rJlz7yMNdYE7MIrHmcvJHH8xMbgj9CeUyWVUtud2Nzu4Fbdy7HtVXfVDZ7y45F
         DioZ7Q61V/ZNmc8gLcum24bWhCf7TJz+V7383UB2REMWd+tgGr/BfcbR2A7gBUDlWiDL
         UrBGx/NFnyJOd7odi5Wb4vQinb/4fe6092+cPeWJ68XP1Y886hnuDiCD8IRIm4pCtkc+
         ZIag==
X-Forwarded-Encrypted: i=1; AJvYcCUctLEZPipoeZISkDsRX018i2xwkoSTOU74ue/j95ECdBVPSmHGa5YH3MlCLlH/T55v3MskXQ+7yqWY5fGb5ckhBQvB5HOX4KjqU3qQ
X-Gm-Message-State: AOJu0YyBIPjCR0UGkNUGuE8cKFOyaKq1Uh3gL7fwaLK2BsmTp+qd9HyC
	O1BJVLvM/y03+yXN9mBsmee+Uj3Ze/IYK/JLOFuL36YinOCArNyN0+cExoBfRdM=
X-Google-Smtp-Source: AGHT+IHyIFq/MJPHYNYxljNwR5PEhaFOsCTOZ+ANviYaWzIHF0QHtuX7rhJ3Yvr1fkY/b9wA7vbcGQ==
X-Received: by 2002:a05:6870:330b:b0:258:3455:4b02 with SMTP id 586e51a60fabf-267d4f3b2c0mr12329491fac.51.1722354190145;
        Tue, 30 Jul 2024 08:43:10 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2657723ada8sm2269453fac.57.2024.07.30.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:43:09 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:43:08 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kartik Kulkarni <kartik.koolks@gmail.com>
Cc: hdegoede@redhat.com, mchehab@kernel.org, akari.ailus@linux.intel.com,
	gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
Subject: Re: [PATCH] staging: atomisp: bnr: fix trailing statement
Message-ID: <582189dd-48ee-4ca5-87ca-dd640b09f18b@suswa.mountain>
References: <20240730123842.37487-1-kartik.koolks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730123842.37487-1-kartik.koolks@gmail.com>

On Tue, Jul 30, 2024 at 12:38:42PM +0000, Kartik Kulkarni wrote:
> Fix checkpatch error trailing statements should be on next line in
> ia_css_bnr.host.c:48.
> ---
> Newbie to contributing to kernel code
> ---
> 
> Signed-off-by: Kartik Kulkarni <kartik.koolks@gmail.com>

This signed off by line needs to go above the --- line.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


