Return-Path: <linux-kernel+bounces-563558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40A8A6441B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2D07A2C43
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BAD21B909;
	Mon, 17 Mar 2025 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="SKEvc+fa"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804F21ABA7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197550; cv=none; b=us8T9m2DV0Hqdn60aahstzECSbBfvDDEnfINDuSbzO/AZ2yo22D3AMYFOtTevyzmPiJL5cu5mnhkpKCZuwcsoyyQSSI0tgwty9pxn8+P4pTRkKaPEHIvOY/ta7PzmxJW0zSy1BFlJfbmixHCNn0W5/JrPw1flL2nyPGxiw9y4xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197550; c=relaxed/simple;
	bh=z/35C6OncKImSrzwCMGsv4v7SHuEIwjIRKaGVCMngMk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=K5W/qNe5yfS06inp5sGw1SRVr3lw/Bhp9NAxlk8SxD2NKkDnSyp9uInopgePPd7tpBhpvkJ4v3KgVjuOVDQABCClgc7A48gBrkkJ9wdE0qVvJl27S+UoGoQ1rmd8ljo5GqlJXytAUd4eT2yH78EBibL0Az3BO4oyf9PKmI4CIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=SKEvc+fa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso5044429a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742197547; x=1742802347; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl7H7yZOIWFrlEzxdHx2ScaCc87hpAhwNF8CQ1QYBik=;
        b=SKEvc+faLEJJIRTvnn7nJyhuqtSC91fYhPUaM4EqY2EHC+FV2cPcLnlBagyvmEnv3W
         dG69pcspGSax0w4/OXWmYqyo3Oh+qD1h+n8MCf3k2daVrm5Jh82vxgkpgHFAPokeq3Js
         CaoqeTH4hS1KfpGm2CYmIaK8qiisMHd4FwCp4U0823sGqc8UgkDF41QiveiFD+zo4bPf
         04zWvXBLP8z8wVzIKds/n1A77x9A9SGZgB7UEvgWmEX9Sea0lYdFQkOTnkonRi3wNZvw
         51KUI07RWyW+Kct/edAQq/TuyYm3PvALwuZkI09dbcWRzXOBA9X3fDHyC8BrwBRtuZf1
         JEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742197547; x=1742802347;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gl7H7yZOIWFrlEzxdHx2ScaCc87hpAhwNF8CQ1QYBik=;
        b=OCBRHqMy0UKF/reR5MBDQ+DAK64MLrz9rJjWhOVZQ660ceppEAkS927TQ4PPGm/hmA
         9g/hnCVW1MtDvrOFQC9/uGK/5bu4Lzesw4XXCSTvSUgnc0oDKSyh6F2/OMe5BhCS8SuM
         i9ZTjFhVfR+pMTaVMxCpiq9IANvAa8ymvoArqHx98uqqRbICVKZcBoQ02fdrV/ANpeMM
         mGjwR8QQudojQkjYcgCTcUeTAmrC8DV7Hs3CqT8U/fQv5ge75vl/4yeAOcTaC/v1PIBf
         bLKqoGvigs6DhBek5q/Auzz0qguuQReYID1T88/5okENXDPPlrMhfMjU+3FyTVJW6lqB
         z4AA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2qoW3Vq/dc8lFgsgcLpqifYn3OKK7EiSalBwq1aQepNRQxTmnV7jmKUS0l+JNlDFDVAFamTNi6IKkds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYUz4WwARmYNJV/qzRE0/yR9VB6XsdFy2/cm6I0Blazrq653Jz
	j5LDXRxtBvxLrL4NqAdC53+mzrWOK5kxwN8G7wo8MhMNF9MYVFJ1JwwXmb8FRIg=
X-Gm-Gg: ASbGncvuMdGo/2tJ/7gtMKmhLmCs25MEwTQPa2LS60MNX94TzdUeqhsYdj9joamJsCW
	O4FbbV1wvvuK9q01m+NMOjvSv7F0T1IgUF8M3vDUKGZxxZwYHVgZ3Rp4NoJ+uhi3IXdVGG9eph2
	HLhjWNJ2w5W/lON1LoW2DVvZNnKGJLwx6V36WLXJn7Pqz7XfG+MnhDUHPBKgHHzdmSVDSfK0gYQ
	lvsnFz+gkQ2M9RONOlaBO970iNqSVQgYyapmsauK3GrgPh6Xk7iQbqop+DC9xMGS9jZdBXelPf1
	SgkSi/EX8EsauPFJzyNPSPvQ0arbwKWVIC7FHzlp+RMjDkeRYOsi5wVHXWz7Evr5wSdjd9wEBNP
	VgrOd4Mjr9fJU4Q==
X-Google-Smtp-Source: AGHT+IGmNMHuunVdQSgHrKnOfe/ERZGsvr0xj7JwdS+NX5aLfGQnW8CH56uoLVrH9JWD/35XdRKpyA==
X-Received: by 2002:a17:907:2d92:b0:abf:6b14:6d00 with SMTP id a640c23a62f3a-ac3301e1e64mr1158441066b.5.1742197546956;
        Mon, 17 Mar 2025 00:45:46 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ed1e4sm623996666b.66.2025.03.17.00.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 00:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 08:45:45 +0100
Message-Id: <D8IDHJAC4BJ1.WNTMQEJXD2R2@fairphone.com>
Subject: Re: [PATCH 0/2] Some small preparations around CAMSS D-PHY / C-PHY
 support
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Todor Tomov" <todor.too@gmail.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Barnabas Czeman" <barnabas.czeman@mainlining.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@somainline.org>, "Caleb Connolly"
 <caleb.connolly@linaro.org>, "David Heidelberg" <david@ixit.cz>, "Hans
 Verkuil" <hverkuil@xs4all.nl>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
 <D82FU3SIX5RZ.1Y525GJO0UOAA@fairphone.com>
 <eb06daf1-3cc3-4b31-a0bf-bc450cd0f041@linaro.org>
In-Reply-To: <eb06daf1-3cc3-4b31-a0bf-bc450cd0f041@linaro.org>

On Wed Feb 26, 2025 at 3:47 PM CET, Bryan O'Donoghue wrote:
> On 26/02/2025 14:13, Luca Weiss wrote:
>> Hi all,
>>=20
>> On Mon Dec 9, 2024 at 1:01 PM CET, Luca Weiss wrote:
>>> Since the hardware blocks on the SoCs generally support both D-PHY and
>>> C-PHY standards for camera, but the camss driver currently is only
>>> supporting D-PHY, do some preparations in order to add C-PHY support at
>>> some point.
>>>
>>> Make the dt bindings explicit that the hardware supports both (except
>>> for MSM8916) but also add a check to the driver that errors out in case
>>> a dt tries to use C-PHY since that's not supported yet.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>> Luca Weiss (2):
>>>        media: dt-bindings: media: camss: Restrict bus-type property
>>>        media: qcom: camss: Restrict endpoint bus-type to D-PHY
>>=20
>> This series is still pending, both patches got reviews and no pending
>> comments from what I can see.
>>=20
>> Would be nice to get it in for 6.15.
>>=20
> Yes this should be merged.
>
> Thanks for following up.

Hi Bryan, hi Hans,

6.15 merge window is approaching fast, I wonder if this series was
missed still.

Regards
Luca

>
> ---
> bod


