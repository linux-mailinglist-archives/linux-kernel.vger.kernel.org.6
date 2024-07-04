Return-Path: <linux-kernel+bounces-241075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A3E9276CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABFC1C21D56
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA01AE85B;
	Thu,  4 Jul 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKx10rfU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C501ABC25
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098323; cv=none; b=H+THlz771rGpvr08TuDatX+4QabEe7BPkWwStFk1a7zcLTiCoGYx1GiOee3Q60pEhQB2EwnR3DUjeF59tiB8K8/oDoJr73MMPkB3xwHitFeOhGV5PkqdBYsDgGjI+tRD/mr2ugqbxK/VTN2Bguzepdl8MH5+OC3Y0xEL5eVhoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098323; c=relaxed/simple;
	bh=kEgHvrKkP/JmOKG/+VNDIUUpwZumLitFBjNUA3WIU0g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=H6zlwKR1FB6GgVTc3H7v5ovBZmsVkEVttAM0Zzf6r8HlP100or/Ksw1rgQl2LMjDZCj+jAohLVdTi4qFYxdPxJaOmDu/d/D7FRfeVJggSX8l9RF24Ee7c7tThjh4p08sANDP7Xy+1XYIaOUdEb4UTyXNMCqkksUGhn0Sf5VKVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKx10rfU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720098321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K0LIkgFk3FChOL7eIhbF4O+FeLzO9NmnpeAt7yD+xlo=;
	b=IKx10rfUn2RZMhnFoB4cq/GXLhsKH8bcYHZYzLI3Wf6qpwruVZ+MoJPoUlaLAKhDwKfpGS
	xusRcxZN0UpK48twizn55Tt9cYrdQo+8CGHY6PxOjENoBp5mFrQzxgsdETBvjCvkA9QXlx
	AAWT8tOR5vMC8xGVEtkB4I49R7azwfk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-zG7GKWI0P6uJwORhHby8Yg-1; Thu, 04 Jul 2024 09:05:19 -0400
X-MC-Unique: zG7GKWI0P6uJwORhHby8Yg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57d3eca4bb7so1032869a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098318; x=1720703118;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K0LIkgFk3FChOL7eIhbF4O+FeLzO9NmnpeAt7yD+xlo=;
        b=EvyU7xGARs+CkPVqRQuRR3hdVbt4OZrrtqp7OMxtgIC/ulds6JE1oLiL8BC/ljM84r
         2LgeTM4+d9WBGnUBQeoGkZaoa0X2DtnjU/6878c1IK57T3SjuVxbBhhGXZxYM1XQBMZV
         xHEgvbFEehy/NsmVwt5/oJy38eWSbwkL78cGuWvTndI7sJ8gor37p6AfAyjF4mS4pTMM
         EImBeQie0C3lpcWfwqNt1oSXn/4dbu9CzclvAoYSUpan9leHhNO8NPUoiIfyb3lL9SBk
         C/5PPtHqNjdyT43UIy5WbWGUpbZXtOWG3xRhfAy1Ije2u0HI3KBxiOhs4msc10l0nwFy
         8e2Q==
X-Gm-Message-State: AOJu0YzKAvQJ3vbzTjrPqe+Zb4b3FoMMaGBPmBWSiK7Xpc7atkRHw+rw
	C9KtlpZL76BFWeJ574xXEfDTGTXfStticKwvTSmH1TMJRCKncKRvCWiOGL9uLqaNZrMdSNgM3LK
	BWh2UWDIhoscUG/xI4RNuA9nMt/n3MGovpUr6bS5i4ze27QqdILoPPqTWe++omg==
X-Received: by 2002:a05:6402:2692:b0:57d:5442:a709 with SMTP id 4fb4d7f45d1cf-58e7744e613mr1449069a12.0.1720098318665;
        Thu, 04 Jul 2024 06:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaDxYn9Pqu6TsWtxIem2XZpMIKWwXHc7vlrDGTnHQPn/nhfDycg9sSKf42JvwhrYxeAfSSZw==
X-Received: by 2002:a05:6402:2692:b0:57d:5442:a709 with SMTP id 4fb4d7f45d1cf-58e7744e613mr1449047a12.0.1720098318211;
        Thu, 04 Jul 2024 06:05:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58614d50580sm8454972a12.72.2024.07.04.06.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 06:05:17 -0700 (PDT)
Message-ID: <1cf4578a-3499-47e2-85de-03887de1f05f@redhat.com>
Date: Thu, 4 Jul 2024 15:05:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 6.10-5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Here is (hopefully) the last platform-drivers-x86 fixes pull-request
for 6.10.

This contains a single fix for a regression in toshiba_acpi introduced
in 6.10-rc1.

Highlights:
 -  Fix lg-laptop driver not working with 2024 LG laptop models
 -  Add missing MODULE_DESCRIPTION() macros to various modules
 -  nvsw-sn2201: Add check for platform_device_add_resources

Regards,

Hans


The following changes since commit 7add1ee34692aabd146b86a8e88abad843ed6659:

  platform/x86: add missing MODULE_DESCRIPTION() macros (2024-06-24 13:33:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.10-5

for you to fetch changes up to e527a6127223b644e0a27b44f4b16e16eb6c7f0a:

  platform/x86: toshiba_acpi: Fix quickstart quirk handling (2024-07-02 16:01:45 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.10-5

Highlights:
 -  Fix regression in toshiba_acpi introduced in 6.10-rc1

The following is an automated git shortlog grouped by driver:

toshiba_acpi:
 -  Fix quickstart quirk handling

----------------------------------------------------------------
Armin Wolf (1):
      platform/x86: toshiba_acpi: Fix quickstart quirk handling

 drivers/platform/x86/toshiba_acpi.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)


