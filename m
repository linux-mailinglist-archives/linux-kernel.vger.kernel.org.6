Return-Path: <linux-kernel+bounces-421431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515829D8B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA16163EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0A1B6D0F;
	Mon, 25 Nov 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="grBbqD6t"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74879192D6C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555164; cv=none; b=Yz8nlpw9BToUbedUaA6PF0rylEDaZVBkHrZVDBZxgDqSxC/FShWfzw0opzB3KVEpYNn6VfHErb0uLnsbddbE2f2k5XoEbw/2+o+vnJhl8NqrpjqfFUwW4FKEnvo/PQOSlVeT4FEjgvwYuKMVjHIBjomkhoVnhD5gBul3inSXhgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555164; c=relaxed/simple;
	bh=TiUNDOaFRB1I0ZknfKQ4oNwpmZSuTLCus9pbIcS9U6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjtRvz39eBTGuybHMbJ4z/SFFGX+FsPozX3iWwpmQT37EHbc0jez+6WK3pMVbBtoOdk1Ug/Zdz2RPiJiUNfZnNROZpG0avrtkL3DOrOOPaIDcLUVrrIA4Qc7E5TC/fKFLhzKxYZUBiKf4TOONhRFfXnAhgBryH33DAZ1nkc95AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=grBbqD6t; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffba235991so15272521fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732555159; x=1733159959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMzxcC5wsaZiCOOJDSmAWDv3eoVe+TCnixOaVa1nGDY=;
        b=grBbqD6t/EAQGWREj5VLPmoDIO4EqiMefO4LYW1tgV3I2XEYakL3INQklpYGQThE1O
         WLdhapOyd5TT8w6r0v9EV0/2N9GSZXy3x34IR0dTPusJTQS1osFfVyDaMZC+e+zvc6yA
         t5U6F+u/SuN0uEQR/sZ70+n0gLM0m3UzKmlas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555159; x=1733159959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMzxcC5wsaZiCOOJDSmAWDv3eoVe+TCnixOaVa1nGDY=;
        b=Ce0wyXBF/E4LfmJp06AubR+4cA2OlsPnbC5NdO+12y65Utw+0ipuoWO5GXUNUkRFAm
         q70aTz9H30ttMHJ8uRJhCxDYLhhOfIEBCiJllXYx6EZg9SgHovp/sd8Xa+MiFPB4PZDU
         HjnHXrHhurza7uLGCuPkClbSBBJHfa/rqDbT/9H9PHMKP0ALAPAuVUidsQ5WdHHwsLWA
         Kv9oXHvscVEes9+2wC0OEakw9jWi6RYsrT73t0ZwtIH98PiE2xThV45hgtamab7HXsA2
         /y++XTL2/SPPSa6qS8cVqAb8KvIN2GPL2jtzudWtIUNSeWsdeNFYDfbWP9vR8BNj9/MB
         N0og==
X-Forwarded-Encrypted: i=1; AJvYcCWLmisgvXtNl4ZCs4s45Gqmha14Htle9QO5qHR7nhZanZb8YuKNAn479D3kBXusokmBbh9OIPXVWu+jV84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHX5MuZoq+gGscIXpHZYMAamv5aSCO2VSHGWKoqRodlmn0D7q
	gacNjAIc6sPvV7XoZGXyuamSxjkx+rFzAJjgVn5w7vGJC8pDB7sSzzPEJnMNwnhAoOgSdmBrvOQ
	=
X-Gm-Gg: ASbGncsA/DXa0L/M5IW4pVATOY1zDBqLSSU/E++cnK/jV6XmXHcP+v+WLPdxKSVcD4c
	Md/SgSTCvAxqfv7yB0i/ylhrP1bugdc4m75mLGg4Q2sTUuQvHRmLgZr2FcD6EdFBKUL+elEdkbM
	8vPA2tFm58GGggBNm0Q/RYCGyD1ppctva+uHd1T/+V0yJaWRXN4GZgq644A2+n/pwnEg5c7jdAJ
	GBRP2YLt4Ef7WyKxNsZv3jYOgZlaAHEnppv5sQrPAF9H4F03hJI3TAGq4LmQ7AlhZy+Ku/X3X0Z
	QK6zFbuWvhOU0Q==
X-Google-Smtp-Source: AGHT+IEPQDVsb4NbYgC11LUHRYx4RCXQGIEiodn8HrIJjT+PClLGGh2AFIws22sZlU1kwEJiVb8sIw==
X-Received: by 2002:a05:6512:3d93:b0:53d:e5fd:a431 with SMTP id 2adb3069b0e04-53de884b61emr53544e87.19.1732555159592;
        Mon, 25 Nov 2024 09:19:19 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24459casm1728020e87.51.2024.11.25.09.19.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 09:19:18 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd668c5easo3264650e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:19:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuASKkwwXy2c18bwg9WioIzdIUFiYIg7jR9oM2QniaYV8j6Nn08IZXmDrDXrVPsvMQxskjdLjpH7q7iA8=@vger.kernel.org
X-Received: by 2002:a05:6512:b8e:b0:53d:ced5:e9f3 with SMTP id
 2adb3069b0e04-53de884971dmr59574e87.25.1732555157694; Mon, 25 Nov 2024
 09:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124-asus_qcom_display-v3-0-002b723b1920@hotmail.com> <20241124-asus_qcom_display-v3-1-002b723b1920@hotmail.com>
In-Reply-To: <20241124-asus_qcom_display-v3-1-002b723b1920@hotmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Nov 2024 09:19:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XjWT16wC_cpnC-Y5=eSvnj7rXY1z2ENyWZQYDawmjs8g@mail.gmail.com>
Message-ID: <CAD=FV=XjWT16wC_cpnC-Y5=eSvnj7rXY1z2ENyWZQYDawmjs8g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: panel: samsung,atna56ac03:
 Document ATNA56AC03
To: maud_spierings@hotmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 24, 2024 at 2:01=E2=80=AFAM Maud Spierings via B4 Relay
<devnull+maud_spierings.hotmail.com@kernel.org> wrote:
>
> From: Maud Spierings <maud_spierings@hotmail.com>
>
> The Samsung ATNA56AC03 panel is an AMOLED eDP panel.
> It is similar to the ATNA33xc20 except it is larger and has a different
> resolution.
>
> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
> ---
>  Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml =
| 2 ++
>  1 file changed, 2 insertions(+)

Pushed just this patch to drm-misc-next:

[1/4] dt-bindings: display: panel: samsung,atna56ac03: Document ATNA56AC03
      commit: b1fe820d03e2e1b89315faf99f1065bdb4146a8f

-Doug

