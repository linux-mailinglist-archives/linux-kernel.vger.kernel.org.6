Return-Path: <linux-kernel+bounces-385576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13859B38D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684BB1F23364
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7461DF99D;
	Mon, 28 Oct 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JQQPzl6+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AA185B54
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139136; cv=none; b=ovTPjN0rZziHnkssfYbfyUO50Ebt4GBijAearS7YehoCLyyLbyS+cFkDmXCICn4N5ekJWa0KJKol+JmnH8/NmTggDDZll2IgjJx25Qt8yKGjCSkEQsHbzf7lKEazQ0eJmvf9C9LUqcSr6xkP7BQ6N6NNPPxisBH72xlx5o0iK+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139136; c=relaxed/simple;
	bh=mDrRQj1Mrib9/EgojunqyD42XEGRcvIiFq/4nXqWp9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYKkc1F04k6WLnpb34KPNpIHOod7LAi0OmUnTqjdbAcrqaAw6JbTkNqSX9+7kmbYMUt819y8UOHIUG+9+Y4Vyi/pcDBh3BI6F/TIFUJFoOzAE9aWfW+DlqxYydmXOaiyxr502XtpfrauHoepPV/RZ3GGKI3OSjTOz4avQmDic0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JQQPzl6+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso4693373e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730139130; x=1730743930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5Mp+oG6fw51RJspX3eEPAbfvpSkKVhKdPlkTR9F3Y8=;
        b=JQQPzl6+cJYB/rNnS1nfqyP46u6TwUiqLNg9q9SinCrTS4Uk7bxb3HG7yKAxcPwxv4
         80WwSCo1GELDjo8Ftygr8g9Yckh+IAmGhcroSdJwPsK8+VfK1kG3jYVVDSVHCcI2aoJj
         DhD5BLfx8ZoceyIdQ6MvOhjNDTJK4zilj+fKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139130; x=1730743930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5Mp+oG6fw51RJspX3eEPAbfvpSkKVhKdPlkTR9F3Y8=;
        b=V9JV2DxRkEd9DRSQmnuWd1Z+eTIlSMOa9WkeZJvJeNBkt2okuZe5WB0nQoT3EqU4XD
         fHEigKXPhVmaP6+glgQHGVAumOT1ACOxEl7Qei1acMoYudT9xi6I5nSrjFgEUp2wU3uh
         3wdsvCc6MzvRd0uGs2xu1xLFVDTjNMHDTyNQvDyTBRkOflRKhzjg4BVXV6Rs+v7IfCqq
         8wv/Na7p3t0+1ki01mwCaSScMz5EVRlv3m7LAt7gLmLjMT1V8gjVUaJqiBlxWC1vNUEg
         nt+dGo95ug4aIwD0wx4qH66H4mbwSYGMi4GkBPv0pcxWcE0dXaQK/b2CuXUA9jbFWEz7
         /Vag==
X-Forwarded-Encrypted: i=1; AJvYcCURHAobe1PbozLQSS/nhkGrx0YPKIS7mwUD5x8ybIerm3fe54DV1h17bHJIPfHbrk21dY8imBpm11JI0U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKwPOlot/uVSOr58XtMEVkUQe1HbgXE7TgJKvrPhgB1vk5iBe
	nNAskYINClTW0xFIGaHkUXURRgRiTD5nHeZwjDXNcKaQg/E52UTUdedzwr2BMyzwlYdmCj16WJo
	hJA==
X-Google-Smtp-Source: AGHT+IESH5kPY0aTKS3XnM0SzCRZy/dSzG9GAov6P+FhOi6VJntt/J1+FHYgNkI3/FvpBHERQs2APg==
X-Received: by 2002:ac2:4c41:0:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53b348cf0c0mr4094255e87.14.1730139130422;
        Mon, 28 Oct 2024 11:12:10 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1af388sm1147667e87.172.2024.10.28.11.12.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:12:10 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so44432271fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:12:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX38k8+TKpz4z9Z4m3hEmdRtRrSusiUAnMLfzEtcrygpnl46nOJK65QfDguItO+8H0budEP2h/OWO4O/nk=@vger.kernel.org
X-Received: by 2002:a2e:4619:0:b0:2fb:5504:794d with SMTP id
 38308e7fff4ca-2fcbe0bddb9mr33372431fa.44.1730139128714; Mon, 28 Oct 2024
 11:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026144724.GA892311@lichtman.org> <20241026145417.GA892629@lichtman.org>
In-Reply-To: <20241026145417.GA892629@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 11:11:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+YLXs8GugQUhqK9aQM_eRzoJwLc0Yb_OwW9baqHkPKw@mail.gmail.com>
Message-ID: <CAD=FV=X+YLXs8GugQUhqK9aQM_eRzoJwLc0Yb_OwW9baqHkPKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kdb: Replace the use of simple_strto with safer
 kstrto in kdb_main
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 26, 2024 at 7:54=E2=80=AFAM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> @@ -2083,15 +2064,10 @@ static int kdb_dmesg(int argc, const char **argv)
>         if (argc > 2)
>                 return KDB_ARGCOUNT;
>         if (argc) {
> -               char *cp;
> -               lines =3D simple_strtol(argv[1], &cp, 0);
> -               if (*cp)
> +               if (kstrtoint(argv[1], 0, &lines))
>                         lines =3D 0;
> -               if (argc > 1) {
> -                       adjust =3D simple_strtoul(argv[2], &cp, 0);
> -                       if (*cp || adjust < 0)
> -                               adjust =3D 0;
> -               }
> +               if (argc > 1 && (kstrtouint(argv[2], 0, &adjust) || adjus=
t < 0))

Between v2 and v3 you regressed. The kstrtouint() was supposed to be
changed to kstrtoint() here.

-Doug

