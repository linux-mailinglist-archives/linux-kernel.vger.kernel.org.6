Return-Path: <linux-kernel+bounces-238229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DFE924739
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E4BB2139F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BBB1C9EA3;
	Tue,  2 Jul 2024 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ry5Q7izp"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D31DFFC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719944527; cv=none; b=bUbYNh5YJNnvjYOVMIEcIffUEF23syyT+OAoVIFWGgVhUNHKtyNpM0fUlf6HVuWm+rQVhPgpDAnC/Yv0oQUnjiqId3yGGjVYlSWpBjACgEFSlmvnqAVGG6CJjeaJNqRXF6BjrqQAQKXYf6yLBIF3vHSe1Nmnf0yeTJVln1+6qyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719944527; c=relaxed/simple;
	bh=E2J2QkQQsRJmh3/tlADcUy8VsBpOGKquPnoZlertLNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3se97HmiMVwann8fyFmAdF8hrXYLDnA1YX/yUwAWhIligV0ja8WDBwnMA8mpKJDK2NedTppYNDp14fA5UGybNoJv0fp5siwX1PSFI3m8+cyCx6wmKT59ZekLZarWoRNK2Zk2xoGt4GetYX6wQD6+fLFQG9vgeNB4Lm3uQmW+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ry5Q7izp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso6996041e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719944524; x=1720549324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2J2QkQQsRJmh3/tlADcUy8VsBpOGKquPnoZlertLNM=;
        b=Ry5Q7izpTH4+NNPS2oYUY4w7pO+teqnbGK5a64T532AOhNFA4rXBOEQM5O/yOjnmBa
         usoic2JpCor1kAVXSZWOlL90o5nQBXsVN8xpBGD/vDMUIo7O1n+2bE1CvymIKHcqBP9S
         nHbWj5aaZVflMKobHhEbijt6BEPFJR8ja7FCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719944524; x=1720549324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2J2QkQQsRJmh3/tlADcUy8VsBpOGKquPnoZlertLNM=;
        b=IN1iiqdbUFHuJMPUZCjXI3o8aFHI2E4F1ADZmqJLUm++/BG3ejhNJoCFOlpOYlsgCM
         U8C+DS60xE1Fqm9TvTSYAqWsWVwyq5Ilal/f6N8sH82fzNBqLTrAISzivueNjT7/6A6J
         d0JB1rSFsMNl7qD/lekCRgVN0ffHPJilfm3rgIoghpeEj1kCaew3ZfiXVLhqxEUyZpdu
         sS5YZfuDwQo3cRdjbd0bK5AJHoJZw4RHrBaGhwha+9aleuoRf9vUVGZ9X6u8Srbx+uZy
         l+V2kpRNPHQl7sg+jHOJ51+/i+OybXkdnzAQ66EEGmy5MXte3gdlUAZaq+eSgSgNqnla
         vevg==
X-Forwarded-Encrypted: i=1; AJvYcCW5wQSyr0sNTZpmFgzXlBqh2TuEgCeYwR/fqUtLnQGpB1CU3psUy+CFZHxuLkk+vt64ZFo0D/iiY0SFJHBvbueJJBmz0YsRmPhNPXQF
X-Gm-Message-State: AOJu0YyAFCZXx3aF9xClrQxL0ogdfKUt3ReM6tPNGrZS8Z7C78t3Yvt6
	OIUvNfy3dLwdcVM5kX2Jt1zFQoEbdcsFeCdF33Kh+K5lVin7g59g/IJ1GV//RcRwXJRnbFw64o2
	u1A==
X-Google-Smtp-Source: AGHT+IEclaQ0c2FpfZx2xTbrFThyN/yQ68VH02nmbOo3xn6zQCxlCGQglMLv5EdumtLS/rGy0ytoQA==
X-Received: by 2002:a05:6512:1595:b0:52c:9d38:9df1 with SMTP id 2adb3069b0e04-52e82651a6fmr7012978e87.10.1719944523993;
        Tue, 02 Jul 2024 11:22:03 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b3bdsm1888762e87.288.2024.07.02.11.22.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 11:22:02 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cd717ec07so5654787e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:22:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhScROjwToDPwtPgujykxlcMFhlZHEsxRKBDVmVzzuNG9RwuTWPdOihMYASo2cIsfvpcE28TWIUQgHlmwof8KedYIF6LEf49xYFrMi
X-Received: by 2002:a05:6512:3056:b0:52c:dea8:7ca0 with SMTP id
 2adb3069b0e04-52e8270faf7mr5904357e87.55.1719944521845; Tue, 02 Jul 2024
 11:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <Zk6TklTIbxZxIWyb@google.com> <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
 <PA4PR04MB963875C85CFFA0EE2E914BEAD1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXMzHRs=CeyVeMbY44ornTa7f8G3ek3bFeyX39QAwr5bog@mail.gmail.com>
 <PA4PR04MB96380A04A6830AB69024E4B2D1F62@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <ZnRsfiau_JSWBXTZ@google.com> <PA4PR04MB9638E38BF0C8391582EDB121D1C92@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB9638F352F7026C4DFBD8C562D1D32@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXPjT1DywGG_7vVVKfRM-JCO8pBq0jm=yRGvYci2omnkNA@mail.gmail.com> <PA4PR04MB9638B0940ED592CB80A883BFD1DC2@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9638B0940ED592CB80A883BFD1DC2@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Tue, 2 Jul 2024 11:21:48 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPg86bzZDVeXRz+021RpbhzDm0zg6_Uqpoo4AJybvMbTg@mail.gmail.com>
Message-ID: <CA+ASDXPg86bzZDVeXRz+021RpbhzDm0zg6_Uqpoo4AJybvMbTg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 4:23=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrote=
:
> I want to confirm with you:
> For patch v11:
>
> [1/2]: Carry your "Acked-by" tag with following comment put to the code
> used to hook probe_client().
>
> "hostapd looks for NL80211_CMD_PROBE_CLIENT support; otherwise, it
> requires monitor-mode support (which mwifiex doesn't support). Provide
> fake probe_client support to work around this."

Sure. I never actually acked this patch, but you can have my preemptive:

Acked-by: Brian Norris <briannorris@chromium.org>

> [2/2]: Carry your "Acked-by" tag with the modification of mwifiex_mgmt_st=
ypes.

Yes.

Brian

