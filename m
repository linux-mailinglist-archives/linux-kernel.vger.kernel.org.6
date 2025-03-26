Return-Path: <linux-kernel+bounces-576576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B34A7114D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7097A3258
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195AF19C55E;
	Wed, 26 Mar 2025 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkGHI87+"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFED170A37;
	Wed, 26 Mar 2025 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973841; cv=none; b=MhE1TEBhbY3qP0kgGh3h1X3G0oDX8CGZ+jv8JAld2cmuYXNdcdEQCBxyMEof0TY12yAtkiki2EdVUWVN1x4GFjPmno2eMnCLKLZ591IGPxGn7ne6/OM8r4pQRIGPzVpuhpa3qUVE3WqRGEAaNRfmupG/irEis+1BD3TQSb8gmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973841; c=relaxed/simple;
	bh=E0sFEAZTaMEvyyxH0pLgAheiSrDDDJD3pR0+GGVoNlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=WWE6qQS7PTq/LNDNStgXoMoRjpD+9axe6uG7fp4MbcWMAUgFdnjRt0Dz2j+wHmwtKCUXnDzTVm7m4DUOG93OJcMiRO1UC3jWviLTx33BJntFWws6D67sXZN0+JCzrpCYHrjae6iZ9Goxba0pHY6cFFPCKPjkNgB0703G4FWzsjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkGHI87+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30c091b54aaso64741071fa.3;
        Wed, 26 Mar 2025 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742973838; x=1743578638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RC0v/dICMowzdUsWp0DyK5hDPdADpm8V6Q0kfq5W0lw=;
        b=DkGHI87+BV9yfYaKWABGf8ZwT9Te5xEr1FOUcQAsUY3LGFOaMauU5MHKxUUL/QfQBo
         D8+d5Ulb5jJkfLFTqnsnkCU/t4M7HyY/d+iIqiDhv4t9N/we+bx4+SyxW6nDl4fCiZUk
         ZetPFm/2Af/8JiDRGoOYvtUMr75qPSpZ2UJr9VWi/TbUl3P9e04GZZURGd3kP6XhUc/f
         yqyHoHizEC7yf+DM0/hODJ5in+DJzdl/Yy0mlTtgDldVsGb/WCnFGKFDkGmsYV8+KZA+
         bVtLQNy2p0v6nv4/KywOwrOUc/XMu178C9yCFpklyrtsm7gFMdBl0JsCss5nnWnANJE/
         TW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742973838; x=1743578638;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC0v/dICMowzdUsWp0DyK5hDPdADpm8V6Q0kfq5W0lw=;
        b=eUyomhDdcC5IRe0/YTRwyXtLy3rnjzisEEabIsRhGe4ZSlqIVs6mtrjYRXOchjPcs+
         v/kKKD/VEIksDU4SlGCsZ1OD1QBF0gxXiS1dLQgj0GvgRmebZgKpFDwNudiimvnczzbm
         R578jru2IG8MuCPKxb4bQHCF2cujWoJbgCW/wueq/nEAWmWkkJzus3ggeqeqg8LWiIcX
         OwFt8Ms0uhgi7g+fIEsxGgD/bfRWb6ffuQd8LGAeHHMv7Tkg17I09q4oj3TsHvU4zPJE
         vTIRK/r3HEpyz7FLWVqM+U9Ti4lequbrKq2YnWG5K26EFolKrYvuJXOH5Jvk+tAbQRZ7
         FXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsbDYvjAkrjmE9WBgy707AHpnHX7I7qLnJvmPLRctZfpzPL3xEOPfrpArz/d7zqcZpCmfBEGrYUFfA@vger.kernel.org, AJvYcCWyvnSQsqeM4XQqBuzAPYFIPLCeszUPotwivws0VFc3/K9mRIu0fXswT5S02xqNhe0UkzpQvWOav5QXwPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofzMujiNgA5uEWrVnBbCXv+nqmIclb+1a1NtwJvf1ETVf8xwO
	5Pj1pgxTczt/+BzXjuj9gYd7/S1PtKPyV0KvlbJelxbAkdWpYUd9+H0zRA==
X-Gm-Gg: ASbGncvsYaN4kDmJYeOFcOCCY1UGRQr7oCaqgVBDfbfOUU2fro4IAixH0mbAet2MAsx
	3rC1oRPZubWFHnCnD2eHm2oEgHIX8c735IECPqnteRotT7KOL+xyCvVkJ6Nf06SmWBr5dsjjwb9
	Xh7Jj/BLkoTD+ECC1ZyocYEOge4+WcfSIMsV4ipzhW6IXWJJWNzmi36nBwgAr7lZax5Crd7CC7o
	gvtRsnw5mvBgjmCl3LCSwMHXq6dDYX5Ti0L0ats/xZM9BJq41bWCHV+ewC3nxgB+qqOOv1qA2Fy
	hkKvQ0YX5ZdXcq++xFXXowwcyye8fdauJhWI9gvoSq1VqxTzEHr+KKQVk8E=
X-Google-Smtp-Source: AGHT+IHC7XnxMEcM0Lxz0dG87XGOaRYhqY/yx5CjcnqQXakLkIgJiBfBLJJkEyosp76O1mhbbWOTCQ==
X-Received: by 2002:a05:6512:3f1e:b0:545:6a2:e58 with SMTP id 2adb3069b0e04-54ad64ef4ecmr7894381e87.32.1742973837595;
        Wed, 26 Mar 2025 00:23:57 -0700 (PDT)
Received: from foxbook (adqm95.neoplus.adsl.tpnet.pl. [79.185.146.95])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646cedfsm1714368e87.2.2025.03.26.00.23.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Mar 2025 00:23:57 -0700 (PDT)
Date: Wed, 26 Mar 2025 08:23:53 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: dengjie03@kylinos.cn
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
 usb-storage@lists.one-eyed-alien.net, xiehongyu1@kylinos.cn
Subject: Re: [PATCH] usb-storage: apply IGNORE_UAS for Realtek on RTL9210
Message-ID: <20250326082353.3a79aa8a@foxbook>
In-Reply-To: <20250326022019.1593669-1-dengjie03@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> The UAS mode of Realtek USB_HDD is reported
> to fail to work on several platforms with
> the following error message,

Possibly related?
https://github.com/raspberrypi/linux/commit/9d3afd87557637a37135aa6e370dea846b839c2d

An RTL9210 hardware bug with a simple driver workaround, solved
by RPi but never submitted upstream. I guess you could try it.

> [  148.437916][ 22] xhci_hcd 0000:ba:02.0: xHCI host not responding to stop endpoint command.
> [  148.462295][ 22] xhci_hcd 0000:ba:02.0: xHCI host controller not responding, assume dead

That's your host controller crashing, maybe a device bug confused it.
It may be the reason why storage drivers never recover from the error.

Out of curiosity, which HC is doing this?

> then after
> re-connecting the device will be offlined
> and not working at all.

Nothing can possibly work after the above, until xhci_hcd is reloaded.

Regards,
Michal

