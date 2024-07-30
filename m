Return-Path: <linux-kernel+bounces-267346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 965BD941085
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF526B24F00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C17199235;
	Tue, 30 Jul 2024 11:32:20 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20E187340
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339139; cv=none; b=rUMyWTuLfyf3WLREs67yi1yVrVTZeB/ha5K1kjBxfitqOCv1itftEyeHmsilW/BXxUMe/WaB/nkQv+UHAFHu9e5AfXLFxjfFqfz12P7tDBqh4POILV0fM5qCOFsHocIJWpCKPcGLbmzXfLf9SocNc++J+pt7H54SkoIGjEfjZD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339139; c=relaxed/simple;
	bh=ijUNcgcuLhIdQSjWSu4vAPrdpMXsZifY9ALseJFkkO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=husZzKDowFUAOdHVZNRSf9vCG7UcnXkV5G8nLDvdOHY/BAJneGcOYhEpAC2UuEaDddGDl/SF+yLtV7Jh5tse5qhK1Uurnyr9xG916GlZAXTGoFXVQJxC5DzVmulgeL9qGQlMNaxzRF1t4Tf1OPLEuQvxK/xTXd+MzWd4CLkJ7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so16933115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339136; x=1722943936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ye7xymP0lVxdOW1VnYguGOUs40HRtW5yTGkObTJ6GAo=;
        b=GtMQGJNdt+Awo7ypW2L8K1QDfgQpJyi0WkVkKqLZxVsPp2Mqz9Em913Q1PSCD/mqY7
         KiDNHk4fQBidEK65pu/c7sScB4Co7G0DtYUqPqlmMZdhejnin+X6V2dh38QDpcdLcINJ
         zOl9AcmVAHlbqE/s56vZOwWwDq2x2l1Ykyb7dvQ4jY081ditKYXfVKGExRb2ugZt3iPs
         W2aEZ7teVJRadgPr1Fbkl+x7UHEn2aJhNzrSiIBEFbS9LWLX9Tc1U+kNthL13Lgy7p4/
         tKbNsNTPmE3dKDOJMN900WfksKE48a8C9uZG61bryhKuQeWQ6E62LTIW4okaX5F9gNGt
         L0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUlABL3gVg0HwLjlaQrOGzSb3iGPLR2jmj0xtXtDosa64dqihmjwgRqeo6KaWikeufbW3eOg3uRDex9HxQEGX3zJs9jLGC9AjIy2BH5
X-Gm-Message-State: AOJu0YwM4FLOvnjLnGhU/ZO5sJDHJZS85Faj90gfwBqc6bQ5J+ezScta
	HbdQzF/eCxkZs+qZteG7CUrD7qfTenhiGFSaCYJn/RjVMlZyf5hD
X-Google-Smtp-Source: AGHT+IFPbmqgnqJa+EFS4T/aQsdGqc4a0CyqIy57IkUeRTs1+UE04r6UKAN4+R+Lmd8R289rwM4BkQ==
X-Received: by 2002:a05:600c:1c8d:b0:428:29e:67cc with SMTP id 5b1f17b1804b1-4282440e3d7mr12731655e9.10.1722339136271;
        Tue, 30 Jul 2024 04:32:16 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:7aef:1aaa:3dff:d546])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281c701619sm79531755e9.36.2024.07.30.04.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 04:32:15 -0700 (PDT)
Message-ID: <a161733dd063104b371f4587ace612025b4981f9.camel@debian.org>
Subject: Re: [PATCH 1/1] vmgenid: emit uevent with new generation ID
From: Luca Boccassi <bluca@debian.org>
To: Babis Chalios <bchalios@amazon.es>, tytso@mit.edu, Jason@zx2c4.com, 
	linux-kernel@vger.kernel.org
Cc: graf@amazon.de, mzxreary@0pointer.de, xmarcalx@amazon.co.uk, 
	gregkh@linuxfoundation.org
Date: Tue, 30 Jul 2024 12:32:15 +0100
In-Reply-To: <20240730094831.882166-2-bchalios@amazon.es>
References: <20240730094831.882166-1-bchalios@amazon.es>
	 <20240730094831.882166-2-bchalios@amazon.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-30 at 11:48 +0200, Babis Chalios wrote:
> There are many system services that need to be notified when the VM they
> are running in is resumed from a snapshot. One example are network
> managers which need to renew DHCP leases and/or re-create MAC addresses
> for virtual interfaces. Other example are daemons that manage system
> clocks which need reset upon snapshot resume.
>=20
> Send a uevent notification to user space from the VMGenID driver when
> we receive the ACPI notification about a new generation ID. This way, we
> notify user space software about the VM cloning event and give it a
> chance to adapt to the new environment.
>=20
> Signed-off-by: Babis Chalios <bchalios@amazon.es>
> ---
>  drivers/virt/vmgenid.c | 2 ++
>  1 file changed, 2 insertions(+)

Speaking as a systemd maintainer, this is precisely what we need for
systemd-networkd and systemd-timesyncd, thanks for taking care of this.

Acked-by: Luca Boccassi <bluca@debian.org>

--=20
Kind regards,
Luca Boccassi

