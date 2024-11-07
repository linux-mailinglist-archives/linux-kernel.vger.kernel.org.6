Return-Path: <linux-kernel+bounces-399847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DB9C0534
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9F72826B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C1620B1E7;
	Thu,  7 Nov 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URPzzogG"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4561E1043
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981051; cv=none; b=Ry5v5ZN4/2kIVREgjECDhMlnLs8a6XA972VcUGlCUT33kHxDwnC7LOSLBZuD6YOFz15wudS1VsRoIqkoGhm6vNna3I1RFTk+WvDXKJslskpzdUK9liDmPt5nzSEOaiwOIYAJQvyDCdOQdc8J4FmjxqIJYBs4j46OTiNZBzAgBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981051; c=relaxed/simple;
	bh=FD9SybItjrWYCxkvJ10uBzmtydWDzUdUjR+CbBgU2z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpFyqKePEF7Hy1gcIGwOidYOYa9zDGWKYx6W5n+r30Ix7N9GMEVK5qKZ0jbLfv2UVhYHwbvnzXSxC4pSCFFHSSFTNNXY5e2LYQtdBkX8RnLau3zwjTvriYtEhxoRhTEK28lEck0bCF+sey9xEmsoazMxrBONb7awWj/TlEZZ+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URPzzogG; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e30eca40c44so882799276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730981049; x=1731585849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSPWmvzriU7n4zt5eFjV3QM91IvIEi4Is4DeNEfxm2U=;
        b=URPzzogGZXqR3LeNLyVEpXgIKQVLMXcyS4Bnh5CpQjV4LnwmW3w+aaaMyImetYPqG/
         Qn3iLtTZtm6D23NFtq07fykN7jnmyQaoh2Ogi+BhSqcm2/o8owZwsDk4DE6I7APQn0Oo
         ghQIfGfTXSZRcPhZsni7CmAbGKHuA8Ib0HrS/MWKXt5odw/BfFQPsL8qFSOyBsJ6IeHh
         vHA5Iqt6AOHIX1Ei9eXg1wXJl6lTx3TosSX8ov5EQ156d5+JTNSqjO5ZA8By669VLfxS
         AaN7qTexAahzU8frZOQ1FnQn4mT0vlgmEk6Qcc6C4Ngyj0M6m7vdwfeFZ99Tx/8MKkZb
         ijqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730981049; x=1731585849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSPWmvzriU7n4zt5eFjV3QM91IvIEi4Is4DeNEfxm2U=;
        b=muNMgykRSxwnnGVfLE8L2SysRcIuSojZf3b9bBEQ6YkjSxkiddKBN77J/8b+S79NB0
         bf2LCovHno/vXaoGYCvcsRHRMT91hPwYv9ZQsyCV5RdVVND+AkWcvWHWmWrmtWi7ayGB
         H6c3yZx2T5KCO9gOZ4jCbAKcud2ZH28pYMJtBuD+fxYijOOe5WhC98D9QZnHK3Z2ETBm
         s9hRb2Ho0SWKKGsw7SNIlvwD03qMWGdf9P3ZB8ByuVTKwXe5GxeyE4ussLof32qinGXw
         U1H/WCxDzbIuexLKlBafzvPZRr57UXWuMbwtNqg3+X9myukKlW+ieNeDTD8jqBMOMUeL
         7BpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSIphFRJNq+bfMyfj7VqevagU7gzXijB3wd74BmZbHakJ/oX1Q5xI/EqY5u13Pi9cTyfDflA1XATM2RvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxES20qcN31IVAqZIvvJqpHHIFI11zOwO92r8K2RcIonSLXRbZ0
	JmXJ4lQMci/bOxU8FBCBkbEIIvW621fecYKkWPfkkVNq7MrWUvbw1SZIPKT+E9vdXqe74HxLHGh
	JeIS2yb+Rxm3PDWc4Z6dejOsipG496I1Z/StNng==
X-Google-Smtp-Source: AGHT+IHv9mgUbimlGT5mX5UyhqitGAJmHvxVkXQPT0TuyKjaYEJSoXqczA0NpCvvlC2PQwJhFcmZoanLH7+Ypxxf7Kc=
X-Received: by 2002:a05:690c:b98:b0:6ea:7015:99c2 with SMTP id
 00721157ae682-6ea70159addmr188580517b3.40.1730981049268; Thu, 07 Nov 2024
 04:04:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105180444.770951-1-quic_rajkbhag@quicinc.com>
 <49a6ec0d-8a0b-49aa-a9eb-1174cff930f6@kernel.org> <cmvfpctliqggra33u6ituguoxh3jxcuxiyjpbtcjbcgpu6lhoi@4zdthfkc2ed3>
 <692503b8-cf39-4d6b-b70e-910fcc710d69@kernel.org>
In-Reply-To: <692503b8-cf39-4d6b-b70e-910fcc710d69@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 7 Nov 2024 12:03:57 +0000
Message-ID: <CAA8EJpqMCbyK0dodMNyfs8dNjV2QoB2nyWm233eOS9xo8BaFJg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] wifi: ath12k: Add wifi device node with WSI
 for QCN9274 in RDP433
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 11:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 07/11/2024 12:06, Dmitry Baryshkov wrote:
> > On Thu, Nov 07, 2024 at 11:23:20AM +0100, Krzysztof Kozlowski wrote:
> >> On 05/11/2024 19:04, Raj Kumar Bhagat wrote:
> >>> The RDP433 is a Qualcomm Reference Design Platform based on the
> >>> IPQ9574. It features three QCN9274 WiFi devices connected to PCIe1,
> >>> PCIe2, and PCIe3. These devices are also interconnected via a WLAN
> >>> Serial Interface (WSI) connection. This WSI connection is essential
> >>> for exchanging control information among these devices.
> >>>
> >>> This patch series describes the WSI interface found in QCN9274 in
> >>> device tree and uses this device tree node in the Ath12k driver to get the
> >>> details of WSI connection for Multi Link Operation (MLO) among multiple
> >>> QCN9274 devices.
> >>>
> >>> NOTES:
> >>> 1. As ath12k MLO patches are not ready yet, this patchset does not apply
> >>>    to the ath.git ath-next branch and that's why the patchset is marked
> >>>    as RFC. These are the work-in-progress patches we have at the moment.
> >>>    The full set of MLO patches is available at:
> >>>    https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/log/?h=ath12k-mlo-qcn9274
> >>>
> >>> 2. The dependency marked below applies only to the DTS patch. The
> >>>    dt-bindings patches do not have this dependency.
> >>>
> >>> Depends-On: [PATCH V7 0/4] Add PCIe support for IPQ9574
> >>> Link: https://lore.kernel.org/linux-pci/20240801054803.3015572-1-quic_srichara@quicinc.com/
> >>>
> >>> v3:
> >>> - Created a separate binding "qcom,ath12k-wsi.yaml" to describe ath12k PCI
> >>>   devices with WSI interface.
> >>
> >> Thanks for the changes. When you finish with testing/RFC, please send
> >> proper version for review (just remember to keep numbering, next one is
> >> v4 regardless whether this is RFC or not).
> >
> > Isn't the 'RFC' being an invitation for review per the nature of the tag
> > itself?
>
> No, RFC means patch is not ready, might change. This was brought on the
> lists multiple times and some maintainers clearly ignore RFC. Including me.

Thanks, point noted. I'll stop marking my patches with RFC tag.

-- 
With best wishes
Dmitry

