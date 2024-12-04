Return-Path: <linux-kernel+bounces-432238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B339E481F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5FB188048C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBB21F5438;
	Wed,  4 Dec 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEoGi3lD"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5718C932
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352529; cv=none; b=jf2IW1x3uyhRKtx6+kh3Al1Y50DtavvQqOEzfWXpFErA0oFNlIMcsAaIP/WRnNOrZB7dDAWEjkOnKlcpGoyXaS9kNdI6YIVYYBpTLtniBG2QF854gBWZ0tTUtzTToD7qb4TJF4Z0NY1NQU8KY7YVmojZjzeqrWSI3yHxOZJD6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352529; c=relaxed/simple;
	bh=TSj4StKekoMWof/0a9RDpcEaVlkxhZJJcFqRiqpRSp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jx4heDWG8tkMHutuQV2iUlhI5zX3XQqquOVf/pXDLB8H2HsWov7EVfiNYfnOhFs3MV1ukj2M+nBXxfzQfOUAhX1u2a3uvA8hrxIsJsqQnpSDW8ps1Bf8cALg7nU7WZ56uT4N8PagHLiZDXyETysUCFyLNPYPL/JFGljQTtQfgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NEoGi3lD; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de6b7da14so315638e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733352523; x=1733957323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS5St45eHSe24ISFP3PYGVU7STuxo7md32QjNE7kdII=;
        b=NEoGi3lDwp6W1/daj4d9A3avq1l4mkKCq4sqaRrGFS8YKoO149M2vlLirdwDPuxa/H
         NgCziL3wrG3mxLaZtQFTenhQJu32FbS1jtJQ6fSdlVl9j/gHRFTxF3DWiDuw1Gssi6r3
         FR/dUtKlAbIlbTHX4ct0qIzY36Ywv1SAb1xKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733352523; x=1733957323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eS5St45eHSe24ISFP3PYGVU7STuxo7md32QjNE7kdII=;
        b=QOkd4L+OHFxiMuPp9zbVEbuh9n6dPOc8KjVyt6dwIxJbkgC7+LU3pwmoHJNTf3B06V
         dsttP9NauRQfOd8zSRthan6vfH0wbU/cK0LGI/foSsUVtsEf0q8vAqUBlBNp1F7//qls
         UNVJP1e/BVlzBTargRU/Cm0zCoZi69LkOoNxOfW0D8Mf6AgUdi5p+0/U/vaY1xQSEt4F
         WK3AMBssbcNK+yca1UQODB+NjRt4iAv+pCT4goiOoCBm91QoL46ovqtlm2r2q96jiNs1
         t4z7nBIe/nC0CH9u9eI0PyqxbgMxrgQ6QOWYpy36Z9YL3rcysxmAgg4dAacq3QnylwEY
         9NBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+IfvctJ6jcljnkAVdf+tmODmiTFrwfgq/smCehCgQjX022tyO0kd3gLGvq0OKsItH6hMgiT2rFJ3gppU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIuVR5zt4iXgrfUrxw0rZWsAc5rOrwlfoASSeDakmskZO/zdHF
	On1jOxzKqCcev8inhvlSmtGJMwbOkiQmgEtcfTdI7lBydAPMDzFtwc2Rn0oV5WUv4TNBViMYsh5
	E9RaH
X-Gm-Gg: ASbGncsmCLOG5nBdqVdIESIU/UK5NbvmZbZl90B+5eSD0Nln9CUEoRbUrPs5ztcgPIK
	RCDs00mlfqCpVFFUtSEtEwuXnGbxGsclqu4V45KX1gTDjpTMJHZ+LEpTRTgQGmzWaOsmDb0ia0N
	qC0O6kY43Wf+wvmmxL5vqzGFm7YMZ21UXRGXNRB6Y3bkyLeqOIcQPn43bM08yxZK8bpBQ3l8SJ8
	14clYL6WAXU/c0CANsFC2EJIDJvG4NVQ4aN0PX9gI/G+w/calBi+sAiscKMf6ghJoKt4b0+5owp
	CL0PxWzQGYO4GA==
X-Google-Smtp-Source: AGHT+IFhS79gnv6j2J+6E8hDnGiVKl7PnOv9cBwgG5sc8vWttw5iqsbIGpZLm4sfQ342rNZsblHy0Q==
X-Received: by 2002:a05:6512:3111:b0:53e:1c3d:fb2d with SMTP id 2adb3069b0e04-53e1c3dfcaamr1265772e87.0.1733352522757;
        Wed, 04 Dec 2024 14:48:42 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229d9913sm24365e87.283.2024.12.04.14.48.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:48:41 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de852a287so309274e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:48:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWt1t6XDp97QDe36DyxVlFwCvuiLq6NzhYJVj+ploWQiWViHGcd7sEfHfthDepdmhOKHZpBt/G4EgYTi8o=@vger.kernel.org
X-Received: by 2002:a05:6512:3087:b0:53d:ed89:d78d with SMTP id
 2adb3069b0e04-53e1b8785eamr2316814e87.5.1733352520879; Wed, 04 Dec 2024
 14:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org> <20241204-topic-misc-dt-fixes-v1-4-6d320b6454e6@linaro.org>
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-4-6d320b6454e6@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 14:48:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WMm5j60+jn9JFYkTDgm73NOHU5SAxbWvXOicEFbDySxQ@mail.gmail.com>
Message-ID: <CAD=FV=WMm5j60+jn9JFYkTDgm73NOHU5SAxbWvXOicEFbDySxQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sc7180-trogdor-pompom: rename
 5v-choke thermal zone
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 4, 2024 at 2:57=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> Rename the 5v-choke thermal zone to satisfy the bindings.
>
> This fixes:
> sc7180-trogdor-pompom-r2-lte.dts: thermal-zones: '5v-choke-thermal' does =
not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pi=
nctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/thermal/thermal-zo=
nes.yaml#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

