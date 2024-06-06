Return-Path: <linux-kernel+bounces-203525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EE28FDC94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F7D1C24144
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821517C68;
	Thu,  6 Jun 2024 02:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="sQDMVEOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1WSPuwL"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04D17580;
	Thu,  6 Jun 2024 02:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639995; cv=none; b=PTrDJSuvDth0GpUzRGm63m2hxxtgEkUVQEzTeLQB55lveUZFhkOwGqpSI6hoYwKwKS3Ps+Svl79hNzPhqU9dIMm8bI4gMTyPmDfMlRWdJ+HjcP55LlU5sLiZ9JuML6FxGuwM8ns8h7RzXInZ6MhT0/A0KDOlaqrbw3qvj95veNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639995; c=relaxed/simple;
	bh=yJWrJbCqPqapXYAwKXwN1zRvyQPhRPbhbiN+kmQtLK8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ofPXwGCsfgsJ8zvjR/tl8qA2joHe0ioDN/9frypzzayTT0xQjddBKS+6tHuGG2K8j+yBt29dfpoCJ0DudIdtcrNuD63EvVy5ZItObx2kkVL0LJsahTcV5vcGOPB36uLt/K0Ucj/HwDIA7hayTE/jjN0Ko4MRTXl03ctgEjK2fzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=sQDMVEOH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1WSPuwL; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 39898180015E;
	Wed,  5 Jun 2024 22:13:12 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 05 Jun 2024 22:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1717639991; x=1717726391; bh=f/U9i0grtX
	yPEh0f0xQwuZ2cYpbRTaMYvy44FQqW0H0=; b=sQDMVEOH0IXXRS9X5J8vQcyJUN
	ZxKcwS+lfJQO4froeZwXxeH/EI6EtuJS9nG4plNpKLjDb+Te2+F/a3sR9J0Mx1Zf
	IUADurirUQ8UqmTUZkXJMAxsznFuzBQKiTug5finxKfj5kUy6C6+eYdWjmyCuKFA
	WPZMK8QWNUe8y2TBNgP8yVL7r9e6qIglIrLD6uuXZbQ/P1XbpzZPxv0MyBUtOu5F
	dQ2VsCdZ6irhZhEouRE7qSq2q9z98cMlbEIYqdmm05Ss1xzGhV8YS+Untx0VsitQ
	g8xp03NJYwKBbK6sS96PjG67UwqmJ5LFjaHyK2xbD0GnJ6uXbdtFEimZJKnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717639991; x=1717726391; bh=f/U9i0grtXyPEh0f0xQwuZ2cYpbR
	TaMYvy44FQqW0H0=; b=Z1WSPuwL3pJTZzhP1DjSJXPzYZqmi1RBSF2XW/+EbNSo
	O8wbcQ4lFQxR91v5xzOKFsdNdZWXU4XwZIGNGEtn9bOftETFTIujQ4dxHsZBPt1d
	LLM/xz0YL/4NgcNSypFAUmV/MseY8RmYKk6oSpGoRtf1cRaBofDugM6f+g3vvHKQ
	FaI1QohEQuy01+uV5av40MxAovnC67LX9gBjYJoiivj/F8przYhX1PR1Lvxazr27
	VL4rZPbLCXTMIGSqQLWQ72v67fQ2SgE5gOlhRDgpqsq9ZTW5l5rSZjvnz5rjHEsO
	iPrDHC2Nn+rZWgG7M6E9f+SZPBdr+Z/eCHlJSuzf1A==
X-ME-Sender: <xms:NxthZgdYgGz97viewXpCNuC02I1k4qVS3uXSahQXlDNelnFhUR8pxw>
    <xme:NxthZiPhJQKKdX40Zsu3IlaudFAi8mlh4aoF-c_tXsULelz1QJYrj0oMTzts_zoGR
    RSDBoFwk5e-ecbGb_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:NxthZhimCtCqUFhz4KtQdiGegNxyJtrgE8jETpmhEtXrQAWKNp5SSA>
    <xmx:NxthZl-0xVjCjVqr18XbucUoy_FD7De1dTJFBkZPiWfCU8bJBT9fkA>
    <xmx:NxthZsvqElJPb7qbwX3eC5klZCgxUYlqaeW-r-vuUC9s1Gr2FWPFeg>
    <xmx:NxthZsH2Cu-QxERUDeAzuf-p3mBHutc07mq-EdyzkoaZB6mLjxz7nw>
    <xmx:NxthZmUnxNZpvZZcz0uByckcEo2EXgvULZEudtgWzI4I7bifaTsgOMIV>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 845FBC60097; Wed,  5 Jun 2024 22:13:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <69b41002-69d7-4327-a8cd-b8bdc371ad2c@app.fastmail.com>
In-Reply-To: 
 <CAA8EJppzeBPHW1GPGvVzT-YSGm4PZUQ4qgq0FCgqn1e9Vt-MXg@mail.gmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
 <2midmmssv2i3plvtc2hajar6alfvggpnbvgpmldspelxsnjvcl@qiblhwat6n3p>
 <a517bb13-9772-49f9-b75c-8fa4d98b2ae9@app.fastmail.com>
 <CAA8EJppzeBPHW1GPGvVzT-YSGm4PZUQ4qgq0FCgqn1e9Vt-MXg@mail.gmail.com>
Date: Wed, 05 Jun 2024 22:12:45 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Greg KH" <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Diogo Ivo" <diogo.ivo@siemens.com>
Subject: Re: [PATCH] usb: typec: ucsi: treat get_pdos not supported condition as info
 instead of error
Content-Type: text/plain



On Wed, Jun 5, 2024, at 7:26 PM, Dmitry Baryshkov wrote:
> On Wed, 5 Jun 2024 at 20:09, Mark Pearson <mpearson-lenovo@squebb.ca> wrote:
>>
>> Thanks Dmitry (& Diogo from the other thread)
>>
>> On Tue, Jun 4, 2024, at 7:45 PM, Dmitry Baryshkov wrote:
>> > On Tue, Jun 04, 2024 at 03:40:44PM -0400, Mark Pearson wrote:
>> >> On systems where the UCSI PDOs are not supported, the UCSI driver is
>> >> giving an error message. This can cause users to believe there is a HW
>> >> issue with their system when in fact it is working as designed.
>> >>
>> >> Downgrade message to dev_info for EOPNOTSUPP condition.
>> >>
>> >> Tested on Lenovo L14 G5 AMD and confirmed with Lenovo FW team that PDOs
>> >> are not supported on this platform.
>> >>
>> >> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> >> ---
>> >>  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++--
>> >>  1 file changed, 6 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>> >> index cb52e7b0a2c5..090be87d5485 100644
>> >> --- a/drivers/usb/typec/ucsi/ucsi.c
>> >> +++ b/drivers/usb/typec/ucsi/ucsi.c
>> >> @@ -632,8 +632,12 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
>> >>      command |= is_source(role) ? UCSI_GET_PDOS_SRC_PDOS : 0;
>> >>      ret = ucsi_send_command(ucsi, command, pdos + offset,
>> >>                              num_pdos * sizeof(u32));
>> >> -    if (ret < 0 && ret != -ETIMEDOUT)
>> >> -            dev_err(ucsi->dev, "UCSI_GET_PDOS failed (%d)\n", ret);
>> >> +    if (ret < 0 && ret != -ETIMEDOUT) {
>> >> +            if (ret == -EOPNOTSUPP)
>> >> +                    dev_info(ucsi->dev, "UCSI_GET_PDOS not supported on this hardware\n");
>> >
>> > Maybe it would be enough to guard GET_PDOS commands with the
>> > UCSI_CAP_PDO_DETAILS check? Is it cleared on affected platforms?
>> >
>>
>> I checked on the system I have and the features are 0x84, so the CAP_PDO_DETAILS aren't set.
>> I can do a formal patch if the approach is better, I ended up doing:
>>
>> @@ -645,9 +645,13 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
>>  static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
>>                          int is_partner, u32 *pdos)
>>  {
>> +       struct ucsi *ucsi = con->ucsi;
>>         u8 num_pdos;
>>         int ret;
>>
>> +       if (!(ucsi->cap.features & UCSI_CAP_PDO_DETAILS))
>> +               return 0;
>> +
>>         /* UCSI max payload means only getting at most 4 PDOs at a time */
>>         ret = ucsi_read_pdos(con, role, is_partner, pdos, 0, UCSI_MAX_PDOS);
>>
>> And this did indeed squelch the 'error' message.
>>
>> Couple of notes:
>>  - I don't know this area very well, so don't know if there are risks of any regressions in other circumstances. I think it's pretty safe, but if any experts have an opinion that would be appreciated.
>>  - It means that there isn't a log message saying that PDO capabilities are not available. Are there going to be power related tooling that won't work and it would be useful to have that message available?
>
> From my POV this patch looks good. Also if there are no PDOs, then the
> UCSI driver will register an empty usb_power_delivery object with
> neither source nor sink capabilities being present. So userspace can
> identify the case of PDOs retrieval being unsupported. If you really
> want to have a possible trace in the logs, it might be a good idea to
> add dev_dbg under this if statement.
>
Thanks Dmitry.

I don't have any concerns about not having a log message myself.
I'll wait a couple more days in case there is other feedback and, if all good, get a new patch submitted with this change instead.

Mark

