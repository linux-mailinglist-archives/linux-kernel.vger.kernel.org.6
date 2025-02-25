Return-Path: <linux-kernel+bounces-531760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA66A44484
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DC717DEB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C9415198B;
	Tue, 25 Feb 2025 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpovPZ8x"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD181624C4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497596; cv=none; b=GmbnJ7O4qOOqSlmkimv9PEVcka5PS13oO2n8/bE3nEVXMgClz6rv0oGG+5M0Q2A3KIi/X+HvVCFW05VsuTJNLHOA5I/f+iSplSJw5VhUlXKQbuk5T/v3lcur3NseX2QjRsYba7MUKhGhXF+sp5uIpO6SJ+7f4LUnKLCZMhmBZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497596; c=relaxed/simple;
	bh=Tq0JAILQnrwUNJlWo2imokvsNwFjJTOC1cGqEdpzsok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgIvhXOKa/ef7dhM/asDDkVuhF/fJE6FGcyyY+lnWqRzgvkuHX96lkgANF+Ph8j0d7s5yI9+Mym9xkXDM5wbj5mamZPHFcg12pJdbOr6odyaOx5nDL3KLvxQuJFUaqIimR80iCYkJ36NoVUWKUGOkyi7DElMUNNGFnZa3G4+Ngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hpovPZ8x; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3072f8dc069so59180261fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740497592; x=1741102392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tq0JAILQnrwUNJlWo2imokvsNwFjJTOC1cGqEdpzsok=;
        b=hpovPZ8xTcI6Jy93VnRnKaYvPVMOb4jLhMZoy4QL6kidBbCPG97TSx6pM+72DpV4Yp
         d+DX6NJVro64tgeHkap4MLduQEIcgqAnMMVzHDuOsz78MPe0xdwAtoiKw9vyFPjt3LTi
         Ntr+CcUNVFIdF79sTe7fbWao2Gd2vJYzCJFp9zgTmuzWsYyEXyFND97M2yylntM3uOAT
         sFOp4VlfnbIUck0MfgzFE1lHGlGxyw5rsyU5mmKe8gptN8NOhgL2yMmGUfliWWsVJYqZ
         oIHrdo1+kp7R8ehTtHpYaFqkPTTz3lcT1h1UoyI70NtSlp6Rhkczink8svXXokJZIWMN
         wLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497592; x=1741102392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq0JAILQnrwUNJlWo2imokvsNwFjJTOC1cGqEdpzsok=;
        b=h/Nzr2olF8QUPWfL3g1I4GvYMI3Abxn5GonWOXfwBZYdf1QjN9Y9OBifJ9s7OwpCFF
         h9OzDQgd3kN777+MEO0VAM+0vJ2onixwlP2q061s8wplOd2kN7J7d8WkWCYohXi8gFLl
         Sx0oQ0td1iYcbvenpvUJPDQXan+b/K4Nr8PbCMRXGO1e7BbBxJwu7hJbC8pqcLsllAxh
         tqMjIDwuWZ26FT3nc6eKuD7PU1U8SUDW70hTuJwFIMzFMq1arskViwPKD1IdctIRKveg
         AKhJTD3uFCNFoP9i1l6KhsW3TmXbWTSCtLxBJPrqkcBWSnP+LabcDzhFT/Wdgs518+of
         kFTg==
X-Forwarded-Encrypted: i=1; AJvYcCWzPHUPgATz0L9V6UTERASLOVqTFlj9xkYMkaDRnX0KTPxqdzSbK/OBqDtbO7n+I5jmbNSOWKcC950J+4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlCKCz/FNH7j1YHi7Ct42svtTdarwmAYE8q94/VRWZ1JRIQHd
	2RobbpXZztxTC7npkHFVE90buwgVTceqS95rnbIKNS9gdiJ3G58oiyOZ6KqcsNiTB7dGPhAve3K
	WeZ9hFwIpy/c2iwblwwgveQasnAlLzp3SX1HnSQ==
X-Gm-Gg: ASbGnctNZeINgIOiNX1lqdCMVrsI02JLUqdEmPSOTtj8FW/PIXzIgYy0gNZeJ3Qf9Ap
	y9oqHzsqrmPI0GPiHrW9Fpquwby0n+aqvE3sNJzjEHfFfVRDbBO6TR/6UIXmuR6W/HQ//tlLid7
	NI501k/vk=
X-Google-Smtp-Source: AGHT+IGObra9Tx3ZHxqC0tnEIpcJ9EtsRQQnnThFPr2iy8wxSLtweQx5fZAZ2r60/7qKj5zUv2tlIOi/SsAuuP89YE8=
X-Received: by 2002:a2e:9583:0:b0:302:1fce:3938 with SMTP id
 38308e7fff4ca-30b7915f78dmr51951fa.11.1740497592318; Tue, 25 Feb 2025
 07:33:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com> <20250221180349.1413089-3-vincenzo.frascino@arm.com>
In-Reply-To: <20250221180349.1413089-3-vincenzo.frascino@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 16:33:00 +0100
X-Gm-Features: AWEUYZlmYF-dBAz6Af0Nh3BXuPzjG8T7cjYs05yRSwlUmuQ4nt6ckOluFYjoK9Q
Message-ID: <CACRpkdYR7zCOfRcbixPbtupLue-QsaCCh5WyX-fGBk5zMQ15NA@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] dt-bindings: arm: Add Morello compatibility
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 7:04=E2=80=AFPM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> Add compatibility to Arm Morello System Development Platform.
>
> Note: Morello is at the same time the name of an Architecture [1], an SoC
> [2] and a Board [2].
> To distinguish in between Architecture/SoC and Board we refer to the firs=
t
> as arm,morello and to the second as arm,morello-sdp.
>
> [1] https://developer.arm.com/Architectures/Morello
> [2] https://www.morello-project.org/
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

