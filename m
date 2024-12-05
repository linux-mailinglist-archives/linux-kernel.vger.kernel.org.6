Return-Path: <linux-kernel+bounces-432539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AC59E4CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85143283EB8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C518FDBA;
	Thu,  5 Dec 2024 03:29:39 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5D36127;
	Thu,  5 Dec 2024 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369378; cv=none; b=lMfVGylCsYbBalqYtH0vMYD0sJis4FvqbmAMiRPbSGuPiD1ssI4XRY23/qhfKHr0fNEMKoDkplwv8Aicy4SUM5rFydjy3mEX074qWd4gwTJm0EwDEJzHE8vPyndMejaHPMSQa+YToRTfePCIVBkEaZWHjreKGTHljQt1qCX0pxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369378; c=relaxed/simple;
	bh=d9QqhJy6LFx98gqli7amTeV8pMlMivhrXQSOVdmRHCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaGFPCMc3IFxAJlQjGbW1cuZwPe8fmMGtHqbAiFfURSdzHlfeAbseXHnyZFUnFPWTGyDTo6VM7NUTzdc9TMsjJVzt3jCjeaVyt+H15q6s4czWPmlPuApVv9cE1cdIIG+LTCGcneLJeMpLL/eeBBSC+vrjJ3roqofaiVYbyib1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso3829111fa.2;
        Wed, 04 Dec 2024 19:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733369373; x=1733974173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1k1WfYR2gjydU449wpk5rhPTUc08x8Av6VdOn6ZQfI8=;
        b=w8HnUwwTk2FZgZ2VtJK7wKxLDpdwG9FcS5vW461M/NspNSM8zxXV3xH7AxPaBwVuOo
         hY76/Rjjkt161pDv35zG87I9jqhjBeFo/40ghhkDErnHdkj1Jkp+97YCsMihRjeM0BWs
         18Rj42u28yDoDuSTGyKgOMAt92v8QGwHnkTXPxlQsjJByUrSHoAwSgfRMGjSDj26wVtP
         P4ifNjxylvvoQCQbITyl/t2my3pRJ9ckTJRWWVAkgweTIO0tKy1bAjyXjn1U7DDPY5sb
         7St07dKB+8S++61T9Oulezqi2vqhrSivTW6WiisV+b+0qT0PRJ/l/hiiAvdqhKMYER7I
         uAlg==
X-Forwarded-Encrypted: i=1; AJvYcCVxS9ykJbmptkt8Z917XTDf+zaXLXCCDw1l7aM0KM9dCVryUjwjVSyhVYPQK/HVvKzT9hsPYIohai5vu/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3FpNKsyGu8hqx0YAFBhUg+q3r3A8uJZPqXbqNIamQka6QL6KH
	AKoVtFnBfE0GU4clnD7h3s9wu2ZIn68W88kR7NmLS8lFd8HuyjeDBjjfit8Q
X-Gm-Gg: ASbGncuwqfSXrefa2NkFYRsl5lcFtIAadihzejTpuk7QoQ5W2JymNzWXlYHykcRLa0a
	clsq5q7wmPwz8UFucoDbaKOgSM7+QJl+JhxFhckZqhgSGEbvTSkqNhF+csh62MWEowHg54dwNfu
	C3ps+d8Q1kaCBZXHTBaZeLF5a4DeDUfpLnPDaL8/kPNLKXM0RljW+UMODLRDloEfRY8eb3K67Lg
	cjOcJ2fGX2uxBGMfzzn3+5OqXAoKAA24e0jgdbUnlXNACH+bKABdFZq/Slt8TDZuTtQuyiUK/BA
	sX+c8p4=
X-Google-Smtp-Source: AGHT+IHR8i0dNkSrqHpCxy7cO0Tv61bKr/nFvOMXv2l9euZo4XuXzRVyxYaWlvm55PYCAF4x7epz/A==
X-Received: by 2002:a2e:be10:0:b0:300:1f05:5bde with SMTP id 38308e7fff4ca-3001f055e6dmr5391431fa.5.1733369373126;
        Wed, 04 Dec 2024 19:29:33 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d8526fsm788501fa.20.2024.12.04.19.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:29:32 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffb3cbcbe4so3973961fa.0;
        Wed, 04 Dec 2024 19:29:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+WatdSAuDWPZcnrbcLd/KfCLzYYjq9+zNqknItlJyOuRqN77+InNjcvxLnXMKSj2SRfBvVgViJG5iTLA=@vger.kernel.org
X-Received: by 2002:a2e:a907:0:b0:300:8ff:d93f with SMTP id
 38308e7fff4ca-30009c50cb0mr52396671fa.22.1733369372603; Wed, 04 Dec 2024
 19:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205000137.187450-1-csokas.bence@prolan.hu>
In-Reply-To: <20241205000137.187450-1-csokas.bence@prolan.hu>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 5 Dec 2024 11:29:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v674BnpmyP6zC85zbCuKVN-gb3MQA=CiQoe7-eV8qqyM+Q@mail.gmail.com>
Message-ID: <CAGb2v674BnpmyP6zC85zbCuKVN-gb3MQA=CiQoe7-eV8qqyM+Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add F1C100s audio support
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Mesih Kilinc <mesihkilinc@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:03=E2=80=AFAM Cs=C3=B3k=C3=A1s, Bence <csokas.benc=
e@prolan.hu> wrote:
>
> Support for Allwinner F1C100s/200s series audio was
> merged in the for-next branches of the DMA and ALSA
> trees, the last step is to add the codec to DT.
> This series was forward-ported/rebased to the best of
> my abilities, on top of Linus' tree as of now:
> commit feffde684ac2 ("Merge tag 'for-6.13-rc1-tag' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/kdave/linux")

There's no real need to resend just the DTS bits, though I appreciate
the effort of making it easier to pick. There should be no difference
due to rebasing, since we didn't have many F1C100s changes.

The DTS bits can only be merged after driver bits have been accepted,
otherwise we would get DT validation errors in -next. After the
notifications yesterday, I started to pick the patches, but it got
late so I hadn't pushed them out yet. Just want you to know that they
haven't been forgotten. :)

BTW, if you merge different patch series and resending, please keep
the highest version number, like you would when resending a single
patch series, and also provide reference links to the originals.
That way we know where it came from and which version it was from.
There have been cases where the latest version was rejected and
an older version was resent.


Thanks
ChenYu

> Mesih Kilinc (3):
>   ARM: dts: suniv: f1c100s: Add support for DMA
>   ARM: dts: suniv: f1c100s: Add support for Audio Codec
>   ARM: dts: suniv: f1c100s: Activate Audio Codec for Lichee Pi Nano
>
>  .../allwinner/suniv-f1c100s-licheepi-nano.dts |  8 +++++++
>  .../arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 24 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> --
> 2.34.1
>
>

