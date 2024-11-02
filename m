Return-Path: <linux-kernel+bounces-393574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05339BA288
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9630C283192
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE7B1ABEC5;
	Sat,  2 Nov 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="IFK0A0M8"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16E14D718;
	Sat,  2 Nov 2024 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730582598; cv=none; b=D0PpZhhMUiYjQ22OkV1FZHCsZc+oPMN7O9UGfPQVufMYIjnQB/W6P2J+sRvIDfDgN7T5E0UPzfcC6Sbjre86MDq9+7SBpCJd5rw3C7+mLjjxaFI+II4HyxtOrLDFoYldkrS72wZz02u27IoUG+CI9CVJ+bYh6rijNHMbrka6yQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730582598; c=relaxed/simple;
	bh=lUBRlvZtflMuXODUVE4C23FpmQTp14LkJVoNNlP2kEs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o20Bsrmj1z5fcQ/KIkeQwVQjzbmzgfetuzcBajndqw+zg8AG0HcEeyfxB+N6b8oaqNAAyp5LedkLT93OBsBRe2Pv06n5h7eJ53OyVXj6Jdc5V2hUtTsOYQEsytzyoh5TLJqcOGd7ee1i+MVJyM7Mqe8X8EHP5BAG4DWJKli5w8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=IFK0A0M8; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730582588;
	bh=lUBRlvZtflMuXODUVE4C23FpmQTp14LkJVoNNlP2kEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFK0A0M8uMH8FIsQ7JHYXZMporgKO9E2ULkzM5d1HxOtzs/FyfYe2e9Gk8kKAXLvQ
	 v8MXYw9QvKecZbRnnL6BdpOurT2JMmzI8DLXKszz+aXDHvQLPFKLx6cvZwI43cdIn1
	 1gLrLe7t4WzlU1zvrSZjtIRAh20gbGiTBwTZ5r6V7PgQSagB2N1fqEmMkXezkyvxmD
	 rs7PbTSku4KIxw+8Ml2lxdkErmDLYLXU3qVuIxNZQgBLiWfVL8QYcGTjXwd9TouEu4
	 iI+ycEjpUPqnENhtiyvcFXI4SS7iH8jDF3gOV2Vo5YO+N39789ME28z++l3Q3COZLu
	 ggZ8BycJUBnVQ==
X-Virus-Scanned: by epochal.quest
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 02 Nov 2024 18:23:05 -0300
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: wens@csie.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Maxime Ripard <mripard@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul
 <vkoul@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>, Parthiban
 <parthiban@linumiz.com>, Andre Przywara <andre.przywara@arm.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] arm64: dts: allwinner: a100: perf1: Add eMMC and
 MMC node
In-Reply-To: <CAGb2v66TAttAezXE7TnT5N6XFW2482ipuqkcpwjeDud6v=xD3w@mail.gmail.com>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
 <20241031070232.1793078-11-masterr3c0rd@epochal.quest>
 <CAGb2v66TAttAezXE7TnT5N6XFW2482ipuqkcpwjeDud6v=xD3w@mail.gmail.com>
Message-ID: <36415ea50a5aa6cec8c5fb281af73f50@epochal.quest>
X-Sender: masterr3c0rd@epochal.quest
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/11/02 8:48 am, Chen-Yu Tsai wrote:
> On Thu, Oct 31, 2024 at 3:03 PM Cody Eksal <masterr3c0rd@epochal.quest> wrote:
>>
>> From: Yangtao Li <frank@allwinnertech.com>
>>
>> A100 perf1 hava MicroSD slot and on-board eMMC module, add support for them.
>>
>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> 
> So I skipped this one since Andre had some questions about the previous
> mmc clock patch. And I believe this one won't work without it?
eMMC (mmc2) works fine after more testing, even without the clock
reparenting patch (in fact, it appears to work more consistently), but
mmc0 and mmc1 require more testing and debugging. I'll deal with
the remaining MMC issues in a future patch.

- Cody

> ChenYu
> 
>> ---
>>  .../allwinner/sun50i-a100-allwinner-perf1.dts    | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)

