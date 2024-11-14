Return-Path: <linux-kernel+bounces-410005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A79C955A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73275B240C7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F871AF0AB;
	Thu, 14 Nov 2024 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3Mkiw4D"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E611AC8A6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624543; cv=none; b=CxW/DMNgs2hizJhZuR1uDIA7+8+JjqPhLeXOwu8WWC/9n05irBiiFG7OsH6uFeg9ufoD9yhMqHr8oynJ032KofftG54gYHx5BJXshEGzbvHCk9lxP9wyhCs0qsAG7xaxxk/EPKO8d9X7JjguO9m69Fx+HSUTsa7S23ZBgTMFZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624543; c=relaxed/simple;
	bh=nw6VoUZvZNkdUACTTIdXm7iGFjKeQXD96Z3wjmO7E0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/35lWaKvaW88pUCQdJ/CwLz6271d9UxHSzpqDvT9y1/m4JNrhAzQgTb0LMcpHeole/wWksAR6nsT7Cgov6F1fimvkSnwI/IZcMzC1GvAaGxC54D33UmzE33buu31qPW3wSSB/aKi0HPrfjpxEtJ3RE9zuYz1g+fvg/LVsjgV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r3Mkiw4D; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53da07b78dfso112261e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731624540; x=1732229340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+li1obQZDvHKH1dQ4Z+Cz98Hc0DiodhU7YwjL0CPgQ=;
        b=r3Mkiw4DfNsvSchnyij6eK9tzqSgXetX8yAZa5otp2hWljvJ9iBbw59RhVAh+ts5uP
         7+ERMi6FCxDhdmisJ1bYP3vtD8/5DGsi/bRIGwvg6+ivarwVC0c2R5zxLCJFDd5/O/V5
         8R7UlEyeFsLifdc2iIn5qIBIIBVZ4ICiURXkoj0Z6J7PaM/S5p+ifNiG0MGjGdvMgNF/
         Prj+HAfSbP4YQRlTuyQNoE3yW8E5kFCx9ib2Be+4xIr6R329MF0xedYv98BwWOjKofil
         NrX+uv3uyXJm9Fkdv8qOS1qSZnhUFR9AUv9Z3p656YPU7twbQ1BgDuRNlok678S0rqyk
         WzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731624540; x=1732229340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+li1obQZDvHKH1dQ4Z+Cz98Hc0DiodhU7YwjL0CPgQ=;
        b=nJpJuYU5sTKArsO9oTOOasNkNktscl8DARnHRg+wE28UQNwYyfi4/ybwFvk9Nrn0Mb
         q41UOtFCMqNvBEf2C5FTPdnwZjZa2Oq0aUz6GAu/nP8rtgWUJ7jqxMlWrpUZfRHrjwM5
         6FgDtXsjk9iddCDkFyixaD1rVjf74xGhSh9RXGJs/4vaySoOUarVu5lKdEJIg9k4FKrb
         jP0GJBwnKZDBRFlSQEFgGHSTbvRWsATdzte99iibMcC4acDjOrLHAcq95cXASJRX4hu/
         U4VHH96Jupu+SY/7XvDiT97qi1mLe/bfAeEBjowWog+ZL9dZvXWjiTGyD28SDdKzjYBG
         fr3A==
X-Forwarded-Encrypted: i=1; AJvYcCVchcvHz4a/duoWBlksOrrJr3lVtIhIypc1oP596br+bXJk71FJ9iLr85gFp3AU+Oh5cAEFixtUgbCQb9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32D9xR7rJhQbLjnjbfif6qt2r/sfJdj9ivDJhuE/6dtsI7Ji2
	ZoSU5djq9c6JFcmfMaNSXojAGv++fZUVk0ZaDiFRD0eCerssnERdrwPvUpmCIX0=
X-Google-Smtp-Source: AGHT+IEciwhn6WNJsfswVN08/jxN2a5HA4mqW9TSwasMhjNmEK4pBMTbGoHEAgA+zAKx/x+31BOCNw==
X-Received: by 2002:a05:6512:e95:b0:53c:761c:2a14 with SMTP id 2adb3069b0e04-53dab2a9191mr155211e87.29.1731624539902;
        Thu, 14 Nov 2024 14:48:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da65000a7sm332985e87.76.2024.11.14.14.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:48:58 -0800 (PST)
Date: Fri, 15 Nov 2024 00:48:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Brian Masney <bmasney@redhat.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Shivnandan Kumar <quic_kshivnan@quicinc.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8775p: Add CPU OPP tables to
 scale DDR/L3
Message-ID: <daqa3krsp6emdha6h7tlcelsggb6qeilnojgtfxjbp5zw4n6ow@xzwdmu55ygjf>
References: <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-0-074e0fb80b33@quicinc.com>
 <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-2-074e0fb80b33@quicinc.com>
 <ZxEwVShJuMH4J1Hp@x1>
 <9179759d-7af1-409f-8130-1136c9ae4ecd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9179759d-7af1-409f-8130-1136c9ae4ecd@quicinc.com>

On Mon, Nov 11, 2024 at 06:39:48PM +0530, Jagadeesh Kona wrote:
> 
> 
> On 10/17/2024 9:12 PM, Brian Masney wrote:
> > On Thu, Oct 17, 2024 at 02:58:31PM +0530, Jagadeesh Kona wrote:
> >> +	cpu0_opp_table: opp-table-cpu0 {
> >> +		compatible = "operating-points-v2";
> >> +		opp-shared;
> >> +
> >> +		cpu0_opp_1267mhz: opp-1267200000 {
> >> +			opp-hz = /bits/ 64 <1267200000>;
> >> +			opp-peak-kBps = <6220800 29491200>;
> >> +		};
> >> +
> >> +		cpu0_opp_1363mhz: opp-1363200000 {
> >> +			opp-hz = /bits/ 64 <1363200000>;
> >> +			opp-peak-kBps = <6220800 29491200>;
> >> +		};
> > 
> > [snip]
> > 
> >> +	cpu4_opp_table: opp-table-cpu4 {
> >> +		compatible = "operating-points-v2";
> >> +		opp-shared;
> >> +
> >> +		cpu4_opp_1267mhz: opp-1267200000 {
> >> +			opp-hz = /bits/ 64 <1267200000>;
> >> +			opp-peak-kBps = <6220800 29491200>;
> >> +		};
> >> +
> >> +		cpu4_opp_1363mhz: opp-1363200000 {
> >> +			opp-hz = /bits/ 64 <1363200000>;
> >> +			opp-peak-kBps = <6220800 29491200>;
> >> +		};
> > 
> > There's no functional differences in the cpu0 and cpu4 opp tables. Can
> > a single table be used?
> > 
> > This aligns with my recollection that this particular SoC only has the
> > gold cores.
> > 
> > Brian
> > 
> 
> Thanks Brian for your review. Sorry for the delayed response.
> 
> We require separate OPP tables for CPU0 and CPU4 to allow independent
> scaling of DDR and L3 frequencies for each CPU domain, with the final
> DDR and L3 frequencies being an aggregate of both.
> 
> If we use a single OPP table for both CPU domains, then _allocate_opp_table() [1]
> won't be invoked for CPU4. As a result both CPU devices will end up in sharing
> the same ICC path handle, which could lead to one CPU device overwriting the bandwidth
> votes of other.

All of this should be a part of the commit message.

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/opp/core.c#n1588
> 
> Thanks,
> Jagadeesh
>  

-- 
With best wishes
Dmitry

