Return-Path: <linux-kernel+bounces-526425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F44A3FE95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625C8166F94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C3C250BFB;
	Fri, 21 Feb 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2CC3h+vU"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8391CAA90
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161921; cv=none; b=MfYF5fUCXhyNjQsEr7ZV2YIsnsevLqEwT3WYd09HaBHgNV+DhUFsIQDGktKdA+Yjyl5I/KisZtOgrWOUPySrpXvgfjkW5WwAKTSV1vJz5XhehjIdkkR59SVkTJq91Bd8ZBppEQTxtj/DNge7eYV4VxkSXE+7FcfxMRPVjfIUw0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161921; c=relaxed/simple;
	bh=GGzFnXUDdo94zP/g/M0vl1gNFcXO3KuhwN3auxqRUAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldRn+BFtvwU616ep1R4eahQMsMCSssJ4LGX4OXUt/0g99oKjsx258TtMXvjzJbPlHltFn7Mskrh820+SXGo8gEcAHHZxEZUtcy9UMa9IAznjN4snDITn9pWfkiidNXhYMBfqOSFe/xas6+LHVAyW+wQx5sDo679YIwhh16z0+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2CC3h+vU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso3462982a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740161918; x=1740766718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faRqCA81jH4txu0fAi9rdAQk4yfaELeIVteH/sliYZQ=;
        b=2CC3h+vUPUMa0M4uAc+cpZgbkYY4vKQHhCtAh0si/b+yP1wtL+cWKwOckjUBDD6qOv
         w6EnfRPDyMdtQ5aRTck42PcpNG8M7wxRLd3n3GclU9213Rnw65coV/FGpHQuwdTPiXaw
         tcU7Jyq1Mjig60TaW8Udl+tDKmSGz8t+I+tLazoCWChLaByB3+1z2OtGxgdxD4ousph9
         CMUP7E5yOQ2V84B5rWTeVowqjBFIMWbdTwkOdarLUA03LJqY0eM0Mq74eSJxaDcU/Lf1
         q/7iBtmxwGBFDyQWCtc9Cujn1VXKLUl6fN/sPME6++VtHDzZ2kFYIWq7iEDSeSG6iAvM
         UVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161918; x=1740766718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faRqCA81jH4txu0fAi9rdAQk4yfaELeIVteH/sliYZQ=;
        b=KY3SS5gNwR0TxsjvekbP4MqLk6eEW4ENFo3H6tHVissyxHo6IXMq3OccXt/Mujn8tB
         v88uXizIvK49M9mSHl96FK60l98+u4jAb39ybH9iwuPeIUfSQDPAebG0/aejuI/iE4Br
         kyL5WB4l53gpCdL1XxjrV5bJBqf56ptaicbo++ldaq/CqPJvMqSyq3QPlW1n2VirWJIM
         5oQZMU+s81BOFFo6efn3s2ON+aSrMynDDimCz2l7mr/pLX61oQoKKhV/AO1vB+WpCOHE
         sx0wyjUQIoiHLEXqR3L1Qrq5nbf4x4us6HSKtowWTo7JNfVeLJuL7rhe08TojMndNWME
         HIFg==
X-Forwarded-Encrypted: i=1; AJvYcCWG4u7drKTeR4OHjcEhk15GJmRgolASOGzB022RTvVTo2umUGMf2qQx2U+8tIVIWKMq8pInieYEvcY6dYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyezjjWp2x2fLk/WL04Us9R1im7OPeTOlCFFU3IicmCKPz4xSj6
	zWtATt2t0nxsw3j3tei+7o1vZvAFfYMRBh4Hj374HwPs9cfP5sjAB8JV3hpACtA8PFRjcPEvxv5
	+xCpIIrkACgc+GLulzuVzn1FtKhkxf3hKTHrY
X-Gm-Gg: ASbGncsHH+4Dev6ujsZ+W5Hf4P2R/dyfJxYH+HzuGx+WqmTt1hU/AV4Qvmm6/ARq6Dc
	tqQ+2/GE4TJ1Tt5mm0UzO7acm0IZODLvnt5qxKhR7X8GWY+1SU0koRc3sRkiAXBlBALCHarGGOk
	wQelp5pvw=
X-Google-Smtp-Source: AGHT+IF6v8PIfym1PMyabOHdGTmRgwqRk4s4qoohzkIsffoZydOlVmaS6zsX3+sB8p+2yvlL2fXKdic+GCMXbK141jw=
X-Received: by 2002:a05:6402:4313:b0:5de:4b81:d3fd with SMTP id
 4fb4d7f45d1cf-5e0b70fa0efmr4107878a12.13.1740161917702; Fri, 21 Feb 2025
 10:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-netcons_fix_shadow-v1-1-dee20c8658dd@debian.org>
In-Reply-To: <20250221-netcons_fix_shadow-v1-1-dee20c8658dd@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Feb 2025 19:18:26 +0100
X-Gm-Features: AWEUYZlKwQ8cz6aUrcdxM4m4-YuXNW5btQgtHANtkvNmjfxNPFwqDaP_9afxZQ4
Message-ID: <CANn89iJ0ePmPZW6c3XzUbm_kND1r_EPxz7xNHgroAZwzDjn5eA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: Remove shadow variable in netdev_run_todo()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:51=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Fix a shadow variable warning in net/core/dev.c when compiled with
> CONFIG_LOCKDEP enabled. The warning occurs because 'dev' is redeclared
> inside the while loop, shadowing the outer scope declaration.
>
>         net/core/dev.c:11211:22: warning: declaration shadows a local var=
iable [-Wshadow]
>                 struct net_device *dev =3D list_first_entry(&unlink_list,
>
>         net/core/dev.c:11202:21: note: previous declaration is here
>                 struct net_device *dev, *tmp;
>
> Remove the redundant declaration since the variable is already defined
> in the outer scope and will be overwritten in the subsequent
> list_for_each_entry_safe() loop anyway.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

