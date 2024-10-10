Return-Path: <linux-kernel+bounces-358751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F9998323
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25021C21234
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD381BE241;
	Thu, 10 Oct 2024 10:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eu3jl8O/"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9B1B5ED4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554840; cv=none; b=Wt+1QYgvO7xPAJ6aCqFcR8JqxM2z8dS9nW3cl7jGvJadWypwxDC4iIvu5ddlOao2ebzYd+Hbn/WxPODBR8utnSwMHEV1O66eD+5pf8Oybt0d8nGU7yqwVDqQX16h1N5JSfK9v7POjqyAyLr+CCS3dEDpPxNZbi0350llkfyL7Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554840; c=relaxed/simple;
	bh=7y7cxuTJHYmgeNz1IQ/OyZKVAv8+2FQ7zyJgmIWILI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxoNj90gfRNrfpgIzlzsG5/tQNFWg/C2E0It6WGK2nJ1zyC9IUkABZ2Ggk7W6/0xupMl4v3I6wMumx3CbvWjozYFnYmUvnsF667zK0oih6JtQDGE6x5fOjPnQsCpoNvPokpCeAr0LtvRSk6C6SWQ5YW5er4T6zupKqXIl1fX4tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eu3jl8O/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso525986a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728554839; x=1729159639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOAjLNr3ULWfKUtF75MCpA435WSZvgqvWL/wFUG5XrY=;
        b=Eu3jl8O/YRXl5E4MzaNOVIJSoK4M160DFFljkdStnqCdTjuza99J6V+QYvVXl3qwXn
         j1eCPe+7F7qhnTgCOvuD1oUUl6y2KIevrPMJlQEVhRhugiUfQjIzhJ0yzRs9D6JBdEoK
         tOoncOSGh3w+iLXBX6mGQcSmzM9HtUBPrDp1HqnKSlDVO4lmcn2fW1UuO8HczqqRgGHr
         e5bGYVdvwF0ic6sO5vJIMFn91dGNGCwJON+n9k086vADgS/7kcsKjxGGag6Qm3qjWFn2
         Q84bCiQ0s8whURiaweuSXAJaI9p7DHxsOFN1xn9JNe01Kh/2PBmIeF0XElN3s+6Yyqsh
         A0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728554839; x=1729159639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOAjLNr3ULWfKUtF75MCpA435WSZvgqvWL/wFUG5XrY=;
        b=War8W9EX3073WGAD1FJ/ujfOxuJZ20URq1xXe6PO0RD/iBsR7kF/z6WIo99CzS+lrp
         tlZfRFibmA18f3L6s5WtM5QG4pXuQXYjdX2uo2O5J1UaWhV2GFxwlpNkWu8ukms6AkH1
         aaPWhNlDH3X1mj58C2fVqKCmNTf1OUENmgAjpa82T+iacq5RYARogrbaPK1XJKh54N03
         NXaxmgFYA+uDItGPXZqSCLSgB4Jizoq9N+r3ZFVfZkzdO0rRG2BZdrNffY0A5nvr3Fo/
         IEjw+tmAJpWZVWNuUszIGHLHAiBdtzsIFIaTuP/f5b9PKFMai1RtxhB6+hgG8V+A8Kau
         LYxg==
X-Forwarded-Encrypted: i=1; AJvYcCV57BQ+30YOIlIPZ5gtiRRhhUmQi1jFj84deC2eopMDA8+j7r/w1bQtpRFHAkTRGRZNz1aR2CTA9sqUymE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXpcI4JKxazTnxA8C9LluxfwepTxGhPVXCbvUbL7px2UWh0Xc
	YS0ycAvqwSZPN3wflzi6QxHclC23Tzoh4kzpKf/8v8mo5Byf6DSobfyy3qRBn7M=
X-Google-Smtp-Source: AGHT+IFMWfrQsqybIcI0tSDYWOJNHBSlL3M8OpXyx3WEtEF6xXw3hPxQDnu93oiX6qYnV5fBYaBaHQ==
X-Received: by 2002:a17:902:d50d:b0:20c:8cf9:6134 with SMTP id d9443c01a7336-20c8cf961f8mr21657395ad.4.1728554838827;
        Thu, 10 Oct 2024 03:07:18 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e7744sm6783645ad.135.2024.10.10.03.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:07:18 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:37:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
	ray.huang@amd.com, rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: Add a callback to update the min_freq_req
 from drivers
Message-ID: <20241010100716.omywobjusxzrknew@vireshk-i7>
References: <20241003083952.3186-1-Dhananjay.Ugwekar@amd.com>
 <20241003083952.3186-2-Dhananjay.Ugwekar@amd.com>
 <20241010073541.nxsftik6g3tche7n@vireshk-i7>
 <1a38d478-6e34-4041-9169-ba34996d573c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a38d478-6e34-4041-9169-ba34996d573c@amd.com>

On 10-10-24, 15:24, Dhananjay Ugwekar wrote:
> Sure, that also works for us, if it is okay with you and Rafael, I can add the 
> u64 field in policy struct.

Let Rafael continue the discussion on the whole idea first, if we are aligned,
then you can make this change.

-- 
viresh

