Return-Path: <linux-kernel+bounces-312558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1B96982C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAAB1C2310E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CE81C7690;
	Tue,  3 Sep 2024 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RadgnbUx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C331C767C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354146; cv=none; b=SN08FODIPN6RpCT1bzBmuFSSs+wbjAMOqsDnDFprDPkiNS7PEhq+F5e2jkybLomd7XmRgG8x+NrzvhcheR6BcWG4Svv71FH1NAl0h46njwzJKJCNcXw0L7memSWQQS+cWmYrBmgOl1tD9VMbEAmKrWQ7B9H4EQWxiY2Wtv8OvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354146; c=relaxed/simple;
	bh=IQb53KgzsuBBGNZqztOohZUksn7yecYeum0vMBoGK3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L99Y6aJc2SACIVzS0Gq/AsFfvl66n+aPoZ6o5AFzh7G2DFxlWmaw93jzj45jFM3KE6Fw4GCXblGhOu4wh+48VdeWkYGYQSqtZkjVykNRjukf9jJ5pa8YpmOoZDeevWW0PEe0xfQYrF369KKnfuJIkzx1DLcownXKX6kgPRdXC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RadgnbUx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71431524f33so4052546b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725354144; x=1725958944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28J7btq0UkSAA2HYJWvtZYvalFZ69/IJwEZuaIkLzn8=;
        b=RadgnbUxZg+w42X/5CP79U0mAlJ2wNshhU2Tp7MbCZJtytE7VsZG0WVBDapN8KRbp4
         +nEESZJvJXp9Jb0bLtkDS1g60jOfNT76KLF3SL4k76d10xP+ISLxVaZTxbTN3wVNjwSS
         Q/0GRctLZXwsbE0YyqK/CrJPD3VA/i/cfoSthO3PKyQn9nuufpK0ngQBYzei0lC7+iTx
         2cJA5i4kLE3VYAYl6UZzBELY8OmtTvBIMSYUYSmmJTZ+T5aJcmkOfTzrwOgVA0DIdPPw
         b/ogdC/i0N3PmtHP6DmR1s6jVkEGfoOLpoKkK5kVMRuQD/PVMaQmWfa5FmFNHMnIHvcF
         uwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725354144; x=1725958944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28J7btq0UkSAA2HYJWvtZYvalFZ69/IJwEZuaIkLzn8=;
        b=EG47UTRGLrZJzElkmROkJDKYlM+P3GxzxYt7Subiy+fsVNG24QG6COMhwT1l4PL4XM
         s3iNqUIrD4HcwY1WneMYXSb7hoqTY21s3iNWlfbq7Evy20VPAO8zOIQCavyXnksbdQqw
         DqK+6hHG7W5jkjXSqn9VybtdA+UEHdSzYs62170VFaGYpb6GrKJHb/oR5ZsN8H578vHw
         FpsfrhT21fYTBr2EzOFIzY1XlvQyr8He+DbVEGwJKzmBeNEq2pFZGSTbjn9B2p1s9+o9
         HZqKxL9vSRlGYTe40nU8guJgyrTgvAQxzl6YMGfxDUhL6Gkf4YArS7rM8nMeEdiWfCBX
         KgPw==
X-Forwarded-Encrypted: i=1; AJvYcCXBWfuSo1heXAY/8iPGksAeNX7JBd69Jv3OsCEG+zzAlECNsn6CVhmwpQ/Eh5u6iMgRZlmO9ynS56BrCwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0MC+XGH9f8djB4W9GA2DGBD7t8I4pzYMD+UfVdnOVm8JdOQL
	VA9KO0I7H/CVnyRnyQVb+/1ACZX/CxZNbzjTiw6VsW/eef9xJXq7dBTGhPsBdmU=
X-Google-Smtp-Source: AGHT+IHEB6NjKvozQK25VQbnAiQGuXSrow5+OHBblwLeDF2SxTC7aWBa3T+1AoJ1phXALsBFx5kKIg==
X-Received: by 2002:a05:6a21:2d8d:b0:1c6:ac08:8ee0 with SMTP id adf61e73a8af0-1cecf4dd69cmr13350841637.19.1725354144618;
        Tue, 03 Sep 2024 02:02:24 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77554fsm8845343a12.33.2024.09.03.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:02:24 -0700 (PDT)
Date: Tue, 3 Sep 2024 14:32:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nishanth Menon <nm@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bb@ti.com, d-gole@ti.com
Subject: Re: [PATCH] cpufreq: ti-cpufreq: Introduce quirks to handle syscon
 fails appropriately
Message-ID: <20240903090222.y4cnnt2o6t5tr3n5@vireshk-i7>
References: <20240828131915.3198081-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828131915.3198081-1-nm@ti.com>

On 28-08-24, 08:19, Nishanth Menon wrote:
> Commit b4bc9f9e27ed ("cpufreq: ti-cpufreq: add support for omap34xx
> and omap36xx") introduced special handling for OMAP3 class devices
> where syscon node may not be present. However, this also creates a bug
> where the syscon node is present, however the offset used to read
> is beyond the syscon defined range.
> 
> Fix this by providing a quirk option that is populated when such
> special handling is required. This allows proper failure for all other
> platforms when the syscon node and efuse offsets are mismatched.
> 
> Fixes: b4bc9f9e27ed ("cpufreq: ti-cpufreq: add support for omap34xx and omap36xx")
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 

Applied. Thanks.

-- 
viresh

