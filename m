Return-Path: <linux-kernel+bounces-189178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB68CEC81
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9E1C20CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604C128385;
	Fri, 24 May 2024 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N8gWPnnw"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF284A01
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716591312; cv=none; b=ZFhHrnJV87x1zsW2Y+L31N1REh6Dow+Zh6tv/Yv715mvucwZSMk1gIZl3zPDOYbnlBX0NL6KCAGqdVw2CqR8A1tYLyOuBtKM1bGuVm0Pn73/rOw6kLjR9flCJUN9HzLTbihrN0iIv551/ht1MuCk8nho399SCCA/NOfEG4Usu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716591312; c=relaxed/simple;
	bh=vFIQk8rk4nhAX1GMl30ET3KpsGu/hdAnGJjqSaqy4vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL8I+3L+PCBkvbqUKkejYFUm8YH5pdXQaq2Lrx2CKj6od0av31Ff2Io1UAsvE+nL8HvOOwdtEClCJCeNxx0/Qv5QNUUIcSWzaHqYyQHOZ1SsSGCCSWy6NBVSR8X1T3HTaiFvacNM1fmFkxBCxzkaltdOEBLfEnKXA15fLPN/4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N8gWPnnw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57857e0f45eso1087510a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716591308; x=1717196108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFIQk8rk4nhAX1GMl30ET3KpsGu/hdAnGJjqSaqy4vI=;
        b=N8gWPnnwKwrp1nYOSPOygvMc60UP/ygxWE+ADcykYV/4C8/qWGfDb26PbK7NvNnI0C
         ekn44p2UzOLRK/DLIF5laPVSyKXvM3D3OjgbeIsq5VAx08tdhATDwSr0dhUf+AwQTyww
         hdfV84aiS1Z8FZQIy+mNGEuK+lM8WCGXD9w20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716591308; x=1717196108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFIQk8rk4nhAX1GMl30ET3KpsGu/hdAnGJjqSaqy4vI=;
        b=HuWRw/bQi8t6aPjBbmXUw7nEmNICW2Ck2jDXNfxf2SwT73+WBG1zOpweQ9ck6syozz
         Qyh6Y9m+h14x6AhSYKDi6ji1meflUzngj5qDKwxq4ZTkBl2H2QIwVWVttURvTGqguwB9
         98sL7PzdUrqcrkbawx4JXzdHT5pWGc9Bg7OLg2+7HvzAOrz+4PnftIrlW4UP8aFS1W0R
         xRSASgA6+Oveqs+DNNL7QR4jBkzPjQlpxWj/1AAxl3hTd4mqDRmLZGqX4lzcTCMYnBD3
         AIKwJNyYa3q6eI9cBq4Kjx8Ag7ghP/S5ES9i0zglteMO3sJLwOKKKGfglaPRxFxtamY+
         gRng==
X-Forwarded-Encrypted: i=1; AJvYcCVT15QdSm18eT7RUoKn/8v61HIGS9B95ppZNbqkT4meBq0yrHaCKhzMmM34+/GxIT/UzOyDX7txSIlJFHRaAFqz49KAXBbizBifoOik
X-Gm-Message-State: AOJu0YxtiSFbWZxNTjKm08j15cYzER2EqamCudRq7Xm2EPH480bXM9VW
	KYjG1KuO+cWbbO7OUGhJ6Qs7ZSD2UOc2lNZRElE+LOmkQSwh+yETlRsL+OXEWVD11BbJdXojyys
	HyA==
X-Google-Smtp-Source: AGHT+IEgJDNR4Kkr5KEkrTA8DR5eg2u0Hdim93JOOYLnI/HwiRiUA1DA8ra/vZhj8KomtGE7O7TXrg==
X-Received: by 2002:a50:cd08:0:b0:572:637b:c7e1 with SMTP id 4fb4d7f45d1cf-57851966484mr3114529a12.21.1716591306980;
        Fri, 24 May 2024 15:55:06 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578523d2507sm2325638a12.40.2024.05.24.15.55.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 15:55:06 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso1317605366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:55:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOpGERqDzaKb8NuCulq3Ly2N0MqaoUTJ95ZNyUFGsjB/AGEXqy5fq9CCVn5n3bVm6/2N4ukY9Icgdfg8EPTH6QCaGrCyEGGRybNJJn
X-Received: by 2002:a17:906:35d8:b0:a5a:5c98:c595 with SMTP id
 a640c23a62f3a-a626511a554mr347429966b.61.1716591305542; Fri, 24 May 2024
 15:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <Zk6TklTIbxZxIWyb@google.com> <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com> <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 24 May 2024 15:54:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
Message-ID: <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 3:01=E2=80=AFPM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> I think it needs time to support probe client. Can we put your suggested =
comments to the code
> used to hook probe_client() and add
>
> "TODO: support probe client" to mwifiex_cfg80211_probe_client().

Are you suggesting that you plan to actually implement proper
probe_client support? Did you already do what I suggested, and
understand why hostapd needs probe_client support? This seems to be a
common pattern -- that reviewers are asking for you to do your
research, and it takes several requests before you actually do it.

Now that I've tried to do that research for you ... it looks like
hostapd uses probe_client to augment TX MGMT acks, as a proxy for
station presence / inactivity. If a station is inactive and
non-responsive, we disconnect it eventually. So that looks to me like
probe_client support should actually be optional, if your driver
reports TX status? And in that case, I'd still recommend you try to
fix hostapd.

But if you're really planning to implement proper probe_client
support, then I suppose the TODO approach is also OK.

I'd also request that you please actually do your research when
reviewers ask questions. I'm frankly not sure why I'm spending my time
on the above research, when the onus should be on the submitter to
explain why they're doing what they're doing.

Brian

