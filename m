Return-Path: <linux-kernel+bounces-252620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB159315FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1541C21A51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD818D4DC;
	Mon, 15 Jul 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bmpFt9Bs"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9B18C169
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051002; cv=none; b=dLpzGzA1BhZJAF4LpVQcJCeZmVRCBHOl/MUqELxO5Ut98rHl6UNtB79kOu770urWWqEo1CHNUhANLWSKv23TIjATNmMOVrkJ1DjmNNq/s39t71RvBNvIo3/EWG39c+0eVlHjYL8xrdqqOC6S0jOC3kV2Hany1udKVL73H1xy2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051002; c=relaxed/simple;
	bh=M8zigsqNJE+phkpqp1gyoQZJLxt+QNapc75xhNmetU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m292VMK04+0+B8qH8raQWlf4/geHBvJ6nQnYby9Y7OEyYraeJ86S7dKUPGpxNt4dz1FRaPy5/2xGbpRLrFZW+Ji0W/zRTBVtJdjC4xHQL51Z7aWlMhPnfsrsH9hN/RTxqdi0ZMkGL8GuQXZg2ZLLFoT6u9Am0CrY3FRXy/3owWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bmpFt9Bs; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3cabac56b38so2891519b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721051000; x=1721655800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeGvR/8lk6Nll/J3UVT9i6hjcln5jvzV7Bpthcn/O4s=;
        b=bmpFt9BstdyV4kcpMMeKdFxVkI/eFpmI0e1bKI8XxPmOtzoUa/Y/+PFgt07aEyqviV
         mlsTbDYj4uuye+0m5PuaGSjHuKuSrZRTEpC48/xhdxYOHePZLPQE/VmhmC9m5ialI5/q
         uflaPJGV0R2Kz4Lst07abcv0C8Nmfazrd5QKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051000; x=1721655800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeGvR/8lk6Nll/J3UVT9i6hjcln5jvzV7Bpthcn/O4s=;
        b=BigFONFN042/Qmc8HmB8ot/1DRUYc4mYRo4ZVbd18JikF+8Q+j/KvFRpwSpliI4vuo
         JANUWGP9uAq70PEeXm+3Wrervo6K3Q7fDVhDSa3OwfFa9AdPClj2Y4Wcf8HMMVOVXslP
         sHKQEo3Z3uqoAcmohTzSTyaLaJ2VDsz/zoxS7TwWouqF3jQHpsDAxeKW1bw0M29KgGD9
         P9TjeAb8Nfo/AVAGxXIGuz4Ruv51v1L9Xrz/i4YKWlc4EiEOhCYZYn2JctST6nIsOl1O
         MtcafQtzYkvr6Ts5/acXPaH3MCOQ+vPpyIQ7ORQkZcIixEeVRjQxcOsOG4frmvFjS7A4
         s2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVXuUvPPrsYpHK0rYaqhTdWv3pjBhlXbUHp6lHF4G1q5ccFUgGG610EAp7AIgQKPrPrtUkQ/QhLEHIFHqlx+uSDvCDqtBW/S+k+N3b4
X-Gm-Message-State: AOJu0YykqvfVD59KW+LZ62pICVyA8oQjJ+yVC++DOHWY2E31SDhcbUFG
	MPkjps4jbAi+9BB+3Hv7IDSjSTgOsEg33AbRpioc0EwPeC/Kc78tGxy3KA2svzXrP0xKwPrExeQ
	=
X-Google-Smtp-Source: AGHT+IENQDmSrTPkLdtpIhfrWC0qGbNJwLTI/NpHfzpM0XrIRYrU+lcgIxr2BlTeuj1gKhUaeArxaw==
X-Received: by 2002:a05:6808:308c:b0:3d9:fab2:d767 with SMTP id 5614622812f47-3d9fab2d836mr16259824b6e.20.1721050996891;
        Mon, 15 Jul 2024 06:43:16 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160b9087asm201727585a.16.2024.07.15.06.43.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 06:43:16 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447df43324fso489501cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:43:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKU4u/CDRnlkJOTaTCKYuK2qrLAIhDIi/0GVkfocaFqcB36gfPBBv4DV04DyQb6VDzwlvyqjAlo0qL01Vv+bpPxNMnaE1ggXMFofFM
X-Received: by 2002:a05:622a:2446:b0:446:64ad:ee91 with SMTP id
 d75a77b69052e-44f5a31ec80mr5833341cf.20.1721050996122; Mon, 15 Jul 2024
 06:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-x1e80100-crd-backlight-v2-0-31b7f2f658a3@linaro.org> <20240715-x1e80100-crd-backlight-v2-4-31b7f2f658a3@linaro.org>
In-Reply-To: <20240715-x1e80100-crd-backlight-v2-4-31b7f2f658a3@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 15 Jul 2024 06:43:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WLFohKUUFqsPrpRGCer_TPugoM8_Du6=7YcDywFfUkVg@mail.gmail.com>
Message-ID: <CAD=FV=WLFohKUUFqsPrpRGCer_TPugoM8_Du6=7YcDywFfUkVg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: defconfig: Add CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 15, 2024 at 5:16=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> This is needed for the display panel to work on the Qualcomm
> sc7180-trogdor-homestar and x1e80100-crd.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

I'd assume that this will go through the Qualcomm tree.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

