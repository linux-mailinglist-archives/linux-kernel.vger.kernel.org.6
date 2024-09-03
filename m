Return-Path: <linux-kernel+bounces-312922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AAF969DBF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB20283514
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6E1C9851;
	Tue,  3 Sep 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1FTf6oU"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8D1D86DF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367076; cv=none; b=Vny+buc6vYHwDMidPuBQ5oocCbrpDSpvwxhBcEY8OQorJiTMyJtARz762NT9X8pU9P21BUOHU9AA+jB66hLQSHRf5jKIoGNzDitNpJ8Db8wAuDB60BamAn4Mq3x2eBVa8jblxqbKh6gQus+m+DQUBVNd9uF2TRJybuJdl9c5yjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367076; c=relaxed/simple;
	bh=B9GQaZHEH+VhKCVUh+CkMNjIC0n6Uvue3Y1ZCqmBrTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHyYYD8yFwNrtvJOjzgvKfUzYTAfYJVi0dR8Ai0A1nFyYbmXfskeJs4f07Jg8KrvxkYpJ+sFiRbmqqN7TR6xJ0xNCxHmIJFW5a4YZLXHKnBkXr+R1hCfldoRUfPVeDvu5SKXYug4IUVyD2MiSV2nvpJKn4wn/59ztSZl8rmEKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1FTf6oU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a989bd17aso2837171276.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367074; x=1725971874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnaiTsQJeVNyMyP3bsJIPbb/u/YgFuRtKmzebQGwg4k=;
        b=p1FTf6oU/nIanxYl6Iqq1YXkhSc/Tlh3l0Z8M9zIAV9k+Z/r/aG3GUXaMfVtK4Cift
         BgFfqOsN6uEFVkSrVQMtxOlvSQGo9m6Pd/q4mvcNYNnPQSYpX/syJqIVkL0n++P2niCV
         zZ2RMgoa7KwplpGxiVS4ykLQap+YiVcZxaxLpWTgQWXe2rD0vb10zBVxp+ApBUjkpYdk
         PMmkVEHflXrkn+WNR5oRybLE4nroZise+6t8ES7fTewP0yC36KDtJuKPfAh2kzm7gD5W
         MtYis8PsV85o2H+1jWSkNjK1x+BskTntWSS+T8dQbxKJwawI6G5qNQ0hkdtQq/3CCIOb
         rQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367074; x=1725971874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnaiTsQJeVNyMyP3bsJIPbb/u/YgFuRtKmzebQGwg4k=;
        b=EZ6BjLP7eW1j4/eYFIecqrxh2PrXNY0V+RJ5I2yYVgHy3ouatZz5popZYwzVr9z4LW
         USv8z02GHrblCHcFsCIAThrs1tKgkNFZFeuPDvrVadG+si32/iCncGJ8SAN8sbtEBdib
         0pQeCqGuFrLb7BLMNoXlhAk6KcvUw6w9I6FK98fh3roPHv+g3XZCvJKYhAejJR0Xkl16
         VuuE7LWs7bDxpCFPC877dhEvIbLYFrNaSqE5eBO2Ut2Mq/jfT3JXoEPS7F2JWStOkuvy
         V37RLH/xQdb8DcP6XCRVadNtPLueIbaudj4MeGk0610wwCG6ebpdB/WJBXvXvImDccOp
         SqCg==
X-Gm-Message-State: AOJu0Yxsc6FN74+u1TBbZ8f0S+1n1JMT2ewxfK2NzQ57DuP/jbPcuEr/
	RWadqIBHxZFbPpdQ3DC35SuT4vtYgJKvTW7Pu9ivBczy3iJgy6hrhhEjiUvAJj3JBiEIoALnxw6
	nksmzFBCt+7QCNuxNqQAgc/IxzzmxzygSLkRvLw==
X-Google-Smtp-Source: AGHT+IG17HynGU3mjtWr4zoUdmkHjFCO/zDNCMk5KVQ8L8Ku8TSYbAHSHm4n94LAVjR69BcrXhgysMejjLj105b0f30=
X-Received: by 2002:a05:6902:150f:b0:e16:6feb:e615 with SMTP id
 3f1490d57ef6-e1a7a1d2633mr15093173276.48.1725367074096; Tue, 03 Sep 2024
 05:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240829061842epcas1p25b97a685d0946c360338adf716bfaf2b@epcas1p2.samsung.com>
 <20240829061823.3718-1-sh8267.baek@samsung.com> <20240829061823.3718-3-sh8267.baek@samsung.com>
In-Reply-To: <20240829061823.3718-3-sh8267.baek@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:18 +0200
Message-ID: <CAPDyKFonYhKdJuFN_v=S-MCyRHUJ8015fxuJ7xeG7jQtX-9xCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cqhci-core: Make use cqhci_halted() routine
To: Seunghwan Baek <sh8267.baek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ritesh.list@gmail.com, quic_asutoshd@quicinc.com, adrian.hunter@intel.com, 
	grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, 
	dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, 
	cw9316.lee@samsung.com, wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 08:18, Seunghwan Baek <sh8267.baek@samsung.com> wrote:
>
> Code to check whether cqe is in halt state is modified to cqhci_halted,
> which has already been implemented.
>
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Applied for next (and by amending the commit message according to
suggestions from Adrian), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index a02da26a1efd..178277d90c31 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -33,6 +33,11 @@ struct cqhci_slot {
>  #define CQHCI_HOST_OTHER       BIT(4)
>  };
>
> +static bool cqhci_halted(struct cqhci_host *cq_host)
> +{
> +       return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
> +}
> +
>  static inline u8 *get_desc(struct cqhci_host *cq_host, u8 tag)
>  {
>         return cq_host->desc_base + (tag * cq_host->slot_sz);
> @@ -282,7 +287,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>
>         cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>
> -       if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> +       if (cqhci_halted(cq_host))
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>
>         mmc->cqe_on = true;
> @@ -617,7 +622,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>                 mmc->cqe_on = true;
>                 pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -               if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
> +               if (cqhci_halted(cq_host)) {
>                         pr_err("%s: cqhci: CQE failed to exit halt state\n",
>                                mmc_hostname(mmc));
>                 }
> @@ -953,11 +958,6 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
>         return ret;
>  }
>
> -static bool cqhci_halted(struct cqhci_host *cq_host)
> -{
> -       return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
> -}
> -
>  static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
>  {
>         struct cqhci_host *cq_host = mmc->cqe_private;
> --
> 2.17.1
>

