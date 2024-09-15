Return-Path: <linux-kernel+bounces-329998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D0497984C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B141C21323
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C481C9DCD;
	Sun, 15 Sep 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ex7xvI8A"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C061B85EC;
	Sun, 15 Sep 2024 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426939; cv=none; b=JskrcvauE7GGjmI/ISdzTAB/hsbMbAlk7UnI1dmzoU8EXxu2Mc40xfRoOiiClUu2oxkdHEUkvzk0TBiv+Cisq23u9K2VTvQOUs39WJQEhdcbo7XNqLFsLTYXCTeiPsZylZPmcApxvh03HQ42XhUiYDeh8yr9HSU9yUqB2s6G+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426939; c=relaxed/simple;
	bh=H5Hu/8gjONjIyi1nXJ1H/zgchlAiM87cQq8+/OyBoSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knLxpqvDCWo2FzeIk0XeO5PucO9wGWMvBQ71cgme+Rb9RECLEe6n/aH+QSmq+GIPqV4rJYohJGzgMCFj1plzL2xpHMDhi1speRWlDl385+z5Jl3Y0C/NevFe19xkuqCXH3Jfepf6GbLWooo8hD/9qMGL/Wyr1dxpZhTEewfzA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ex7xvI8A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2068acc8a4fso22813545ad.1;
        Sun, 15 Sep 2024 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726426937; x=1727031737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZjqU4AINP/IiVa4kPndu35gKyQ6yjWUa2bBBkDYEpo=;
        b=Ex7xvI8A6xuK9ZyBoYY9eBjDu0FK3jSOgeYegRc6qEn6GwWWJxI2pgpoRRAhIGJ3mc
         rPfkx+YQNk9Agu+iLXIcPkKbbiwzyrCdXye+d/Sc1Q+tvVY28q/EtKfNqXJV9k1/dwbj
         MlQRSDhvU4EZJ0JdDNWg1gJ1K/l74lrYTlHrRYGpk8AvhKwZj/dhY/om+Ubfnenq6u+d
         SClZ6m7yDGzAhhcBFHakXU8ruLb5FKmf+X+wPD6RoWdRJuXX8Uhrb8AvhSe+X1Ug193k
         n5CMoB4SdF5oMWBdVOGufGxPkiBEk3bFlEYkbxY3uyy8l016bwdc+G03SdRMbcIzC2in
         Y2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726426937; x=1727031737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZjqU4AINP/IiVa4kPndu35gKyQ6yjWUa2bBBkDYEpo=;
        b=TNcv170VGQ0W1kHYepmmQ1yOOy35+fWjN8KKYhUpgawGuU3V97cPEHOnz8Gk0f2Lnz
         sR/2Rkb8eu78JAMIrPHuMk9yqHN+oPw10LNB5Szag1CUGNkdMHEdc9XjMnP9AmuNzqZj
         1ix88Sa4REv6B6alIkw2BpnniDOta03PkCGXNoP8VaRkF69miSRYgPBtzyuWvIVZhVK8
         xFSCjxYffRSEQzofek1gNXKlzeXD6sskL5mH3NIT6l7oWuPgstQN6cN9u7tCX2Z9532x
         0+jApR5qOCohsTQ/bSWqrYOWANpYhXv2uMWLGpPZ3TkGby6YrHtPuBIWc7v5DhugnYk/
         CTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWYz5eDENUKB2KJzPl99znGG+C8JWR0Lv9BUI3GIU1nXsj8cOZObiz1hoj7GAlQ8NnFZiTzgCUZPgadKxE@vger.kernel.org, AJvYcCVszUN4QAr9ryIai1poEfPe8yMfo5PprjmZ0M4o+beFiBRhhnZ45JIVXl9nqoeWF9IRa3wBmREu1usT@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIwbWIFZJo18PDTxONeorufIAHyGpAcwCtsUjMgO4mMOTUq+Y
	G0GWrcXewOwH7xae1F9sqeCO0EWvjP9aG49tMTmlTuU1/o57PLJYBAQF/tmZJ28e0ltsZ+cUr+I
	i5s813ETKKDK/3n1fNyj4lgFSi26APdmS
X-Google-Smtp-Source: AGHT+IHe1atv/v02eHxBeLSaQupGAbcdfb73NBASPB+dRd+NN2OC/Y8NMPRVfzEtOWGS4P74u50FWjgUkjJh6E5mYEA=
X-Received: by 2002:a17:902:ce8a:b0:205:8b84:d60c with SMTP id
 d9443c01a7336-20782b642a8mr164239225ad.35.1726426936833; Sun, 15 Sep 2024
 12:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-0-feaabb45916b@linaro.org>
 <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-2-feaabb45916b@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-v1-2-feaabb45916b@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:02:05 +0200
Message-ID: <CAFBinCChaq4YF2koPnRaSCJpP=qSZVpRsqCMmidnHzF-TPjX9w@mail.gmail.com>
Subject: Re: [PATCH 2/7] ARM: dts: amlogic: meson8: fix soc thermal-zone node name
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
> Use proper name for the soc thermal, fixing:
> thermal-zones: 'soc' does not match any of the regexes: '^[a-zA-Z][a-zA-Z=
0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/thermal/thermal-zo=
nes.yaml#
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

