Return-Path: <linux-kernel+bounces-275936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789E948C2D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8582C1C228C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D6B16B74F;
	Tue,  6 Aug 2024 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aihYQ5QJ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5941AAC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936656; cv=none; b=A3OOisfg8cKQ1LgmvgNbJ7wINCbPH7BM4fUTWdQA35dVW0jr3OIIoGDdPA2xCu69KmD+YCBIySsw6TB1u6cDEBn2lyl54+/j38IFx4W4ldOIipU2HYjVy10saT2l6PQD/b5EKOcAIVmCgEqowy0jEjUCmP4ahNNYQDABkYvNcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936656; c=relaxed/simple;
	bh=+ryfO0tZc+4WojbWKaDSaudajDQqeCAZJp25hBEXjbc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCEKHyrAQctOGNIbfLdAlgse8YsVNJLD7IKHewfmL/K4hBXSk4q4t4UFFk84XDSXF9ttwuIy0WqrdxJ03w64RxhCZVqTP8fz1lKoHTPmkO+W+P85y0GcvMyOSehLp2w3ALU3rc1X5ddvwg/oKNWsOMjRD/CYVK2fQhwzQxOLLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aihYQ5QJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7AC8940637
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722936650;
	bh=xwD+Ys2LZNp5yQhdRMErgecrdX9WjVd2du/1YLfTqdY=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=aihYQ5QJz/setCWN2Gf0wipG7GFZ4243XjEzkLasb00kQ2xwzpBnbD5PStxVLstRo
	 I06LzJbuqDYtWcTQ7c3jFopWXovmuj4a6GpZiLrlqD/DYqn6Esmdlakf49HeZ0N9y2
	 /QTYBG5QVUXEwGTSYwJUjJb/PL6lnHRLVYWa7dOxT9/gUTeetuj1jteXd1DR5PEknq
	 T+kQlW5G756ukoHIjEVM12hCuWcaReKSt4f72iIEVQ0dTzeZVfmLsIzrOz07TVnrB/
	 rvhs0QeJVu1Y+IIgbadrO0VPGw8YXK190HyFdEOC+DHmyUWJH6/YgkaLklu9Xyjk49
	 JKutQZHQyWMEQ==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44fe49fa389so5223441cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722936649; x=1723541449;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwD+Ys2LZNp5yQhdRMErgecrdX9WjVd2du/1YLfTqdY=;
        b=UMOFcHFs18vo0RyP0QKY9aCB3cqAeZU1hYyWCmFStcyMMrcb2uWMYSn0ZIxy/atJwW
         R2Ps+PRd7uAAc63qCZQs3OFQYUHCqyMJhwQ3Ry5JS9Rv8mQPn6TWuSGG+WeFvH/dV7z9
         twpPyn2BJO7EWLWsSjzOIVjvxZd8OCPrycH5CjJiB7goaP4q0XbvtjUyjuGuCEpAhM9I
         9o7Z7QhvWhR25kKMTmY0lXeajbvb8VDCGn+NSAqZc6/UKtoa8yszYGW5yiY88GFwJ85h
         TcPOST2MlkTOY9phyK6GCO2Lqi6eY3UZFYwvVD3g8y73WfVJuGJKOXXP4w9Eo4sljcMH
         LnPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpIDpg5URvT3VyOUe3Vq72PzuZr1IXwbnUeuSHvZ+Xhw336LrSoSzZgrAV+fN3mtktALKGnFwX1o4lzpJKrM7XxSNYYUkZb9Rm/wRJ
X-Gm-Message-State: AOJu0YzuB4ygsibemfZIYQkEI0ejcOls4LsBIspFG18YNY03ieqO4Erx
	1yQZVL2qaRfYSJDYgUUND6kTyi+PHZEYxQ9F9gLHtIwJSwkdFrb7KvvardfMLwgyRCxiNv9cWnV
	aoJvVJHCIKkVIfYtN83eHJ0AKN7F3GnBOvCmyUIImezgIZUxTuBsiQi1WWhd7uk1qQOQJh0hgYQ
	23d2yhBQ3B3DsbRx9PPaQ5LbuHIjW9ihLQQ/XT9VD926kmxrGZMqkS
X-Received: by 2002:a05:622a:1914:b0:450:4788:ac94 with SMTP id d75a77b69052e-45189288104mr192145001cf.16.1722936649456;
        Tue, 06 Aug 2024 02:30:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHCqUjdnFHutaVI39WTNoHNqS3Lby2GXNCQz+gEOH6cNBzePyFMzSaeUFOKPFqist830dSYJL1tqS7fnzHPFI=
X-Received: by 2002:a05:622a:1914:b0:450:4788:ac94 with SMTP id
 d75a77b69052e-45189288104mr192144701cf.16.1722936648976; Tue, 06 Aug 2024
 02:30:48 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Aug 2024 05:30:48 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240805023320.1287061-1-unicornxw@gmail.com>
References: <20240805023320.1287061-1-unicornxw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 6 Aug 2024 05:30:48 -0400
Message-ID: <CAJM55Z9_sDT2wUy-GMT=mi4FcWth-O_LUbmVtbdZRipQrUzh4A@mail.gmail.com>
Subject: Re: [PATCH] riscv: defconfig: sophgo: enable clks for sg2042
To: Chen Wang <unicornxw@gmail.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, inochiama@outlook.com, conor.dooley@microchip.com, 
	guoren@kernel.org, emil.renner.berthing@canonical.com, 
	apatel@ventanamicro.com, hal.feng@starfivetech.com, dfustini@baylibre.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, haijiao.liu@sophgo.com, 
	xiaoguang.xing@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Content-Type: text/plain; charset="UTF-8"

Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
>
> Enable clk generators for sg2042 due to many peripherals rely on
> these clocks.
>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  arch/riscv/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 0d678325444f..d43a028909e5 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -249,6 +249,9 @@ CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
>  CONFIG_VIRTIO_MMIO=y
>  CONFIG_CLK_SOPHGO_CV1800=y
> +CONFIG_CLK_SOPHGO_SG2042_PLL=y
> +CONFIG_CLK_SOPHGO_SG2042_CLKGEN=y
> +CONFIG_CLK_SOPHGO_SG2042_RPGATE=y
>  CONFIG_SUN8I_DE2_CCU=m
>  CONFIG_RENESAS_OSTM=y
>  CONFIG_SUN50I_IOMMU=y

Are these all critical to boot or could they be modules?

/Emil

>
> base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

