Return-Path: <linux-kernel+bounces-553558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EA9A58B92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F113A1697FB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 05:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291891C54A2;
	Mon, 10 Mar 2025 05:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XL6Mn0ad"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E723A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583492; cv=none; b=bMrFisCRVV2iRaSgFV5j+kb9gezbkXE2Nac55eZ79sk6zSLUJFjwfO9TRlz6atGLB22hMaH13HSmugyPu7Ytidtndh3nLxp/WQOwEKTyLA/n0+9NgOsBGDNzB90umkgmjFL5DyS2Rz+ooD4rJVZS+jSUtiZ3daQQo+ZWcXDtYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583492; c=relaxed/simple;
	bh=4979GeQXZM3VH30x/v2nzcE8JX2PgGYEku8PS5snLjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJfeT2DQdqU2SFE3UFdsnkHaeGm5zmGGOqmmPBkTUKelpA3UUGT3h8HRrlLa7hLCwc57n8Fm6c9jhHYLKOr1UCNMOUZkuxfQKZq8/J9OkJDqZip1bwjS4Ni6ioqQHyYH91HvQL8lSYo6zeLBFdT5QpMGI6vS8kwKyOOrQjiYNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XL6Mn0ad; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22349bb8605so66750345ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 22:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741583489; x=1742188289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wyoLL4OIFrG4gMeDSCBEzBNAUYvjMu9wkevzhYC73Dk=;
        b=XL6Mn0adHN6XJDqne0TKNxxXK6EzFxNRlsWj1Tukc+bLSSzUfopP2qYaPIkY+f4a8D
         E2uA4qB/V83LT34UbJxhiWc9r7VMZMXwbycj+sKY2ax/mT3HYLUR2bmeMxQTI79pmcpy
         BRl+VVSlGdR4RE6QZM7z9pO4SvR8Q+1ycbxmUJx+OaTJ5o9GcPrnzcITmKz1lTqEAa76
         cBEYoYXnWYqenbzh6qZq12XPdcvb+OlI/mlVQB/JUhSJtdmUjM3Ag6AjkwZIDW5e2deu
         +ZqEsPoK/4WeiDiLDgrlVEzxILd1qnqdAFHWeVAcPauUBR2cAkgNDWfvRpVOsRG0V/oH
         Cbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741583489; x=1742188289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyoLL4OIFrG4gMeDSCBEzBNAUYvjMu9wkevzhYC73Dk=;
        b=hqJGsUfVCjPk+B9KivyWDhtLaSETI1dmH+CICsiqpP2m6jR6jAADQaLZ1cIkUbGKgS
         ZA+bjCwWvvRyeQxiGhnOxsvw9+GE4gJa6+Wep/QiZuoDEdmRxt2S+hoXoH88ALcxLT94
         pB5pBfLnzrCl00C2z9MCOzN31g2VPAPGh+kHZV6eEJlE6NL05NaiwN4UpbMHoWJsuBAB
         w2i5joLXwSXVY9a+NR68fybo8OvoMQiNV6zVBjZPwKCW0wzhAxAOkLnCZMmueeSa/w2+
         4gmtx3VdJPUVM90jjixUADtwGnLnqm+tDSK0G8DXzCb86ahQFnINd2JgWeBWVGCfxMiS
         NZrA==
X-Forwarded-Encrypted: i=1; AJvYcCVfWdVOnsx1liO0eiZwZET6lOeLHCTJsw+Ewd0ve5TZkTH5/8ueIPCHA4Z117MD0ICbUh6FMcARifs3FSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRl6ndFbzoDo5bo8PXq0LNq8NuE5Yb6wf/cFuQa7wVKvfKzRkC
	BVHIT+UmvgMLvGCt/PDih3HiSW4CM5FgStJJ/OeSvbm903Gppn7yJMd256VwqOY=
X-Gm-Gg: ASbGncviCfZLYYtfRT4zD2OK0NVcJSWP7YgJB+gW6YnHCYXC0qaUatbjE8XcT2Bs72g
	cUsGpiMK0/lgpitvHVBNI7iHnndz94V66CxnAxFzGBFvwdOdo2ZUgu1TjSzToQ+czqePBJY5duz
	3HrtzxFBjeCzfqIF2PYxKC9Pc/7LItQR7LuPJ/KDWDqCxTm1bA3u8sSVM7W1OJO6b96WG155g+4
	6yKhKXbUy8mA2IX0pWQs9fS4dj/ul0b1tk9FkT3gPIIBrl3TW0gj5jkspcBDMVaOCyuaGigivAb
	FZIppg5UjVGmPaD6mYe7XO3yg5wmg+fXluIai9FZF2INxQ==
X-Google-Smtp-Source: AGHT+IFt0b16olpogoFM9xHcx/8jo5Ldjyg2FEB+jFeQ3uVcb4VHrywsI0xOp9c+x4cPvtbnptVG+w==
X-Received: by 2002:a17:903:2405:b0:220:fe51:1aab with SMTP id d9443c01a7336-22428c05613mr241630645ad.38.1741583489537;
        Sun, 09 Mar 2025 22:11:29 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a9dfbfsm68188905ad.209.2025.03.09.22.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 22:11:28 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:41:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Aaron Kling <luceoscutum@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra186: Share policy per cluster
Message-ID: <20250310051127.zsnxoudfsw2ebeil@vireshk-i7>
References: <20250216160806.391566-1-webgeek1234@gmail.com>
 <20250310044553.zupmsoi4d3errjvs@vireshk-i7>
 <CALHNRZ-YpkSmLipQJ6i8XR+R-4ReLp1fd=jx0X1V8vDvuPG-gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALHNRZ-YpkSmLipQJ6i8XR+R-4ReLp1fd=jx0X1V8vDvuPG-gA@mail.gmail.com>

On 10-03-25, 00:08, Aaron Kling wrote:
> On Sun, Mar 9, 2025 at 11:45 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 16-02-25, 10:08, Aaron Kling wrote:
> > > This functionally brings tegra186 in line with tegra210 and tegra194,
> > > sharing a cpufreq policy between all cores in a cluster.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> > > index c7761eb99f3cc..c832a1270e688 100644
> > > --- a/drivers/cpufreq/tegra186-cpufreq.c
> > > +++ b/drivers/cpufreq/tegra186-cpufreq.c
> > > @@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
> > >  {
> > >       struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
> > >       unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
> > > +     u32 cpu;
> > >
> > >       policy->freq_table = data->clusters[cluster].table;
> > >       policy->cpuinfo.transition_latency = 300 * 1000;
> > >       policy->driver_data = NULL;
> > >
> > > +     /* set same policy for all cpus in a cluster */
> > > +     for (cpu = 0; cpu < (sizeof(tegra186_cpus)/sizeof(struct tegra186_cpufreq_cpu)); cpu++) {
> >
> > Can't you use ARRAY_SIZE here ?
> 
> I could, just wasn't aware of that macro. Is that enough to send a v2 over?

Yes, please send that and include the tags you received.

-- 
viresh

