Return-Path: <linux-kernel+bounces-358325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62BB997D31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F1B1C22AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D05D1A08B8;
	Thu, 10 Oct 2024 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUD3kwcV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5033CD2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541704; cv=none; b=pGn2QeZjuj/hg635np1dILivTvKoexARQKftqZBX31PiELr06ki/vGKPujoFVap43UF545A0KmHt0Y09iTioqlyh5YZsGnLa7XmVjwwN5n8mpq/qOdkdiIa3GHE+6CkxkNZ+RHjCIiYxz378dKmIkXU572lvdoS9lk4KGJvIvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541704; c=relaxed/simple;
	bh=TX/KMkh7o4UkhoOhtTta+lrKV8s0uQ0QAOmvx3zs5sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deH7DCH/ob5RxVsV2c6mAgN4jvR+sal/5A+x2yZnG0EJT1rA4Bv5brRWbZ721qE9tkZFP8t0UmM2ZnfExGNkZu1bJaWDIYV4JROrvqHdyaVpsyQp9sdjFYJdzPKpEtGbSunSYdGk8bfTSUlaq9/qdGV3p63rX1FQLDZOanjDAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HUD3kwcV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43118c9a955so1637975e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 23:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728541701; x=1729146501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9dxwcXVFs3vnkTzThkLKa7FVga4fnERpw3hSn0gAas=;
        b=HUD3kwcVDvjvfS8BlyO1eum7N7rTX3H8zMZSeqzbMVkM420VG/BAy1LMhKkKthgZQw
         czgDb2x+RvPmcXNGLlljd2ZiVtkOhM7JLKm3/8t5OahSh0Vg5X3oOQND7UDzlXGyvO44
         UysW0JHeE/lQkU7tJ6e9HDY8lvQFiXHuKuwhK89vldFuFh0COuqqz+U7+gS8DNnuqKG6
         MUg+igBtj5giWdsKnBF7RbVk+8ma6jYYuLZZs73VIAH8H4i2SGsAScW717STorWYSsgY
         WUSidnNlZICTbq9miYEGLsjGSQv8ls4TsxvPvZEWcSbuHN4JVEtEVHKi8UIzCzHbYrS3
         OY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728541701; x=1729146501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9dxwcXVFs3vnkTzThkLKa7FVga4fnERpw3hSn0gAas=;
        b=bDS9Yvqd+0tiHB2d9uUnbEdf1jwdUbE0OTsQhWL8A0P3SpNBAXY8fKrKuE4u53I4lg
         KtUsnXvA3/JojPysSW4FGdai6sKZau6J7KlmQFRcb387gkGE+k+yzXUXN7ARkJ1wxmtQ
         2KnE0YHDLGES4Ri68f5UgXTdIPzhM9RympTlY9mt9ZmOtcHFIuqdRFBmIcVxtF+lVMSE
         WzBuyklYNqRfKyoUqmv/Rze5AFj0Ev9i3q/4JMI3OinKRuMbT0vMYUlL+PqxK7WJrNVa
         6vdAgrAImRJfvQ7BTySlSFDjX20rCnQuqgXbcuJ3o7DJUzTXpgVdcSUwOya2CJ/cKR6g
         eJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCUU26A7VUiS4uzlYSd90CfZlz63c8+cH1cUts8YCiDyPAayZ8sSAjiHVJsMq62Phdoq5nT6k9wY20Lnydk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25CaX5avngcVZHucwLPbbMESw9NSfSOR9iN3ND2bsOl+4gppa
	gTzn1xHCE+A0Tvkp2UDtnrGq0Is2Yhsp4oQ5So7tibFjghINy0mVa9vPWHsw+9A=
X-Google-Smtp-Source: AGHT+IHC0o9tqFtiDG4GnzxZXvNF3ZFqzwHj0uJ1SCAz4Q/E8H+XfyWulVcSrjl1hk3YLD9AEqhUwA==
X-Received: by 2002:a05:600c:3b9f:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-430ccf0928fmr41157205e9.8.1728541701026;
        Wed, 09 Oct 2024 23:28:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7ca3sm6172505e9.2.2024.10.09.23.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 23:28:20 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:28:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, skhan@linuxfoundation.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/xe/guc: Fix dereference before Null check
Message-ID: <c2a9c4ad-ce50-42ab-8dac-65914e188cac@stanley.mountain>
References: <20241009213922.37962-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009213922.37962-1-everestkc@everestkc.com.np>

On Wed, Oct 09, 2024 at 03:39:20PM -0600, Everest K.C. wrote:
> The pointer list->list is derefrenced before the Null check.
> Fix this by moving the Null check outside the for loop, so that
> the check is performed before the derefrencing.
> 

Please, mention the effect on runtime if it's not totally obvious.  In this case,
someone reading the commit message would think that it leads to a NULL
dereference but actually the pointer can't be NULL as I explained so there is
no effect on run time.  Say something like:
"The list->list pointer cannot be NULL so this has no effect on runtime.  It's
just a correctness issue."

Change Null to NULL so people don't think it's Java.  ;)  Also dereferencing
has a typo.  s/derefrencing/dereferencing/.


> This issue was reported by Coverity Scan.
> https://scan7.scan.coverity.com/#/project-view/51525/11354
> ?selectedIssue=1600335

Don't line break URLs like this.  Just go over the 72-74 character limit.

> 
> Fixes: a18c696fa5cb ("drm/xe/guc: Fix dereference before Null check")
> 

Remove the blank line after Fixes.

> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---

Otherwise, it looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


