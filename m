Return-Path: <linux-kernel+bounces-312874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F87969CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7369C285B91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE51CDFC5;
	Tue,  3 Sep 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gp9vvm+C"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6011C9861
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365001; cv=none; b=HXkigLhyAISY0U96lnuuYcQdP/NidMpqfVyelm85FdymNNHvTnoDG1HSwanPmEOJlodPWQ1f1vDqWSiCqxuwYNr3Sq9oyCeJhiTPcKRphmaLIV8LK0KtQsENFQwhAR3joly/MqkZuOsqHBsKSFbKtL5FgHf62r/B7o2ntODuicQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365001; c=relaxed/simple;
	bh=kEy0uL+fD2lKj3iUlgQ27J8z/bCXyx9tdiqTWqPKOBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1U4hGChg2fmRH/h1iUEaw6LXLliTujzXThxfjU1zXY6/vm6GtJDMdGiD4LE98k9xDKHYxyHQSOdt3x+mYXzaVi4fY5IeD7P8c5de5YN2G+Aoqqmj7cZll5gLOCtvx4e29Lkngksh4HU2QlZqzQ7pbn/I80daFoR3VCz6zqhOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gp9vvm+C; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6daf1c4aa86so5747827b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725364999; x=1725969799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uT/aD2fYaRoviJnEdnc8G+3b8uWSX+p8TECg/DCp5mo=;
        b=gp9vvm+C1jByzbT/wWT7AOvC50nptTMcmhxYhhhMKcqLUevaeqnTxDw0q2ACVCXp27
         +TIQB8Jclw1WEKuEQNqJs0wdJ6KVqe2LQJSK23fr41dTVAgmU9n6YrDWhHZO1OyV+GRd
         28TXKZtpwiP8JNkAiAeqsevQP+/4qwZqjb7V0VInQZSNlvwsLR0CkbekH7DfDM438DSS
         3zpv8eQCBXbPuTBj5DZMN7LYHBh5Wk/VCNJfxjc/QMNEZSQqQ7jEb7JqnD2SO3SMfm/w
         oqDQoLlPrRpIpVFjxiKbr8Zzk3LEnuACv8BjUN4FIz5a0T80vqTZnzhqPPpUaux2uiIp
         2aLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364999; x=1725969799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uT/aD2fYaRoviJnEdnc8G+3b8uWSX+p8TECg/DCp5mo=;
        b=NXsuMfRwD9iYPCxkrJGJkb/ojnnqX4GgBQt5o/3nzUd7VHgJzJW6rbH3VMAZODP38s
         iuaGqeD6PUcNKVZAU9sxfQ75P7+7D3Qyjw3kl30hP8lO9CGr7xgd/y4Jhr9OqsIiFde6
         983Ji43dvxjw4qNn5PRSICYwzrAoFRajceUWs02+OqdUwN8hMt+s2d7r1PqHSMnDlkT7
         u1WOB5E4s6/7O30hht1dlE8dvJNDsbouCOr6Sq4ztS99B1YCKgFqM+u5xhCO4WFg3M7L
         sEHDXM40mOdrFvSrOlGS0MKq3JuwYx0eD7blOkyYDq1gK06ujQce/fyk4vHU+dB5wbsc
         EH6A==
X-Forwarded-Encrypted: i=1; AJvYcCV3kLbi4LozRscSY3MeF6c91/z9vz9U1Rg9En0cwI+lj9q/KYYJZ4qBojAZx4JPPvIXwwZyvha3X0aVqdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3Tnw4tfNjlvn8cd7/3v3pQ+duYUQImZeKUcmnG09Sp75rHKI
	NNY+8h6UQ86URYVdd1xdnLiHT51Lf48r+cc5txiUx80guqRkiCtgePSPH8UIXvQcl3sQog8pIZL
	lU7be4HOnYfw+xmFyoFCYBjX8rsjzAB4kqC8V8Q==
X-Google-Smtp-Source: AGHT+IGjLf7ldseShYpxexhc7HH680FQerWRfT+m5UtLRaHJVdDS5HYSjtVrk09unMIBtJDDtIBsKWubTRG962bdoF0=
X-Received: by 2002:a05:690c:2a83:b0:6d4:d6de:3de4 with SMTP id
 00721157ae682-6d4d6de4266mr91396297b3.34.1725364998931; Tue, 03 Sep 2024
 05:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903-topic-qmp_typo-v1-1-781e81799992@quicinc.com>
In-Reply-To: <20240903-topic-qmp_typo-v1-1-781e81799992@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Sep 2024 15:03:07 +0300
Message-ID: <CAA8EJpp_O4B+eciQ9h8nPdiVxy4CTD8nE+WiYbDmUUSuhvwvMg@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom: qmp: Fix lecacy-legacy typo
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>, Konrad Dybcio <quic_kdybcio@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 14:13, Konrad Dybcio <konradybcio@kernel.org> wrote:
>
> From: Konrad Dybcio <quic_kdybcio@quicinc.com>
>
> Introduced in Commit b3982f2144e1 ("phy: qcom-qmp-combo: restructure
> PHY creation"). No functional changes.
>
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

