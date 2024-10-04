Return-Path: <linux-kernel+bounces-351051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B53990CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455381F23F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86241FD312;
	Fri,  4 Oct 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="p3rOZDzg";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="cPrDotOU"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE91FCC41
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066239; cv=pass; b=KU7tdVNe0bVbMcVo67gxgHG4puVE0R9xMas5v02czuDNjiY+5c8iCXuQk/pbktzv89ag/3SdBL0sZbnMl7Ro23na9ompJR5DpT1UwiOcZ2db6uNpcDAYEGknpNqBp8x6AScorLd91CeoSF4Feo/xmmHcram183LD/3Iyprw/uKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066239; c=relaxed/simple;
	bh=t3SSTTvJiPcGS8AWBMj6FYw/8/xboakWRSqFZ3Foj9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1cQvvoqkPYTx6XFb8ka+EpFxfFqSNJDG4yV46YkK1wfVL2Fjynb/4W+2rLxK3sq8347RFFtNKozT4FW9zmVxm01OOzQaCOq5h3VHrAYyBDLP5TuTteaQv5FgDqSUCqyJ3ZaqTRLRjHjDAyFlPn4qt8mmA/0/+0/3rW9PZCJF9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=p3rOZDzg; dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=cPrDotOU; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1728066202; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ryuDJkyoAigBE+RjYWjHOwz8Thcg/gbb5fWaZSHOKf3JBmDgDoTeXz3xVdKujnkzl8
    R+SWtAHPD1GziAmZIjOmP/jPWL+X84TE7IeB7kg4kNOzDLylwqwmOYD5SYD7SA6JDaTx
    yVPfjPHrhNZArjZpXx3lm0B8HZtXcG00gvxxVFG+AVqH8SC8iMyuOrjCZJqNPfu55/i+
    OId08i3wIHDYgsOy7AL3GEPgDwuzI52EbKO0c6j1pUCohNtxMmnYAUFeMZZ6Jo51jUz9
    YXvOdPy4SfziFFzJEtdxeDdT0X9JfgI8AOeTvuzMmfk9WZucU1OZ3S9Y8jH9cKucX9Rg
    N4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728066202;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fh5lK3S2+T6zI5umkiU5AYrf63ArwtBPlfiCR8hznDs=;
    b=cpYZO3RGAgzFip2LJ6xDfBHZMeM1zuDUDM2Vk6+Vb2B4rEOMjbOW07Z2xTsWTP8Xu6
    xYDEPYn7HVSpFjZ9MZ4hchhfzwY5GsSobHh0yDIqt5JFKU2+6G5hqsBjrAJaZfh32szy
    5I2qjpmcDj9ctG0xSAdlq38N/f3HokxgmpbTKi/VElEe1cDrgKZ0qgNsCW55YdWrSCjp
    oyoWec6QE2TzN5xW/LIHmxhnVIVzuLLHReErjR+4wTFN/IWppD22UVhMnHhxFR8CNQ9U
    CZXB4kHCYShrXcUQ7sH/4pV0FI1imTATdKPy7kVh4pnsLCcKYz7gBHZYwZO5rGXM1Z0f
    H8Fw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728066202;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fh5lK3S2+T6zI5umkiU5AYrf63ArwtBPlfiCR8hznDs=;
    b=p3rOZDzgUeuNjjwRSaUcfaVPHXrMVMvdn2MkrRb+3WKWL1fkyB0L9WkitiF2tfEheo
    H7+NzvSZwpxiAG/vBhFIgL3FdGwIAPFRDPU3k+dsS6Sd4NilPuI3QzbopyoONEg9AygS
    koBB2JmRhdVygCTSE52rXEb72/Dvwg0HtzPMhgXchL+uymFEHBX+WsCtAxeeys39NgIb
    AZ5FcrzcYaZl1lMG1Yv4OxrLmCEqNSLooxCHkxHyXLgEqTPWbDYyi1dddhzGqDP6LIUr
    b9j6p7UJASIBdWdEBlgitL+lfgo9x9GNKtdYR6s+LNQfM20Dl42Xw94hzms4VMXuAkSw
    eOZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728066202;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fh5lK3S2+T6zI5umkiU5AYrf63ArwtBPlfiCR8hznDs=;
    b=cPrDotOUMGIqIkpyrdwgVL/OvKnf2X+2HfYKDSbbZooT2v6gIAQ66Qn8b3ArRjUC1w
    rCaUNpTGk9m9F74AYhAA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5jms33DCCl8yuj1GiXKxy2NgsIyNI7J6OEvKwI="
Received: from [IPV6:2a01:599:80b:670e:7ae4:fdea:aa8b:6a58]
    by smtp.strato.de (RZmta 51.2.8 AUTH)
    with ESMTPSA id e0da1a094INKf8x
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 4 Oct 2024 20:23:20 +0200 (CEST)
Message-ID: <b758c87b-1ab3-4ce0-bc97-ac8fe9387c1b@xenosoft.de>
Date: Fri, 4 Oct 2024 20:24:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] drm/radeon: add late_register for connector - Please test
To: Alex Deucher <alexdeucher@gmail.com>, Wu Hoi Pok <wuhoipok@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alex Deucher <alexander.deucher@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "R.T.Dickinson"
 <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>
References: <20241004010601.3387-1-wuhoipok@gmail.com>
 <CADnq5_Nt=8Lx6KOXHf0DHmqo2O7dYKDTfGCz-w_Hv+__=BqP9w@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <CADnq5_Nt=8Lx6KOXHf0DHmqo2O7dYKDTfGCz-w_Hv+__=BqP9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi All,

I compiled a new RC1 of kernel 6.12 with this patch today. Please test it.

Downloads:

- https://github.com/chzigotzky/kernels/releases/tag/v6.12.0-rc1-2
- https://www.xenosoft.de/linux-image-6.12-rc1-2-X1000_X5000.tar.gz

Thanks,
Christian

On 04 October 2024 at 4:00pm, Alex Deucher wrote:
> On Thu, Oct 3, 2024 at 9:18 PM Wu Hoi Pok <wuhoipok@gmail.com> wrote:
>> The patch is to solve null dereference in 'aux.dev', which is
>> introduced in recent radeon rework. By having 'late_register',
>> the connector should be registered after 'drm_dev_register'
>> automatically, where in before it is the opposite.
>>
>> Fixes: 90985660ba48 ("drm/radeon: remove load callback from kms_driver")
>> Tested-by: Hans de Goede <hdegoede@redhat.com>
>> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
> Applied.  Thanks!
>
> Alex
>
>> ---
>>   drivers/gpu/drm/radeon/atombios_dp.c       |  9 ++-------
>>   drivers/gpu/drm/radeon/radeon_connectors.c | 17 +++++++++++++++++
>>   2 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
>> index fca8b08535a5..6328627b7c34 100644
>> --- a/drivers/gpu/drm/radeon/atombios_dp.c
>> +++ b/drivers/gpu/drm/radeon/atombios_dp.c
>> @@ -228,10 +228,8 @@ void radeon_dp_aux_init(struct radeon_connector *radeon_connector)
>>   {
>>          struct drm_device *dev = radeon_connector->base.dev;
>>          struct radeon_device *rdev = dev->dev_private;
>> -       int ret;
>>
>>          radeon_connector->ddc_bus->rec.hpd = radeon_connector->hpd.hpd;
>> -       radeon_connector->ddc_bus->aux.dev = radeon_connector->base.kdev;
>>          radeon_connector->ddc_bus->aux.drm_dev = radeon_connector->base.dev;
>>          if (ASIC_IS_DCE5(rdev)) {
>>                  if (radeon_auxch)
>> @@ -242,11 +240,8 @@ void radeon_dp_aux_init(struct radeon_connector *radeon_connector)
>>                  radeon_connector->ddc_bus->aux.transfer = radeon_dp_aux_transfer_atom;
>>          }
>>
>> -       ret = drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
>> -       if (!ret)
>> -               radeon_connector->ddc_bus->has_aux = true;
>> -
>> -       WARN(ret, "drm_dp_aux_register() failed with error %d\n", ret);
>> +       drm_dp_aux_init(&radeon_connector->ddc_bus->aux);
>> +       radeon_connector->ddc_bus->has_aux = true;
>>   }
>>
>>   /***** general DP utility functions *****/
>> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
>> index 528a8f3677c2..f9c73c55f04f 100644
>> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
>> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
>> @@ -1786,6 +1786,20 @@ static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector
>>          return MODE_OK;
>>   }
>>
>> +static int
>> +radeon_connector_late_register(struct drm_connector *connector)
>> +{
>> +       struct radeon_connector *radeon_connector = to_radeon_connector(connector);
>> +       int r = 0;
>> +
>> +       if (radeon_connector->ddc_bus->has_aux) {
>> +               radeon_connector->ddc_bus->aux.dev = radeon_connector->base.kdev;
>> +               r = drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
>> +       }
>> +
>> +       return r;
>> +}
>> +
>>   static const struct drm_connector_helper_funcs radeon_dp_connector_helper_funcs = {
>>          .get_modes = radeon_dp_get_modes,
>>          .mode_valid = radeon_dp_mode_valid,
>> @@ -1800,6 +1814,7 @@ static const struct drm_connector_funcs radeon_dp_connector_funcs = {
>>          .early_unregister = radeon_connector_unregister,
>>          .destroy = radeon_connector_destroy,
>>          .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>   };
>>
>>   static const struct drm_connector_funcs radeon_edp_connector_funcs = {
>> @@ -1810,6 +1825,7 @@ static const struct drm_connector_funcs radeon_edp_connector_funcs = {
>>          .early_unregister = radeon_connector_unregister,
>>          .destroy = radeon_connector_destroy,
>>          .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>   };
>>
>>   static const struct drm_connector_funcs radeon_lvds_bridge_connector_funcs = {
>> @@ -1820,6 +1836,7 @@ static const struct drm_connector_funcs radeon_lvds_bridge_connector_funcs = {
>>          .early_unregister = radeon_connector_unregister,
>>          .destroy = radeon_connector_destroy,
>>          .force = radeon_dvi_force,
>> +       .late_register = radeon_connector_late_register,
>>   };
>>
>>   void
>> --
>> 2.46.2
>>


