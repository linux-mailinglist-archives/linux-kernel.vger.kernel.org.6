Return-Path: <linux-kernel+bounces-254696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05715933674
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1656B1C20BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCEB10A1C;
	Wed, 17 Jul 2024 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="k/XBLT58";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXMzUvZk"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0701878
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721194822; cv=none; b=M40NCdnj8GnEshCFOx8nqb23FFAT8b3TqTN4+AvPmuucPA96lFFRagkL4jKR3ZzG7vboL39DkaMlvMBHhk/nUhT7X7CTU6+HtSHu3cPbA+W0ocjf798OZnnwqqyRheU0N/8zZqutxEflZYFHNiW8paeUcvpknV2mQOUXarGfiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721194822; c=relaxed/simple;
	bh=UZQ3LPOMW6rlopp3XIosJrKAsIlcT2VdhUlmojIV/Po=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=kePT6vyQs1v6HKOA0u1gXJcH6fHFiC32QhSB9r9pz6xDicUzUWZF8z4z4qm/MTB2W8tSPDZHfC5yiRJjl57Kcta/zA4QJxF4M4LPAexEgYDCbVwrI1nbob4BEfj2gXWJXKGlOpZs1zfp5OfQ/gwVoPtKOwsbZHm6J7r6gT+P1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=k/XBLT58; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXMzUvZk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E72E611401BF;
	Wed, 17 Jul 2024 01:40:19 -0400 (EDT)
Received: from wimap26 ([10.202.2.86])
  by compute6.internal (MEProxy); Wed, 17 Jul 2024 01:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721194819; x=1721281219; bh=dzHN4GZtuP
	JB029ydV+RBdnF9quOADzKqz+UUHymSe4=; b=k/XBLT58EQJtuIr8u3zdFTyGoA
	Nu11n/OQWiXh77y0bZsxJfd7ILufh+rLdV2McL99L9tL4ueCis71Nhb0JfYxAa0W
	rL+vCmbGD46iGFsEMeWj3qaGm8/uAYUl1AG9Ft9rWy8cu0REXx4LeTa/Ly6wvF6v
	qJpRFVnNcqWARlpY7tNDd7rEnF3PxbW9e+FP0TcvVaMtxRk8lQHfGxKELapJusz2
	IkjQyMBpvMjX5MGGXZvh6uuXabnG9uCGb3nLevWs1ghk2qrYnllCEU4KpcXQ4Vyv
	Uo/DRMkzigmyi390ZAn8xgdorXixIvWNb8OYt9fcFqo6PEaXknDrFxxzhg6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721194819; x=1721281219; bh=dzHN4GZtuPJB029ydV+RBdnF9quO
	ADzKqz+UUHymSe4=; b=uXMzUvZkgLGDyEwwZ4fTUjL+ahcBQvjQ9s1Zl6GLVbQY
	pZ07MAHICxTeEVOqDL81ABHdsQnufjxJMUFno4fMQa8ihXiilvcF8dXS6Y5jyigN
	Jze3+9XRMJAa5wlTa6IhXWqpTBq8MKZ0iwnztitP/94WAEVFYefYqJKmZETuFNsT
	695Vl5rmP1YlORO3H0ZLwjtNqJ9oCpv/cW3inXJ83pJK9blIYnLM7qkmEy+Y5vFD
	QFmSWOLAlzGuWiceGDYRpq7ObycTvHT/5PCAMgyioOAa3GsFc8laTt9oKsuHr86X
	yGyGSUXnLZDH9drsU8bNMi5oUVw8WQNruBoBxJEJtA==
X-ME-Sender: <xms:QlmXZhIls2N-ErNmpRsvFmx-2xC05gjtqx4X4OMsE-BKfX9ghJLNew>
    <xme:QlmXZtIQI3fSkDdQGWYeYPZ3U0Zd9ZOYBKUtWA_GytCDOCTwIdy-Lr0DqzyOrUNRT
    k-mW2ZywgapQjarwdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeehgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QlmXZpstA9Dm57-RNHO4E_1bT3yp5aVNl0EM2zv6E0dxuh3ef3-hYQ>
    <xmx:QlmXZiYZGyb9qsFlNnNGpSgjep-3TnE9JddBi5LXSsXBFXsTbziJ2A>
    <xmx:QlmXZoadbfEuMjERAwRCqQvUuWHs5ciaPnzNpT1Jh9P1FPb9e-5Iqw>
    <xmx:QlmXZmASoTN9wPZQy6g3mEdekBd2DSdzdTn2LeQslCekqm911neBfg>
    <xmx:Q1mXZvUZlB-HUyM5ThdVsRWJoYOoPGasmAvlsl664lWLdBXivBJyx_4L>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9A28B19C005D; Wed, 17 Jul 2024 01:40:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22bf9a24-b4db-4017-b5a9-1b03e6f20bff@app.fastmail.com>
In-Reply-To: 
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20240717045225.138799-1-vattunuru@marvell.com>
 <2024071709-nephew-scooter-5c6b@gregkh>
 <MW4PR18MB5244DBBC231E986EDBEDD5BEA6A32@MW4PR18MB5244.namprd18.prod.outlook.com>
Date: Wed, 17 Jul 2024 07:39:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>
Subject: Re: [EXTERNAL] Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation issues on
 32-bit ARM
Content-Type: text/plain

On Wed, Jul 17, 2024, at 07:35, Vamsi Krishna Attunuru wrote:

>>>  #include <uapi/misc/mrvl_cn10k_dpi.h>
>>>
>>> @@ -185,6 +188,8 @@ struct dpi_mbox_message {
>>>  	uint64_t word_h;
>>>  };
>>>
>>> +#ifdef CONFIG_64BIT
>>> +
>>>  static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64
>>> val)  {
>>>  	writeq(val, dpi->reg_base + offset); @@ -195,6 +200,40 @@ static
>>> inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
>>>  	return readq(dpi->reg_base + offset);  }
>>>
>>> +static inline void dpi_writeq(u64 val, void __iomem *addr) {
>>> +	writeq(val, addr);
>>> +}
>>> +
>>> +static inline u64 dpi_readq(const void __iomem *addr) {
>>> +	return readq(addr);
>>> +}
>>> +
>>> +#else
>>
>>Normally we do not like #ifdef in .c files, are you sure this is the correct way to
>>handle this?
>
> Ok, came across the similar usage in some other drivers and presumed 
> it's fine with small routines. I will move the #ifdef inside the 
> routines than.
>
> Thank you, Greg, for the prompt feedback.

You shouldn't need any #ifdef here, just call readq/writeq
unconditionally after including the header.

Have you been able to confirm whether the device works
correctly with the lo_hi ordering?

      Arnd

