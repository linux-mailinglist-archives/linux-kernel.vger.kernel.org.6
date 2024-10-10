Return-Path: <linux-kernel+bounces-358363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E735C997DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C0A283550
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3B1AF4E9;
	Thu, 10 Oct 2024 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mR6Lwqxu"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FDA1A304A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543265; cv=none; b=H9G1MuNQ1vjcPwJDiuklqCQcgpXmcghTQq328DPpg+BoIDH0ASruPMCyCV2gDYGIxCIz5fTELchLDHd54BVCfBadltw9o4n/HzjrmNLAFHi5FBcf40aY/6BYzKum8Xl6JF3te+2o38QmybeIIV8NMQvTzQHAtrkcMP6Yl/nyt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543265; c=relaxed/simple;
	bh=0ms1chKdEWxTq/IFCWt6Vhx8aIoVGjaB7A8yNhqcslg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpBNbxfPxuRF6hM4fXxWvgJOk/4N91gJzJIz5enpyRlupqSmSN/IACr3GIfdnrLMhTSGzW/gZtHRvDUtv6XluBvH327fCFqb+XPBf6GKlf86juubI0fBIfmlekOkv8Bxx+HZNdltey3v5bcNhgZO00wdFxwWY/RmRGZQ3AcU0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mR6Lwqxu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so4518055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728543261; x=1729148061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4m5R0JtPpfaojQZL3OlH+ec0WCCRm/TpTjzYrE2iFl4=;
        b=mR6Lwqxu+ZJdXt40L763SSOqyzsfdRXHR1yYcnv8/87p7EW7yoxV1OQBjBOMfVgZYE
         fqwmJNHK+UW1dl6S8eBLXtXGRHqBXtFcLXqd00y2zU2To0vgmVdyaKCePo9NlyEk39py
         xkCtB2Efuo+uwdpNU666DUoiu2IlorucMQ2mFjUJrQS72z5eTlNgrR5EEZiO+HrOgPh6
         VjtiMyrctU5efucXWll38HH9MOwrrKeBxRh75ZWtOhCsVYZhEBsAvQK+U8m3w6PRzVOI
         F/8HhAv5O1A5DKEyWHRSPuZQDEMRtIQyXBTmUvYbfyKuwgKPpoEaeaNrB0Myv3HyS3Td
         kYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728543261; x=1729148061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4m5R0JtPpfaojQZL3OlH+ec0WCCRm/TpTjzYrE2iFl4=;
        b=mPREY38wsEyZpZF7CkkcXao5qABpn4y7iupGEiSW0F0EZ5him1WzviAVzSSzgWTMXk
         eDoCgh8Drg8IKIqTCAg3qqK2oMDtF0EM5j9ct59RL7cVu3g4bJKT9Sx5LCV6W0Ydq6hh
         a3vWJfdYT4t1NswAr04MZKACjIGOLQ7BqylD+hClekBilI67PIFzpsxiPCIJs3m0ANTw
         vVWjGNW02FpTKOKbEkrh+7PKuIvRGgcrBczYhPAflxC6Hqinl1+NuWuidx0gYOYN/JEK
         FZSlqvBaDwFQZbkTJ/qtkK/q1qEoNaU4W8UlwTn3i1L9RpSKxF4Gw9mHobA+9C/aspdx
         5Amg==
X-Forwarded-Encrypted: i=1; AJvYcCXKD9wzGbgzKs/rQQmKfqxlGY24NeZJ1MTQJWf6vw5U2Aiiw7hQK5Hy7FgJNXiTKEvh7d5TvLmtapJ4UII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGG1x33HHfe7pY6/eosTKFpvWz02V9+z/aSbzUKfTzS2CGzeH
	1w8K/I0r/W8yYo8042ZZ+c33OdcsDcoyX5lcKsbayIRM6DzB5JLmicvJiLLJKFg=
X-Google-Smtp-Source: AGHT+IHT9IlJQF0bRhontqJBDQWsf+MVObv5bUTBsaOIzFmxsVdQfGzrmTIzPD0VfNHeePPUMsSx3Q==
X-Received: by 2002:a05:600c:358d:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-430ccf03b0amr37644685e9.4.1728543261409;
        Wed, 09 Oct 2024 23:54:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9190dfsm640951f8f.116.2024.10.09.23.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 23:54:20 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:54:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, skhan@linuxfoundation.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] drm/xe/guc: Fix dereference before NULL check
Message-ID: <1a5407c4-3b0f-48a1-940a-cc6b3ff3fb12@stanley.mountain>
References: <20241010064636.3970-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010064636.3970-1-everestkc@everestkc.com.np>

On Thu, Oct 10, 2024 at 12:46:34AM -0600, Everest K.C. wrote:
> The pointer list->list is dereferenced before the NULL check.
> Fix this by moving the NULL check outside the for loop, so that
> the check is performed before the dereferencing.
> The list->list pointer cannot be NULL so this has no effect on runtime.
> It's just a correctness issue.
> 
> This issue was reported by Coverity Scan.
> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600335
> 
> Fixes: a18c696fa5cb ("drm/xe/guc: Fix dereference before Null check")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---

Perfect!  Thanks.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


