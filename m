Return-Path: <linux-kernel+bounces-362452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECC499B51D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09941C2112A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336A6185E53;
	Sat, 12 Oct 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPBV/TkW"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126D1552FD
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740555; cv=none; b=lUDzQg/yAa9aTliKka+P3L9jUj0/L8WtEvGqGUYFEoCrfmnxf1ksDo3mZSmXYlwqHlTcTQjjZof0/lm3Pq/im//kbsLJBIe0B/PLdAxCGdlUfcfsfU76B6AlIAbFEFL0WxwA80Q65AcG2QPghjjUzpCRztO8HIqxBwLc9+MNCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740555; c=relaxed/simple;
	bh=WT5MmpXdbJfwqQCUnzaskjiOSw6bD4LJWOzIuYZ0AuY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TME9/HKWIkfQ33CwjBU9Fd1TbwAFEBs+waXsWLz2Cc45josZ8HlW8ozgIg/MG52v7YDzOZes0bZB7uxFLJSZw4jlkxKN00Ehn8UcGI9Zz5vnF5Yg9u0EIrW+jl/vp7xbajHvcE+26R7Jb0oypV0eZOV2R2Qy/0J4L/jxKTx45gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPBV/TkW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4c1b1455so1885926f8f.3;
        Sat, 12 Oct 2024 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728740552; x=1729345352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5VvXu3fs6fooJDsNL/5eiUIUqGjKTvSOIvRitQil/qk=;
        b=VPBV/TkWWA8C1/M5y3uz+2odBdTRzCaEsMR+SbGAYgE6PHx2KI4U4AFxW3+w7zl49y
         LkHvpylJTglmkDqfDrSITem+wGBMjWTyZtPq06jAuqENtOLv09AO9FbXhvYYK6J+Wds2
         ew+DRz4Af9xeoJhJhrxi5etxKy4/FxxU7e4HxXECWFCy31fPKaj29LLTaAYcfNWHmL0U
         Vep7HpVytCmqPKlddKT8fh337Syg7cv7WsxmWeKonJV54IoudXlhZ9VSj8vkvLw5pB2l
         o3DLNUh0OFaLq7Wk07HeBdUGDY+CwRFROvYUiZYYc+/oAUjck5FA2zcz8ffq7wLmeOgT
         IhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728740552; x=1729345352;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VvXu3fs6fooJDsNL/5eiUIUqGjKTvSOIvRitQil/qk=;
        b=wckfq+R+8YSn8XUMjPwVtYz/9k3csPYjNwEAaW+KeErOpVpwsNhAz1vgf9xGhpK8CA
         LELCOt9eYV6HT4nHj+NBk0dOD1MsSQK103yxCM/r0JODiYAQqWD9s8akg67Pc02ftJAe
         LDk0vBllSuG7Fi2CmjdChnXsD7zF/lojZkHmK7ztajlt1XdCSCWaJ5Md+A/lBEycW0l5
         3SqjQ/cTHTzr+Jqz0geVqVdZjOn6379wut2ekgN11Zswv/R/qArfd1fQCv1eViFYl5a0
         PE0FQdBrEAw9oJ8XX11ZnLDNXpa6EKuaFwAQ4RfCXWHSnfVCsLom7KSyCjTOtCJ3k6i7
         ok1A==
X-Forwarded-Encrypted: i=1; AJvYcCX4Mmx86bh7qqmAbxmWX8+oxjFXy24e6NUYCpa/jY/j5caVlxjEDdCCz3l0qVl7F8GG7mil8QceU+hLJc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMAU5PjyC7E2PoaNT66Vpbt8HfMQCTz4a/JRhTvPxJuxa+vn+p
	rMDRTWTLV6+hxoZs/5r+UF+oEmLHfzNJiOP6dL4pG970/R0/WPz4ByB5Zxqdo59UnOvVRw7hxgc
	B0UGpxt4virswempREkql2GnUU7v6nDji
X-Google-Smtp-Source: AGHT+IEyYU7deWtacxwIqeiYOu2qiGEZ8vh0F+36zUSmLh8Azj1Fkq90zF2K/7irt2iplt80IUdXGz6aBwF44MVCfHI=
X-Received: by 2002:adf:fd8e:0:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-37d551b07e0mr3890379f8f.14.1728740551948; Sat, 12 Oct 2024
 06:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Walt Holman <waltholman09@gmail.com>
Date: Sat, 12 Oct 2024 08:42:21 -0500
Message-ID: <CAMb39_=ebMmeCuZQAQS--CnM4PDaBEfJ4pbiG9gtJZkmikohWQ@mail.gmail.com>
Subject: Commit 610712298b11b2914be00b35abe9326b5dbb62c8 Breaks Bluetooth discovery
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-netdev@vger.kernel.org
Cc: luiz.von.dentz@intel.com
Content-Type: text/plain; charset="UTF-8"

Recent 6.12.0-rc kernels include the following commit:

commit 610712298b11b2914be00b35abe9326b5dbb62c8
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Oct 1 11:21:37 2024 -0400

    Bluetooth: btusb: Don't fail external suspend requests

    Commit 4e0a1d8b0675
    ("Bluetooth: btusb: Don't suspend when there are connections")
    introduces a check for connections to prevent auto-suspend but that
    actually ignored the fact the .suspend callback can be called for
    external suspend requests which
    Documentation/driver-api/usb/power-management.rst states the following:

     'External suspend calls should never be allowed to fail in this way,
     only autosuspend calls.  The driver can tell them apart by applying
     the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
     ``suspend`` method; it will return True for internal PM events
     (autosuspend) and False for external PM events.'

    In addition to that align system suspend with USB suspend by using
    hci_suspend_dev since otherwise the stack would be expecting events
    such as advertising reports which may not be delivered while the
    transport is suspended.

    Fixes: 4e0a1d8b0675 ("Bluetooth: btusb: Don't suspend when there
are connections")
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Tested-by: Kiran K <kiran.k@intel.com>

This breaks bluetooth on my ASUS ROG GA605WI laptop. I am using a
Qualcomm WCN785x Wi-Fi chip with Quectel Bluetooth. Reverting the
above commit fixes discovery and connection issues with bluetooth on
my laptop.

