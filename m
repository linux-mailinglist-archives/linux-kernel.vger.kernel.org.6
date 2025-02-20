Return-Path: <linux-kernel+bounces-524646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08E0A3E569
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDC770396B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9472638B8;
	Thu, 20 Feb 2025 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lC2NhlaR"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713351DED7C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081484; cv=none; b=dKinpf7FEd6t5hxGLtWzar2LUTdCmIHZ/ohTfqxGb/lr4yx207aC/CcrciFx89nKcR8hx50iwpSCcippW1XcXzNh7OWrk/7ORBYD9+8grsQ0wheNYtyXGmu5Syyua+LyLC89ct5cNsxEreZfZ4o0hcZz1dttRNPLTw+KJZiAZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081484; c=relaxed/simple;
	bh=jrlGTmgmhbT1peUN46Fe2MxKkTTrc+D4XgqIColiGGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOHOUvXbd5uQop6vIOAZHj6OsRajh1wRnEAES1MFtkpz7va/i28wcUlEZfYKm1q18fYcHDFQWvEsREFNUVJEfxLQw1WipQb7kOeNvps0mCDVkY2VjjI9yzjYnrlNKBKNKMO0EsVCg8tAdL9i09y75XJKJGB3iOhtojPHRGcSoBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lC2NhlaR; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e67f377236so10563656d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740081481; x=1740686281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kr1joMIDiETyhMXa3u3wcO1t9R4bjZJsjINmgsHmqAs=;
        b=lC2NhlaRmmo3P6GtYE0Y5L7gyeW00f1JV1B0MsYm9EBhQRGFxVvIaxMUo5yPBZL4vW
         cTHKgRkwlFj8J6eMCCfgC1qUjLMaYT9YryefKL/ezr9wEy+uxVb5gPnvO5X/EgWlmqFB
         XAO7iWDv/ECqx+4hPvvrpqSbHMlrFXncR73jIfYhhWDkbJ0RT/voxgrcAHsut72y82wF
         D5rT0P5MpWywJ8ANXVQK5UcmlIFZ8M68A/pD9a7E3+dUgGPBwyvM1ETFv0eMpN48u5qd
         TotGafwXuEG/UEe5yUjx5dR5IyQyjt+lsGgz+uIHHHoKsg5WdZLQizwEpPaUxXowMmx2
         HLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081481; x=1740686281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr1joMIDiETyhMXa3u3wcO1t9R4bjZJsjINmgsHmqAs=;
        b=sPB+CB26m2QBAbcF/IePFwlRvuugiuSV/qreH/TAIKSrqYtbtCNsDxRpIlUXH6HTQ0
         DZ0XSsDAnR0jetIuNd/lJipcdTXkwzWm06hsTUS24nrBaeLvmzFST+e7CjGTjdZ4LLMx
         EZIaEcPaoRs5p/2S/vMUGVzw6G3bf3MTgzcdd2n31BV7rQSXUMgm4Nj+SDBXu0QvkjKP
         zCcE6tJ2IBKdhk2MuBQdqVT1/cW3sd8BB1GIjxaUBALIDkr+c0R5737YZ6t3c9KQsWxr
         9Azs7mkdk8qxpnxazI+1xFk+JDyXVKqOLo49PnW0E4o6VlovNEdRcsbeNGrCvbOJLq75
         vszA==
X-Forwarded-Encrypted: i=1; AJvYcCWhVmFS1DjN6FefgN1/UuJk5rd39exYy7Ea+HWkT0IVRc5JHKZoO/2fUSC9U1jqboUO3sRbEtNtXG7uLhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZtktsq7S8rbl0vdudszYk1MpkXsVsRPXW1Kd9sK++NZgDqpzs
	dSnaJr0F43jpgQXnwfShWHiamwirvu/QfCL7b7TFy92mqc94OHg68jS7zKpo+sk=
X-Gm-Gg: ASbGncuRD69npYJZWtp3IYvvXL6gAUhBFSzjO0pVC1qiulWsOuneT+gcLta6/GTg1AP
	kHsvsNwhNqKjWkcWYF1RsRFlCBxGC8IyMtXTSW+Md2zEPkERvYDZIG3yz50MdNUDEzTfCqgZwm3
	G1FVWNFWwmGS+kpHsitFlJiFlrzt7H4HWraPRKBeOV8y6CHPru0GR91l6b5l8Px4I5PjfyQ8QbM
	SHewtKyWZALtBNYOy/h6P+tcMFvpZKzWgDmDUIEAaQXiiI3VKaRlQExl25t7ZzDbthDIIICr43W
	klmVqWFSfmlD1efzU2UAbCSw1EYLhZ2RQEr47LJJUjzfgEtLfnMoRt48KKZVKPeyxrf0rdhjyg=
	=
X-Google-Smtp-Source: AGHT+IHZS+OAndXZ63oF13Bq+bLF0/Yd5FRQs22lEGLPEgYn8FK+myJuX9Qfgt1NDL+/ZMzp5hGhxg==
X-Received: by 2002:a05:6214:4109:b0:6e4:2c6e:7cdc with SMTP id 6a1803df08f44-6e6ae84f6dfmr5284346d6.25.1740081481372;
        Thu, 20 Feb 2025 11:58:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daff4fdsm88988706d6.96.2025.02.20.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:58:01 -0800 (PST)
Date: Thu, 20 Feb 2025 14:57:59 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 13/15] cxl/x86: Prepare for architectural platform
 setup
Message-ID: <Z7eJR6U878BIwk1X@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-14-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-14-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:54PM +0100, Robert Richter wrote:
> In preparation of an architectural, vendor and platform specific port
> setup, add a function arch_cxl_port_platform_setup() that can be used
> to handle and implement architecture and platform specific code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


