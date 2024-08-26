Return-Path: <linux-kernel+bounces-301096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1595EC51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170F81F210A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83B13D276;
	Mon, 26 Aug 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8zbRTMK"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989F13A26B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662110; cv=none; b=FsIs/0RnMGcOzVmXsYg26RMbqdo6GxSbXQp30KW/Lw1q4G5jPJHaMMhlnZGQ0uYCTOPId5Yhj5SIFFS8yH8B96cVw4Dab9R+XMcwzNtnE0JF2s4zFOuduDn+hzgb/Do9sNgreKEDxW1DI/qDYlD0T377uUf+aHKNmMkz0EQhLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662110; c=relaxed/simple;
	bh=2hnjvVAoZ7bwbquiwr7BPEkR48jyp3TjmuaLIQPgQ/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myIiqY7Nk+TY1QvP3kIVE4cKw1DZhUGAoRWV48lE3NAIAXx8uAVqwoO+OF1Bvfr4prFudsD+CbXzRyq2KLeWXW2bqulQJnvZ7Q7yUNUD8RGyOSOuid32J7+o2RtZfwdSFN87FbduVPqJOon5JshLCWIJ3/4tNVCxjhzawZyV/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q8zbRTMK; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-533496017f8so5428225e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724662107; x=1725266907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hnjvVAoZ7bwbquiwr7BPEkR48jyp3TjmuaLIQPgQ/o=;
        b=Q8zbRTMKK45g+Q34lEp4ykV3Sa4Y7y/pGePjQ8RYhH8TkY7r+lBUni9BIt1SffNvQL
         CIcTULPIK9PUdqXI6ufkrn7RiQHaiDXVyFPn9AEj/afiTmCG3PIU+X1ueg6mvtqE6M7E
         26pjj5uGgIT+AoLFk/1F4PKdPPOQHoghYXIkS8U2xhvxCBAz00TCkCiI6uLacbBaHBwM
         O2G1JdFy4jm8bplgkEBfHPn4O3qWII5b0Jqa09gVCb06oBgwU359HrG962qPpoQ9QOoL
         3dOZxm2IZT+p0y/cBPpEVAJWELPYWNO4UNU/U4Y7eA7j/9I1F7/u1MA8giVNjZxfD/Mz
         P8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662107; x=1725266907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hnjvVAoZ7bwbquiwr7BPEkR48jyp3TjmuaLIQPgQ/o=;
        b=dpToM35U/s29kX6nnWNwCgrpwgVWJu5fS/S/b6mizla0L7buf294amEsFA6KUMEhSo
         8PdAev3Efq1rk/r6SIaiDErDOn0hxBYGRTeeerxlVhWDAkb+9oz1z4N/wqLcmXgvP6/H
         sxnkeRPKWrrNsI+DemgnzDber6rzv0wNDXv4GU4CrOkZ1QnEv6FaukQG0adKrTuopENA
         Anzdk+s+EBXIn6by7+Nf2U6VbPMVxahQKKoAcoIl3mKZZ1w7FZOX5uN3IAJnSWPuPKc3
         5LmobqDFdNDL0Jd0EKTelm/Gtd7uZlFwfZL3Te6shCekvoXLTcQQJTWzMAOWiYE9YVMk
         w0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlssIoi+CG3ftaHSg8IEQw1AL6MMwvCdQ8DPscEgHqxQ8jKejWxxFjWBjjVY5+sUA6uNeRQM6iNnETpRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ESjGWc2Yjf77orY0uWH7q9+m19kIGeR6gmvB4PIRBUloNrz5
	5wpWaXn/AGXRF74Tybsh3g8GDYqIdmJKFveR4a7CJljM73XsAKSz8UJu9kMU5bP4ckeep3oGX5C
	U/lHm5pVmjDPcGJZg2BzFE9UKX+CVbkkQGVE2iA==
X-Google-Smtp-Source: AGHT+IFZerPWDOgr4c1WuohxSQ3+JvT1ubVNndAVMth/RrtYH7UChyTMrjQo7sPYZVdcATBDZ05y/rcKJPj98SHVq10=
X-Received: by 2002:a05:6512:3088:b0:52c:9e82:a971 with SMTP id
 2adb3069b0e04-5343882d1ccmr6349398e87.7.1724662106426; Mon, 26 Aug 2024
 01:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823105421.50017-1-shenlichuan@vivo.com>
In-Reply-To: <20240823105421.50017-1-shenlichuan@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:48:15 +0200
Message-ID: <CACRpkdb+kfRZE-tJWpxsmYFCzLhnJvCjVtmwrBCAFHbaXVFHXw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: freescale: imx-scmi: Use kmemdup_array
 instead of kmemdup for multiple allocation
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org, 
	ping.bai@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	opensource.kerenl@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 12:55=E2=80=AFPM Shen Lichuan <shenlichuan@vivo.com=
> wrote:

> Let the kmemdup_array() take care about multiplication
> and possible overflows.
>
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Patch applied.

Yours,
Linus Walleij

