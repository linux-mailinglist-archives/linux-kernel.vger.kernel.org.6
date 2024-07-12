Return-Path: <linux-kernel+bounces-250103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2992F449
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284181C22BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39000D517;
	Fri, 12 Jul 2024 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwp7TUVV"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A102749A;
	Fri, 12 Jul 2024 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753865; cv=none; b=Mc6nJU3NJqSSXNJ75ARAkRU0Sqj/v1zS7ALQ+UFBFH5CyIxz6Ryyjkm9mM62vxqCSKVx+7VIixh06aqbMf2K88anvCGlAP3WlS2HePUtvEnG3MSbUUnKQz2npoPY3OQw7sz1U1oH69KpBMZV8veBkN+bWqv7znd5+PczJuEF0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753865; c=relaxed/simple;
	bh=dEAa5YzE2n5OuCjrIwY5pzmm3A0j7RiyhpI0nGWcSAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRxZBOHXai70aP4/RsBmQqWxv9uMvCTJ4/YmZiTX367HZjfpZzANsQJe8avMpCgBSrn7NsTk3Yt9XdYy8xO7xe/hpRnYyVALOX8q96zE1YTYShVDT1iD14s93HyeOWw/raNXOox9YAMZawtld+2o83+vgcPNZaBG/9gIlu7A/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwp7TUVV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa9ecfb321so13043265ad.0;
        Thu, 11 Jul 2024 20:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720753863; x=1721358663; darn=vger.kernel.org;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ml2DPYAyUJyVltqbgbaMwabyFMeG/DO22mcUV9WuoFM=;
        b=bwp7TUVVoCLh/0BiFVB6mQWtFvHrowRhUauAIMo0cGWwBYBpy90XpacAzK4q3t4dWp
         5tOl/ApFrH/v1iUJi9aTGDjsmzsTJtOIlRgVfKHf6lgFhpMh2glsHyRQnPOzsqxaGlR4
         n/w4uZsRpFT/HvlB0ZiCR5c85JVJHud6aeV6RZxSTryHY3hAzpV6GUEof9HXWKFRvOqr
         p2PHrDkdIE7lEZwcrJfJbDU46dHO612aBJYWEurte9TTUFIp9dnucxTngza9vfH1K89H
         VzUHCrPZ9JddmGJVTVl5M94Y/N/7JJsCrGCfGWn4UPBwvPdbU+xUFIqsJ46NtYjPS4bc
         UUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720753863; x=1721358663;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ml2DPYAyUJyVltqbgbaMwabyFMeG/DO22mcUV9WuoFM=;
        b=I+gzVMBpCB3sQwTWxalgCKwdWa3mAC0tK8RsG95E+pNO3ADMP5ehJzayqU49ZhJLxG
         HbYn5XoGAMxg96tjO8mw34wTaTLADaYsCVDio+Xyh7/fnke/Czbu58qcMZVZBqtIaenC
         jaikkEEuurjoTrMZWud2VE7JTUtrnU4yeyuEWK6VmtETmRPUimtmk1KT019N4WTA2Lz9
         KIk6xwKwg4CT9Z+3l2zK3bXNV0viRDjYm3Sboe+SQAoT1d0M6TuzyI4dNUDAS6fUEqBA
         EBX4SLU/LYVgyYB88sSDJntQogFyvRNBkDNc/oNA4ntQCj+I3o/EvCCDcsjfnl+xtx0S
         LODQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwQyCwhCjZGSbtKWyLG6/N0IF5PhBKPcJwpncbdilmQ3i6SJSkb2lKfNrYq3xAT5zuwxAy7bZzbRJI+KXu+foBAlf2B21mEtToEu3fZHfUvyXIEbTxVt2kQcaiYHBA7v5g9grlUh7B
X-Gm-Message-State: AOJu0YyO5HGh1psMNQkBEFG77fQ5tu3LZ138VQggAidSfGYRTZfq0iUg
	riFusCrPTtrBNbab2Ah5Hel4OkFc0i2hFsraLvdiJDoUDVs+NaXc
X-Google-Smtp-Source: AGHT+IH7+npEXds1wOtBP0PIPRz96ImAaPJyGAUkcxxUuZrzMdDol6p9jVgUYeJoIltue3djNGcPOA==
X-Received: by 2002:a17:902:f54f:b0:1fb:389b:1054 with SMTP id d9443c01a7336-1fbb6ec4012mr85996495ad.52.1720753863191;
        Thu, 11 Jul 2024 20:11:03 -0700 (PDT)
Received: from js-pc.. ([2408:8453:6d:7f1e:41e8:c2e1:ca4f:c196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2a5a9sm57404765ad.87.2024.07.11.20.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 20:11:02 -0700 (PDT)
From: Hongyu Xie <xy521521@gmail.com>
To: gregkh@linuxfoundation.org,
	oneukum@suse.com
Cc: brauner@kernel.org,
	jlayton@kernel.org,
	xiehongyu1@kylinos.cn,
	jack@suse.cz,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Date: Fri, 12 Jul 2024 11:10:57 +0800
Message-Id: <a782c5bc-fc8b-43ad-9c6e-1e6799243364@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
References: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
 <527927b8-9475-47da-bf2b-7a5d9e81e470@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://xiehongyu1%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

From: Hongyu Xie <xiehongyu1@kylinos.cn>=0D

=0D
=0D
On 2024/7/11 16:59, Oliver Neukum wrote:=0D
> =0D
> =0D
> On 11.07.24 10:43, Hongyu Xie wrote:=0D
>> During hibernation, usb_resume_interface will set needs_binding to 1 if=
=0D
>> the usb_driver has no reset_resume implimentation. The USB interface=0D
>> will be rebind after usb_resume_complete.=0D
>>=0D
>> Normally, that's fine. But if a USB interface has a matched kernel=0D
>> driver, and a userspace driver or application is using this USB=0D
>> interface through usbfs during hibernation, usbfs will be=0D
>> detatched with the USB interface after resume. And this USB interface=0D
>> will be bind with a kernel driver instead of usbfs.=0D
>>=0D
>> So add reset_resume to fix this.=0D
> =0D
> The device has lost all settings, yet we continue like nothing=0D
> changed. That strikes me as a very bad idea. If a device has undergone=0D
> a reset user space has not requested, we need to return an error upon=0D
> the next interaction.=0D
Sorry I don't understand your concern.=0D
When will "a reset user space has not requested" happen if there is a=0D
reset_resume in usbfs?=0D
> =0D
> I am sorry, but this implementation has some fundamental issues.=0D
> =0D
>  =C2=A0=C2=A0=C2=A0=C2=A0Regards=0D
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Oliver=0D
> =0D
Regards=0D
Hongyu Xie=0D

