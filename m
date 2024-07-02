Return-Path: <linux-kernel+bounces-237911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFAA923FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAC4B20BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9821BA063;
	Tue,  2 Jul 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SD/4Xdcy"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10258BA2D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928649; cv=none; b=nX9Db119hatzCzTBeru+3utcdpSO1YALj7TrnAUbWWnHHt7VQ9Xh6j93Ms+J2TdwzV/v6XdrpFuWz1rlTkQMBpgyccER4y8P0M/x7+7+rY7s+NQFMKcbG1CcvyJ6pmeZ7bNYMsyE63sth//SZ4wfCtdk03/aOQdZjxMLcAYr1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928649; c=relaxed/simple;
	bh=qt01brAtBuYeYDb5XU6vCoxDmnQV+1+Sre8GzSkYpTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/rjK8j3CXG0jgQpKrS/99G9hjeBDM7o+en/+5PQQBO1VBqNiD9nQUKZ5Pn7M3tkFLPndGWn32UwdniFRq+rJ2aFOcr5R3d3rH1GQuyWSBYNZWOJUOL1YppcR4I7kOn0a5T0dJXbAjvG/jiSGUWKImgyBECHIaHzJKK3aEJdhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SD/4Xdcy; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f8d0a00a35so3977058a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719928647; x=1720533447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePmiEYi/a4AH0wn7ckFFYm2PTW/+uVYsAN+yRliA3Bs=;
        b=SD/4Xdcy4fe3ZVO3oqqPa9q++Hszs4ulZr+39UOdXOyvkdKhvwxmZKrmgdd8yCaT44
         hdfCXKvZYcDiQ3oUXQd/guxEeUHK4MZo+A/3YKrwPtSp0ZTcnPTsqWXmMiNY5mvRbNYL
         7ew+UjSEDqgPZqHhuchJkmRn0iHR2vzuDgvYouou/tFzOESIL5bAPGwn+631ctrH2xqI
         X0kdOTs4OyB0RI9VrakfixnBTs09+l5czZ7QAGxKniScmlgTDw/6rjmiqIzh24vGuuMO
         A0RGrmTmMiw6ig5S0YU4n0qwPMhZQPWQm0wiwN9pGD6uXJLcOIaXQ4ZoTyOLQACl5CZJ
         lutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719928647; x=1720533447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePmiEYi/a4AH0wn7ckFFYm2PTW/+uVYsAN+yRliA3Bs=;
        b=lGlEvExbzO4Vqe9Mwv5OKVJO9CTJSvoN4XntgPkhNr+rojHUXgTOcBLMmwmzn5Szq+
         71fjW/g77BMuPgEaGm0UhsM+JUJv/RO/VBUBs8SVvo6n9U4X69nLwJlsB4x+Ac+0op1x
         RBCCSyc/amqg82e5RaCoWfEBkUNBZRxFnR0dGcw2Vhhxj9nAydeqEaVROlnwwG6EUmyC
         zstr6+NMrnTgTNZNAkRb+Uj9Rml8DyTVRQ1WjckWDL5xgSA4GK5Afduun7CRZ0PBQEJs
         C6VPHoVsS+hTk7a/SCYcVx7IUH+Bn+opjDwIKnlvq+weViFg/BT4ZkmOG1jsZ3Jde1V+
         NTMA==
X-Forwarded-Encrypted: i=1; AJvYcCVBpBa/2NMAhEBStN7fQM/PYTWiYP5mw+g0l/vOEgPplRyvMeJxvtS4xvuUIIQmyxCbPcCvhLQyMKGc3KPG/MOkC3EFGzNS7esEbRMy
X-Gm-Message-State: AOJu0YxkJZ3NI09hG30qFkk6fkqe2ss+9ldTsVAwLgBJH/71ingUTQyZ
	wa37DJjOC1gmzrt0KYIg4BF+RDAqNXG+R/PbhzQqyBQA91Nxx10UfGwKJbz5H7I=
X-Google-Smtp-Source: AGHT+IH5Vk/edmC8lLAXOlWnBYfSKbo/eOsXpv1FuEvdKG37AODsGoiz394zQKMr5V6bCT7B+XImXQ==
X-Received: by 2002:a9d:7c84:0:b0:700:cf6e:e261 with SMTP id 46e09a7af769-70207708212mr10589665a34.31.1719928647061;
        Tue, 02 Jul 2024 06:57:27 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:a6f1:b7be:4c8c:bf62])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7ab6931sm1688615a34.31.2024.07.02.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:57:26 -0700 (PDT)
Date: Tue, 2 Jul 2024 15:57:23 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: arend.vanspriel@broadcom.com, kvalo@kernel.org, johannes.berg@intel.com,
	kees@kernel.org, a@bayrepo.ru, marcan@marcan.st,
	quic_alokad@quicinc.com, zyytlz.wz@163.com,
	petr.tesarik.ext@huawei.com, duoming@zju.edu.cn,
	colin.i.king@gmail.com, frankyl@broadcom.com, meuleman@broadcom.com,
	phaber@broadcom.com, linville@tuxdriver.com,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH wireless 1/9]  wifi: cfg80211: avoid garbage value of
 'io_type' in  brcmf_cfg80211_attach()
Message-ID: <ba67020a-04bb-46b8-bc05-751684f71e8a@suswa.mountain>
References: <20240702122450.2213833-1-suhui@nfschina.com>
 <20240702122450.2213833-2-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702122450.2213833-2-suhui@nfschina.com>

On Tue, Jul 02, 2024 at 08:24:44PM +0800, Su Hui wrote:
>  brcmf_fil_cmd_int_get() reads the value of 'io_type' and passes it to
>  brcmf_fil_cmd_data_get(). Initialize 'io_type' to avoid garbage value.

Since you're going to be resending anyway, please delete the space char
from the start of the line.

It's weird that brcmf_fil_cmd_data_get() uses the uninitialized data.
It looks like it just goes to great lengths to preserve the original
data in io_type...  So it likely is harmless enough but still a strange
and complicated way write a no-op.

regards,
dan carpenter


