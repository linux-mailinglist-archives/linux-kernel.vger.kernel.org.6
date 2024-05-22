Return-Path: <linux-kernel+bounces-185756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F78CBA38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CFB1C208A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75866026A;
	Wed, 22 May 2024 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP6XuLQj"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2511DDE9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716351039; cv=none; b=NmSTn8x/w5SRNlI7pJ6vkybRmrxvDTIMGelYzEfX5E7+h5wLgYGnz7MxMQnOqJtYHUwVauakgHaT7twPaJwCNs8kb1YLORo+ts8AKNWPuhQJZ6utrKsZ0VRxdWX+isnMcwWfVf6FkwYakIua+nF9DBS4KbV+yj2usJtOIsJH5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716351039; c=relaxed/simple;
	bh=1oafiKVBFuWBNVbOkGlV0dgnt7V1qUFFgDrp7qRXDO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdcevC4NArI6qobwYCkGEXrfYpfGwwbQu6Nf50QrzNSoJS4lOUxBiJOtHwlrRa7muG7XQ9uCbtnqj64fiSoXFHitgSYJKz5CHuvhYOZfiWDNoaCVtjPgCh3rl2Ecmh9TVlqZzxIELETjyOFXYq1+HYctUXzm80jeFLtcm1it/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP6XuLQj; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b2dec569e3so2579300eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716351037; x=1716955837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgSeXxmgoRIUV5Txe9egQU8ABDcaKhUa27/It2jbyDg=;
        b=DP6XuLQjhSgu1F+V6FUjwOAbekDua1eJ4aSinn29oaPrJgqdVJi7VSZRxil+TUbC/e
         BHV9iW9qq7vz1vZsh4Lhd+s9eDRtXNpa8qVsQ1Xab7GN6SeOU1wG4XHU7pI6OfGcRv1S
         QVKIKpB++IjXFC2AQfQkHQ7UsdrciT9LYcW2REJDWFEMuYtpSjbQGRBD0DXax0IRV8XM
         NEt2B/CXgoByOaBUiAVH+QBuqjD1EluFLFAgyQBYNHDRq3Ya5p9hfyC0s3RLXGVR6b3S
         vHqdRgBCuzUiCUwRH4qw0ltO0p2PXWWymNUyr7AszRo4iP0lXuv3EZrynUGrn0B02yli
         wvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716351037; x=1716955837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgSeXxmgoRIUV5Txe9egQU8ABDcaKhUa27/It2jbyDg=;
        b=oSAzBJGmQVViL4Gl1TwR3vUiV2Ul75XVNslP4qL0YwCqPVx13i3HPslK3I/xOKBOR9
         S0+uDi4N//c9od/0slXVX3K6cYe/tLw1+cyT1wTtysQCXGtjkKY1c+2F/4C4l+uryrFX
         IEIaSmIpQkdTOKv3crwnt/CI46F+ATgpF1qbtTScNDF9RkvRbP9Iq0fmwLWP9+Bt+U3Z
         2TCP/iTpj9WRgbwDzqmULgx+9/ILKc5MpFvXXlDh988EXBtQ8aJh19hgtKEU4jPhL7Sd
         FXN0e+guktwzDrs8E5Dz8+tu2VdMDOSoJPbrYsh5d2REl65XdDGAij6fUElcLyLb+gx4
         vUGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqTwwHmSlplYrkt8h9jdnayRfDt36GEEcI72wAC3P/Uku9LwoTFOQV/QMR5JK1YfU+sRTkNbAq4QnMNkf2duz5Q+ky3IJdAXIS/hva
X-Gm-Message-State: AOJu0YxMYyGCUWO2JRWfXQ1AU4TumpqMH1i5m/60thv/GiNyNdPPEZdy
	2EJFgy7SL+X22mh9YVvgBcUc/QBaLD2yUXLVzTIyyopyIccdc43B0cwtGe5LgrCDKymZu+fS17r
	GxESkieUZ1vffi4oD2VRDb5Or8IA=
X-Google-Smtp-Source: AGHT+IHtkmxDoImQvsL7YNCDqUM0EgUSrkWs8oAp5tAEYabe/YGfep6YdpFavQj7M4KZqyolRadUIEfkHCoopnzMjd8=
X-Received: by 2002:a05:6820:1ca7:b0:5b2:9d0:4d91 with SMTP id
 006d021491bc7-5b6a0c10354mr950727eaf.1.1716351036688; Tue, 21 May 2024
 21:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521005649.12144-1-xndchn@gmail.com> <20240522010559.10551-1-xndchn@gmail.com>
 <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
In-Reply-To: <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
From: xndcn <xndchn@gmail.com>
Date: Wed, 22 May 2024 12:10:25 +0800
Message-ID: <CAJ=gGT1Ojxe3vLNVAoXHO4j1_-71YafRXkVkd34Oqyzs9r3VwQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: better support to ARM32
 module stack trace
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	quic_bjorande@quicinc.com, cmllamas@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, I'll split it into 2 patches later.

> Your change is to strip any leading/trailing characters before/after the =
[ / ] respectively?
Yes, exactly.

> Isn't this a problem for $symbol as well
there is already a strip logic in "parse_symbol()", which seems
introduced by #e260fe01, also for ARM.
> # Remove the englobing parenthesis
> symbol=3D${symbol#\(}
> symbol=3D${symbol%\)}

On Wed, May 22, 2024 at 10:48=E2=80=AFAM Elliot Berman <quic_eberman@quicin=
c.com> wrote:
>
> On Wed, May 22, 2024 at 09:05:59AM +0800, Xiong Nandi wrote:
> > Sorry about the name, it is some kind of abbreviation. So I re-post her=
e:
> > ---
> > Since System.map is generated by cross-compile nm tool, we should use i=
t
> > here too. Otherwise host nm may not recognize thumb2 function address w=
ell.
> >
> > Beside, sometimes special characters around module name, such as ARM32
> > with BACKTRACE_VERBOSE in "(%pS)" format, such as:
> > [<806e4845>] (dump_stack_lvl) from [<7f806013>] (hello_init+0x13/0x1000=
 [test])
> >
> > After stripping other characters around "[module]", it can be finally d=
ecoded:
> > (dump_stack_lvl) from hello_init (/foo/test.c:10) test
> >
> > Signed-off-by: Xiong Nandi <xndchn@gmail.com>
> > ---
> >  scripts/decode_stacktrace.sh | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.s=
h
> > index fa5be6f57b00..324e4a6c260a 100755
> > --- a/scripts/decode_stacktrace.sh
> > +++ b/scripts/decode_stacktrace.sh
> > @@ -30,6 +30,7 @@ fi
> >
> >  READELF=3D${UTIL_PREFIX}readelf${UTIL_SUFFIX}
> >  ADDR2LINE=3D${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
> > +NM=3D${UTIL_PREFIX}nm${UTIL_SUFFIX}
> >
> >  if [[ $1 =3D=3D "-r" ]] ; then
> >       vmlinux=3D""
> > @@ -158,7 +159,7 @@ parse_symbol() {
> >       if [[ $aarray_support =3D=3D true && "${cache[$module,$name]+isse=
t}" =3D=3D "isset" ]]; then
> >               local base_addr=3D${cache[$module,$name]}
> >       else
> > -             local base_addr=3D$(nm "$objfile" 2>/dev/null | awk '$3 =
=3D=3D "'$name'" && ($2 =3D=3D "t" || $2 =3D=3D "T") {print $1; exit}')
> > +             local base_addr=3D$(${NM} "$objfile" 2>/dev/null | awk '$=
3 =3D=3D "'$name'" && ($2 =3D=3D "t" || $2 =3D=3D "T") {print $1; exit}')
>
> The nm parts should be a separate patch.
>
> >               if [[ $base_addr =3D=3D "" ]] ; then
> >                       # address not found
> >                       return
> > @@ -282,8 +283,8 @@ handle_line() {
> >
> >       if [[ ${words[$last]} =3D~ \[([^]]+)\] ]]; then
> >               module=3D${words[$last]}
> > -             module=3D${module#\[}
> > -             module=3D${module%\]}
> > +             module=3D${module#*\[}
> > +             module=3D${module%\]*}
>
> I need to get a moment to play with it. Is my understanding correct that
> the problem is that the last word ($module) is:
>
> [test])
>
> and after the existing strip logic, $module becomes test]) whereas
> expecting just "test"? Your change is to strip any leading/trailing
> characters before/after the [ / ] respectively? Isn't this a problem for
> $symbol as well -- it would be "(hello_init+0x13/0x1000" in the example.
>
> - Elliot
>
> >               modbuildid=3D${module#* }
> >               module=3D${module% *}
> >               if [[ $modbuildid =3D=3D $module ]]; then
> > --
> > 2.25.1
> >

