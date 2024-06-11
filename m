Return-Path: <linux-kernel+bounces-209809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18022903B31
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CC71C2336E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00717B51A;
	Tue, 11 Jun 2024 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHkTfwXy"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF516F839
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106837; cv=none; b=qzmfo3H5Avs2OjRWumaE4N9XlfiolhnMPilcOpRPpD6KM7+mVgHUPPmH2L0pS/XW3MEhL70lRM7uda+pUWkADpqvLBdIE6etU1hTDvefnnE8v8TctK57X0wecvqqrQCeaK6ykHEnz5amllms8FJ/27DDuJ5CzKS2iFVtgavfEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106837; c=relaxed/simple;
	bh=a9wEMYMLhPik5Iha8GD0lGDvxK/fpNcpfivXFPvkQT0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YXyqV5jQLAPkhUM/Z0oAqp/REQez1OuhpsAsBRE5y20/TsHoPuAhFI+7Jqbc+nleIXjhEZzSQpFHADuNM4Rb/j5I57Qs0onajkdS8FLLTX/xD+U6BSGmGiclzZeaR+roqHOrJ+Pt6rZkmb0qRcQnFULQYfiwoIARyBBVdOkjp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mHkTfwXy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f3efa1cc7so47431366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718106834; x=1718711634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0y6b4gZFGCud80AmP9t2bvPpeH4+hki8K6zxSKyNa0=;
        b=mHkTfwXyB8HMILBOaHFqKY0viLoSyWo7q+s4fBHTqzHq8xfhZoibuRi9zfBZmuD6t4
         ghzTwOUZuHF02EGr8p+Ef0249TNF6jqDpadN26XyC4jeAJ/SFs/gbEMfqVKhOXEAapPF
         Tai84SPzeiOOANrWAzMf0vlUULwA0Kvr22YqGB9o85jYjAK+FoRjf1vQlyYPbymqjaLr
         KU/GK5ykRz6AvA1scABZJXEQnKB9DNiM/TOMaR8RIqXZbBnMa1EG7vYtmy+3Bd8ND+a4
         3+WaDHquxulefSBQ19NCSYspqXLJnM5p5n/iRYAm9ihQNP174/Sd0k2DrZjpu1leE8YJ
         MUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106834; x=1718711634;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0y6b4gZFGCud80AmP9t2bvPpeH4+hki8K6zxSKyNa0=;
        b=S7s+tThKUXaw5oVmBYJ9RyU1mac+YDgEOGwR+JdxVz18QOU8v1QNyEqa+D/bdYTqse
         9QmcUrRcTcz7xUHYfEA6eWtEbwcIBSAoP73ebjywj9zR0jg4LjtNZYeEWtQv5YJLTnC7
         Gtu7jPbSXr7WhvMYSL/RbSiG1U/Hb6/bjCNY3yeeCstXvVkpt1tvvop7/WIdupiSuG8O
         Pb7ru4TDSCYn9NdMXgWqLLdUH+UWjsd6C0/VTymgtNccl3x63OLW86mGQWMzegkEhOj1
         3Grm49I/kC09lWwqQjRanOUca1m8XJTwPlLamaVylGRfFD9PFRJjIXWItIHC68aS2WsM
         mXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpX+E31YA1hH0trlwztbl6FM+mhSxnDA2gRjqwkC92gijLmE8a3MgyKsSUQGt4NAf2oowGsneXlLa4tvWqwffEd3ZU9jH17KaR5uSS
X-Gm-Message-State: AOJu0Yyvnglf0+pGNcTjXtINWpx87hcefgy3Y8NEj53cL7/PvO/iNQCP
	/M14qk3WO6ya3pdxDVit/7hqPOiTuVLJxnX8dRYba1cDMyGj4MR1YeFgdmc02HM=
X-Google-Smtp-Source: AGHT+IGp+ZH4BEY69xpRaz+jLd45lkNkemrYFPhxsTjCwIw9D9bZcBF1aj2i0QYXU+k5xe4xVJFGcw==
X-Received: by 2002:a17:906:4ed4:b0:a6e:f53c:8da0 with SMTP id a640c23a62f3a-a6f34c7d40bmr184942166b.8.1718106833865;
        Tue, 11 Jun 2024 04:53:53 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef83ac0c4sm505225366b.74.2024.06.11.04.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:53:53 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-arm-msm@vger.kernel.org, Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
In-Reply-To: <20240611103442.27198-1-quic_ekangupt@quicinc.com>
References: <20240611103442.27198-1-quic_ekangupt@quicinc.com>
Subject: Re: (subset) [PATCH v5 0/7] Add missing fixes to FastRPC driver
Message-Id: <171810683302.68152.7087367565963378291.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 12:53:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 11 Jun 2024 16:04:33 +0530, Ekansh Gupta wrote:
> This patch series adds the listed bug fixes that have been missing
> in upstream fastRPC driver.
> - Fix DSP capabilities request.
> - Fix issues in audio daemon attach operation.
> - Restrict untrusted app to attach to privilegeded PD.
> 
> Changes in v2:
> - Added separate patch to add newlines in dev_err.
> - Added a bug fix in fastrpc capability function.
> - Added a new patch to save and restore interrupted context.
> - Fixed config dependency for PDR support.
> 
> [...]

Applied, thanks!

[2/7] misc: fastrpc: Fix DSP capabilities request
      commit: 8bac43bb507f1fe6e56762ca350c8b6f41096959
[3/7] misc: fastrpc: Copy the complete capability structure to user
      commit: 552244bb57914612f4db79f0f52c6130af45c50b
[4/7] misc: fastrpc: Avoid updating PD type for capability request
      commit: 7718647366694bf1821a87e08a2ee4ef62012270
[5/7] misc: fastrpc: Fix memory leak in audio daemon attach operation
      commit: f3080b096933b6633d71e5345f72a79ec25faaa9
[6/7] misc: fastrpc: Fix ownership reassignment of remote heap
      commit: 2a732868df39b717046a4f03c40f84db8be9c687
[7/7] misc: fastrpc: Restrict untrusted app to attach to privileged PD
      commit: 435f39b8991cd719fbbceb6872602629417c9272

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


