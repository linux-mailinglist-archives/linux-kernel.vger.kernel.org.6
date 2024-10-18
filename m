Return-Path: <linux-kernel+bounces-372335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F79A4757
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AEF284CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A97207A34;
	Fri, 18 Oct 2024 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lBqlPoB9"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B2206053
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280795; cv=none; b=J93lNN9Dl4qh8FNjjc4LPNielf9/I4kjhJEPP5pvw9Yi8qK3OAT+NGxWenG4yFw8E88eZ9xAWnt2IfF8eOK5q7LT+GGtlz3XSqkgV8uj9U6xkIo69CMRn6mbi+ttcEygsNDUUpQeBsaGLacO+bTRBzVBtnWbSY6IL3KT0/xpA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280795; c=relaxed/simple;
	bh=gRKbZykbQnfZIa2mN+Qk0kjeMCLWWLiYlGss8XAlG4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=andCQkFq73uV7M2hKoubf8iaiCnRDmgFG1A2QL9SocaTdwn/TvW18SDkgN2DZpSFQ0Bu7f6POwONrZGniJhAQOLkoReDbzIfZdyBFHei90JFghhMSoK0EpQYpE6JqqeagPNCVYLbjj85diQ+htOOJeMAvgsz4xdH2oxBqKUv+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lBqlPoB9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8586b53so2960228e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729280791; x=1729885591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8ipiDWj3Ck20WdXHaYfDWf33qFxj+sWnjP/LUx2c50=;
        b=lBqlPoB9n9a+fq3rLpZCop2AmbKMiQfS79QNqmHPaxwhsIVyDkrsNvgnLhGe06XhAB
         bkxeKjZX2CWDnCb2BxlDUbkS3mBz22sYj1o9lj4wlZiRhwxlfC961izMUeqPsSxH+Nfa
         McM/jXc2lgz46ey1tlpTaH2m9thxKgpMuXQjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729280791; x=1729885591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8ipiDWj3Ck20WdXHaYfDWf33qFxj+sWnjP/LUx2c50=;
        b=PQxfZWu8n8RaT5Aw4Mel7qFaJnTyGserRFHailBlIH9wz26BdVXyOvOEzES17YMD9V
         UvO9d/x6yHtIi2drJLTyC2Fwkbfzl9la6KCeeS1EjDKZ4PDpitqmCZ82SEw7WL9l5nI7
         3//dVOEQtzRmNlJlk73aJdvU4tZuABqztIZyyWFwRCo/sh8w+pPixcWMT+i5ycbEbgQk
         2rnWIphe++9XuFX42FKOxjZxBHcev5WBO+Rn300FO0LFBt3d8Md9R4ayQ1Gg7XHzQAdS
         d+HTOeAGZ7Td+jZcO5c7TzWBbLD7bFIhjEo8oBWwYNgCAMZNWhy4hxeM81dDaJLCK8Xk
         pc8A==
X-Forwarded-Encrypted: i=1; AJvYcCW/qL8EUI45JGFbjogJPsq1YXQSGMay7FlGMqLEuAXIVoYXOWfBYeoXSrG49FPLBk5IQtQ+zC8LpSlptiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzylhccnz7pn/QsK0/0GEPWU5v4KUJyVhZoOkaJ16BKAVTTZWhX
	uEjGs4F2HbPrbiBuD8yPoP350UK77Q1tynLYfvO3WkK9PcidlcwMeB59172bq7VK78x2ROagWIy
	S/GvR
X-Google-Smtp-Source: AGHT+IFHEFMCHbviQdEimrmzObEv3fq9tVc1V2fBHGCHNHLPa/qz/FH1mBLMPdvD65EZOAsP0TdoBw==
X-Received: by 2002:a05:6512:2813:b0:539:f6b1:2d05 with SMTP id 2adb3069b0e04-53a0c6ad3a5mr2695265e87.9.1729280790482;
        Fri, 18 Oct 2024 12:46:30 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a152044a2sm305238e87.227.2024.10.18.12.46.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 12:46:30 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fe02c386so3600841e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:46:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9yRVUERjuImFlNJqG93WGl0sehEBek3v0wbGJasnt7JSLcNOBGEJtSc+FYvh2wSH8DChpXDHiJaQmFbo=@vger.kernel.org
X-Received: by 2002:a05:6512:e91:b0:53a:c15:96a5 with SMTP id
 2adb3069b0e04-53a15b98db4mr1223870e87.27.1729280788792; Fri, 18 Oct 2024
 12:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018163136.GA795979@lichtman.org> <20241018175540.GA796909@lichtman.org>
In-Reply-To: <20241018175540.GA796909@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Oct 2024 12:46:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwNAkam8HFhdPLRCXHf05LUXdJF++d-pvpFrCLtOypPQ@mail.gmail.com>
Message-ID: <CAD=FV=UwNAkam8HFhdPLRCXHf05LUXdJF++d-pvpFrCLtOypPQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: English fixes in kgdb/kdb article
To: Nir Lichtman <nir@lichtman.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 18, 2024 at 10:55=E2=80=AFAM Nir Lichtman <nir@lichtman.org> wr=
ote:
>
> @@ -201,7 +201,7 @@ Using loadable module or built-in
>  Configure kgdboc at runtime with sysfs
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> -At run time you can enable or disable kgdboc by echoing a parameters
> +At run time you can enable or disable kgdboc by writing parameters
>  into sysfs. Here are two examples:

In response to v1, Matthew wanted you to change "the sysfs" into
"sysfs". In the above it's no longer "the sysfs" but it's not part of
your patch (no "-" of the old line with the "the" and "+" of the new
line without the "the". Huh? This causes the patch to fail to apply.

Other than that, this all looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

