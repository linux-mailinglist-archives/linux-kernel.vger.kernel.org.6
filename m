Return-Path: <linux-kernel+bounces-389502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48949B6DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC6E1F22D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C41121892D;
	Wed, 30 Oct 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jndXqIGb"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0412178F0;
	Wed, 30 Oct 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320666; cv=none; b=MXf2guXhTs9F1JyLbG56zeTMdv2U8GMQaMqDpQVC9oBEJkZG7Id1N+pXBlTshJbstBwW/XTERr9LsedFk6CiMoMJnZ4p5kYKfSc5Q/qcn+r6q4+u+UTY0j1hWJBAI6LyUw3TD9YziHvpZWPfT8nQWyh39BKBGU1284EfofTl6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320666; c=relaxed/simple;
	bh=nKpfZxhd5JTHPVwevLVBLkoT7+Jsed3mNhMIIP8pgR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snfYf7s+oF6oFGCx8tNMlN41oJwK9QqElzvyUqXbmxj3mKSMl8VUJdbflyy3CW6GILbs7+sT6j2/N3bzoWzY4EZg6iEidf/9kYvNTB+VfcptPz7qWOuiUXredjom7WEW7NB0FwjLav+8Dj+0tPO+PgSrWEf76RgpCGRsYdAILeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jndXqIGb; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so172982a91.1;
        Wed, 30 Oct 2024 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320663; x=1730925463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NPktwdcsysf0pPmaCSB+WL73aCzNuMhxTTi/LgU30h0=;
        b=jndXqIGb8+4EPwLqkENgxJqrUQyJ1fif0QY8JGlqt4MeG7Vbxo7TpnBMHjlKuY3Q3X
         Vj1VClunsW9N7wsjvvevZMe15SzSWEUntI75e/DcqskjWpInSys77Qj1wuTqkMFXa/AR
         6Kjq4HLBk9d3FNncAz/6iabWRTLndiN4Cbusgc77bMcEdoghogaVBCldKMzL0HsM4LDe
         1VrWDIeXORWJODWbYCXqIYWiki0LKhNScGp2R5oartXhnQRngVQStHmLaTGbZJKNFT/Y
         IsXMh0BkziuDwgwFJ3eXbNNuegTscUF+MRL2mmT3AZMB82qBvsnjJKsyiYVivlQeYV54
         4mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320663; x=1730925463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPktwdcsysf0pPmaCSB+WL73aCzNuMhxTTi/LgU30h0=;
        b=CI60lujzHXXF1XRCu6NDs0799Wf9tvdB767AN9bKCNce3diHCeiJSaJnxrGloMmIbD
         G3HeXI1STHg2l7LgyWCDz5gnKQrRq9D0w9dRYSIxOhorSpm5dp38F9tmRzNvhwjTsyIl
         PKspNdDU1oSGlgc7AhkUD7Uav8gZK30TMrIypugDdQlqn0ZYi1VUWZ85cWuQsIqh5iyE
         RqlIOSIIKCoyPENiCdwCvo0mVn3jyROs9UtTUMRxIwIetcIg0PCRmPKMW+OSwd4hVsU8
         0tgI0jEzNObSvBmERC5Ch9zkHCTM0cJzuJ+K486qR6jhQsAO2HlGXQI0h8Oa2aMtaAcv
         kjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2DoTHhfLqxiFkdbtgzcVXfEoDApDYvQ7H57TpJyULmsqwd3ptM+/K6uHU8x43KnOn+dxAUADUdN9Ny+x5iCqLWBNrpg==@vger.kernel.org, AJvYcCWg5kG2k+6XVVzAILX9dEGe5nDkiXkAu5aJegl4qFb3oV8RsglkHurSCM+odFopHH/cVODW+7886wdvPH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50A2g3pa9aVMhrn3CEV997bmnv83OBgesMSRF0nwFbMKLp9Iv
	TeKDU7PZku68FD88ZBxqqahCDrq/bNrEqA3YYOE2eyPsOvyWtNk1
X-Google-Smtp-Source: AGHT+IHWm+74PvGbarLd657fMbJ/otvDcDIVZ4INlbAEkbkWex+5yQTDO+PwPgmi8YRFg4XnAELS0w==
X-Received: by 2002:a17:90a:4a15:b0:2e2:b41b:854e with SMTP id 98e67ed59e1d1-2e8f10756e1mr17639282a91.20.1730320662671;
        Wed, 30 Oct 2024 13:37:42 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa5f70fsm2314138a91.33.2024.10.30.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:42 -0700 (PDT)
Date: Wed, 30 Oct 2024 17:37:38 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, w_armin@gmx.de
Subject: Re: [PATCH 2/2] dell-wmi-base: Handle Win-key Lock/Unlock events
Message-ID: <u6iblpzelejo45nshcgkj5ohmmyomas5bze6xsrtgfeoyo5rqd@rfrfcwp5hsaz>
References: <20241030181244.3272-2-kuurtb@gmail.com>
 <20241030181532.3594-2-kuurtb@gmail.com>
 <20241030183436.3w5po6kcg6jmqigb@pali>
 <hj6jurton7ll4i475cwcqvk6dzjjire2briawxmuemnliofpyo@kpjdxpwflekm>
 <20241030202029.3ugz75wiautw6ewt@pali>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030202029.3ugz75wiautw6ewt@pali>

On Wed, Oct 30, 2024 at 09:20:29PM +0100, Pali Rohár wrote:
> On Wednesday 30 October 2024 17:11:40 Kurt Borja wrote:
> > On Wed, Oct 30, 2024 at 07:34:36PM +0100, Pali Rohár wrote:
> > > On Wednesday 30 October 2024 15:15:33 Kurt Borja wrote:
> > > > Some Alienware devices have a key that locks/unlocks the Win-key. This
> > > 
> > > Please specify (in comment / commit message) which devices. It would
> > > help other developers in future to track for which device is this event
> > > needed.
> > 
> > I will!
> > 
> > > 
> > > > key triggers a WMI event that should be ignored, as it's handled
> > > > internally by the firmware.
> > > 
> > > Can be this handling in FW ignored? So OS can use this key for any other
> > > functionality?
> > 
> > Probably not. FW locks the Win-key regardless of how the event is
> > handled.
> > 
> > > 
> > > Anyway, what is that Win-key and its lock?
> > 
> > Win-key is the LEFTMETA key and the lock key is the RIGHTMETA key.
> 
> Ok, thanks for info.
> 
> So if the firmware handles and process RIGHTMETA key, it means that the
> RIGHTMETA key is not usable for generic purposes on this machine?

Yes, it is not. Unless, of course we find a way to change FW default
behavior.

> 
> > > 
> > > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > > ---
> > > >  drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> > > > index 502783a7a..37fc0371a 100644
> > > > --- a/drivers/platform/x86/dell/dell-wmi-base.c
> > > > +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> > > > @@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
> > > >  static const struct key_entry dell_wmi_keymap_type_0000[] = {
> > > >  	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
> > > >  
> > > > +	/* Win-key Lock */
> > > > +	{ KE_IGNORE, 0xe000, {KEY_RESERVED} },
> > > 
> > > nit: code style: spaces around KEY_RESERVED.
> > 
> > I will fix it.
> > 
> > > 
> > > Is not there some better constant for this KEY_*?
> > 
> > We could assign it KEY_RIGHTMETA.
> 
> Just to note that if the key is marked with KE_IGNORE, its value is not
> used. But for documentation purposes it is a good idea to have written
> there something other than KEY_RESERVED -- if it is possible.
> 
> For example it can be useful if somebody in future figure out how to
> turn off processing of this key in firmware...

Thanks I will replace it with KEY_RIGHTMETA.

Kurt

> 
> > > 
> > > > +
> > > > +	/* Win-key Unlock */
> > > > +	{ KE_IGNORE, 0xe001, {KEY_RESERVED} },
> > > > +
> > > >  	/* Key code is followed by brightness level */
> > > >  	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
> > > >  	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
> > > > -- 
> > > > 2.47.0
> > > > 

