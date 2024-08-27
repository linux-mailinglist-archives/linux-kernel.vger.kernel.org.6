Return-Path: <linux-kernel+bounces-303873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298196165D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9471F249B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DAE1D31A6;
	Tue, 27 Aug 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QIZbH10N"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50A1D31A8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781856; cv=none; b=BAD5vN8H+S2gmUGXLqH1wM4pyJmMwLiNgoBhtMbdmbsxI+59zcEuwf4F7nvmA28oFZEeIGIllCuU54I/mQLSf9Bmw8t/2T06TDvq3FVpwPb0IhJxjxEkCE0r+p5YqQYFHR0iZSlz9PjhMFT8p5vtfDHiduV13FxkUGz8SIdI32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781856; c=relaxed/simple;
	bh=dMLDKe44fCDwnHMVTWPeFlG+Xo4vnWXVI5dcdgD1bYs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAoqzf5LcSg9grnOIWCjcVB01+L+P+NFuASFwhRBcye72mOezwJPqZ9IXysOEKz9C5IGCw/iKcXwp8teB8aGBP2s9juM/ORZX1l6KkPi8h/22atM0ylME921iIVZyUBaATRddeYKB8DP5h32hHQ7WSzrwOQ0Oy+/o7gdEPdOFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QIZbH10N; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso5073727276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724781853; x=1725386653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMLDKe44fCDwnHMVTWPeFlG+Xo4vnWXVI5dcdgD1bYs=;
        b=QIZbH10NZHJZralFoSyn8LA+6zuUnsh7bTrPreNjKeczWRVIc7fZgT8tJu/Ld4V1nt
         LRdFnJ6JVHwX3RXh6g7KRn7d9HQMI0+ga1ao9LJI0dHnW4BL054RvD/rTH+6hvg0oXCy
         vprFaW5Gx0BkvdqmvZkAEe3LR2vVqUaJt3zww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724781853; x=1725386653;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMLDKe44fCDwnHMVTWPeFlG+Xo4vnWXVI5dcdgD1bYs=;
        b=Z6BQ7aPG3Q1VXthkW8udhzAky644PfzL4PrsKepPcw82GYQNJs0wRo0WUu+qt3Jth+
         sxdrNbDomXTjEw5vFbDukwt73H7EJ2hWVJdIyzATqDOUa6uz1H+TGxBuBk/lKukKgs8n
         uSUeFBOqpY9VcaNRCxKhOhY0RTz6DzJTel0PDT3e8JKyBYmcRkr4NRgL6GiLDJyoe8kQ
         1RazfVP7JCqhWFz3hej80++wDvG23KpJNw3u5KABaAbkE5S2ME+YyhGdJPzZKkG74E1L
         0M7Gf0+sSoPawPf21DVW3dyCiilakujGkUClWFElzMKRaskZmz2rcvder0JFEg3RiUXX
         CTDg==
X-Gm-Message-State: AOJu0YxGsp+72cFbf4gOhho3BEVfhV1Dt6XemqgjZDrJYEZuGTRt9LoV
	UXcB3V8oJJLxJdE6zrjDPjrXsf8fOGG2kJDaoTx9yZimUpqJIwtjUgFM8iqnemtAa6VkK64H7Vv
	D59TX2HWmPmoOmxEkLRV8WJcpaVtIbhiEp1LWwOSVLGUSeq0=
X-Google-Smtp-Source: AGHT+IE0Bn9i/bUKuhoTzrKG4rVSXstRxEFMj4JTAl4ym01IvcLZrTD5rOM1gwCNkQJJ0jrFSUsDnYcxg59QUJYwibU=
X-Received: by 2002:a25:dcc5:0:b0:e11:7588:3329 with SMTP id
 3f1490d57ef6-e1a42273847mr72517276.7.1724781853199; Tue, 27 Aug 2024 11:04:13
 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Aug 2024 18:04:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240819233628.2074654-3-swboyd@chromium.org>
References: <20240819233628.2074654-1-swboyd@chromium.org> <20240819233628.2074654-3-swboyd@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 27 Aug 2024 18:04:12 +0000
Message-ID: <CAE-0n52xg2ts9dm4cG1CmevrD0Gn8d9x+VvK8av8Fn8esoz14g@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: qcom: gcc-sm8550: Don't park the USB RCG at
 registration time
To: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, linux-clk@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Stephen Boyd (2024-08-19 16:36:27)
> Amit Pundir reports that audio and USB-C host mode stops working if the
> gcc_usb30_prim_master_clk_src clk is registered and
> clk_rcg2_shared_init() parks it on XO. Skip parking this clk at
> registration time to fix those issues.
>
> Partially revert commit 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon
> registration") by skipping the parking bit for this clk, but keep the
> part where we cache the config register. That's still necessary to
> figure out the true parent of the clk at registration time.
>
> Fixes: 01a0a6cc8cfd ("clk: qcom: Park shared RCGs upon registration")
> Fixes: 929c75d57566 ("clk: qcom: gcc-sm8550: Mark RCGs shared where applicable")
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Closes: https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Applied to clk-fixes

