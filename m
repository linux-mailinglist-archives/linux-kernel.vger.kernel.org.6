Return-Path: <linux-kernel+bounces-529636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BF1A42930
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2D63AF590
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3F264FB5;
	Mon, 24 Feb 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="3gIivHkK"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56681264FB1;
	Mon, 24 Feb 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416586; cv=none; b=XrvBlraS56sgQ0l9hqV4f7+aAF19flq725cTKfi2ihq4Uzeildejxpw4J1iRqUbhYF+z8ZRAp0AT4zG5XJa5dndB8lAEotTQet2sVrzeJiFKaDr6FMNDzwQI9hKsI6GMGTOSd3uZP1Gl0gYc6BWCtuuDXQQFoWhQliay6ZqLUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416586; c=relaxed/simple;
	bh=n2lZ8k9oUq22PKfrQ6ce22//L3GqOg01Nk5ixHKJsvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gu/ArF4WZy1vFA7rNR+Q4vnrknmyOUH+z5HrGxhZXhuvwwsODKdovx8vghnIG4svZS0qJPi9G9BLKOJ0HxIfAi+n5Dy8KXOTjYwLPuU4CpeCogXcaMFCdGz8koAh9oXqBPl8YPj03dyn0gDkw6mmNaeLqAIV9M2iTNFBHtvSzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=3gIivHkK; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 76D6C2E08F44;
	Mon, 24 Feb 2025 19:02:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740416580;
	bh=n2lZ8k9oUq22PKfrQ6ce22//L3GqOg01Nk5ixHKJsvE=;
	h=Received:From:Subject:To;
	b=3gIivHkKxINwkI0NXbhow3EGi30oCQMc7ilLznbktaLSaHvdRjyybe5GegewltXbX
	 Qgug7Si/uKOCS0+AIY8YAXPyvOd9NalgYTIS3q4mByVtRQPicETwAUvKvD301ThCyJ
	 DNE7wTiF6U+E1cfudBKPG5LX14b7z8X4hhbyr/vs=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.52) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f52.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5484fa1401cso474326e87.1;
        Mon, 24 Feb 2025 09:02:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXpSoSOdMssRLq7YvFEIqHxlCDt3AVYYyGb89tT8EjI++3NQ8HVrpvlEFCu3xJGaNCYFuHgUqb7wILSjgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1Z77Qi1ALQzzcAmoxqelJLP84ZvfiJAjHO89mTBUDkwaTg4M
	2FFPjRSlryraQvW8FdxjE7ylVMLhCY9dVO2+UbKUA/8EUNLfB/r4ohylZvEFjLMvTtoyF1WKjqA
	yhnAfUizuTE3UquWJdJJmqPMkvv0=
X-Google-Smtp-Source: 
 AGHT+IGFQ72mOtg94FYVjEVsFldi/A6WofYFElWbdydv5ti61fFGgws/gBH8KthURKtfBjz1pRBUK2R4S00FM3JrNZo=
X-Received: by 2002:a05:6512:239b:b0:545:10cf:3462 with SMTP id
 2adb3069b0e04-54838f4e423mr5642542e87.41.1740416578675; Mon, 24 Feb 2025
 09:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224161016.439696-1-lkml@antheas.dev>
 <20250224161016.439696-3-lkml@antheas.dev>
 <004001db86dc$b32dec60$1989c520$@opensource.cirrus.com>
In-Reply-To: <004001db86dc$b32dec60$1989c520$@opensource.cirrus.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 24 Feb 2025 18:02:47 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHSbzDxCiO-xYNqNH20HovMnMk+rNLEatToX4js=gO_RQ@mail.gmail.com>
X-Gm-Features: AWEUYZl1DWVsw0PLPt9fKMNHMejG65PcIh5oxap3br6wh9Kqvn2_VdKHoFq484E
Message-ID: 
 <CAGwozwHSbzDxCiO-xYNqNH20HovMnMk+rNLEatToX4js=gO_RQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda/realtek: Fix Asus Z13 2025 audio
To: "Stefan Binding (Opensource)" <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, kailang@realtek.com,
	linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
	baojun.xu@ti.com, simont@opensource.cirrus.com,
	Kyle Gospodnetich <me@kylegospodneti.ch>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174041658016.14046.9167718211215169635@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Stefan,

> If possible, could you provide an acpidump of this system, so I can compare
> against what I have?

sure, see [1]

Antheas

[1] https://github.com/hhd-dev/hwinfo/blob/5bb16fa59f533e036e430016f2c85facd0325f5a/devices/Asus%20Z13%202025/decoded/dsdt.dsl

