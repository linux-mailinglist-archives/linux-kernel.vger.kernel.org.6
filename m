Return-Path: <linux-kernel+bounces-346108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65CB98BFB3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C60E1C24057
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003461C9B90;
	Tue,  1 Oct 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdn5ZAWI"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF98A1C9DC0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792223; cv=none; b=rgNQtqS3pB28WYyTjJbE6ORov3ODtCH4LmmltQHBMdYEhHv5Zje33quXP6vzPqFaW63q6sEmuvmG1uWukWRdZuhi+qMbEnpCkp+VYcMLzXpCt2RN9JGjq+2FjEqb5sJ8FhnkqDW1pSyGnQ392n16UYUIlvU8nAxXjqlVYcZdZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792223; c=relaxed/simple;
	bh=MvAacLaDBceNrpSd1jDzbEXuHGqrT8pU1AHDnl3+2N0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mO1KBpWFSzZWqVQBIMClYT/6uwRf3gOFkakcE2YHlMbQbu2lOHgy7c5oVfQRY1IvAE2QN2e6neSQbtKYSM4g5p+3uyoMqkf0zoIjwNerfUFdhdau6xjkiNpnuEFsPJbpb3ZFn6+oJtjZ6amyHDg50kDS9Rc2wt7HZAm6nIsOPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gdn5ZAWI; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a93b2070e0cso675413766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727792220; x=1728397020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MvAacLaDBceNrpSd1jDzbEXuHGqrT8pU1AHDnl3+2N0=;
        b=gdn5ZAWIlhlAGBtI994A637HnhBN7pzbMZUIGdGYOzc3jSXtcbblPFNGNcPE1ZE2K3
         +1jlTBS+RHjctMot0XILXqoeUQOVSmCJbDp143QaWRIXIXr1F9X+n2G2/c9c6Z/bkDQ+
         8LunTI1TvYUr8SAmI1GlEhakLePL+sV0q3UPxfmPhkHqBDq70ebjmtme0+aWuh6ql3QZ
         +EjXzL5hx2V6zIRyTGlanS0qaO+Bc47MqpoWsCjb5QltRkU4RD+/zfsQh3mkLgdvloCp
         NoFOvN6GdGLBhDy0QUrxcGe0dlBBMjoTg+ZaryqFIBh3mQFENNsIlkMK6VYismyFPzJ4
         R6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792220; x=1728397020;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvAacLaDBceNrpSd1jDzbEXuHGqrT8pU1AHDnl3+2N0=;
        b=exV6vKklO/5n5jVvL1MAveRAhWcArXX+xW8X/5JDS3iOrYSxGTIHxE+sRXmkfZXCCE
         eXX6yFJGHugKZWUWdzE/ZdWut9EPc5HKE9N7osyvZoF1nipfVviEllGb9OV7WtnDP8ly
         FBTras3sCWkgP7SkzksSvAfjmM4gTo2setel84ArMu8jn4O5QX2qxoL0+E4+rX8FmBub
         Eqt4iqJWzZZGISWE+khOXUo55kFKxgnNsQqDMuUw8i2ggxD78a1u9RR3VAs8QS3D270d
         8tuvTIo9dDP5H8uUYVw7UASU4IUEd/xHV8VpIJo4Uel2O3MEjyGzKrTl+rsGjo7KWRui
         xOHg==
X-Forwarded-Encrypted: i=1; AJvYcCUpfDIB/kNv8evP0r+ctdXvUXiZg6taGk+TIjP1s3SP6pp52iA2Ep6UXDHkHeCcnkEtOgJd0GPGQqRCorE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5LzFCjiEIOHQo9itzvgZ7hNiBY9ZqJv1tydoozkxCCzKb6WR
	trdfYy701YHkLZZjtCnIMogYmbMQctQWtpL0rHiq2OxU+aQwvv8ITebBXDV67u0=
X-Google-Smtp-Source: AGHT+IFEWffX/CHGY6XoMdO9kdp7HM2GYhPbJlSBDdG8O1hxbquzBTDo/fLcnh7exBe/tUwFPn8yXw==
X-Received: by 2002:a17:906:db04:b0:a8a:18f9:269f with SMTP id a640c23a62f3a-a93c4c267dfmr1736758766b.60.1727792220071;
        Tue, 01 Oct 2024 07:17:00 -0700 (PDT)
Received: from [127.0.0.1] ([37.155.79.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947487sm719545766b.139.2024.10.01.07.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:16:59 -0700 (PDT)
Date: Tue, 01 Oct 2024 17:16:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, quic_mahap@quicinc.com,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Kalyan Thota <quic_kalyant@quicinc.com>,
 Jayaprakash Madisetty <quic_jmadiset@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_0/5=5D_Display_enablement?=
 =?US-ASCII?Q?_changes_for_Qualcomm_SA8775P_platform?=
User-Agent: K-9 Mail for Android
In-Reply-To: <609440b4-e46b-44c6-ba33-c30f4ca8d863@kernel.org>
References: <20241001-patchv3_1-v3-0-d23284f45977@quicinc.com> <609440b4-e46b-44c6-ba33-c30f4ca8d863@kernel.org>
Message-ID: <576B115A-CB36-4795-BF23-75EACD0679E5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 1, 2024 1:16:31 PM GMT+03:00, Krzysztof Kozlowski <krzk@kernel=
=2Eorg> wrote:
>On 01/10/2024 08:41, Mahadevan via B4 Relay wrote:
>> This series introduces support to enable the Mobile Display Subsystem (=
MDSS)
>> and Display Processing Unit (DPU) for the Qualcomm SA8775P target=2E It
>> includes the addition of the hardware catalog, compatible string,
>> relevant device tree changes, and their YAML bindings=2E
>>=20
>> ---
>> In this series PATCH 5: "arm64: dts: qcom: sa8775p: add display dt node=
s for MDSS0 and DPU"
>> depends on the clock enablement change:
>> https://lore=2Ekernel=2Eorg/all/20240816-sa8775p-mm-v3-v1-0-77d53c3c0ce=
f@quicinc=2Ecom/
>>=20
>
>b4 diff fails=2E b4 mbox + b4 diff -m also fail=2E Way to make reviewers
>life more difficult than it should be=2E
>
>I'll move this patchset to the bottom of the queue=2E Please in the futur=
e
>send patches in standard way, so our tools can handle it easily=2E

This is the first time I read that using b4 tool is a strong requirement=
=2E This iteration has been sent using b4, previous, probably, were not=2E=
=20


>
>Best regards,
>Krzysztof
>


--=20
With best wishes
Dmitry

