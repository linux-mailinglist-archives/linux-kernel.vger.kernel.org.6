Return-Path: <linux-kernel+bounces-234295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494D391C4CC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88891F2460D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F341CB327;
	Fri, 28 Jun 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b="jahStvWW"
Received: from us-smtp-delivery-172.mimecast.com (us-smtp-delivery-172.mimecast.com [170.10.129.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880551C230B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595568; cv=none; b=g/vJ6e+c82nOQSXOLu2xf1ICWWHWQ6FdkRn8fzfM6DrTUHUAcwtC8ZQTnAL8/Nw5BZZ7wE7CCmBa0smtuNZsFEToEORiJwT1UTfKD3zOOxhja3TXQF2vNOhVa7cJgt6JSjnp9cBNSEMUGNwcpxvRq9oCc+Qk3dHsxpx+TpCIYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595568; c=relaxed/simple;
	bh=3toKfkefklQuqnFmzsR6BLu9S7GErzc295gsRBJ/UJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PWHtoKbNTYdDqFnrA4elbAs4YNLfT4LOS6SHauWihLqRCeydW5TNhism6FEEvU57iZVF6nnmJI4Fj41fpFzXiAdwN5kvaMSxXURC5L/afk5+8OnQL/vAo7k70KkcRa5lTt2m/vW1WBYzATCkW/FMn3YTrGVJw018HryI9kWQbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com; spf=pass smtp.mailfrom=valvesoftware.com; dkim=pass (1024-bit key) header.d=valvesoftware.com header.i=@valvesoftware.com header.b=jahStvWW; arc=none smtp.client-ip=170.10.129.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=valvesoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valvesoftware.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valvesoftware.com;
	s=mc20150811; t=1719595565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XKtCW3Er86rGfQYrPBdk0AkxyGBnrD1aUtOlms/i3Os=;
	b=jahStvWWA5kMAAAK54JxjrAxQFgDxb9hSGsYG/GdCRE70S5ErWiURlP7qzVPXNAuZxYRxS
	tp6Lxi2uAs5RnJBy7Wxha6M7PtTDbm8ySYfU0itXQyE9olh+fsFwFrZl8rhXOH+MeMQW27
	zPoOMr8njLXPla+4QW+yOirWeTydFcc=
Received: from smtp-01-blv1.valvesoftware.com
 (smtp-01-blv1.valvesoftware.com [208.64.203.181]) by relay.mimecast.com
 with ESMTP with STARTTLS (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384)
 id us-mta-509-H9YTwKGXPeW6f0huGGxihw-1; Fri, 28 Jun 2024 13:26:04 -0400
X-MC-Unique: H9YTwKGXPeW6f0huGGxihw-1
Received: from antispam.valve.org ([172.16.1.107])
	by smtp-01-blv1.valvesoftware.com with esmtp (Exim 4.93)
	(envelope-from <johns@valvesoftware.com>)
	id 1sNFMJ-004VPr-K6
	for linux-kernel@vger.kernel.org; Fri, 28 Jun 2024 10:26:03 -0700
Received: from antispam.valve.org (127.0.0.1) id hfrp2m0171sj for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:26:03 -0700 (envelope-from <johns@valvesoftware.com>)
Received: from mail2.valvemail.org ([172.16.144.23])
	by antispam.valve.org ([172.16.1.107]) (SonicWall 10.0.15.7233)
	with ESMTP id o202406281726030074293-5; Fri, 28 Jun 2024 10:26:03 -0700
Received: from [172.16.36.27] (172.16.36.27) by mail2.valvemail.org
 (172.16.144.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 10:26:03 -0700
Message-ID: <884684ce-53b1-48db-8dcb-6b2bcd0d151d@valvesoftware.com>
Date: Fri, 28 Jun 2024 10:25:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm: panel-orientation-quirks: Add quirk for Valve
 Galileo
To: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>, Hamza Mahfooz
	<hamza.mahfooz@amd.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Mario
 Limonciello <mario.limonciello@amd.com>, Kyle Gospodnetich
	<me@kylegospodneti.ch>, Hans de Goede <hdegoede@redhat.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, Matthew
 Schwartz <mattschwartz@gwu.edu>
References: <20240627203057.127034-1-mattschwartz@gwu.edu>
 <20240627203057.127034-2-mattschwartz@gwu.edu>
 <19ca1a46-6a74-4eec-9e84-0092faaee7a1@amd.com>
 <CAD9O9Dp89CprZFMn=ysduPmUTkmJ5y6qDw18X9pLr7=ChoD0Uw@mail.gmail.com>
From: John Schoenick <johns@valvesoftware.com>
In-Reply-To: <CAD9O9Dp89CprZFMn=ysduPmUTkmJ5y6qDw18X9pLr7=ChoD0Uw@mail.gmail.com>
X-ClientProxiedBy: mail2.valvemail.org (172.16.144.23) To mail2.valvemail.org
 (172.16.144.23)
X-Mlf-DSE-Version: 6871
X-Mlf-Rules-Version: s20240627204322; ds20230628172248;
	di20240626213040; ri20160318003319; fs20240628163459
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: johns@valvesoftware.com
X-Mlf-Version: 10.0.15.7233
X-Mlf-License: BSV_C_AP____
X-Mlf-UniqueId: o202406281726030074293
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: valvesoftware.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 6/27/24 5:17 PM, Matthew Schwartz wrote:
> On Thu, Jun 27, 2024 at 2:28=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.=
com> wrote:
>> On 6/27/24 16:30, Matthew Schwartz wrote:
>>> From: John Schoenick <johns@valvesoftware.com>
>> Since this patch is from John, you would need his S-o-b in here as well
>> (assuming you have his permission to add it).
> This patch will be pending approval from them in that case. The panel qui=
rk
> follows the same structure as the Steam Deck Jupiter revision, but the qu=
irk
> has only been signed during merges by people who were not the original au=
thor.
> Link: https://gitlab.com/evlaV/linux-integration/-/commit/b90ac393

Hey, thanks for taking the initiative to upstream this -- feel free to=20
add my S-o-b

>>
>>> Valve's Steam Deck Galileo revision has a 800x1280 OLED panel
>>>
>>> Suggested-by: John Schoenick <johns@valvesoftware.com>
>>> Link: https://gitlab.com/evlaV/linux-integration/-/commit/d2522d8bf88b3=
5a8cf6978afbbd55c80d2d53f4f
>>> Signed-off-by: Matthew Schwartz <mattschwartz@gwu.edu>
>>> ---
>>>    drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/g=
pu/drm/drm_panel_orientation_quirks.c
>>> index 3d127127e7cb..ac8319d38e37 100644
>>> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
>>> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>>> @@ -427,6 +427,13 @@ static const struct dmi_system_id orientation_data=
[] =3D {
>>>                  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
>>>                },
>>>                .driver_data =3D (void *)&lcd800x1280_rightside_up,
>>> +     }, {    /* Valve Steam Deck */
>>> +             .matches =3D {
>>> +               DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),
>>> +               DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galileo"),
>>> +               DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "1"),
>>> +             },
>>> +             .driver_data =3D (void *)&lcd800x1280_rightside_up,
> Unless I get a S-o-b, is authoring a different DMI check the only solutio=
n
> to get a functioning panel quirk upstreamed for the Galileo revision?
> Not quite sure how I'd maintain conformity with the existing Jupiter
> quirk while also writing something original here.
>
>>>        }, {    /* VIOS LTH17 */
>>>                .matches =3D {
>>>                  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
>> --
>> Hamza
>>
> --
> Matt
>


