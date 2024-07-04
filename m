Return-Path: <linux-kernel+bounces-240449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C682926DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C3B281D52
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC864200A0;
	Thu,  4 Jul 2024 03:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="QG7jwYcA"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA41C2BE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062116; cv=none; b=JTfnDmKWsn/RqidpW+SNNKCZd7qN7iPPDVl/wV8idyQp9Th7326d/qrZ7JCL4x7xAWUVeXppD4oD1oV3VXC29agm7ZsjcQronNTyLy+LcPsTv0Lhrvv6FNTfnlvldCYRtr93HQ42oIJ/zF0CI9/36ilMbuyexxBZWC7mR7FYOls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062116; c=relaxed/simple;
	bh=aiJrCreF6nhZTc0vL6R5K+tzKKSERjB67Jy9IJ7xSVQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l6++exLlUxrSt1TExV9c/ZarkSPhYZ72iyu2b6LpA7G+WPt4Rg2VK7kecswWnl1mvfTMOiZ+tn08CtGPbmfRKn18O3zAx7xgcH0CzBTpCsU9sztY+sQFBfhCt5n5pHrBwHzWouCtkcJur8M4i31HUk090yaxka8efjLpJUdhV/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=QG7jwYcA; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70aff4e3f6dso160472b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1720062113; x=1720666913; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiJrCreF6nhZTc0vL6R5K+tzKKSERjB67Jy9IJ7xSVQ=;
        b=QG7jwYcAdUfcQFG8mwIjkNK626wrMEKB2mbcwT6EHR76ywJgBgYD65iMbopVTILN86
         hDZFu14l8qfFXyEqdc1HUgY5T6YQCpLZ5x57khW9TnghcY0IIBgKt2ixBpEofPqV/mQx
         fU+N4lisiN7lmoR2wQjIxdAg1eiumLVbP57p/QlVgVnzU1XUhhLM0kLBN53UAWhvuJt2
         735rVSdGLgl0Vs127PanoFLYvnYQJiwjTgU36zmZsbrmFfbBFfj9O7QKjrTJrjrZylgO
         7eLwe24X4lfn3Cl/I/rJAFeeLz2YoKIf/sTGMhCfqYeY7YyUha/wD1gMLzA4aKMR97Lf
         hEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062113; x=1720666913;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiJrCreF6nhZTc0vL6R5K+tzKKSERjB67Jy9IJ7xSVQ=;
        b=vGG7sQ60+BF5+fbypdKs2v4l+iJdGyvawKud5esMjHIYiAvvTqRkT7D7eVTCWxujTy
         HgXYiZhGOl2Ap9s27/rIKyISVhIWO6ABUJuThyGspDZLka1GrQqxWLLPFtcZe5V9qeIl
         XiGPXhPUC325Pp3Njm12mNqX7iuv++7nUfbYnAqcnb0AzsLjbkCP0kFviLXfRF3nurqr
         vKWRCCYJdjV/yj36riT+93xQoEHDECrE2En40iMPfONGjuFzljvjInpFF/00r+zcocJM
         7cZ083Q3R1gXzrSJvMP+xTBe382W5Iu64FBEcIAtObQSu0UhYZp+R/tqwgojqascB0kA
         P/TA==
X-Forwarded-Encrypted: i=1; AJvYcCWZPH9aX9FWW3dKN4q7GVOkmaA9HCpoLvwABmWS0RDcps/fF9ZRHdgKPTck3ep9gwTksvWBfSJhGEzCH7QvbJu137NSO/yWtuDpaC6y
X-Gm-Message-State: AOJu0YwgE6y23OzE+vmqf3yNyaSy35pxCkNrutgZ9bpGKwuM79so4z9s
	tb7Srt5+D7xQRy1p+RbtFpnTOQSg5uZ9rT7YOiQmMacynYipopPTGb70Wg5lt14=
X-Google-Smtp-Source: AGHT+IGppthVj50QduluUwT2ETsJWZWd3n0XLzpYAWEiDTwHoT9p8vH4s5oPIB4f2k/6kzyeQIv3cw==
X-Received: by 2002:a05:6a20:1594:b0:1bd:2aa5:f177 with SMTP id adf61e73a8af0-1c0cc72bd10mr285893637.11.1720062113323;
        Wed, 03 Jul 2024 20:01:53 -0700 (PDT)
Received: from smtpclient.apple (vps-bd302c4a.vps.ovh.ca. [15.235.142.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a97c196sm295825a91.26.2024.07.03.20.01.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 20:01:53 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 3/3] scsi: sd: remove some redundant initialization code
From: Haoqian He <haoqian.he@smartx.com>
In-Reply-To: <cde0a2da-fae1-4f9f-b67f-f3906fc5cce6@kernel.org>
Date: Thu, 4 Jul 2024 11:01:38 +0800
Cc: Christoph Hellwig <hch@infradead.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Li Feng <fengli@smartx.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <344C3711-EE11-41F8-975A-EEA312CCD833@smartx.com>
References: <20240702030118.2198570-1-haoqian.he@smartx.com>
 <20240702030118.2198570-4-haoqian.he@smartx.com>
 <cde0a2da-fae1-4f9f-b67f-f3906fc5cce6@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
X-Mailer: Apple Mail (2.3731.500.231)


> 2024=E5=B9=B47=E6=9C=882=E6=97=A5 11:33=EF=BC=8CDamien Le Moal =
<dlemoal@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 7/2/24 12:01, Haoqian He wrote:
>> Since the memory allocated by kzalloc for sdkp has been
>> initialized to 0, the code that initializes some sdkp
>> fields to 0 is no longer needed.
>>=20
>> Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>> Signed-off-by: Li Feng <fengli@smartx.com>
>=20
> Looks OK to me.
>=20
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>=20
> --=20
> Damien Le Moal
> Western Digital Research
>=20

Hi Martin,

According to the SBC-3 SPEC:
"The device server in a logical unit that supports logical block =
provisioning
management shall set the LBPME bit to one in the parameter data returned =
for
a READ CAPACITY (16) command."

So we can use lbpme bit instead of lbpvpd to indicate if the device is =
thin
provisioned, which was implemented in patch 2 ("scsi: sd: remove =
scsi_disk
field lbpvpd").

Thanks,
Haoqian=

