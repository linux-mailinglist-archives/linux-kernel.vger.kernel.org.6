Return-Path: <linux-kernel+bounces-381051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645F9AF9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07E6282FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123FB19340B;
	Fri, 25 Oct 2024 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjFdyWb1"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904118C92C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836636; cv=none; b=CgxORu5lG/FvqcFuFKBmJl5l3QPjUjo95UaToiqMp32/kgZQVmInwJCBncLAYkd+zD7r9ysAta1k7if9GHE4rdgVlGSHhAP9UUs4k9n2QdwJsun0ztimCFLMtO6tpa7oDlhFmUTaetJMKtnLtEzQbWOn++j5GWzDKv5+1VRKdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836636; c=relaxed/simple;
	bh=RZf4quO3hvc9YGqR3O/W/MHuzKLzacRYkuTdyI/aTVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg2hd+4iixJ5mEw8pJ2IMXxaHA2NQC2m7l/Nq1nobRFt/fryxRw0mGzAtuzuiwJMT/ql4RhjiwDwKMSpvLTFI92aXVvpjm6IX5YN3OCJMxBtP8Z53XoAkz2GEx+f1Urn9L21t9Epmsj1NcXeG4cH6BmDgbnwXj2TeW+ODjZzXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjFdyWb1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so16992361fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729836633; x=1730441433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kkKPNMfQxKeojJArVyXseEAJLG1rkqHbjN5GAes3jo=;
        b=pjFdyWb1Cz1++lCtff110wKItayo5BdDZ/LE9IgxOwfqyXPwNBI8l8+htzvUb8SzM+
         drfGQc4/AbV/3S1VbVBuE25cx7kLCvEKUc7BPvM/eEnrUkIAMLArT0shmE9NhaD/q6Rm
         FEnQvVsIVYNc63egzGJuUhqfLpkkJN5cKZwREpYqUZWowcQEZxaYkq7gO6K0x7hJn9vu
         7CJPxe+DAO5LWJuChXDXVd0c4sBjC4Jzt+qnoXaZXYxVPruLGETSU+ydfn9iie85nctV
         sxxsit41uC9/E7nVtD+xutrbksZxZIIVHKfamBu4RrWKZFWfL/F+x6KWclhZCswTtbMQ
         wWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836633; x=1730441433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kkKPNMfQxKeojJArVyXseEAJLG1rkqHbjN5GAes3jo=;
        b=b4uECnYQmOi2Kt2OYL/Pvf0ltk5wMzj0QbQehEbY0B0noWSTJDelYCDrxw820pXnEX
         CTq1QkaoZ0WkxmVzsYxAgCOVojrltTRPWChzt3wRzWItQYZzsoOsu206webi4cbEs/pe
         Sy7BklHUHyPplSZZEdrJuRgI177Za5p/SypPugdjseb8Xa1C9xGKVjflOeNgIlWftVTZ
         yuSoLv8u1V8FvccVYuAEu4sMTCx/M/jHaqLfU4zK8W3mPpMhQOiOARXWXgwbPpZQiz0V
         Ybgd+XU3oXDjHEknAaHYhovKbj3rapwdmk7XKQXodq+PVpaVZ2KHM7NsxpQU6zE0JtLI
         YggQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1yaPt/CwW86KQD+csYBiSw2GibZq/bJN2x8Azr0eNgMurO/Y13+8OuqKIwaSLf7ndewCMkyxlh1eo8yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIM52upqlMC4Jf6K9uj1kGbGiRqEKZQ5WnuqjdLW6k9lESWVyM
	bPKHdMnwxIUMPDWkKAnF3m9q24AwzIDjlOVOk831s2R9OLXQOnGZvjGDGANU+Ys=
X-Google-Smtp-Source: AGHT+IFXtDyLhu4urkvu/zEBWCkjD6zDt8bX3VJFbWKeSAuwp/zDLD94N+n1R/o9WeiwSGWu061YMw==
X-Received: by 2002:a05:651c:b20:b0:2fa:cd7e:3b40 with SMTP id 38308e7fff4ca-2fc9d3458camr51692481fa.11.1729836632473;
        Thu, 24 Oct 2024 23:10:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d19d7sm692021fa.96.2024.10.24.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:10:31 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:10:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sa8775p-ride: Enable Adreno 663
 GPU
Message-ID: <dfaszv64mpxtqnqfulibglshdrtb67fsmj7tqilrrisqq4274j@z7u4qcom77zi>
References: <20241022-a663-gpu-support-v2-0-38da38234697@quicinc.com>
 <20241022-a663-gpu-support-v2-4-38da38234697@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022-a663-gpu-support-v2-4-38da38234697@quicinc.com>

On Tue, Oct 22, 2024 at 03:16:06AM +0530, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> 
> Enable GPU for sa8775p-ride platform and provide path for zap
> shader.
> 
> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

