Return-Path: <linux-kernel+bounces-559619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9050A5F64E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4963170447
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E7267B81;
	Thu, 13 Mar 2025 13:50:08 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83294267AEC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873807; cv=none; b=BW9rguBDMkVHAkDYEeo7AEIOxSvwO2koKER3OT8HLnJM3kasnP/ZQCxvQRJrwomoF7+Gtd9f4GqyCwf8GIlqwZGEGkVv/RubOmfe41sEeeTYMLJohyiRnkV1hEaoLdlnTHypWR4+tce/kmOL4AdfSPB8TDIEgbAPoDf3cN8ndbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873807; c=relaxed/simple;
	bh=c5BwsiMUEcE3FxlbLKMbbMYxcD4AgL6mpQVpTtKlUJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnbT6cuQNVgC6KRZTvhzXJ0IJFEykWXZPR5rziKyG+SaApB0VP0wbkeDJ80PYTi4EFfjzuRUVaaEv5BqhS1l7h4cAHXWiVpZMum40O4qyMeTQgcBXPL5lQmw1rBTmPAQgMv5hAexKzsRmaag+4xnqInbcEt/iI6m2PiLTFGKeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZD7qG0qYKz9sSY;
	Thu, 13 Mar 2025 14:38:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bhtE9KRHTdsR; Thu, 13 Mar 2025 14:38:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZD7q91zC1z9sSL;
	Thu, 13 Mar 2025 14:37:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 302D58B779;
	Thu, 13 Mar 2025 14:37:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WdQEpeFRVBdp; Thu, 13 Mar 2025 14:37:57 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C86C58B770;
	Thu, 13 Mar 2025 14:37:56 +0100 (CET)
Message-ID: <362f9392-f891-4a15-9ffd-5f5a6cac41b8@csgroup.eu>
Date: Thu, 13 Mar 2025 14:37:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: fsl-mc: Remove deadcode
To: "Dr. David Alan Gilbert" <linux@treblig.org>, ioana.ciornei@nxp.com,
 stuyoder@gmail.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241115152055.279732-1-linux@treblig.org>
 <3f9dbb7b-6527-48e1-9028-b46e5a0c58ce@csgroup.eu>
 <Z9LbwRUsHwFLpBZA@gallifrey>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z9LbwRUsHwFLpBZA@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/03/2025 à 14:21, Dr. David Alan Gilbert a écrit :
> [Vous ne recevez pas souvent de courriers de linux@treblig.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> * Christophe Leroy (christophe.leroy@csgroup.eu) wrote:
>>
>>
>> Le 15/11/2024 à 16:20, linux@treblig.org a écrit :
>>> [Vous ne recevez pas souvent de courriers de linux@treblig.org. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> fsl_mc_allocator_driver_exit() was added explicitly by
>>> commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
>>> but was never used.
>>>
>>> Remove it.
>>>
>>> fsl_mc_portal_reset() was added in 2015 by
>>> commit 197f4d6a4a00 ("staging: fsl-mc: fsl-mc object allocator driver")
>>> but was never used.
>>>
>>> Remove it.
>>>
>>> fsl_mc_portal_reset() was the only caller of dpmcp_reset().
>>>
>>> Remove it.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>
>> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Hi,
>    Can someone pick this old change up please?  I see the PPC patchwork says
>    'handled elsewhere' but doesn't say where.

MAINTAINERS file says where:

QORIQ DPAA2 FSL-MC BUS DRIVER
M:	Stuart Yoder <stuyoder@gmail.com>
M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
L:	linux-kernel@vger.kernel.org
S:	Maintained
F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
F: 
Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
F:	drivers/bus/fsl-mc/
F:	include/uapi/linux/fsl_mc.h

FREESCALE SOC DRIVERS
M:	Christophe Leroy <christophe.leroy@csgroup.eu>
L:	linuxppc-dev@lists.ozlabs.org
L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
S:	Maintained
F:	Documentation/devicetree/bindings/misc/fsl,dpaa2-console.yaml
F:	Documentation/devicetree/bindings/soc/fsl/
F:	drivers/soc/fsl/
F:	include/linux/fsl/
F:	include/soc/fsl/

I acked the 2 line changes in include/linux/fsl/mc.h, the main changes 
being in the C files which are not under my scope.

Stuart, Laurentiu, can you pick up the patch ?

Christophe

> 
> Thanks,
> 
> Dave
>>
>>> ---
>>>    drivers/bus/fsl-mc/dpmcp.c            | 22 ----------------------
>>>    drivers/bus/fsl-mc/fsl-mc-allocator.c |  5 -----
>>>    drivers/bus/fsl-mc/fsl-mc-private.h   |  6 ------
>>>    drivers/bus/fsl-mc/mc-io.c            | 20 --------------------
>>>    include/linux/fsl/mc.h                |  2 --
>>>    5 files changed, 55 deletions(-)
>>>
>>> diff --git a/drivers/bus/fsl-mc/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
>>> index 5fbd0dbde24a..7816c0a728ef 100644
>>> --- a/drivers/bus/fsl-mc/dpmcp.c
>>> +++ b/drivers/bus/fsl-mc/dpmcp.c
>>> @@ -75,25 +75,3 @@ int dpmcp_close(struct fsl_mc_io *mc_io,
>>>           /* send command to mc*/
>>>           return mc_send_command(mc_io, &cmd);
>>>    }
>>> -
>>> -/**
>>> - * dpmcp_reset() - Reset the DPMCP, returns the object to initial state.
>>> - * @mc_io:     Pointer to MC portal's I/O object
>>> - * @cmd_flags: Command flags; one or more of 'MC_CMD_FLAG_'
>>> - * @token:     Token of DPMCP object
>>> - *
>>> - * Return:     '0' on Success; Error code otherwise.
>>> - */
>>> -int dpmcp_reset(struct fsl_mc_io *mc_io,
>>> -               u32 cmd_flags,
>>> -               u16 token)
>>> -{
>>> -       struct fsl_mc_command cmd = { 0 };
>>> -
>>> -       /* prepare command */
>>> -       cmd.header = mc_encode_cmd_header(DPMCP_CMDID_RESET,
>>> -                                         cmd_flags, token);
>>> -
>>> -       /* send command to mc*/
>>> -       return mc_send_command(mc_io, &cmd);
>>> -}
>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
>>> index b5e8c021fa1f..6c3beb82dd1b 100644
>>> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
>>> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
>>> @@ -656,8 +656,3 @@ int __init fsl_mc_allocator_driver_init(void)
>>>    {
>>>           return fsl_mc_driver_register(&fsl_mc_allocator_driver);
>>>    }
>>> -
>>> -void fsl_mc_allocator_driver_exit(void)
>>> -{
>>> -       fsl_mc_driver_unregister(&fsl_mc_allocator_driver);
>>> -}
>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
>>> index b3520ea1b9f4..e1b7ec3ed1a7 100644
>>> --- a/drivers/bus/fsl-mc/fsl-mc-private.h
>>> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
>>> @@ -66,10 +66,6 @@ int dpmcp_close(struct fsl_mc_io *mc_io,
>>>                   u32 cmd_flags,
>>>                   u16 token);
>>>
>>> -int dpmcp_reset(struct fsl_mc_io *mc_io,
>>> -               u32 cmd_flags,
>>> -               u16 token);
>>> -
>>>    /*
>>>     * Data Path Resource Container (DPRC) API
>>>     */
>>> @@ -631,8 +627,6 @@ int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
>>>
>>>    int __init fsl_mc_allocator_driver_init(void);
>>>
>>> -void fsl_mc_allocator_driver_exit(void);
>>> -
>>>    void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
>>>
>>>    void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
>>> diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
>>> index 95b10a6cf307..a0ad7866cbfc 100644
>>> --- a/drivers/bus/fsl-mc/mc-io.c
>>> +++ b/drivers/bus/fsl-mc/mc-io.c
>>> @@ -263,23 +263,3 @@ void fsl_mc_portal_free(struct fsl_mc_io *mc_io)
>>>           dpmcp_dev->consumer_link = NULL;
>>>    }
>>>    EXPORT_SYMBOL_GPL(fsl_mc_portal_free);
>>> -
>>> -/**
>>> - * fsl_mc_portal_reset - Resets the dpmcp object for a given fsl_mc_io object
>>> - *
>>> - * @mc_io: Pointer to the fsl_mc_io object that wraps the MC portal to free
>>> - */
>>> -int fsl_mc_portal_reset(struct fsl_mc_io *mc_io)
>>> -{
>>> -       int error;
>>> -       struct fsl_mc_device *dpmcp_dev = mc_io->dpmcp_dev;
>>> -
>>> -       error = dpmcp_reset(mc_io, 0, dpmcp_dev->mc_handle);
>>> -       if (error < 0) {
>>> -               dev_err(&dpmcp_dev->dev, "dpmcp_reset() failed: %d\n", error);
>>> -               return error;
>>> -       }
>>> -
>>> -       return 0;
>>> -}
>>> -EXPORT_SYMBOL_GPL(fsl_mc_portal_reset);
>>> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
>>> index c90ec889bfc2..37316a58d2ed 100644
>>> --- a/include/linux/fsl/mc.h
>>> +++ b/include/linux/fsl/mc.h
>>> @@ -417,8 +417,6 @@ int __must_check fsl_mc_portal_allocate(struct fsl_mc_device *mc_dev,
>>>
>>>    void fsl_mc_portal_free(struct fsl_mc_io *mc_io);
>>>
>>> -int fsl_mc_portal_reset(struct fsl_mc_io *mc_io);
>>> -
>>>    int __must_check fsl_mc_object_allocate(struct fsl_mc_device *mc_dev,
>>>                                           enum fsl_mc_pool_type pool_type,
>>>                                           struct fsl_mc_device **new_mc_adev);
>>> --
>>> 2.47.0
>>>
>>
> --
>   -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>   \ _________________________|_____ https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.treblig.org%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C707d35bccc9a4949428b08dd6231e98a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638774688697894005%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ncMBG9AvSfn4mKmQkFv%2F6UfFYp%2FBMDOna7uejbavhUc%3D&reserved=0   |_______/


