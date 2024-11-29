Return-Path: <linux-kernel+bounces-425240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0E9DBF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32F5B21604
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C0155C96;
	Fri, 29 Nov 2024 05:13:28 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A613C689;
	Fri, 29 Nov 2024 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732857208; cv=none; b=a1F4VyUQcwmKYHHMMdahPIiWJhSkD2MYPBQbJJTlNyTOzYgGF0IiIxP/knW0soqgQmf7nRSQP83G2bKEr6M/9kVN3lTVUe8778aCtpt3sZwbnvtt6kq1CxQM9D2PCisHmkZy8ewJCBpaXxv7x/keuB38HVWSDXiQdumIGJwOqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732857208; c=relaxed/simple;
	bh=+12xevKnTNauiZYg0olJVZ1Thq3/ybq5525r9lkxdSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgGjD6ESxtkU283uiJ4HSArxSBxAp/19G7ixsYdZuCIzMgR1p2hukfqVGQPbiz/dilB9a/CbFcl0ZDhZtjuibO9k9TJj2hTt2EYjo5Ocwtqu0h/RgP3qYOwGu0EYAcafIsKxnN19M4/sv+dcWRzIyIQX4xj6m9JRyow3MYE9Foc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso8721881fa.1;
        Thu, 28 Nov 2024 21:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732857203; x=1733462003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJvwqiaal1EaQSpBB0Sl+EHlw0k4hE//iJpExas7lYg=;
        b=IlF4phdEVmTM1hKjGVkUJ58VRrKRA2+8UuhT7Mg98AfrUQlKx4xyYaHd2te1vXOxZV
         6MPQg/r4XmpGjA5fCLurbWjJslnmPa7vcTNNMmZK07pgF6gsUIPElTT63TSrUD/c+Lmz
         IygvqjwZiAtxF8lYSc/Ljx98a5k60bpLarhPzniFQCrYrrPErL6+wzowid4Yl47mRc3M
         FR3FnCbcbGEjsZu6AqbjofUiffyZtp0m5o+YhIsIsCuh9qL/5rM+DcJIZtrpWQJrC9DS
         L51Fsu83SMWlRx8AyLoX0J1qvFTYcCxaKswoUN/oj0toIl3pTka8t/0mFY6+38tz+6e6
         m8PA==
X-Forwarded-Encrypted: i=1; AJvYcCUOsLPjaKDY7DNgDSDpAp+vfKr8QlM/KoTBGzh+qK79gNpUtuI3N7hG8R5vF7gf3z0pT+yDBooa3NkQ@vger.kernel.org, AJvYcCVOB2U/2Er5X1b6y2VPIuL0wZFPJrBMzxEhl+j7iFeTTOrSKMffGG3vR/ALzG01MmQkElnnkhJM2xSxBtvc@vger.kernel.org
X-Gm-Message-State: AOJu0YxdBnyAOvdeoyQIEmAuz3Cxno2T3xjcaqj9f0zFovC/7+AFLrjz
	viN9F7RnQ0YpOi5rXEo3IUvnxDon6olN2ENzhHc/z5BecnTzf/Wv7eY99XSB
X-Gm-Gg: ASbGncvBz/6oscvSBNxjLjolRKLhCNpjt8j53S1mUdw1Odd9Z8Gk8Ve87FkhUK2Iwzg
	FNJB45hOfz+obABjFgAAS59dyMpDnlu/Tp8LD/HAGhIWgnPJUrX85GYByt4ALRIf78R+WUWdOIW
	1DJpIPRWclddXLIVrU3803SPvAWxgcB4lKwAWrTsF+Hrg4Pps7ciBKRXIKnNgwqPdui4UHD4d0o
	fzsszTbIdS3JZTA6jll9pXEAQ8oKMWAHRB9axEd+nWhbq1tmbQya4/d3NTg4BSp04BpHfLvy3eZ
	/YhDvJc=
X-Google-Smtp-Source: AGHT+IH+HnLs0pNZp1rR2GdvLGo33LZqnwfZVJ6ChF0vq01+k5XlHHTocJKc1ba59OCyMNdPo2Y8Pg==
X-Received: by 2002:a05:6512:1152:b0:53d:f71d:199d with SMTP id 2adb3069b0e04-53df71d19b5mr1533541e87.22.1732857202728;
        Thu, 28 Nov 2024 21:13:22 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f08csm372928e87.164.2024.11.28.21.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 21:13:21 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffc1f72a5bso14998511fa.1;
        Thu, 28 Nov 2024 21:13:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDD+eKlssE/WCziYC73DAkiRa4kF+/N6W1oWySLu6c+AyYyRxtITq7DnAf6eNrSfyxrmrc9LCtl3uf@vger.kernel.org, AJvYcCWDyhxQK/XbXa8a4Nrl08u70roYffQcw5WwW+mP3r6KrPIg94CkmnQ5xhhUPUfGPo1KHOTjxyUJ4r8BZezb@vger.kernel.org
X-Received: by 2002:a2e:9687:0:b0:2ff:e54a:cd08 with SMTP id
 38308e7fff4ca-2ffe54acea4mr7224861fa.3.1732857201437; Thu, 28 Nov 2024
 21:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128154556.2743839-1-simons.philippe@gmail.com>
In-Reply-To: <20241128154556.2743839-1-simons.philippe@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 29 Nov 2024 13:13:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v64b-m8XoXWXyPFLZKpfTJd2beE_QjUUbf17o4y_rfTmJg@mail.gmail.com>
Message-ID: <CAGb2v64b-m8XoXWXyPFLZKpfTJd2beE_QjUUbf17o4y_rfTmJg@mail.gmail.com>
Subject: Re: [PATCH] Update H700 opp values
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 11:46=E2=80=AFPM Philippe Simons
<simons.philippe@gmail.com> wrote:
>
> My H700 (RG35XX-H, RG40XX-V and RG CubeXX) devices are very unstable,
> especially with some OPPs.
> Crashes were fairly easy to reproduce with any dynamic cpufreq governor
> and some load on CPU, usually in matter of minutes.
> Crashes manifested randomly as simply hanging or various kernel oops
>
> Manufacturer (Anbernic) is using more conservative mircrovolt values,
> so let's use these.
> While using performance gov seems stables at 1.5Ghz, it still crashes
> using a dynamic gov (even with Andre reparenting patch), so let's drop
> it for now, like manufacturer does.
>
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com
> ---
>  .../dts/allwinner/sun50i-h616-cpu-opp.dtsi    | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi b/arc=
h/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> index dd10aaf47..ac13fe169 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-cpu-opp.dtsi
> @@ -50,24 +50,21 @@ opp-1008000000 {
>                         opp-microvolt-speed2 =3D <950000>;
>                         opp-microvolt-speed3 =3D <950000>;
>                         opp-microvolt-speed4 =3D <1020000>;
> -                       opp-microvolt-speed5 =3D <900000>;
> +                       opp-microvolt-speed5 =3D <950000>;

It seems that you are encountering the issues on this particular binning.
Could you mention that in the commit message?

It's not very obvious that H700 =3D=3D a particular speed bin of H616.

ChenYu

>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
>                         opp-supported-hw =3D <0x3f>;
>                 };
>
>                 opp-1032000000 {
>                         opp-hz =3D /bits/ 64 <1032000000>;
> -                       opp-microvolt =3D <900000>;
> +                       opp-microvolt =3D <950000>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
>                         opp-supported-hw =3D <0x20>;
>                 };
>
>                 opp-1104000000 {
>                         opp-hz =3D /bits/ 64 <1104000000>;
> -                       opp-microvolt-speed0 =3D <1000000>;
> -                       opp-microvolt-speed2 =3D <1000000>;
> -                       opp-microvolt-speed3 =3D <1000000>;
> -                       opp-microvolt-speed5 =3D <950000>;
> +                       opp-microvolt =3D <1000000>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
>                         opp-supported-hw =3D <0x2d>;
>                 };
> @@ -79,7 +76,7 @@ opp-1200000000 {
>                         opp-microvolt-speed2 =3D <1050000>;
>                         opp-microvolt-speed3 =3D <1050000>;
>                         opp-microvolt-speed4 =3D <1100000>;
> -                       opp-microvolt-speed5 =3D <1020000>;
> +                       opp-microvolt-speed5 =3D <1050000>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
>                         opp-supported-hw =3D <0x3f>;
>                 };
> @@ -93,7 +90,10 @@ opp-1320000000 {
>
>                 opp-1416000000 {
>                         opp-hz =3D /bits/ 64 <1416000000>;
> -                       opp-microvolt =3D <1100000>;
> +                       opp-microvolt-speed0 =3D <1100000>;
> +                       opp-microvolt-speed2 =3D <1100000>;
> +                       opp-microvolt-speed3 =3D <1100000>;
> +                       opp-microvolt-speed5 =3D <1160000>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
>                         opp-supported-hw =3D <0x2d>;
>                 };
> @@ -102,9 +102,8 @@ opp-1512000000 {
>                         opp-hz =3D /bits/ 64 <1512000000>;
>                         opp-microvolt-speed1 =3D <1100000>;
>                         opp-microvolt-speed3 =3D <1100000>;
> -                       opp-microvolt-speed5 =3D <1160000>;
>                         clock-latency-ns =3D <244144>; /* 8 32k periods *=
/
> -                       opp-supported-hw =3D <0x2a>;
> +                       opp-supported-hw =3D <0x0a>;
>                 };
>         };
>  };
> --
> 2.46.1
>

