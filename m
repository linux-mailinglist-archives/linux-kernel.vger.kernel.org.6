Return-Path: <linux-kernel+bounces-242483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A409288AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC59B286849
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3214A08B;
	Fri,  5 Jul 2024 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbj2Kxom"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055C13D243;
	Fri,  5 Jul 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182432; cv=none; b=kboTJpCR/hdgbWKLkrryzz8jLZZj7cOGdn/0h8auwzaW69AYMyUk589HlIhUchJzywhyU9QnIwMXUE9dCMW5GyfYFOchhXNeZQISoNrabEusbF7HXixcdo2/QpLmSPcUFlrFCtAowxlpJWeAXl9dIxvq5uH5GjMrii7tZFp1dfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182432; c=relaxed/simple;
	bh=sIWevVUKkb7FOCasj7mQTl9nMdE+rJH3P8UkJXqyiYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMh95qMPjsKonBSn068C7JPKA45LGHc6pgWxyMsUnyxFWC5MbeuYK//Ay61+FuZ+MWvXNX/ajUTaC4hFnRe348FAda1u7MI7t+z34oQ4ONcX/kwI9hUgBKH1KjbW90FqZprUHDCOW+ETDM5te+OWCeWty33mr0LYPRQ3564JSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbj2Kxom; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee844bb5d7so2487051fa.0;
        Fri, 05 Jul 2024 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720182429; x=1720787229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIWevVUKkb7FOCasj7mQTl9nMdE+rJH3P8UkJXqyiYg=;
        b=nbj2KxomoIf1w0Ft8nqQRzefIixtER9pCecqC9JwtdOZxFfik/ii+P9J4pE2ydEtw8
         UJfx97toyH2fo8V7g8xccpQ1HIE2gQDPD4XgXOOc89qPrus+a/UlU79cdPWRVdVbRNcx
         p8VQ+DnqG6uwSTWG6jtc7J/rVkOKx9R4frJN4IfXm6Te8CSIsiL8zr95QpLOfG6pctl8
         DR0hYdyQLCKHExA8krfU3fkWiDyie1jggyfP3u9I3PJGU3QfSNE37lZMUfmP4qOkdS/R
         FL2WU+X98tUKCPJCzEpURqkCNzyaKz5K8KvJt/yt5rOvcqak1X0arMie2bY7r3OiHI/V
         BRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720182429; x=1720787229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIWevVUKkb7FOCasj7mQTl9nMdE+rJH3P8UkJXqyiYg=;
        b=gYg7Z6MnnPQqQw0DCEDPrgvZZFez3kOQKrrTJBOlamjOxpENMbjjYkyPzW9dWBxnRR
         AKiI6iCfVC0zufKaQQI3kNNxlw7fsr6YHXRe0FOmgXcpesDTLhClUxOUmV+F0ipIkDfE
         yVMMK6K4+1QABzsv7rULLXP19okcKVeh1/ht3GycJ0sFhKNaIcOv/B4DIrgZJhjGGJLR
         6fHnAQAWCs5fZGaSDBBrqIrc6dJTibLqzO4llvub39nkTZscsMZAKVZLMuV6Y7eDGvsA
         RjffSeto/eIlorFbfw+rrH1CoeXuAnYPOffvcUjZoGK3h1YNNrBXWh7UGk8BTNw+CpOD
         pOVA==
X-Forwarded-Encrypted: i=1; AJvYcCX/hPMFXEaSImiv4F3Xg4tYodhyktTwO3UbsEroDpnDa2ihjkZsfbBHHYWO2SyrClCBILw9YjJlI1MvaEsi9iFK9aLYTAqGOhOlR00ebJuTzZ0s1wjKFjgZN3shyHGycjB+Zj35P8/3ug==
X-Gm-Message-State: AOJu0YwVekKh5xJ4sCRSPwUBEiXfpL3vReZVofIfSQFXAH/wLfbLF343
	x0zx5oOAE9+Ho3g70ea4G6aChOKIkGbMOkVQExPDr9sJ81eARtEn16SsmA8PifU5+SMZvlx6Xe2
	w2hOPA3F+F6m/GDFR00fEo4wF+JJHAw==
X-Google-Smtp-Source: AGHT+IE8OV1AeVxu2SX0O/PkjN0a38BZTc66Pul7Ij78t5Gphi3uH38+dmdzatGgs+bEAS/I8hEOBqE62yBpxruHbxw=
X-Received: by 2002:a2e:8183:0:b0:2ee:4a99:6a3a with SMTP id
 38308e7fff4ca-2ee8ed9589fmr29383411fa.2.1720182428647; Fri, 05 Jul 2024
 05:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705-bspimx8m-3180-v2-1-dc1a7e1689be@phytec.de>
In-Reply-To: <20240705-bspimx8m-3180-v2-1-dc1a7e1689be@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Jul 2024 09:26:56 -0300
Message-ID: <CAOMZO5BEHoAycqQehddA_d03nrKkNnbcTAkq=VXww0d6HRHFdQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: freescale: imx8mp-phycore: Add no-eth overlay
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	upstream@lists.phytec.de, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

On Fri, Jul 5, 2024 at 9:14=E2=80=AFAM Benjamin Hahn <B.Hahn@phytec.de> wro=
te:
>
> Add a devicetree overlay to disable ethernet for boards where it is not
> populated.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Changes in v2:
> - Remove the compatible from the overlay

Reviewed-by: Fabio Estevam <festevam@gmail.com>

