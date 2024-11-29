Return-Path: <linux-kernel+bounces-417907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BE89D5A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3451F2364E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF8118891F;
	Fri, 22 Nov 2024 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFybMwWJ"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D9187321
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262495; cv=none; b=LSCbtRHRgWmesn2WttHt3+kyEq1ncaTCPUsznN2dZGnITFnUdjiHLQjzHW7oYPB1M3fQ99YuHVF9kxuMDBP9ljPN/6SZwYfEQHNj1kDEXC3mis2+sQgP/mviO9fzWzhc+ms3Ufe5PbMz4lWVXG5ndp1GHOom/2x5yd40mk3lqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262495; c=relaxed/simple;
	bh=ccGCjoR7OOGsWyQ0kZ2v3mFpY4WQi19CY9Hwz6i8ids=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCJhjt23mLKDDRrtA3wf0bbTDETgO9uNchEPdmAUHJZ20/y2OfOmd7xmOpJ7t4KcgU/H3KEw5pdA7dyvS+BnyvLbWaqfJmITEe/fhaM6WKDs1wlkJ5ymiduZpEiXpeKjawrjM0x380luvISxvszLGE/xJnCP7c+1bCs6BmBZfc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFybMwWJ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e383bbcef9dso1818228276.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732262492; x=1732867292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0n9X1zO0xeMvExen0u2qj/zc+VVdF7G7eQjHYHIY33g=;
        b=WFybMwWJbTEtuZ37Ed+MQ+AJKHSzkouq0lF8XAzplLKSZI7TLuB0IkhiGrWHe/+Diu
         sFPwXNDdo0uAa0R7+BQwpjtOH6KZwJNohUTC3Q9s/tuig92GJGEHyNjau9nfm6t9WEb6
         llkLRYBW3udE97j0ChK91eHoSvgt5l/fnkDp4m7FU7XVpVvLEMIYWYxe9xUuR/IJZ4XX
         uhT5COq+BE6XzqoXc1gP1Zxy+V3/I7VKgBv6HuIzKdbNC1HHHLLcXm1l2SMBVhnis6y+
         +ay+EEer9Pfkag5DhBEdvWM7/QI+IXW2Y0E3m0gN8UyaetCFxLQoKQ0Et98D0FwvQC5o
         YT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732262492; x=1732867292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0n9X1zO0xeMvExen0u2qj/zc+VVdF7G7eQjHYHIY33g=;
        b=pDMOuN2wRap/OqGshkgHOK4PQEibjp18SGfbpiNztPk3kV7/A7nvv+QOeqa9utXFpm
         A+8lgdnYxNynUeAZD6qJp5USUM5xpsXjRnWcJ1wePIGtgxUOTDwmMKehdyWcKfGyc3yg
         VC3ejM2HTQ+/a3XGsBcq0vPngKPB8MZYFByu5aggQlE/NfKDEoI6mXnPTCAkSPNtvUg+
         AFtWr8vR/ySAiAugQXd6yHvYyeIuZa2pNnn41bw1beWSWO7aVxpCmd5IdsOAT/xGjSsh
         9zoEvQwWEnty6ld1qzKR7AIluZ7xI5iyFcqmCfn4UGGPZ0rE2QyQP/oa2TsL6ieGaynq
         YLTw==
X-Forwarded-Encrypted: i=1; AJvYcCXCrG/1BXqLTOGisWDA1mrvvZzKrJIEZ0tfP8ejlNoYWl9U4dk4V5uYgqiSiYGRUqT0Vz6jtg1xw4WpwBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5rTHQHkN/OBBH5CgIQG14HShSOKtzb48gQubvcoqKKn0AM5VP
	2GkGBu2nCR4EFicE59fCdZgyYi2ygUdclCa52OOr1uvPFi8oedSVoTxXycnRjCh6DuMWxaRPwE1
	CHh8IPuShvtj3y75i9hWLyQbD+YyRT+rMvvzQHw==
X-Gm-Gg: ASbGncuqF4DCoxV6keZtHs4gZnp3XLuPB37ZfGEPomorvWxtpTZJpfRFM+Pl2CxhWYG
	fbUprjnN/varGrU/avR60/k7ggX21QpAXpVPF91meQzupGQ==
X-Google-Smtp-Source: AGHT+IFU5ixE8Xx6CZ0SxpuikfRRPTuuMks+1EGpEPYq7zm+H95wFUg/aT+MJnKUnRB2FID0ghRSfJDLOAnf/bPxO5E=
X-Received: by 2002:a05:6902:2a8f:b0:e38:a031:bbd3 with SMTP id
 3f1490d57ef6-e38f8bcc9fbmr1727683276.39.1732262491893; Fri, 22 Nov 2024
 00:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-3-quic_chejiang@quicinc.com> <smwxrjvdvyxw6tknucl6fb5jpjau2q4jcyjxpunbtt5ep6xsr4@ztuyfkrwgxoo>
 <44932c08-000f-4e6c-89b3-d7556a0a7a88@quicinc.com> <CAA8EJpq1u6ngze81LKAcGzQEJz=yJ-u6MjvRMJHdKp3aPVnewg@mail.gmail.com>
 <e8645b6c-7f78-4051-9e29-2276197714ed@quicinc.com>
In-Reply-To: <e8645b6c-7f78-4051-9e29-2276197714ed@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 10:01:21 +0200
Message-ID: <CAA8EJprmdafDNpjEXg==NA3rQnMYKDxKrYLCoTH0WCv1R265Eg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: bluetooth: Add qca6698 compatible string
To: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	quic_zijuhu@quicinc.com, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 03:55, Cheng Jiang (IOE)
<quic_chejiang@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 11/22/2024 12:28 AM, Dmitry Baryshkov wrote:
> > On Thu, 21 Nov 2024 at 06:12, Cheng Jiang <quic_chejiang@quicinc.com> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> On 11/20/2024 6:44 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Nov 20, 2024 at 05:54:26PM +0800, Cheng Jiang wrote:
> >>>> Add QCA6698 qcom,qca6698-bt compatible strings.
> >>>
> >>> Why? Is it the same chip as WCN6855 or a different chip? Is it
> >>> completely compatible?
> >>>
> >> They are different chips. But it's compatible with WCN6855.
> >
> > So, do we really need new compat? Will/can it use the same firmware?
> We need to use a different firmware.

Need because of the product needs or need because of the existing
firmware not working with the chip?
Wait... your WiFi colleagues were more helpful and they wrote that "it
has different RF,
IPA, thermal, RAM size and etc, so new firmware files used." ([1]).
Please include that information in your commit messages too to let
reviewers understand  what is going on.

[1] https://lore.kernel.org/linux-arm-msm/20241024002514.92290-1-quic_miaoqing@quicinc.com/

> Let me check if using
> "firmware-name" allows us to omit the new soc type.
> From the driver's perspective, the only change is the need to load a
> different firmware.

If you want to emphasise that it is not just WCN6855, extend schema to
use fallback compatibles:
compat = "qcom,qca6698-bt", "qcom,wcn6855-bt"; No driver changes are
necessary with this approach.


>
> >
> >>>>
> >>>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >>>> ---
> >>>>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> index 9019fe7bcdc6..527f947289af 100644
> >>>> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> @@ -18,6 +18,7 @@ properties:
> >>>>      enum:
> >>>>        - qcom,qca2066-bt
> >>>>        - qcom,qca6174-bt
> >>>> +      - qcom,qca6698-bt
> >>>>        - qcom,qca9377-bt
> >>>>        - qcom,wcn3988-bt
> >>>>        - qcom,wcn3990-bt
> >>>> @@ -175,6 +176,7 @@ allOf:
> >>>>          compatible:
> >>>>            contains:
> >>>>              enum:
> >>>> +              - qcom,qca6698-bt
> >>>>                - qcom,wcn6855-bt
> >>>>      then:
> >>>>        required:
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>
> >>
> >
> >
>


--
With best wishes
Dmitry

