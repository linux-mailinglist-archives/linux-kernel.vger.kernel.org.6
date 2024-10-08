Return-Path: <linux-kernel+bounces-355920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7439958EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CDD287305
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC07215F64;
	Tue,  8 Oct 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ukTCt9R9"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9955213ED6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421710; cv=none; b=mNboyEDjXApKbZeqD6RlM/1rYwM8EmkNWfWht1jmkIfVKL1Mof4XvObHMD9OJvovudoR+BzoSeUiL1L33xc6vgxo7+7E6hTuog/nFYEQdUyuDSAnovdcBHGXgib4Vej012uqrsTgvQWFra8wuQFaOKKNg05IQ/KIArrlKbmm7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421710; c=relaxed/simple;
	bh=MnazW0czy6QsKx0VD61wzExgH7uM2nZ2mt2atrzIfnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ozh9G42q68UDpFiS/Kze8wJdLGLZENJx7yy3GeybSg+N83xLq2IEtDDsHJ+TLusMcOHXu/6eKsOkcBJ9saj6Wv41iZbrrS8wlL/+Ue79zyzhisNQzlRB1swJt8nnqVyxtu5A1LBGa/f1AwlKsrfFQOZ/LfPZdifmw1uQ0Nu9hEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ukTCt9R9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9939f20ca0so571978866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728421707; x=1729026507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sE83pFCV26DOjSccPxtuo+ZxnLJQRJXe4yNALdDcOkk=;
        b=ukTCt9R9BmfAv6zYQ+X4t29fue6HkNXpD14QAEBKt8xBlygAI/qoEnqnS2c16qI6q5
         sla7vbh1xWNam4wLCAwjcbeFqllAyLqm9ZUmrpE7pGHsU/VH1Qbrj2249LJ1NJOSKZEF
         eWZsbYtNM1GDtjakn+oFzOZSCoyCubTYaKyan9VSoTO4MwAEBNzvSDEnWKQ7b+xVA0mv
         W2TE1lxwWHHmmhERSX1p8oWQz4Yp1MubU3xYAJhQr1QPHW/9BSrwmV4ZlPbhF5pIsrG0
         M+WjLILEL99ogBApLKP25vM/buGAq5yzUFNm4loHpKqQpCDHr5jNaIyFLx/IR+3AkXDu
         WJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728421707; x=1729026507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sE83pFCV26DOjSccPxtuo+ZxnLJQRJXe4yNALdDcOkk=;
        b=sAFAtP+2wahJnwRUTX7Jpp2HtDzG7feXK9k8qSy9rMPJFXCDey8jK+iJw8J1oW2Wnu
         LJWnrEqQX+NzATC86UIEnA0XjEgVogJMKdTUGbOk1Ai475FwDsbKfPR8jDcUBvWZB87/
         7uti7Ma/TGc2sVgZPXKfmktnuDSSmSaOfUxkw8W6p8EH5kYgBtDqAwi4K2qdchzmA/E6
         k3Q6sBwFjoMR+COFpAxqY73Lbp7Xo2UmZdEupQt3PYoaAQbsugh+CETC8ip8+DvzOjHo
         aESw6NrAckPsaxyAvlkpSeHM0wAkgPQwEX8krE/SxvQwC9o012R/asJv9Z1EVekpQjFj
         /+gA==
X-Forwarded-Encrypted: i=1; AJvYcCVG1nsGCpH0jfFh4LeHUXP1BTomc+bwRYh/NykHDwO7rxhzItJZi8jt7PHF9xBk6UTGjAwstqCzVUyc+xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziX0egFymh42hLbB7CZOO9SdJPdm40Uho+NYF2PCtU0Jx5wAT3
	bBbxwtcXKnA7M2/X1Y76GCraUX4Rab01XD8u0DVLrcI13QInjaEOVJgvfXGo1XO7cVE5Jwbw6dr
	E9M3YQ+cin0NZ/7HqjSRzMY83gSkUwYF/HeP3aQ==
X-Google-Smtp-Source: AGHT+IHqVitJqVh91Dw21ceGsoCsmpbMpD1zYOyB0xs++neKXZuOILxOMEPnjGNDkBYWXx0j6dth0ALd1nftkjQkH94=
X-Received: by 2002:a17:907:c05:b0:a99:7bc0:bca9 with SMTP id
 a640c23a62f3a-a998d11f6bemr8789666b.3.1728421707232; Tue, 08 Oct 2024
 14:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003211139.9296-1-alex.vinarskis@gmail.com> <20241003211139.9296-3-alex.vinarskis@gmail.com>
In-Reply-To: <20241003211139.9296-3-alex.vinarskis@gmail.com>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Tue, 8 Oct 2024 23:08:16 +0200
Message-ID: <CAEvtbusLQHqa-3RKogD9CquXTyZz6UZgWjf02SnMBW4F=8cZnw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] firmware: qcom: scm: Allow QSEECOM on Dell XPS 13 9345
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, robdclark@gmail.com, 
	peterdekraker@umito.nl, Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Aleksandrs,

[Again in plain text]

On Thu, 3 Oct 2024 at 23:12, Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Allow particular machine accessing eg. efivars.
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 10986cb11ec0..2495c08a52f5 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1731,6 +1731,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
>   + any potential issues with this, only allow validated machines for now.
>   */
>  static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
> +       { .compatible = "dell,xps13-9345" },
>         { .compatible = "lenovo,flex-5g" },
>         { .compatible = "lenovo,thinkpad-t14s" },
>         { .compatible = "lenovo,thinkpad-x13s", },
> --
> 2.43.0

Tested-by: Stefan Schmidt <stefan.schmidt@linaro.org>

regards
Stefan Schmidt

