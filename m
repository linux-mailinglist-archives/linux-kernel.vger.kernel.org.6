Return-Path: <linux-kernel+bounces-381114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 885499AFA88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEB42838F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13D1B0F24;
	Fri, 25 Oct 2024 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K15Fe2EG"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB5818C021;
	Fri, 25 Oct 2024 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839628; cv=none; b=H4TI0u7Qy4WGg/dAiVTOK3jsJdK2jVmhBCZJUN6SGnRA4ZjfxmgLRqqinXldesvBTBfGaTOWPW9+IFmVLebOUg/0v+bIYItHIGR0MtlZRP+1YLSN/nkRtnrNhWaM3fd6DrHedGa5K5udQpEnyvpP/8CsUBMjuoTHh+o5eAdCheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839628; c=relaxed/simple;
	bh=tRqzSPxl//A8Xi9j/Uj7B60dNsxsbQ6BPI6dSwlP0sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEBhg2F2rXcDoxvtso9bSr9CzSiFZadrMxgw8mBgY8yG31NwU1IzA/yv7d16b1+/vRxzWyrDVMkXf7T9P6PNAx8uM7YECI1i0sjeUzi491YDvFxGY/QPpJKilPXuEvBZA9LChP7NRYs97wexxHIE6MhT+yM6DxEb06wgPZQZB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K15Fe2EG; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e29747b7532so209091276.3;
        Fri, 25 Oct 2024 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729839625; x=1730444425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRqzSPxl//A8Xi9j/Uj7B60dNsxsbQ6BPI6dSwlP0sA=;
        b=K15Fe2EGhowtOe1FPIw0Le51Vo8wd/RC5rqLMNVIxeMYMdkMFEIpkD4Dctjx1IerdG
         dH0/nDhfXKnvZ/UD54OoverBpOURtdSF+upScWNVj9rBUzQXj5HNXAH5d+5fcnE8fjpQ
         TWvXepiI6sgYUY0Gqkntc3dfpAI0UhjHnKTYP9tVXR0AdavXJLD/WtOevVZEi/iUD3xh
         adQ1N1jom1W+k1CkdH+JbyeZEl4ax2FPKuZ4KkqQjMppIjP/5DaYYvZbrdNQ8+fV9WKC
         cPNlPxIwhY8Bd64SJl25BLcvVaE+DvP4P0Mb/P30J7evZ8gVnFfU3OAg+56dBxwlnIKl
         QMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729839625; x=1730444425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRqzSPxl//A8Xi9j/Uj7B60dNsxsbQ6BPI6dSwlP0sA=;
        b=sv5g5sqZeQWkgV+AgWlrEElxqjKLSigfuApi1kii+bnIvxFZEWpZirZp9NE2Zg2yWH
         WHl+VrI0WkKGHkUQ2UgKBDOWbkziRT1+ftEdOXtooFXiiwivcEVcugCs94iKkeoEf0uF
         eFziUpgW1FQ6oqpvCuSaqUyJDVelxRSCLLXRpdONQKSgfQe6oAObFyX1gbdb3R0ueat4
         RvdAT3FfnuMEw8Nj1GdaHHV0rm8+WgHpGLW/23cB9bBLZGdp6k6NR89OjzSeFTlJ7hm8
         8CjZy0Um0fk8JCS2zLn1pfd1LKt2oWkHmUv9SQy5lVUJZfG8N8pPA5oub+5nuMBzlgnV
         KKaA==
X-Forwarded-Encrypted: i=1; AJvYcCVIQ0XS2QzGHXPN2S5lAGMKsRHuUUlbfwLhGa6DskX6LF52nol58rzEP7hc1yoUn30Apzyuow5YhA14@vger.kernel.org, AJvYcCW5qd0tjZpJl03CGH2zDecJgGghGA8ceK/CUV+OqkG6wDEYy98ttxD81M6+1PJhxsLcgO5qAiLHkP2yMpn8@vger.kernel.org
X-Gm-Message-State: AOJu0Yybez80Vwdmw5HqLBkbK1bL+ktxQOdvzZptvTrqbgDJCec3emK1
	Hg3yOEuGcIxR7EfWpERNoGbkKT4ixN9C03kKsOg1kT2A9uhEH/OvP2QhFIp3TYDN72wN1gm4dR8
	xIPncxojbE8ABeshQTIHnNXAvzJQ=
X-Google-Smtp-Source: AGHT+IEkT3x7HvFzL0vQRTHYvRqAckw95IbfIaqDhHXoKMBPeU3ICzKT6ovE0XBQjDT/IeSSpjZOXJxIka2JdKt61Y0=
X-Received: by 2002:a05:690c:6b0b:b0:65e:684a:2d95 with SMTP id
 00721157ae682-6e9cab9c2e8mr1388927b3.7.1729839625052; Fri, 25 Oct 2024
 00:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020194028.2272371-1-l.rubusch@gmail.com> <20241020194028.2272371-13-l.rubusch@gmail.com>
 <v4gqnsyhqjccdac3kgmo7y2aunigqquqc3f7n7wgt5hiv3rnip@jfmoq3is4rjh>
 <CAFXKEHZOPioES4guqjco+BE7i=Eqe2DdHiUxAksBCZm7nx1Rog@mail.gmail.com> <cdc7032b-4d09-40dc-86a7-16d244517d11@kernel.org>
In-Reply-To: <cdc7032b-4d09-40dc-86a7-16d244517d11@kernel.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 25 Oct 2024 08:59:49 +0200
Message-ID: <CAFXKEHZhGEJhOxqX04fAR6qs-vee4+-DWC4_pNGaDCzEumMsiw@mail.gmail.com>
Subject: Re: [PATCHv2 12/23] ARM: socfpga: dts: add a10 clock binding yaml
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dinguyen@kernel.org, marex@denx.de, s.trumtrar@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 8:24=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 24/10/2024 08:10, Lothar Rubusch wrote:
> > On Mon, Oct 21, 2024 at 9:05=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
[...]
> >>> diff --git a/Documentation/devicetree/bindings/clock/altr,socfpga-a10=
.yaml b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
> >>> new file mode 100644
> >>> index 000000000..795826f53
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
> >>> @@ -0,0 +1,107 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
[...]
> What corresponding txt file? You are adding new binding. Are you saying
> you duplicated bindings instead of doing conversion?
>
> git log -p -- Documentation/devicetree | grep -i convert

Please, try the following:
$ find ./Documentation/devicetree/bindings -name socfpga-\*.txt
./Documentation/devicetree/bindings/net/socfpga-dwmac.txt
./Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
./Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
./Documentation/devicetree/bindings/arm/altera/socfpga-system.txt

Currently, bindings described in these .txt files are not covered by
bindings check. Is it supposed to be like that, or is this just
something "historical"?

I would appreciate to take the opportunity to learn more about
bindings and bindings check, and may try to convert the files to
.yaml. Is this ok or do you have plans with those files?

If noone speaks up, I'll put my name under the maintainers in the
.yaml. Let's see what happens (I hope it's ok, due to the high demand
in cyclone5 these days...).

Best regards,
Lothar

