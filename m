Return-Path: <linux-kernel+bounces-190382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53EF8CFD84
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65131C2104A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181FB13AA5D;
	Mon, 27 May 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYtpefpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3692E3F7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803665; cv=none; b=oa1zl35EDxKqxd8piUWTM9+6zJ8wWCWw05HcdbLKoVjzY6zljytBUM+snbvUEjwih2KFemq2ae11jCrwI2w+LN2+Ph6+3yi6cFHbAGzDP1lopVWp00WE2oEEYMP6hyiPeaigiUVW9kTxwv9RozewdFyv8eCJqsaud1TvhYLRy+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803665; c=relaxed/simple;
	bh=v+rsW0/LzxEapO717GWJ4lTXfFgzJsow4u9nEbWqAS0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=byZQXbzCMuISSQEPd9e2MhVLIgRE8hAHq81odXZ/wNoFkldant4U4fIQBvcAvjRAtHQN0H0fLSEiUPJd/dbIGrryCpp0T7NbbnKPYZK77Rm1q2oTAGVeeM/TbqEJKHLyE5jJYBRpVU6uCcG/AmQWevib5ENOrdSjAvWkjugqtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYtpefpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B53C32789;
	Mon, 27 May 2024 09:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716803665;
	bh=v+rsW0/LzxEapO717GWJ4lTXfFgzJsow4u9nEbWqAS0=;
	h=From:Date:Subject:To:Cc:From;
	b=lYtpefpawJYcihwK6Ourkxyn27mSvSDKk/kaFUU8oLcP5h2uF1XOfcrjkDmfJj2le
	 3OsKLms/mIbMsIF+vSBswyvYfnEg2MCpaHmBZfF+tUT2rgkqBNth33jEKASqelPzcR
	 PKq7u3Nyu9WQFF/sS4Vfpbdu+2sWLhUXw5Hp9nQ187IECXaaUiaejMesmt8maaBs1f
	 9+mE3VrKmelVVBka5/W/p/Q2IWSUCEIb+6QHHbL3mXWjL9jQfnBT7muQAAJp8RcfWZ
	 gisS2w1j7+eLe7F/9Eg9CuQZbFRSL+RTfYHQn+iPfRljSyc5/3RIse20j4wIw+xF56
	 IjTrmTNHOR2EA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e95a883101so37420651fa.3;
        Mon, 27 May 2024 02:54:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YxgFpLv237d6QNZBA9n4PpR2B7wP5jourQTrNAGqPYZYAC4MFUy
	aJU+CyEcYV0qKHXG1834AsBPhppNggJ7pXHGdOFiAUqEiTTxErxyOV/tX7A2YJgp5YZ7WjuJGp/
	VTEC6jmFLzT5qsEuP8uzNIaSt2g0=
X-Google-Smtp-Source: AGHT+IEV8JscxKFJ5tnASrrJUBVb3/gaoYCwVy7M7G4yQMVFJ07zrHtupx8INAGgfj+ckhBOYuqCcV/YOCQqAm9oFhQ=
X-Received: by 2002:a2e:9797:0:b0:2da:d2b8:ffb0 with SMTP id
 38308e7fff4ca-2e95b25ec58mr53702501fa.41.1716803663548; Mon, 27 May 2024
 02:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 27 May 2024 18:53:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQo43-iUhhjKNPRJmh=SeMuZCX5=FK3BKemb0Oj9S2_CA@mail.gmail.com>
Message-ID: <CAK7LNAQo43-iUhhjKNPRJmh=SeMuZCX5=FK3BKemb0Oj9S2_CA@mail.gmail.com>
Subject: [stable 6.6, 6.8, 6.9] backport 2fd3ef1b9265
To: linux-stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello Greg, Sasha,


Do you have a plan to backport this commit?

 2fd3ef1b9265eda7f53b9506f1ebfb67eb6435a2

 selftests/ftrace: Fix BTFARG testcase to check fprobe is enabled correctly



It has a Fixes tag.
So, maybe it is already caught by your raders.

If not, could you consider it for backporting?
(to 6.6.y, 6.8,y and 6.9.y)

With my quick test, it fixed the kselftests/ftrace issue for me.


-- 
Best Regards
Masahiro Yamada

