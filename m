Return-Path: <linux-kernel+bounces-352456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFA991F7C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012302820A3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EEF18786F;
	Sun,  6 Oct 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YY6bkCmC"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E218757C
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728229317; cv=none; b=Lvk31u7SfKlPyAZTxcliKay3zgLV69uDfchLd0YIKZLQJHUXpJzYan02Ap3czNR2E1PL1D1VqDPIvt3iwxqHpsVwRRrbdnbQurxdkJn7y8eM+DxKD5FoT+nfJm+nX+M4wMISzS87FIFZZJbLlZmSPcuHV0EAlwER2VY69ILDVmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728229317; c=relaxed/simple;
	bh=ZYu1p2iCUXXqlinc4FOntVJQpB0ttoG4OyLaYqbVpoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0Va+fPUfPwYdYj18sqey2cS1ELoQkbVC0tpo7ptrlFnIQ+x/fFBeOb5mYS9ODnwzpmSWDdYHy8oJx6MwuRkQBOyET++YePwiBpvx6Q2MM8pPTrUkLbeHRyrjKPRNBdZPNg7ss5gZTbmrQVzxROZPAY2kdMNs4Zz3GbRtIDOhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YY6bkCmC; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-537a399e06dso3735483e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728229314; x=1728834114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4p9jMFSztyoNE904oPFEPF87mzw4/12acqenqKvZUA=;
        b=YY6bkCmCWbuMtDjphtxjgd0nswbQCh8dbT1cmUU0vU3eKCzYWcY1UIzRsTtGhBsqWy
         Nf5JXslcqdfnAvnTk1oDNkNG+/CJI1pU7h2UIJxpbYLV9kKX7w2YCGxMa1o/Vva549kJ
         YKgBvB/a1SNR59r51/jdR5M0UeJY42wkl1eQ9K21PwVbGyNUyS9le92mB5CSalXM+5cN
         3K1/+LPE83JkQqoFBsxId0gc9Oo+/qSNGIJuV94SgOmr9zHM1bovgXLKNMv86LJhUSii
         Ogwo5nhS3r9/NGgtK8DLjpw7eclsAdNPKrwjKW6C+XLqNs8uzy8I4LsonJqk0U7kFaDb
         cTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728229314; x=1728834114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4p9jMFSztyoNE904oPFEPF87mzw4/12acqenqKvZUA=;
        b=g9FEaTdN2ZOEzoFR1tzEWutvmDVbSkZhJVaITe7qc0b7LQwS+gMKFhjN9rOelE6Kqq
         x6s3gpw9Ns79uZo8y1zJ5YFy90wkvT66WA0lkyyzL00vv1q8IGE9RtsVS+PF81nEMO9f
         VYm2mrKHe94lxOaAstknweSgTqWyDox1Wrn1YJqm7qIDWeQp0mhAmIBdFGrN6aqIsHPX
         Wrao/PPQN6I91IUSoA7lfyI1S5K3wQwjswx3J9S13hc3j35QybIa/dlPC5ofxwzwXcg9
         iLGLm70118TNziFlYQegm4IgWggVXp8S6cUlkB7gZqOKTY9qg+bdRhf64k5QErHG0eqK
         1UXw==
X-Forwarded-Encrypted: i=1; AJvYcCU5xtWiso27BC+mOc0GM/rbOlziRMudDze5LRQ+uv+wUuZBEHKRw8EXZw0S2aPoTy7uPeOdjagjcteMSX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SPwO9adIDy2huJZ+dpjW2l5UE9q5d+QpDH3HJNME2TpS2uD9
	8u+rkWV07GcOtRBantqwIxquJAD8C2UGoO9Am239pvkj3pHjFxkFfeokTy3r2Uc=
X-Google-Smtp-Source: AGHT+IGHyll29gxgPVrSu7EY6tFsXaeJOH6QVOYgehdPBBFKLBFBH1xiC0t8K8NJD7F1RqXQRBlrZg==
X-Received: by 2002:a05:6512:3089:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-539ab9eb010mr3830938e87.49.1728229314192;
        Sun, 06 Oct 2024 08:41:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23334sm542714e87.184.2024.10.06.08.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 08:41:52 -0700 (PDT)
Date: Sun, 6 Oct 2024 18:41:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	Guenter Roeck <linux@roeck-us.net>, 
	"open list:QUALCOMM TYPEC PORT MANAGER DRIVER" <linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: fix sink status being
 overwritten with RP_DEF
Message-ID: <4outbhuix7ivgvzqwymttxwv77fuvuwq6cj62glccknc4ftjei@pqq4n7j2d77v>
References: <20241005144146.2345-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005144146.2345-1-jonathan@marek.ca>

On Sat, Oct 05, 2024 at 10:41:46AM GMT, Jonathan Marek wrote:
> This line is overwriting the result of the above switch-case.
> 
> This fixes the tcpm driver getting stuck in a "Sink TX No Go" loop.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

