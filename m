Return-Path: <linux-kernel+bounces-264088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ABB93DEE9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868351C21519
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A2D57CB1;
	Sat, 27 Jul 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwzcvJgh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4A5589B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722077745; cv=none; b=Zyvxe3hHXAThXDOtBOyW18x8vA78TI0gO+EVrYNxx24RJLdJZygMIb9p/IOOipchEpWTlgXFU9o3gmFi/dZuB7cssvC3Bub0xx0KiX+MTOCrBApGC4iA6cIPHIWUJj/1SJ79TfqdzzLxNoLfOCe+mKNg881VBib45GBx6T8BzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722077745; c=relaxed/simple;
	bh=68s/AGh0KdHaOGVbq3ybeiL3/h7OccMgD2M7Qinek94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuRBCISJHgr/JqIy8DksuPloWHweOsfjOKNwsUAEq6T9ZmUeoCPX1ljRv9m6m8HsMsY2ZKC9Se9NR3zgn0eq8dQ7W+6oF5FjaFitG/DMitemij+EgRhKINhxY5PfmIRd1jqyZ4DPS1ECSj+ofnHDG4WD7w4B9XmC8Jq8o9kYL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VwzcvJgh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so3072417e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722077742; x=1722682542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eSQLqxhvdwaXYSfWwT/zXs0MzmxstO7ywTlJURA+QUQ=;
        b=VwzcvJghIPwvE0gB7qZ8B/pN2jJyT1ouDFx9RBLvnzNWPMJMcVzed/8rl9bTsXpmv9
         NRPdRVp6q4lyzZCWQ0nkWvmRf47Uoqx0qVFcGoCcZw3pqvHCvhZsycc4g0Hi8eoFKQLz
         VO3VM1aOdV+xrBtDRM5KkLtQQC5B6qb/O4XuDRf0k606K1KAxqQcJ9ZP1cdA6RmXXoL5
         KyJ2jC6g625GULPyHxiZU1ZtHIS1QHE8TlT5UhUOebtKWJBUgejWR60znEMV65hBZd0y
         52xGCBJvgZ5peI0BszR+OUfzUZzSBJvOfN4X07n60UcFH1k42UtZGj5NrCY+YciMpM1w
         6LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722077742; x=1722682542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSQLqxhvdwaXYSfWwT/zXs0MzmxstO7ywTlJURA+QUQ=;
        b=tdkzthGigZ/SLV+736BpL4hflXYsjjI/U3dxNfdlPTmAZoo3Y3ZZ/MEYj/86/iC5gO
         /zrZuW7sBOMsM/EqT6YFnAma43hHhh6u2XHSs79u7pkYOhzVMF39uSPSVHFduFhI+FT1
         IbKpwaMgHoRDIlyaIbFsXCLM4a1lRITcoj9wX1P+1+1a3DVuzkBoZgjeDL0BiN33+ipM
         q4XmQ/8OeD3lMFZ53/W8DCrLV+leIppmYSVdzkJkJ/JnnVD6tZMDlm/FS2diJGOGpVJi
         K2d9Jo1np6O4gWkED0pM5rwJjFz4DJ8EZ9Rw5Vh9HhgewLTe3+lAvhA0/xz2/7NKckEV
         NAmw==
X-Forwarded-Encrypted: i=1; AJvYcCW3UruApOmQEAa9uSe6Mlt9VNQjHqAU8hQuROnu3NyfJrLM/k/1exWNbm6HLfoCUZHgDOXamZiS1L2xXYmYU5uHVSOtRYXy+35+GEMV
X-Gm-Message-State: AOJu0YyuZO4bkgGqv8/5MRx0px7EtswWCQjGAoH8hRmBeXkku7EuE6OH
	D+sv+0jncqPpgXSkdrrztNUbGvHhzSL4IleWojqXLMTFzjijO5XL2RAKIj/PoQY=
X-Google-Smtp-Source: AGHT+IG/g89VE0vaiUQwCJYmJWWSqhFEML1N3eYG2UploJkfiYPufIYQVcfURtGME0TkGEoamzZuAg==
X-Received: by 2002:a05:6512:2513:b0:52c:b479:902d with SMTP id 2adb3069b0e04-5309b259c26mr1773343e87.4.1722077742260;
        Sat, 27 Jul 2024 03:55:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c081ddsm736621e87.132.2024.07.27.03.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 03:55:41 -0700 (PDT)
Date: Sat, 27 Jul 2024 13:55:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Mohammad Rafi Shaik <quic_mohs@quicinc.com>, Prasad Kumpatla <quic_pkumpatl@quicinc.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] ASoC: codecs: wcd93xx/wsa88xx: Correct Soundwire
 ports mask
Message-ID: <kggm3zlkevqw3lelxukz5lyfch3vd4uxta3gi7kcidacpo7uz2@hlqq73saz27c>
References: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-asoc-wcd-wsa-swr-ports-genmask-v1-0-d4d7a8b56f05@linaro.org>

On Fri, Jul 26, 2024 at 04:10:40PM GMT, Krzysztof Kozlowski wrote:
> Hi,
> 
> Incorrect mask of Soundwire ports - one bit too long/big - was passed.
> 
> Theoretically, too wide mask could cause an out of bounds read in
> sdw_get_slave_dpn_prop() in stream.c, however only in the case of buggy
> driver, e.g. adding incorrect number of ports via
> sdw_stream_add_slave().

Well, granted that sdw_stream_add_slave() crashes on RB3, we know that
the driver is buggy.

> Not adding Cc-stable because I don't think the issue can lead to real
> out-of-bounds read.

-- 
With best wishes
Dmitry

