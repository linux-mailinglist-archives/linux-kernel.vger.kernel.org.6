Return-Path: <linux-kernel+bounces-185357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949A8CB3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1AA2836F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F206314884B;
	Tue, 21 May 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4ji7tJl"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C014900F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318017; cv=none; b=H7Vw61rk9NMcIDuGvrUDnkKH2nWPqj8w6SG0bvfiEorYww0XE6r3zPHQ0ViJjK3m+wxabAsZsO0EV+U++D4qSLu5bYqQFvjOML7Wn7q7lVDcQB0vc61sZz0yavpg6sBuTiaL0c3Oo9REyQJfv1dBLMJrnqhuawU7wyLwIGrWrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318017; c=relaxed/simple;
	bh=Y4kAtq2u27/QT2c8cc/6K07/xzsH3x5mStJNRe+bsuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2KSUMMsjz6FrMh1AIh+GKtYZjo9GoJZGw+YJcuoGU9oY4Z9W/Lp9yi8TWnuGB83d8v2IOAXWfPAxYASpmBqXlh4Bf7Vj3OM3xcbQxn6xIP9gqBxSTegGj9g4BX+sIzVxS4aYusAPc3a3B3SESE88GQEtNkLoGTKPpRJWcClpzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4ji7tJl; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6153d85053aso17797b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716318012; x=1716922812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j2dJjZszZabWmG8eK2HsvGgJ24f0l3khGbuW2IX85+M=;
        b=s4ji7tJlWsBErxZeYCRwjlB3Yy3Zr5QJ4Szh/wABWXAd6SXldYAMdjwQEJ3T7t/Vhe
         MCJkIZB3d4hwZthWdwKQkFqb2WsGrBG/GqBfWumO3v/6HV9x0LphdQN+mTC3EzzN1een
         BchVlQ7JazH//iMi3lv0hDZtEy54ZT7Epdeaccp/8ZPwxWwHsZSdgiZ2L36a8oXYC6j5
         kimjUpeCR6c8uyJ6CkEoNbkdE+Vp0M/tnJ0W+1NVnVxZDX84INlKJ/w+B/XA3zcKYPJZ
         T+E/Ks0r1Byodo21owCGqQgSo5UXul/mLaKF8iPNmauCIWieTiZfSSkcZVN09myjc4i2
         NqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318012; x=1716922812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2dJjZszZabWmG8eK2HsvGgJ24f0l3khGbuW2IX85+M=;
        b=uDDr3Brlc9Nc1LEportH4jciEkKB/rMk7FUl0soxwam/Zldg91e4e2JgYw4ti2m15f
         k8FngOIVVJuyMptQLfXsDpSU34z5Ho8y5iPbmV8vKQiqpTmypow5Bn78nmyGVewnn9pa
         SlQmZ8ctlFRqz4VH9qEG1hSgMjNxdBW6yG7ynm9nBsH0t6d1LeC0W6mMJ2c3SwnrSl7h
         2rEBNc5eIqjcFCgQjH/fEg0ugajZnRACE3oJQU89mNdFVdUvg1vMH35QNJ6h8Fn+OK0S
         hnu0qNDaAeNe8sEM1cV8sZGOl754b2ora9zBi6/lkOD3aOoy8o50t5APN1ScsQfUlgGV
         ucpA==
X-Forwarded-Encrypted: i=1; AJvYcCX8jn6rVZHBDkWZC1NAZaD7zK4f6YoecjRZCe2LmCzwbMkKcZV3ExSAA1OmNpEMg5/32yF474co0locdbQoyyBgU6ry4s8vaf7CezR+
X-Gm-Message-State: AOJu0Yzy1MuZNMmrGiBM6IOMlCSdlx5nFEISVazOToYZuVglEJ2U7dcg
	zsxLZbLsCr0P3tX1ZbBOwWoO641+vfKZeFYerJtb6FaBHlM8XU58740pRJBylzF09A80mThHDjH
	H5z50iYAxoMDcLoxovJnf6TmK9xx8R0hRPaZiPg==
X-Google-Smtp-Source: AGHT+IHps+GRz537VGqn9WNMddSpdygBCzdOT0qoyGTzMRpEmepGJPUIo/0kWhUJl0kN5U1agql0O+39Wkicam0iijY=
X-Received: by 2002:a0d:d78d:0:b0:61a:d2a0:5497 with SMTP id
 00721157ae682-627e46aa110mr79027b3.8.1716318011734; Tue, 21 May 2024 12:00:11
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-board-ids-v3-0-e6c71d05f4d2@quicinc.com>
In-Reply-To: <20240521-board-ids-v3-0-e6c71d05f4d2@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 22:00:00 +0300
Message-ID: <CAA8EJppYmVMmhgLSiSEGA_r4hFbQYriOLjNK9b6VXUYEYiZ6Zg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/9] dt-bindings: hwinfo: Introduce board-id
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Amrit Anand <quic_amrianan@quicinc.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Andy Gross <agross@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Julius Werner <jwerner@chromium.org>, 
	"Humphreys, Jonathan" <j-humphreys@ti.com>, Sumit Garg <sumit.garg@linaro.org>, 
	Jon Hunter <jonathanh@nvidia.org>, Michal Simek <michal.simek@amd.com>, 
	boot-architecture@lists.linaro.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Elliot,

On Tue, 21 May 2024 at 21:41, Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Device manufacturers frequently ship multiple boards or SKUs under a
> single software package. These software packages will ship multiple
> devicetree blobs and require some mechanism to pick the correct DTB for
> the board the software package was deployed. Introduce a common
> definition for adding board identifiers to device trees. board-id
> provides a mechanism for bootloaders to select the appropriate DTB which
> is vendor/OEM-agnostic.

This is a v3 of the RFC, however it is still a qcom-only series. Might
I suggest gaining an actual interest from any other hardware vendor
(in the form of the patches) before posting v4? Otherwise it might
still end up being a Qualcomm solution which is not supported and/or
used by other hardware vendors.

>
> This series is based off a talk I gave at EOSS NA 2024 [1]. There is
> some further discussion about how to do devicetree selection in the
> boot-architecture mailing list [2].
>
> [1]: https://sched.co/1aBFy
> [2]: https://lists.linaro.org/archives/list/boot-architecture@lists.linaro.org/thread/DZCZSOCRH5BN7YOXEL2OQKSDIY7DCW2M/
>

-- 
With best wishes
Dmitry

