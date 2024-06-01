Return-Path: <linux-kernel+bounces-197969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F28D715C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 19:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B759C1F21B77
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A77154BF9;
	Sat,  1 Jun 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+P5UhoT"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3EAD55;
	Sat,  1 Jun 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717263362; cv=none; b=i/Xfx79RzTG7IF7eNg7O2UsR6j/ezVBzpQ8n4zl/B6VwPtKMZL+mWCAbJRvi2bdCZ3YgjGtSYO7xATVgFybzA8NVs15u2MBqeWLt2TfAG+FPgUpTgT0RBTRLjETmoyVsMUjeRCVkhnATAL53wilRufYOl8OqiLbRo8QEY30Qg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717263362; c=relaxed/simple;
	bh=XJyl4l5t/k3rLnQ72/yn2HQW5issWPa/CHD5pRVJm74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1Uhkl08jzeNvwKxmYw2iLoz3BAXJdCEtZuHXJkdV/FQEe9p7cPoILlXgd1iGXrh/x+b5pwAaybO72i4y34A25Ef/iiY0iRTvX/QYzCKNS54dqSCmD3GvhiOVSqZqnOilFWh957EKc4k7SVPO/o7dbn343wnPiC+htyhtwcQPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+P5UhoT; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b919d214cso492455e87.2;
        Sat, 01 Jun 2024 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717263359; x=1717868159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJyl4l5t/k3rLnQ72/yn2HQW5issWPa/CHD5pRVJm74=;
        b=P+P5UhoTWRIfMPiEvbqujuEn5q2u7mWJLopu/PT66y/21ttz2XaN1eq7bjAuDTNhJR
         dLPoSpOH4OZK30oFI4pa5VH7VtybAuGWfBpgeN0zDe2Q+qK86Lb9/7Frgxd4lWvqs3lP
         XHdVg1Z3P4O5z/x0fMQQhfeTh9cW17HoZqHZ4fEEPsAsmriPSxf0I+fflgHAsDhjDUsp
         jCGmvGhpoeFMhGtxBC4UMCsvcs3X09kc7if+qeYYn68U6UfLYXCf/+6ATjuyIfkyKoX0
         krJiPYbCABUPhFyXcMLCHB/0x3f7zun/fW873lfjZOkcnTlXh3Uz7FTJwCi6QAiWTEtY
         PAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717263359; x=1717868159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJyl4l5t/k3rLnQ72/yn2HQW5issWPa/CHD5pRVJm74=;
        b=HbCfH97ueqevRdbAjgZLDoO1jAQNow69rNtGtdWvgOxs4a9mAVMC9G1fAKErAUYziR
         XXauYw9KTVBXCUDyovC/d6AR+t7VPLtj5ZzBSbBIy0BWSKqOn4KKXpF67Dlo3gn6zqsd
         5VPd3T9GUwz4770Upc8uNA2tKK9k6mQY92LDadf27+L8JWDZHZyht3KNPOQwOcwo7Xi7
         uUSIvyy2dF/w6AYyDv4Qptbyy3y7VEjGsOOApkqrQQqr0/14cx/0emX1sEDfVPy3rK1s
         RqaNodmmRFrgV5thgqobVwHL8nHk2Sxw3OhknmWhpEGB3BFJQTOL3XwtsoiCwJ9hjXXx
         YxAA==
X-Forwarded-Encrypted: i=1; AJvYcCXbmPj7sCDfO0ll0c5mDzFzTHZ3YmXDrhqp5rw0wbjTa8tz56WZtKyxPbHzy96JQPbYy5+wcUax9NS17ExcZ5OclCEwkWOosvX5jeLlv+pi656dWnQVTjwBQCePD/GbgXGTU/nY8M0wS8UgkS05T5z5zG3TPw0Q+b5Nb1fBDLBpsEkKrRdz
X-Gm-Message-State: AOJu0Yx7F+EXexeMcIwF0EUSYom25T6VpIZmGICsuWxptS8MWCGdfsMq
	KSziZsg2t7iY3Fhh4oTiZzzB5G14kTcv3RNoOcO34ZHzCnlWHOkxyKmHX9376J1wwcxC8bY2FnG
	+MEl94knl4R9ARSvfhnCwGvW5er0=
X-Google-Smtp-Source: AGHT+IH04S1mTC1pbRmToifVqj/OK9AubBcLxbTT/9mdn/0C3Y2HQnsY37NvyikE6lfjaJ8pSWX+rxyxcA2IjZ4SRQY=
X-Received: by 2002:a05:6512:3ca3:b0:521:e065:c6c5 with SMTP id
 2adb3069b0e04-52b8955c4bemr4195236e87.11.1717263358375; Sat, 01 Jun 2024
 10:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530111205.1764-1-bavishimithil@gmail.com>
 <7845bb1c-47d5-41f6-bf08-bd7b357df02c@kernel.org> <CAGzNGRn=e46yYrK3o8JhUmod4pGFFdEK31kUWUU4jn+JTgZjQg@mail.gmail.com>
 <c89d4290-1f24-4a30-9d94-f6d0dde21e80@kernel.org>
In-Reply-To: <c89d4290-1f24-4a30-9d94-f6d0dde21e80@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Sat, 1 Jun 2024 23:05:45 +0530
Message-ID: <CAGzNGRk8OtxY-K+3FF1UJ_mUS6Ras-FA7Es_KuLnva9jfqEPHA@mail.gmail.com>
Subject: Re: [PATCH v6] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: peter.ujfalusi@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lopez Cruz <misael.lopez@ti.com>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 8:44=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> I think you are now mixing different things. changelog and differences
> comparing to pure 1-to-1 conversion.
Oh my apologies, the commit message being more descriptive? Should it
also include the changelogs, or just a general description about mcpdm
and it being used in omap4/omap5 platforms?


--=20
Best Regards,
Mithil

