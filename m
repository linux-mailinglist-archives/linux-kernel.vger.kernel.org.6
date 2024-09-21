Return-Path: <linux-kernel+bounces-334838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9AD97DD36
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F5D1F21B95
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0441D16F8EF;
	Sat, 21 Sep 2024 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEn4sQhD"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5C137E;
	Sat, 21 Sep 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726921486; cv=none; b=i91rTtbXo5BU3YBSzBjyT1609miwD1hg0JVcyRIQZ8K7bggYthQ3xH8FXzwO59ZeD7OhcxEi0DU45pyzGfCnecXY0OkVbm6si2BERRnrfnrCHmWdEd91TaVJqybkp/KqIyqNhMGW93RrOXb8CgLWxz1Ps4SxBIkTdHkImJGYdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726921486; c=relaxed/simple;
	bh=Lm5wT3nctgKw603dwlAmokov0gKbgWJJS54F9VbU9Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o05dQ8RHLcN+doF+etaPIqx02wf6RU5XTNozjJBaAEQr/3yyr7Pz0Q5sskMlGKvBSmjAa8ZhttbfYRWS3vDPO0ss8zLjxXEapQ2BjpMCGYeHksoOneBmT9DT5pfRAm1+o/QvP+KqvD0dnZi/zLvu4QNIX5T4PNXMRgNFq+Ex9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEn4sQhD; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53654dbde59so3781633e87.1;
        Sat, 21 Sep 2024 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726921483; x=1727526283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnV4AAkppYdl3VxpkVdBWhDkeq1tyHDu6V34X7mplIs=;
        b=aEn4sQhD8vkSZF6exOfNB1HXli4naG8OE8uXoFsZRFVKnw5rUknwATcooGRC/MlqHQ
         jNjwjR7qnNM00GFgNigRAbF9Q6RWtBCnMFDzXn3uWUrJLv/jgTDJnG0vQhjcvMhfITrf
         iKsICk8VpjxEFQjKAKQf4Ux2M7fqG0l5hGN+3WQxgeq1diQb9S4cazCnmgtxzODTkVjn
         du6WEsILsUfk1/4hczT5SrKb7jikrmmyR43IgEPa3PrXVl4g7phXGSEsNIV90YI50rs5
         74JTa3amWeQSLEayTD+u10tsw7lFEibBel1DefjN81VToeHU6QHCjksIaVFlf6/i6IaA
         H8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726921483; x=1727526283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnV4AAkppYdl3VxpkVdBWhDkeq1tyHDu6V34X7mplIs=;
        b=CPCHZ2O22Zkdxw3r/d1Ero5s/z6ltdlt+cv68K/DOt3KlHRvmvHuOBbNXwErncT5nk
         MyLDBvOLyQE9M2SiUL+EbUGxcFE5PBJW2h/OUwR775gQhPNx5tUyEtd6fOOVLImLoZsN
         R48jYJlrOm9UWBZC6TzywPsQ0d4IkMaSXfQqk1o7gP0iou8Bm593tuQeiXh2FOeKm5C4
         pHhT0j4uCHXJ2G4o7BZzVDGMajE3xYCIKtTrmdfJrssz3GSbbIB+GWCcsXUB2R0HoKqU
         ILYgARU5U5GTL0YdLUmaJIwqHtCXpsrJCY2YNovdtZwnAla6psU4vPaS8s1R0iuF/OXo
         GJlA==
X-Forwarded-Encrypted: i=1; AJvYcCUHBxmL/S0Fu2EU1krEaOUQtWURZDR32p8Aza1GVGOsySEUMuNzLrRlJoT+V3MzCHptnH5EHVq8XZtsCvyG@vger.kernel.org, AJvYcCVW4p+PzxWvgZ1i1TqWlB51BU25Dg/Hu4FAnux+jnWAcIINwFkaatfAbPlzyI4YdDe6jqVCdWIoBP2+@vger.kernel.org, AJvYcCXCb3uqtYJeKBC+4FQHhzOCVY3/c6VwcBEmkERNWT7RIZhV/HK7GOgYmlFtGgbrb0dKDbwanaJrruBz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8ooDKa1EPe9/AX01H5ml/qSCTKVbjnNHrqTLvYM5WhM5k+rO
	fme/9l7hvc2vjv9z7oPxZ8a+rEDPMeIw8RBWyhkcBcYzxNsdfabTmFn3rJVd4hZ1dDscq/YDsrq
	1jxDpGMBAafgAoIfsn6dBykh6zp6Sss7u
X-Google-Smtp-Source: AGHT+IHoWHrGLBUT8JY+piHvjihWgo99vAImbbX2yX9mk8Be7SSOMzH323JpYw94nPlLuAepPzXyxgM4onEBHNSwyKg=
X-Received: by 2002:a05:6512:a8d:b0:533:3fc8:43fb with SMTP id
 2adb3069b0e04-536ab7c7c4emr2435107e87.0.1726921482619; Sat, 21 Sep 2024
 05:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920080154.1595808-1-michal.vokac@ysoft.com> <20240920080154.1595808-3-michal.vokac@ysoft.com>
In-Reply-To: <20240920080154.1595808-3-michal.vokac@ysoft.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 21 Sep 2024 09:24:31 -0300
Message-ID: <CAOMZO5BrmuWdiEo6xi8ChT01jfLMaLAb88iUhS1kt6qqr_h7pQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: imx: Add imx8mp-iota2-lumpy board
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Herburger <gregor.herburger@ew.tq-group.com>, 
	Hiago De Franco <hiago.franco@toradex.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Joao Paulo Goncalves <joao.goncalves@toradex.com>, Michael Walle <mwalle@kernel.org>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Fri, Sep 20, 2024 at 5:02=E2=80=AFAM Michal Vok=C3=A1=C4=8D <michal.voka=
c@ysoft.com> wrote:

> +&usb_dwc3_1 {
> +       dr_mode =3D "host";
> +       pinctrl-names =3D "default";

Per Rob's robot message, this pinctrl-names entry should be removed.

