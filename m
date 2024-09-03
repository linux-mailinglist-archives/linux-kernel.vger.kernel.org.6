Return-Path: <linux-kernel+bounces-312980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8A969E91
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31996286969
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF701A0BF1;
	Tue,  3 Sep 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jABeNKYv"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61721CA687;
	Tue,  3 Sep 2024 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368521; cv=none; b=YFoEU2DhH2rZ/nL/3U9pBT5ZhLWJHkt7NkqS2lAIBcMFTXycrfes+RVW3lq00kivvMebsX6wGghrI/5WtUX1GoldEC3kfldKa8ZZMDiknW+YBjbI6QfcU5Vn/2OdsHeG5qEGaBT5CO54zUFLVPVB6Q0Gs4P5tiLUjxfQSVHDBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368521; c=relaxed/simple;
	bh=51XZL1zpa9+ZugG0MuTKWPjrQIyg9Ca1YCU0ZCUyuio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfJ0/gnVFR/LIDquQTqAmww3GLzzD8O3W72IA7c8PTwqUGzcQbSR67ijHMBlLMus9lLUDWcgILsc/atL1y5+RjKSpFGmdM8RSN3tG6D+3Fyyq3NHyhHdqWsfAuYE04BGWuBz+Js9BTZdM0r9+iEmYuAEdVOMfCDU8jw9yElhCp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jABeNKYv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53351642021so5736897e87.3;
        Tue, 03 Sep 2024 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725368518; x=1725973318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNCoDBWiaDkhcsMePwXkrH4rh6xCaLi3QD6d60u1M0k=;
        b=jABeNKYvaj74uVZuY+nSaryNdbwJWJ72xUFBi9QDe8zEvzNtD5MDOz1hHqgNuz8S1a
         NaBBqko1PltVOTEUwNJvi6BpqP4JsVpMigHm8Ph2VIpTx3zVVeRMYQV5M4WoqUzSQl/V
         yds0WBEGZ4PQU+5zCZLQSqYXmASP5Dmpw2MFIQXH3l+q4T8vY2naWmtpKqh9BTvmPBLt
         BQdfbC6/CyemW0uFwYVk9YLZhN5GTXb/NcHw4bKzs/gybKBOFZe8EHGkCPVt7ELyHWDW
         3+GYNnTpYHkqCCC17WDpoKth0+bbNuvSu9onaRqZWVyvgS7GbROgW1SBB2vKYq1xCUgU
         cp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725368518; x=1725973318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNCoDBWiaDkhcsMePwXkrH4rh6xCaLi3QD6d60u1M0k=;
        b=n0oHckhsmbSYEM5RZu4xvxaYaRpyvojesh4BRcNgR5yZVMmabd8ThXSPGMgkH7Gt8v
         ycTBN2ie7ZFC5qufcU3Kxup9611AMQwmvp08e5fxXp0iHY5UUD2u/hEVtJlWJi67yzXg
         o3ogDfPUfbiUQZz25T7kuDkHIxMh696AXlUMkwGFMusehWHy2RSkw3rllOvb6H4Iwgj9
         vx2tw36m9KFy2CBkahzgcywoJ17Z3c39eQo04Y36P8cBdSwL+5jg6AAKf9THTUEEor6Y
         yVcgrUNP32jFUdR1UQfUM4QbMbqQ8U5m0nUmW3M20rOh/Qe/nGXG2fsmuZkAMbOrSXL6
         VLmw==
X-Forwarded-Encrypted: i=1; AJvYcCUx4m777DYi0T/pXKWFq8Ly8n2IVeksWFwfKgTb45mq8309iCuewiZL/svX5z8HPitucdmIhmkTOKZJYDKw@vger.kernel.org, AJvYcCX8s0Tp6XUpryGqfLJICbbUP68XcG2vobRZlOkf6wEOwYP11BcjTPh/cEjRBS5OhL5c0T7LK1ooXVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNiCRZL0F1R8Z34r4YT8SENfsyDdGOWFtOJvPYbjvgYQW9/h9
	+2MqFgxpKR/FFmqjV5GPcvmBJl8NsmB4BM04kyxgbPdXmqLjMQfWYyU28S3f+nVqxvYQe+4/oy1
	vaDE6vw2FT9Sfa6gBA53vC9b1zqo=
X-Google-Smtp-Source: AGHT+IH46cK4NeXPdEqmfU2Trxz2EWki+TuWP1ltUeNhM80T1XWTNZT5fdoKzGW1CXcqoGBpxBr6zBmSxc/j10SM9BU=
X-Received: by 2002:a05:6512:1047:b0:52c:c5c4:43d2 with SMTP id
 2adb3069b0e04-53546b910a0mr9807468e87.47.1725368517402; Tue, 03 Sep 2024
 06:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1725350397-19527-1-git-send-email-hongxing.zhu@nxp.com> <1725350397-19527-2-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1725350397-19527-2-git-send-email-hongxing.zhu@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Sep 2024 10:01:46 -0300
Message-ID: <CAOMZO5DsUdus8b6F+vz_g7+tZum9e5WPmFCg8zts7qDU6DToTQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 compatible string for i.MX95 HSIO BLK CTRL
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com, 
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, imx@lists.linux.dev, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Tue, Sep 3, 2024 at 5:21=E2=80=AFAM Richard Zhu <hongxing.zhu@nxp.com> w=
rote:
>
> Add compatible string "nxp,imx95-hsio-blk-ctl" for iMX95.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.ya=
ml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index 2dffc02dcd8b..638241f6749f 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -17,6 +17,7 @@ properties:
>            - nxp,imx95-display-csr
>            - nxp,imx95-camera-csr
>            - nxp,imx95-vpu-csr
> +          - nxp,imx95-hsio-blk-ctl

Please keep the entries in alphabetical order.

