Return-Path: <linux-kernel+bounces-220982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256B590EA28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD71C2102D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB56013F435;
	Wed, 19 Jun 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQCAR30K"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87577137747;
	Wed, 19 Jun 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798187; cv=none; b=dMkBla+9U/q/NgHAewoA18oCA6hxaEQccinLPkadOyhOxAc1QMR14dmW9GA8+XBMbb6OHmUE0EHg8YAfO+52KaFI2mZtdlbQENkyvAWNb0PdDygvwUa3hJZek37Z/hneZhSNq37LEkqyamgsYeVfg5u6U/M3GB66xD+/smiLTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798187; c=relaxed/simple;
	bh=pOc8XAV3ETcz2jRRlUtG7K4MJXex94LvXrdBqMtoB00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSvdzhH13Z9XuHnedOICC6DiWwKf68qAVupxquSNMdDiOax/unzhMetcSnPsbYwhj+nPH2pmqK6MTB/OR04xUesHhozY7pX0MYWTovNN5xBTJ//wWN6Cf1Dw8IH4J5+9/j9KWZbwsKNBXU7clYbOJOXfpBqbuGaQk55wXu/CQuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQCAR30K; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a63359aaaa6so1007081366b.2;
        Wed, 19 Jun 2024 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718798184; x=1719402984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VigCe6J4hk8HOFljrC6mCt89lYlhdtQHnpiVgdfrXfk=;
        b=iQCAR30KA31GNptXcyS33a1dOZ+RmYtou3FPoHpyk65EKa7TVp3jx6AF1HVsWYGRhT
         k/EgMA3aaSP7RCaKwg0yUpS6yUGBHtRiqNZRQNHLWXpoGzM+bR7xaoq163PXrdhH7D5j
         hSGm6TGi1pf85rk0iyugDYzI+jTtp5J5zAszEfj0x79JrvZhyByQ5j1uC/ADRP/ukLL3
         jzWhbFPggthW1B7da2iOp9tua7jzJUnj57wfSOxLBwpZI/7I6OyIo60LvxxJ6JnIcbF6
         kxF/Ncwrc0IUchFXsX6ocn6JRntBPPVxDtAxpxqqCpecNrCf85XkgOBSjufZl8gwIm1N
         E9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798184; x=1719402984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VigCe6J4hk8HOFljrC6mCt89lYlhdtQHnpiVgdfrXfk=;
        b=C3o39M6shSLNJhAnDpQ4sB3Zrvmj8kj7AAZiv3H1t+RRxbNWIAmC3whbCMFj3e/pMT
         EHCQVWourDW2S7H6MpehK95Xo9YyJrl1mBDD2on/cbfX5UALOlxiGJm7sQT55Sa1Iv2H
         tlbVBWaYXDG9bH5cZ2Wo0GdaFNvB9+xNURavEFRgIDJojGflkdOyOSGJHgKGYnwq3Z6d
         gBpg7qCoE21IUdzqP6eEf8cxvGNkb2yLnjr/feisg+mFHcLrNpXEMGNCB/Au6XirRdXQ
         l74hgJpgNJN+i/NZrq/qxVo+YOuS27b0KlgmCwmwYUT8gkpSRkn14q6QRv7alBikrn6T
         r3hg==
X-Forwarded-Encrypted: i=1; AJvYcCUNuTWKZedcSuIjtCgR7nemcx4YanL2vfVCSJU0qSvwj4cc/xqdD/DZQGVS9wLEH6C9iy/EC5He76jZYGPr7O/cL2n2ntpCdNfKnmp6qK+9G1znM2f2fRSW9IZjYv+s2OfOACd3QfkN5qgFpbt4r1G/cj3K4Ntfde//vI1D3hpKRJwq1Q==
X-Gm-Message-State: AOJu0YyLCQ0kMukzAbzma4lW8R5IbwlM3btEngs8FsN0LqZEiFynqHUe
	ZpQZB6La8d6XlNCk4K6am/yG5CXLxOgp7vfJbrCJZBV8olT7NQS/g8LVXq5XpmvqBfSpO/abbzT
	H2hFmewKgofJdwBohJsnN3uM4mR6ZHoOeE6kJTjHW
X-Google-Smtp-Source: AGHT+IGJ1U5ZREckNCsu3v55VGRmfeDWoXXFjg+Sbw+yUhNJDknb7XhOIuRCdgjK7SXELVRWFiBFKcXkae1qeuZgB84=
X-Received: by 2002:a17:906:284f:b0:a6f:2130:34c2 with SMTP id
 a640c23a62f3a-a6fab62bc61mr107040566b.18.1718798183544; Wed, 19 Jun 2024
 04:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240603130126.25758-1-joswang1221@gmail.com>
 <20240604000147.2xxkkp7efjsbr3i5@synopsys.com>
In-Reply-To: <20240604000147.2xxkkp7efjsbr3i5@synopsys.com>
From: joswang <joswang1221@gmail.com>
Date: Wed, 19 Jun 2024 19:56:13 +0800
Message-ID: <CAMtoTm0S2WSO6VxK79DkTs+1aq5xBYBMRsPXWAFuWo4DoymUEw@mail.gmail.com>
Subject: Re: [PATCH v2, 2/3] usb: dwc3: core: add p3p2tranok quirk
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "balbi@kernel.org" <balbi@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, joswang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thinh

The workaround solution provided by your company for this issue is as follo=
ws:
  Workaround=EF=BC=9Aif the phy support direct P3 to P2 transition=EF=BC=8C=
program
GUSB3PIPECTL.P3P2Tranok=3D1

As the databook mentions:
This bit is used only for some non-Synopsys PHYs that cannot do LFPS in P3.
This bit is used by third-party SS PHY. It must be set to '0' for Synopsys =
PHY.

For Synopsys PHY, if this bit is set to "1", will it cause unknown problems=
?
Please help confirm this, thank you!

Thanks,
Jos Wang

