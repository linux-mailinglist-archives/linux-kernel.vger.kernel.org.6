Return-Path: <linux-kernel+bounces-329999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477DE97984E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDF028225F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F71C9EB0;
	Sun, 15 Sep 2024 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ItnhACcq"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243271BC59;
	Sun, 15 Sep 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426956; cv=none; b=U6vm6TYPI8vi35fS5b1+mOd3+aeuXTFpdPNX/V9Ev9d4fidYM+qj6/x7iHMLEYNZYqjdMCOrhDjhZpgoSsdDZI6qjVQQJOYQPNQMZroL1z3hFoIYFuYk9TD4p/4Ou0EK9Q4aJt2nxj+1mI4xrbJh+yMHx17Trv8okgRu3ZSoxy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426956; c=relaxed/simple;
	bh=LRTm9QMs48zKJ6w3wCdNSSMFbJon0s3OK+Yc/61thl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqtbYJASfmz4qTGy1RyG69Pw1qEwgaUAcfddoAFzZDGxu5T2Vakh2BXTP8efFnZ9H9wjbmihTjmIkhNQ6ZpBi2kuv5fE+HyW9f7QjP5D4LKwCySyHJrHfSDVmuxU3GvTJDQIKWb5HLM6W9+xp+xOwsJZ3C72XwPQ8vcNmhDB//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ItnhACcq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-205909afad3so39658615ad.2;
        Sun, 15 Sep 2024 12:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726426954; x=1727031754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl3JgxfsDEcMv93irGGWEQMK2kPdpMNmmbqbOCPjeeE=;
        b=ItnhACcqhcjHMQ8+zVVHfAkWn9SjQWzLIt/okZ2LQRATrxA+mR/wuLpqZMl8W7PPHi
         LaZVOFzrFZraJz1Ot1RVZUeb0oqeW1K0IabtydSaD/NYyU7JtLxR0HuxZqcPAYo5/Rbc
         OJdzGm8AjTyShJ5OW3TNhY7RtcfZw5Jg7fIl5c1evo9OjBSCSmuwu2RigkDtX+3wEiNp
         S+fDL68/GevofJdNtSEN7Y7dl8uFaejlHTKFlv1Y0SozBiYSXKWF17dwfADg/t4yxcTj
         qmEIhursWPgD6wkIEqxMWJx8eOSOlwJ35Ed86zIRT7YNTR9gOedRh+g/Ng9miwKEqVWX
         1a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726426954; x=1727031754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl3JgxfsDEcMv93irGGWEQMK2kPdpMNmmbqbOCPjeeE=;
        b=u1g2qn3iK+SmitskQZ+CwuhVelRnxyiXhmw8zgOMDaROpBVhnjM2pC5QbEDJSwK7d1
         a/vUCSXVwOaFXhfRF90JEqY7TEi4e1/eDzhUKwU/nzLiKGCCFSaA99sYwTkwfMEhufht
         VVBQSI2REwZ3+COxWoUm8ZWtjsHMe1yK97J8GOdTQGxQiCh+9t/4qWAsQnBS3IPr+jiq
         7Ei05WuuBqMF6sj1DJ0Q8BePDZMqaF7wxZUg978sHfdTnwXGtg/GyHvlFA+wfuvFl7xC
         2LLsqWq3KEj3de5v8eMrHEPjR/f6S9ijN6k/T3kcXCk1IawBIzrgP/gv5406xQaYtY0h
         YPWw==
X-Forwarded-Encrypted: i=1; AJvYcCUIMUdeLETFGinCltwZjS0Bp63jvbzaHXTkAoqJQrV5No/Yy5qSZbN/3kTfjoqwvD7+Vg1ndUIV1HMc@vger.kernel.org, AJvYcCWOI0wNNddUzafcd3k/1zwP1vI+rBc50Mfpa4AZfc8p8cM8caQYKUpLCrCy115MSoyqP9BYSb3zT+p/i3EL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp64kIYhBhi8OZdqTmw9zfO79EzuI9r5eb3tmZ4/5zjBAt1iHV
	Ar8e82Ro8F+uNczL++cVrLn4lT+j/OVwn43T7aJymKSd2ggoZf/SYkcVv9tG0yrG9QVBgb5NZjo
	0yT3t/pM1siRkzklSkncPX30p44A=
X-Google-Smtp-Source: AGHT+IHUhNgb5CY73OVQ923HMu5EESIjBPBxS3vs2jfupJZ1tMBLM2XnsxoP/DNupYRnYP+/+zH2b2BjxO/nsut89FE=
X-Received: by 2002:a17:902:e5c3:b0:205:709e:1949 with SMTP id
 d9443c01a7336-2076e421fd0mr213345945ad.57.1726426954359; Sun, 15 Sep 2024
 12:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
 <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-3-feaabb45916b@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-3-feaabb45916b@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:02:23 +0200
Message-ID: <CAFBinCBj5OoJ7DqwhfV0RGZjW681U3ELqm=LX13XY3RAO3S19Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] ARM: dts: amlogic: meson8: fix ao_arc_sram node name
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:19=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Use the proper node name for the sram, fixing:
> sram@d9000000: 'ao-arc-sram@0' does not match any of the regexes: '^([a-z=
0-9]*-)?sram(-section)?@[a-f0-9]+$', 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

