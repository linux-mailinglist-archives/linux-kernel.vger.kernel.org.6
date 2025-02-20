Return-Path: <linux-kernel+bounces-523433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D57CFA3D6B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0ED7AAF07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297A41F1300;
	Thu, 20 Feb 2025 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S5vEYE2i"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81681F12E9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047312; cv=none; b=AXojdqiQaoLfdq6ijxXfE1vFmFa+VUKVjHUg9udmvQYe/Q9heaYmWnoP54wKRz5b8+7Jn48IRuHkGi61ch4ZgRBuHQiLWXDUx0aFt3wYGqok3MBpRsMcKaUw3kaxp74uTXADSxk01U8sXZrhFSxQuezLT/k1ozQ23gIM8AogTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047312; c=relaxed/simple;
	bh=pbqCbnn3949AQ4E9A+0vVRKzntefI3rHN0xAk0SFsaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFzoWr9M1ivKX3s1mlmE1v+BWshMiSs76N1nngL5cdxHbmdvjS3AMC3exWFSTa8Diwd8XcIrxP4Y0pXjODcxAvKWbnAP6270qqi5TUYgH2kFfm66tncdMTr7cp/R9CL1jNSwispXs3FYRvLwrSgEEDSO8FNqSJaHnurMlkwMRJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S5vEYE2i; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5452e6f2999so806350e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740047309; x=1740652109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbqCbnn3949AQ4E9A+0vVRKzntefI3rHN0xAk0SFsaE=;
        b=S5vEYE2iZs7zfqUnuG/NbJghV3PMYbcdJvqxWlGnw4mRohayyeJA27K8d6x4Ol8c/y
         SxlpdNnLKk7WTpzizGExJ0LS0EIvmdEa3hUiTQ6m2l5yvVEz4Cgs+V+uJvRR0PqOqiic
         5Uu4zOLPGjUXl6/uFcaMIBGlVqaPXMffdfxhiYJmQ11NtHt9rJqYZMsBdm9gY4cSb7cS
         1zHDYqYp/uV4rHU3acOrq2FptSB4ZjjM2v3UsjK4g9O59/M2IQ8dxHzcmySlT64K0nAz
         44DiWWYG/g8rfciYj3s6dXs68hDZqHMB7YidEIt0xcPmoh/gmEk5Opol8l7gIycX9OOy
         mKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047309; x=1740652109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbqCbnn3949AQ4E9A+0vVRKzntefI3rHN0xAk0SFsaE=;
        b=Sad+U4SIh+XVNAjnqSes6lvYqusR0tjN9+FOhpcW/DHSOSyEJDDi4/grQMCRWx3VVQ
         k++sMoFC20s+//t9uM5cpart8/th6bJdwHKLCP5mPxJU/tMq2r45KaGxowNQoRLNBwDS
         z4zsVA6P5xspjFTqr2Pf5dX7DuUccacs/v5/fUrijxVHY49HHVpt93WeBCw59csFUMRZ
         XffwXKOHMUb4XwnYmxI+5a/MOO74Adx92slFOk4XCDtO3lO3elbpVMc3o/nltOhd06Ie
         zuWVtX7yO2BxX78DzDTiSJEpRRx+Md6yj9Y0ZtbRVef94HBOcJXR0g6xbXA4/PBt5DO3
         Ow6w==
X-Forwarded-Encrypted: i=1; AJvYcCVXaadWNOS4xzxIYk+l4Pw5ArMFTAzTsHpAooaJWOXF8GjWOTK3bjtd0BhBPajkb++Z0GcpK7gH+6uOVpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyasKu7BvaEU0c/Qw3oqug0rIqnauwO5ZCX53Ldk23Y9U5TGJJU
	f26xteXFXDp+bERpwHdFVlr4euHfBEw4we5mYvwusQAC7FmNqwLQcjIKnHKoBHZnMbGxnKxDWHN
	t3QWoBl66x7c5Gi/qLSQFchChLYC1jWj6FZT/LQ==
X-Gm-Gg: ASbGncsqv7q6lcshS5BPSMp0TKqW5sL78VjFNdP8yUrX3uHwQBBmc0eA4MbMMhNi5kN
	8akZXyTFIchabZBieACxbcedsFpo5KbpjwdOl8gOROWyxA25+Pp0IPpLaOnEhWnEzcwjica3Eel
	ZU+0gnpMulIih3DrkfyQ8Lhryk2AY=
X-Google-Smtp-Source: AGHT+IF0hQZ/o7X6oVYIqlG9AO4qIYWcUHjPU9+7r0G2SjwNswpvYumQDzBci9SP50JD992GaVeG7nqS05hEGDgUTbw=
X-Received: by 2002:a05:6512:3d15:b0:545:ae6:d73f with SMTP id
 2adb3069b0e04-5452fe71c09mr7419846e87.46.1740047308933; Thu, 20 Feb 2025
 02:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217-x1e80100-pwrseq-qcp-v3-1-a0525cc01666@linaro.org>
In-Reply-To: <20250217-x1e80100-pwrseq-qcp-v3-1-a0525cc01666@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 11:28:17 +0100
X-Gm-Features: AWEUYZnBe24sPzSNetob_Hp5SUYrijNXBw3LzypTXZXkpFm_3GC1U29Nl3T-Itc
Message-ID: <CAMRc=MeAYTz-z6PK8U9XmEdaxXNT2zN_sc+wybdp6GzxTgksBw@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: x1e80100-qcp: Add WiFi/BT pwrseq
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
	Johan Hovold <johan@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:55=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> Add the WiFi/BT nodes for QCP and describe the regulators for the WCN7850
> combo chip using the new power sequencing bindings. All voltages are
> derived from chained fixed regulators controlled using a single GPIO.
>
> The same setup also works for CRD (and likely most of the other X1E80100
> laptops). However, unlike the QCP they use soldered or removable M.2 card=
s
> supplied by a single 3.3V fixed regulator. The other necessary voltages a=
re
> then derived inside the M.2 card. Describing this properly requires
> new bindings, so this commit only adds QCP for now.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

