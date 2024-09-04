Return-Path: <linux-kernel+bounces-315746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775FA96C67A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235CA1F22E74
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C551E133A;
	Wed,  4 Sep 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enJ88dFg"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB9E2AD02;
	Wed,  4 Sep 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474684; cv=none; b=UZ88hn8VwxgCn4T+xOVFe7tD0zQjtzq+8FhN3d8qegesVFe3s2scFxuSPeL+LBrCwV59kAh+/8SWyOglTB/5dZ7JwuODanO/5587o4hAZC+KgoaXs9gF3aPSw7k7v+afMInye8iyLM7t06LTwQK7IIYCPwTrDT1AsILS3pQvLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474684; c=relaxed/simple;
	bh=cqZTeCKtiWRNmN3gcAtdrz7XjCzXiplabvraNaLf8FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPfya0E5xc4iZ7vlfAAtmS4nPwmCuVDRssL6i/6HZbzwbKWPoZEypk4j/E204K09Z35WIGQAivegnIuw5MyJcV4XfA0yOJiWEekUy9yqzGzT9Ute0/fNyiVFynQd3mDwPfAgVaUkiHz9D5v/5ebChHQ2OOdENiFJ3xK25u2ySJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enJ88dFg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533496017f8so9131585e87.0;
        Wed, 04 Sep 2024 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725474681; x=1726079481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqZTeCKtiWRNmN3gcAtdrz7XjCzXiplabvraNaLf8FE=;
        b=enJ88dFg5uaMgJMx+c0QcHEzpcahrmREoEiOTxtwKFw5m5PU1moGtpnuyoNK5kCJT8
         B9dlg5mvEip8wIASvmq6x1zSU3FKhsh8k8N7FL9Yn+8BS/xJT83AodfedIq7szgGNgAq
         7LhuOidCAS+2OlZRE3M2Pb9XuCkf8X7K+QNbaeIwOa1y9HKathKvIft+SiMTjOxkJI5R
         npDXSkSSVa2Rxxp9NI13nG6MRQLrAsZZjfbDctCr4DIm8DLhqWClMPlWmYGtiOypjBom
         t9jUrwb/w1MddR7SxMD6gDefI5b1EidC6CS28llGWCFSWWJzFOY6W6+w90eONS9PFh6a
         uMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474681; x=1726079481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqZTeCKtiWRNmN3gcAtdrz7XjCzXiplabvraNaLf8FE=;
        b=UAbnAa1sTCSCX5qkdD6vilwMWsZsvFatyFwX+uPVVEUln9KLLUJlAQyR1QusZcVucn
         hZWOIatxTVIu07UUnJg81wpZbFuaSn7hsnBHs9Z7vGvrO3xyQXJ+NZtb/0hC5CRWpBBw
         hwP2Q3MFS3U6J2GSADFCoVW9JAuCT09/hyprVEpkAfgo2/QoA/mhQ6iuFCKPwBiOsJa4
         caTEcRsXH6FFPf8CVWl35FmutaG5XVTR1ZYEurNxg9RJO2a8rOuHI4eu7oIXReKnCVro
         mOY2mgUnc5wnIS6933DbxbxiLih2Q6w/DdAyrldEd/P/s0FFwzZ7GA3ouigHjQsH9Ue2
         hrHA==
X-Forwarded-Encrypted: i=1; AJvYcCUwp38OaigefazEBWN0QJyA7lFBEgavJBfPab1k47NVZx9oRgkQYZ5Z3GcKzRtUKGTr9KM18VKXxwHIur/B@vger.kernel.org, AJvYcCWAO1W3IQBLZ8OVHPoSyFkSaNfR1j2UGN4cFvVkaqja3oCgituYLETESOkDKZRX12fkyU2EdCNso1aQ@vger.kernel.org, AJvYcCWFzqg0CJVk3RQvyyh0vTr+JZzZKeSWdKdaHx5pqvterVMxs9RV2Mdwm4uPaCMBqCJEyNd/sWKjW+d4@vger.kernel.org
X-Gm-Message-State: AOJu0YysMHY04m2OF16ah/9375ZegzTaAFByp6L8CCew+mFok7Wefb03
	M2Ftog81OUClST3y7AbGDCQBFmTuAa5aX+vKMEn56jn3AIIas6ICDewrX8fStT4nMdEkYdLWUDi
	HVTZY0bnvBd/TnM6a9hE8Todvl5w=
X-Google-Smtp-Source: AGHT+IFPTDmBPzfMHi+JBca0iBl6QnzPcfCv2Mi+TGhi7mW9W3f/6R0U2aXmin1rHR0zhBgKT/q01r6RE4rYphIlEjY=
X-Received: by 2002:a05:6512:159a:b0:52c:e047:5c38 with SMTP id
 2adb3069b0e04-53546b0401cmr12698659e87.15.1725474680916; Wed, 04 Sep 2024
 11:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com> <Zth7LdsV/KbjzB2b@lizhi-Precision-Tower-5810>
 <AM9PR04MB86049FFFCBB357E3BC1E4C90959C2@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB86049FFFCBB357E3BC1E4C90959C2@AM9PR04MB8604.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 4 Sep 2024 15:31:09 -0300
Message-ID: <CAOMZO5DdujNkL91+8tzO2VzS20ipRGDCyzo8ppa0A33V0ZvabA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Changes in v7:
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:09=E2=80=AFPM Pankaj Gupta <pankaj.gupta@nxp.com> =
wrote:

> Thanks for pointing it out. Will ensure not to repeat it.

Please trim your replies.

Your email had 341 lines and your response was on a single line.

Please remove unneeded noise in your replies.

