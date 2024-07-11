Return-Path: <linux-kernel+bounces-248704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D24F92E0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D526AB2220E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF014883C;
	Thu, 11 Jul 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wBTa++Mi"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82384DFF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683100; cv=none; b=kZtwoS/v24/puR9HRMylwzgfIi8VA18tFKQG3jRJe1i5vi1tgxwXQZhXkvYXchm/X2V8TUQkyDUKKTEBSoTo7h7cuVISEfDON/pd2m9fyGVKX+JK6NTT4xGV/sxNLAMMyPRqdICjKK5b4JkVhHPog3YPvVMtllYkCYhNWaPR8iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683100; c=relaxed/simple;
	bh=SDtQSFrHCO4F7Kc1Ae2d9XG29FrX3GmsyF59cErvosc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CJOvMd3ybJNsbRRE20yL0riSrOMcbqYRRWvNxo0EBiznu5Jxq7vAiypeR8qXudJ+wM34rWlZt9/QBUh82exR4MmepB5LT9WoCExinW1JFo5JStRvao1R/eQA4azCfanALYZa428YmXPBjdI3VUdd7b8iO9Xc2VDpUTY0KpC6arc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wBTa++Mi; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46B7UqjI077813;
	Thu, 11 Jul 2024 02:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720683053;
	bh=hgfOmcBPT0l7LpiWRAFVjmyHwAQI8g7arwy3bfYKk/8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wBTa++MizJGdrX51N+Z30lV7vkf+U9+LShGQ9M9f3F1/btB8aQQkqGiK5C6dT54ay
	 KTQqR16hDfDAP0X195VyfRRFC6Y0ZWzlAiTY5RbZFxKQM9fbp1EYu65Pxcgup0ErZM
	 9CJZ/JqomatLK1aX2JwOWiAk4REP+i3ge4zW/2TM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46B7UqXY074190
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jul 2024 02:30:52 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jul 2024 02:30:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jul 2024 02:30:52 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46B7Uin0016470;
	Thu, 11 Jul 2024 02:30:45 -0500
Message-ID: <3aa27f67-02d5-4bd4-b45e-9d4753a333f8@ti.com>
Date: Thu, 11 Jul 2024 13:00:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] drm/bridge: cdns-dsi: Reset the DCS write FIFO
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Dominik Haller <d.haller@phytec.de>, Sam
 Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Kieran
 Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri
	<praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar
	<devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra
	<j-luthra@ti.com>
References: <20240622110929.3115714-1-a-bhatia1@ti.com>
 <20240622110929.3115714-8-a-bhatia1@ti.com>
 <11bf22b8-4a5a-4c9b-8c78-0454165ae711@ideasonboard.com>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <11bf22b8-4a5a-4c9b-8c78-0454165ae711@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 26/06/24 16:33, Tomi Valkeinen wrote:
> On 22/06/2024 14:09, Aradhya Bhatia wrote:
>> If any normal DCS write command has already been transmitted prior to
>> transmitting any Zero-Parameter DCS command, then it is necessary to
>> clear the TX FIFO by resetting it. Otherwise, the FIFO points to another
>> location, and the DCS command transmits unnecessary data causing the
>> panel to not work[0].
>>
>> Allow the DCS Write FIFO in the cdns-dsi controller to reset as a rule,
>> before any DCS packet is transmitted to the DSI peripheral.
>>
>> [0]: Section 12.6.5.7.5.2: "Command Mode Settings" in TDA4VM Technical
>>       Reference Manual: https://www.ti.com/lit/zip/spruil1
> 
> Hmm so if I read the doc right, it says: if sending zero-parameter dcs
> command, clear the FIFO and write zero to direct_cmd_wrdat.

That's right.

> 
> Your patch seems to always clear the FIFO, not only for zero-parameter
> commands. Is that a problem (I don't think so, but...)?
> 

My patch does clear the FIFO every time.

While there is no documentation that says its harmless, I have tested
the patches with RPi Panel (which doesn't seem to have any
zero-parameter commands in the driver) - and so far it seems to have
worked fine.


> Also, is the direct_cmd_wrdat written at all when sending zero-parameter
> dcs command?
> 

At the moment, no.

Apparently there are 2 types of "Zero parameter" commands.

There is,

a) "MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM" - which has absolutely no
parameter that needs to be sent, and there is,

b) "MIPI_DSI_DCS_SHORT_WRITE" - which has a 1-byte command value that
needs to be transmitted.

(Macros referred from mipi_display.h)

In the J721E TRM[0], there is a table[1]  which classifies the
"MIPI_DSI_DCS_SHORT_WRITE" - the command with 1-byte command parameter -
as a "zero parameter" command.

For a "MIPI_DSI_DCS_SHORT_WRITE" command, we are still writing the
1-byte command data into the FIFO.

However, in the other section which talks about resetting the FIFO[2],
it is mentioned that, for "zero parameter" commands, the FIFO needs to
be reset and then 0x00 needs to be written to the FIFO.

The second step cannot be done for "MIPI_DSI_DCS_SHORT_WRITE" commands
because we want to write the 1 byte command parameter instead of 0x00
into the FIFO.

So, the only logical conclusion is that, the FIFO reset is only required
for _truly_ zero parameter commands, which is the
"MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM" command.

So, I am planning to change this patch to do 2 things, under the
condition that there are absolutely no data bytes that require
transmission.

a. Reset the FIFO.
b. Write 0x00 to the FIFO.


Regards
Aradhya

[0]: J721E TRM: https://www.ti.com/lit/zip/spruil1
[1]: Table: 12-1933: "DSI Main Settings Register Description".
[2]: Section 12.6.5.7.5.2: "Command Mode Settings"


> 
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>> b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>> index 126e4bccd868..cad0c1478ef0 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>> @@ -1018,6 +1018,9 @@ static ssize_t cdns_dsi_transfer(struct
>> mipi_dsi_host *host,
>>         cdns_dsi_init_link(dsi);
>>   +    /* Reset the DCS Write FIFO */
>> +    writel(0x00, dsi->regs + DIRECT_CMD_FIFO_RST);
>> >>       ret = mipi_dsi_create_packet(&packet, msg);
>>       if (ret)
>>           goto out;
> 
> 

