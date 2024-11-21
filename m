Return-Path: <linux-kernel+bounces-417217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 961399D50B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F51B22FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D81A0AF5;
	Thu, 21 Nov 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UinRx+EL"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0E16DEAA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206534; cv=none; b=Be7w8CST8CAeJdlLZYFU7vRQDP008xBsT01tj+WFZTvDAtF7Tigu0Y2we2Ib80KpWtOOZz2jMoXv9Q9UhkNCBKsPuFFrq0hXUNsIfJXUqx7A0WZMmnJx3Wg+Yw+CF6z9IHerWUXONyMtByL38jYf9XDwNRMFH+OzKwSVf28DzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206534; c=relaxed/simple;
	bh=MGKmVjnk8yoDkXuExTllKnxldDA3sHkKgKmYP7xY74Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmPeT0olelgsU3eXm5zrMFm3KVcDvkuYdUIban2Wgn0TW80EuRIcmwe1SIlUmSl8V40u9n/M2GEsGltt+wfIC6IVNrHNhAsZNB6/0767luvCurR2+METJhmRA6WBKYH+zDKtcoSylDP7HKNIG3qpw21RZkJAcE7gJDXZKPow+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UinRx+EL; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e38b425ce60so942009276.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732206529; x=1732811329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9TXJDPjbxfNTgXBJjbMA4nZmwtyITDhR1t+eI678Jsg=;
        b=UinRx+ELSUQ8Cl9nzb7fNsK0LSsWCdyVUkHXf/wGS95oveUb1NqPcPXYYE2fJnAoyC
         4uLIoTEsaH+Z0HXZ0psUKcpKxUhHPtWpymCA+flJChItbBseHt4qjWkLCP80on5faD7V
         p937jG0ufTdaFGKcB/5+xGgbWtlc0nx81g06j6YNtJdAh0QAkAxKMbJhs5DG/meAZiSR
         pWelGB/IJaR3fCUpzkk+rsVpg15Ieq7TvnExVW35021i69w972fyhAUOfsSZuX4pZWWq
         xD4zwq64aeR7ahES5tdh0nttwX7hpNBYPG2KOK1ed4FKZI+rPDjnJ6AE9mb+R7VXsWBa
         9DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732206529; x=1732811329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TXJDPjbxfNTgXBJjbMA4nZmwtyITDhR1t+eI678Jsg=;
        b=Eh0XxaXO9V35RLch5GM85lNoJpt/ciUdg/am8LMM5fZZPDgFR1D84VDe1qmIHogRf8
         DaeJerOFZ+zqlo6JlkljVNa7tfmqdWiuFWfqbXvDDthofeT8JGs717pVys51rDGsJiTW
         BeJMGhPR1RP5Nl5Egd71TAC1V1pZDIBvT0ZlsHXhjGqyFw1NXxqxU227FvSFgPtZ38/H
         k1GgY4+aZxJ0dSM50iTYmWm+FCNd8AhpOaoXIY72YMf1wCj6phL+WquM9jLcUEhvkIOK
         d8KlCx6OSace+e2jWBla5+lvILjAPAXVWbrH///xXtiKn7qKtMRgtMQaVn3ReBkimiNn
         RDkw==
X-Forwarded-Encrypted: i=1; AJvYcCXuNQFwT3EhSqX6CMOv/ciLTrgoTINey/oBYPhGlxUZCPO8EFTw+5SRhmf92z5psh0LdW12QlrCY5oHVho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDFWLF4FOpiqpEoQOhUk2ns35bScnsfsy3IsaqPoAZ7T8cNAcq
	pEIHXa+OebTvUMuOFQBfED1rM+KLq4bmzf7hNT7HQIabr0xlURYKBuHmIIbtwHLpU02789uUluA
	/dOLJUm3pBJjymGkM7oeOOi0hdHhRzQqFIT8juw==
X-Gm-Gg: ASbGnctd0+7c/em/g1dDRAzGWWKKNRbTjKV1U12/A/agQ2CkztgHcR0dgGtgQX89N4M
	yjEH1moU1NjKETZYcieT9UkWHwFi8MA==
X-Google-Smtp-Source: AGHT+IH8jQ21wlz4AC2Gow5w4irMjP5l7uwsR8il3RocOz176o0lukHq/cOQw/yaQ1lFxcITz6OY2O1mdE+2lf5pOlI=
X-Received: by 2002:a05:6902:1242:b0:e30:c850:b77e with SMTP id
 3f1490d57ef6-e38e14bdda0mr3239516276.3.1732206529351; Thu, 21 Nov 2024
 08:28:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-3-quic_chejiang@quicinc.com> <smwxrjvdvyxw6tknucl6fb5jpjau2q4jcyjxpunbtt5ep6xsr4@ztuyfkrwgxoo>
 <44932c08-000f-4e6c-89b3-d7556a0a7a88@quicinc.com>
In-Reply-To: <44932c08-000f-4e6c-89b3-d7556a0a7a88@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Nov 2024 18:28:41 +0200
Message-ID: <CAA8EJpq1u6ngze81LKAcGzQEJz=yJ-u6MjvRMJHdKp3aPVnewg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: bluetooth: Add qca6698 compatible string
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	quic_zijuhu@quicinc.com, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 06:12, Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 11/20/2024 6:44 PM, Dmitry Baryshkov wrote:
> > On Wed, Nov 20, 2024 at 05:54:26PM +0800, Cheng Jiang wrote:
> >> Add QCA6698 qcom,qca6698-bt compatible strings.
> >
> > Why? Is it the same chip as WCN6855 or a different chip? Is it
> > completely compatible?
> >
> They are different chips. But it's compatible with WCN6855.

So, do we really need new compat? Will/can it use the same firmware?

> >>
> >> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >> ---
> >>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> index 9019fe7bcdc6..527f947289af 100644
> >> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >> @@ -18,6 +18,7 @@ properties:
> >>      enum:
> >>        - qcom,qca2066-bt
> >>        - qcom,qca6174-bt
> >> +      - qcom,qca6698-bt
> >>        - qcom,qca9377-bt
> >>        - qcom,wcn3988-bt
> >>        - qcom,wcn3990-bt
> >> @@ -175,6 +176,7 @@ allOf:
> >>          compatible:
> >>            contains:
> >>              enum:
> >> +              - qcom,qca6698-bt
> >>                - qcom,wcn6855-bt
> >>      then:
> >>        required:
> >> --
> >> 2.25.1
> >>
> >
>


-- 
With best wishes
Dmitry

