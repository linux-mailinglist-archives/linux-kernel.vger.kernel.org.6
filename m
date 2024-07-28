Return-Path: <linux-kernel+bounces-264499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1493E431
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A5B281735
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539E17C61;
	Sun, 28 Jul 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5jDSVHQ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3ED1877
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722157231; cv=none; b=Frf2/cSkOrG0hZuKQkFOXy2+qg0uCmk4F7br/bej9IAr2DBbmQ3wDC2e4u+KWWnZ5AdH1rOdHPWVMWWbhEjXLOOQiXhnT5PF68sE2VuCp7M1WD8PmKVXYHQtIcWwxWuBhQ75Rlf7vQ8EPJ8IkEuL0AJ6W50UG8fueRWd5/bkHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722157231; c=relaxed/simple;
	bh=ujZadsmAlrryVH7s65HYoO1mYAguj/qF1c1WDAZXUNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSKQsFpcfAKvczsMt0N3HeefzydO+paC9D4+DPaPY4R+eoQUpowtESLc3KutlyPOZC3cB3E0tWcm2J/pex5auA9ykgiCVeaRfvlScPY5VeuShz/VY8v/UO7c4lT4JxihxJfconKuIkEbTqyP7tU+FE+S8WCMA1P6ilCK529SbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5jDSVHQ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efd8807aaso3979423e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722157228; x=1722762028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f5NLazh5in+pBW1g2Mr1FfXjDf+1KVwju14XjPZipY=;
        b=m5jDSVHQ/7nYBPbULFODlDx5RNfX+bPGEVk8Rz1KsvgtOYAPQ7KzGEkGCKFWekLCbZ
         BkO20CZACgQHPqMqW9z/5zxSgMtOKELAV6cUJgpCRGY9f5keA40pN8EMUU+xjUJYrTFf
         k/nyfmrDF0PDJ4h5izyjMyBZG3aW6+RwDjhN5HTwt5g9Z6Ci+Qa7O8MYrN6d1QmrD+2D
         LVC9kkIOxi8rIQQ+zNiwyL6l2gvgVLaLMpLkyOic8OzchMDn3Mqga9ldcpVJpJ0OFTzv
         wiPTgfBDbtd9C4hTC/jFWwrhLFIhRQ0ywcw1LxfJSLtMl55/lEzq+L/DZn+lVH3AJ8iZ
         1msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722157228; x=1722762028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f5NLazh5in+pBW1g2Mr1FfXjDf+1KVwju14XjPZipY=;
        b=niBKn5NS1NyCnK7oyyQxCScVHYymmCyz9mZMDBwpN6m/4cdTR6uHCkdgo1/xUus7iU
         xDE0Of6nFQLLPhdtYVFJP6MGq0IOQNRYzq0Fjp1f46r9rsjpivfxyfb+qsFB9Qi9F5/J
         XJ1Fytmg2eiDWP8TU4MSfhC8Xmwvrr4cx8yTwr8ImvK7zhrdbtJj/FZ+Fzx+eu38/jAG
         6Acd/0nQwTl+ZSCBeOW6v7Ih64PYvuOUlzw0+IIR+xClfRUio3ZmphcEMCSpBVWm40Ee
         Qo6uxDDuMW6trzUXzlHedhmqtcI30aF7Tbd+BCtjidQDyUQWyWDV3E8Kle+Xg73D5sSs
         EFvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9syuy2LZ+8MEASnRjIcEAU+ZUbacGn0/B3P6n7eBXK5Uw3wYKLmdlywEovv3QS2Iq4bFjc4lnRxvoda5a2pr6aOBKIoYPugzg5ldA
X-Gm-Message-State: AOJu0YwAPQw2zg3O3brrZ4DxMjwHw0JUu5M6WItjnDz8EHPHd6tSKYUo
	zUltFDH+rqN87IDY138z59kbivlss1QYaEAoXRF5uwatFZ0i4P4sTPHw6LAhTG4M2C2MAEg+Iv5
	bHkZtomsC9SMpSUOWWeK4R1sTyUE=
X-Google-Smtp-Source: AGHT+IEfop4MZgYbfVkRogoHTR4KMymOl6FhVvJxTvvhSjTnQU3NGW/LLFKLzyslu/yA++LpMhjdErtPrP41LklzyHI=
X-Received: by 2002:a05:6512:1104:b0:52f:89aa:c344 with SMTP id
 2adb3069b0e04-5309b26b828mr3724527e87.16.1722157227182; Sun, 28 Jul 2024
 02:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726104848.2756962-1-leitao@debian.org>
In-Reply-To: <20240726104848.2756962-1-leitao@debian.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 28 Jul 2024 18:00:14 +0900
Message-ID: <CAC5umygxnq=h1H2CCeprzaggu_A4DxZia3EEBTYk7sb72OnQFA@mail.gmail.com>
Subject: Re: [PATCH] fault-injection: Enhance failcmd to exit on non-hex
 address input
To: Breno Leitao <leitao@debian.org>
Cc: akpm@linux-foundation.org, leit@meta.com, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=E5=B9=B47=E6=9C=8826=E6=97=A5(=E9=87=91) 19:50 Breno Leitao <leitao@de=
bian.org>:
>
> The failcmd.sh script in the fault-injection toolkit does not currently
> validate whether the provided address is in hexadecimal format. This can
> lead to silent failures if the address is sourced from places like
> `/proc/kallsyms`, which omits the '0x' prefix, potentially causing users
> to operate under incorrect assumptions.
>
> Introduce a new function, `exit_if_not_hex`, which checks the format of
> the provided address and exits with an error message if the address is
> not a valid hexadecimal number.
>
> This enhancement prevents users from running the command with
> improperly formatted addresses, thus improving the robustness and
> usability of the failcmd tool.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/fault-injection/failcmd.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  mode change 100644 =3D> 100755 tools/testing/fault-injection/failcmd.sh
>
> diff --git a/tools/testing/fault-injection/failcmd.sh b/tools/testing/fau=
lt-injection/failcmd.sh
> old mode 100644
> new mode 100755
> index 78dac34264be..234d49fc49d9
> --- a/tools/testing/fault-injection/failcmd.sh
> +++ b/tools/testing/fault-injection/failcmd.sh
> @@ -64,6 +64,14 @@ ENVIRONMENT
>  EOF
>  }
>
> +exit_if_not_hex() {
> +    local value=3D"$1"
> +    if ! [[ $value =3D~ ^0x[0-9a-fA-F]+$ ]]; then
> +        echo "Error: The provided value '$value' is not a valid hexadeci=
mal number."

It is better to write error messages to standard error rather than
standard output.

Other than that I think it's good.

> +        exit 1
> +    fi
> +}
> +
>  if [ $UID !=3D 0 ]; then
>         echo must be run as root >&2
>         exit 1
> @@ -160,18 +168,22 @@ while true; do
>                 shift 2
>                 ;;
>         --require-start)
> +               exit_if_not_hex "$2"
>                 echo $2 > $FAULTATTR/require-start
>                 shift 2
>                 ;;
>         --require-end)
> +               exit_if_not_hex "$2"
>                 echo $2 > $FAULTATTR/require-end
>                 shift 2
>                 ;;
>         --reject-start)
> +               exit_if_not_hex "$2"
>                 echo $2 > $FAULTATTR/reject-start
>                 shift 2
>                 ;;
>         --reject-end)
> +               exit_if_not_hex "$2"
>                 echo $2 > $FAULTATTR/reject-end
>                 shift 2
>                 ;;
> --
> 2.43.0
>

