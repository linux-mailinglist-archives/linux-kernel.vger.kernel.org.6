Return-Path: <linux-kernel+bounces-425364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E039DC10B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CD516068A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD0143C40;
	Fri, 29 Nov 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snOZ+VX8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63860147C91
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871102; cv=none; b=hb3rN+Rhg/ao8G30y5JypNEFCQ/rp+23jzwa3KF+48HBHbf2FXrbzJjiGPUwprPU54WzqR5Pjk+G2wkvu8nYcody8EqIAueJ1mLyzz4FMYM51slSTP4HvcP12vJ6ZvG0IV2dbqTmUhTC0dCjfXA3GphvgyKn+c4Jfl9sbM9Rr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871102; c=relaxed/simple;
	bh=vO9ByBT/SONTBhVHpVkxBH/3ubi5rKJXvHi2ak4c5rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr8YYrJr3HV66q3G0kTINgYRWDqi8Dg9ERw2cd7Gy8deeXejqbcr9+ibIUC1U6qWq5Md95hrmJGaRuh8yjj7UM6tGyQ1O6NgLOg+yDT23i4k0C9qrrI784R8B2N2pcXcczMMnmzPBJCQZB2HWobhtA9fi931kKB9cGXNwNYDd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snOZ+VX8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-212a3067b11so15954795ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732871100; x=1733475900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NmzgYiTHuT38Cq1Mm5SUp1x96rSOx0XuBvQMGFzhB/s=;
        b=snOZ+VX8GgUZEPuf/7YeaZGbp3HR1aCyAOswJ/zlFoJgZsvcsBFPhJOiJcf7Nb7J31
         GuBYXJCQRUu31MTYIuxj9nsEi9EbAtysPGaZTKpZMT3Uer/G0tOB/HqV7FjxcnJLI6SA
         KHhRGHpFcrZc+30TI4RWLJ5WhGtigHqHdY/HPSyzpdiq+LM8FGWWuYn4yomdRfpc8v4D
         gz8vF+OUHc8fliXpkjM8ENc3yWKofqOqjS3qYbVcSxjqEb50WUaZMNu1LLtOOeRonX4s
         0qGUomDOlTjjkf/Y1scXVJEi7ZJrvsbb7h4XQl4t5m2dVgHlMKuO7QLYSnZTrrJAQDj9
         37zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871100; x=1733475900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmzgYiTHuT38Cq1Mm5SUp1x96rSOx0XuBvQMGFzhB/s=;
        b=Ui7S1W+q0Llvpig2BkK3ioO/Ct8unLPiEhkzIGZH8DzIyaENg4xmIR4fwTJj7ej/7Q
         WmIJQd3PI2pX7BL/emE2hsiaNULWbIkYJIZODjZB1R/yRNzAoJsv0w9rBZs4wm9XtZK6
         mOpNO4Ewiega902kx1erM59Wy4iQ13sx/0Zp/DJQBLRCQ5k0pKJGJjqVuUT4Q2kM0vCP
         y4B2P71O2WS3Olv1jN35yQCGnpeZVob8eTFEh9XORLEuTk5H9+oSmyOlYXuA0wcelY5c
         xE2uZ1P/dHMWaoJIBTjELdnqhC9SVussPfZr5Fn/237EXoS8Hv5DwmFU/9nZ0XOPEw12
         LVag==
X-Forwarded-Encrypted: i=1; AJvYcCXk+aP07JL2X5a+P6EEdW1YooNAEtXQc72ybiuWbAwIBeUQNtIGbVMMnmlh8dJr52Js+vECBc1LyX7pMPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9nQ2rQMOiAO1AOruX/ducP27ooNJpGehPhgw/PnQdVknpDhh
	wUtuiEnslv41c/LFsKbnKOvtwFDne0jDUhZ7kFKqfVZUddUrmAHwE95lDIS7Zgo=
X-Gm-Gg: ASbGncv70MrdE4cY30N8+ZtD4pkq1fDqjYJqENN2TSqSzFww2wt+k0OiUxPbntJ0eKx
	GvzlK/qgq8A9fPMZiqCm0TGF0sQWEPw/UfIm25ZSP292+UzG2x5QwlLPSjnLccWCL2D+msokI36
	Niae2XVj4RZXMkO4PYIN3CAjcTPw021X7jRLHXCSSQ09GiBijgaBAM78qRYMRHMVXjbBbODgLJA
	A5ty9bysvX1LASCqsvuP7KmAFbywz0Ocxec49k6Nd4J7wwp/OK8
X-Google-Smtp-Source: AGHT+IGg1qw57WoQi6dR9QPFZwX2ihLooOHM8ZDLeNgvNGkx/nUn4iMKoXAEtGbpgf57okVCQmDWxA==
X-Received: by 2002:a17:902:b716:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21501d6133cmr117311875ad.46.1732871100576;
        Fri, 29 Nov 2024 01:05:00 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21544fd9b4dsm6314165ad.223.2024.11.29.01.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:04:59 -0800 (PST)
Date: Fri, 29 Nov 2024 14:34:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: add index check to assert to avoid buffer
 overflow in _read_freq()
Message-ID: <20241129090457.4ibsyulffydnc3ns@vireshk-i7>
References: <20241128-topic-opp-fix-assert-index-check-v1-0-cb8bd4c0370e@linaro.org>
 <20241128-topic-opp-fix-assert-index-check-v1-1-cb8bd4c0370e@linaro.org>
 <20241129084052.wfi7nakgcnt3zkur@vireshk-i7>
 <c6b5b6f7-ab55-4d46-888e-f9e00b269c9c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b5b6f7-ab55-4d46-888e-f9e00b269c9c@linaro.org>

On 29-11-24, 09:53, Neil Armstrong wrote:
> Hi,
> 
> On 29/11/2024 09:40, Viresh Kumar wrote:
> > On 28-11-24, 11:07, Neil Armstrong wrote:
> > > Pass the freq index to the assert function to make sure
> > > we do not read a freq out of the opp->rates[] table.
> > > 
> > > Without that the index value is never checked when called from
> > > dev_pm_opp_find_freq_exact_indexed() or
> > > dev_pm_opp_find_freq_ceil/floor_indexed().
> > 
> > These APIs aren't supported for cases where we have more than one clks
> > available and hence assert for single clk.
> > 
> 
> I don't understand, the _indexed functions clearly have an index parameter
> which is documented as "Clock index"

Ahh, I missed that there are few _indexed() helpers as well which you are
correctly modifying.

> I agree we could leave the other ones with assert_single_clk, but we would
> need to duplicate it to have one with the index parameter, so it felt simpler
> to use assert_clk_index everywhere but indeed we do not exclude them for
> when there's multiple clock...

What prevents a user to call dev_pm_opp_find_freq_exact() for a multi-clk setup
after your patch ? As we use Index = 0 here in the code.

That's why I would prefer the earlier assert for all these, except the indexed
ones.

-- 
viresh

