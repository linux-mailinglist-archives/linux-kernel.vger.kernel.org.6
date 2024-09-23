Return-Path: <linux-kernel+bounces-335624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1557197E838
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C611C213A4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2111946BC;
	Mon, 23 Sep 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTjHjh2s"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3198F1885AD
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082534; cv=none; b=KYyVhDXH6OfTtVznEGbQ863caq7xrqZq2PAsk+hHGC5oC4oZAq6mZ0uig+vqH6Lb6BTDFaL6wnhNZYBd6dWS9JUJRmgAQ57mUjJRn/DsVmIw+EF9Q+WiZcRA0MdUVGItue8nrpv7j8giySJgkyuHj5ndbg/Q5zq0bj3QnLMZ5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082534; c=relaxed/simple;
	bh=JELDF/Zw79oZ0FUIS2rLWoMNSuxFhGD3+cD8JeDI/eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsYV0Szq+W7ZgNELfex9f2po4Uo1021J1VOlY3BsGKZ2gNMlDwqlVWi8cDjKOzlIy9LcZxQpPDJQUNNTghWUX6bxAJKTRuLIo/pggCjE4nRFG74YVWqPjFn5l+cn0k5oEr9LwSMFoKdlxpaoTY9ufWyhdhiK5Sofu1a2m2JoVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zTjHjh2s; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53653ee23adso3541059e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727082531; x=1727687331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JELDF/Zw79oZ0FUIS2rLWoMNSuxFhGD3+cD8JeDI/eg=;
        b=zTjHjh2sMWoJu5owFEYbdlF+4UWLgteX9a/kwFOebMBVFAkyzWrdbET+h1rjkA8shv
         oydzO7mndNH1A3PvJJjPtScGFUJi/lg5FGllkwawkz5tZYhxp4crGQLOjZ1MnQVF/2+l
         a2vNArGW8Z0IISmFYUf5D67EJMvhrW7B8fPOa4OWTwX5rHdfLgI732hWcveOkl+25tj6
         VQYIgvG1vLhghsfbLmuDsuGpEZCaZ+P8Tym7K6U9WS+SO9kfKYsf/o0houN481hnA567
         wMmHlZP79Kx0IQT5yKRXshkU8sMtyeekXVdBy2rtz89TelrTwQbwfM+kKGhy9FMocUSg
         2whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082531; x=1727687331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JELDF/Zw79oZ0FUIS2rLWoMNSuxFhGD3+cD8JeDI/eg=;
        b=Nzh2+tNiLsPzLjTeG6gfRkXK063Z/d9n7kNL4SaS2Re1eKH6eX8j74VI0WXi+MRhci
         oSJgIpv4bI/+9fkcAKi6Jz0Kybakpf3Pbz4C8PwxT2LqUGvT2HU5JNWxNYFlDDP3qalV
         eTlSH7tFKVm2lDpl6iSCBkooeskV/GZA7w+liB2VUiod+GMi72Ov01hacevxClRP1mcO
         6tQssM7DfvHksBqWzOhiCJERIf57NoObZHGOHFwTeJN1l7x6Z1kJbZKyoPjMiu24Biy/
         d9424X1wMCzDTrTsAntJjqxR9XcHlVyE3vYqJbK967/bcHWJIpFKC+8Txb43Ht/AdQnY
         vYbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0ZnO0JbKu6qqvTh/n6qn/7wLm28V7X4qTcPqRtvS18FyVoJPtcAP3/YQElEs14D55koEhK/JIw2ME//U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpwyxVhjnrPBVPofGID3hFd6n23lzh7FOhNR0j6AfuGfTeQf4l
	JK4/g+6GZSco/np/NHHnbLqmPbdKVFd3rX4A4905eGGOk+oq4IxyfvQRSeZQICi29p69cpyu1C4
	H1YPlLv8Q1WnZoV1s5SQ1ygPP07YLx19FQfywZA==
X-Google-Smtp-Source: AGHT+IHo5OqAsBLecq0W7uEgoSonYeSP+z4Hl3h5JMui3ZaIwaomJwFKc1/L2fAHd4MtYPhb8fguCO69PRbjQ+Nc6rM=
X-Received: by 2002:a05:6512:3a84:b0:536:550e:7804 with SMTP id
 2adb3069b0e04-536ad161b01mr4635287e87.18.1727082531360; Mon, 23 Sep 2024
 02:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905020917.356534-1-make24@iscas.ac.cn>
In-Reply-To: <20240905020917.356534-1-make24@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2024 11:08:40 +0200
Message-ID: <CACRpkdZYnwbpqSLrxaOZ-0rbbQq7XHjznnCqOx1Pk=8kPiYL9w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: check devm_kasprintf() returned value
To: Ma Ke <make24@iscas.ac.cn>
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, maz@kernel.org, 
	joey.gouly@arm.com, stan@corellium.com, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:09=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:

> devm_kasprintf() can return a NULL pointer on failure but this returned
> value is not checked. Fix this lack and check the returned value.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: a0f160ffcb83 ("pinctrl: add pinctrl/GPIO driver for Apple SoCs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Good catch!

Patch applied for fixes.

Yours,
Linus Walleij

