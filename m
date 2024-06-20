Return-Path: <linux-kernel+bounces-223467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F288911384
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7551C21ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242326EB55;
	Thu, 20 Jun 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWxnl3/l"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4175A0E0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916113; cv=none; b=N1dV+6Y4ja4Q4sGi29FhLzHHB3k8MzydKfpLyc+Hzkyn/tqT72F7r+GO9QMrm5oYzA0K9xMgBiMKPzu490hpTh78r4xhv5a1OsgKJkaxkA5AmfjCjnIuIKXuz3lsmCqa3GsexbvlAnd4M1+0niiRPmrZKwYSOonbjtxKFheuRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916113; c=relaxed/simple;
	bh=jCRPeDhRTexacpaLMCQOVq+EqZtjNasVzgQEbK1/75s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1OO00o1keqjcGwAkAYxqb548YBtJLAmzrkiehIjjBzpG1YS0CskhQrHqZWuKwk5aE4sl1h7bpqmG1/USlc4JYJE9QS8xb7xeAn+Ob0KtRcznxOHBJGx25oR2DgA0TBqnT5oDhpLs2EwvvDHw1o9/UlT4luoxRRB+HrgLaHs2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CWxnl3/l; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so1306730e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718916109; x=1719520909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LV42KA4YMDhuTQbvBLdefHeipONZ+HZ8OMMqsUM/p24=;
        b=CWxnl3/lxP1H9NpJ07ZVp+ldCK5RkJ96WOsLeEtNkNDVMYeTapmo5C8hT+GT//89r+
         ipj8+hEN9PV7eaaCzbM4+SEiqeYaVwptpnrZT+290RySpWSk+OKhVVBnodIsn03G0T2H
         QftO7aD+pP2yr2C1KPj2vLnsiD+npRpoTBam6CZx+o6ltbnLUF5EAdEuvv/QO78A86th
         79rg6tiptD3+wf/kM1654k3fhr+/OsTYGmYAE0hRPgOznE/8V8C78k5rVPLejXj85vZi
         Em4CGrU9g8ys96o49Cla0dKNTDp795Acaziof/cucJUmApbnkja9TLWX8KJpss2xrj3M
         MwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718916109; x=1719520909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV42KA4YMDhuTQbvBLdefHeipONZ+HZ8OMMqsUM/p24=;
        b=RL8f2Y0xjCyM4tZRJmRCEABME30704xY37wNAWa6BQShlKTlc1JBCXGM/oTS2t4Mv3
         7ijcnXXPg7Vra/+Wz8B2k5/NkG0L3xU4dZ/px6PmQBiuSGWXN/haBDzgzFARFsYYS11q
         TcGw1u3j8l9HjtnApV1XHVNfmC+WQzf7zmLP7VFCvmALFCv13dnfB9TPVZhEf+b+Z4T8
         B+lPB2DvG883BGLLFmbbXtPI0hjrhB3tsRQo2DWHXbnbcBFa/E8yYHs3YNa/3VvspRuM
         2STHQUzh4BiSobFYRRZ0Tm9e0BXTtuOA0JTPICX/Z0wxHamdCb3HMwQFL0DyGvVCnkFG
         9gRw==
X-Forwarded-Encrypted: i=1; AJvYcCU0YnS/CYS8NWW6QIE6/ArQy68oLQRYqoQNdqwr6ylBr0NX9L19+M7yetc/lPZ2tSO3/MEAaRwMl0i+o2dHpFCBLhPSeETqYX8yFXyN
X-Gm-Message-State: AOJu0YwZvzMRQO25LOpGmm2dbe73kx0fR5xtChOtKARBVKb1xc/TkF1H
	x5qTM9nb6yqusyIoj6KPun3sBziYjyuya9uJB9w8RWy8cj0F128ekcgK0sG4Qaw=
X-Google-Smtp-Source: AGHT+IHRtv8ZxR7EYsMMf0CjZ2uGMGxflB30i6/Yb/bOaNtWDIKRz1l20HzQlyZfncdMDFY59vj67g==
X-Received: by 2002:a05:6512:3ba3:b0:52c:9c8b:f89f with SMTP id 2adb3069b0e04-52ccaa54b83mr4595217e87.48.1718916108756;
        Thu, 20 Jun 2024 13:41:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282efe1sm2155501e87.76.2024.06.20.13.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 13:41:48 -0700 (PDT)
Date: Thu, 20 Jun 2024 23:41:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: msm8939: Use mboxes in smsm node
Message-ID: <rl3jfufx6tegdt2ff3n6lveqvlqs76lypeegu2l3u4lupcfxcm@jlzxny4fmsns>
References: <20240619-smsm-mbox-dts-v1-0-268ab7eef779@lucaweiss.eu>
 <20240619-smsm-mbox-dts-v1-3-268ab7eef779@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-smsm-mbox-dts-v1-3-268ab7eef779@lucaweiss.eu>

On Wed, Jun 19, 2024 at 06:42:29PM GMT, Luca Weiss wrote:
> With the smsm bindings and driver finally supporting mboxes, switch to
> that and stop using apcs as syscon.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

