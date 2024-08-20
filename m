Return-Path: <linux-kernel+bounces-293641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4D9958249
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9902E284193
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED60618A6C6;
	Tue, 20 Aug 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzLaa0VX"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83318E37C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146297; cv=none; b=eK7Xyqp4U8FiTht/Yz6sFIHCg5A+wEJE/DIOqTUR4DxPvQid+YKANuB4hkQacEt+t9dFT714t57FdDJskGprHfwhkmw8yEVLlydsKY4tz8VWube59+7MPJD+LlU6hVlfVP+obgfi5fiuNDk/AbZ7bXNEQVa1vrv+oswqrQVgmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146297; c=relaxed/simple;
	bh=/MXlB28bsgCkC9kq+cpP/GjMuOsqVoNeN1HWsI9R9bk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iMSpypplk+tq1WCUTom9PE2U5HOn/LiwlyKeSovBOfc2ukpma4teAdyLqKCVDDaSQ+kzBXHEWYRcbTUk6LdXUJDKyz4c4/ZIIZTlL+j8D54GY1XNqejXfljeErDfOLmFs1QcbSXnEv4norLk9bVw7r1kIR4FE+te+zRdWSbg0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SzLaa0VX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3ea86377aso5215231fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146293; x=1724751093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bNc9l8XiGEm1hW0c81TkZnlO34t4wQ/crzh+T3fF2s=;
        b=SzLaa0VXNvCHayDXm47baQ/p4BYLn7EGg5mTPtNuWa+oDyarCL/ImIsBxA8Btfn3up
         KzoDdep+q1yoRR/LHo6g5ezDraLelaL15rqhglImHVNMbDdBcDguUPsZb236TlDQ8tLx
         BKOLiihN9FijMXshKZLrCw64Ei2I+9Wk73xPIz6SWw3G40odXoGbNLN5av1VzHB8eHvs
         A1CiJg1cZwqGaPBj9eYS5Q08kZnyfacdQspLq1lpv3H0J08JrwYrSm5R7kajBCgvGkf4
         qBwlgbNdDx/8ojM1CS603sOuKa3PP2ew2aYDcNh539omB0f8Quah6hJyRsE5kBCFATBf
         057A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146293; x=1724751093;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bNc9l8XiGEm1hW0c81TkZnlO34t4wQ/crzh+T3fF2s=;
        b=Ua3QcpqhSvNA1+YpEJotLDW+pc072+VeeBN1h5xufMckB1ZP+20qQxzEX6dA/zodDz
         9It0hGazr4Ttige6w0CtLcIai+FWHAQTozbVsFvgLrKO1LI8dDOrP++14Xfop7yNT5QM
         7BENREDhs2WKDZSY4qqbDBh8bX6tFIFjcJlkC0tBVvN5CvARSFxHFqtetltzEkCExGYP
         W0+PeHE02yu/7JGvbLAmtOrrUn3Q5bRCT3Pbj9zZf5sV3PP4gXolPm+oIwwvqZK0aoHx
         egwxqingppD3+w56cq71J/ChAHnNmc/GXP9vqSSmbMZrVQC+qroNoprit3l4rNWvMdJZ
         8ziA==
X-Forwarded-Encrypted: i=1; AJvYcCX6gNM/XyAxIHd1mC7P8kTaTEFPr76IxEXC7gpZ4ymhk9tm6Q16qM07yo+A4r4VSDt8DNrpJ576bxWMhO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDFP5NegmZdEEAwuCJjpn4OOoQzkov3vKqdvaHOdBw6WdTsE3a
	nQQ9kPoz7ThrNJBWDCs7/7lwsv2JSt1JBT3EWp6Mv4nHae/oT/KB3ZbFFn1e9nc=
X-Google-Smtp-Source: AGHT+IHblW4gV3DpsU8/IHEQKTGcs6OrOgAvGPIjBHkHUBepvRVzyoB1s/Fv/Hbq19HVXW/1GWWKXQ==
X-Received: by 2002:a05:6512:641b:b0:533:44d2:e682 with SMTP id 2adb3069b0e04-53344d2e7fbmr439573e87.34.1724146292925;
        Tue, 20 Aug 2024 02:31:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648f00sm136597505e9.7.2024.08.20.02.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:31:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: agx@sigxcpu.org, kernel@puri.sm, Tejas Vipin <tejasvipin76@gmail.com>
Cc: dianders@chromium.org, quic_jesszhan@quicinc.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240820091556.1032726-1-tejasvipin76@gmail.com>
References: <20240820091556.1032726-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH v2 0/2] convert mantix-mlaf057we51 to use multi style
 functions and cleanup
Message-Id: <172414629205.2571141.13215409630895562248.b4-ty@linaro.org>
Date: Tue, 20 Aug 2024 11:31:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

Hi,

On Tue, 20 Aug 2024 14:45:52 +0530, Tejas Vipin wrote:
> Uses mipi_dsi_*_multi function in the mantix-mlaf057we51 panel and
> converting uppercase hex to lowercase hex for cleanup.
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] drm/panel: mantix-mlaf057we51: transition to mipi_dsi wrapped functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e139c0eb22ce5b2ab6a2056c1ff495f3a38322d7
[2/2] drm/panel: mantix-mlaf057we51: write hex in lowercase
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b61c4bc674c6032827f2682a0c72ff577c36143f

-- 
Neil


