Return-Path: <linux-kernel+bounces-304743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2622696243A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BF0285D00
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D57E166F11;
	Wed, 28 Aug 2024 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAYPzGXb"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7B1547F2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839308; cv=none; b=q0nKqyU8HVAEzqV97X0M8Ud2lH62NKftIo5FjG+ZwryhT30qZn26Scz9be369ZZo9WR59HcsZiEyn2ILxQaIyLnCVXWl8hTtBvVMhjZlXdtbdobKShYcIkEhkuQDue4OccVvhuGPHhbJyHkyXzch0Lu/I1XLXR2CBj0hbvT+zsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839308; c=relaxed/simple;
	bh=/7MURJkSBPRxvFV2K/o6yQ4iEcMvcArJy/YsuJZSYlk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqA96iOUFEcba5oVe1E5awt2CIT5gemhtsbMkQwx1/U9jGXOHxzY9kv3+xkBm9MZ5FnWI4JU/r1dvVkzEWUlMPfovmt5ufNlVKGsmnZm0h9s/avuKTtXHPaU7xup6TRjZvxcIspsndBrUgMNYgywLjqlwWrXAaWyMKaPV8PzOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAYPzGXb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201fba05363so55184015ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724839306; x=1725444106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILQ333BDFlU5S5fyU2L5G2VIKc+hOKagrbroJak6mWg=;
        b=gAYPzGXb/wllyH45RFbs5CZ1uUxThtmeM21gFXY568qoewhCwBuU7gFyv99eZG/hTV
         +jkCwsbLZWkw90VIBcOds62SnX+UGjFiuq7MRM+dlWlZXmks03rnOXETQXmGOTSU03Me
         uwx/OIVFohWs3wH27nEYSqlheEMpcvHVXbChGu1TV9Gf6wwyI/H2Wilau8UQ0owHNSMF
         LpZr85UPEOYfk3UBihVMeCbasCwEg/yQ5owKB80bdP+Ndrc/DAvQmt48uOE64f5+hdgL
         LO7lG0rALiUWEF3F3SBtU1o3MCuumo4mQdVIoK1jDJGmIcIdb1Hul3ZKV0X9MriJF6Li
         X6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839306; x=1725444106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILQ333BDFlU5S5fyU2L5G2VIKc+hOKagrbroJak6mWg=;
        b=ZF/YVLpzNaeTQaLLXDo4ZWMNr+igWRpqZD0EJUaq3pNRkTab/ki4EXzyf1IQjseGXN
         fvrrFuFvM8st858ZWXN2Inx61g5NsH9+7sTuO31BQy2CNIKk5SLrosllOMvyaQUA2Wwm
         OOH6i15bUTnJHwoRJiGhNX6FU0A8vNU4SVY9Vc+WnLyNesF3xJTREQ65CKglCxwtED00
         Ahybj8CVsKn1jUyl4YOPJ15dFXwMcPdroySZ5XobbgLdeZC/0nuNYodwqzTL5aDsDGRZ
         NMTsdCU6vOfPasZsTk6csw+V+WpHDy3VnvtN+8E1vAR46FV38WDB9j2OeXdHlXYQM3yw
         2D1A==
X-Forwarded-Encrypted: i=1; AJvYcCWqsHAyLkexO4baivQ/wWw7dzDwk3xHwksoh4a4oQRdO8VX99DMjgHg/tFtwktwTiCetopV6nTCg3X2FKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRX+0rS9GbzGX2VPvol5F3IbeKqTBd8D0iRJrkBdqq1WoO4tec
	7Bt00BENO5Uebdg4vzXNu8U/ncm9XB7emTwIRkOiBTOtqed2qG4F
X-Google-Smtp-Source: AGHT+IFXwWv0Svgce9lob7cKs0SAQGG+i+XSbJVD7qmDdNe3kJdMmO8lgf/9SvJkUmZ6kPkTyj0a9g==
X-Received: by 2002:a17:902:d512:b0:203:a0ea:62a3 with SMTP id d9443c01a7336-204f9a3eca5mr13492065ad.1.1724839306246;
        Wed, 28 Aug 2024 03:01:46 -0700 (PDT)
Received: from victor-IdeaPad-Gaming-3-16IAH7 ([116.68.77.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385bdca67sm95440285ad.251.2024.08.28.03.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 03:01:45 -0700 (PDT)
From: YOUR NAME <vivek6429.ts@gmail.com>
X-Google-Original-From: YOUR NAME <username@gmail.com>
Date: Wed, 28 Aug 2024 15:31:41 +0530
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: Rename function SelectChannel()
Message-ID: <Zs71hc9-p0vST-7Y@victor-IdeaPad-Gaming-3-16IAH7>
References: <Zs7vQXhcYRCxCDaH@victor-IdeaPad-Gaming-3-16IAH7>
 <2024082848-ice-unfixable-6a09@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082848-ice-unfixable-6a09@gregkh>

On Wed, Aug 28, 2024 at 11:38:18AM +0200, Greg KH wrote:
> On Wed, Aug 28, 2024 at 03:04:57PM +0530, vivek t s wrote:
> > --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> > @@ -455,7 +455,7 @@ u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset);
> >  unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter);
> >  
> >  void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigned char channel_offset, unsigned short bwmode);
> > -void SelectChannel(struct adapter *padapter, unsigned char channel);
> > +void select_channel(struct adapter *padapter, unsigned char channel);
> 
> This is a pretty horrible name for a symbol in the global namespace, can
> you rename it to be more sane for this driver (i.e. put a prefix on it?)
> 
> thanks,
> 
> greg k-h
okay, will change and submit again.

thanks,
vivek


