Return-Path: <linux-kernel+bounces-193791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB928D323A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A321F21774
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C362F16EC1E;
	Wed, 29 May 2024 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZsw9ADR"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22421667DB
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972423; cv=none; b=LBN7xsPuNI+E0cFqRqDUzoTVob8c3M3NA9iuzSHt8udIvSzs+AigQ7xkS/9+0nY1iCrvL6eYc0Hcv8qzpmkV3yZcSBpzWwGcgbK4NtMqOYQ+2/d69fLAyXEyBEx3a9brmpqhUQnTNO7TQYRKPIk54wabbDNEAEcSHKz9uQnvJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972423; c=relaxed/simple;
	bh=lvTa5cX1mmBZ1ZZ4KWiUXD/FpcG1GZZGSVfvUOJDuuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARc+jcIxjenYrHGDzkA+VW8eMeaGTKFRZOHxl5CR4JtviO9qIcDnhK0PTLnOcIjAA2T42zIYYLY0FZW4amHvbLoAeLy6McHclJ3YCzCz41LPG/ZsQTzGMzxfVqXO9lWfkSzJ63IhJ0DTx5zoDXqAiOdeFh+hGg8TeV7GegedOpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HZsw9ADR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa52560cb3so62563276.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716972420; x=1717577220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvTa5cX1mmBZ1ZZ4KWiUXD/FpcG1GZZGSVfvUOJDuuc=;
        b=HZsw9ADRdPM/TS/DCBnVuO0aSHroPL+J2F1HOkEtRENtPi9FIxNxx+iBUJB33YsGW5
         EAVdDtKj1xWYk++ectvUP7npw6lmgmw/hbuh+Mns4gb8EaNwE95ojggIgbzUQUhUO4KP
         uTvliiJm/j9LDqmyJGmbyhXvgnEnhyvgLH4FOyn3VXJMJClo9Ux4qnwKw7sLNB07A5z9
         ebNINa6H4nXh1kJXcflTZ2jxw+Gn1VqYrDNivTHGWqs+niJ7tMXw2Rs/G8TwFnFcWGi+
         d3tfquNfivIaEY2PhPZS14EDNLD/7aH/diq4ntMsVWxO93Ce8K8a3nTDS5LOtofTPInE
         kvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972420; x=1717577220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvTa5cX1mmBZ1ZZ4KWiUXD/FpcG1GZZGSVfvUOJDuuc=;
        b=uFygKEOLypgbyR7WsMtkOS/vBg32C6DFLBeG0pVQTFq/pV09hGiP6wE9ODRecK1s9a
         Zr/ptw2DjmljWYUtBffOLxsMS9nP+17BtrZZTESOw+dXG5UJ83qjV8Lk+r0fMe8RAlHI
         aIo3UqfB3+MHkKwQIYxPXDnrR9gs/1h5Wa5FD9vJzGVOtto1ODf+lcX0AjIYHg4x51vm
         EFHncVIEzrEqkUnDCjz7Z0BOw3X1sGkIBKvjRPnsBWUd1wuLB0QXmQ2N8KbImDMAOM41
         LQepVBaLPeHD0p0whn6FfVKE7U6xlOXppck45fwqGOI8fmcamlx0lvdyCDhLU/KrEPuL
         Uljw==
X-Forwarded-Encrypted: i=1; AJvYcCXlnNacR0309+Ar6HR/LGniE60Ne4TVMSVPrqsJqNRsH67xtzpg6pi4XgXSl3US8eatgaZT9liSu0hG1ZuX5RHIvfqI/sLUpgUn8W7Z
X-Gm-Message-State: AOJu0YwZv/mZXcvAndUBmu1tqKssWIX/nIvXHaV10iFXGGOV+QhJ36xh
	kbDl+2rNYjiitTPJA8hR9ba83CK7Xx6WujjJ0enL/357p4Sdv+paev/A03oSdSIuF68434TFdBM
	Fc4UsMXQL+kKp1k0cggyw0pn1ltGV5rpndm0mbg==
X-Google-Smtp-Source: AGHT+IGuMznx5rWwHnVVAA5zaRjFtg8ZFNidvvarA84qFUsV/R+f1/mRXm1Lav0k09Px+qVqWtmoJmeY+03tojOc7sI=
X-Received: by 2002:a25:81c7:0:b0:dcc:8f97:4c42 with SMTP id
 3f1490d57ef6-df772155e85mr14425777276.13.1716972420598; Wed, 29 May 2024
 01:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528191536.1444649-1-robh@kernel.org>
In-Reply-To: <20240528191536.1444649-1-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 10:46:49 +0200
Message-ID: <CACRpkdZznuUSAKZx-BLgt+smaTDt8fVtJ-xRzL_0u7uYMDGJog@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: dts: arm: Drop redundant fixed-factor clocks
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 9:15=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> There's not much reason to have multiple fixed-factor-clock instances
> which are all the same factor and clock input. Drop the nodes, but keep
> the labels to minimize the changes and keep some distinction of the
> different clocks.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

