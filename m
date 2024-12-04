Return-Path: <linux-kernel+bounces-432241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F47F9E4825
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38FE2845CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E275202C33;
	Wed,  4 Dec 2024 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gJ9Buxxr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC211F542D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352569; cv=none; b=fmgDHxLz35P4/LaHlTpR8VfMmR03U4tqDIRrK7idvtEXY4IFQgvYvgasX4sFR09h1XnKfI/cMqY/Q40OPMsTpXP7YllhaiNqOG56K79eRgHa1vL5Sk3fP9/Lwe0YLRn451vwtTrnqZYSaNAwHqhVoctZ7oNV4s4qNbThBGwHHwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352569; c=relaxed/simple;
	bh=TFhy+fON5EYXB48RBtCSmjPevQfB+1YjtuhEruheq8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p818qeLd0ckSbbjhg74l0IiWCxrJRR9xXe4yajU+aFCN2hXT2Yjh4Y0+91IY85YsDgs4SI8sSgsiTIUjlxCikHVdo3i+aZt8paE/kpkk4P4GXartladmcMmoKqqdD+Vg8RbsqsBJ1b7DAAcAAJ12jHheahTAbLIPUPRRkaMSSbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gJ9Buxxr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so1981361fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733352565; x=1733957365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3NqyklxNKjn7GA1Xiioa4rdBEF1bx3QvQxtDhyi8+k=;
        b=gJ9Buxxr4i+Zh6zHQ84t1zFOu/ew1Y4U7mWy78f/U7w/hx7N8N8W7d/jJG79Dh0xJ8
         6ZeRKcS6YXNTjQf/WbV+IpV8jp+ObWuYrVj1YDZWKlmXyJl0+s2dXyd5a0X46Ci8brFp
         VhMqaetajVFBEXAMLIW1NJ7MjulHdFgN00v+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733352565; x=1733957365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3NqyklxNKjn7GA1Xiioa4rdBEF1bx3QvQxtDhyi8+k=;
        b=MC3JBNYRPPMwOcsWI2N4saikoAmJ9MwzF5f/GOXd6eySLkNnpM1U/zdeuxponEkopJ
         c9ZMRLxWlmc18D7II0EiaF8vsJEmv8XfhfigqOQmgpHv7YPagd/sZh6YALc1qrCLMdBE
         8vuqqN3nIgVnGhgGUViTfzb9WYcrw4BUByV/u6zKcstT43jcFSomxFocuirO/Ebx5tcX
         keMF0WvblFfIDhS+H5K2RZSeekLAINkqDwr0HyZeSHEcRFtLm3LbanhWvETD6ws0HLE2
         Vh5h+o3SgdgeD58T0UXB5NWG0j4HHaBpPS46QKKANhOLiOyjURKPFUNKVP3KgGPGsXI+
         5QcA==
X-Forwarded-Encrypted: i=1; AJvYcCUK95KUwv7wkRXBIlM5KwAT85ZlpkEF8NnaKvKbgBFFm7Th0OjFeNlRYrRaWdGuWKwFHYDOnbmbfw+7WOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFEBcUz2ksFKv/oc2Boay9WoY9ugov87ABajQBwjqvMLh3FVK
	XVGhuKAd/6uUfiCnTzutqQSKHY3Zc76Jq/4XKtqeaHH89sLuOr3no/bu6m4/8XvPqq0nExglrri
	/RE4g
X-Gm-Gg: ASbGncsbVqmH3wzugsn7LOqqIzQweY7zBSwiWM9n8gMENu9h02ztIkelwEPM7/1AnnU
	E2RPIA6m24/jkwYXY3VVizrHl8uBtTLIeSHhsLCmi9BK+9FajGq8q0zu2CKAwkFmw/+uDlwjb3P
	nmjF0Gn9qOE3QSrZP9g7rTq3jA21IECQiBruGZkcOMtXZ4PnMkX1iE2vxpZebihtjDDGnBiSlaZ
	QCbNwvdJiXoyvUmFbFV196kyjMk7n6Cn19b9LjxxCp0qAALgtG7eZ/uuGUGA1sNeWdvpTY+jyiV
	hLhLfxCPVO3G7NXs0Q==
X-Google-Smtp-Source: AGHT+IFZ5sq2pxWWRKFS20g9hOEkxLgfKhKlaaTOD9IIrcXSDT6dGP8tqeqF39DQG8od6Av+A0IcdQ==
X-Received: by 2002:a05:651c:892:b0:2ff:c77c:c71e with SMTP id 38308e7fff4ca-30009c9e079mr73752291fa.20.1733352564631;
        Wed, 04 Dec 2024 14:49:24 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020da0296sm87911fa.33.2024.12.04.14.49.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:49:23 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so1640081fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:49:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUUX0AWRh8AXagCwbyBJrOMN3WOCNBct1wgs2ZVZBVeAoMMLV0lKe2SG3Td9w+pzYlEcgPLX75xtY1t2Y=@vger.kernel.org
X-Received: by 2002:a05:6512:b0a:b0:53d:d44e:fae4 with SMTP id
 2adb3069b0e04-53e12a0687fmr5763487e87.28.1733352563093; Wed, 04 Dec 2024
 14:49:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org> <20241204-topic-misc-dt-fixes-v1-5-6d320b6454e6@linaro.org>
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-5-6d320b6454e6@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Dec 2024 14:49:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UKyyp4_BfHwpYLEB-N+-R0P=RVBsUDHHu2gS=Zwi3WmQ@mail.gmail.com>
Message-ID: <CAD=FV=UKyyp4_BfHwpYLEB-N+-R0P=RVBsUDHHu2gS=Zwi3WmQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc7180: fix psci power domain node names
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
> Rename the psci power domain node names to match the bindings.
>
> This Fixes:
> sc7180-acer-aspire1.dts: psci: 'cpu-cluster0', 'cpu0', 'cpu1', 'cpu2', 'c=
pu3', 'cpu4', 'cpu5', 'cpu6', 'cpu7' do not match any of the regexes: '^pow=
er-domain-', 'pinctrl-[0-9]+'
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

