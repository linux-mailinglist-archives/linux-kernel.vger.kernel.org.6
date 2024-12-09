Return-Path: <linux-kernel+bounces-438366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F05D9EA03B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE7216665B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEB199EB2;
	Mon,  9 Dec 2024 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qt6NDQ19"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD98137930
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733775948; cv=none; b=VOUSKWDGZJx9DkMq06BNBabsYzm3w+MteyPLeyf3Ka4i1GFdaeiaivygTgZUCVQVsUBIeNi2fcOVJYA+fBr9vwCleU4svkIPMAmy0QfkxtAogWdNUXxqfuFcMc5dSkWnn4zovq/p3vDql2hXSDln4XiwZebc+3Trfqjj3g1W+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733775948; c=relaxed/simple;
	bh=aeW1Qv2UPwpRAYlmvNgiB96ubvKWe8vR9mtKpaMWFh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jCq2ZR5Cvd8jpH58L6gUpzIl/wckAXp5nyzDGzCbG+lSlK3kduwRCxOXB/0tGLl9yvzs+HyNYwI1bEvfG+nj0eXS89CRJ/+oyu6GnybT1taMv/Oq89amE9p/CRTSkNkub2VEGp/3FTh14VVLrlT4wa+DwN/A0QikDbI0Uyk9OfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qt6NDQ19; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f00da6232bso15549847b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 12:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733775945; x=1734380745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwx5IHobGMlKVDDKEmFg8UZxcT8RAcxLlIlsPHAr7oo=;
        b=Qt6NDQ19TyzpxcedYchXsfTQaKNPnUZznjLok9seEXBxokd70yeR3R5uXWujj7T6gs
         G1CG5qHMBeNdmiZe1AdQeOzdEVQuyjIoKk2ZS7FMYyFSZ7o2etXd7QBclzSMRHvEv+tf
         mF6BGZLIJF3z6YP5CWNQFs7b5DN2JsjM1hs9HXYcWgl5KuW7L6OGBcGamyRE1ZcTSqYf
         Qt4p7gLOo/SJA9hpFwTwd7Q7cQISmzM5YLabL5ag/iod/JvcwSWAf4nI0XlWmBncH2V4
         0mmOxNYcTWiZA0JCBrmH6oTpY0D7TD1HJhiZlXlb3I4mbjfehq5CVpQ2mcRK59yXWu9K
         ELPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733775945; x=1734380745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nwx5IHobGMlKVDDKEmFg8UZxcT8RAcxLlIlsPHAr7oo=;
        b=YifvpMN3BtAcJq5W1BUsmXNlokyeGqWrbZdtJ49ZfsOR64abcEt0tm/2JQNtYxHWK7
         RV7LzSfbWc9DE6ENASnNJkUBhmzwpdLvJrFdfqarzAFwy/N5AlLaKKSsu35qyzErysRf
         dPDS8I+rWrVrn/2MRVealuKuqz39ql/mus+aKMgKo+PPkHXL72GUgpOub1p9BnZrZKyk
         BWQubmV4p6elTTAD4zxh0ds27pB9rfGB4/gj8VwlMXexNbAm5p0F0Cp+l+xQYtIqfY3a
         W4Hu/vSHNSOGffLoUbZIxJE4jCFadeP/dIfAjLQ0WUYnx/n4tQ1WQjW88gBOxkUbvCzs
         P5lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0V/8sVeS8Q8vpWUYQTSuPfCvGPRNtMV3sj58r4jPbbdzNJjRXOBWM9F7ZdDQN9NNuOL29FijgdJnwsRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DgDJUMwGB/9FNkebyR1rX1XPnylxdFhGLiuLxhyrrbREdXhl
	lHYfdUYDh5TYcrJW3InYm+oQ/BlNyBWvuslkH5w6nm6mJbaueLYrEXnFJtl9oMnBD6RYOnTsQ0i
	PJWnUUBIbvBbjddnBrDn8KsRWogpYnZF57OQWHg==
X-Gm-Gg: ASbGncslro+lQ+BTDdfgpnJIidtJajTpY8FjC25StViEcK8Qm8tK9Wov+Qmfg+GUVLJ
	KZcmNTtTReSnWoD5U2kO8UMpi/pkEZ8qvaL++783T6dd2FFhy/FwFH0a7KyQ4uSPVxSM=
X-Google-Smtp-Source: AGHT+IE4eIG1CU8nTE/djGI7rWu/Aot88rWUk4lCyh2w34yi487HGQfCm9tQE98cxEW5ofI5zKH9RgP2gJmphFmD5Mg=
X-Received: by 2002:a05:690c:64c1:b0:6ef:c24e:5e2 with SMTP id
 00721157ae682-6efe3c0db31mr121637897b3.19.1733775945676; Mon, 09 Dec 2024
 12:25:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-0-9061013c8d92@linaro.org>
 <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-3-9061013c8d92@linaro.org>
In-Reply-To: <20241209-qcom-scm-missing-barriers-and-all-sort-of-srap-v2-3-9061013c8d92@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 9 Dec 2024 21:25:34 +0100
Message-ID: <CACMJSesLKmNSQKzc=4er4-sUP=+1cMRFoHNgR_CjCg8f6+Vmhw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Handle various probe ordering
 for qcom_scm_assign_mem()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Ojha <quic_mojha@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, 
	Elliot Berman <quic_eberman@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com>, Andy Gross <andy.gross@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Dec 2024 at 15:28, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The SCM driver can defer or fail probe, or just load a bit later so
> callers of qcom_scm_assign_mem() should defer if the device is not ready.
>
> This fixes theoretical NULL pointer exception, triggered via introducing
> probe deferral in SCM driver with call trace:
>
>   qcom_tzmem_alloc+0x70/0x1ac (P)
>   qcom_tzmem_alloc+0x64/0x1ac (L)
>   qcom_scm_assign_mem+0x78/0x194
>   qcom_rmtfs_mem_probe+0x2d4/0x38c
>   platform_probe+0x68/0xc8
>
> Fixes: d82bd359972a ("firmware: scm: Add new SCM call API for switching memory ownership")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

