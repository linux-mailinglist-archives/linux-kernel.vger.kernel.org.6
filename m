Return-Path: <linux-kernel+bounces-426558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7BE9DF4F3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C6E162C6E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15170809;
	Sun,  1 Dec 2024 08:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmuqTzGj"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF318654
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733040549; cv=none; b=hknmAmRNYEBuAaTttsC28bXbXsF5sdIGUXquiJwJBXMDZG3ifhY8dcYVag+LbZnpZC8nveNFeh8VpNf0Qy8DakijHfGwcW9T/4wuSM6O18jCCfndtETANKf4qRG5xlS90Z7UdPtQo2/c5lvir7DqysdjmBj4A9w+vH1/hRdPnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733040549; c=relaxed/simple;
	bh=q8Xflx4nuwr8WqlZznZzM4Larjd+ngbLhcTfJqHMm8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0pqBGrmIJg4DftJKKL1NqJtr7qvMALSE5strjSHAiq/m1Bl0Eki/2pflsVBXTQfRLE2hURiFAd36xco9fLstS0SC5Hzlv8oCzvfF2IYXklfH7eBDB4SDhH8seP6lbl/ybiRRBTWQxb/0SThja+jtGgmtxW8uD+KB236fipOaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OmuqTzGj; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e398dc7864dso1520204276.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 00:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733040547; x=1733645347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eBUL8rUioKfjIFVURgDKGycrpqU7QDcXSGd9jkBZ2eA=;
        b=OmuqTzGjve5ipbfyuEnZ0RwZNlGmL+QCPAIOcSazD3ufnChAOmU/omj0jBQ6aZmlG2
         9VtnVVxZs1tARTZC7M/3YYhBkv4eS7UTtojiLdYjAJmbgFGz5o6qHfqgqbWLDDgMz8LZ
         abT5b5OvgFjcSDtkBCWYrEDkfNQWpRnNt881nGsQgzoN0UKcGx0QleWJdYzxQlFEVHma
         rHxu9y8uX/Tljq9PYZJvOAowu6lKIfwffn3JxNP6AZqQFjvYoSfSdXL0fwFAF09FpvNk
         2t+bS3HqF+6KjYv793LskHDG+kTVAtWqM1g0qM3nTU0WujjJLFw2AXPLA5VFtiBw5/1I
         MDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733040547; x=1733645347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBUL8rUioKfjIFVURgDKGycrpqU7QDcXSGd9jkBZ2eA=;
        b=gpJe6mQ3dLPy0yO6YSJdE92D02JwCxbP+rWfW3oZjKKUtPnpdc6kH0BXNXPz7bFHOe
         3gcsoZfGsq2wYJV6T08br5L3NeMddAR8is4DvnvPbGPdmjyeWJrWIfSsA60Ku0rlDeYA
         R8M8IeBIrTL+hDO61jhsv8p46OvjG4fXLfujHV2wXaDDFf+iT3+x4MH6HemwbTBBPUc/
         ttND/wHaiBTvL+yJLZzZaixjVyZMPV3ePNWRpRT0Rt50I+ZyOx0SNqh4Dvv9jqmHftOY
         gVy4xCzF/aFmDyURK8bLhwQ0Xsz3HrEbt49mkQa8moeE9gqhSlhzB55KNxEtFoX9VN4v
         jo8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDnV1CeWvfr6P57LJbhAwAL+e6LSgxexx/54Y9Kb5LS5gtvlCsqxsVsNRaigVE/6xvxm73tUVgbbVt4nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkX7p3KXss/lbqcoy5yqiUSAvJi6T9NHq9i1qa4Wt6Fujw4qj
	Or2uKGW2B41PoE18TEnUg6qhVXPA0OK3bLnU3+KgEJL1kywv3lj7sZbXnq7/GKPVROeQ0QdYW/U
	JJLjuPJGuniVdPjhXi8tqdamaSjSTM9fLHShRrQ==
X-Gm-Gg: ASbGncvai8rat5DjZaoRvh+jYJ22JjIDZ8wRbTK3tzJFQybjvR47OT1niPWM7COGskN
	eG5enAZRDH3UUFoGRX7VOuP+b6JsGL8It5oexIeCVG4mZYg==
X-Google-Smtp-Source: AGHT+IHcUUm/krwD5SmkbEnJqxOYEzdgb5XkJH+JZjAtMBagBkTNtc2cjtKvaJA+Wck0ATJv6E5fRH2nqSTIAV434GI=
X-Received: by 2002:a05:6902:150d:b0:e38:b889:7eff with SMTP id
 3f1490d57ef6-e395b870d38mr15606436276.6.1733040546860; Sun, 01 Dec 2024
 00:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128-adds-spmi-pmic-peripherals-for-qcs8300-v2-0-001c0bed7c67@quicinc.com>
 <sxbjxywwjbep5rlndxoi5k62hqs24biryslkwbcxtvz3ilypvl@qi4omifueyqu> <c425b639-20a8-439c-9e9a-8b5095f8d3b0@quicinc.com>
In-Reply-To: <c425b639-20a8-439c-9e9a-8b5095f8d3b0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 1 Dec 2024 10:08:56 +0200
Message-ID: <CAA8EJpqyQ32TNr-_0owXqbCzbwRcr7enmUV2TYoX3yWHz-Vn4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Adds SPMI bus, PMIC and peripherals for qcs8300-ride
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, kernel@quicinc.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Dec 2024 at 09:13, Tingguo Cheng <quic_tingguoc@quicinc.com> wrote:
>
>
>
> On 11/28/2024 9:10 PM, Dmitry Baryshkov wrote:
> > On Thu, Nov 28, 2024 at 05:40:15PM +0800, Tingguo Cheng wrote:
> >> Enable SPMI bus, PMIC and PMIC peripherals for qcs8300-ride board. The
> >> qcs8300-ride use 2 pmics(pmm8620au:0,pmm8650au:1) on the board, which
> >> are variants of pmm8654au used on sa8775p/qcs9100 -ride(4x pmics).
> >>
> >> This patch series depends on the patch series:
> >> https://lore.kernel.org/all/20240925-qcs8300_initial_dtsi-v2-0-494c40fa2a42@quicinc.com/
> >>
> >> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> >> ---
> >> Changes in v2:
> >> - Fixed comments in community.
> >
> > comments in community? What does that mean?
> Comments given by the opensource community in the Email list. Sorry for
> not being clear about this.

Please in future describe your changes in changelog. Saying 'fixed
review comments' is not enough, as it's hard to tell, what was
actually changed and what wasn't.

> >
> >> - Added arbiter version(5.2.0) in commit message.
> >> - Link to v1: https://lore.kernel.org/r/20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-0-28af84cb86f8@quicinc.com
> >>
> >> ---
> >> Tingguo Cheng (2):
> >>        arm64: dts: qcom: qcs8300: Adds SPMI support
> >>        arm64: dts: qcom: qcs8300-ride: Enable PMIC peripherals
> >>
> >>   arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 23 +++++++++++++++++++++++
> >>   arch/arm64/boot/dts/qcom/qcs8300.dtsi     | 22 ++++++++++++++++++++++
> >>   2 files changed, 45 insertions(+)
> >> ---
> >> base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> >> change-id: 20241122-adds-spmi-pmic-peripherals-for-qcs8300-0a3c4458cf7e
> >> prerequisite-change-id: 20240925-qcs8300_initial_dtsi-ea614fe45341:v2
> >> prerequisite-patch-id: 73c78f31fa1d504124d4a82b578a6a14126cccd8
> >> prerequisite-patch-id: 5a01283c8654ae7c696d9c69cb21505b71c5ca27
> >> prerequisite-patch-id: dc633d5aaac790776a8a213ea2faa4890a3f665d
> >> prerequisite-patch-id: 9ecf4cb8b5842ac64e51d6baa0e6c1fbe449ee66
> >>
> >> Best regards,
> >> --
> >> Tingguo Cheng <quic_tingguoc@quicinc.com>
> >>
> >
>
> --
> Thank you & BRs
> Tingguo
>


-- 
With best wishes
Dmitry

