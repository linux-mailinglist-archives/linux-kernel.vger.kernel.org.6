Return-Path: <linux-kernel+bounces-326184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA0097646E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2991F24DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD893192587;
	Thu, 12 Sep 2024 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ95qncD"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C1D1917CD;
	Thu, 12 Sep 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129621; cv=none; b=sy7LjumkVes2mPRWZ2E+E1/FDhs+DDfkaN/Gs4eTlJdAq6HrAF7BWzNY2PQM0HHBgl92MD7GlLRmph03lUaoWNTHUXrWUFb5cDAQQZnETF+ge69F3c8N6xGnGxwjJttTQX0xXQBuE4CirTrT3AzKXTG6dBqmz9GX04rJaxbYrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129621; c=relaxed/simple;
	bh=eGhoXPmHyaA9nfxemlihyhx2ly0XnoBJTKUcKXRneK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=hzE7nfuno/143H2hX40fbspjsLLwfkQXCyus9bNzCTJFjdedpJY7BZUxQUw+2yIpeVxhh/GKiV4s9YynOovCm4TZEdk2roAG02nYJs8lNfHQHSW4sQPWxzx34U7XuIdx637HkEXBepGFJFJW3LEp9ajKVaLXvjrDfNu3CpGKTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ95qncD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso788372a12.1;
        Thu, 12 Sep 2024 01:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726129618; x=1726734418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eGhoXPmHyaA9nfxemlihyhx2ly0XnoBJTKUcKXRneK8=;
        b=CQ95qncDe7oyEpwxeT64lp+N+POIsrTB6TAhIYZGDyliae9PfC1UZSk2p/fQjiCFvD
         tEma5QGCXGETK/nsHiFXXrOAq1NK9LrXSnsnWHVoK92is2gUjxEJuWm+juX3ZdONmc3s
         KooP4LCGRJ73uaz45egIr7uLJE3LHRSCPNT2tuwwnfk3z83BhOa6NyyfMSNwpHwE9+zA
         iMMgV7PSoUuyq3s2OVpf0Jrox9strmqBz1T2Vls40hVOzSlET5en79JfgiAivLpPRtAh
         8vnYPM5/p9MaucYmmHf42FZvGPMq6uQY7MPhkDekQKWeDeZJXezrw3MTV4GkYqEFG1Es
         yphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726129618; x=1726734418;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGhoXPmHyaA9nfxemlihyhx2ly0XnoBJTKUcKXRneK8=;
        b=nKfPYGNEEXUtOIAJ+yl34dsI1A0yYSrM5GG6CyIpCYB4CNYokw7YPknTXwYfqYt3v6
         9t+44QYuvXMCRud9j79rC364yu1/GmCcXbA2p376DI6L0d3LEeFO/TuVLz20of1sOaa7
         f2PoqYa0Een7GWPLQKd6S5t/ErtwQEAPhzhL2fpNiVTpNFMr0zzvZQCY3a3ZOj2bLuO/
         dysEIxhfE7lKgu3APbtqvTCLN3uRUnVSvtqeT53/q9a5vs+16/MP0vaIn2a4EFJGO2Wt
         m19HVKVyYGNLyKhe+eeeZ/Yz/ofToRqsvoHI0I5Ne1ZZnqELnkqFXQkIg9kA5g9lECSM
         L8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9mGEyamuSNZdgqDHkEJ721pEDDObxzt6Xh551Ep2pTOOO9FHj9ERZm4r1Js6q2m793Wd/Aj5agAcnHnc=@vger.kernel.org, AJvYcCWPXCGxtmxGpVoPkQQzeDfG929FHLjQ+V3raKZw/HDdf7mpxWl70EPswdX2ACDyi8VHEFsZ4MPODCPX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+wDXSsTDdaTZp8e+gFctlC+MXHyMV5zEMC211gY6aeTDQonqE
	7tkmnL6RXoG46y5t7tuMsMmalahDVwa7nSMRnv2bJzHIUYZJyRPw
X-Google-Smtp-Source: AGHT+IGBHPIOi+BlBzoWIqOf4JAFJrqgZb8DJeyyKsjgufW6aVvNACK9DhzW7U9tj/aYrQcUuM924w==
X-Received: by 2002:a05:6402:42c3:b0:5be:e9f8:9bbf with SMTP id 4fb4d7f45d1cf-5c413e10cb3mr1843629a12.9.1726129617711;
        Thu, 12 Sep 2024 01:26:57 -0700 (PDT)
Received: from foxbook (bio143.neoplus.adsl.tpnet.pl. [83.28.130.143])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8ce50sm6266289a12.84.2024.09.12.01.26.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 Sep 2024 01:26:56 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:26:51 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: jan.kiszka@siemens.com
Cc: gregkh@linuxfoundation.org, johan@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: pl2303: account for deficits of clones
Message-ID: <20240912102651.0febe751@foxbook>
In-Reply-To: <ecfefb25-7ce9-4a74-9708-f08d51d03ec1@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Wouldn't it be simpler to make this a quirk rather than a separate type?

Such approach has the added benefit of being easily adaptable to similar
half-baked clones claiming to be other types. AFAIS "pl2303" is about as
generic a name as "8051" these days, so I would prepare for the worst...

Regards,
Michal

