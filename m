Return-Path: <linux-kernel+bounces-356968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3E99697E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31549284AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC0192585;
	Wed,  9 Oct 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaRKU9pf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06719068E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475434; cv=none; b=g7obIcF5Bdq5BavVDX+V56mztJIoAp/m8m92eHzEp8SULSoiQMU5VNnBQxdz++lQ/rfrQR7BUHp1poKrWVUtHknoFELH3uPb8WC7yj9TLTjLtrnLKxh4+l8nFlfkwGQoc3KkzeViccbOCVsi0SPY9u6zl8+1QoEQaYW7vzBNDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475434; c=relaxed/simple;
	bh=d8Kavz4pG0DrcMSTG519JLahfgY0ngVMi+UX0VgfOxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNDgfOMtXImz8Uny39MQaONM/WvWStGF+GNyPcLAM8y2v3gLEdEOHCAVojtfuFqa2AGxPp6/QhAxRg4Y5WO464MlQhb+ZoZsq8+rvvxTgFAqFxqIL54CkIUbSMkQl9dOyM+ePhcxhi2wJOOHdY7NginAGU3NLJx/KoDVnRe3ndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaRKU9pf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728475432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d8Kavz4pG0DrcMSTG519JLahfgY0ngVMi+UX0VgfOxk=;
	b=aaRKU9pf/FlOC5TYh/NYDWzJD7cArUf6VXNH9in96tJDZpYfgSFNFo4r/IHj+AXeZekcQ6
	2qR4g6Hr0qvKJ7NrY1nUNnrDouLsdTix7vk6DJIzte6tGZtzvEwfPQi3yL3j8VQPSBGZpw
	NmiU0ZEp/bB1hNofzw36WVnPsldfEkY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-wcuPtQS0Mw2088n-UVQoyA-1; Wed, 09 Oct 2024 08:03:51 -0400
X-MC-Unique: wcuPtQS0Mw2088n-UVQoyA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5e98bc4f87fso228496eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728475430; x=1729080230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8Kavz4pG0DrcMSTG519JLahfgY0ngVMi+UX0VgfOxk=;
        b=uuzVwiypmRPfqa4mIgbcz6cn+pTwVTYpKU3tUkAvTw2WhfkqIoCKeSYqj13Zq60qhy
         3TSh7MHlzZYe8vFKR0s199h3y4B5mQmQYG3gGg4jZar+NLJLZoBvfQyCpQl5qMZOUYDO
         0mxJSN9hDx9U4CTd2PvAdXRNonBVGnnQLTgStDlSrSDEgD2tDZrYy+d4g49Ih70SXsYs
         pgF0t1darRUeecVp101WxRx24xJ/x6iLeNQd4nrHwamdb5ATqgKgmOV/RWsPWQI57KsW
         KK8ycTSYUXkpAXkh7/yNMR+aJYqduFp7mhjWzxrMMxMtARU77kb5b/1F7e85GWC6954i
         0NTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1o+T3CaqXlogy65SmicdgKIgBkKI/mSeHgMAdQWL3k1cRwP0h5SHh+wXAJvglQRc7lDGQlX0yIZ/VBYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmecNA+iVU8z1lv4makrpDpKIemU20wxgRmHzhbn8ivNeFFWEw
	zormfMPwZVzetJ5c6stgeyxv78YTqPLsamqEV0Mavaig6SppYWuPGnx+K4cnVzIHZHCL0TZZ4WT
	xGowgbgv9oHbat3p1EDAa0hod0gtZCCpiCbHYScZ6bPsHnsr3/FA/tMZtG4TUlX4sQ4cTAxwXzD
	5D0Q+PyHAF5WzoRUAHtqkJcAYg+jjsuuSakUGu
X-Received: by 2002:a05:6870:d88e:b0:261:f30:fda3 with SMTP id 586e51a60fabf-288343063c1mr1385927fac.21.1728475430457;
        Wed, 09 Oct 2024 05:03:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEunAW49fg9TRqfk2Wul+wjLgorZM7rhrZCbIHsry+h80qprHZ8RuUHrprF5ApY/0Yivrsxi+udN4/j+iPW3fY=
X-Received: by 2002:a05:6870:d88e:b0:261:f30:fda3 with SMTP id
 586e51a60fabf-288343063c1mr1385884fac.21.1728475430088; Wed, 09 Oct 2024
 05:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115648.280954295@linuxfoundation.org> <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
 <CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com> <ZwZuuz2jTW5evZ6v@yuki.lan>
In-Reply-To: <ZwZuuz2jTW5evZ6v@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Oct 2024 14:03:31 +0200
Message-ID: <CAASaF6wdvXAZyPNn-H4F8qq6MpHmOOm9R+K+ir9T_sOG-nXpoA@mail.gmail.com>
Subject: Re: [LTP] [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Anders Roxell <anders.roxell@linaro.org>, Jan Kara <jack@suse.cz>, lkft-triage@lists.linaro.org, 
	allen.lkml@gmail.com, stable@vger.kernel.org, shuah@kernel.org, 
	f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org, 
	linux@roeck-us.net, srw@sladewatkins.net, broonie@kernel.org, 
	LTP List <ltp@lists.linux.it>, Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	rwarsow@gmx.de, pavel@denx.de, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, conor@kernel.org, 
	patches@lists.linux.dev, akpm@linux-foundation.org, 
	torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:56=E2=80=AFPM Cyril Hrubis <chrubis@suse.cz> wrote=
:
>
> Hi!
> Work in progress, see:
> https://lists.linux.it/pipermail/ltp/2024-October/040433.html

and https://lore.kernel.org/linux-ext4/20241004221556.19222-1-jack@suse.cz/


