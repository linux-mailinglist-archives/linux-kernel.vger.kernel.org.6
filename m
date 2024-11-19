Return-Path: <linux-kernel+bounces-414207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA29D24B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2098B24B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5EF1C3F0E;
	Tue, 19 Nov 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ob7uqVwp"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE41C242C;
	Tue, 19 Nov 2024 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015343; cv=none; b=ApRlhupiy8Iex+JjYZucAss5tmn2lb5JuGaOSVQXDrlzhyuVAwZRP1mZDJA/Vrrfo3noxJG8Tz7ZamubqVZxQ5rYIgj/ETgPtjoUW7HoM+7bcWuxfN4NBf7SW5YzTHeFiRH1FMSXEgCwWZRm1IGNkcrjBl0hvtETMwVVKOYxfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015343; c=relaxed/simple;
	bh=xwiBdxZwubWz7bqqNS+a9hP63RXvgwe+4qMxsd4awho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZS+AXQVIOlja6w0ZDkydbW5DVo8GfXRTILhf08dztYEB4G6XvOEsh51WDDQzTZai5mFA66hPmoRwDGm/vLIQM5i+iFhmZ83zvO5ejgizrrZtSg8QvDLR9EGMe7BbMnvVz9FJn8yC6Nnf40+Lfcqu6a/B0E3nqoyC4q2Ty6ho6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ob7uqVwp; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 9F36C1FCB5;
	Tue, 19 Nov 2024 12:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1732015330;
	bh=mvNs9jTFC+vvsWUY8Alhqtf1e8UARS1YpFbeMu7TsYc=; h=From:To:Subject;
	b=ob7uqVwpl3w5QJgm2XonVBAtDi8g/P7wzlNRRlWJe8OQ8+X6mHMaq7p/C66JfdhAa
	 oXkD76CvIqGPdLHHhQ2FTzZRTntGF8iojjTcD56jMl7MgkSTN5FtBwOId1dNQl/I/x
	 Du8Ap2xftzojyF5N22CeDJRycbdWd/pqyJuGUZgMk/2lRCBkr7bPF5pHHzYSTuD1XX
	 7uIlg0rJPJQSLHZcRux9IbbQnkARE/87HTtNmECe7Eljq+Ctb0t4f+R2wVFvL+YhCI
	 X0DYb7ajtYeIw3TFa4UHJ76fXt/QAiuuvxRmRu+sgkTROyvjsMznSywwRonOVXe+vg
	 7MdqR+3Mcon6Q==
Date: Tue, 19 Nov 2024 12:22:01 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	Adam Ford <aford173@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>, ulf.hansson@linaro.org
Subject: Re: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on
 v6.12
Message-ID: <20241119112201.GA17768@francesco-nb>
References: <20241007132555.GA53279@francesco-nb>
 <20241112075958.GA8092@francesco-nb>
 <20241112092054.GA18139@francesco-nb>
 <CAA+D8AO3a5WsZ4=V-9CDifDZYjJjwQmQQDDQM7ZKgZ6_-CNDPA@mail.gmail.com>
 <Zzde9xS0zGJhcoUb@gaggiata.pivistrello.it>
 <CAA+D8AMx14hp51aH7Y=Sgu+X+_KxQ8zdJdrQHFY84nKtQsKKrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AMx14hp51aH7Y=Sgu+X+_KxQ8zdJdrQHFY84nKtQsKKrw@mail.gmail.com>

Hello Shengjiu,

On Tue, Nov 19, 2024 at 05:35:36PM +0800, Shengjiu Wang wrote:
> On Fri, Nov 15, 2024 at 10:47 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > On Fri, Nov 15, 2024 at 11:13:58AM +0800, Shengjiu Wang wrote:
> > > On Tue, Nov 12, 2024 at 5:20 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> > > >
> > > > On Tue, Nov 12, 2024 at 08:59:58AM +0100, Francesco Dolcini wrote:
> > > > > On Mon, Oct 07, 2024 at 03:25:55PM +0200, Francesco Dolcini wrote:
> > > > > > it seems that an old regression is back on v6.12, reproduced on -rc2
> > > > > > (not sure about rc1).
> > > > > >
> > > > > > The original report is from https://lore.kernel.org/all/20240424164725.GA18760@francesco-nb/
> > > > > > and it was fixed with https://lore.kernel.org/all/1715396125-3724-1-git-send-email-shengjiu.wang@nxp.com/.
> > > > > >
> > > > > > Is it now back?
> > > > >
> > > > > I was able to reproduce this issue once more, this time with 6.11.7.
> > > > > As I wrote in another email the issue is not systematic as it used to
> > > > > be.
> > > > >
> > > > > Any idea?
> > > >
> > > > Frank, Shengjiu, could it be that the udelay(5) in imx_pgc_power_up() is
> > > > too short and therefore we have such non-systematic failures?
> > > >
> > >
> > > Francesco,  it seems hard to reproduce it on my i.MX8MP-EVK board.
> > >
> > > If it is easy to reproduce on your side, you can try to enlarge the delay
> > > time to see if there is any improvement.
> >
> > It's hard also for me to reproduce, we just have a relatively extensive
> > test farm and 2 times it happened while doing unrelated tests. I was hoping we
> > could have some idea on what's going on, I'll see if I can put together some
> > kind of stress test, being able to reproduce it more systematically would
> > certainly help.
> >
> 
> With my test,  the issue reproduced with delay 5us/6us. but hard reproduced
> with 7us.
> I think we may need to use a delay of 10us for safety.

Great that you were able to narrow this down and confirm the issue.
I wonder if you would have any information on what is the actual delay
that the HW would need, instead of guessing numbers. If not, well, let's
go with 15usec, or 10usec, your call in the end.

Will you send a patch?

Francesco


