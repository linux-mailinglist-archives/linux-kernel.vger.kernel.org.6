Return-Path: <linux-kernel+bounces-203979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FDB8FE27C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FCC284FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20231527BA;
	Thu,  6 Jun 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNfzlbpV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A21514E7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665709; cv=none; b=Y/q3cVpsdW8NmqEqTlL2O+zZ5DSs6obO15SU3knM1l9AMR+Ab11bKH344Jt8YBqcwNyy16mcjuSfIJuznT2ZUKbRCor1PznefokjPOWtWw+VqbkoXyXGkNAm5M9qnqCu/oL7SzP6geRowAX30na8AOl4hj5LJYpwIZTJV24uoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665709; c=relaxed/simple;
	bh=j6wEvo0CGowVxf8AMl+Xy16XsVKn+Lvcja0unc/VlUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CFF/LyN8Y4Rcf0xzhuKfnMMX9oBl3+B09CRwb1NPWb4PSVcMMuiOgppI5+238/k3XYGPhgMp22uAd0eAHCZZm6yoPrXug0/e7C1jFnV5iF3UYb/IaM1iRirZaW2z+WkxZD6iQ1yeBCfPrpQB7zDL0OqjqyRsCSp4Y5ZZLJWDlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kNfzlbpV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so9190795e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717665705; x=1718270505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IamIVnH7h3ptzY7s1SJQ3/raS/vygxAsXmJzN5Us3c=;
        b=kNfzlbpVfwbZ9Fh5T3ZBBoYOBapsKjByfVp4r7Y9VtMzmLt9+JD1cgZtf2cKceSTS3
         1uefoJIWRaJl7BJ2F507Ufx5PFuZMOaBcUtsHRfM3Q69Gqj2eaXi8MIwg83b/xA28bea
         CM8A1o3/uSZ9k72ZlKW1RpG0dsMdTHwbcQxz7IQcvNOMeYaFUYHOJDb5sSNF/O+HPtOr
         3h4dtQeFjPUWltL4pelW9eXZb6B2E/DNTedXIzF3GuKtTuSc7qo///8+KQr5MNbTkemN
         JmB/I1EyQuU6jQwZ0I1lOSEQwW4QmRh5QVp4VR8+RMLFnqmQBpMU+5DeBcoW+HqnH6dw
         UX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717665705; x=1718270505;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IamIVnH7h3ptzY7s1SJQ3/raS/vygxAsXmJzN5Us3c=;
        b=XTWnekY6Q7LI4cpnGnKnpoKc5N8R3tWgbivgD5BSE6/bfDSC/k7wwTvBleoeCU9tHw
         9nFcKq9lnZldtZzcdZtMv/zgfgrtv4DwI60IOb48zUcrVdNPCQA3A+reMAw4j5hBTR2s
         SCIFKJbY0v476cXnlModokmGoCO8Ju8bxu5phDnQlDVla25aHjQoUaDwn9Sqk81XJWyW
         EexZXflvqHygR2cRVNbJ7ZGukwNcRCpKLh5dOuKT290zkLwNUZa0lsXZsKgUzYovnwVx
         gBsaPjBqMi4UOdjW0LdHerTYxHLWMXMTczQK5QopZymK1+tNgVYEEKW/rass6uxB+qn+
         R7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWllKRgO/y1NdmDDyjEL63xhXHG+cBhMvwkPS/vD5tAuI04X2chLaoDjnP17yH8dy1RRZSSq67W4eS7SfSV7VLIMlbms412WDie0si2
X-Gm-Message-State: AOJu0Ywligv+6jVwQ/zJX7Ak3K/jx0wW7pAyUc84fMveMIhsSdx1UM2K
	HkWdPR5Mu0kizKZMOOy9kWPNWS3o7fiduRSsxYv+nscStNskpq4cZw7VUKjBPIQ=
X-Google-Smtp-Source: AGHT+IEwTtsEYTmIGHFyaEV/Mt03vYK3X47FVxjZeEawQNkUUPRQKYSrAJkIvTiPl44uc76qhsDGzA==
X-Received: by 2002:a05:600c:a43:b0:41c:8754:8796 with SMTP id 5b1f17b1804b1-4215632e1cfmr43304245e9.30.1717665705057;
        Thu, 06 Jun 2024 02:21:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d4a582sm1033012f8f.35.2024.06.06.02.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:21:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
References: <20240529-a4_secpowerdomain-v2-0-47502fc0eaf3@amlogic.com>
Subject: Re: (subset) [PATCH v2 0/3] Power: A4: add power domain driver
Message-Id: <171766570412.3938980.5083031830854767858.b4-ty@linaro.org>
Date: Thu, 06 Jun 2024 11:21:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Wed, 29 May 2024 11:10:32 +0800, Xianwei Zhao wrote:
> Add power controller driver support for Amlogic A4 SoC.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[3/3] arm64: dts: amlogic: a4: add power domain controller node
      https://git.kernel.org/amlogic/c/c830ead0d16131de93d2020369ede4d670a4123b

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


