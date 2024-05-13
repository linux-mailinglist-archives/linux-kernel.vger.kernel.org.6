Return-Path: <linux-kernel+bounces-178042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EFC8C47CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B1B1C22EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9D78285;
	Mon, 13 May 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PamTSi9I"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298DD77106
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629630; cv=none; b=bssW47vdnN4KThX2gxRY0UFN2ArYPgaKTeHSNgqcnxjDI5k19BR3zLT1a2nehWRbMRIPXkBR7ZJ8yqZddFV8P5w0TKGyKM3X+UcaAeEwn2yZFi/LVmqY3jgpTuqXUCPOnpY0MUkhuK2kVIuz9x0JjRx5Rj8REaFyPgaTg/zuCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629630; c=relaxed/simple;
	bh=16a3Epaq7g7pf8NaFIU+bskv2ICswFxu2+yqI8JIU9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1Js0gQLTd3loxhUqu4hosxM+Vg+2CxjS20yNXZ2VAfbJciw20auU0Dcd+RbplEt4UhDpImEJc6JaN19SoBjmz5tV/XmOFMP0cgjCG/TXrBQz4SFBccI9q9SPxuKDbK4L8Gj9K5m+aJfO10B6iP7WujBBt3nFD0BpSZOpRw5DI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PamTSi9I; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-61aef9901deso3444807a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715629628; x=1716234428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfFfYpzZ9TkXj0n+fN7saznALYpPsNADwmH6bqocYac=;
        b=PamTSi9IUV3k9KyOzKbYhCQHoF3hzhyZAv9trDSgFgdBiht+S0densC7xGT4AHuJ9U
         UhubWxNZZPXKJEXOQ/LO46BAwMs/FAF8Voa2GVFfM6ZUhTJSyvlaa5qe0XNNSe42pmJS
         LcYCdEdfT7UglIT9mKVo7fDpL2wTDco/9PkBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629628; x=1716234428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfFfYpzZ9TkXj0n+fN7saznALYpPsNADwmH6bqocYac=;
        b=QSFwSVFd6e+fgv4H0SoWccwUSy27/VnY4AViNsrzd0PoPEtU5zf/3ZR0lvCuhp72iV
         dICGEIVcobikGCXlYh4lB1HLdkRzwRMYnXtpd7i8IpJ0q3zFsxczKU0G8BGuJ8YnF8dS
         4dhNdMDplvqjn7+C3cTRFje3yGoOUiCYJzVkJL88/LuwNBmPBMEY5lRM1sJl8OWn1PYg
         bYjM86zYFMAE3QzsX4WGZIU0mOJhDDZOyBrgM6zAvlN6vsm2CFKGhp9/nmWdFJ/kPtB7
         O+K1DBtX1qQjlEVrGCe4uQoT35X8pLlM0FNuOpMRsVF8qtQYcAg+KRE7Y81NB43PaRUV
         V8kw==
X-Forwarded-Encrypted: i=1; AJvYcCWOryewBIqcVC3ixPHCbTiMk7PWJmQaPET7+7gG1u5PpFqyyN6F1oOAwzVmv0sgr9P0h6x2elwLAvpQojNkxWYyJod8ZTdJWPCCF1dT
X-Gm-Message-State: AOJu0YyXsDQHNSI89drtlXFA28RDtFV1j7NVKoVaqs4lQpvyOoRUhc/a
	TUIPJLU0n2S7jpb5RZPIBnO5TRZmk31kxQ6B0isCe1NQvibND+i6EqRsAFxDsg==
X-Google-Smtp-Source: AGHT+IHCYwJQrbP4JQr6MKsvJGpWLKJOfs8nmRXdxibnc6JRMVCbqPxPTY++ociMncHgytrf0PoIIw==
X-Received: by 2002:a05:6a20:7f81:b0:1a7:a3ee:5e4a with SMTP id adf61e73a8af0-1afde0e24e4mr11181425637.33.1715629628568;
        Mon, 13 May 2024 12:47:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0d77sm7765927b3a.106.2024.05.13.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:47:08 -0700 (PDT)
Date: Mon, 13 May 2024 12:47:07 -0700
From: Kees Cook <keescook@chromium.org>
To: j.granados@samsung.com
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: constify ctl_table arguments of utility function
Message-ID: <202405131246.C27D85E1@keescook>
References: <20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com>

On Mon, May 13, 2024 at 11:25:18AM +0200, Joel Granados via B4 Relay wrote:
> From: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> In a future commit the proc_handlers themselves will change to
> "const struct ctl_table". As a preparation for that adapt the internal
> helper.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Yup, looks good. At what point is this safe to apply to Linus's tree?
i.e. what prerequisite patches need to land before this?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

