Return-Path: <linux-kernel+bounces-191805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769388D145A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B57D1F22E07
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9140761FD9;
	Tue, 28 May 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyHcZ8A9"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E9502B9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877340; cv=none; b=K0ycjETamdi2nKbNwndP0g0+796+3jaOrkYwqE7RbiBMjIOA+6hTcMew4+4kjkeXs2Lc+M+PYc5GguDAymeUr4F8DZOH8cjh+BmOH8YLhac+8BKcQc0m3VXGW2a0shrk+Fy4gYciwPWqTr+azYQtUnXhEBaUYGtBvShNc8Co488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877340; c=relaxed/simple;
	bh=sSgwOYRHZt/YbcgLjLwtPsu63K7tgceDCycI1YiPeFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUnhT7HNf2n2oriJaLWYhasv4JbzWVIDOQYF6xQ1ohht1bhjE/2NTahARbW4UBKw/oKINdY9EyvPBNOuIcTmAiJWiSGOXx7nikvvCZvn9xkOdrw3ns6ciUXYBkXazwLzsVNr/TH4jbXnpf031Lo9sA26YMTZOKUchDGuk6ytFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HyHcZ8A9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8eba8dcfcso326467b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716877338; x=1717482138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M1CHUr7Pq8GWsvlpUiKUEvnvLu0gU/BSuoJzF8WPCMI=;
        b=HyHcZ8A9w5/AGKJXt1jMLx/6casaWPe08m2+6yPmHRiAmND4w7ZWKrfg7dO6xetrJS
         inEDHn5KE60ahLfd6lynICBTLpAGyyASxd6FrhD3KxR3ZR3rppIFR5pK2HA20BvnlpEr
         GZTOsrJMWIPjbxAaGiTqzjv4kPOPFsy3YueA7KZ0/Gr266qwWuOtGuCcRXCuNb9rkVvL
         4c+X8dh+n44Ww0BfV1xqTSD9F2fcuPG0DiUkFnfALf4OmHg+RBAhy4yMAhfJDKPpDHpz
         DpvIDcJI5aFbsUIrXestRykGRcJ/AKv56c4EPoyoqq0THGniy6CfXsYjK3wYdalPO7/1
         VdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877338; x=1717482138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1CHUr7Pq8GWsvlpUiKUEvnvLu0gU/BSuoJzF8WPCMI=;
        b=DKY15Nol8I24pgx3MjMsSXB+SePFBpIeZttPEnCajR/Nb9VrqFTO9mNPlo+Hh+/HIl
         6IdD5PKwtDewE0icXPkOxCf6FSIkOYZNPXECEKOCCLWrPo9HVvSUHzuqI47o1oq3AhAR
         ZqJ0zexEpXoOiEtvyg+qvDuwc+HrpxY8LzH+whOLC49plYZZQjHzgxK+DxV46zSMX6LA
         Rgm7jTfNPYD0x6Mp6RQApNvcCJwCM7YFzSgqLVcpP+cR2FIODiHO+K5ceFw9hUF0uExk
         xq/5bGEdxf8FyltIn1XvLBXt3yOypGYGMAe6FeMmNOWljJVTwlL87kHonfOrSWln1Zp3
         3lqA==
X-Forwarded-Encrypted: i=1; AJvYcCV9GuocmHvpKNcEDv8xsHS9L294JoNc7zjS63s3n14ZLPa5HbHChwGXCRy38mNTqtPc9N6jLT5x/yFir6kiNysRdgV1o05wEpnBWIRk
X-Gm-Message-State: AOJu0Yxk/mq9RBlxtxaH/qhgai3k1RKNPKRaMdc31RsOZ/ydBRUB97uS
	4b8Sgfn9+3VwHz3YDo9Vii4B8frCCpv4hOWJgopXWQipDPOH6bd+KrNMcOuqxtI=
X-Google-Smtp-Source: AGHT+IHnG/9iKdwGz8BZ4UVDyhrtXFgE7l0DRXdew9SAvtrL+y7nxrXtyvsiWGYHJk7XzGoau+hIHA==
X-Received: by 2002:a05:6a00:428e:b0:6f3:1be8:ab68 with SMTP id d2e1a72fcca58-6f8f43c183bmr11831391b3a.32.1716877337935;
        Mon, 27 May 2024 23:22:17 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3ef3esm5802550b3a.32.2024.05.27.23.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 23:22:17 -0700 (PDT)
Date: Tue, 28 May 2024 11:52:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: qcom-nvmem: fix memory leaks and add auto
 device node cleanup
Message-ID: <20240528062215.msu5u6zc2whpqqob@vireshk-i7>
References: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-qcom-cpufreq-nvmem_memleak-v1-0-e57795c7afa7@gmail.com>

On 23-05-24, 23:24, Javier Carrasco wrote:
> There are a number of error paths in the probe function that do not call
> of_node_put() to decrement the np device node refcount, leading to
> memory leaks if those errors occur.
> 
> In order to ease backporting, the fix has been divided into two patches:
> the first one simply adds the missing calls to of_node_put(), and the
> second one adds the __free() macro to the existing device nodes to
> remove the need for of_node_put(), ensuring that the same bug will not
> arise in the future.
> 
> The issue was found by chance while analyzing the code, and I do not
> have the hardware to test it beyond compiling and static analysis tools.
> Although the issue is clear and the fix too, if someone wants to
> volunteer to test the series with real hardware, it would be great.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       cpufreq: qcom-nvmem: fix memory leaks in probe error paths
>       cpufreq: qcom-nvmem: eliminate uses of of_node_put()

Applied. Thanks.

-- 
viresh

