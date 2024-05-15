Return-Path: <linux-kernel+bounces-179763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16688C64FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D591F25355
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB542604B3;
	Wed, 15 May 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O14T9fHJ"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E345FDDC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769089; cv=none; b=DwWNqbkXmpiLG4pinSPq316Qso7dBB9SeUox/Xm2izdxrKOIxhCztQoLksOmfFXWRR5MEd+Gpbl5NMxlG+zawOG7fvOWyG7aSpZpYHAkQHxahL5P2ATdclaPFFFY4iyK4QO3Z8+zz4SpYmJM5gyfrBfkz+6+wULf+TuHsDNN/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769089; c=relaxed/simple;
	bh=qpCiEdvxKqwdG+d5y1lBs4jc9rD211BTocGCbHNSQ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/cuPQ9PXK8XWXg7K9A3gs6jcmET79PXFLx7cKHblK2q9EoaCzZPgdAWKIHqau/2M76dJo7VweiLOt1eWOEo431TAgqMxxXekJKZtUccl0haN/4JaOVIWW/izSszMtIWFRUqZy+I1qXWVsXBl5+MlJHSfrTQa37n23foJfxnxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O14T9fHJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41ffad2426eso50325605e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715769086; x=1716373886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjV4TTUb0QKx080PxSAg2NHcluzRf9bueF8g/pcjOOw=;
        b=O14T9fHJIrlK7D/qtMdoxBVs/tPGtLWQNPJaXOqbvVo60THyjrrCKnjnWpMVAPnp7e
         tbzzKw/7Fs8rEz57PGQNg4VkNxG3Xfl4ePSb/otKl5+1znUSmYcdEMthZvtACsdx/RES
         lBdfgGOIImPtu3UEtdZWp1vDLb2Knrhn7Id39kiMeUpJPIQp4ndRDUwAJZ3ZEdhz+k85
         6BDmFyHlNLI7rGTEU4CkADtk7XMn7/JXL5KCekMRmoSNO077jiJ0C0iSMljFnzF3edai
         uyD1Bn5r+63ox+O4TXNQikn14XFKgvYpOMLrnmQM6Z81WMjf7LAq3+qW5QyglyHeoXI9
         +FPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715769086; x=1716373886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjV4TTUb0QKx080PxSAg2NHcluzRf9bueF8g/pcjOOw=;
        b=lrHuURI07KXRJpePr446Q9PFZkeAtzpZLOexsaz4w9TKzpSDiMKA++wubV+aAW+MsW
         U8auknZnCODuAcALpiuB6PktdoyioILml0BMwBIW0KRSCnDX6Pcp3xtTKtETeMX6raXL
         2Dnywn3e02yGBuVQZjXr2cBcuRlIreOfv3/xNTCl+QuYOEZM5ppDAyvSgqi3fdwLdJXs
         jBjhtnUZunLi9kS9tmr5ki80dB+iymSlRe9KDwlKgxYoJW0Xe4oYr0Y+zjrcqH5B5Yf1
         MwHJwISqc3Yo2W7Tkad8G6QFJLF5iPa5n4kr57Ht0iaNeNs/SXwp2my3OVnE4qVYFa5N
         7L+w==
X-Forwarded-Encrypted: i=1; AJvYcCXgwj4nIS/bJqiiZF1fTbG0G3mr8f8Z0t5a5f7g+wi59y3egt5Ha+LrRehNMUSohPGEyU56xDJ++akHqWYkAJQQW46e9CwerguPWlwP
X-Gm-Message-State: AOJu0YwdzqR9kE3Zm8IMXLV11hcUkiUV4rPKzELLDCph+dwU+ylxwpzW
	u35DZKWyJZaj5/GZbPqm7qD8F5UjfCMBDywHhlpR6mdUsQ8jKiagWySweYcMv3lEFamMjCGH8bO
	6
X-Google-Smtp-Source: AGHT+IEvZyAZR5fcKV/6P27Ha19FRgf2etS4fJ9dWsF5pMRgDiPHAq/ZIvDQFUqeYItPSUTI51Ovdw==
X-Received: by 2002:a05:600c:4707:b0:41b:edf4:4071 with SMTP id 5b1f17b1804b1-41fead64731mr141037755e9.35.1715769085768;
        Wed, 15 May 2024 03:31:25 -0700 (PDT)
Received: from localhost ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad0absm16052659f8f.69.2024.05.15.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 03:31:25 -0700 (PDT)
Date: Wed, 15 May 2024 12:31:20 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/31] Staging: rtl8192e: Rename variable ChkLength
Message-ID: <2624273f-3589-435f-8bc0-8ae6514916b4@suswa.mountain>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
 <20240515045228.35928-20-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515045228.35928-20-tdavies@darkphysics.net>

On Tue, May 14, 2024 at 09:52:16PM -0700, Tree Davies wrote:
> Rename variable ChkLength to chk_length
> to fix checkpatch warning Avoid CamelCase.
> 

Just use llc_directly and delete ChkLength variable.

regards,
dan carpenter
 

