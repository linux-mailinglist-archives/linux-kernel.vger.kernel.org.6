Return-Path: <linux-kernel+bounces-180191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A055E8C6B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FA28311B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20038DE9;
	Wed, 15 May 2024 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="g8RggYc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEJmMGqI"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4136AF2;
	Wed, 15 May 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792829; cv=none; b=pEwVuBFtZdoW6jJ7fluocvqc4tPxK/d6RI7k9+iGM2Qu/rrUhIQKejrti18W5GZhksiBnvVv3oyXbVJyzCx9gr2ZsQKArPXNhyEeUHmOlE8qyMGUCHG0zbLpf2Gh75F/+dpxOkI1ywhLsDblUB169RlT1qgCMavj+bOLzMz8EFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792829; c=relaxed/simple;
	bh=qrQZyAZgVUPNCUW1pRjCklM+vCSso8Xl/qKciw6A6yI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ypq+sZcK6XX0zGTCS83WQddEd+bQLOPxBAutFjXzyj9F62ZbcLWkau1OH5hpNOeuEkYSVme6AAdEQjwxEBGxFqDl7PU2w6Tq0DS5bNr80LEtnc97rSc7PAaA/8asQT/Ut8giHLOY/hf/GaIfoe8SRetc9WKYYPUhlbDZegTy5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=g8RggYc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEJmMGqI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D24D0114009B;
	Wed, 15 May 2024 13:07:05 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Wed, 15 May 2024 13:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715792825; x=1715879225; bh=HKJnf18XpQ
	XKeOps2EokRjX0aTuUxsmfspin9xKrYJ4=; b=g8RggYc683ErxmYGBSnT+1TSbg
	62L7reQ6vrBgaG3zc7XQ8TSmSVpE26e9xtnEplG7mbpv72DU+Z5pBT1Zk5FnZdwJ
	kXaRUhMlmWWPVMabMLbzQTgFT0a4BpPhSXgkFXaChEKsoZDNsRK++Zn0c+zUFLDB
	uXXP1HNmoE52Qsyzl/bHORFzpJKltXCmSM3iHRyoH3jJSH0wBhT/u8azMuyHconl
	dDxNAM76HRir08I68Czux94bkzVD33Iry14JR83f9wEfJZVxEC1OSFdEGAt0e1yV
	39DYBACQ6cfA+Gi//yetv+KbfZCp57OV4AGB9pXNt2zr/YxZktffbyY5MTQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715792825; x=1715879225; bh=HKJnf18XpQXKeOps2EokRjX0aTuU
	xsmfspin9xKrYJ4=; b=gEJmMGqIzymlt1Mqii6T1fe4NHLrxfF14/db6NYPFALb
	5gyvxwtFeQkRME7FUhwIvJhQNOWcpkRc/Kj4SUU7+oUQFHBHL4SXkPPYAy+KTN6W
	Z3QdO1TcgjioR4Dj8Zigfe+w59MIFW9iyt7e6rxy0z+J2yMUenfgonbHLvKiwYS1
	MQyAKVjAaGCjMIKDEgLb9XBkY0zbmOfFqSa54bW3p0OJUGPJlcLNRXWsRw+DlFjx
	FOg1lqBAvWTCL0TNIkjZbAUEnnsPL70tceeU0CYzniUvzEq7x1rCvjiYQuPBwKId
	zwA9DwVacsRDRcaDAD6VRoBxiyiifBG0Fv1qpVbUIQ==
X-ME-Sender: <xms:uOtEZsP6IrdcEd_QZB2V7Nmx0WGkbCPHQUC8BoDWOPXLPlqwD_x7SA>
    <xme:uOtEZi8T6vTT4Z1JAAUuNGzxHK2U9rCJJwH0vI0_F2ZdbsjbXvtkeRExK8RJu6tUn
    gucXa4xzUjaRBbfl0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfn
    hihnughonhcuufgrnhgthhgvfdcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqne
    cuggftrfgrthhtvghrnhepfeekieeggedvuedtjeelffetgeelgeeludffjefhkedvudeh
    gefffeehtefftdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:uOtEZjS9mv1AbjhKoDIacsZrxYfa5Csl1BpPXbSiU51uS7K1IaRU1g>
    <xmx:uOtEZkuzssn7KkGMrON6YTv1IUp9rpE9vvv14PtvKEeA_xyHyszrJg>
    <xmx:uOtEZkd9k_2i_zXvnru75XFSWAr2mCgypnuWGSmeYYTBre0gYdE_oA>
    <xmx:uOtEZo29tArsmLFZq5M_f3sFmJmFCI1LKId6aksU6xpcMz6vQV0PVA>
    <xmx:uetEZo9tbCjTiqnkqQYPQDaid74lluakjbi_UnFrNC34jgj9dc3aEGVq>
Feedback-ID: i1719461a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1D106C60097; Wed, 15 May 2024 13:07:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2419538f-199c-4404-9af4-e17259e09cf4@app.fastmail.com>
In-Reply-To: <c927c490-bc22-45d9-87e4-4156746547f9@gmx.de>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240511023726.7408-4-lsanche@lyndeno.ca>
 <c927c490-bc22-45d9-87e4-4156746547f9@gmx.de>
Date: Wed, 15 May 2024 11:06:43 -0600
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
To: "Armin Wolf" <W_Armin@gmx.de>
Cc: "Mario Limonciello" <mario.limonciello@amd.com>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 srinivas.pandruvada@linux.intel.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "kernel test robot" <lkp@intel.com>, "Hans de Goede" <hdegoede@redhat.com>,
 "Yijun Shen" <Yijun.Shen@dell.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Vegard Nossum" <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v6 2/2] platform/x86: dell-laptop: Implement platform_profile
Content-Type: text/plain



On Sun, May 12, 2024, at 12:05 PM, Armin Wolf wrote:
> Am 11.05.24 um 04:36 schrieb Lyndon Sanche:
>

>> +static int thermal_init(void)
>> +{
>> +	int ret;
>> +	int supported_modes;
>> +
>> +	/* If thermal commands not supported, exit without error */
>> +	if (!dell_laptop_check_supported_cmds(CLASS_INFO))
>> +		return 0;
>> +
>> +	/* If thermal modes not supported, exit without error */
>> +	ret = thermal_get_supported_modes(&supported_modes);
>> +	if (ret < 0)
>> +		return ret;
>
> Hi,
>
> the function dell_smbios_error() says that when a specific functionality is
> not supported, -ENXIO is returned.
>
> Please treat this as "no thermal modes supported", since checking if CLASS_INFO
> is supported is not enough (CLASS_INFO is also used by other functionality like
> rfkill, so machines might support CLASS_INFO but not USTT).
>
> Thanks,
> Armin Wolf
>

Armin:

Thank you for this. I will include this in the next revision.

Thanks,

Lyndon

