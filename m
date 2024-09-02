Return-Path: <linux-kernel+bounces-311387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD0968872
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4042C1C22A67
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D169205E08;
	Mon,  2 Sep 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzyqLZHe"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7720126E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282404; cv=none; b=Me6ML7GUre9/qU8O2PKYfqqO9NNL+dv728N/vbg954YZpeGIEb5sFiq6jlLYm0y5sjayjDFzTDLFWqcaGbAeMPxeHNTRTJD9LjoDOByE7BaCpYS5BYtiJCLQ9VlrUUnYuz4ikFnswyerKJ4S9nSYj4G+nQTni4AXf4CRctZTR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282404; c=relaxed/simple;
	bh=hCao3ZwMfqBXJ90vPgMuPKTqI+Ts2iwIkv+E0luWloY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UCef2o5aAXx3+vtCGxo8uAaWrpraCQ0Lw3jMLXnuanediZk3eIYclVttZkvemECsvlLpJ7p4KSrnhi+VfNE6qU59sKMzi7GP00llx2D9AbnRyIz8wRpy5p7P+Ap+dkV8IymbAbsCQcOdFZUSTCy3O9N1fsdda7EYTn2N3+mZLsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OzyqLZHe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533463f6b16so5325617e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725282400; x=1725887200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxFGRWUoPCMnGMElyAdl1qHVvyQ1H86yoEGFpbkJKF8=;
        b=OzyqLZHejB7rNiMGkaEAWgPNi1a1x4+ma/4n1tG8iYgm7HDoDRA/zRAANLjJHzMSjl
         5Dxn6tHX53LvLoxwXAJyMPjxOx1NRizaG/Q8Pb39sj3SANqZH5dnb4s4h2IbQ0NqgiyF
         Ru5Xl2MdykcPl1iGDqLQT0o8+L5wMBJgMn7VAfn1TJCTNZx0yztzsMGTYeCE6VbrxqHv
         FTJBF5ZW1AihURIRhTvvL3Sa4rCR6LVm15YVoUlsrf2DweAIfgSSQWkYoSfX3syleiYg
         1P53KrsP9zQqi6qGomk2+YhLEQSp8SlcOlTG97z3WE8HkBb+3CjJMeusDoQDj4hb+pD0
         PK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282400; x=1725887200;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxFGRWUoPCMnGMElyAdl1qHVvyQ1H86yoEGFpbkJKF8=;
        b=GW4KVuHqw2eNp9Y8SqKhKcnBriYy7uEdrPXZuBZkShzgSSdmEKQKH3hAF8N4NjZDhW
         +mmfCLfdZA3FQieudFA+zl0WmaHP0QhzygZUKSntkLpcnJfTBWWbQ0xPYuCgqyHSXb8u
         EqkS8+p05I3wNbzYOjn5TxVUVV4vuy9Ts5isu980mOg4G+/9LX4AcMkXplVQ8QeJDC7S
         sXeWgjnLJkKho4TbOOVu5iOtQq2bf9FC/1RRQuP4YC5eVZIOJNCQkhb4etmdLqdUvwHD
         Skjn/4CZp+z6atcqZEeMHVYMUApvVyTUiY7vZLUzVn8keBl4d3cgPagZOqf0Vd/vVwO+
         aUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzIldarfGsJkvdStHgZTN2z2O1C8DVhL7QYQXN7SZCtAKB94VrycNhClPEPw+z7pVsnjC9tYZkaUt+Lkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/zcQhTpwnPWgdA37MXRWH0ogCen47DlDpLBFD5lqaiznnUCMc
	00WWmIISrQ7ydNf3rFzK2iMLJkFmcBsgZzIBH4SczAqwspVGmpoUAxQ4N/TrX00=
X-Google-Smtp-Source: AGHT+IFt3dS9hGbtQ1XenR2ZRQc50prF2t+XU8esp4fl59eflznNRmkdPTVgxF5vzgMf2AOQpdNOGA==
X-Received: by 2002:a05:6512:230c:b0:52e:fcd0:241f with SMTP id 2adb3069b0e04-53546b27fddmr7561878e87.29.1725282399574;
        Mon, 02 Sep 2024 06:06:39 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891968desm558529266b.130.2024.09.02.06.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:06:39 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: vincent.sunplus@gmail.com, linux-kernel@vger.kernel.org, 
 Zhang Zekun <zhangzekun11@huawei.com>
In-Reply-To: <20240902015051.85093-1-zhangzekun11@huawei.com>
References: <20240902015051.85093-1-zhangzekun11@huawei.com>
Subject: Re: [PATCH] nvmem: sunplus-ocotp: Use
 devm_platform_ioremap_resource_byname() helper function
Message-Id: <172528239889.64394.14926980583304748361.b4-ty@linaro.org>
Date: Mon, 02 Sep 2024 14:06:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 02 Sep 2024 09:50:51 +0800, Zhang Zekun wrote:
> platform_get_resource_byname() and devm_ioremap_resource() can be
> replaced by devm_platform_ioremap_resource_byname(), which can
> simplify the code logic a bit, No functional change here.
> 
> 

Applied, thanks!

[1/1] nvmem: sunplus-ocotp: Use devm_platform_ioremap_resource_byname() helper function
      commit: f940496293787ddfa481f2dc67fed60148212d83

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


