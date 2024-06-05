Return-Path: <linux-kernel+bounces-202959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C323C8FD39D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D86B287FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BEE18FC87;
	Wed,  5 Jun 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="yNnDzR1g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ft8oOzDh"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7B3BBD7;
	Wed,  5 Jun 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607366; cv=none; b=fitfpzvzehMxqFw1J2eB+RrbzcLHp42X5qY2ZdMCjHUnUeW2FvieP9PoxzeBIetwbahVtGyzBB13ouIK/rdtsgXquBywbULctYHynuQ0A+/PwiZzNUKytzOLZInxHDiXFchQgZpOuFSzLKP2SFKQob1rX86R/DsoUyvoNAMIx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607366; c=relaxed/simple;
	bh=F7Eh5kg8b6tfkcpTjbETzCmLSlgUgrmBSekOVyhs6+4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZAvIhqhnMt6YaSHysPJvMWuUKzsg+zbj4HCcDW/GsfSRqeiriIoLZg99D8nO9P7u59D3pg4pGPywY4BT5KqcF45ii4qzkLih9sbHAa06uf56HAWJ0Pz80XEU4m5GvhvuThx/qhGzCvBvms9gslOQixoYVchb9np7taUin71o++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=yNnDzR1g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ft8oOzDh; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id D5E361C00133;
	Wed,  5 Jun 2024 13:09:22 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Wed, 05 Jun 2024 13:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1717607362; x=1717693762; bh=ZHXgv05Ed0
	PNjKxsr4XqCWtGawsCHif6ccMqAyWwMRI=; b=yNnDzR1gQvhsPIbQw+80gvRg2C
	4JbdDp12xAj7J9fYlGVpC/jJu0ibS85YpUttxqanIHl4lWWWSGMaIQcC5uEPsVDn
	qSGj0S3+yfZh09HH8XfC3wvk1e+I/8IbBybpdVqWjJ9Pw/vC2mpBzSR904v3X8n4
	E1eqKbZh7hBru1Wqf4PUZ1q68B6GOTxAWrRYPxDDvxGSe1Zpp5GsnCXCw9P/A4Es
	LN93suNkj7VRuPNOPtQk+J2RcjlldWuNaQP4PKDZb0KAYWx4WkBYcsnjSFSYBSjn
	POQs5CE+T0GkTFcfFWJJCxqSkagBARKP8wOneqASiSNtws+Tk5DA/i5sk+3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717607362; x=1717693762; bh=ZHXgv05Ed0PNjKxsr4XqCWtGawsC
	Hif6ccMqAyWwMRI=; b=ft8oOzDhh5a1Ns1kkZD1ugH+T5UN4KXwxe3orwtLIDMf
	ye7VyVTs4ipt/XCVdro5BCFfsAASMfUqX2mS6ygtje2nM9QU+nIkZrxtFCr4c5yK
	MQ3rgfDwKh/XhprC1Uw9IPtk88tZjn9jwLsYY11qsCM8bVGurlbljDAeUTAklou3
	2J1EPDLPzMFjzf11uCfv3gVtrrxj0s1q1pPf0CHkvWgzwoLOzg1p0nu9Yjc5B6zk
	fi7hIakBhYwF+Mgw/hHL/j+QEDN9V7vieHLmBBHGDumEnKTHOo5fakPQR0tj7RJC
	69Qz7YhzTMbjB0G2WcLHtQx/eEBR3TCuQO6Xdr3WDA==
X-ME-Sender: <xms:wptgZpS4NhllHqMyFQkIWpyk2Hu5IBm0f4Me9RrAYAI7_PmJACqfQQ>
    <xme:wptgZiyrh64mJqnKmyAPWgSGZrcPsc4pFTjryV4gSnll3pAXS9xN29eAYnw6oqRHH
    Vl3iWnd41xLNVtr0hE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeliedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfo
    rghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsg
    gsrdgtrgeqnecuggftrfgrthhtvghrnhepieeufeejieevteduvdekteefledtveffvedu
    hefffeejudefvdeijeegudegkefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgt
    rg
X-ME-Proxy: <xmx:wptgZu3BfR8455hJIcEgAe7dn-TNFhf6gA80i_ZvBkqXoqmiIhaTkA>
    <xmx:wptgZhDsJfaudmgGb2rc_gFL33Gn5gbo_qhhIKTMMs-oVvx8CSNdbw>
    <xmx:wptgZiinP5t9LfBrXb3Ebeqcc3q8LpPTQQDj2eKSQKmGS995Qmftcw>
    <xmx:wptgZlq4DpTt_tuBckOjyCbuZelUXTOU12R-KgFBk_ix31-4Y1OQLg>
    <xmx:wptgZkagJgrgVWR8Hp5UVHjYLl5G6-zGtL01FoI2p7BQqJrpL4WCiklx>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1A572C60097; Wed,  5 Jun 2024 13:09:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a517bb13-9772-49f9-b75c-8fa4d98b2ae9@app.fastmail.com>
In-Reply-To: 
 <2midmmssv2i3plvtc2hajar6alfvggpnbvgpmldspelxsnjvcl@qiblhwat6n3p>
References: <mpearson-lenovo@squebb.ca>
 <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
 <2midmmssv2i3plvtc2hajar6alfvggpnbvgpmldspelxsnjvcl@qiblhwat6n3p>
Date: Wed, 05 Jun 2024 13:09:01 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Greg KH" <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Diogo Ivo" <diogo.ivo@siemens.com>
Subject: Re: [PATCH] usb: typec: ucsi: treat get_pdos not supported condition as info
 instead of error
Content-Type: text/plain

Thanks Dmitry (& Diogo from the other thread)

On Tue, Jun 4, 2024, at 7:45 PM, Dmitry Baryshkov wrote:
> On Tue, Jun 04, 2024 at 03:40:44PM -0400, Mark Pearson wrote:
>> On systems where the UCSI PDOs are not supported, the UCSI driver is
>> giving an error message. This can cause users to believe there is a HW
>> issue with their system when in fact it is working as designed.
>> 
>> Downgrade message to dev_info for EOPNOTSUPP condition.
>> 
>> Tested on Lenovo L14 G5 AMD and confirmed with Lenovo FW team that PDOs
>> are not supported on this platform.
>> 
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
>> index cb52e7b0a2c5..090be87d5485 100644
>> --- a/drivers/usb/typec/ucsi/ucsi.c
>> +++ b/drivers/usb/typec/ucsi/ucsi.c
>> @@ -632,8 +632,12 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
>>  	command |= is_source(role) ? UCSI_GET_PDOS_SRC_PDOS : 0;
>>  	ret = ucsi_send_command(ucsi, command, pdos + offset,
>>  				num_pdos * sizeof(u32));
>> -	if (ret < 0 && ret != -ETIMEDOUT)
>> -		dev_err(ucsi->dev, "UCSI_GET_PDOS failed (%d)\n", ret);
>> +	if (ret < 0 && ret != -ETIMEDOUT) {
>> +		if (ret == -EOPNOTSUPP)
>> +			dev_info(ucsi->dev, "UCSI_GET_PDOS not supported on this hardware\n");
>
> Maybe it would be enough to guard GET_PDOS commands with the
> UCSI_CAP_PDO_DETAILS check? Is it cleared on affected platforms?
>

I checked on the system I have and the features are 0x84, so the CAP_PDO_DETAILS aren't set.
I can do a formal patch if the approach is better, I ended up doing:

@@ -645,9 +645,13 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
 static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
                         int is_partner, u32 *pdos)
 {
+       struct ucsi *ucsi = con->ucsi;
        u8 num_pdos;
        int ret;
 
+       if (!(ucsi->cap.features & UCSI_CAP_PDO_DETAILS))
+               return 0;
+
        /* UCSI max payload means only getting at most 4 PDOs at a time */
        ret = ucsi_read_pdos(con, role, is_partner, pdos, 0, UCSI_MAX_PDOS);

And this did indeed squelch the 'error' message.

Couple of notes:
 - I don't know this area very well, so don't know if there are risks of any regressions in other circumstances. I think it's pretty safe, but if any experts have an opinion that would be appreciated.
 - It means that there isn't a log message saying that PDO capabilities are not available. Are there going to be power related tooling that won't work and it would be useful to have that message available?

Thanks
Mark

