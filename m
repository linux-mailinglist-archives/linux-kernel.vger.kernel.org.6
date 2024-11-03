Return-Path: <linux-kernel+bounces-393648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625BC9BA39F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 03:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FDB1F21940
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA870814;
	Sun,  3 Nov 2024 02:55:14 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313070804;
	Sun,  3 Nov 2024 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730602514; cv=none; b=q2Bbb7YoPInCiq5n/I5+oxav0C6nJjLIoxu1lC1dfY2Prp0teMhM457GanAgqOrYW8tSUR36a0S92pvZMOAHYoYrGBmMivJDTRBK43nxigC9QIWz6Z+jTDhuq0N6xPHyaXuj0B1bczcPAliA3xibq6UKz5/T57xruJ1oXj1jnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730602514; c=relaxed/simple;
	bh=Ts5mJgx2UPMaUYQQ1cD8EkIgBpOKjbKDuYhTB6/VNzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQDDdmgu8p8E7tsA5nDV+GMKHpxghve2bRP1KiYY7TJnYVY4DL/UWCW7XNAOdZIgn3R9UH8ZZmBSCUOGT+azb3TYOA0lg9TuUL1RSYLJdTBjfH0IuzFsBVHZNx6XChFYUroIs7F38A0yEMsZ5S/i/FOcg3LymXoK46V09sxDv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb584a8f81so28410971fa.3;
        Sat, 02 Nov 2024 19:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730602509; x=1731207309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ts5mJgx2UPMaUYQQ1cD8EkIgBpOKjbKDuYhTB6/VNzM=;
        b=XxE3LxK7/OWxgAIUPGqy5o9sZh2DH0kHiwJAlkFIxVENu+nu+FoGmMeQi16i9o9hTY
         EJjxlSiIZ0fiVwX5IV2X81xZpGeTLD+8EH8YpeRxhz1Ud4tSXHIsXgDHUfwPvzZxWWi4
         ++uYttInBbWt7px6LKY/jem7fnMdVN0Ow975Ja/443Zi4bmWV/ADeksiPq6oe2OgPPf6
         DBroHfFiLrmpmjnukf/XTWRSS2CWBE3sRNJq4mD5ElcJC9DXSAvC6UhYE9HcPgVEvu7G
         t4Cm+fdD2J/GqtX2Zez9MjLlqIoVAN6nzNIAsNGpg9x+H3aogWxnU5P+ZVAoTlecp6IF
         f6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJzENOhoWWuaxEZVfPnnEIqKbzurn0FAgUDQcFDf1tB1Jo9NNQaKEgh4m5l/s/DeWR3NEW19qSm3MoqVwg@vger.kernel.org, AJvYcCXFmQwcWkUkXIKDHyJXas6sp4aW3fAkMdvlcAsqjYjxaQbqYlII5A6dxn1uhyW9gFCBc+bEB2MU1Yeg@vger.kernel.org
X-Gm-Message-State: AOJu0YzNO0ruZZbiw73oFXC+5BQbGZ2MORPFsfMisPzZVweyDYuYO+Q7
	r99zUcI7k682f2nHg3RJ17QIquqBjpPBo7C3AY2W7LotZYDOqhicadMf8xlG4cM=
X-Google-Smtp-Source: AGHT+IHH+efbbHaSXvYUhzblOr5mC/yDgOpYXBh0LcfFGIQs23YtRP6bl5ooqPI9Ab14/4Ex8LPzLw==
X-Received: by 2002:a2e:be84:0:b0:2fb:4f2e:5be7 with SMTP id 38308e7fff4ca-2fcbdfe4a77mr138953671fa.24.1730602508779;
        Sat, 02 Nov 2024 19:55:08 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8a686bsm11411011fa.80.2024.11.02.19.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 19:55:07 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so28629271fa.0;
        Sat, 02 Nov 2024 19:55:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU03FMtgvOoi4uj32ckmPRqeEmJKrssrio/NYMz4UZKxw8FJXT+SvDe0peaDZvtMqQ78s3pXMZZ0Z0d@vger.kernel.org, AJvYcCUSnLuimW8U2wrDX1MgL7SEebtn+NVtASUQ2+nUxrTO3LJWLeXmuYyGiBARmQ0nA3zYWxDusD9HD3hry/aN@vger.kernel.org
X-Received: by 2002:a05:651c:1507:b0:2fb:5e64:327e with SMTP id
 38308e7fff4ca-2fcbe079c43mr115559201fa.33.1730602507670; Sat, 02 Nov 2024
 19:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-11-masterr3c0rd@epochal.quest> <CAGb2v66TAttAezXE7TnT5N6XFW2482ipuqkcpwjeDud6v=xD3w@mail.gmail.com>
 <36415ea50a5aa6cec8c5fb281af73f50@epochal.quest>
In-Reply-To: <36415ea50a5aa6cec8c5fb281af73f50@epochal.quest>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 3 Nov 2024 10:54:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v67RHjq=5DMiP8YtvOww5B8qJxCqF9ofGTXPUkmP-5herA@mail.gmail.com>
Message-ID: <CAGb2v67RHjq=5DMiP8YtvOww5B8qJxCqF9ofGTXPUkmP-5herA@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] arm64: dts: allwinner: a100: perf1: Add eMMC and
 MMC node
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Yangtao Li <tiny.windzz@gmail.com>, Parthiban <parthiban@linumiz.com>, 
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 5:23=E2=80=AFAM Cody Eksal <masterr3c0rd@epochal.que=
st> wrote:
>
> On 2024/11/02 8:48 am, Chen-Yu Tsai wrote:
> > On Thu, Oct 31, 2024 at 3:03=E2=80=AFPM Cody Eksal <masterr3c0rd@epocha=
l.quest> wrote:
> >>
> >> From: Yangtao Li <frank@allwinnertech.com>
> >>
> >> A100 perf1 hava MicroSD slot and on-board eMMC module, add support for=
 them.
> >>
> >> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> >> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> >
> > So I skipped this one since Andre had some questions about the previous
> > mmc clock patch. And I believe this one won't work without it?
> eMMC (mmc2) works fine after more testing, even without the clock
> reparenting patch (in fact, it appears to work more consistently), but
> mmc0 and mmc1 require more testing and debugging. I'll deal with
> the remaining MMC issues in a future patch.

I think it would be better if only the eMMC was enabled. Enabling something
that is almost guaranteed to cause data corruption isn't going to be fun
for users.

ChenYu

