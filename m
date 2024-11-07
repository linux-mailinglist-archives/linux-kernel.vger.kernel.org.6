Return-Path: <linux-kernel+bounces-399889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F49C05E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D621C20A7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43AB1F472C;
	Thu,  7 Nov 2024 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T/i8KB/e"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A211DE4F0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982906; cv=none; b=m1TgWkDIrlIldZRGXso3HFV9Y3OPRZLt5AwBcIkoMUJjo0Ep5Ich3rOlpuCuqGdUXV8CXrFSsyAyjGZ+D4wWv4HkGzu9pg0RYe0VpHg4ZJg+cWR1GblGsjlyrL8XwpjlWCkPJ97Aqgg5Yn9JVlYOkacMtok48Mhue95h6Ur9w94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982906; c=relaxed/simple;
	bh=Esda7sxbhP4fmYNvQU/wAslDDgX06gVPKFPIdwfsU+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOizMv5PLWw7q9XcYaeaANRYB4Puv9GZ73SIEiD6/ZmsgGinrPPIKdqWqTANqFyH9uVXsGfy1GGBtWm4iseLrabFlahNxT/gpnWg11UoCcP/GnuGLNvMfjFxK5+r6HMALBoxDdiCGjZuCOTTERMSUp59qLNnlFOKD8UwKDux71g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T/i8KB/e; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431ac30d379so7542655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730982903; x=1731587703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1E1HnzW14p3ky9k8ykLp0FSr/w1f40YmC6K/07hNjw=;
        b=T/i8KB/eFyxCVOLSP5PKRigER5gise95lorYfWRq3a7ivXoa/8je4UVKYQ+GDhGUJZ
         o5FjBVw72GkKE82oknX9mHyl/hVCPQJOEh7Ao0M7fa/L4+e1FVaJjyyDOBJbr7KsoCZg
         EzKvM7yAgPG3ORpajHmifSdWODITFudOfntxFy/WeOJxV/hlBJu2Uc49f46l69uLvefK
         G+ha8qw2HKGsrMQ/VmNa9Axg0IppqFPvCSDmHrRSpBK8xS6tKo2p8Y4RYKDvHlTNGClb
         k6VnulrYWsmAXkAk6gej0TVQksuhYniHePVvPKNR3qma+TRlxveI5vmbiaHTaiEDn77Q
         NWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982903; x=1731587703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1E1HnzW14p3ky9k8ykLp0FSr/w1f40YmC6K/07hNjw=;
        b=gHRZpTy7DK09vqqpSoL2XJkn7VFcYMjvrJMOXD2xutuaNBYGpJf7lflnH+yEQAV8Lm
         XyygEBH4vuWGrKLtfBsidTXxrjmZ2jJRD8di4VhkJdASwKm2Ap5ydlqm/gFhrxyiCyk0
         B9ARnaiNVdKXPoT7T4Qq/DgDpSnI3i5t/jlLA2NQoOHnlCuP7j6/vBdJZO/Nl6O/PBKO
         sPC/ulcLVJFhwar44frquuLhSEEJXJnnXy2KoLArfFxExgbODWR4i1c8mu80Aup0YARH
         YkpEwsSVNStI+HpviJ30EgJO6RT7ZQGX9Lp5cb9vGPsb+3KWYkj6h76d8gKmAHmr25j5
         NA6w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1yGV7hXJInJd+z+X7tjdMRkFo0pPL0PAogGj/UDsjQLzsJzhmUHNIrQPcYeCE+7BcurjKikm4LuCtSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+WCZljeNYnvTy6f4QxHOSTlDKIIwAYOZuBlYy7yGneDAmDsk
	NAE0YK2w5sVFf0/GxwoSRl9mLixZgRP7+6OKsXgcYBQdtGRmOlTDVW+6N0UsHBY=
X-Google-Smtp-Source: AGHT+IHN/1L/dUoeYcgUToN3r4u5BpldBQGtGvcGjc/Hw9fcK0iHSssfgI0Mi5Z6DtlW3jdu9v85TQ==
X-Received: by 2002:a05:600c:5618:b0:42c:cd88:d0f4 with SMTP id 5b1f17b1804b1-431a01782c6mr381936165e9.22.1730982902712;
        Thu, 07 Nov 2024 04:35:02 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970d10sm1603880f8f.20.2024.11.07.04.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:35:02 -0800 (PST)
Date: Thu, 7 Nov 2024 13:34:59 +0100
From: Petr Mladek <pmladek@suse.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Documentation/printf: struct resource add start
 == end special case
Message-ID: <Zyyz85FfUuLv_oo7@pathway.suse.cz>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
 <20241025-cxl-pra-v2-2-123a825daba2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-cxl-pra-v2-2-123a825daba2@intel.com>

On Fri 2024-10-25 19:46:54, Ira Weiny wrote:
> The code when printing a struct resource will check for start == end and
> only print the start value.
> 
> Document this special case.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks good.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

