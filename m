Return-Path: <linux-kernel+bounces-435886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A89E7E42
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A32866FF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9032E401;
	Sat,  7 Dec 2024 05:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="aQBFvtUv"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16C2629F
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733547884; cv=none; b=FYCVj2QNCJHEQGVioy1iIXpjC5pJocFv6Yc4vkbr8/TtPqx4vPaxCu1URr3DaVG81rk139Sh0ONuzlLABwK4yCzqV5GRzFHx5flxuExTmJZRbf9hH6J+ZI47JX8+1xJPy3vIuxwfcRKClDyU+W59yNBUdJCH8ZZSLTJ7iiS4Dkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733547884; c=relaxed/simple;
	bh=VUi6E6Tz/yc2Q0GE6Mu6Gat67zGMtdy2Gi4v3kMP7w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8eKprkGLNBOsexRGJJlIVtSFTxdmf1hJ7XmwQFgTqx42DbUsib33sLWDiJNRaJnRV3bQDdeoryay3UWR13vurhU4wlbHNfFxSNaeJR/cZPMjTDAwoR3+q8M8VloRM8Vbcb9r9I2QDrzV6y3BNSxARx3RffjB6qEzHbzjrXBDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=aQBFvtUv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7259d6ae0c8so2602908b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 21:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1733547882; x=1734152682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ddt2VEuIOo1iVu76Orar/Zo/Mdp1ppf8GycmQvRWHA=;
        b=aQBFvtUvdaNhi/TLylLZkoJdRugoLtLobGm381iAIkR5OVtnhPcbyxlRBqzEvK5LzX
         JV0JkIvIskohWoU1Z3lJNH7jI4usjaIL6U/FGKikvvpD+aecrrp21RbBA3xpZi7hcMbR
         Tipkgjffa3QitsRMUdd4Qr6MZLPxD1Y3sYsgGZfO8JhGMu3evNvFgrg7/YUsfhQAznG1
         QuMPRFhoxWK4BiaCSi/H8Iima/ICUj+4ueQLhiKAaB6BihuF/13KPQl7D9v1rwLObGuK
         XLJ5QdFMDLOFNPrvz8SLC107qiY+xUX8sXJO3CqawLdfk9iiW13djd7E2z8zQX/eP4Wl
         sOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733547882; x=1734152682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ddt2VEuIOo1iVu76Orar/Zo/Mdp1ppf8GycmQvRWHA=;
        b=N3GDrzYN7E5xU2hK6BB6GskPS/BjInkcAg2QyFcgO61zQDck5zsVDH58kWn+t8iJUE
         E0ElivrQExY00OOsM4vPlkwRVbn+1xzer9JkSvgoyJ68D18POamLDFq5cc227uGu1hjS
         HGsYQ9WtTD6EEtPHIN+2gB/HxSXw/gtW6ejMlPEguhUN5lXvLZ84lrzt5L17tgtoOChQ
         tRILLN0Kv4e2elWzpbtuARJlvrYOmcJStk1jKr0nmjJykzU4aZBJNI5KalIEdcdklfq+
         wNfZR81Vpj7P82xtVfVCSoDx2T4rFa2FmgQx2/E1eTpHgAupL8COCibNgLQis5xc8Yjz
         dyPg==
X-Forwarded-Encrypted: i=1; AJvYcCVy8KUPhgl0k8KcYU1tC+NNuk7MWvH80/bsdeWZb1wV9bgOPpY/5Xbmz17Zd1OrhP0v+VWc9lMW37Sf2XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ZE5VGwsD+YAvR9elqJ7AZwA/cYj14Onq0ElGbIp1FD7ipSpy
	D3gcDmdb1+X/cVWLGB/R25Mgefpie4//RxZkM9HMC/tByqT2F8AbUSwFlHpL92B1mi5uHQdStFv
	70R00QhVN+hMXIbJqtl0Pk2dr9DKFMt30zTg3kA==
X-Gm-Gg: ASbGncvhxdXwq8+I2UFrMrP3dvLlyTlyAI239Zkwqn0reVVAeAEC+S3tdszdeZpeTrC
	BjHWPMUM3jiT/LoC7YRYJARH4R/HFIw==
X-Google-Smtp-Source: AGHT+IEyb3xya9vheBrL7IJRZCeTEEHlKpHt0HNZJAo076PAOtifRmW78Meq4o9kgxdcg0vlyTCPwLyJMgs9Bqw3+vg=
X-Received: by 2002:a17:90a:da84:b0:2ee:cd83:8fd3 with SMTP id
 98e67ed59e1d1-2ef6aadd741mr7528991a91.33.1733547881868; Fri, 06 Dec 2024
 21:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206143527.654980698@linuxfoundation.org>
In-Reply-To: <20241206143527.654980698@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 7 Dec 2024 14:04:30 +0900
Message-ID: <CAKL4bV60tq-6dDy86C-8nKOf20iHygyW6ZK47DxiE_8zhHuD1A@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/146] 6.12.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Dec 6, 2024 at 11:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.4 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 08 Dec 2024 14:34:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.12.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Linux version 6.12.4-rc1rv (takeshi@ThinkPadX1Gen10J0764) (gcc (GCC)
14.2.1 20240910, GNU ld (GNU Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC
Sat Dec  7 13:07:21 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

