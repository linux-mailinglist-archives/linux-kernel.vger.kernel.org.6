Return-Path: <linux-kernel+bounces-192315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1108D1B71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C3A1C21A98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE116D9D1;
	Tue, 28 May 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XAdJd7vj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EhutbxSO"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA47C502B9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899934; cv=none; b=aI2F01aJjFrvCnfCiGtpuHIpIKzhQxDagpAoc2ZHhOjgzHPV+wRH6/+51R2SsWc/+Kjt7cijHKZaHIi6Z74X7z2nC5qUJPBg9jUM178BIRldYkEFcLK4/zGnKmNWDVZA/RQAFOCuKK9t9LKGRZBgPPiDZPh0F1o071IBVOHVRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899934; c=relaxed/simple;
	bh=dZXLjy8YgB1ZnNuK0/l9LMejKe3f6bEG1QoK9hx4eEU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=V5xtwVIEUiAOsM91sCo1Vt9Ta0640o2f1EDmmXCnhUpMqRaBJwE9hYIIsRZghIjMzzfycROI6WkMTz/tAfT1PbLSXyTAIt0shgCpSmZ1U/qQLDprv1kEWa9ePCRWZfHywUv8Y4XsASLeCximq7aujICXRyspYwKmqMq8RvgzRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XAdJd7vj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EhutbxSO; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8A1261800186;
	Tue, 28 May 2024 08:38:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 28 May 2024 08:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716899931; x=1716986331; bh=n14BlgCwO/
	WHEr03j0wHCbykXhEI5vzMH7WTcucsq9I=; b=XAdJd7vjsSJLycXtD0gc3k/1Ar
	3HHQa80OHdyk4Ft0d/I3GvVxSgcKZ8uZvB3Zm1kREuc6KXdUvTB0inHsDGl+Mq92
	fekE+KTM5Pc2EUfnxd+jSzn+nk9CpYuKY4vqW/FlMH9aI8W3OvsubVBDhDKJpTkK
	Q16WbD5JZ01fa6luVDd/j7TEaeDyyMqtRwDxS5DFlcfvJcKB0JbyeWiV9ekNOLQP
	rgh7q3jlPgHAIP2PdEFICQBziyLenST5sGS7pqUqxyVhrvtV3loYpIFA5ms5d0U0
	BDWETZqNIM018cVGvhs13hwoLabnk2DnIC7zsijiI6rZdLI68Ikb4QmYJX9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716899931; x=1716986331; bh=n14BlgCwO/WHEr03j0wHCbykXhEI
	5vzMH7WTcucsq9I=; b=EhutbxSOpqlXxba0MLpUC+IriAhLgutepvjA3vwnvJnw
	doiEUQg6y7SHiNZdN+VZSpm7lZG8wRs0h3mKHTKK7hULTLbmtUsjeXe8gfcwtBCr
	RPR6plWygh9JRExU4h7189UQPc6naFppM63oXSpIUoow0ePK0QpX6dnCECzjA175
	j/qUCZU9AdvA3yApIxBcaeqJtYnh/vUyeotO2GnWfipMpk/UucAVfCvRBPJNnstM
	WN2j2eD2N7dLuKWlD3UYgIQwQW34wgn7eo7e5DdKsa3I8hBGOS835dqPYlBhfc7D
	QGIuj4kjSksDgNDB6k5GvyT+pcAudywvIHj04gGj5Q==
X-ME-Sender: <xms:WtBVZqeQqeyYbVSWtq17NxeF9UHyJ8oN4jkj4QjrHyI2dnSlzOsrNg>
    <xme:WtBVZkO9EpA7OEBgc3j8pxxl3HeLNzv9C_efLDdS8YIsPVfuuyP6tRo1LzZDd-BPX
    47R7B4BqwVjcaHu1Ng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WtBVZrgfKbmFa6vVeFLCj_7KeHGdSviicWJbu3MxinZ2j8j7VuILoA>
    <xmx:WtBVZn89hduQw9PRUP-i-rK3RYPdbiHnykgmj5NH752HFLoOoonL7Q>
    <xmx:WtBVZmsNUzzuXaUEhQre_Fly-dMjkGmVkFVlTrFARA9skALZMsZSIA>
    <xmx:WtBVZuF09fZb1Jy5DUYaCWsWnMzpEQWzMcG5-X8s4gyqoQMoJq3gGw>
    <xmx:W9BVZoVm13sVDpxtvz_tjQJQpYRh6vCU0NgiGsLmk-gtHSd9gXZKPsu0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 62E0DB6008F; Tue, 28 May 2024 08:38:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7391d6a4-0c0b-456f-a2ca-cf3dafa67c5a@app.fastmail.com>
In-Reply-To: <70125571-5add-47d2-b127-c57e67c59df9@sirena.org.uk>
References: <20240528121222.3675312-1-arnd@kernel.org>
 <70125571-5add-47d2-b127-c57e67c59df9@sirena.org.uk>
Date: Tue, 28 May 2024 14:38:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mark Brown" <broonie@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Liam Girdwood" <lgirdwood@gmail.com>, "Alina Yu" <alina_yu@richtek.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rtq2208: remove unused rtq2208_regulator_ldo_ops
Content-Type: text/plain

On Tue, May 28, 2024, at 14:25, Mark Brown wrote:
> On Tue, May 28, 2024 at 02:12:13PM +0200, Arnd Bergmann wrote:
>
>> I did not analyze the change to see if this is the only required change
>> or if there should still have been a reference instead. Please review
>> and confirm, or provide a different fix.
>
> Fairly sure there should be a reference in _init_regulator_desc().

This is how 38bcec0e7cbb ("regulator: rtq2208: Fix
LDO discharge register and add vsel setting")] changed
the lines:

@@ -427,14 +448,11 @@ static void rtq2208_init_regulator_desc(struct rtq2208_regulator_desc *rdesc, in
                rdesc->suspend_mode_mask = RTQ2208_BUCK_STRMODE_MASK;
        } else {
                /* init ldo desc */
-               desc->enable_reg = curr_info->base;
-               desc->ops = &rtq2208_regulator_ldo_ops;
-               desc->n_voltages = 1;
-               desc->active_discharge_reg = LDO_RG_SHIFT(curr_info->base, 2);
-
-               rtq2208_ldo_match[*ldo_idx].name = desc->name;
-               rtq2208_ldo_match[*ldo_idx].driver_data = rdesc;
-               rtq2208_ldo_match[(*ldo_idx)++].desc = desc;
+               desc->active_discharge_reg = RTQ2208_REG_LDO_DVS_CTRL;
+               desc->active_discharge_on = curr_info->dis_on;
+               desc->active_discharge_mask = curr_info->dis_mask;
+               desc->vsel_reg = RTQ2208_REG_LDO_DVS_CTRL;
+               desc->vsel_mask = curr_info->vsel_mask;
 
                rdesc->suspend_config_reg = curr_info->base;
                rdesc->suspend_enable_mask = RTQ2208_LDO_EN_STR_MASK;

If the desc->ops was removed by accident, it seems
likely that desc->n_voltages also needs to be reverted.

     Arnd

